Return-Path: <stable+bounces-217061-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJgqIw7UlGmfIAIAu9opvQ
	(envelope-from <stable+bounces-217061-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:48:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C02941504E6
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A524300602B
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B719D28851C;
	Tue, 17 Feb 2026 20:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qc1gnVPw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5AE2773E4;
	Tue, 17 Feb 2026 20:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771361289; cv=none; b=g0NKV7tdOhZ/401X6vv0GKKRErzLi0Zclv059l20USgX9RKizLAtrdnuzc3hFFp467OVuOo9q1Ff9CEo/2lcaOs7phXyDqD3aC2dK847+ePzy2XE54ljqdixqJouRzm+svIukMtKyjAwTokEQL354vCWGHAYaPnOEMyaZlki36c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771361289; c=relaxed/simple;
	bh=rXw0Uoge3XnV8GkFOelzMVR1EZE1ZGK6ylID/gELPGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qY/4XjPADih93fdXrkj7HPBMxyROd3pqGKeBfy+CY+dsDesazFasitD3B3TrGPU/l7AZx5dNPopIPendS7T4x1KfVB9xQHF21oto8CKu40xAvIfI+AiEBlOZQvGhnglDZT2cZgbSp/8n5RvqQqlWU8D+vw0emB4rAJ0vc3I8u/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qc1gnVPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDCCC4CEF7;
	Tue, 17 Feb 2026 20:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771361289;
	bh=rXw0Uoge3XnV8GkFOelzMVR1EZE1ZGK6ylID/gELPGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qc1gnVPw4jblq1mNmJPNGphDepGCUF1L6WdAOnxJWEN69Nr0TDkDOKWLxKYoq90Gg
	 IYlIEA4isfnDJRvgzf3b3B5JVmy5Q6BXFSx8elo60m23yvF/sxdC5rf3A/RwTgsG1T
	 7p9+WgL38wDP+EyTwLFLKD9nvAUy2MF6Zer7zN6A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Wetzel <Alexander@wetzel-home.de>,
	Johannes Berg <johannes.berg@intel.com>,
	Bin Lan <lanbincn@139.com>
Subject: [PATCH 6.1 56/64] wifi: cfg80211: Add missing lock in cfg80211_check_and_end_cac()
Date: Tue, 17 Feb 2026 21:31:52 +0100
Message-ID: <20260217200009.607155854@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217200007.505931165@linuxfoundation.org>
References: <20260217200007.505931165@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-217061-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,wetzel-home.de,intel.com,139.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,wetzel-home.de:email,139.com:email]
X-Rspamd-Queue-Id: C02941504E6
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Wetzel <Alexander@wetzel-home.de>

[ Upstream commit 2c5dee15239f3f3e31aa5c8808f18996c039e2c1 ]

Callers of wdev_chandef() must hold the wiphy mutex.

But the worker cfg80211_propagate_cac_done_wk() never takes the lock.
Which triggers the warning below with the mesh_peer_connected_dfs
test from hostapd and not (yet) released mac80211 code changes:

WARNING: CPU: 0 PID: 495 at net/wireless/chan.c:1552 wdev_chandef+0x60/0x165
Modules linked in:
CPU: 0 UID: 0 PID: 495 Comm: kworker/u4:2 Not tainted 6.14.0-rc5-wt-g03960e6f9d47 #33 13c287eeabfe1efea01c0bcc863723ab082e17cf
Workqueue: cfg80211 cfg80211_propagate_cac_done_wk
Stack:
 00000000 00000001 ffffff00 6093267c
 00000000 6002ec30 6d577c50 60037608
 00000000 67e8d108 6063717b 00000000
Call Trace:
 [<6002ec30>] ? _printk+0x0/0x98
 [<6003c2b3>] show_stack+0x10e/0x11a
 [<6002ec30>] ? _printk+0x0/0x98
 [<60037608>] dump_stack_lvl+0x71/0xb8
 [<6063717b>] ? wdev_chandef+0x60/0x165
 [<6003766d>] dump_stack+0x1e/0x20
 [<6005d1b7>] __warn+0x101/0x20f
 [<6005d3a8>] warn_slowpath_fmt+0xe3/0x15d
 [<600b0c5c>] ? mark_lock.part.0+0x0/0x4ec
 [<60751191>] ? __this_cpu_preempt_check+0x0/0x16
 [<600b11a2>] ? mark_held_locks+0x5a/0x6e
 [<6005d2c5>] ? warn_slowpath_fmt+0x0/0x15d
 [<60052e53>] ? unblock_signals+0x3a/0xe7
 [<60052f2d>] ? um_set_signals+0x2d/0x43
 [<60751191>] ? __this_cpu_preempt_check+0x0/0x16
 [<607508b2>] ? lock_is_held_type+0x207/0x21f
 [<6063717b>] wdev_chandef+0x60/0x165
 [<605f89b4>] regulatory_propagate_dfs_state+0x247/0x43f
 [<60052f00>] ? um_set_signals+0x0/0x43
 [<605e6bfd>] cfg80211_propagate_cac_done_wk+0x3a/0x4a
 [<6007e460>] process_scheduled_works+0x3bc/0x60e
 [<6007d0ec>] ? move_linked_works+0x4d/0x81
 [<6007d120>] ? assign_work+0x0/0xaa
 [<6007f81f>] worker_thread+0x220/0x2dc
 [<600786ef>] ? set_pf_worker+0x0/0x57
 [<60087c96>] ? to_kthread+0x0/0x43
 [<6008ab3c>] kthread+0x2d3/0x2e2
 [<6007f5ff>] ? worker_thread+0x0/0x2dc
 [<6006c05b>] ? calculate_sigpending+0x0/0x56
 [<6003b37d>] new_thread_handler+0x4a/0x64
irq event stamp: 614611
hardirqs last  enabled at (614621): [<00000000600bc96b>] __up_console_sem+0x82/0xaf
hardirqs last disabled at (614630): [<00000000600bc92c>] __up_console_sem+0x43/0xaf
softirqs last  enabled at (614268): [<00000000606c55c6>] __ieee80211_wake_queue+0x933/0x985
softirqs last disabled at (614266): [<00000000606c52d6>] __ieee80211_wake_queue+0x643/0x985

Fixes: 26ec17a1dc5e ("cfg80211: Fix radar event during another phy CAC")
Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
Link: https://patch.msgid.link/20250717162547.94582-1-Alexander@wetzel-home.de
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[ Use wiphy_lock() and wiphy_unlock() instead of guard() in v6.1.y. ]
Signed-off-by: Bin Lan <lanbincn@139.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/wireless/reg.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -4241,6 +4241,9 @@ EXPORT_SYMBOL(regulatory_pre_cac_allowed
 static void cfg80211_check_and_end_cac(struct cfg80211_registered_device *rdev)
 {
 	struct wireless_dev *wdev;
+
+	wiphy_lock(&rdev->wiphy);
+
 	/* If we finished CAC or received radar, we should end any
 	 * CAC running on the same channels.
 	 * the check !cfg80211_chandef_dfs_usable contain 2 options:
@@ -4264,6 +4267,8 @@ static void cfg80211_check_and_end_cac(s
 		if (!cfg80211_chandef_dfs_usable(&rdev->wiphy, chandef))
 			rdev_end_cac(rdev, wdev->netdev);
 	}
+
+	wiphy_unlock(&rdev->wiphy);
 }
 
 void regulatory_propagate_dfs_state(struct wiphy *wiphy,



