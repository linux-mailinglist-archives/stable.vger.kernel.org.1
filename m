Return-Path: <stable+bounces-100192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3679E98F7
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 15:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9AF1672CC
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5132A1B0426;
	Mon,  9 Dec 2024 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flMecMpB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1234E23313D
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754907; cv=none; b=czSE1LVqTOxHt4I8n9Ly7MnUBoTwRLAvQ1UU2y56Jwju7Iq/XtNOAHvGTvA4ZSG9NsmhSF+8GpSP5qz1uYm1z1XaSCM0Wz2L952NjxS5yJF3NGEAVqSEYnsmQESJ3M96ATWZaAJpKIFJvURPjwjAU4tgFvOMJqRVHaM93+vDP3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754907; c=relaxed/simple;
	bh=H2AqVqHXbQg0TxI+zf2MVuW0IpEL/UfE63KO3kN53WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N9mJdQIRUknMSajLVH22XC+tRtu9pIJb5DLjqm/cYbZyjiTwSNlJ1WDJ2eDwgSQ48pgXiEP73ZGaFA1vMouFIBsjgXOX9YneS+J0N+X/g4UsBCNnxykmEI/4tnu7LZwhHZQHle1xqCCRciOsEiDgmTMuCjCpMRoVCrmSzieFPvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flMecMpB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4F3C4CEDD;
	Mon,  9 Dec 2024 14:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733754906;
	bh=H2AqVqHXbQg0TxI+zf2MVuW0IpEL/UfE63KO3kN53WI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=flMecMpBdFp7DeN4RLumHvGLKDYccLgZnls8bUMSiUXL/EutZ8e2WheH446eJNpFk
	 jPNfxZNuR161p5rhgltt5MNggDUMk/PkU2YPMmpiLiwyivcHnJG07+/c9/YeGiOhoM
	 eHyUvKHazcS7OrE01WARZ6ky6LJHkZOYMNDUGu41JZifjiDcREsKtV9VjupgA5gTyi
	 T7rtr0AX9aVOoeFrwvVm+o3RMRu1S0NpoHSU90cn+CW2vtQ6jhOgFz0S/sAviNmSTg
	 IimUdNoZ70jQdejt8Aawj3FdkZ5g6c08ed5SnOAemgr0bCdBSztHtgY3Iy5FPTGuRh
	 juUO6Oh7wa6EA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] fs/ntfs3: Fixed overflow check in mi_enum_attr()
Date: Mon,  9 Dec 2024 09:35:04 -0500
Message-ID: <20241209081750-0d5e8a9d122a3494@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241209065223.3427374-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 652cfeb43d6b9aba5c7c4902bed7a7340df131fb

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 8c77398c7261)
6.1.y | Present (different SHA1: be684526fad4)

Note: The patch differs from the upstream commit:
---
1:  652cfeb43d6b9 ! 1:  77aacf84111d3 fs/ntfs3: Fixed overflow check in mi_enum_attr()
    @@ Metadata
      ## Commit message ##
         fs/ntfs3: Fixed overflow check in mi_enum_attr()
     
    +    [ Upstream commit 652cfeb43d6b9aba5c7c4902bed7a7340df131fb ]
    +
         Reported-by: Robert Morris <rtm@csail.mit.edu>
         Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    +    Signed-off-by: Sasha Levin <sashal@kernel.org>
    +    Signed-off-by: Jianqi.ren.cn@windriver.com <jianqi.ren.cn@windriver.com>
     
      ## fs/ntfs3/record.c ##
     @@ fs/ntfs3/record.c: struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
    @@ fs/ntfs3/record.c: struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTR
     +		if (le32_to_cpu(attr->res.data_size) > asize - t16)
      			return NULL;
      
    - 		t32 = sizeof(short) * attr->name_len;
    + 		if (attr->name_len &&
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

