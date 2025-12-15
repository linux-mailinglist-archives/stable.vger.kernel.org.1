Return-Path: <stable+bounces-200998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C90CCBC4A3
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 04:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C44313011ECE
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 03:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0822797B5;
	Mon, 15 Dec 2025 03:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQbbKKOy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64AC317715
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 03:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765767919; cv=none; b=ccTY/xGgrUUcRe+e8gsGvyt2z6c0AOVZKD5M3MOF9pETIgYE2GWNfm70qXr7ROqH4FzVQCBu8aGZwIANC/Yv+0WnDG8kFRqVHNN2uT3h+8VQx4FZ3YhO2T0wDJ79SH+3DGkXVU9TQU6I2k9O42N51N3Vwep7DOlFdLUQ3p/JiA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765767919; c=relaxed/simple;
	bh=oN767t555H1kIiWjLDwGJZ6hCrsDHha3zysjC6xAxPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rbsN3XE15qB0AJXu8jdZ4vozHPs432FWLwH41dG/mGyCPmb8WY+dnVJxNf9S1B+7UwqmeWXQ8eFh2pAMQRzq6OVxaZa6BDXpylF2OcS6ceDhtI7/EUHvekqPMLnQBXzz4lWmPF5MGtEjEszH5sUiViXYSZolpmaxYCErej1nkms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQbbKKOy; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29f2676bb21so29044945ad.0
        for <stable@vger.kernel.org>; Sun, 14 Dec 2025 19:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765767917; x=1766372717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBRV01n6Z10+Z5Vfi/wD7Tb0wVdvo9mjj3mwV2A1JME=;
        b=cQbbKKOyjkNEJFJk1UK1+iHp2ve9EfhOTAFivLpqLRO4zMqLhtZF8VxaBkbaPlBQji
         luKU/Yf2nJMvx/7uj5npSis4vav8tPUMUFAlM+QHZbvO8BSD6goc2aIdaJaTDaK2zr7V
         d6+ngrYaNXIqyqKlpUE50vLXUMR9uvVvnB4RUmaeifBw0g8Of5c9FfIzgM8GA6x5ufmQ
         uK+4orquawlS7wl7FAPAP5aIiOd9hyeQl0pQ+ETDZDh3nxlcwrA6ptD9hdYzP0OH4Cdn
         hdEC57F1APQtKlZw9ite4cbSKHg2qu9HKbvgQGSq+pxsTA7ycgJTqV6zKJAtv/kMB0i/
         ZeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765767917; x=1766372717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LBRV01n6Z10+Z5Vfi/wD7Tb0wVdvo9mjj3mwV2A1JME=;
        b=XSGZ26lA+oe5PO01BPoEuhEBDZB2XnsCCtC27+piixXTQEZX1atlATT7RG8OXrnlGs
         Sx/BcIiml4z+fZMrPNo+KHBAj7ML/X4qqS1k9RhQCBr8ffk542jk31L1KCcK9TdVmuYF
         4U7G3P4RFjO4z7PaiCdtgQ/9lxDM0qACJHE5bnrs7LmTYU6XW+fDMeXyFmWDfoLZmcRT
         5zo6xFmQ3OlOo1tueGAyWytByLul2qMfpRBkI9X7QEKVGqmLDFr8wIbr19IojyVPM7GB
         59sJTuAgUet98l+iIlmIe7RDiMDN/gePqgJUPj+TtBwX8ALJeBpMmqc2QJRWoFSKJzNm
         0mQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw3JkqIdP4rJgHkGp0Adj1aVB+elQ74qo/ehOamoGb8rjZ9gGjCBgp4flL3brBb0KKCnsUJUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgBKKzckPI/99igcbAyJC5em5SSXy/ixq2JafjG4tPiecXTsGS
	0aonSaxAcPYoxZ1wSekx1ixDA3CT9Ojj0l5kT/GOvNrQ7jOqkv6zqSxD
