Return-Path: <stable+bounces-165834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C83EAB19589
	for <lists+stable@lfdr.de>; Sun,  3 Aug 2025 23:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB173B5BE3
	for <lists+stable@lfdr.de>; Sun,  3 Aug 2025 21:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391F3217F33;
	Sun,  3 Aug 2025 21:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgjmNRXP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51061FC0F0;
	Sun,  3 Aug 2025 21:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754255885; cv=none; b=tp8J++TS7vOmYGYj47tpk+YsgJepDqviG8po4unyKAX9+6mydALVNoXi2deJxi92wCRvwmGDmzLfI74LdraSfedbB/cTE/YOz/1zAvvSo4wHvJILfnS1dq2mKQ9zFWw9oFTIVe4IBbFEuiIK2NhcQehH7hYqt3+7N6H2Ca8DmEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754255885; c=relaxed/simple;
	bh=e4jAUNsPqeu366ZDtnh7El4UN6Exn/WzIQm6cTVFkPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vz/4KvQ+E2ZboaKes+QTYdH+TDGWQnLQewcOHWeyxWs7PRzH+zZVwZtgm9kGVty6YxMvxoi/SX+Dm8o1kvMvgUH3LPiHSFuhexK+7u0AWJKz89OugFyuEkAqvAFmZJi8GXslzC/9vnYjapWsEAla6GvdA5M6fAY3OFioKI/M9mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgjmNRXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68C0C4CEF0;
	Sun,  3 Aug 2025 21:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754255884;
	bh=e4jAUNsPqeu366ZDtnh7El4UN6Exn/WzIQm6cTVFkPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SgjmNRXP94CJVQOAk506EtmMAcr7zWa5+shTTDAZzvUd7Z+wC5FXbnyEzxI1qgf5D
	 uFpJiHuniCh4k0UuOru6OLGveFFCVoLYn+Jv8MvVb7OE5Fiewa44G5YPouMO3we/ZO
	 u65heahtlN05UmM/G6hd1MK67RDR13D74zb6NpCkvP46NQRTgmmMewrvmUfdmR1r63
	 rnApwZKylI+ehPUf9xiCn74GF/MLKyxTJocDX+zTGg7uabndZr2aRO39DxqMB94tU3
	 Xd5Rc2i224rR3nVFenezesGDUB6mT4CPY4c2xhINmihke6OmByXwysyxjVjSSFPUZO
	 o4iNsTblOe5jg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: NeilBrown <neil@brown.name>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	smfrench@gmail.com,
	linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.16 11/35] smb/server: avoid deadlock when linking with ReplaceIfExists
Date: Sun,  3 Aug 2025 17:17:11 -0400
Message-Id: <20250803211736.3545028-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250803211736.3545028-1-sashal@kernel.org>
References: <20250803211736.3545028-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.16
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
index 63d17cea2e95..27d04180789d 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6053,7 +6053,6 @@ static int smb2_create_link(struct ksmbd_work *work,
 {
 	char *link_name = NULL, *target_name = NULL, *pathname = NULL;
 	struct path path, parent_path;
-	bool file_present = false;
 	int rc;
 
 	if (buf_len < (u64)sizeof(struct smb2_file_link_info) +
@@ -6086,11 +6085,8 @@ static int smb2_create_link(struct ksmbd_work *work,
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
@@ -6098,21 +6094,17 @@ static int smb2_create_link(struct ksmbd_work *work,
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


