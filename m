Return-Path: <stable+bounces-157467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7C6AE5416
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684CC1680E3
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5CF221DA8;
	Mon, 23 Jun 2025 21:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zDqLeP7X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA5B70838;
	Mon, 23 Jun 2025 21:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750715937; cv=none; b=rORlo3pqKpNaqnW4eB54dgzzpVwoLiRoD9V36NvMjdkDCFdWXbVgGDcMTAvW8VMep7ijIT9TamKquBu2d5F9WpHaJKZvlKnEbWl7yk8GQ9OjK91MQJEYjpjkUY88dqzKLO2tqlMEojoS+tZs9bG/3boZTbhxGQ17mnHYIAXe2GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750715937; c=relaxed/simple;
	bh=WNcmRlUC/+x2ELohiQRKAK/UEn7Z7lXAykhDXLLHg1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXoyAEkQlV+WB2Wh96TXeYHJyJsb+KNeJSknk0+j7+F0u2PQzxbjHHHMFExTUr7zon8lgAmvLE+PGdUG0OadYMlGBnmPdeLDJHr8G0Oy0lkN5KnGEwnNVCsaVEa08WYsWD6PJaTWz3Z6/5T+uWOubEMkq/VekHIi2Si+/uHzR6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zDqLeP7X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C17C4CEEA;
	Mon, 23 Jun 2025 21:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750715936;
	bh=WNcmRlUC/+x2ELohiQRKAK/UEn7Z7lXAykhDXLLHg1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zDqLeP7XLkcM0zFy+DgL/daN2r7KvG0lI6tvBI2zXi4alw34zGpeHdFXHPI36LRF/
	 37tqcwKnhnIHYcgjfjByFxRHPM9ijcfB7D/wPcr2jkax1hZXR57QpbsRyq0rJk+i23
	 qwjEf/La3P8vec0d/atF3T7oE2FYgZMCrRy4yM1o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+aaf0488c83d1d5f4f029@syzkaller.appspotmail.com,
	Edward Adam Davis <eadavis@qq.com>,
	Johannes Berg <johannes.berg@intel.com>,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH 6.6 230/290] wifi: cfg80211: init wiphy_work before allocating rfkill fails
Date: Mon, 23 Jun 2025 15:08:11 +0200
Message-ID: <20250623130633.845729710@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.910356556@linuxfoundation.org>
References: <20250623130626.910356556@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Edward Adam Davis <eadavis@qq.com>

commit fc88dee89d7b63eeb17699393eb659aadf9d9b7c upstream.

syzbort reported a uninitialize wiphy_work_lock in cfg80211_dev_free. [1]

After rfkill allocation fails, the wiphy release process will be performed,
which will cause cfg80211_dev_free to access the uninitialized wiphy_work
related data.

Move the initialization of wiphy_work to before rfkill initialization to
avoid this issue.

[1]
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 UID: 0 PID: 5935 Comm: syz-executor550 Not tainted 6.14.0-rc6-syzkaller-00103-g4003c9e78778 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 assign_lock_key kernel/locking/lockdep.c:983 [inline]
 register_lock_class+0xc39/0x1240 kernel/locking/lockdep.c:1297
 __lock_acquire+0x135/0x3c40 kernel/locking/lockdep.c:5103
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5851
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
 cfg80211_dev_free+0x30/0x3d0 net/wireless/core.c:1196
 device_release+0xa1/0x240 drivers/base/core.c:2568
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1e4/0x5a0 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3774
 wiphy_free net/wireless/core.c:1224 [inline]
 wiphy_new_nm+0x1c1f/0x2160 net/wireless/core.c:562
 ieee80211_alloc_hw_nm+0x1b7a/0x2260 net/mac80211/main.c:835
 mac80211_hwsim_new_radio+0x1d6/0x54e0 drivers/net/wireless/virtual/mac80211_hwsim.c:5185
 hwsim_new_radio_nl+0xb42/0x12b0 drivers/net/wireless/virtual/mac80211_hwsim.c:6242
 genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2533
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1312 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1338
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1882
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg net/socket.c:733 [inline]
 ____sys_sendmsg+0xaaf/0xc90 net/socket.c:2573
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2627
 __sys_sendmsg+0x16e/0x220 net/socket.c:2659
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83

Fixes: 72d520476a2f ("wifi: cfg80211: cancel wiphy_work before freeing wiphy")
Reported-by: syzbot+aaf0488c83d1d5f4f029@syzkaller.appspotmail.com
Close: https://syzkaller.appspot.com/bug?extid=aaf0488c83d1d5f4f029
Tested-by: syzbot+aaf0488c83d1d5f4f029@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Link: https://patch.msgid.link/tencent_258DD9121DDDB9DD9A1939CFAA0D8625B107@qq.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/wireless/core.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -550,6 +550,9 @@ use_default_name:
 	INIT_WORK(&rdev->mgmt_registrations_update_wk,
 		  cfg80211_mgmt_registrations_update_wk);
 	spin_lock_init(&rdev->mgmt_registrations_lock);
+	INIT_WORK(&rdev->wiphy_work, cfg80211_wiphy_work);
+	INIT_LIST_HEAD(&rdev->wiphy_work_list);
+	spin_lock_init(&rdev->wiphy_work_lock);
 
 #ifdef CONFIG_CFG80211_DEFAULT_PS
 	rdev->wiphy.flags |= WIPHY_FLAG_PS_ON_BY_DEFAULT;
@@ -567,9 +570,6 @@ use_default_name:
 		return NULL;
 	}
 
-	INIT_WORK(&rdev->wiphy_work, cfg80211_wiphy_work);
-	INIT_LIST_HEAD(&rdev->wiphy_work_list);
-	spin_lock_init(&rdev->wiphy_work_lock);
 	INIT_WORK(&rdev->rfkill_block, cfg80211_rfkill_block_work);
 	INIT_WORK(&rdev->conn_work, cfg80211_conn_work);
 	INIT_WORK(&rdev->event_work, cfg80211_event_work);



