Return-Path: <stable+bounces-112784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85216A28E6E
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F2357A1B39
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A0F14F9E7;
	Wed,  5 Feb 2025 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jOFCHoj7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FBB1547E9;
	Wed,  5 Feb 2025 14:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738764742; cv=none; b=sQ/IJLSPLRpIeqGCyevlwxE+5BLxIugBRrg609lNPujlruzmEJPH8W7JOWPEEqx71Dcw86YtUVuCQC24hPTXRbLNYKnwkmxSgunSOcMkaGutjt23frqA2kUn2UPV5o3hWtLiQzpWH6KkMaVVsVX63EFYYfN6ghQ/OXun8Yu2Q3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738764742; c=relaxed/simple;
	bh=DBw3ngTaiO4bYcQ6Z9ZI3W1/qQSqLl8TNBvOhokyIFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8/c/fPGPDzBk8SyUOseBEp/KBJ4k4fT9WM+O1zn7AIaophcN56WIQ3UjPWvyXRi1ExKzVtxmxymdg4dTgFoeY5eTfybPupb/fduugxLmUcniAFbhDxYUlj2sBB0h8nCHZk7DXd2W1bRFHYIoia86iSxdAsd/kQ+lYmFZoJnFNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jOFCHoj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2598C4CED1;
	Wed,  5 Feb 2025 14:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738764741;
	bh=DBw3ngTaiO4bYcQ6Z9ZI3W1/qQSqLl8TNBvOhokyIFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jOFCHoj70aJLZHRhCf1KQ5o5Vwivu0A+BP7d5wDOrTCgrTVmHu5G7GM/LQxZ6Rv0K
	 UlpNM7YItwEBml98MuEGs9e5ndJSU7gDbBdmOu0DjGyMVLChHk0pw9fYIanA1ItLA1
	 qk50AhsGd2z9qgyvVvitBo6+F0KWvubvClnGO7d0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 154/590] wifi: rtw89: fix race between cancel_hw_scan and hw_scan completion
Date: Wed,  5 Feb 2025 14:38:29 +0100
Message-ID: <20250205134501.177445354@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit ba4bb0402c60e945c4c396c51f0acac3c3e3ea5c ]

