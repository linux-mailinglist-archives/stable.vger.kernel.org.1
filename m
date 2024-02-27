Return-Path: <stable+bounces-24366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6820286941A
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4171C24B5E
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0256813B78A;
	Tue, 27 Feb 2024 13:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yQSvDpw6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F96013A885;
	Tue, 27 Feb 2024 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041796; cv=none; b=g9SLvudbxIDXjviYqmHjI7tS3luaUGHlu4tFy91aDOzPYDCPUbgaq84SdWMOwf4X+ZcvcnTbJGsUHC9dCRT9rAW+7FVu5lRXxc00upjInhjbixoXg6REdqhDJYoobiK2m8Bx82B/Q5HV4lgxtueK4p2IgmYW5qVhxRj7U4VUsT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041796; c=relaxed/simple;
	bh=JzHtKzLcMO8JsBS3fvQSlkJAFKPydNlMnBidpxoqrdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXSScdWozq12380p6GxoS/30p98YeKzK1RltO1jJbXchwa1x1hpmAr34yEM8a39+fm4ZY3OdNg/qdcoVkbWDnCQ43lw0eYqj9KXHjXn9O9BdOId7fwAMsqQ+KSrvJ4kfOLX7OLCjyY1QeZH6+nBHgtKbqUppFIO50C4BL+PV238=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yQSvDpw6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD1CC433C7;
	Tue, 27 Feb 2024 13:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709041796;
	bh=JzHtKzLcMO8JsBS3fvQSlkJAFKPydNlMnBidpxoqrdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yQSvDpw6/H+Tz7WYCkK9AJyaqy9t1YShvSZcXgizZehEQY76/W2Qtx+dmixecktbG
	 RysREsZJo9f8xgVu9fkJwsJcRIK6f6nmnW4yzlnmLco/KUbZW4obHrWScbRZbV/tXO
	 zZwjWfjS4MXEuEmpxjWI0e9iYb10dSKQfddm0CiY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 073/299] fs/ntfs3: Correct hard links updating when dealing with DOS names
Date: Tue, 27 Feb 2024 14:23:04 +0100
Message-ID: <20240227131628.290100693@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
References: <20240227131625.847743063@linuxfoundation.org>
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

[ Upstream commit 1918c10e137eae266b8eb0ab1cc14421dcb0e3e2 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/record.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 53629b1f65e99..7b6423584eaee 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -535,8 +535,20 @@ bool mi_remove_attr(struct ntfs_inode *ni, struct mft_inode *mi,
 		return false;
 
 	if (ni && is_attr_indexed(attr)) {
-		le16_add_cpu(&ni->mi.mrec->hard_links, -1);
-		ni->mi.dirty = true;
+		u16 links = le16_to_cpu(ni->mi.mrec->hard_links);
+		struct ATTR_FILE_NAME *fname =
+			attr->type != ATTR_NAME ?
+				NULL :
+				resident_data_ex(attr,
+						 SIZEOF_ATTRIBUTE_FILENAME);
+		if (fname && fname->type == FILE_NAME_DOS) {
+			/* Do not decrease links count deleting DOS name. */
+		} else if (!links) {
+			/* minor error. Not critical. */
+		} else {
+			ni->mi.mrec->hard_links = cpu_to_le16(links - 1);
+			ni->mi.dirty = true;
+		}
 	}
 
 	used -= asize;
-- 
2.43.0




