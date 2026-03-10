Return-Path: <stable+bounces-224356-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2B9RAgkCsGnOeQIAu9opvQ
	(envelope-from <stable+bounces-224356-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:35:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9941E24B0BD
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4FC1A306B47D
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D37387590;
	Tue, 10 Mar 2026 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D32mu0OT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3CC33A9C6;
	Tue, 10 Mar 2026 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142050; cv=none; b=pPIhv7G7h2lX9uQgVCX3BscUACxF3rm3nUX30uyfcQ1jJUltJNb3GTfsbyGU4UiUl1YaDKM73/NVJkaZHLq/JP23F8Mj3li4uo+0cnuELfjlPP/QvOpJ4d4lbUidTMVbwG9SO0Q8QmhKq4ZqSw+S6rmPPaIbjkw39+U14CT0OCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142050; c=relaxed/simple;
	bh=gYnQmoKX7kz7j3fOyV+2UxkJHZLzZ8Ka91t44vJO4mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUiE91vXRmdWPUPwtD5lWBAZpjMEN5OtgX7AAp+MP7YkC2BZcGujY9E+XY+fnNgfdVCX5Q+BB0nd394MzAWftVhGprOng/k/Yv3Ly0UIyIr6hpOKKsOg9UqCduwsS3/7ddnYmcoVvXNAU3wyL4hRM85nz+ZYVnG2Ch8EVSZgsKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D32mu0OT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AF8C19423;
	Tue, 10 Mar 2026 11:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142050;
	bh=gYnQmoKX7kz7j3fOyV+2UxkJHZLzZ8Ka91t44vJO4mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D32mu0OTwSupXaTTSLLoOxj120qJq0Gp4+be/v4rV8mnlYITOET5c+4q48GbX/XNG
	 CcoxG9CII+VigX5SYu1JkVX57JpwKi7SBSKeS7DxNy3VLaysqkxZL5AgBzYiDLQkyu
	 /TSUtedqPXV6ukolZdwTuyxcy7VnICajQUuJPalakxd3SACyrVdsJ0SL7e5TMIFTPq
	 QzzfrjeIMn80b8gw6Elug+xSvDE5WbBfint12IeSHL8LXwwolab63BTfWUTgUB2+YW
	 +WnoV0Ud4DKdSfAgcHOBW2E4Jdm1XPJwNJ0NAW5sq3ynGuWRTUfEn97rCyYP1yZn1R
	 wwfYtCOR/CnjQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Prithvi Tambewagh <activprithvi@gmail.com>,
	syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com,
	Dmitry Bogdanov <d.bogdanov@yadro.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.18 177/314] scsi: target: Fix recursive locking in __configfs_open_file()
Date: Tue, 10 Mar 2026 07:17:16 -0400
Message-ID: <803346a641cf98efc902fa9c2668df27c15f25f8.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9941E24B0BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,syzkaller.appspotmail.com,yadro.com,oracle.com,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224356-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,f6e8174215573a84b797];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,appspotmail.com:email,syzkaller.appspot.com:url,oracle.com:email,linuxfoundation.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Prithvi Tambewagh <activprithvi@gmail.com>

commit 14d4ac19d1895397532eec407433c5d74d9da53b upstream.

In flush_write_buffer, &p->frag_sem is acquired and then the loaded store
function is called, which, here, is target_core_item_dbroot_store().  This
function called filp_open(), following which these functions were called
(in reverse order), according to the call trace:

  down_read
  __configfs_open_file
  do_dentry_open
  vfs_open
  do_open
  path_openat
  do_filp_open
  file_open_name
  filp_open
  target_core_item_dbroot_store
  flush_write_buffer
  configfs_write_iter

target_core_item_dbroot_store() tries to validate the new file path by
trying to open the file path provided to it; however, in this case, the bug
report shows:

db_root: not a directory: /sys/kernel/config/target/dbroot

indicating that the same configfs file was tried to be opened, on which it
is currently working on. Thus, it is trying to acquire frag_sem semaphore
of the same file of which it already holds the semaphore obtained in
flush_write_buffer(), leading to acquiring the semaphore in a nested manner
and a possibility of recursive locking.

Fix this by modifying target_core_item_dbroot_store() to use kern_path()
instead of filp_open() to avoid opening the file using filesystem-specific
function __configfs_open_file(), and further modifying it to make this fix
compatible.

Reported-by: syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f6e8174215573a84b797
Tested-by: syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
Reviewed-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
Link: https://patch.msgid.link/20260216062002.61937-1-activprithvi@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/target/target_core_configfs.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index 1bd28482e7cb3..a2bd2e81d2c68 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -108,8 +108,8 @@ static ssize_t target_core_item_dbroot_store(struct config_item *item,
 					const char *page, size_t count)
 {
 	ssize_t read_bytes;
-	struct file *fp;
 	ssize_t r = -EINVAL;
+	struct path path = {};
 
 	mutex_lock(&target_devices_lock);
 	if (target_devices) {
@@ -131,17 +131,14 @@ static ssize_t target_core_item_dbroot_store(struct config_item *item,
 		db_root_stage[read_bytes - 1] = '\0';
 
 	/* validate new db root before accepting it */
-	fp = filp_open(db_root_stage, O_RDONLY, 0);
-	if (IS_ERR(fp)) {
+	r = kern_path(db_root_stage, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &path);
+	if (r) {
 		pr_err("db_root: cannot open: %s\n", db_root_stage);
+		if (r == -ENOTDIR)
+			pr_err("db_root: not a directory: %s\n", db_root_stage);
 		goto unlock;
 	}
-	if (!S_ISDIR(file_inode(fp)->i_mode)) {
-		filp_close(fp, NULL);
-		pr_err("db_root: not a directory: %s\n", db_root_stage);
-		goto unlock;
-	}
-	filp_close(fp, NULL);
+	path_put(&path);
 
 	strscpy(db_root, db_root_stage);
 	pr_debug("Target_Core_ConfigFS: db_root set to %s\n", db_root);
-- 
2.51.0


