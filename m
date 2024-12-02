Return-Path: <stable+bounces-96138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32299E092F
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 17:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C0D328226F
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4C51DACA1;
	Mon,  2 Dec 2024 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eed7jgAg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2BC1DAC95
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733158652; cv=none; b=nD0UtGM8wxmAZvGIV0UiYU3qx+CmzwFMw36m9ZHUUUVNW0kliUuaBT90RT9SpzDtS5ULgbgYeUwLKuop8GOEhcQGIhn67/03wmlTqFEAHFRw4e5OXq4CNMwLTV6ShDcP6stKVW/t81tLeMMMhrjZ9FoTfc8lpGhaT6/TXY8Whxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733158652; c=relaxed/simple;
	bh=9L1XHGwNfFo/RDZVsLVOGp2QONwPMnjqdVl0uPKlqII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DqQo4VLtLeX9ZHuX08+kospc78SGCs/21j69aBpVhi4BHLjpN1XCHb535sL6F+C047NtYf2OT8Nll1bwAJZRUwBqkRgGABaGtd5x95KcadFkvMyRNbxItzOBlmj02sxujiCU3SXBAI+gzxEuOowtZYRAZRjCXrwW5CDx8TTUH9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eed7jgAg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E1CC4CED1;
	Mon,  2 Dec 2024 16:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733158651;
	bh=9L1XHGwNfFo/RDZVsLVOGp2QONwPMnjqdVl0uPKlqII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Eed7jgAgHA9pA5NK07OTYohwUHBtktIo1w14osd93mVDZxdr4Ti2kXeBIoD1DCFC0
	 8ucjY1FFuaqSJn4ZyP1ibzJcWxY5E2r6Xl2LSA7JolgbyfvnrON1he4l/OSJGYkMjy
	 vJuDUpwJMtfXDzyB0rqhT/Ewrsivk79t7rdKAlgHjt56IPv8ng2RvSLdpS5RDTRPZy
	 Pv8thWoyzIbvUAHNuGvemZAvvbh7pn7DxaW3KxH3MxODTnObICdJHnA0gjv7NpEMV9
	 OH+NVdwvGFgw58KKn59RhhEyLzh8YQfIIe6MERKhBMWdKHqAKxJHpHQXc8HVFviuy3
	 wP+ZLQBOAWsrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 v2 2/3] net: fec: refactor PPS channel configuration
Date: Mon,  2 Dec 2024 11:57:29 -0500
Message-ID: <20241202104739-e9362086b350bb63@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202130733.3464870-3-csokas.bence@prolan.hu>
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

Found matching upstream commit: bf8ca67e21671e7a56e31da45360480b28f185f1

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Commit author: Francesco Dolcini <francesco.dolcini@toradex.com>


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  bf8ca67e21671 ! 1:  bbf739e5f67f0 net: fec: refactor PPS channel configuration
    @@ Commit message
         Reviewed-by: Csókás, Bence <csokas.bence@prolan.hu>
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
     
    +    (cherry picked from commit bf8ca67e21671e7a56e31da45360480b28f185f1)
    +
      ## drivers/net/ethernet/freescale/fec_ptp.c ##
     @@
      #define FEC_CC_MULT	(1 << 31)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