X-Gm-Gg: AY/fxX5ftPAp7A+p0dy0GeEkUZgjsW2aoNOJHwmRghJQjqiUwzP8HquN7yPGAcWjM89
	IEYGjkDYf+pREtU2hmwYsevqUgSVAUARWGio142y44TcUWrHzi7pmsh4F/X3LmGeP/RHDn50yGx
	E7dPxbANo56jAWZbPIH3cj28msVW0TUZlfD56qfi+3Iwqu9wS/6kc5kKxZNJIghfgtoU9JrLN4E
	DgYpNUWqsjVzR7QEd4Rp1ANK3cS6Ut5ioXt9iPxAd1E6/HPoKEZSr9NwZnS3B4hItfxNtgVtYlr
	PrYYIcTOS70kKEqAmYMfihxrfddek3PanTa4RTiBDXQJj/rG3qzyPKAe78smakPGUSmG4GaeSX2
	RMzydSMD3Sfan05eZ4X1aDfqGottwGOyVS/jGj4TcSTY8HYTXDccT6Rf6K+y9VUnYAFzuOqhRR/
	YSks30S6Ojfad4a/e0og==
X-Google-Smtp-Source: AGHT+IEn+Y8AE3kEX5AkB/sFeGPR4t6lVQuTq+UDwlWj5SFZcATCZ4c86Jekd4k01WrcvjN481NL6w==
X-Received: by 2002:a05:6a20:3d8b:b0:364:13c3:3dd0 with SMTP id adf61e73a8af0-369ae58ce09mr8734759637.36.1765767916868;
        Sun, 14 Dec 2025 19:05:16 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2ad5663dsm11335787a12.17.2025.12.14.19.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 19:05:16 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com,
	miklos@szeredi.hu,
	linux-mm@kvack.org,
	athul.krishna.kr@protonmail.com,
	j.neuschaefer@gmx.net,
	carnil@debian.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/1] fs/writeback: skip AS_NO_DATA_INTEGRITY mappings in wait_sb_inodes()
Date: Sun, 14 Dec 2025 19:00:43 -0800
Message-ID: <20251215030043.1431306-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251215030043.1431306-1-joannelkoong@gmail.com>
References: <20251215030043.1431306-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Skip waiting on writeback for inodes that belong to mappings that do not
have data integrity guarantees (denoted by the AS_NO_DATA_INTEGRITY
mapping flag).

This restores fuse back to prior behavior where syncs are no-ops. This
is needed because otherwise, if a system is running a faulty fuse
server that does not reply to issued write requests, this will cause
wait_sb_inodes() to wait forever.

Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and internal rb tree")
Reported-by: Athul Krishna <athul.krishna.kr@protonmail.com>
Reported-by: J. Neuschäfer <j.neuschaefer@gmx.net>
Cc: stable@vger.kernel.org
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fs-writeback.c       |  3 ++-
 fs/fuse/file.c          |  4 +++-
 include/linux/pagemap.h | 11 +++++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 6800886c4d10..ab2e279ed3c2 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2751,7 +2751,8 @@ static void wait_sb_inodes(struct super_block *sb)
 		 * do not have the mapping lock. Skip it here, wb completion
 		 * will remove it.
 		 */
-		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
+		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK) ||
+		    mapping_no_data_integrity(mapping))
 			continue;
 
 		spin_unlock_irq(&sb->s_inode_wblist_lock);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 01bc894e9c2b..3b2a171e652f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3200,8 +3200,10 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
 
 	inode->i_fop = &fuse_file_operations;
 	inode->i_data.a_ops = &fuse_file_aops;
-	if (fc->writeback_cache)
+	if (fc->writeback_cache) {
 		mapping_set_writeback_may_deadlock_on_reclaim(&inode->i_data);
+		mapping_set_no_data_integrity(&inode->i_data);
+	}
 
 	INIT_LIST_HEAD(&fi->write_files);
 	INIT_LIST_HEAD(&fi->queued_writes);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 31a848485ad9..ec442af3f886 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -210,6 +210,7 @@ enum mapping_flags {
 	AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM = 9,
 	AS_KERNEL_FILE = 10,	/* mapping for a fake kernel file that shouldn't
 				   account usage to user cgroups */
+	AS_NO_DATA_INTEGRITY = 11, /* no data integrity guarantees */
 	/* Bits 16-25 are used for FOLIO_ORDER */
 	AS_FOLIO_ORDER_BITS = 5,
 	AS_FOLIO_ORDER_MIN = 16,
@@ -345,6 +346,16 @@ static inline bool mapping_writeback_may_deadlock_on_reclaim(const struct addres
 	return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
 }
 
+static inline void mapping_set_no_data_integrity(struct address_space *mapping)
+{
+	set_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
+}
+
+static inline bool mapping_no_data_integrity(const struct address_space *mapping)
+{
+	return test_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
+}
+
 static inline gfp_t mapping_gfp_mask(const struct address_space *mapping)
 {
 	return mapping->gfp_mask;
-- 
2.47.3


