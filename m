Return-Path: <stable+bounces-174940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56733B365DA
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49B53564715
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1AB27EFE7;
	Tue, 26 Aug 2025 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WjTeArz1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486E5230BDF;
	Tue, 26 Aug 2025 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215718; cv=none; b=RPU/EquRyo8T4ltWr4men2ttOOdYmZZP7bB6t3ygAh9lL6Ete3Ize8B7Wm2zex2ORpl4iLOCHkGJa3XevzhyLf6YXcFchGFv9OU3c+PboTuc1uUXVI9pmBhWbS3qSJt/IfSgPzvqLhYRcrPcoLKA1MnUwkSyGPVky0licx0DYPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215718; c=relaxed/simple;
	bh=zaAsAU5yYolZcGvwMHIH4pGSumLryI8KuwswVkWqDuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9gaDlPjp2pDkjY2R/d3doOtp5yqg+gvUju09thEtJYP0RSI4wvWNr2xfxWI4mlWgkeKLLK1QfVUleUJHvWqTs4qExKI5CZqlaIcrUPKoBqCEktLzWF0I35yhkm0ieGhWfjG2F1KREH7k0KDojrV1V+Po9v8kiemxSgZclBhqjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WjTeArz1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8698C113D0;
	Tue, 26 Aug 2025 13:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756215718;
	bh=zaAsAU5yYolZcGvwMHIH4pGSumLryI8KuwswVkWqDuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WjTeArz1JM06EYVQuo35hOaGumWLlx+HOrP6s8VqW/cfP0xfzWcwdrIFa9Ycl2GYK
	 9deNi4wnzBE43xxTDekUarBIa8ciJfi3HAxAS6Ja4TtncHCciai/Z0uyfSaXnIOsgI
	 llHQviMKnluKM6O16BA3bGK5DgktVyaobLZhKdYY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniil Dulov <d.dulov@aladdin.ru>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 140/644] wifi: rtl818x: Kill URBs before clearing tx status queue
Date: Tue, 26 Aug 2025 13:03:51 +0200
Message-ID: <20250826110949.969091434@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniil Dulov <d.dulov@aladdin.ru>

[ Upstream commit 16d8fd74dbfca0ea58645cd2fca13be10cae3cdd ]

In rtl8187_stop() move the call of usb_kill_anchored_urbs() before clearing
b_tx_status.queue. This change prevents callbacks from using already freed
skb due to anchor was not killed before freeing such skb.

 BUG: kernel NULL pointer dereference, address: 0000000000000080
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0000 [#1] SMP NOPTI
 CPU: 7 UID: 0 PID: 0 Comm: swapper/7 Not tainted 6.15.0 #8 PREEMPT(voluntary)
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
 RIP: 0010:ieee80211_tx_status_irqsafe+0x21/0xc0 [mac80211]
 Call Trace:
  <IRQ>
  rtl8187_tx_cb+0x116/0x150 [rtl8187]
  __usb_hcd_giveback_urb+0x9d/0x120
  usb_giveback_urb_bh+0xbb/0x140
  process_one_work+0x19b/0x3c0
  bh_worker+0x1a7/0x210
  tasklet_action+0x10/0x30
  handle_softirqs+0xf0/0x340
  __irq_exit_rcu+0xcd/0xf0
  common_interrupt+0x85/0xa0
  </IRQ>

Tested on RTL8187BvE device.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c1db52b9d27e ("rtl8187: Use usb anchor facilities to manage urbs")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250617135634.21760-1-d.dulov@aladdin.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
index eb68b2d3caa1..c9df185dc3f4 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
@@ -1041,10 +1041,11 @@ static void rtl8187_stop(struct ieee80211_hw *dev)
 	rtl818x_iowrite8(priv, &priv->map->CONFIG4, reg | RTL818X_CONFIG4_VCOOFF);
 	rtl818x_iowrite8(priv, &priv->map->EEPROM_CMD, RTL818X_EEPROM_CMD_NORMAL);
 
+	usb_kill_anchored_urbs(&priv->anchored);
+
 	while ((skb = skb_dequeue(&priv->b_tx_status.queue)))
 		dev_kfree_skb_any(skb);
 
-	usb_kill_anchored_urbs(&priv->anchored);
 	mutex_unlock(&priv->conf_mutex);
 
 	if (!priv->is_rtl8187b)
-- 
2.39.5




