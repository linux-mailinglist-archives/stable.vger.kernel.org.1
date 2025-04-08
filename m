Return-Path: <stable+bounces-131713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378B8A80BD1
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF86E4E6CDD
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DE226FA41;
	Tue,  8 Apr 2025 12:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1/PTO+xF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B66D27CCE2;
	Tue,  8 Apr 2025 12:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744117136; cv=none; b=H21SDon0T2J3c0uLNSziUhClieA3tg/RzaNj9gGEoOG8SCYA7AN2acA9+B6SGu9k0a5cFhue9DBsHfHkdieN2ga+Guj4gQvmZifpnT7iivD5+r+0CDLKHj0phiamOGGloOXY6iBiGpiOCpM8o/v4a0yeKaK7LemGAErgJlN88Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744117136; c=relaxed/simple;
	bh=oPzPkOyCV0DjuL0YxsOVRu4ReBsGhbVGj+BUgHwJT4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNq35Qg3BagyzxpnnadC8sktOHNWl5vVwxtR6TJ1LUR5uyIDRvj0XMd71ObjuTF4mGyf9blEoQCsI1+FLIVbetUQy5dI8DzMFB7lMvkLL3U62S0C4IyrR3Sulzg1Kpwayx/DWO3cMWQDhflYfC39EWv5wv9hk37tS+keGxVTscY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1/PTO+xF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E56DC4CEE5;
	Tue,  8 Apr 2025 12:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744117136;
	bh=oPzPkOyCV0DjuL0YxsOVRu4ReBsGhbVGj+BUgHwJT4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1/PTO+xFKM8TP6PcpvluPxEX51tho/nfohNGtSZRaNwT69ZIYC4aZ4tvw8gyb6cRJ
	 1NvEbRy4x1onm3fdHAlGCiT72Mw8+E9fkg6mHQ87eXMzawFCUeaXOnGERfNYcWOm3Z
	 CSBBIylZ+sNEjmAg9Q/3WpDqCnYHlw7kcc2TVYQk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Norbert Szetei <norbert@doyensec.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.12 398/423] ksmbd: fix overflow in dacloffset bounds check
Date: Tue,  8 Apr 2025 12:52:04 +0200
Message-ID: <20250408104855.172246529@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Norbert Szetei <norbert@doyensec.com>

commit beff0bc9d69bc8e733f9bca28e2d3df5b3e10e42 upstream.

The dacloffset field was originally typed as int and used in an
unchecked addition, which could overflow and bypass the existing
bounds check in both smb_check_perm_dacl() and smb_inherit_dacl().

This could result in out-of-bounds memory access and a kernel crash
when dereferencing the DACL pointer.

This patch converts dacloffset to unsigned int and uses
check_add_overflow() to validate access to the DACL.

Cc: stable@vger.kernel.org
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smbacl.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1026,7 +1026,9 @@ int smb_inherit_dacl(struct ksmbd_conn *
 	struct dentry *parent = path->dentry->d_parent;
 	struct mnt_idmap *idmap = mnt_idmap(path->mnt);
 	int inherited_flags = 0, flags = 0, i, nt_size = 0, pdacl_size;
-	int rc = 0, dacloffset, pntsd_type, pntsd_size, acl_len, aces_size;
+	int rc = 0, pntsd_type, pntsd_size, acl_len, aces_size;
+	unsigned int dacloffset;
+	size_t dacl_struct_end;
 	u16 num_aces, ace_cnt = 0;
 	char *aces_base;
 	bool is_dir = S_ISDIR(d_inode(path->dentry)->i_mode);
@@ -1035,8 +1037,11 @@ int smb_inherit_dacl(struct ksmbd_conn *
 					    parent, &parent_pntsd);
 	if (pntsd_size <= 0)
 		return -ENOENT;
+
 	dacloffset = le32_to_cpu(parent_pntsd->dacloffset);
-	if (!dacloffset || (dacloffset + sizeof(struct smb_acl) > pntsd_size)) {
+	if (!dacloffset ||
+	    check_add_overflow(dacloffset, sizeof(struct smb_acl), &dacl_struct_end) ||
+	    dacl_struct_end > (size_t)pntsd_size) {
 		rc = -EINVAL;
 		goto free_parent_pntsd;
 	}
@@ -1239,7 +1244,9 @@ int smb_check_perm_dacl(struct ksmbd_con
 	struct smb_ntsd *pntsd = NULL;
 	struct smb_acl *pdacl;
 	struct posix_acl *posix_acls;
-	int rc = 0, pntsd_size, acl_size, aces_size, pdacl_size, dacl_offset;
+	int rc = 0, pntsd_size, acl_size, aces_size, pdacl_size;
+	unsigned int dacl_offset;
+	size_t dacl_struct_end;
 	struct smb_sid sid;
 	int granted = le32_to_cpu(*pdaccess & ~FILE_MAXIMAL_ACCESS_LE);
 	struct smb_ace *ace;
@@ -1258,7 +1265,8 @@ int smb_check_perm_dacl(struct ksmbd_con
 
 	dacl_offset = le32_to_cpu(pntsd->dacloffset);
 	if (!dacl_offset ||
-	    (dacl_offset + sizeof(struct smb_acl) > pntsd_size))
+	    check_add_overflow(dacl_offset, sizeof(struct smb_acl), &dacl_struct_end) ||
+	    dacl_struct_end > (size_t)pntsd_size)
 		goto err_out;
 
 	pdacl = (struct smb_acl *)((char *)pntsd + le32_to_cpu(pntsd->dacloffset));



