Return-Path: <stable+bounces-223536-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2P8qJdqermmqGwIAu9opvQ
	(envelope-from <stable+bounces-223536-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:20:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8491A236ECE
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F76C3013188
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 10:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6081B38E5D4;
	Mon,  9 Mar 2026 10:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eD58Nq0o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E1523EA85
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773051578; cv=none; b=pZBjrQiT03s5O4xjMZgDgPLksHtHtshk3pwTKNK7zEoE8vBv50vutDi+sOv+Pjd05Jeu0T/GTEuU1zSvHPJBuY4w1OCsfcB0hjXh2wSp2X3i7FqiW3vFhEu0F3zcHiirBP9oJLSjsMRWn+q6yn0VzS3tzcmY3PXLw9eyr9Vswuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773051578; c=relaxed/simple;
	bh=5J89EeNMgyxW7z7WfUBhnvz6INaMHbhWgmmwbHxPRk4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=p2mPf9z3JbOQA7ejgdUEJjghdfkvm53MV3uNy6T57YJe102z0vfaYp8YP6RpzbqyP2mxbeEm6GjbaofTtxwXIhOkYjE01FGul+4QhZ3NFrH8DmzzWNOkat+DMx9NU/PiKxFXl33+M/X9gmpEV/avuGs9wTs/i8y0YwuwGLPrHR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eD58Nq0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7593AC4CEF7;
	Mon,  9 Mar 2026 10:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773051577;
	bh=5J89EeNMgyxW7z7WfUBhnvz6INaMHbhWgmmwbHxPRk4=;
	h=Subject:To:Cc:From:Date:From;
	b=eD58Nq0oizBQYebdZ6nB0NNP2Wss0V2NLRmjgdZeFaYW5joh5Cxcxv39rys0JAl7t
	 Dirwpj9v/m8xex3drInB6Pj8tk0JPiO0QzKVA5KtpdLQ/CQ+BkuD1hWkYVgxq0znK+
	 AOlHNdaeZVjYG9AF0jCRXyK22IHuByw6oXyQkuJU=
Subject: FAILED: patch "[PATCH] wifi: cfg80211: cancel rfkill_block work in" failed to apply to 5.15-stable tree
To: d.dulov@aladdin.ru,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 09 Mar 2026 11:19:34 +0100
Message-ID: <2026030934-cocoa-wrangle-1781@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8491A236ECE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223536-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.237];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,intel.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 767d23ade706d5fa51c36168e92a9c5533c351a1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026030934-cocoa-wrangle-1781@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 767d23ade706d5fa51c36168e92a9c5533c351a1 Mon Sep 17 00:00:00 2001
From: Daniil Dulov <d.dulov@aladdin.ru>
Date: Wed, 11 Feb 2026 11:20:24 +0300
Subject: [PATCH] wifi: cfg80211: cancel rfkill_block work in
 wiphy_unregister()

There is a use-after-free error in cfg80211_shutdown_all_interfaces found
by syzkaller:

BUG: KASAN: use-after-free in cfg80211_shutdown_all_interfaces+0x213/0x220
Read of size 8 at addr ffff888112a78d98 by task kworker/0:5/5326
CPU: 0 UID: 0 PID: 5326 Comm: kworker/0:5 Not tainted 6.19.0-rc2 #2 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: events cfg80211_rfkill_block_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x116/0x1f0
 print_report+0xcd/0x630
 kasan_report+0xe0/0x110
 cfg80211_shutdown_all_interfaces+0x213/0x220
 cfg80211_rfkill_block_work+0x1e/0x30
 process_one_work+0x9cf/0x1b70
 worker_thread+0x6c8/0xf10
 kthread+0x3c5/0x780
 ret_from_fork+0x56d/0x700
 ret_from_fork_asm+0x1a/0x30
 </TASK>

The problem arises due to the rfkill_block work is not cancelled when wiphy
is being unregistered. In order to fix the issue cancel the corresponding
work in wiphy_unregister().

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 1f87f7d3a3b4 ("cfg80211: add rfkill support")
Cc: stable@vger.kernel.org
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
Link: https://patch.msgid.link/20260211082024.1967588-1-d.dulov@aladdin.ru
Signed-off-by: Johannes Berg <johannes.berg@intel.com>

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 9af85d655027..d35cf04cbc81 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1212,6 +1212,7 @@ void wiphy_unregister(struct wiphy *wiphy)
 	/* this has nothing to do now but make sure it's gone */
 	cancel_work_sync(&rdev->wiphy_work);
 
+	cancel_work_sync(&rdev->rfkill_block);
 	cancel_work_sync(&rdev->conn_work);
 	flush_work(&rdev->event_work);
 	cancel_delayed_work_sync(&rdev->dfs_update_channels_wk);


