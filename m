Return-Path: <stable+bounces-151902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E11CAD1235
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 14:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9324116A41C
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 12:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B2A213E77;
	Sun,  8 Jun 2025 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulUaW48U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE3521323C;
	Sun,  8 Jun 2025 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749387311; cv=none; b=Ijh0UbIUYftpxLi+kABLZouX8NZr8d7JUcQGhXgzKYRZIw07PqZVVVNqmLJOWlvXjvcPxwYBZEpU1EPa0dCyzxUhqnSijEtEGAYZogaueedmbr/eE/7aoLYSgSLgDg+XlDJVgZYXYz9vQIUCjQFh2flarP4jHHjPswSPLJssZzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749387311; c=relaxed/simple;
	bh=r5lcvMeIFl0weuoVyoHeVTqHoqUe0pfnScw2crbJDb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edxdmEOqN9MO18OxxqdqJozQAC4HnfxTOOOCYoV99zKXgu/d0exFzgD5E0blglMO3tnoIybRkuLzRbkJI2zNRVlhbZ2lt6DIVLTUVbKEnfYOWnpq96ik+UDW2tg9BC6hdzpiPafxBytMprmzoq2V0pJrrF5bgWUfqKOdXOErELE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulUaW48U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54842C4CEEE;
	Sun,  8 Jun 2025 12:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749387311;
	bh=r5lcvMeIFl0weuoVyoHeVTqHoqUe0pfnScw2crbJDb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ulUaW48U7xruWj1oS6Ik2nKIK4Zj/+N73U/GDAnsICWEZPeJy1xMukUI82PH0y21+
	 BAPxFLF0LepSy3BIRBXyCA572O+22G63gLW3FjqxfOhvV5xr5BTGkYXa8rAta3tiBx
	 mvPQY1KBzeHzKTjkkNka/E20vuAPBQ+ZUPucrEE0QoJYj0gXmMEbZtaqp0Wz9CkSE7
	 eny5fyPN6uySg6YAARIir/8unyIwN3uynXEyexWg14gd9P11T2vGLUMdE/MO+yXChZ
	 EZoWAFcxQTAJfqg3oPNNketX6FjGWoMqnv0p8rtf0tX11dy0NNC820DA5+kGWXGQUq
	 dIphAHkRJwd7g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Justin Turner Arthur <justinarthur@gmail.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	smfrench@gmail.com,
	linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 02/10] ksmbd: provide zero as a unique ID to the Mac client
Date: Sun,  8 Jun 2025 08:54:59 -0400
Message-Id: <20250608125507.934032-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250608125507.934032-1-sashal@kernel.org>
References: <20250608125507.934032-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.32
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 571781eb7ffefa65b0e922c8031e42b4411a40d4 ]

The Mac SMB client code seems to expect the on-disk file identifier
to have the semantics of HFS+ Catalog Node Identifier (CNID).
ksmbd provides the inode number as a unique ID to the client,
but in the case of subvolumes of btrfs, there are cases where different
files have the same inode number, so the mac smb client treats it
as an error. There is a report that a similar problem occurs
when the share is ZFS.
Returning UniqueId of zero will make the Mac client to stop using and
trusting the file id returned from the server.

Reported-by: Justin Turner Arthur <justinarthur@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

## Critical Bug Fix Analysis

**1. Real User Impact**
The commit addresses a real-world compatibility issue reported by Justin
Turner Arthur where Mac SMB clients fail when connecting to ksmbd shares
backed by btrfs subvolumes or ZFS. This isn't a theoretical problem but
affects actual production environments.

**2. Root Cause Analysis**
The core issue is an architectural mismatch:
- **Mac SMB clients** expect file identifiers to behave like HFS+
  Catalog Node Identifiers (CNIDs), which must be unique across the
  entire share
- **ksmbd** was providing Linux inode numbers as UniqueId values
- **Modern filesystems** like btrfs subvolumes and ZFS can have
  different files with identical inode numbers, causing Mac clients to
  interpret this as filesystem corruption

**3. Code Changes Assessment**

The fix is surgically precise and low-risk:

**a) Apple Client Detection:**
```c
if (conn->is_aapl == false) {
    context = smb2_find_context_vals(req, SMB2_CREATE_AAPL, 4);
    if (IS_ERR(context)) {
        rc = PTR_ERR(context);
        goto err_out1;
    } else if (context)
        conn->is_aapl = true;
}
```
This properly detects Apple clients by looking for the
`SMB2_CREATE_AAPL` context, which is the standard way Apple clients
identify themselves.

**b) Conditional UniqueId Assignment:**
```c
if (conn->is_aapl)
    dinfo->UniqueId = 0;
else
    dinfo->UniqueId = cpu_to_le64(ksmbd_kstat->kstat->ino);
```
For Apple clients, UniqueId is set to 0, which signals to the Mac client
to stop trusting/using file IDs from the server. For all other clients,
behavior remains unchanged.

**4. Comparison with Historical Precedents**

