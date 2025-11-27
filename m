Return-Path: <stable+bounces-197092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1779C8E4C0
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 13:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A23BB4E744D
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 12:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060D1330305;
	Thu, 27 Nov 2025 12:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="s+QU2J1z"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7912C1F12F8
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764247447; cv=none; b=sbd8+67jqY6nVJvRzwTGCWJaJfivIaplp85WEv8/PK2Z6ESiVhL63GzGJzzX1TVEyIe4tyVgWaQDOGV58X86l4mD8ePpBRP3hVYRwem9teuTo/pz4TennUBFbzd1illvl4JbgDAd1hnfXJOebN+x1Ba/72yVHH/vXluMJB4kv0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764247447; c=relaxed/simple;
	bh=9snvuW1KJ+VouVojNeylBNBaqMxI+rBFqCducOaAaYc=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=pppCBIcdNxPzGNQeoUWMlqofHY74xMxPNU9816eceqtLyaj9NszbBhYrR+guw2QqDOlkC18kujNFMl0OAi+f0ShsQYnplW3TbcaRYGRA+vGX7L45nfenPBKzUh62HZsk7qM2fN7HM0lkWoJoh0eA1uGvUv3H4UrNiYNbjAcyfiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=s+QU2J1z; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1764247434;
	bh=CH5o5C8UYksmKGr3g0dl+2RvN6TayozwW0P7RdmI0J4=;
	h=From:To:Cc:Subject:Date;
	b=s+QU2J1zxlyqwRU08HVwb4EN1vDTwIsUcxHl5ImIYrVRdW3He9bdRt8E4AQHGU9Qv
	 SXDpEBIIEiJ9j5gdmSc4hJfDL5U+/eioeYqyOoCcj3IzNIv1ByBxjSJglb0G7qXMNc
	 VevoAIxtHWEkOT/Re59gbisZVDXSbrjVvcuJZtMY=
Received: from ubuntu24.. ([120.244.194.181])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id AF0BC629; Thu, 27 Nov 2025 20:43:48 +0800
X-QQ-mid: xmsmtpt1764247428ta9mcnz6j
Message-ID: <tencent_6D9A9A8F6E490FEB741C0F18C30643DA9F07@qq.com>
X-QQ-XMAILINFO: M3cUO7vMX4ch2YmjNiUP31pPR+KCru/X70X4KyDez39ag5IkHyUPzOHQARi1q/
	 JBJdT7nNWBBLSyCc78UyMwE82n9EnmbiWrOvl01OQRsXMGHAvioq09eyrjr2+0vyRN2kcc5+LOCy
	 zbeJFAIVtyFQFTCrS4U9TYlGkW6g2/d+pIVrcYI9HaNh3ZFerLVkjbVjyPdkW3QpltpN9Pp6MGy9
	 7dPkFlPpnv36u3IyL9E+62Ub+/FkrbR1NbCtkHB9D3K7FCTIKQiDf43CiAiSNlrPsUlAu2gZs+yH
	 WoYx+m4nUVoVsNkEt90ZYW0chd6NNMb298EQdC55ZsQjc0gpeH+HUiivor5H3FjnXVVb50V088NY
	 hcpIpjmvR+Ugs3doJxNQ2n/BoiwvNDGdNFc7J7t8C5VYtdaORA9Qt6sPQlJyXVGKi3uzGneAwhZ/
	 5aU67QBjOBNyorDptcFSmIBRm9ZH4bsRYmqzN2zSB3gX1yd5wSjA6M2gppjE+Y8qWI00e4js/Pu4
	 oMHZdSt+2pwGBZjIGjpsUWyrmvL2GOsc6kq12+7kEZiPjhXjk0d8zRQaDXK6FGBdvqQDBug1kjHt
	 eV1J/8h1uz2h18V/WhhvUh5xLRruYs5BaSRoGp5JNI6TVWFWLkJxS6d0lTHCs5M3dF5ImHFGW1fe
	 s2iyfjfLAH3fAPOEMUA4bONLpmwshm2PCowKPxlOTMBcbecPMAFwzEC7zFgomuPf9l5Ed8p6HiRk
	 Z+V5tct9NmonSlJeXZMAAA1SN3JvPVgiXMIUeq4UYEXgSBAapkljVnTAFcFwnAvec5a/2ejOrqPJ
	 kEivq6G7lzbIlvQfhJnHE8xcI1gsI3S8jXjMM5MPyi8/DswP2kz4kK//W09VAiMfg8oQcJS6HPaO
	 9ivmGRc22DnKpkNaeTm6rqNkRJ4A5Zx/wQePZv32H2a5mWnSkWC9kfQ3CWJMygUNybFgn3YGIrVY
	 z8xXqxCw/qNTZ6MrLGPsdo8k2PX8XiFdzvBmxQaQJle0hsFTHF3bLOeV5P4nx5mRhAI/0X5y4Wpg
	 0aFSTrUSvkg+Jhg81BOAsFMqY9Ufb7IJhNeVckGRc22gxrD5Deo9OUy9QENniwxzNUNkGSdA2XnP
	 LHehRhEq2MIzlbs8U=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: alvalan9@foxmail.com
To: stable@vger.kernel.org
Cc: Alexander Wetzel <Alexander@wetzel-home.de>,
	Johannes Berg <johannes.berg@intel.com>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.6.y] wifi: cfg80211: Add missing lock in cfg80211_check_and_end_cac()
Date: Thu, 27 Nov 2025 12:43:47 +0000
X-OQ-MSGID: <20251127124347.4768-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
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
and wiphy_unlock() instead of guard(). ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 net/wireless/reg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 9e0366ea86f4..4c695f29dfed 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -4208,6 +4208,9 @@ EXPORT_SYMBOL(regulatory_pre_cac_allowed);
 static void cfg80211_check_and_end_cac(struct cfg80211_registered_device *rdev)
 {
 	struct wireless_dev *wdev;
+
+	wiphy_lock(&rdev->wiphy);
+
 	/* If we finished CAC or received radar, we should end any
 	 * CAC running on the same channels.
 	 * the check !cfg80211_chandef_dfs_usable contain 2 options:
@@ -4231,6 +4234,8 @@ static void cfg80211_check_and_end_cac(struct cfg80211_registered_device *rdev)
 		if (!cfg80211_chandef_dfs_usable(&rdev->wiphy, chandef))
 			rdev_end_cac(rdev, wdev->netdev);
 	}
+
+	wiphy_unlock(&rdev->wiphy);
 }
 
 void regulatory_propagate_dfs_state(struct wiphy *wiphy,
-- 
2.43.0


