Return-Path: <stable+bounces-136575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E75A9ADDC
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 14:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD6D465A7B
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 12:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBCF27B500;
	Thu, 24 Apr 2025 12:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triops.cz header.i=@triops.cz header.b="ADwtGcQ/";
	dkim=pass (2048-bit key) header.d=triops.cz header.i=@triops.cz header.b="ADwtGcQ/"
X-Original-To: stable@vger.kernel.org
Received: from h4.cmg1.smtp.forpsi.com (h4.cmg1.smtp.forpsi.com [185.129.138.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0462701AA
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 12:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.129.138.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498834; cv=none; b=UemO43Qe5XJAUQnwY/6KUuhJQvVLwv9tyPMcc0DBObmX2Hx5Reoi4nNFUMI+xqRk2hcQoOJhy7kcrSf2ep1YPKSyjE9/eBFYFZLnDcFKwvyXMp2h8tgMZoK+GH82v/SJSjvV7Proc4KRIM0TRUBV+e5ruDAM4p2kNeYTb6Iefqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498834; c=relaxed/simple;
	bh=bEdSoFx4PHOKfvfjUOSX3nVIfRBSu8CmdD47wcyLmLM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=abCviFbX84kArbAiVo3k7+m+IUqiZCIdsKKTOS0C2XgfGuWVGtw87B4jSOdOE11tFm8WMiMdzbfG8SmQEspUsR43dfkWFnzXVVBhikGNLwF7TWiYmyBeRc81pgyur978h6U4Z9/DUu9OBnQmFIRndA83vPmmNGZjEsv3XiLWB4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=triops.cz; spf=none smtp.mailfrom=triops.cz; dkim=pass (2048-bit key) header.d=triops.cz header.i=@triops.cz header.b=ADwtGcQ/; dkim=pass (2048-bit key) header.d=triops.cz header.i=@triops.cz header.b=ADwtGcQ/; arc=none smtp.client-ip=185.129.138.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=triops.cz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=triops.cz
Received: from lenoch ([91.218.190.200])
	by cmgsmtp with ESMTPSA
	id 7vqeuJqpjwQNX7vqfuy26g; Thu, 24 Apr 2025 14:38:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triops.cz; s=f2019;
	t=1745498318; bh=30ztKxeDwCPMH8hXr6tldCgP3V9BMgV+5j8xTPnp8KI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	b=ADwtGcQ/2yIxzRNJrjoZ97s+YDoASZVBvWzTQeuIbeRRA75xjzQLjqTOdofL6HOzJ
	 TGkszQ2Q1Y+yuL/D9hcj6cYrvi4WEsSEtmClZUs3lUZYpcY18xU8r+msKvWQ4sKUgh
	 apjW7sTtC4Be2ZOQLQPYjGSS5jDUaf/MN1x2NvWzKHmqWKUbo4LVW/uS3/DI8wkRC+
	 0laaDf6HBNmU0logA4GeI8RfadI4sMw5aw0qw5gu1A65yFEN70n2ha3bkWCP+quJ0p
	 DejTANltITto1uCdiUreGUNP321OMiPOqaSWqGCnCRpsmVc6647R9n8WlYsvKzM9qP
	 Kwv+8gYxaTSCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triops.cz; s=f2019;
	t=1745498318; bh=30ztKxeDwCPMH8hXr6tldCgP3V9BMgV+5j8xTPnp8KI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	b=ADwtGcQ/2yIxzRNJrjoZ97s+YDoASZVBvWzTQeuIbeRRA75xjzQLjqTOdofL6HOzJ
	 TGkszQ2Q1Y+yuL/D9hcj6cYrvi4WEsSEtmClZUs3lUZYpcY18xU8r+msKvWQ4sKUgh
	 apjW7sTtC4Be2ZOQLQPYjGSS5jDUaf/MN1x2NvWzKHmqWKUbo4LVW/uS3/DI8wkRC+
	 0laaDf6HBNmU0logA4GeI8RfadI4sMw5aw0qw5gu1A65yFEN70n2ha3bkWCP+quJ0p
	 DejTANltITto1uCdiUreGUNP321OMiPOqaSWqGCnCRpsmVc6647R9n8WlYsvKzM9qP
	 Kwv+8gYxaTSCg==
Date: Thu, 24 Apr 2025 14:38:35 +0200
From: Ladislav Michl <oss-lists@triops.cz>
To: stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH] wifi: rtw88: use ieee80211_purge_tx_queue() to purge TX skb
Message-ID: <aAowy1C3tCewoMDT@lenoch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CMAE-Envelope: MS4xfBWow4t25fdfpLPciJ8z3ke82YzLo5W+mUP1F7InXuXiPGADql2fTq+PHb1vEgP399+99KM9LdbX5epCUzYvtRxFax1wPjOUpfQXRuMtaainkDq11KFU
 XUAtTtpubItC87Esk9ScYp+0AH9n2PmwfV2pnvkKx9jL8uwA/0iOLqQXynrzTDT3xT5OuUDS6DL99V1nJnXrJSbfXdd0YoZCXr4=

From: Ladislav Michl <ladis@triops.cz>

corresponding upstream commit 3e5e4a801aaf4283390cc34959c6c48f910ca5ea

When removing kernel modules driver uses skb_queue_purge() to purge TX skb,
but not report tx status causing "Have pending ack frames!" warning.
Use ieee80211_purge_tx_queue() to correct this.

As upstream commit mentioned above does not apply on linux-6.1.y tree
it has been rewritten.

  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 4072 at net/mac80211/main.c:1506 ieee80211_free_ack_frame+0x74/0xa0 [mac80211]
  Have pending ack frames!
  Modules linked in: rtw88_8822ce rtw88_8822c rtw88_pci rtw88_core mac80211 libarc4 cfg80211 qmi_wwan usbnet mii cdc_acm [last unloaded: cfg80211]
  CPU: 0 PID: 4072 Comm: sh Not tainted 6.1.104 #2
  Stack : 0000000000000000 000000000000068d 0000000000000008 000b24caa995d315
          000b24caa995d315 0000000000000000 8000000002813958 ffffffff818f4a30
          ffffffff81a673c8 0000000000000001 0000000000000001 0000000000000000
          00000000000817bd 0000000000000010 ffffffff817f3720 0000000000000002
          800000000281384f ffffffff81a20000 ffffffff818f4a30 0000000000000009
          ffffffff81a20000 8000000003a41df8 ffffffff81a20000 0000000000000001
          8000000002651570 8000000082813847 ffffffff8143a6c0 0000000000000000
          ffffffff81b10000 8000000002810000 8000000002813950 0000000000000030
          ffffffff817ca460 0000000000000000 ffffffff818f4a30 ffffffff817ca3e0
          0000000000000001 ffffffff818f4a30 ffffffff811198b8 0000000000000000
        ...
  Call Trace:
  [<ffffffff811198b8>] show_stack+0x38/0x118
  [<ffffffff817ca460>] dump_stack_lvl+0x30/0x54
  [<ffffffff81130f6c>] __warn+0x9c/0xe4
  [<ffffffff81131054>] warn_slowpath_fmt+0xa0/0xd4
  [<ffffffffc02770ec>] ieee80211_free_ack_frame+0x74/0xa0 [mac80211]
  [<ffffffff817ccfd8>] idr_for_each+0x88/0x150
  [<ffffffffc0277538>] ieee80211_free_hw+0x48/0xf8 [mac80211]
  [<ffffffff813f2a54>] pci_device_remove+0x2c/0x78
  [<ffffffff8144c7dc>] device_release_driver_internal+0x1e4/0x288
  [<ffffffff813e8998>] pci_stop_bus_device+0x88/0xb8
  [<ffffffff813e8a84>] pci_stop_and_remove_bus_device_locked+0x1c/0x38
  [<ffffffff813f52d0>] remove_store+0xa0/0xb0
  [<ffffffff81279be4>] kernfs_fop_write_iter+0x10c/0x230
  [<ffffffff811fc49c>] vfs_write+0x1cc/0x388
  [<ffffffff811fc7f8>] ksys_write+0x78/0x120
  [<ffffffff81121420>] syscall_common+0x34/0x58
  ---[ end trace 0000000000000000 ]---

Cc: stable@vger.kernel.org # 6.1.x: 53bc1b7: wifi: mac80211: export ieee80211_purge_tx_queue() for drivers
Cc: stable@vger.kernel.org # 6.1.x
Cc: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ladislav Michl <ladis@triops.cz>
---
 drivers/net/wireless/realtek/rtw88/main.c | 2 +-
 drivers/net/wireless/realtek/rtw88/tx.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 4620a0d5c77b..7c390c2c608d 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -2146,7 +2146,7 @@ void rtw_core_deinit(struct rtw_dev *rtwdev)
 
 	destroy_workqueue(rtwdev->tx_wq);
 	spin_lock_irqsave(&rtwdev->tx_report.q_lock, flags);
-	skb_queue_purge(&rtwdev->tx_report.queue);
+	ieee80211_purge_tx_queue(rtwdev->hw, &rtwdev->tx_report.queue);
 	skb_queue_purge(&rtwdev->coex.queue);
 	spin_unlock_irqrestore(&rtwdev->tx_report.q_lock, flags);
 
diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index ab39245e9c2f..05e6911a4044 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -169,7 +169,7 @@ void rtw_tx_report_purge_timer(struct timer_list *t)
 	rtw_warn(rtwdev, "failed to get tx report from firmware\n");
 
 	spin_lock_irqsave(&tx_report->q_lock, flags);
-	skb_queue_purge(&tx_report->queue);
+	ieee80211_purge_tx_queue(rtwdev->hw, &tx_report->queue);
 	spin_unlock_irqrestore(&tx_report->q_lock, flags);
 }
 
-- 
2.39.5


