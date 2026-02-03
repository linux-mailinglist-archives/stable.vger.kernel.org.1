Return-Path: <stable+bounces-213198-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOXxKgPvgWlAMwMAu9opvQ
	(envelope-from <stable+bounces-213198-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 13:50:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1087DD952A
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 13:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E50FE3126675
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 12:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1332344D94;
	Tue,  3 Feb 2026 12:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U6EKlobg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DD93446D2
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 12:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770122539; cv=none; b=g4gUugA10lT+oaD1aMLbxDd20Henx0K/SJ8X1AVQEKIIlg9jz0rxNkZokrj9I/46qYRVokXhSz+Y4w4SV7HfW57xFsdafthFBMkvJ07OGYFP/pkPivmijwzmRefx5v4Ekf22THkKVufvYkwgUBoV/kLsdl8QLzvawTbxP8SLHio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770122539; c=relaxed/simple;
	bh=hUPVrwTHqQbDRyUJ7c3NrAKP2UqtfR4IavMN96YM3WM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VmTLFp+M7VqaO8SHqFGr2WfCMpcOJwyUhYAmUimQruQ4STJ1BkUZD+7md76rHiMlorBm+ev4Zku9lpOQEhEa2jGXKI6PfLfB82u0Bgi/XGp+5j/i3aZAjtXgybAOC4U/Hw1jWWHD4W9wFHkpzSA6eclRhtpv5/FbTDzD6uP3rrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U6EKlobg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A935C19422;
	Tue,  3 Feb 2026 12:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770122539;
	bh=hUPVrwTHqQbDRyUJ7c3NrAKP2UqtfR4IavMN96YM3WM=;
	h=Subject:To:Cc:From:Date:From;
	b=U6EKlobggL8kwjKNcLJHmUK246qBA0FypvhVrRPYCuc9praYQ/i6Y1GFAi1sQs9bO
	 Sn04ykuQAN/Iw0ZPQahWN215bUpVRLEl5rDW21jgGhKbu/fAzU24ZFOUdiOLllkbuz
	 0d8yReXgNIB+UMXLxM0TZyR+o45aupHQr9WxWDx0=
Subject: FAILED: patch "[PATCH] writeback: fix 100% CPU usage when dirtytime_expire_interval" failed to apply to 5.15-stable tree
To: laveeshb@laveeshbansal.com,brauner@kernel.org,jack@suse.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Feb 2026 13:42:05 +0100
Message-ID: <2026020305-fidgeting-jump-20d0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213198-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[laveeshbansal.com:email,gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,suse.cz:email]
X-Rspamd-Queue-Id: 1087DD952A
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 543467d6fe97e27e22a26e367fda972dbefebbff
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026020305-fidgeting-jump-20d0@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 543467d6fe97e27e22a26e367fda972dbefebbff Mon Sep 17 00:00:00 2001
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
Date: Tue, 6 Jan 2026 14:50:58 +0000
Subject: [PATCH] writeback: fix 100% CPU usage when dirtytime_expire_interval
 is 0

When vm.dirtytime_expire_seconds is set to 0, wakeup_dirtytime_writeback()
schedules delayed work with a delay of 0, causing immediate execution.
The function then reschedules itself with 0 delay again, creating an
infinite busy loop that causes 100% kworker CPU usage.

Fix by:
- Only scheduling delayed work in wakeup_dirtytime_writeback() when
  dirtytime_expire_interval is non-zero
- Cancelling the delayed work in dirtytime_interval_handler() when
  the interval is set to 0
- Adding a guard in start_dirtytime_writeback() for defensive coding

Tested by booting kernel in QEMU with virtme-ng:
- Before fix: kworker CPU spikes to ~73%
- After fix: CPU remains at normal levels
- Setting interval back to non-zero correctly resumes writeback

Fixes: a2f4870697a5 ("fs: make sure the timestamps for lazytime inodes eventually get written")
Cc: stable@vger.kernel.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220227
Signed-off-by: Laveesh Bansal <laveeshb@laveeshbansal.com>
Link: https://patch.msgid.link/20260106145059.543282-2-laveeshb@laveeshbansal.com
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 6800886c4d10..cd21c74cd0e5 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2492,7 +2492,8 @@ static void wakeup_dirtytime_writeback(struct work_struct *w)
 				wb_wakeup(wb);
 	}
 	rcu_read_unlock();
-	schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
+	if (dirtytime_expire_interval)
+		schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
 }
 
 static int dirtytime_interval_handler(const struct ctl_table *table, int write,
@@ -2501,8 +2502,12 @@ static int dirtytime_interval_handler(const struct ctl_table *table, int write,
 	int ret;
 
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
-	if (ret == 0 && write)
-		mod_delayed_work(system_percpu_wq, &dirtytime_work, 0);
+	if (ret == 0 && write) {
+		if (dirtytime_expire_interval)
+			mod_delayed_work(system_percpu_wq, &dirtytime_work, 0);
+		else
+			cancel_delayed_work_sync(&dirtytime_work);
+	}
 	return ret;
 }
 
@@ -2519,7 +2524,8 @@ static const struct ctl_table vm_fs_writeback_table[] = {
 
 static int __init start_dirtytime_writeback(void)
 {
-	schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
+	if (dirtytime_expire_interval)
+		schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
 	register_sysctl_init("vm", vm_fs_writeback_table);
 	return 0;
 }


