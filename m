Return-Path: <stable+bounces-76215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4460C97A0A2
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 13:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2381F2459E
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 11:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE8215689A;
	Mon, 16 Sep 2024 11:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DceXspK2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F21847A62;
	Mon, 16 Sep 2024 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487956; cv=none; b=kkoAla1JpBxUJx+baNdpKFq1zqkLSPEMS0UXWBjr+r8Opxc+9OSike3bPwQedSKdNo5L6A8YNdhmU6AE49ZYBqlRP4YwMk9C3OUlHNAuemuQc0NU/zKIhAWPIyO9xBYbeB6hTIO08g5ybpYQLEQn99rNJ4YAtkkW8j0qvEHEb4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487956; c=relaxed/simple;
	bh=TFvM0+6swkycrKyQ4DjvF1UWpHn4dErDTWIGD1rfQVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgjM8udFW6yG89tKP8sz1dTZR8lF+8US0oua9xztyDsbcHmT6tSsMPmcv2+5VtdYnMvNpsFA11wXuLiKrXVn3O3FSLRN2pL6Krx8AhBuL+n1g9fr4XHloxH7tlTwma8pnSXdvh5an9je0LRMuv3vQ3DkjR10kYanZv95dW5n6XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DceXspK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F7FC4CEC4;
	Mon, 16 Sep 2024 11:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726487955;
	bh=TFvM0+6swkycrKyQ4DjvF1UWpHn4dErDTWIGD1rfQVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DceXspK2tLpTFyulvPTiJiF1MYnby1R3Fgpy/COn/m0js+tKl8U3g16d+UPPuNQUT
	 QXujig0Qs6wcvcZWP5FtShkZwal37t64AkEVFdaBETgSjr5NW6eI8f+NwhfA1IuKmM
	 uGj5jpBDzake+L7iTngmEa0OUqpJyCUb4+4gMWAg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sangsoo Lee <constant.lee@samsung.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 01/63] ksmbd: override fsids for share path check
Date: Mon, 16 Sep 2024 13:43:40 +0200
Message-ID: <20240916114221.071369898@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916114221.021192667@linuxfoundation.org>
References: <20240916114221.021192667@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit a018c1b636e79b60149b41151ded7c2606d8606e ]

Sangsoo reported that a DAC denial error occurred when accessing
files through the ksmbd thread. This patch override fsids for share
path check.

Reported-by: Sangsoo Lee <constant.lee@samsung.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/mgmt/share_config.c | 15 ++++++++++++---
 fs/smb/server/mgmt/share_config.h |  4 +++-
 fs/smb/server/mgmt/tree_connect.c |  9 +++++----
 fs/smb/server/mgmt/tree_connect.h |  4 ++--
 fs/smb/server/smb2pdu.c           |  2 +-
 fs/smb/server/smb_common.c        |  9 +++++++--
 fs/smb/server/smb_common.h        |  2 ++
 7 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/fs/smb/server/mgmt/share_config.c b/fs/smb/server/mgmt/share_config.c
index e0a6b758094f..d8d03070ae44 100644
--- a/fs/smb/server/mgmt/share_config.c
+++ b/fs/smb/server/mgmt/share_config.c
@@ -15,6 +15,7 @@
 #include "share_config.h"
 #include "user_config.h"
 #include "user_session.h"
+#include "../connection.h"
 #include "../transport_ipc.h"
 #include "../misc.h"
 
@@ -120,12 +121,13 @@ static int parse_veto_list(struct ksmbd_share_config *share,
 	return 0;
 }
 
