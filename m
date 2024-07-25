Return-Path: <stable+bounces-61562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CD193C4EE
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 16:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D243282B2C
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471F2F519;
	Thu, 25 Jul 2024 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iU7AL2EP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043B919D884;
	Thu, 25 Jul 2024 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918715; cv=none; b=skqdF05P1o1IJ9zijeZ3LSjq7vM2X0z2DvbeqE4n+uKMO3APXBC8SzRXdRmr7ymTrk6gW+IsWkrbDpqT7n8ax/PhKhd74rEki/CpZnHVYqYLw7FQL8utcMkLOKqtaUd8BUJVrf7cF2D4D0c8ppM9cygUCEU7K/Hm3XVEzzH0llE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918715; c=relaxed/simple;
	bh=Ls8Ery/mS8y40FU0RCLdkS+4eE3EBf+RZnVAwuieDe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9y1BvKI0Ch/Tyq9mk1kXUiuvOpuPlSDX4k6PG/Gapc91O9YSCDfyWjf2ylxtZdF6lun7BSImZRvV57uSyVEEJYeYheCvTNrCIgjbWseZO+o4UHEnBGB2Dkqp6yNMyUMt/31f564PX1RgE4tnnZEqLmV4T58sphEMTaMjuC5M0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iU7AL2EP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB02C116B1;
	Thu, 25 Jul 2024 14:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721918714;
	bh=Ls8Ery/mS8y40FU0RCLdkS+4eE3EBf+RZnVAwuieDe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iU7AL2EP2db4sLGRkAML3AQTFJAqOx0RdDzFSzzoLIRlSZe2ggO1/He9zJ4jG165/
	 kzpVnIan9TdSU9ZqEmhXnCpp1ibeWCoduIt//kOWOyqHjDjXoby1rCcVULyHIVEcPp
	 j/0onheIqwTvypidqWqqmDUuVCHpzF+MJVQkTdIQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	lei lu <llfamsec@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 6.6 04/16] fs/ntfs3: Add a check for attr_names and oatbl
Date: Thu, 25 Jul 2024 16:37:17 +0200
Message-ID: <20240725142729.072539182@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725142728.905379352@linuxfoundation.org>
References: <20240725142728.905379352@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

commit 702d4930eb06dcfda85a2fa67e8a1a27bfa2a845 upstream.

Added out-of-bound checking for *ane (ATTR_NAME_ENTRY).

Reported-by: lei lu <llfamsec@gmail.com>
Fixes: 865e7a7700d93 ("fs/ntfs3: Reduce stack usage")
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ntfs3/fslog.c |   38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -3722,6 +3722,8 @@ int log_replay(struct ntfs_inode *ni, bo
 
 	u64 rec_lsn, checkpt_lsn = 0, rlsn = 0;
 	struct ATTR_NAME_ENTRY *attr_names = NULL;
+	u32 attr_names_bytes = 0;
+	u32 oatbl_bytes = 0;
 	struct RESTART_TABLE *dptbl = NULL;
 	struct RESTART_TABLE *trtbl = NULL;
 	const struct RESTART_TABLE *rt;
@@ -3736,6 +3738,7 @@ int log_replay(struct ntfs_inode *ni, bo
 	struct NTFS_RESTART *rst = NULL;
 	struct lcb *lcb = NULL;
 	struct OPEN_ATTR_ENRTY *oe;
+	struct ATTR_NAME_ENTRY *ane;
 	struct TRANSACTION_ENTRY *tr;
 	struct DIR_PAGE_ENTRY *dp;
 	u32 i, bytes_per_attr_entry;
@@ -4314,17 +4317,40 @@ check_attr_table:
 	lcb = NULL;
 
 check_attribute_names2:
-	if (rst->attr_names_len && oatbl) {
-		struct ATTR_NAME_ENTRY *ane = attr_names;
-		while (ane->off) {
+	if (attr_names && oatbl) {
+		off = 0;
+		for (;;) {
+			/* Check we can use attribute name entry 'ane'. */
+			static_assert(sizeof(*ane) == 4);
+			if (off + sizeof(*ane) > attr_names_bytes) {
+				/* just ignore the rest. */
+				break;
+			}
+
+			ane = Add2Ptr(attr_names, off);
+			t16 = le16_to_cpu(ane->off);
+			if (!t16) {
+				/* this is the only valid exit. */
+				break;
+			}
+
+			/* Check we can use open attribute entry 'oe'. */
+			if (t16 + sizeof(*oe) > oatbl_bytes) {
+				/* just ignore the rest. */
+				break;
+			}
+
 			/* TODO: Clear table on exit! */
-			oe = Add2Ptr(oatbl, le16_to_cpu(ane->off));
+			oe = Add2Ptr(oatbl, t16);
 			t16 = le16_to_cpu(ane->name_bytes);
+			off += t16 + sizeof(*ane);
+			if (off > attr_names_bytes) {
+				/* just ignore the rest. */
+				break;
+			}
 			oe->name_len = t16 / sizeof(short);
 			oe->ptr = ane->name;
 			oe->is_attr_name = 2;
-			ane = Add2Ptr(ane,
-				      sizeof(struct ATTR_NAME_ENTRY) + t16);
 		}
 	}
 



