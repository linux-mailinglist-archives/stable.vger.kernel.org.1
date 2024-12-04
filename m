Return-Path: <stable+bounces-98331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FCD9E4371
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 19:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB2DBB30888
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 16:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989CB1B87C6;
	Wed,  4 Dec 2024 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxmZCxfO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585791F16B
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331218; cv=none; b=htjNOGz1wrQ/8U72aEiaUEA9ONBQEu0JwJsfYRQn9KnVK96pPiq12Rj/Rxl/X9qrnMAxOLhPmAQif3ZqoSeRsUeaquMdwALT0kbgLG1v5S4AqtFqn7SJ0p5JB15fOuPWKCaLVpstu/LAqs1RaKTM1S2ZErPpKjxahOAqFrnRndo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331218; c=relaxed/simple;
	bh=xWrufHI/5y35gERJlxW/y9jH5HTbaO77RgpGJC3R5uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HzUzC5/Eh/H08Sr2wH9HvmWwe8HTWx8C2ZG+TbF6uvXSeduLlWIMK//+m+MSdwCAOk4vnT7VA2iFEj7EUwqrfdIEBLMLabJOFu6jtS8XmMon8FTCckYfPVGCqMItYuwvS5EK2RbA+xtEm4r46HqAWNRDdEOcOpnZucUSNekLATc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxmZCxfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7EFC4CECD;
	Wed,  4 Dec 2024 16:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331218;
	bh=xWrufHI/5y35gERJlxW/y9jH5HTbaO77RgpGJC3R5uY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZxmZCxfOX9lRYO/XAfGpz9ff5L93DTv02n0QdWeRrgWt0JZuoy9Cdp/EyPIVrYw/u
	 SdnfpaeSlugdKN436O2NUasiEC9LjvkMiEZHUA2GT9CFL6yIcjHKo4JWfvNuPN7omh
	 fOmLH4EvUaNC8YQOrEc2KLPd6zlFhYO/+c4kpg7D5bISc0Ly8pARkXWX57wsTu0CLo
	 8oT0/1cWrCUBM63pZSaba2x6804pJUGpxBoddWk4zwecSusuO0cL13ICSjaqhkb3QJ
	 3j8ZndzJZFDe6BxSIE+V13hkWpTi/qAkGDoj6eqIuj9fvnDaovuekDD4OjIXSo2Wva
	 9YDgzr+acK8+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] riscv: Fix vector state restore in rt_sigreturn()
Date: Wed,  4 Dec 2024 10:42:06 -0500
Message-ID: <20241204071627-8caffcd5a052a5bd@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20240403072638.567446-1-bjorn@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: c27fa53b858b4ee6552a719aa599c250cf98a586

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Commit author: Björn Töpel <bjorn@rivosinc.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Failed     |  N/A       |
| stable/linux-6.11.y       |  Failed     |  N/A       |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |
| stable/linux-4.19.y       |  Failed     |  N/A       |

