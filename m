Return-Path: <stable+bounces-216034-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDB/OorgjmluFgEAu9opvQ
	(envelope-from <stable+bounces-216034-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 09:27:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6947813406C
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 09:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C74273046026
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 08:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918E7329E4E;
	Fri, 13 Feb 2026 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="eHlnIPNb"
X-Original-To: stable@vger.kernel.org
Received: from n169-113.mail.139.com (n169-113.mail.139.com [120.232.169.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24E632720C
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 08:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770971258; cv=none; b=tq8K5GKHqFvT8Vw/HebslmqjPCO31stXw3LTUtgYr52iZ01AmUqIoX1yGcXiQz+x2JW98YOzvKhxl7YVu3ypVjygroWwq4toO+dJlG1OJYw5WLVeRIkaxfH1MQW3X4VJNIdBKSp41bdeGszi4LV5rFM1Liy4aAefLbFctm+NTqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770971258; c=relaxed/simple;
	bh=MaFPLmOnViW3dMlH0Ck/V6sEHrVux06aCvqQ220Y71Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hr7Zy2zvkfINDnrR5PzgCV1o8tIF7MUFeaj0mugIIiHXIkA8K+Qymp5VGC3ASZ6pb25NlQ1sLwes8O2tgl7L3zF0TrXpn4NFkMS4ZvB675y+Ewg0l07O4Tfs43OY84zpuRhqJAdNrGXDfRLHZWbe7xtm/C6J1xUC0m1pv3JKiRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=eHlnIPNb; arc=none smtp.client-ip=120.232.169.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=eHlnIPNb62l2Lb4vTnc10XqT2uZBCK24Bg7sfmOPLQMlBhx5eDzuUvLAZr2WOXr1NutHctWGkQZj1
	 EVwO0tcRXvwixsYsvsuiGI3awSYu0p/rwWnACp1OIOuSIr2HTbS0Qg35eMnptplzfo662OSf89lwYr
	 BpuiESZ71GJUIGOY=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from ubuntu24.corp.ad.wrs.com (unknown[120.244.194.126])
	by rmsmtp-lg-appmail-28-12033 (RichMail) with SMTP id 2f01698ee0462eb-b1b79;
	Fri, 13 Feb 2026 16:26:48 +0800 (CST)
X-RM-TRANSID:2f01698ee0462eb-b1b79
From: Bin Lan <lanbincn@139.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Alexander Wetzel <Alexander@wetzel-home.de>,
	Johannes Berg <johannes.berg@intel.com>,
	Bin Lan <lanbincn@139.com>
Subject: [PATCH 6.1.y] wifi: cfg80211: Add missing lock in cfg80211_check_and_end_cac()
Date: Fri, 13 Feb 2026 08:26:24 +0000
Message-ID: <20260213082624.4190-1-lanbincn@139.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[139.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[139.com];
	TAGGED_FROM(0.00)[bounces-216034-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[139.com:?];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lanbincn@139.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[wetzel-home.de,intel.com,139.com];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_TEMPFAIL(0.00)[139.com:s=dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6947813406C
X-Rspamd-Action: no action

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
---
 net/wireless/reg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 34a6bc43119b..85a982a1e9f9 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -4241,6 +4241,9 @@ EXPORT_SYMBOL(regulatory_pre_cac_allowed);
 static void cfg80211_check_and_end_cac(struct cfg80211_registered_device *rdev)
 {
 	struct wireless_dev *wdev;
+
+	wiphy_lock(&rdev->wiphy);
+
 	/* If we finished CAC or received radar, we should end any
 	 * CAC running on the same channels.
 	 * the check !cfg80211_chandef_dfs_usable contain 2 options:
@@ -4264,6 +4267,8 @@ static void cfg80211_check_and_end_cac(struct cfg80211_registered_device *rdev)
 		if (!cfg80211_chandef_dfs_usable(&rdev->wiphy, chandef))
 			rdev_end_cac(rdev, wdev->netdev);
 	}
+
+	wiphy_unlock(&rdev->wiphy);
 }
 
 void regulatory_propagate_dfs_state(struct wiphy *wiphy,
-- 
2.43.0



