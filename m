Return-Path: <stable+bounces-105152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D3E9F65F6
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 13:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71FE1882381
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 12:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E437C1A4B69;
	Wed, 18 Dec 2024 12:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g076wcal"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E251534EC
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 12:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734525250; cv=none; b=kriYSaXqatGPXy/dFrgX1XpRWgZsDrO4VxYw+TbaMn8okOPS87qsLMXKhM+qVStddr1WKS7a8a0FWjxYt5G+iQmNCpi7fwf9uG+w7Jm23j95E+SJZrKnfKOKkpgbQ5nixwNz25B5SbXq9JQpbl90TFPrFjklANiUV9LtJusN4cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734525250; c=relaxed/simple;
	bh=gXMNXyDfqM5cQ0b6BjfPFz/wVjASEJUhkROykcTRA1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fLLTwl0yBarxyV814npLm+gW4VbOaN07S3wid+BOw1nJQzxH7D1edaRxWp+ygKB7rIpWtjCPKQNgiwDOz1CWyzbywmsbCHTSfMnjJGI+duzWg2aZZsRTiSvp+oFYRdY8Tv1FGq/XyFNoFGEuk+Zguzn1pinSaWVYGdkUaQQyRPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g076wcal; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C434CC4CECE;
	Wed, 18 Dec 2024 12:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734525250;
	bh=gXMNXyDfqM5cQ0b6BjfPFz/wVjASEJUhkROykcTRA1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g076wcalBfgJVg3DRt0aUlJZhLPlXEm6T4CcspStEbfYfBkm75fdE1aFMSSgyVtRD
	 Ba/vHsY9UWp6ZXJPJMHN7MvSsP6+nub1upZQTo3imoFqoZZZQXm6hjj5NwVFe/fw9W
	 OH5v/ghZIhJ8D26I2U1V8wwJS8pqXDS4Z0KN7ZxYzUiKjjFGCPIIUO59UwlCuOvEbJ
	 v1tFLW5v0HoIbCSAqomcB4Mm2JS0BSeqXDcQHJoXLUtBLfZspU8/E5f/Ua3v0s8GZ5
	 2b4Tr6oQZ4T1NND/r34E9dLmYU4WaEP2AMFkuc1L/GWMuLjw5wkcD6iCFV6OU7Ssdu
	 JJb0r4SiszaJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] erofs: fix incorrect symlink detection in fast symlink
Date: Wed, 18 Dec 2024 07:34:08 -0500
Message-Id: <20241218070817-693dae50bd8a8a93@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241218073402.442917-1-hsiangkao@linux.alibaba.com>
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

The upstream commit SHA1 provided is correct: 9ed50b8231e37b1ae863f5dec8153b98d9f389b4


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 0c9b52bfee0e)
6.1.y | Present (different SHA1: ec134c1855c8)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  9ed50b8231e3 ! 1:  80df2f17dee8 erofs: fix incorrect symlink detection in fast symlink
    @@ Metadata
      ## Commit message ##
         erofs: fix incorrect symlink detection in fast symlink
     
    +    commit 9ed50b8231e37b1ae863f5dec8153b98d9f389b4 upstream.
    +
         Fast symlink can be used if the on-disk symlink data is stored
         in the same block as the on-disk inode, so we don’t need to trigger
         another I/O for symlink data.  However, currently fs correction could be
    @@ Commit message
         Link: https://lore.kernel.org/r/bb2dd430-7de0-47da-ae5b-82ab2dd4d945@app.fastmail.com
         Fixes: 431339ba9042 ("staging: erofs: add inode operations")
         [ Note that it's a runtime misbehavior instead of a security issue. ]
    -    Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
         Link: https://lore.kernel.org/r/20240909031911.1174718-1-hsiangkao@linux.alibaba.com
    +    Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
     
      ## fs/erofs/inode.c ##
    -@@ fs/erofs/inode.c: static int erofs_fill_symlink(struct inode *inode, void *kaddr,
    +@@ fs/erofs/inode.c: static int erofs_fill_symlink(struct inode *inode, void *data,
      			      unsigned int m_pofs)
      {
      	struct erofs_inode *vi = EROFS_I(inode);
    --	unsigned int bsz = i_blocksize(inode);
     +	loff_t off;
      	char *lnk;
      
     -	/* if it cannot be handled with fast symlink scheme */
     -	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
    --	    inode->i_size >= bsz || inode->i_size < 0) {
    +-	    inode->i_size >= PAGE_SIZE || inode->i_size < 0) {
     +	m_pofs += vi->xattr_isize;
     +	/* check if it cannot be handled with fast symlink scheme */
     +	if (vi->datalayout != EROFS_INODE_FLAT_INLINE || inode->i_size < 0 ||
    @@ fs/erofs/inode.c: static int erofs_fill_symlink(struct inode *inode, void *kaddr
      		inode->i_op = &erofs_symlink_iops;
      		return 0;
      	}
    -@@ fs/erofs/inode.c: static int erofs_fill_symlink(struct inode *inode, void *kaddr,
    +@@ fs/erofs/inode.c: static int erofs_fill_symlink(struct inode *inode, void *data,
      	if (!lnk)
      		return -ENOMEM;
      
     -	m_pofs += vi->xattr_isize;
    --	/* inline symlink data shouldn't cross block boundary */
    --	if (m_pofs + inode->i_size > bsz) {
    +-	/* inline symlink data shouldn't cross page boundary as well */
    +-	if (m_pofs + inode->i_size > PAGE_SIZE) {
     -		kfree(lnk);
     -		erofs_err(inode->i_sb,
     -			  "inline data cross block boundary @ nid %llu",
    @@ fs/erofs/inode.c: static int erofs_fill_symlink(struct inode *inode, void *kaddr
     -		DBG_BUGON(1);
     -		return -EFSCORRUPTED;
     -	}
    - 	memcpy(lnk, kaddr + m_pofs, inode->i_size);
    +-
    + 	memcpy(lnk, data + m_pofs, inode->i_size);
      	lnk[inode->i_size] = '\0';
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