The rtwdev->scanning flag isn't protected by mutex originally, so
cancel_hw_scan can pass the condition, but suddenly hw_scan completion
unset the flag and calls ieee80211_scan_completed() that will free
local->hw_scan_req. Then, cancel_hw_scan raises null-ptr-deref and
use-after-free. Fix it by moving the check condition to where
protected by mutex.

 KASAN: null-ptr-deref in range [0x0000000000000088-0x000000000000008f]
 CPU: 2 PID: 6922 Comm: kworker/2:2 Tainted: G           OE
 Hardware name: LENOVO 2356AD1/2356AD1, BIOS G7ETB6WW (2.76 ) 09/10/2019
 Workqueue: events cfg80211_conn_work [cfg80211]
 RIP: 0010:rtw89_fw_h2c_scan_offload_be+0xc33/0x13c3 [rtw89_core]
 Code: 00 45 89 6c 24 1c 0f 85 23 01 00 00 48 8b 85 20 ff ff ff 48 8d
 RSP: 0018:ffff88811fd9f068 EFLAGS: 00010206
 RAX: dffffc0000000000 RBX: ffff88811fd9f258 RCX: 0000000000000001
 RDX: 0000000000000011 RSI: 0000000000000001 RDI: 0000000000000089
 RBP: ffff88811fd9f170 R08: 0000000000000000 R09: 0000000000000000
 R10: ffff88811fd9f108 R11: 0000000000000000 R12: ffff88810e47f960
 R13: 0000000000000000 R14: 000000000000ffff R15: 0000000000000000
 FS:  0000000000000000(0000) GS:ffff8881d6f00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007531dfca55b0 CR3: 00000001be296004 CR4: 00000000001706e0
 Call Trace:
  <TASK>
  ? show_regs+0x61/0x73
  ? __die_body+0x20/0x73
  ? die_addr+0x4f/0x7b
  ? exc_general_protection+0x191/0x1db
  ? asm_exc_general_protection+0x27/0x30
  ? rtw89_fw_h2c_scan_offload_be+0xc33/0x13c3 [rtw89_core]
  ? rtw89_fw_h2c_scan_offload_be+0x458/0x13c3 [rtw89_core]
  ? __pfx_rtw89_fw_h2c_scan_offload_be+0x10/0x10 [rtw89_core]
  ? do_raw_spin_lock+0x75/0xdb
  ? __pfx_do_raw_spin_lock+0x10/0x10
  rtw89_hw_scan_offload+0xb5e/0xbf7 [rtw89_core]
  ? _raw_spin_unlock+0xe/0x24
  ? __mutex_lock.constprop.0+0x40c/0x471
  ? __pfx_rtw89_hw_scan_offload+0x10/0x10 [rtw89_core]
  ? __mutex_lock_slowpath+0x13/0x1f
  ? mutex_lock+0xa2/0xdc
  ? __pfx_mutex_lock+0x10/0x10
  rtw89_hw_scan_abort+0x58/0xb7 [rtw89_core]
  rtw89_ops_cancel_hw_scan+0x120/0x13b [rtw89_core]
  ieee80211_scan_cancel+0x468/0x4d0 [mac80211]
  ieee80211_prep_connection+0x858/0x899 [mac80211]
  ieee80211_mgd_auth+0xbea/0xdde [mac80211]
  ? __pfx_ieee80211_mgd_auth+0x10/0x10 [mac80211]
  ? cfg80211_find_elem+0x15/0x29 [cfg80211]
  ? is_bss+0x1b7/0x1d7 [cfg80211]
  ieee80211_auth+0x18/0x27 [mac80211]
  cfg80211_mlme_auth+0x3bb/0x3e7 [cfg80211]
  cfg80211_conn_do_work+0x410/0xb81 [cfg80211]
  ? __pfx_cfg80211_conn_do_work+0x10/0x10 [cfg80211]
  ? __kasan_check_read+0x11/0x1f
  ? psi_group_change+0x8bc/0x944
  ? __kasan_check_write+0x14/0x22
  ? mutex_lock+0x8e/0xdc
  ? __pfx_mutex_lock+0x10/0x10
  ? __pfx___radix_tree_lookup+0x10/0x10
  cfg80211_conn_work+0x245/0x34d [cfg80211]
  ? __pfx_cfg80211_conn_work+0x10/0x10 [cfg80211]
  ? update_cfs_rq_load_avg+0x3bc/0x3d7
  ? sched_clock_noinstr+0x9/0x1a
  ? sched_clock+0x10/0x24
  ? sched_clock_cpu+0x7e/0x42e
  ? newidle_balance+0x796/0x937
  ? __pfx_sched_clock_cpu+0x10/0x10
  ? __pfx_newidle_balance+0x10/0x10
  ? __kasan_check_read+0x11/0x1f
  ? psi_group_change+0x8bc/0x944
  ? _raw_spin_unlock+0xe/0x24
  ? raw_spin_rq_unlock+0x47/0x54
  ? raw_spin_rq_unlock_irq+0x9/0x1f
  ? finish_task_switch.isra.0+0x347/0x586
  ? __schedule+0x27bf/0x2892
  ? mutex_unlock+0x80/0xd0
  ? do_raw_spin_lock+0x75/0xdb
  ? __pfx___schedule+0x10/0x10
  process_scheduled_works+0x58c/0x821
  worker_thread+0x4c7/0x586
  ? __kasan_check_read+0x11/0x1f
  kthread+0x285/0x294
  ? __pfx_worker_thread+0x10/0x10
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x29/0x6f
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1b/0x30
  </TASK>

Fixes: 895907779752 ("rtw89: 8852a: add ieee80211_ops::hw_scan")
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250107114254.6769-1-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/mac80211.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index a04717b847a0f..8351a70d325d4 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -1273,11 +1273,11 @@ static void rtw89_ops_cancel_hw_scan(struct ieee80211_hw *hw,
 	if (!RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw))
 		return;
 
-	if (!rtwdev->scanning)
-		return;
-
 	mutex_lock(&rtwdev->mutex);
 
+	if (!rtwdev->scanning)
+		goto out;
+
 	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
 	if (unlikely(!rtwvif_link)) {
 		rtw89_err(rtwdev, "cancel hw scan: find no link on HW-0\n");
-- 
2.39.5