This commit closely matches the pattern of Similar Commit #1 (ksmbd
UniqueId fix) which was marked "YES" for backporting:
- **Small, contained fix**: Only affects specific client behavior
- **Addresses real bug**: Fixes actual user-reported filesystem errors
- **No architectural changes**: Simple conditional logic
- **Minimal regression risk**: Only affects Apple clients
- **Clear subsystem boundary**: Confined to ksmbd SMB server code

**5. Stable Tree Compatibility Criteria**

✅ **Important bugfix**: Fixes Mac client filesystem errors
✅ **Minimal risk**: Changes only affect Apple clients
✅ **Small and contained**: Three files, ~10 lines of changes
✅ **No new features**: Pure compatibility fix
✅ **Clear side effects**: Well-understood impact on Mac clients only

**6. Technical Safety**

The implementation is exceptionally safe:
- **Backward compatible**: Non-Apple clients see no change
- **Self-contained**: Apple client detection is robust
- **Error handling**: Proper error checking for context parsing
- **Standard compliance**: Uses official Apple SMB extension detection

**7. Production Impact**

Without this fix:
- Mac users cannot reliably use ksmbd shares on btrfs subvolumes
- ZFS users experience similar Mac client failures
- Enterprise environments mixing Mac clients and modern Linux
  filesystems are broken

This is exactly the type of important, low-risk bugfix that stable
kernel trees are designed to include. The fix resolves a significant
compatibility issue with no regression risk for existing users.

 fs/smb/server/connection.h |  1 +
 fs/smb/server/smb2pdu.c    | 19 +++++++++++++++++--
 fs/smb/server/smb2pdu.h    |  3 +++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/connection.h b/fs/smb/server/connection.h
index 14620e147dda5..6efed923bd687 100644
--- a/fs/smb/server/connection.h
+++ b/fs/smb/server/connection.h
@@ -108,6 +108,7 @@ struct ksmbd_conn {
 	__le16				signing_algorithm;
 	bool				binding;
 	atomic_t			refcnt;
+	bool				is_aapl;
 };
 
 struct ksmbd_conn_ops {
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 815ee5a74901e..9973742e5241f 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3534,6 +3534,15 @@ int smb2_open(struct ksmbd_work *work)
 			ksmbd_debug(SMB, "get query on disk id context\n");
 			query_disk_id = 1;
 		}
+
+		if (conn->is_aapl == false) {
+			context = smb2_find_context_vals(req, SMB2_CREATE_AAPL, 4);
+			if (IS_ERR(context)) {
+				rc = PTR_ERR(context);
+				goto err_out1;
+			} else if (context)
+				conn->is_aapl = true;
+		}
 	}
 
 	rc = ksmbd_vfs_getattr(&path, &stat);
@@ -3973,7 +3982,10 @@ static int smb2_populate_readdir_entry(struct ksmbd_conn *conn, int info_level,
 		if (dinfo->EaSize)
 			dinfo->ExtFileAttributes = FILE_ATTRIBUTE_REPARSE_POINT_LE;
 		dinfo->Reserved = 0;
-		dinfo->UniqueId = cpu_to_le64(ksmbd_kstat->kstat->ino);
+		if (conn->is_aapl)
+			dinfo->UniqueId = 0;
+		else
+			dinfo->UniqueId = cpu_to_le64(ksmbd_kstat->kstat->ino);
 		if (d_info->hide_dot_file && d_info->name[0] == '.')
 			dinfo->ExtFileAttributes |= FILE_ATTRIBUTE_HIDDEN_LE;
 		memcpy(dinfo->FileName, conv_name, conv_len);
@@ -3990,7 +4002,10 @@ static int smb2_populate_readdir_entry(struct ksmbd_conn *conn, int info_level,
 			smb2_get_reparse_tag_special_file(ksmbd_kstat->kstat->mode);
 		if (fibdinfo->EaSize)
 			fibdinfo->ExtFileAttributes = FILE_ATTRIBUTE_REPARSE_POINT_LE;
-		fibdinfo->UniqueId = cpu_to_le64(ksmbd_kstat->kstat->ino);
+		if (conn->is_aapl)
+			fibdinfo->UniqueId = 0;
+		else
+			fibdinfo->UniqueId = cpu_to_le64(ksmbd_kstat->kstat->ino);
 		fibdinfo->ShortNameLength = 0;
 		fibdinfo->Reserved = 0;
 		fibdinfo->Reserved2 = cpu_to_le16(0);
diff --git a/fs/smb/server/smb2pdu.h b/fs/smb/server/smb2pdu.h
index 17a0b18a8406b..16ae8a10490be 100644
--- a/fs/smb/server/smb2pdu.h
+++ b/fs/smb/server/smb2pdu.h
@@ -63,6 +63,9 @@ struct preauth_integrity_info {
 
 #define SMB2_SESSION_TIMEOUT		(10 * HZ)
 
+/* Apple Defined Contexts */
+#define SMB2_CREATE_AAPL		"AAPL"
+
 struct create_durable_req_v2 {
 	struct create_context_hdr ccontext;
 	__u8   Name[8];
-- 
2.39.5


