Return-Path: <stable+bounces-93908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F059D1F5C
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 05:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D3D1F2281C
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 04:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1B1152E0C;
	Tue, 19 Nov 2024 04:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogEV82fe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3807148857
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 04:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731990998; cv=none; b=RoJAGLeE7JMguh/FVcRbT/HbiSfs8QUMjiW+lI0nVKI5alwIihDiTxHAidGhIC3N4uiHlXh++y0o8bowZQjqtLRjfVrVpo0MQJYe4iM9jBkFrsTui0j6PLDasd/VBaLsr8YVk3+rm8tNasZTOWa3zJ9SbD2fqorvDjURWPkc7A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731990998; c=relaxed/simple;
	bh=cBVsmzaYdqsz6YjkJvT0uCPW8tIDW8zcI1RD+93B63E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhdGio5U2EeeBgVnb+Zv5mUgK17spgOaYnXtV72cTFZQziwwl9YJr327LuvwhYu1wHb4RHa/ws102QU+1etyKw+A4wR7Kkv7hQ2unVdFA49SA2SLh1pkFCV36M1EceS0ZtBd70Ly65+j2oczExBDCK5K3yJwttrzQVzdut8CnV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogEV82fe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B403C4CED1;
	Tue, 19 Nov 2024 04:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731990997;
	bh=cBVsmzaYdqsz6YjkJvT0uCPW8tIDW8zcI1RD+93B63E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ogEV82fe0OvS/pS9BB2bI+TIEJNMkLyfRCt+AqqGWGtehxLLwlquWDi9dW45YFmat
	 BihVfVumHADr/Oo1d7qG3NaBbFIpxcqQt+SDtSX2tLlVQ4dkb+Gy1bUkXJ3358ak21
	 o/2gm5GO7SeKAE1RCviv69MB57tsZ6iEQdZbwUzgMEQh3M5y5bNpcVSbN8HsH2lPwt
	 JODLyCKmcVHuDhXG8VDE8NDBVTbMA3l201nK85CeHL36/QFYLfAIBiLCKw4dE+7UBD
	 OSv0pe4fvFpKDIoWnnYXj/HvG4jRypZCjMVHa1vguqhN0cb76AiA+4Ahgjvx+7GCPe
	 UpHKwf0iXhUFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vasiliy Kovalev <kovalev@altlinux.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 3/3] ext4: fix error message when rejecting the default hash
Date: Mon, 18 Nov 2024 23:36:35 -0500
Message-ID: <20241118102050.16077-4-kovalev@altlinux.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118102050.16077-4-kovalev@altlinux.org>
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

The upstream commit SHA1 provided is correct: a2187431c395cdfbf144e3536f25468c64fc7cfa

