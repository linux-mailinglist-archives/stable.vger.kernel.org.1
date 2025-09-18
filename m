Return-Path: <stable+bounces-165920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D19F9B1961D
	for <lists+stable@lfdr.de>; Sun,  3 Aug 2025 23:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AC7C189413F
	for <lists+stable@lfdr.de>; Sun,  3 Aug 2025 21:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001C221B9FD;
	Sun,  3 Aug 2025 21:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOioW1lX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5A120F076;
	Sun,  3 Aug 2025 21:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754256103; cv=none; b=eL5g5L0Qmuqqw+ZH4WcGrYn3o6VrKx59/iqrbfBNNIph+5OCQP7DbMe7Da87U5xWUw+WrUsRZtBvQETyXVXKWSJaQmPrRzVPt3A2ch08XzhvyBbc+sx0JaHJQra+wpb3QyP06oDm50ndXyLABnNTwvV1QmHr3iFDwTKY1gKSftc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754256103; c=relaxed/simple;
	bh=o7LNMXG5wsUTLLMrhOYXm6RvzrNO5p37SSGbgKbQFEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TzL7rfGdsa+alDIO7A9XljJSI4jPlS9agZaG/nZNhGodCsNIPs8bQGt9DtbmnTMSNzoP1f90eOR8M3DChfZOsh8mAUFS2MIFoHvE1FlcAX84SKHTtloJTx1uEyx/cDP8H35tL8BxMVt+H4Pmi1yewB8IPTTpADiifp1lqQJYuos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOioW1lX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20261C4CEEB;
	Sun,  3 Aug 2025 21:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754256103;
	bh=o7LNMXG5wsUTLLMrhOYXm6RvzrNO5p37SSGbgKbQFEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HOioW1lXlz0Vm67RnFAnetLwxR6IwxocE+kHT3f1Iv9qoofzzIMvRzoo2bJBeuDmU
	 n9TbabnSchUY3UW61ACFZiylMg+BsfDz9+U+GKCQvfVN3A+X5eSWX6kmZvIyoPZ8Ah
	 UsBtcR9ILyX3vtcHs4DHlrd36Lo+C8NFk4AGFTpLvHNM63EawjHwAi+OcUBb9/LQ8P
	 ee8BjaG/dLRo7yaoE3hDT2lRPA6JiYPcX+YDI3vNr4y54UKbpFwhySZE8YqLGlStSd
	 XWiUcvYJ3RbIz819mXHxO8EdwpGgPKSAEd8RRNPb9cgbBRlVuA+zKMjObD8eobV0WU
	 GXL5gUlnG2Xvw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: NeilBrown <neil@brown.name>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	smfrench@gmail.com,
	linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 06/16] smb/server: avoid deadlock when linking with ReplaceIfExists
Date: Sun,  3 Aug 2025 17:21:16 -0400
Message-Id: <20250803212127.3548367-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250803212127.3548367-1-sashal@kernel.org>
References: <20250803212127.3548367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.147
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

[ Upstream commit d5fc1400a34b4ea5e8f2ce296ea12bf8c8421694 ]

If smb2_create_link() is called with ReplaceIfExists set and the name
does exist then a deadlock will happen.

ksmbd_vfs_kern_path_locked() will return with success and the parent
directory will be locked.  ksmbd_vfs_remove_file() will then remove the
file.  ksmbd_vfs_link() will then be called while the parent is still
locked.  It will try to lock the same parent and will deadlock.

This patch moves the ksmbd_vfs_kern_path_unlock() call to *before*
ksmbd_vfs_link() and then simplifies the code, removing the file_present
flag variable.

Signed-off-by: NeilBrown <neil@brown.name>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees. Here's my
detailed analysis:

## Bug Analysis

This commit fixes a critical **deadlock** issue in the ksmbd (SMB
server) subsystem. The deadlock occurs in the `smb2_create_link()`
function when creating a hard link with the `ReplaceIfExists` flag set
and the target file already exists.

### Deadlock Sequence:

1. `ksmbd_vfs_kern_path_locked()` is called and locks the parent
   directory
2. If the file exists and `ReplaceIfExists` is true,
   `ksmbd_vfs_remove_file()` is called while the parent is still locked
3. `ksmbd_vfs_link()` is then called, which attempts to lock the same
   parent directory again
4. **Result: Deadlock** - the function tries to acquire a lock it
   already holds

### Fix Implementation:

The fix reorders the operations by:
- Moving the `ksmbd_vfs_kern_path_unlock()` call to execute **before**
  `ksmbd_vfs_link()`
- This ensures the parent directory is unlocked before attempting the
  link operation
- The code is also simplified by removing the `file_present` flag
  variable

## Backport Justification:

1. **Critical Bug**: This fixes a deadlock that can hang the kernel's
   SMB server functionality
2. **User Impact**: The deadlock can be triggered by normal SMB
   operations (creating hard links with replace), affecting file server
   availability
3. **Small and Contained**: The fix is minimal - just reordering
   function calls and simplifying logic
4. **No Architectural Changes**: This is a straightforward bug fix with
   no feature additions
5. **Low Risk**: The change only affects the specific error path in link
   creation
6. **Similar to Other Fixes**: The kernel has accepted similar deadlock
   fixes in ksmbd (e.g., commit 864fb5d37163 "ksmbd: fix possible
   deadlock in smb2_open")

## Code Quality:

The fix properly maintains the locking semantics while avoiding the
deadlock. The simplified code flow makes the logic clearer and less
error-prone.

This is exactly the type of bug fix that stable kernels should receive -
it fixes a real issue that affects users, has minimal risk of
regression, and improves system stability.

 fs/smb/server/smb2pdu.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index a04413095b23..cfc48223b74e 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5638,7 +5638,6 @@ static int smb2_create_link(struct ksmbd_work *work,
 {
 	char *link_name = NULL, *target_name = NULL, *pathname = NULL;
 	struct path path, parent_path;
-	bool file_present = false;
 	int rc;
 
 	if (buf_len < (u64)sizeof(struct smb2_file_link_info) +
@@ -5671,11 +5670,8 @@ static int smb2_create_link(struct ksmbd_work *work,
 	if (rc) {
 		if (rc != -ENOENT)
 			goto out;
-	} else
-		file_present = true;
-
-	if (file_info->ReplaceIfExists) {
-		if (file_present) {
+	} else {
+		if (file_info->ReplaceIfExists) {
 			rc = ksmbd_vfs_remove_file(work, &path);
 			if (rc) {
 				rc = -EINVAL;
@@ -5683,21 +5679,17 @@ static int smb2_create_link(struct ksmbd_work *work,
 					    link_name);
 				goto out;
 			}
-		}
-	} else {
-		if (file_present) {
+		} else {
 			rc = -EEXIST;
 			ksmbd_debug(SMB, "link already exists\n");
 			goto out;
 		}
+		ksmbd_vfs_kern_path_unlock(&parent_path, &path);
 	}
-
 	rc = ksmbd_vfs_link(work, target_name, link_name);
 	if (rc)
 		rc = -EINVAL;
 out:
-	if (file_present)
-		ksmbd_vfs_kern_path_unlock(&parent_path, &path);
 
 	if (!IS_ERR(link_name))
 		kfree(link_name);
-- 
2.39.5


