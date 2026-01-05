Return-Path: <stable+bounces-204940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 003A7CF5A76
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 22:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CA5730D6936
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 21:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62132BE051;
	Mon,  5 Jan 2026 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8JtyCTI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102102DF126
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767647942; cv=none; b=AOD+nA1b2X/Ak6vn6gn1mh2U1T3xpeMnI4qD35lZcMdi2BiQcBBzBZuWHByov22i4Oynf2JrnZCCjl1XaNS9//7nie/NlnaQ+HH8wPURF845xZ0diiQZsN6XIuh7uSF9efGSXK6a2GpTFGsu8mcaQIYyR+iH0RZ0+7dfcbixRCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767647942; c=relaxed/simple;
	bh=7OhCL/hJxXrY3+WYN78M1I0TgI0OqSU05lY8vX8SPRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PnQe0XMld+l/wEsaZVbNKLm3zPbP3XWRzNXmmh9k5Ou3Gal3ReHz/eAW//GRRcVOWVSHtIithcqQ3m1LKf7AV7n4mL+7sm+Nptk33tpsnExnDDTV7gsx27mPBhBF6kFIVnUOauHEYig6ZC3/1o/wjv1t9c52RYmdafUWjcgP/bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8JtyCTI; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29f2676bb21so3703525ad.0
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 13:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767647940; x=1768252740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5LAxK+AjnG3YzNOBaLOPsRos3hCuelykUfVzgLenNc=;
        b=J8JtyCTINDIWTwhSKmmKNZ4eK/1f97ThwCfUon3NKnRSyZHRXOioNo/kpKZmyStQ8O
         jkLf/ZYS9OMCAXrkoKsA1Qb/z3vfTGl0iouaPmdKm5aOlT6Uo5PMbLbbcbNFaQ17MNq2
         v9KPSFyCTDU21ueOLXl9+sonUn/Mb7exTc4ar70A8OnoWdbAS+cCeRyqSQ9yxZHlMFWs
         ot3LoH6C4V4YPpCqSOrU30EU+P8+18UNKzOG3F1pnaAKA6+lDRqfc/XT5Zou7UDW75zr
         jX9ObMrZRjVcgXGPSqwTrqCBgo91G9JUquq7784mOhosi1KonjmlzYQh1Z/p3X3h7atg
         KDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767647940; x=1768252740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x5LAxK+AjnG3YzNOBaLOPsRos3hCuelykUfVzgLenNc=;
        b=Fb1ioaqNAkOT1PSVDXEK4N4gkymyVEu59WONGmpwpIkzlkRvsc9O6CNF15waT/DVwA
         q1rDVJ27v8PqIkn5fvQmBWE4yGGwkxWRgQN8PXLr8dTFYFGJwFbSKiwUPLHCPcXhmmSU
         XusUJY709+7JR/AKpaWWUW0U77EhRsnP0cckT7JbqRnPmKJAVE7xCxkt+XYNUnMK+8rY
         ulFdZXncJIayHHfrSRKShDcD42gwD7mQfvqegCHqo8EsKFoF9C5pAyGdopjIVrKw6woe
         JoWYfeOs1C202Hf/xij55t+py7f1q/IIX/b02MnsEDFIToIhJKlHYb697mKp8kw4iTy9
         H7mA==
X-Forwarded-Encrypted: i=1; AJvYcCXefULg7Q2rlWKvlujvpcoHik5rgxRVcHXkMLxyjVRbwraxDSkveaHO/JcdVllV6AZ++UB4HhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI13GilWwAqabypJHzNJ48309OsHmO+CIXp4Zi73dCTox9Sv+y
	wKe4YkSDpj8St2NR0cTVSHDUGvh8aNAbTUyxQ+Zges/yKHfhwESCr83q
X-Gm-Gg: AY/fxX7exNKBAm4U15v+vkOOXX4nbRA2A1JsL2vPL46P/JM5R2B/O/pM3VeyjL3XMO7
	gZeVjkvP9eG5bXd3m2zp8ha+DziNRn6uCEAn2KCEdn2/hwCPymwH7HIjl6T2YpxIB5jXo+4WJKb
	7KA0Gnq9087vu9dIGJggUO5+IYmrK/kwK5g2MrHWXWB/8djTwFp8C/lrEaMXv9VLTHdhTuhzQwM
	RNAD+cnc5QUx2NT+XJ/yYhsxgzIpWkynyOTcC/KW+1xyP+w1nWaw+RGsGz6MtDk7l3O93T18OZz
	B9kgJ5BsmajXLnVaZ+IXRJUNFgZoXyIbLGGXVQ58nSMzPm5bbICnC7gsBZug0CQ0Q30/iiIGzSy
	sUBuOaS6eTXH5K9voOcN5VzIm5Hzq1vhQqvWB++kha+Y+g4SAp3XxJEJfro2sUeO35QAnt51y5J
	JtSQhE8zkzUutIaP8x
X-Google-Smtp-Source: AGHT+IHHnbvfuO02O2T8eWP+vcVOcuSJ7Y6r/Zmdy3IOsvMBodteHhpEqVwKxEJiZnOh/YXs6iICfw==
X-Received: by 2002:a17:903:2f92:b0:2a0:d629:9035 with SMTP id d9443c01a7336-2a3e2d758c7mr8216695ad.3.1767647940296;
        Mon, 05 Jan 2026 13:19:00 -0800 (PST)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc8dd2sm1526925ad.82.2026.01.05.13.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 13:18:59 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com,
	miklos@szeredi.hu,
	linux-mm@kvack.org,
	athul.krishna.kr@protonmail.com,
	j.neuschaefer@gmx.net,
	carnil@debian.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v3 1/1] fs/writeback: skip AS_NO_DATA_INTEGRITY mappings in wait_sb_inodes()
Date: Mon,  5 Jan 2026 13:17:27 -0800
Message-ID: <20260105211737.4105620-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260105211737.4105620-1-joannelkoong@gmail.com>
References: <20260105211737.4105620-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Above the while() loop in wait_sb_inodes(), we document that we must
wait for all pages under writeback for data integrity. Consequently, if
a mapping, like fuse, traditionally does not have data integrity
semantics, there is no need to wait at all; we can simply skip these
inodes.

This restores fuse back to prior behavior where syncs are no-ops. This
fixes a user regression where if a system is running a faulty fuse
server that does not reply to issued write requests, this causes
wait_sb_inodes() to wait forever.

Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and internal rb tree")
Reported-by: Athul Krishna <athul.krishna.kr@protonmail.com>
Reported-by: J. Neuschäfer <j.neuschaefer@gmx.net>
Cc: stable@vger.kernel.org
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Bernd Schubert <bschubert@ddn.com>
Tested-by: J. Neuschäfer <j.neuschaefer@gmx.net>
---
 fs/fs-writeback.c       |  7 ++++++-
 fs/fuse/file.c          |  4 +++-
 include/linux/pagemap.h | 11 +++++++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 6800886c4d10..baa2f2141146 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2750,8 +2750,13 @@ static void wait_sb_inodes(struct super_block *sb)
 		 * The mapping can appear untagged while still on-list since we
 		 * do not have the mapping lock. Skip it here, wb completion
 		 * will remove it.
+		 *
+		 * If the mapping does not have data integrity semantics,
+		 * there's no need to wait for the writeout to complete, as the
+		 * mapping cannot guarantee that data is persistently stored.
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


