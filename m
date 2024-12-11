Return-Path: <stable+bounces-100647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C67A9ED1D8
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 743A91884952
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADF91A707A;
	Wed, 11 Dec 2024 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pv59zuEC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B90E38DE9
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934735; cv=none; b=HhibWX9cb1eP6POLMHm5RKs+XxBJ5k8/vYTVD4gPvawc4U1AtELmHOYrw1IEtRF73BOdG6gTcJKryp+ZFo8qm3rkUZW/BSBMhgQSDHAzSROL0FxypfcGfLeWGoyB1Yzlf4cQQWsE/scTB8tkgqc1itt61B6OfXrsLBLOKiSPyec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934735; c=relaxed/simple;
	bh=NRwgld+oe1+5byIBb4/2Tj3Dbw6f69WfDg3C924RWAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svmTF9/v33KM+UPjNuXwYvj3C1pwWX2ClrHfMSjU0uqUXry6+rRzkd/1CT50Ex0UGccIgfjG7RNHZ2j07V+JabZ5duTzgSoKgXHP5PEs6rRNkazGF3wDZwdecgcRww/e77TxHuAw+xXIqk/Ik/iVvHi25OkwHudsw9jDb+IsSUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pv59zuEC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAF8C4CED2;
	Wed, 11 Dec 2024 16:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934734;
	bh=NRwgld+oe1+5byIBb4/2Tj3Dbw6f69WfDg3C924RWAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pv59zuECFRz42aFM1B9onzUtmcpzWjileiFDoEKEJF3JCla5TufMbLfez4NP0T5Mt
	 ZHa4+kH9sfChq5ql7ZvM2jX5+4LuqWjV8hIRLvdXBGlrLTRXn996HOy5KjJW0kw5ie
	 HLq9ZjAcN3zPnTRJN/4P7iezzRfHZLvNE8JDtmHS0vmeaaEIlarMHuGt0qv8Wr5MAT
	 xkHyp0+pI2bh3lTxCIb80jNghV+oqgOYjcffoL7lK8VDJBqotg6tPFDMWoH1m2TOAB
	 o0QAUhtd53r53CbnQdmHBjW00+EhIFePrCvEiVUD8MlxjVfFbtGCLy5wiiDEzSYx7J
	 GY3fChniJUT1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: guocai.he.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH][5.15.y] gfs2: Fix slab-use-after-free in gfs2_qd_dealloc
Date: Wed, 11 Dec 2024 11:32:12 -0500
Message-ID: <20241211092532-a65949c2ef78e550@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211075458.3346123-1-guocai.he.cn@windriver.com>
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

The claimed upstream commit SHA1 (7ad4e0a4f61c57c3ca291ee010a9d677d0199fba) was not found.
However, I found a matching commit: bdcb8aa434c6d36b5c215d02a9ef07551be25a37

WARNING: Author mismatch between patch and found commit:
Backport author: guocai.he.cn@windriver.com
Commit author: Juntong Deng <juntong.deng@outlook.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 08a28272faa7)
6.1.y | Present (different SHA1: 7ad4e0a4f61c)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  bdcb8aa434c6d < -:  ------------- gfs2: Fix slab-use-after-free in gfs2_qd_dealloc
-:  ------------- > 1:  984007af06c33 gfs2: Fix slab-use-after-free in gfs2_qd_dealloc
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

