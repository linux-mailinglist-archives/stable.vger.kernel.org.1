Return-Path: <stable+bounces-100673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7259ED1FC
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4B2B166789
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D61A1D619D;
	Wed, 11 Dec 2024 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5LF0ahR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18BE1A707A
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934799; cv=none; b=T4INgnDuZG8YLJ7ud5HqUyBkSQgYcLskWuXVr2aCgydv/lSbjsruZUti0CashCryZzRPU0bYMGZoOWOQMrvLRT5+Eoh+Vaf9fPxsbHhg6XCUf9JpZwGqO+yktW/FV48Od9jVaD+DgyBXVDHNipOJuiWRu50pDAUwe5sZzUcrI8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934799; c=relaxed/simple;
	bh=U7Shs3PWqTjejgTtv2gnA7FPFNrUTDp8XJ+b89UW9Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OH52Mv1JxcfPyu5rRVPQoe3QP9Oz9fVDqaL05lJwpaMnhpeiG9Nd89MzS2rVA1Fhglp9WI+MUr4oaJ6pT4+BWaWmL1EMlpvn/YK3v+ze21xxjpNx81/8hFuUnd25tJ2OlOtN3g8pWxz1FJiKfaJ13NkwdXiC4WqdbF/3kXu1oHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5LF0ahR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A44C4CEDD;
	Wed, 11 Dec 2024 16:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934798;
	bh=U7Shs3PWqTjejgTtv2gnA7FPFNrUTDp8XJ+b89UW9Tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H5LF0ahRNEwCn3ZHKRahKtErE47yPQ7BaO1T2OIzec29Wede/UL3mafMGy10G9fB4
	 I1tbweUxDoPvKGWiJT0XEcKtU9qbwUgfXwMXjV2ykex5paPRTQ82PhPy/BPh1/Rlpk
	 uRACuk31rrP2ewn8RchGordXFemwllOuskFlpn32pliLRj4qRaJVqYtpam5ioYXm1j
	 PGGlZnWxEdRFbGi5B2IrRBO7TM3nZ7ehCZL9ffna3C5dkmifioyf8RhcPJhV0jhT5w
	 MTqc1+3ZRwmLRgj803j3kxUMwVrLmacRmxMY5gaqJsPprxA7XBtZNeuNsYkFXO8iX1
	 YPRO5D6YayThw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: libo.chen.cn@eng.windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] ima: Fix use-after-free on a dentry's dname.name
Date: Wed, 11 Dec 2024 11:33:16 -0500
Message-ID: <20241211090713-f7e0ff5d39288dbb@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211082824.228766-1-libo.chen.cn@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: be84f32bb2c981ca670922e047cdde1488b233de

WARNING: Author mismatch between patch and upstream commit:
Backport author: libo.chen.cn@eng.windriver.com
Commit author: Stefan Berger <stefanb@linux.ibm.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: dd431c3ac1fc)
6.1.y | Present (different SHA1: 7fb374981e31)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  be84f32bb2c98 ! 1:  fd4816135a9e5 ima: Fix use-after-free on a dentry's dname.name
    @@ Metadata
      ## Commit message ##
         ima: Fix use-after-free on a dentry's dname.name
     
    +    [ Upstream commit be84f32bb2c981ca670922e047cdde1488b233de ]
    +
         ->d_name.name can change on rename and the earlier value can be freed;
         there are conditions sufficient to stabilize it (->d_lock on dentry,
         ->d_lock on its parent, ->i_rwsem exclusive on the parent's inode,
    @@ Commit message
         Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
         Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
         Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
    +    Signed-off-by: Sasha Levin <sashal@kernel.org>
    +    Signed-off-by: Libo Chen <libo.chen.cn@windriver.com>
     
      ## security/integrity/ima/ima_api.c ##
    -@@ security/integrity/ima/ima_api.c: int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
    +@@ security/integrity/ima/ima_api.c: int ima_collect_measurement(struct integrity_iint_cache *iint,
      	const char *audit_cause = "failed";
      	struct inode *inode = file_inode(file);
      	struct inode *real_inode = d_real_inode(file_dentry(file));
     -	const char *filename = file->f_path.dentry->d_name.name;
    - 	struct ima_max_digest_data hash;
     +	struct name_snapshot filename;
    - 	struct kstat stat;
      	int result = 0;
      	int length;
    -@@ security/integrity/ima/ima_api.c: int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
    + 	void *tmpbuf;
    +@@ security/integrity/ima/ima_api.c: int ima_collect_measurement(struct integrity_iint_cache *iint,
      		if (file->f_flags & O_DIRECT)
      			audit_cause = "failed(directio)";
      
    @@ security/integrity/ima/ima_api.c: int ima_collect_measurement(struct ima_iint_ca
      	}
      	return result;
      }
    -@@ security/integrity/ima/ima_api.c: void ima_audit_measurement(struct ima_iint_cache *iint,
    +@@ security/integrity/ima/ima_api.c: void ima_audit_measurement(struct integrity_iint_cache *iint,
       */
      const char *ima_d_path(const struct path *path, char **pathbuf, char *namebuf)
      {
    @@ security/integrity/ima/ima_api.c: const char *ima_d_path(const struct path *path
      	}
      
      	if (!pathname) {
    --		strscpy(namebuf, path->dentry->d_name.name, NAME_MAX);
    +-		strlcpy(namebuf, path->dentry->d_name.name, NAME_MAX);
     +		take_dentry_name_snapshot(&filename, path->dentry);
     +		strscpy(namebuf, filename.name.name, NAME_MAX);
     +		release_dentry_name_snapshot(&filename);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

