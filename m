Return-Path: <stable+bounces-110436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 873CBA1C3AF
	for <lists+stable@lfdr.de>; Sat, 25 Jan 2025 15:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF7847A396B
	for <lists+stable@lfdr.de>; Sat, 25 Jan 2025 14:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F193208A7;
	Sat, 25 Jan 2025 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgV0qVkr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFC125A65C
	for <stable@vger.kernel.org>; Sat, 25 Jan 2025 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737813833; cv=none; b=REWUt8maNQYUZczAllL9+fwlE/qJkDie6+Ea5QIz/lye0uE5ma/aZeKQTzJktVLzGajeplPBbd1oO7tGVYEGL93/m/Ju1WXTpl/VOOQvMddRl+QeS8sx3+hU/WdpwmjghBKCl3jwiFEtT6FmvvsrQSBjH4qWMQRi5YFkrh5wMv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737813833; c=relaxed/simple;
	bh=vJY0beyXtO81e3BzhXLcqDqpBksOcVuuFglE6MVN/wA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lodbUvE+Fa1fmFBRf0iywcPryzzCfd055XaZ6smt1i7DoQ6yyVzW9p/aKnL6DbVSAJX/5XCS6yJvHmALRgir8uABFbsVcEvJhMwUY97XCdQbN6CpwNPc4UT2ne0yFLdnPl4eWFB4RPbZCoI1sYC/R+Xn45AcL0asLg9Vgi7UR1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgV0qVkr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2BAC4CED6;
	Sat, 25 Jan 2025 14:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737813832;
	bh=vJY0beyXtO81e3BzhXLcqDqpBksOcVuuFglE6MVN/wA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VgV0qVkrxBGTgQTIfngLl6QTm5bEA2lNzlR8bVm2KMS//SaOgjUYK0AhsKRjq5+H2
	 XI9e23NJFeVikjgjmGMjZebTIBikFrwY0tT5VUiCQ4kDHZnw9LcmuBNrZGC5B+Ef/v
	 4z/OCJDjeIU1y855w8M/zWk7L8T+zPQ0ufHOOE4/NiMPAHbK4ossylJeA4pzinpJW3
	 psUYvJX8KTXGRhu04621kfDQCZXfpCaIoMk659QOpGUfVTYbu+apYAzQcOOD194py4
	 pISv29YX4F5/DfeYjbAynl80/3rXXUM2SWUAwnktUVKietxSM1h83GOzcymoTwE7JZ
	 mbXWO6PR5f0dQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Suraj Jitindar Singh <surajjs@amazon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] fs/ntfs3: Additional check in ntfs_file_release
Date: Sat, 25 Jan 2025 09:03:50 -0500
Message-Id: <20250124202058-b547eaa9b552b92d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250125000112.22389-1-surajjs@amazon.com>
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

The upstream commit SHA1 provided is correct: 031d6f608290c847ba6378322d0986d08d1a645a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Suraj Jitindar Singh<surajjs@amazon.com>
Commit author: Konstantin Komarov<almaz.alexandrovich@paragon-software.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 550ef40fa636)
6.1.y | Present (different SHA1: d1ac7e262030)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  031d6f608290c ! 1:  4e423d945bbe7 fs/ntfs3: Additional check in ntfs_file_release
    @@ Metadata
      ## Commit message ##
         fs/ntfs3: Additional check in ntfs_file_release
     
    +    commit 031d6f608290c847ba6378322d0986d08d1a645a upstream.
    +
         Reported-by: syzbot+8c652f14a0fde76ff11d@syzkaller.appspotmail.com
         Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
    +    Signed-off-by: Sasha Levin <sashal@kernel.org>
    +    Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
     
      ## fs/ntfs3/file.c ##
     @@ fs/ntfs3/file.c: static int ntfs_file_release(struct inode *inode, struct file *file)
    + 	int err = 0;
    + 
      	/* If we are last writer on the inode, drop the block reservation. */
    - 	if (sbi->options->prealloc &&
    - 	    ((file->f_mode & FMODE_WRITE) &&
    --	     atomic_read(&inode->i_writecount) == 1)) {
    +-	if (sbi->options->prealloc && ((file->f_mode & FMODE_WRITE) &&
    +-				      atomic_read(&inode->i_writecount) == 1)) {
    ++	if (sbi->options->prealloc &&
    ++	    ((file->f_mode & FMODE_WRITE) &&
     +	     atomic_read(&inode->i_writecount) == 1)
     +	   /*
     +	    * The only file when inode->i_fop = &ntfs_file_operations and
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

