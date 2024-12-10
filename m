Return-Path: <stable+bounces-100473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC51D9EBA12
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 20:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2152E18885BF
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 19:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE87C22578E;
	Tue, 10 Dec 2024 19:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hen8eVKr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C39823ED63
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 19:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858693; cv=none; b=sfQEk+qZWQl10+Fw5GOBOORAZBUGqYPbebuWn3/3V1c7Hrtc05L1/GtCd1+PbzktdBv8SL/ECZRSMNw9p/IJVuovFSQV/hPSksDPsoHpV3AUYx2gd10bUhtMqDzLANib64gcu9NCwotNfoJ/KOOygDyBa00wHvddm0OTkYIyxeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858693; c=relaxed/simple;
	bh=SOJDo4GYu/BwtbI08pwE08Qb4YAT6brXCsCIVCeL/gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8uuwJeO8MNpZdSMq5O9gB4kGEcY2DOYiHul3Jbx4+bMezH7ZXqpDzrTA+x0j7UMXh1QTBIiJWMg9K5SC0Xa7pxqWIyPjlVWbwjgUh1isuyRup5bZyDMD64sgcX3isjiLjSo1XwBstZa1a1+SSe2jos52ZO1a1y2B+kaAydzaAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hen8eVKr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5361C4CED6;
	Tue, 10 Dec 2024 19:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733858693;
	bh=SOJDo4GYu/BwtbI08pwE08Qb4YAT6brXCsCIVCeL/gE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hen8eVKrfs2Ks6RWWnjR6tq6z/qDGXFyxJGAezWWbN3C3hG+nMWyQBFERFY1rhz4k
	 b56Wn1KF/6WQsN9/6/TvQ7Y5qVVXEJ+0BjKnSNgUJnj7O3wWj8XsouVGDORT66mydU
	 nGEfWU1CnZcqZTQpgNReaVdLdlQSXSAdUKEH5zjez4mv+AMI2rkxinGgF8zZenF+dh
	 yKqcMnQLgrLMjcnB27mraIOn/E3eDziJDdFrO7T3IflLH6TwyajxGTifePrc9ieK6h
	 GeG0VuzdfEAEQLSQQ+MA+RWW0NHLOC8p45sPcXOWOqp/m/tmRoKULfQErUNSP8I23r
	 B+Cz9H/I14fqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: libo.chen.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] ima: Fix use-after-free on a dentry's dname.name
Date: Tue, 10 Dec 2024 14:24:51 -0500
Message-ID: <20241210083609-8c0ba0926772f3d1@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241210020252.3221904-1-libo.chen.cn@windriver.com>
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
Backport author: libo.chen.cn@windriver.com
Commit author: Stefan Berger <stefanb@linux.ibm.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: dd431c3ac1fc)
6.1.y | Present (different SHA1: 7fb374981e31)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  be84f32bb2c98 ! 1:  033c0527f3846 ima: Fix use-after-free on a dentry's dname.name
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

