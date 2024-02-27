Return-Path: <stable+bounces-24690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 559ED8695D6
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B771C2358E
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D445E1420C9;
	Tue, 27 Feb 2024 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bpB3zohb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884AC1420B0;
	Tue, 27 Feb 2024 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042721; cv=none; b=dHTvyu4oxQxftjWlGlQhKfoqvJkXUlAqwZarF0db6hlecxnF8joUfp/VZO88id77kfKniQiEaaRVzhEC8uXnVp94k0s4we5pmnaWOb3zdST4tu7curyeMZf6nq5XDBPJ1RmwYkiQdb7w57yggpJEXIMsQEBvWXqrceAGAGj/DG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042721; c=relaxed/simple;
	bh=QmCyReZdU4Ddr/j2U0i7TRKgJBI583auz1Hz5WkrbOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdPpkfTax5MJaqKhr0hbCXeRNDOf3I6cqdgpqThDd6Prmq+y6xJbfLq5S3MG+lut2iPzq6NSSm/Zsl9HG0LijlW0419NkgUU2UuLSriFQIEfDF4oW/IqGq7A43eSYBnk0qgdtBVhpCcBfXSLKTcZUu471ugDN5H058tzfM0MYjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bpB3zohb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9582C433C7;
	Tue, 27 Feb 2024 14:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709042721;
	bh=QmCyReZdU4Ddr/j2U0i7TRKgJBI583auz1Hz5WkrbOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bpB3zohbsoOshFw0RKncswCwIPwD/hcSJwNGgaTUGoha5ECiXIpSs6riom6jba8r7
	 bQhJ47prwSo6IMXSBxOLqtLB9RT4aALTwe7JmIVvR8zOcWeNmht6hH5bZLbDAJpdej
	 ZwXkPueorMBjA3ESI0bXj9rBmz2EBzmA/k6o93O0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 058/245] fs/ntfs3: Disable ATTR_LIST_ENTRY size check
Date: Tue, 27 Feb 2024 14:24:06 +0100
Message-ID: <20240227131617.118844782@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131615.098467438@linuxfoundation.org>
References: <20240227131615.098467438@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 4cdfb6e7bc9c80142d33bf1d4653a73fa678ba56 ]

The use of sizeof(struct ATTR_LIST_ENTRY) has been replaced with le_size(0)
due to alignment peculiarities on different platforms.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312071005.g6YrbaIe-lkp@intel.com/
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/attrlist.c | 8 ++++----
 fs/ntfs3/ntfs.h     | 2 --
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
index 0c6a68e71e7d4..723e49ec83ce7 100644
--- a/fs/ntfs3/attrlist.c
+++ b/fs/ntfs3/attrlist.c
@@ -127,12 +127,13 @@ struct ATTR_LIST_ENTRY *al_enumerate(struct ntfs_inode *ni,
 {
 	size_t off;
 	u16 sz;
+	const unsigned le_min_size = le_size(0);
 
 	if (!le) {
 		le = ni->attr_list.le;
 	} else {
 		sz = le16_to_cpu(le->size);
-		if (sz < sizeof(struct ATTR_LIST_ENTRY)) {
+		if (sz < le_min_size) {
 			/* Impossible 'cause we should not return such le. */
 			return NULL;
 		}
@@ -141,7 +142,7 @@ struct ATTR_LIST_ENTRY *al_enumerate(struct ntfs_inode *ni,
 
 	/* Check boundary. */
 	off = PtrOffset(ni->attr_list.le, le);
-	if (off + sizeof(struct ATTR_LIST_ENTRY) > ni->attr_list.size) {
+	if (off + le_min_size > ni->attr_list.size) {
 		/* The regular end of list. */
 		return NULL;
 	}
@@ -149,8 +150,7 @@ struct ATTR_LIST_ENTRY *al_enumerate(struct ntfs_inode *ni,
 	sz = le16_to_cpu(le->size);
 
 	/* Check le for errors. */
-	if (sz < sizeof(struct ATTR_LIST_ENTRY) ||
-	    off + sz > ni->attr_list.size ||
+	if (sz < le_min_size || off + sz > ni->attr_list.size ||
 	    sz < le->name_off + le->name_len * sizeof(short)) {
 		return NULL;
 	}
diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 8b580515b1d6e..ba26a465b3091 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -521,8 +521,6 @@ struct ATTR_LIST_ENTRY {
 
 }; // sizeof(0x20)
 
-static_assert(sizeof(struct ATTR_LIST_ENTRY) == 0x20);
-
 static inline u32 le_size(u8 name_len)
 {
 	return ALIGN(offsetof(struct ATTR_LIST_ENTRY, name) +
-- 
2.43.0