WARNING: Author mismatch between patch and upstream commit:
Backport author: Vasiliy Kovalev <kovalev@altlinux.org>
Commit author: Gabriel Krisman Bertazi <krisman@suse.de>

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Present (different SHA1: b5778b2b428a)      |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-18 22:36:26.886622930 -0500
+++ /tmp/tmp.pApf2ytKkR	2024-11-18 22:36:26.882290161 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit a2187431c395cdfbf144e3536f25468c64fc7cfa ]
+
 Commit 985b67cd8639 ("ext4: filesystems without casefold feature cannot
 be mounted with siphash") properly rejects volumes where
 s_def_hash_version is set to DX_HASH_SIPHASH, but the check and the
@@ -11,16 +13,17 @@
 Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
 Link: https://patch.msgid.link/87jzg1en6j.fsf_-_@mailhost.krisman.be
 Signed-off-by: Theodore Ts'o <tytso@mit.edu>
+Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
 ---
  fs/ext4/ext4.h  |  1 +
- fs/ext4/super.c | 27 +++++++++++++++++----------
- 2 files changed, 18 insertions(+), 10 deletions(-)
+ fs/ext4/super.c | 28 +++++++++++++++++-----------
+ 2 files changed, 18 insertions(+), 11 deletions(-)
 
 diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
-index 481ece3660eb7..7ac668d4ce83c 100644
+index 72abb8d6caf75..d5706aedf4fef 100644
 --- a/fs/ext4/ext4.h
 +++ b/fs/ext4/ext4.h
-@@ -2462,6 +2462,7 @@ static inline __le16 ext4_rec_len_to_disk(unsigned len, unsigned blocksize)
+@@ -2449,6 +2449,7 @@ static inline __le16 ext4_rec_len_to_disk(unsigned len, unsigned blocksize)
  #define DX_HASH_HALF_MD4_UNSIGNED	4
  #define DX_HASH_TEA_UNSIGNED		5
  #define DX_HASH_SIPHASH			6
@@ -29,13 +32,13 @@
  static inline u32 ext4_chksum(struct ext4_sb_info *sbi, u32 crc,
  			      const void *address, unsigned int length)
 diff --git a/fs/ext4/super.c b/fs/ext4/super.c
-index 58423e6bf3d07..adc5046fe9dd5 100644
+index 68070b1859803..3e4b9bf101454 100644
 --- a/fs/ext4/super.c
 +++ b/fs/ext4/super.c
-@@ -3583,13 +3583,6 @@ int ext4_feature_set_ok(struct super_block *sb, int readonly)
- 			 "mounted without CONFIG_UNICODE");
- 		return 0;
+@@ -3559,14 +3559,6 @@ int ext4_feature_set_ok(struct super_block *sb, int readonly)
  	}
+ #endif
+ 
 -	if (EXT4_SB(sb)->s_es->s_def_hash_version == DX_HASH_SIPHASH &&
 -	    !ext4_has_feature_casefold(sb)) {
 -		ext4_msg(sb, KERN_ERR,
@@ -43,10 +46,11 @@
 -			 "mounted with siphash");
 -		return 0;
 -	}
- 
+-
  	if (readonly)
  		return 1;
-@@ -5095,16 +5088,27 @@ static int ext4_load_super(struct super_block *sb, ext4_fsblk_t *lsb,
+ 
+@@ -5050,16 +5042,27 @@ static int ext4_load_super(struct super_block *sb, ext4_fsblk_t *lsb,
  	return ret;
  }
  
@@ -76,22 +80,25 @@
  	if (ext4_has_feature_dir_index(sb)) {
  		i = le32_to_cpu(es->s_flags);
  		if (i & EXT2_FLAGS_UNSIGNED_HASH)
-@@ -5122,6 +5126,7 @@ static void ext4_hash_info_init(struct super_block *sb)
+@@ -5077,6 +5080,7 @@ static void ext4_hash_info_init(struct super_block *sb)
  #endif
  		}
  	}
 +	return 0;
  }
  
- static int ext4_block_group_meta_init(struct super_block *sb, int silent)
-@@ -5257,7 +5262,9 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
- 	if (err)
- 		goto failed_mount;
+ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
+@@ -5234,7 +5238,9 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
+ 	sbi->s_addr_per_block_bits = ilog2(EXT4_ADDR_PER_BLOCK(sb));
+ 	sbi->s_desc_per_block_bits = ilog2(EXT4_DESC_PER_BLOCK(sb));
  
 -	ext4_hash_info_init(sb);
 +	err = ext4_hash_info_init(sb);
 +	if (err)
 +		goto failed_mount;
  
- 	err = ext4_handle_clustersize(sb);
- 	if (err)
+ 	if (ext4_handle_clustersize(sb))
+ 		goto failed_mount;
+-- 
+2.33.8
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.11.y       |  Failed (branch not found)  |  N/A       |
| stable/linux-6.6.y        |  Failed (branch not found)  |  N/A       |
| stable/linux-6.1.y        |  Failed (branch not found)  |  N/A       |
| stable/linux-5.15.y       |  Failed (branch not found)  |  N/A       |
| stable/linux-5.10.y       |  Failed (branch not found)  |  N/A       |
| stable/linux-5.4.y        |  Failed (branch not found)  |  N/A       |
| stable/linux-4.19.y       |  Failed (branch not found)  |  N/A       |

