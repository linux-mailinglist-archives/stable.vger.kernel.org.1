Return-Path: <stable+bounces-112778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B850A28E60
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE4E3A1E3C
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171AC149C53;
	Wed,  5 Feb 2025 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gaCRrUXZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71B515198D;
	Wed,  5 Feb 2025 14:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738764720; cv=none; b=IsjZQyztBdBAi9heBVd7psLlE7CTgmT/X180UrwEn9MHanF8QzHzh1ObYjVKyP665+JUdb7bfzQcexKgc4q35TBxcD3T3sX2LJrGkpqKfvDdo1Y8DqS2yLKNFJjhMP5/WoYd7zTiDZ3J+S02Y7V9OjyguDHv3ZdIHXENSipJAmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738764720; c=relaxed/simple;
	bh=Vl+g3A6yDTqZaMlv8BsZ1y2RuJsiiYvGlQCZ5v0rv3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjZyLAKoOe64rMBl6KSAQVtaS7leo4E7QQXMsbWizr79eAf7aeniaWBRDggKTLiqQMhJfyr/rwGiQ5tiPb8AxckPAPsU2Iv0iDkHYym9q0xJh22fysxFXOLoKalHbYj7AoDxTKQveovW/vU+Wq0ZA5vGy2VJdR9agv1plj6OkcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gaCRrUXZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3747CC4CED1;
	Wed,  5 Feb 2025 14:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738764720;
	bh=Vl+g3A6yDTqZaMlv8BsZ1y2RuJsiiYvGlQCZ5v0rv3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gaCRrUXZwNB0ApbHRaZw3fTF6QNKXcKiz0onFGJkoLiZ6scQchwWxer+kAPL0R6yF
	 L74DsPfns394Kume3FUlzxsdWs0ii/JSVljq3it32+pBA6VX/Og0kzZn38w5JpYlCm
	 uUIo5iR8hAWtbSDLw/FnLd2QDajll3Kj99M7Vjio=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chih-Kang Chang <gary.chang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 152/590] wifi: rtw89: avoid to init mgnt_entry list twice when WoWLAN failed
Date: Wed,  5 Feb 2025 14:38:27 +0100
Message-ID: <20250205134501.097759479@linuxfoundation.org>
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

From: Chih-Kang Chang <gary.chang@realtek.com>

[ Upstream commit 2f7667675df1b40b73ecc53b4b8c3189b1e5f2c1 ]

If WoWLAN failed in resume flow, the rtw89_ops_add_interface() triggered
without removing the interface first. Then the mgnt_entry list init again,
causing the list_empty() check in rtw89_chanctx_ops_assign_vif()
useless, and list_add_tail() again. Therefore, we have added a check to
prevent double adding of the list.

rtw89_8852ce 0000:01:00.0: failed to check wow status disabled
rtw89_8852ce 0000:01:00.0: wow: failed to check disable fw ready
rtw89_8852ce 0000:01:00.0: wow: failed to swap to normal fw
rtw89_8852ce 0000:01:00.0: failed to disable wow
rtw89_8852ce 0000:01:00.0: failed to resume for wow -110
rtw89_8852ce 0000:01:00.0: MAC has already powered on
i2c_hid_acpi i2c-ILTK0001:00: PM: acpi_subsys_resume+0x0/0x60 returned 0 after 284705 usecs
list_add corruption. prev->next should be next (ffff9d9719d82228), but was ffff9d9719f96030. (prev=ffff9d9719f96030).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:34!
invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
CPU: 2 PID: 6918 Comm: kworker/u8:19 Tainted: G     U     O
Hardware name: Google Anraggar/Anraggar, BIOS Google_Anraggar.15217.514.0 03/25/2024
Workqueue: events_unbound async_run_entry_fn
RIP: 0010:__list_add_valid_or_report+0x9f/0xb0
Code: e8 56 89 ff ff 0f 0b 48 c7 c7 3e fc e0 96 48 89 c6 e8 45 89 ff ...
RSP: 0018:ffffa51b42bbbaf0 EFLAGS: 00010246
RAX: 0000000000000075 RBX: ffff9d9719d82ab0 RCX: 13acb86e047a4400
RDX: 3fffffffffffffff RSI: 0000000000000000 RDI: 00000000ffffdfff
RBP: ffffa51b42bbbb28 R08: ffffffff9768e250 R09: 0000000000001fff
R10: ffffffff9765e250 R11: 0000000000005ffd R12: ffff9d9719f95c40
R13: ffff9d9719f95be8 R14: ffff9d97081bfd78 R15: ffff9d9719d82060
FS:  0000000000000000(0000) GS:ffff9d9a6fb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007e7d029a4060 CR3: 0000000345e38000 CR4: 0000000000750ee0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __die_body+0x68/0xb0
 ? die+0xaa/0xd0
 ? do_trap+0x9f/0x170
 ? __list_add_valid_or_report+0x9f/0xb0
 ? __list_add_valid_or_report+0x9f/0xb0
 ? handle_invalid_op+0x69/0x90
 ? __list_add_valid_or_report+0x9f/0xb0
 ? exc_invalid_op+0x3c/0x50
 ? asm_exc_invalid_op+0x16/0x20
 ? __list_add_valid_or_report+0x9f/0xb0
 rtw89_chanctx_ops_assign_vif+0x1f9/0x210 [rtw89_core cbb375c44bf28564ce479002bff66617a25d9ac1]
 ? __mutex_unlock_slowpath+0xa0/0xf0
 rtw89_ops_assign_vif_chanctx+0x4b/0x90 [rtw89_core cbb375c44bf28564ce479002bff66617a25d9ac1]
 drv_assign_vif_chanctx+0xa7/0x1f0 [mac80211 6efaad16237edaaea0868b132d4f93ecf918a8b6]
 ieee80211_reconfig+0x9cb/0x17b0 [mac80211 6efaad16237edaaea0868b132d4f93ecf918a8b6]
 ? __pfx_wiphy_resume+0x10/0x10 [cfg80211 572d03acaaa933fe38251be7fce3b3675284b8ed]
 ? dev_printk_emit+0x51/0x70
 ? _dev_info+0x6e/0x90
 wiphy_resume+0x89/0x180 [cfg80211 572d03acaaa933fe38251be7fce3b3675284b8ed]
 ? __pfx_wiphy_resume+0x10/0x10 [cfg80211 572d03acaaa933fe38251be7fce3b3675284b8ed]
 dpm_run_callback+0x37/0x1e0
 device_resume+0x26d/0x4b0
 ? __pfx_dpm_watchdog_handler+0x10/0x10
 async_resume+0x1d/0x30
 async_run_entry_fn+0x29/0xd0
 worker_thread+0x397/0x970
 kthread+0xed/0x110
 ? __pfx_worker_thread+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x38/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>

Fixes: 68ec751b2881 ("wifi: rtw89: chan: manage active interfaces")
Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250103024500.14990-1-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/mac80211.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 299566e2f612d..a04717b847a0f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -189,10 +189,10 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 
 	rtw89_core_txq_init(rtwdev, vif->txq);
 
-	if (!rtw89_rtwvif_in_list(rtwdev, rtwvif))
+	if (!rtw89_rtwvif_in_list(rtwdev, rtwvif)) {
 		list_add_tail(&rtwvif->list, &rtwdev->rtwvifs_list);
-
-	INIT_LIST_HEAD(&rtwvif->mgnt_entry);
+		INIT_LIST_HEAD(&rtwvif->mgnt_entry);
+	}
 
 	ether_addr_copy(rtwvif->mac_addr, vif->addr);
 
-- 
2.39.5




