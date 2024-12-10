Return-Path: <stable+bounces-100470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F5C9EBA11
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 20:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F54283A2C
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 19:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5746D22686F;
	Tue, 10 Dec 2024 19:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ue7Q/Li1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BDB214237
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858687; cv=none; b=uXzjEMQx3XZDoQDZF6VnoDINwY9+rlvUWwbDVvv0HVmA66rkYAcxXWkfqFAcbgiBQEr6P4UBrqF1gpeIeNnLiByQ6b3oL9OmLHuw61Qk9w2rPPrsmBXp3bXMNkWASWATx+bDleMXaxv80KkL2nvQ/C1FMapFMbE65mY398UwTww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858687; c=relaxed/simple;
	bh=AuSNNcFwvvsDw6eF2anOlZaYxm/rVDV5+n+CqxfiCcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bF1Mv2N8dE9ZhOVN2N4kwq/AGclxUDul4dtFR52hCcMnVVEK+ECvf8VHPU35W9E0j1e8/KqYakTqDV1Ee9TNAtjkGt+D3wiX1XH9R5paLkVIg591Ma28vWfdReiNj60LWCUkwsIr3kdyZtJQkxh5HjQ4gX03Jk5olR447lRNP7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ue7Q/Li1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A45C4CEDF;
	Tue, 10 Dec 2024 19:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733858686;
	bh=AuSNNcFwvvsDw6eF2anOlZaYxm/rVDV5+n+CqxfiCcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ue7Q/Li1Cg+LcYK36od+lzAuVlgK+vM3ghWZ3TPrqZ5so9v9VMMtGtjH7mtVVik3K
	 x5hR5kDUtgGBGNPkJWXZnO1Pr2WcTq1g4iGJm7isrxUNcVHraIbVZ6tJR31AV8o5w9
	 lU0c7/li+sGEMFxTAX7I0bnD/zMeY+p40Mu9Apx2ywYY2EtebaTTnEatelF9FypzYM
	 2pvpqQwGEH/n3+UumZsY0/mnkdv56T2qUWNLzZ1i7HSRfWjsoCej+TaZa5HFJLLsM0
	 6PuXJ13sbBFGxPrspA4nQJKAxaBMssglLN7ATnvcc3/o1lwiaO3zl4zbzFTCWmnXsR
	 USUitBNaaWo3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] i3c: master: cdns: Fix use after free vulnerability in cdns_i3c_master Driver Due to Race Condition
Date: Tue, 10 Dec 2024 14:24:44 -0500
Message-ID: <20241210094706-4c4338eab15295c7@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241210082047.3808378-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 609366e7a06d035990df78f1562291c3bf0d4a12

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Kaixin Wang <kxwang23@m.fudan.edu.cn>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: ea0256e393e0)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  609366e7a06d0 < -:  ------------- i3c: master: cdns: Fix use after free vulnerability in cdns_i3c_master Driver Due to Race Condition
-:  ------------- > 1:  4827cea76d760 i3c: master: cdns: Fix use after free vulnerability in cdns_i3c_master Driver Due to Race Condition
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

