Return-Path: <stable+bounces-191772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F56C22EB6
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 02:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BC6E534EFB2
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 01:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36BD26ED2B;
	Fri, 31 Oct 2025 01:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="JIW3QVaB"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E4F23371B
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 01:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761875468; cv=none; b=Z1lUGtZk8JGk5iBXH/qxZnGZDYxMwRDHsf+q+TL2dzRCtYA/hd4evhGD5pOPnaqcaswZAmqgr7T8HJbNQV50nmFZIo77Eg/BjJY5Hx+KaNfnkh9Rml1unFoe8fjWSXFLBKfXFW+KUYEA6KPFNQiWO6J6LsOyZtxaNxzhJ9z6x7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761875468; c=relaxed/simple;
	bh=U7e11lemqcv2EHidj/w3YKNmVrD/5TcvwPsC1RAcckk=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Ib2QPfXBPLhzX+d23eZW4aT/8NY0wIA6o5Inst827+/OfgFR+7PK2YLWPfpKqqWmH1UWvEpfitAlHSfNVDcyl7a4m+qiao+bNL1SclmBZ3voW6BCVfrNzzULiFZMF6LLJcFy9E8kSLyKmsEupgZbV2ydGPQPAohA/vQo9ihmcdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=JIW3QVaB; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1761875445;
	bh=f/ghPKrncavOZ0Ntl5MgLwyJBCFS1YcrSAHOp3I/a0s=;
	h=From:To:Cc:Subject:Date;
	b=JIW3QVaBsfrv8pQIUeUI+wPWdSeUmgZIjRQbw6kbN/Zbgl0GVjuU+CS27o8uNRzGl
	 Teuq/3k0b4mZvTxz5av3gP5xL3lPPSL/9NcinlGdVnb2ShTHynh61cVQE0PMJLLCjd
	 7oE91nmpGwXRzw06hvIjeL4P8dXHGf1C5A3SGSzs=
Received: from LAPTOP-HOSUGD0G.wrs.com ([120.244.194.14])
	by newxmesmtplogicsvrszb42-0.qq.com (NewEsmtp) with SMTP
	id C9D3BE5D; Fri, 31 Oct 2025 09:50:29 +0800
X-QQ-mid: xmsmtpt1761875429t7o4mfq5y
Message-ID: <tencent_D8063C5ABD1AA68F4E4974EB631C0A18AC07@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNznRirRJLtZyxWkt/vr3m6/p7QeB1mDsPMrDagLZljcMN6axWpBlQ
	 Rgly9k4NR6/M/hHZrxU/+WA168LcI8BNZDDe5FeYOmLnEcM8df+0llCkRLUXH20FAZ7jenNf1eE8
	 4/232c+QAo6ft66RXcpKAB92pCPNwLfBfZLLvY04tevwKWep8I+xS9vK4QMFURr+NI7bcffx7yr8
	 KcH8MU1Z/zdkxjvkmF2hxriWy9+9JIYgCKV0WyRCh3mtWqtvg88ZTSdvyAB4MBq2pt8aqFoLshD9
	 e4yO1ydSpqe59tY9/KsxpbjjbWfCY0VTcPoe1sC3pr3TBf8rUUtskwdg9Nf3nrf6dtACJwK67nLJ
	 IMVjxxtfuHlKY2bJq4xnaUH9UUCbTiUF2EU0/SF63nqJH7+1bemx5LS0V/ItMpISZfTR2lFSm2JX
	 vMi/+376dC2JAKWt1/ptuy+Zh58pJNmPTscN+Xbq2aRaFqm/UXpigUTwwB4ZrEGcoKh1XvH4lkAJ
	 4wihFFNOgP+PNTFszK6OZjtOeKgldgo62oLBX4/3sP+BFdcugPny3QKDoTBlyZI3Gc4DIaysVAcZ
	 VV4klUqBaDIHMKfAHZwEHWGJiIAPAeh1Id56w6t75F3tDstIFv2WlgiDxc45yStidqW0hZ7hkIxz
	 g9AcrJ+6H3qchMe3laRC6fpr+NcK0Ntr5ykrISu50Jv+fy8abrspO8G3tecbPzB1pN2vF953em/O
	 D3xNRMAgv1NCpsa1rsLy4htzqRD2r5qQdMpY0KATKJ8kihW35m2VDN/AgbNU8fuUC/byALDV7XwF
	 gCF5cpyo2MnY0yJseaCDydlfhgsM0HmqwJKuC0y864wpDn1i1cW7mk6juGWfcVvoyQnMHzfsgsy0
	 zMoI6eJwmTf1zxV7pISxfz3cWwYco3KIDRGOrh8oNNFpOAjASerpoQtzk+fgSVWSaU4iZSmSJUVQ
	 jABD/M3sb7JpoHoKeQfLLe7eQj9A3gHVjlIHvRRY3jFwfOdB+TjvC7dUrUvl4OuA5API5XYky7U1
	 HwvCxtb7g5GhjhsPDWhDDwVmx/ud54exJWK6EAibKoPeEYBtul
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: alvalan9@foxmail.com
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Alexander Wetzel <Alexander@wetzel-home.de>,
	Johannes Berg <johannes.berg@intel.com>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.12.y] wifi: cfg80211: Add missing lock in cfg80211_check_and_end_cac()
Date: Fri, 31 Oct 2025 09:50:24 +0800
X-OQ-MSGID: <20251031015024.1403-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
[ The author recommends that when porting to older kernels, we should use wiphy_lock()
and wiphy_unlock() instead of guard(). This tip is mentioned in the link:
https://patch.msgid.link/20250717162547.94582-1-Alexander@wetzel-home.de. ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 net/wireless/reg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index f6846eb0f4b8..9f8428dc418a 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -4234,6 +4234,8 @@ static void cfg80211_check_and_end_cac(struct cfg80211_registered_device *rdev)
 	struct wireless_dev *wdev;
 	unsigned int link_id;
 
+	wiphy_lock(&rdev->wiphy);
+
 	/* If we finished CAC or received radar, we should end any
 	 * CAC running on the same channels.
 	 * the check !cfg80211_chandef_dfs_usable contain 2 options:
@@ -4258,6 +4260,8 @@ static void cfg80211_check_and_end_cac(struct cfg80211_registered_device *rdev)
 				rdev_end_cac(rdev, wdev->netdev, link_id);
 		}
 	}
+
+	wiphy_unlock(&rdev->wiphy);
 }
 
 void regulatory_propagate_dfs_state(struct wiphy *wiphy,
-- 
2.43.0


