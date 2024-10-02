Return-Path: <stable+bounces-78728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4112A98D4A8
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B381C217B3
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29071CFEBA;
	Wed,  2 Oct 2024 13:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tz3OUYIy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922F416F84F;
	Wed,  2 Oct 2024 13:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875353; cv=none; b=LHNyigP1FF6/4W4+YsvPgaOwIGEV0nReRBWvSWbGjyIu+d1lf82FKCMaooG8MSiGiMVffGg63H9NppIsUf6qjiiedxfvOS479morIImyNwu0rzNg3s4n/hOXgjjo26zpdPIbio8/du/GcvT7UjaC7hLe4olHKZhgGc+RCZUkJho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875353; c=relaxed/simple;
	bh=B8SHtczI8yepVXzmKuzm1d6hV/LwRpdH8+9d2U+TATY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KyN6zZJeeg/VZoTYqCi24Z+aS6GetEOepgFgctxoalxOuiUcZrv5tCJOYxBZxzZWP6A0tk4iGQIBm6/1uLCLq+FUWU5oZIw4HqvfSIoRKETA4V7Fpy34mS1t5LUSPoya9/p+OTV0LQi0kMGTkye8rzgG3Y6yS0XP/7FWACXCX20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tz3OUYIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8F5C4CEC5;
	Wed,  2 Oct 2024 13:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727875353;
	bh=B8SHtczI8yepVXzmKuzm1d6hV/LwRpdH8+9d2U+TATY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tz3OUYIyWKwTapvjnNPy2S16o6afrvKn07wd+YDhyNiYGtSlBmfO+NWdpqOrPYrGH
	 //X2MEY5c8C7cck1ztAwJNs51oRVOlmw6dn1FEItmgnLG+14Ag+L0No3Y7KYgEIXNC
	 CaaQRXy7vyVA4peidvXwoICQOltNKxhpSQ2LRTLY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 073/695] wifi: mt76: mt7915: fix oops on non-dbdc mt7986
Date: Wed,  2 Oct 2024 14:51:11 +0200
Message-ID: <20241002125825.397085886@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjørn Mork <bjorn@mork.no>

[ Upstream commit 862bf7cbd772c2bad570ef0c5b5556a1330656dd ]

mt7915_band_config() sets band_idx = 1 on the main phy for mt7986
with MT7975_ONE_ADIE or MT7976_ONE_ADIE.

Commit 0335c034e726 ("wifi: mt76: fix race condition related to
checking tx queue fill status") introduced a dereference of the
phys array indirectly indexed by band_idx via wcid->phy_idx in
mt76_wcid_cleanup(). This caused the following Oops on affected
mt7986 devices:

 Unable to handle kernel read from unreadable memory at virtual address 0000000000000024
 Mem abort info:
   ESR = 0x0000000096000005
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x05: level 1 translation fault
 Data abort info:
   ISV = 0, ISS = 0x00000005
   CM = 0, WnR = 0
 user pgtable: 4k pages, 39-bit VAs, pgdp=0000000042545000
 [0000000000000024] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
 Internal error: Oops: 0000000096000005 [#1] SMP
 Modules linked in: ... mt7915e mt76_connac_lib mt76 mac80211 cfg80211 ...
 CPU: 2 PID: 1631 Comm: hostapd Not tainted 5.15.150 #0
 Hardware name: ZyXEL EX5700 (Telenor) (DT)
 pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : mt76_wcid_cleanup+0x84/0x22c [mt76]
 lr : mt76_wcid_cleanup+0x64/0x22c [mt76]
 sp : ffffffc00a803700
 x29: ffffffc00a803700 x28: ffffff80008f7300 x27: ffffff80003f3c00
 x26: ffffff80000a7880 x25: ffffffc008c26e00 x24: 0000000000000001
 x23: ffffffc000a68114 x22: 0000000000000000 x21: ffffff8004172cc8
 x20: ffffffc00a803748 x19: ffffff8004152020 x18: 0000000000000000
 x17: 00000000000017c0 x16: ffffffc008ef5000 x15: 0000000000000be0
 x14: ffffff8004172e28 x13: ffffff8004172e28 x12: 0000000000000000
 x11: 0000000000000000 x10: ffffff8004172e30 x9 : ffffff8004172e28
 x8 : 0000000000000000 x7 : ffffff8004156020 x6 : 0000000000000000
 x5 : 0000000000000031 x4 : 0000000000000000 x3 : 0000000000000001
 x2 : 0000000000000000 x1 : ffffff80008f7300 x0 : 0000000000000024
 Call trace:
  mt76_wcid_cleanup+0x84/0x22c [mt76]
  __mt76_sta_remove+0x70/0xbc [mt76]
  mt76_sta_state+0x8c/0x1a4 [mt76]
  mt7915_eeprom_get_power_delta+0x11e4/0x23a0 [mt7915e]
  drv_sta_state+0x144/0x274 [mac80211]
  sta_info_move_state+0x1cc/0x2a4 [mac80211]
  sta_set_sinfo+0xaf8/0xc24 [mac80211]
  sta_info_destroy_addr_bss+0x4c/0x6c [mac80211]

  ieee80211_color_change_finish+0x1c08/0x1e70 [mac80211]
  cfg80211_check_station_change+0x1360/0x4710 [cfg80211]
  genl_family_rcv_msg_doit+0xb4/0x110
  genl_rcv_msg+0xd0/0x1bc
  netlink_rcv_skb+0x58/0x120
  genl_rcv+0x34/0x50
  netlink_unicast+0x1f0/0x2ec
  netlink_sendmsg+0x198/0x3d0
  ____sys_sendmsg+0x1b0/0x210
  ___sys_sendmsg+0x80/0xf0
  __sys_sendmsg+0x44/0xa0
  __arm64_sys_sendmsg+0x20/0x30
  invoke_syscall.constprop.0+0x4c/0xe0
  do_el0_svc+0x40/0xd0
  el0_svc+0x14/0x4c
  el0t_64_sync_handler+0x100/0x110
  el0t_64_sync+0x15c/0x160
 Code: d2800002 910092c0 52800023 f9800011 (885f7c01)
 ---[ end trace 7e42dd9a39ed2281 ]---

Fix by using mt76_dev_phy() which will map band_idx to the correct phy
for all hardware combinations.

Fixes: 0335c034e726 ("wifi: mt76: fix race condition related to checking tx queue fill status")
Link: https://github.com/openwrt/openwrt/issues/14548
Signed-off-by: Bjørn Mork <bjorn@mork.no>
Link: https://patch.msgid.link/20240713130010.516037-1-bjorn@mork.no
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index bb291fe314fb4..d96ee759828ed 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1529,7 +1529,7 @@ EXPORT_SYMBOL_GPL(mt76_wcid_init);
 
 void mt76_wcid_cleanup(struct mt76_dev *dev, struct mt76_wcid *wcid)
 {
-	struct mt76_phy *phy = dev->phys[wcid->phy_idx];
+	struct mt76_phy *phy = mt76_dev_phy(dev, wcid->phy_idx);
 	struct ieee80211_hw *hw;
 	struct sk_buff_head list;
 	struct sk_buff *skb;
-- 
2.43.0




