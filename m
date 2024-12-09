Return-Path: <stable+bounces-100271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 971CE9EA2DA
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 00:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B99F16673A
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 23:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253B2223C78;
	Mon,  9 Dec 2024 23:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vM7usbnB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9094223C71
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 23:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733787138; cv=none; b=CIt7Cne/Aayp9siCa93zJspPhzYuWAe1PhW8B4cXGpEQCV9Udidd6o/YePa246Rk0vMBuNwQAOvHP8ebkWf1PTs6eck+tQG75Ywt0O9m9emjgzUxZQX07XTpYvjK4T/rnha4cvJcsWvT+Znl2gXyB45kY6VZOrSq9IOovZcXCS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733787138; c=relaxed/simple;
	bh=BqOkU8QY2B/dU+T8UdgZNLAKtmo/AKl2IaImVZpbwG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Go+uoH+M2cKbhFNoKQhJ8vdxQavTnPI4XNH7BMPjBPw8j+4e8by91OuysgCoeoR6IWnk5UYftKIGxk7pOQcIJgYUmUvAAfbnIZ1CZXis0vlZmbKScpA4dJNEUA8sZrCLbDQVGky3JUpC6fJWXLBmUrpmvbXf2EPjrcyAkkN7D8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vM7usbnB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D80C4CED1;
	Mon,  9 Dec 2024 23:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733787138;
	bh=BqOkU8QY2B/dU+T8UdgZNLAKtmo/AKl2IaImVZpbwG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vM7usbnBLx6/+IjofCoMa241FAey1ME7jiRR6rPBH/eI4213COCHtCrK2Q//oyYnh
	 GxGzs8SR9z9+Q2OJxI1xGx+qadEKPkOOEpVlMcoM72oDhtaB24Db2EoV4pCj5Jg4ll
	 6ppUYzUimY04Jfe4UjGi21sxelktc4jrUeq6eFd/bp3yaNLA6VKiawhkLrgGhr+dBQ
	 l1ZyH3CHdh0N4qcY1F4MPnjnuyF5NuMzizCvIRJloqNBEDs8RiPRC2uFdRVl7GDqry
	 pZYAzeDelgnHzKbJzCbff74LZlz1k+QbO1ZvjD84+sYW8ZkqxmqjItF6Xwz1bzP3Sb
	 X39ShrKKY/LOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?J=C3=B6rg=20Sommer?= <joerg@jo-so.de>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] net: dsa: microchip: correct KSZ8795 static MAC table access
Date: Mon,  9 Dec 2024 18:32:16 -0500
Message-ID: <20241209164248-914658d2e63e9ab1@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <b4a802ae7dfac66efa5175313228f0ba2fc769ef.1733771269.git.joerg@jo-so.de>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: 4bdf79d686b49ac49373b36466acfb93972c7d7c

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?J=C3=B6rg=20Sommer?= <joerg@jo-so.de>
Commit author: Tristram Ha <Tristram.Ha@microchip.com>


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
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