-static struct ksmbd_share_config *share_config_request(struct unicode_map *um,
+static struct ksmbd_share_config *share_config_request(struct ksmbd_work *work,
 						       const char *name)
 {
 	struct ksmbd_share_config_response *resp;
 	struct ksmbd_share_config *share = NULL;
 	struct ksmbd_share_config *lookup;
+	struct unicode_map *um = work->conn->um;
 	int ret;
 
 	resp = ksmbd_ipc_share_config_request(name);
@@ -181,7 +183,14 @@ static struct ksmbd_share_config *share_config_request(struct unicode_map *um,
 				      KSMBD_SHARE_CONFIG_VETO_LIST(resp),
 				      resp->veto_list_sz);
 		if (!ret && share->path) {
+			if (__ksmbd_override_fsids(work, share)) {
+				kill_share(share);
+				share = NULL;
+				goto out;
+			}
+
 			ret = kern_path(share->path, 0, &share->vfs_path);
+			ksmbd_revert_fsids(work);
 			if (ret) {
 				ksmbd_debug(SMB, "failed to access '%s'\n",
 					    share->path);
@@ -214,7 +223,7 @@ static struct ksmbd_share_config *share_config_request(struct unicode_map *um,
 	return share;
 }
 
-struct ksmbd_share_config *ksmbd_share_config_get(struct unicode_map *um,
+struct ksmbd_share_config *ksmbd_share_config_get(struct ksmbd_work *work,
 						  const char *name)
 {
 	struct ksmbd_share_config *share;
@@ -227,7 +236,7 @@ struct ksmbd_share_config *ksmbd_share_config_get(struct unicode_map *um,
 
 	if (share)
 		return share;
-	return share_config_request(um, name);
+	return share_config_request(work, name);
 }
 
 bool ksmbd_share_veto_filename(struct ksmbd_share_config *share,
diff --git a/fs/smb/server/mgmt/share_config.h b/fs/smb/server/mgmt/share_config.h
index 5f591751b923..d4ac2dd4de20 100644
--- a/fs/smb/server/mgmt/share_config.h
+++ b/fs/smb/server/mgmt/share_config.h
@@ -11,6 +11,8 @@
 #include <linux/path.h>
 #include <linux/unicode.h>
 
+struct ksmbd_work;
+
 struct ksmbd_share_config {
 	char			*name;
 	char			*path;
@@ -68,7 +70,7 @@ static inline void ksmbd_share_config_put(struct ksmbd_share_config *share)
 	__ksmbd_share_config_put(share);
 }
 
-struct ksmbd_share_config *ksmbd_share_config_get(struct unicode_map *um,
+struct ksmbd_share_config *ksmbd_share_config_get(struct ksmbd_work *work,
 						  const char *name);
 bool ksmbd_share_veto_filename(struct ksmbd_share_config *share,
 			       const char *filename);
diff --git a/fs/smb/server/mgmt/tree_connect.c b/fs/smb/server/mgmt/tree_connect.c
index d2c81a8a11dd..94a52a75014a 100644
--- a/fs/smb/server/mgmt/tree_connect.c
+++ b/fs/smb/server/mgmt/tree_connect.c
@@ -16,17 +16,18 @@
 #include "user_session.h"
 
 struct ksmbd_tree_conn_status
-ksmbd_tree_conn_connect(struct ksmbd_conn *conn, struct ksmbd_session *sess,
-			const char *share_name)
+ksmbd_tree_conn_connect(struct ksmbd_work *work, const char *share_name)
 {
 	struct ksmbd_tree_conn_status status = {-ENOENT, NULL};
 	struct ksmbd_tree_connect_response *resp = NULL;
 	struct ksmbd_share_config *sc;
 	struct ksmbd_tree_connect *tree_conn = NULL;
 	struct sockaddr *peer_addr;
+	struct ksmbd_conn *conn = work->conn;
+	struct ksmbd_session *sess = work->sess;
 	int ret;
 
-	sc = ksmbd_share_config_get(conn->um, share_name);
+	sc = ksmbd_share_config_get(work, share_name);
 	if (!sc)
 		return status;
 
@@ -61,7 +62,7 @@ ksmbd_tree_conn_connect(struct ksmbd_conn *conn, struct ksmbd_session *sess,
 		struct ksmbd_share_config *new_sc;
 
 		ksmbd_share_config_del(sc);
-		new_sc = ksmbd_share_config_get(conn->um, share_name);
+		new_sc = ksmbd_share_config_get(work, share_name);
 		if (!new_sc) {
 			pr_err("Failed to update stale share config\n");
 			status.ret = -ESTALE;
diff --git a/fs/smb/server/mgmt/tree_connect.h b/fs/smb/server/mgmt/tree_connect.h
index 6377a70b811c..a42cdd051041 100644
--- a/fs/smb/server/mgmt/tree_connect.h
+++ b/fs/smb/server/mgmt/tree_connect.h
@@ -13,6 +13,7 @@
 struct ksmbd_share_config;
 struct ksmbd_user;
 struct ksmbd_conn;
+struct ksmbd_work;
 
 enum {
 	TREE_NEW = 0,
@@ -50,8 +51,7 @@ static inline int test_tree_conn_flag(struct ksmbd_tree_connect *tree_conn,
 struct ksmbd_session;
 
 struct ksmbd_tree_conn_status
-ksmbd_tree_conn_connect(struct ksmbd_conn *conn, struct ksmbd_session *sess,
-			const char *share_name);
+ksmbd_tree_conn_connect(struct ksmbd_work *work, const char *share_name);
 void ksmbd_tree_connect_put(struct ksmbd_tree_connect *tcon);
 
 int ksmbd_tree_conn_disconnect(struct ksmbd_session *sess,
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 898622b52b48..386f1f039883 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1975,7 +1975,7 @@ int smb2_tree_connect(struct ksmbd_work *work)
 	ksmbd_debug(SMB, "tree connect request for tree %s treename %s\n",
 		    name, treename);
 
-	status = ksmbd_tree_conn_connect(conn, sess, name);
+	status = ksmbd_tree_conn_connect(work, name);
 	if (status.ret == KSMBD_TREE_CONN_STATUS_OK)
 		rsp->hdr.Id.SyncId.TreeId = cpu_to_le32(status.tree_conn->id);
 	else
diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index e90a1e8c1951..bdcdc0fc9cad 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -729,10 +729,10 @@ bool is_asterisk(char *p)
 	return p && p[0] == '*';
 }
 
-int ksmbd_override_fsids(struct ksmbd_work *work)
+int __ksmbd_override_fsids(struct ksmbd_work *work,
+		struct ksmbd_share_config *share)
 {
 	struct ksmbd_session *sess = work->sess;
-	struct ksmbd_share_config *share = work->tcon->share_conf;
 	struct cred *cred;
 	struct group_info *gi;
 	unsigned int uid;
@@ -772,6 +772,11 @@ int ksmbd_override_fsids(struct ksmbd_work *work)
 	return 0;
 }
 
+int ksmbd_override_fsids(struct ksmbd_work *work)
+{
+	return __ksmbd_override_fsids(work, work->tcon->share_conf);
+}
+
 void ksmbd_revert_fsids(struct ksmbd_work *work)
 {
 	const struct cred *cred;
diff --git a/fs/smb/server/smb_common.h b/fs/smb/server/smb_common.h
index f1092519c0c2..4a3148b0167f 100644
--- a/fs/smb/server/smb_common.h
+++ b/fs/smb/server/smb_common.h
@@ -447,6 +447,8 @@ int ksmbd_extract_shortname(struct ksmbd_conn *conn,
 int ksmbd_smb_negotiate_common(struct ksmbd_work *work, unsigned int command);
 
 int ksmbd_smb_check_shared_mode(struct file *filp, struct ksmbd_file *curr_fp);
+int __ksmbd_override_fsids(struct ksmbd_work *work,
+			   struct ksmbd_share_config *share);
 int ksmbd_override_fsids(struct ksmbd_work *work);
 void ksmbd_revert_fsids(struct ksmbd_work *work);
 
-- 
2.43.0




