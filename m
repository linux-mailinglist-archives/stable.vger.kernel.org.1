Return-Path: <stable+bounces-65557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7356094A9A0
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 16:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3091A288089
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 14:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD242F3E;
	Wed,  7 Aug 2024 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hk5OEsXK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDFC6A8C1
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039993; cv=none; b=NUKWVJoJicwIqvnIX/bxqBvMhtxjWvOcQuk+dSYrSuJn10HD1lRR1ewjsM6Ydnavf5ZIIYNvxK3x40KX8ZlXbN1DYVLF4JlyWXsdmpJKw7JlN7zzx9DCj7IlWsQBdM4+XEWtY5xT5EaUImbRwd1LUG4VAX0X/dOcJi2qg6/8Rcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039993; c=relaxed/simple;
	bh=Hqpoer5cngR3QDrWa+nBPEkoDsm6HhW7ciDaXZWW+Rs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nCSq8BSTDvEzKJIUYO5fLPN4hU3ZzRAEGOpqcJIc7gQ+YSCojK6llPD4AC292RWmEn37bqWmDSUPiCcUHrSOsI+yM8O6jK9YBS2B39SpihGfUv1nXwx88I2elez1K3ceWaYitAsD6iMwge1ASDE80ug+kti5sc20lGoqbqEAFsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hk5OEsXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57752C4AF0B;
	Wed,  7 Aug 2024 14:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723039992;
	bh=Hqpoer5cngR3QDrWa+nBPEkoDsm6HhW7ciDaXZWW+Rs=;
	h=Subject:To:Cc:From:Date:From;
	b=hk5OEsXKXT7xW4Xu1Jeb74xHFsDe8ESBHhO/TD/LeJsR3XU35UyWER2wwFu+CgpYr
	 /1XcjHZa70jym0j282ssVkeIT9jSQiluz3SxyKu5brABiIowot3lAzjEr+/guLn9XO
	 O/qysYt7hBouqgvjW6SL7Wa2CSqaHmAOiBI/nbbs=
Subject: FAILED: patch "[PATCH] r8169: don't increment tx_dropped in case of NETDEV_TX_BUSY" failed to apply to 4.19-stable tree
To: hkallweit1@gmail.com,kuba@kernel.org,wojciech.drewek@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 07 Aug 2024 16:13:01 +0200
Message-ID: <2024080701-prominent-stoic-81d9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x d516b187a9cc2e842030dd005be2735db3e8f395
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024080701-prominent-stoic-81d9@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

d516b187a9cc ("r8169: don't increment tx_dropped in case of NETDEV_TX_BUSY")
93882c6f210a ("r8169: switch from netif_xxx message functions to netdev_xxx")
b8447abc4c8f ("r8169: factor out rtl8169_tx_map")
2864a883f931 ("r8169: use pci_status_get_and_clear_errors")
90760b21aef4 ("r8169: add PCI_STATUS_PARITY to PCI status error bits")
9020845fb5d6 ("r8169: improve rtl8169_start_xmit")
f1f9ca287569 ("r8169: improve rtl8169_get_mac_version")
a8ec173a3f29 ("r8169: don't set min_mtu/max_mtu if not needed")
2992bdfa4ad2 ("r8169: add r8169.h")
1c5be5e91d78 ("r8169: rename rtl_apply_firmware")
8cecc8f0ae2e ("r8169: change argument type of EEE PHY functions")
becd837eebc5 ("r8169: prepare for exporting rtl_hw_phy_config")
af7797785d61 ("r8169: move enabling EEE to rtl8169_init_phy")
3127f7c9b7da ("r8169: factor out rtl8168h_2_get_adc_bias_ioffset")
229c1e0dfd3d ("r8169: load firmware for RTL8168fp/RTL8117")
718af5bc9709 ("r8169: improve conditional firmware loading for RTL8168d")
d0db136ffb59 ("r8169: use r8168d_modify_extpage in rtl8168f_config_eee_phy")
1287723aa139 ("r8169: add support for RTL8117")
0721914a3d2b ("r8169: add helper r8168d_modify_extpage")
3a129e3f9ac4 ("r8169: switch to phylib functions in more places")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d516b187a9cc2e842030dd005be2735db3e8f395 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Tue, 30 Jul 2024 21:51:52 +0200
Subject: [PATCH] r8169: don't increment tx_dropped in case of NETDEV_TX_BUSY

The skb isn't consumed in case of NETDEV_TX_BUSY, therefore don't
increment the tx_dropped counter.

Fixes: 188f4af04618 ("r8169: use NETDEV_TX_{BUSY/OK}")
Cc: stable@vger.kernel.org
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Link: https://patch.msgid.link/bbba9c48-8bac-4932-9aa1-d2ed63bc9433@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 714d2e804694..3507c2e28110 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4349,7 +4349,8 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
 	if (unlikely(!rtl_tx_slots_avail(tp))) {
 		if (net_ratelimit())
 			netdev_err(dev, "BUG! Tx Ring full when queue awake!\n");
-		goto err_stop_0;
+		netif_stop_queue(dev);
+		return NETDEV_TX_BUSY;
 	}
 
 	opts[1] = rtl8169_tx_vlan_tag(skb);
@@ -4405,11 +4406,6 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
 	dev_kfree_skb_any(skb);
 	dev->stats.tx_dropped++;
 	return NETDEV_TX_OK;
-
-err_stop_0:
-	netif_stop_queue(dev);
-	dev->stats.tx_dropped++;
-	return NETDEV_TX_BUSY;
 }
 
 static unsigned int rtl_last_frag_len(struct sk_buff *skb)


