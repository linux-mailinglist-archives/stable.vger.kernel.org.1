Return-Path: <stable+bounces-90140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C579BE6E3
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5BEA1F28090
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A3F1DEFF4;
	Wed,  6 Nov 2024 12:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EGHfJ/Ge"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B151DF24E;
	Wed,  6 Nov 2024 12:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894892; cv=none; b=DpF5e7xHk5b4XhmABrz0I1MdrcHpbW3kArvoIInesMqiSeg2XQAE59XhSoA/YHkaGXKAFYC2f/DPRk269zCSVCPpt6pVks8/qTPvI9hXOwFos6/HkbUz3QOADKPQ0wsE+rIPLRI0taP1kq9+WnkaDe7o2Wl4V8iyAxCrIoI2t60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894892; c=relaxed/simple;
	bh=1j0FbNtYGZic4dXTBRjkpMoON2cm8L1VZXjvaDjs9k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pumOzF2mqfk5L2qKQxfUNubP18+vzumLv7xEkRPKZNSGosX4JnYY5VXoqK8upG0xL4VZwU4g9nAt1/oa6uM7ManWt5Vwtmwk/pXoZbVCrUmREE5tp6DMJuWWc+Z2p0TSZ57a04Q9+Lh7MsC6rB+FubjIxsy6gcqwTeN5F7TpIN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EGHfJ/Ge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B08C4CECD;
	Wed,  6 Nov 2024 12:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730894891;
	bh=1j0FbNtYGZic4dXTBRjkpMoON2cm8L1VZXjvaDjs9k8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EGHfJ/Ge0cyTlkEBDhP18Q2t9YbvTdPoFVrdomygZ3WPUTxXXpvka3to7IIDZ12Ys
	 QaAj/lIZEnf2F1G0Sd6wod9poYzAedofZEZtq7xyeoLe7HQxfT0X0uLRy9I0QrLxW9
	 2NAw4M96z3Zjz1oEVyvJzNXIDlkoaqFWtABb3J9I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+1a3986bbd3169c307819@syzkaller.appspotmail.com,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 034/350] wifi: mac80211: use two-phase skb reclamation in ieee80211_do_stop()
Date: Wed,  6 Nov 2024 12:59:22 +0100
Message-ID: <20241106120321.724391616@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120320.865793091@linuxfoundation.org>
References: <20241106120320.865793091@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit 9d301de12da6e1bb069a9835c38359b8e8135121 ]

Since '__dev_queue_xmit()' should be called with interrupts enabled,
the following backtrace:

ieee80211_do_stop()
 ...
 spin_lock_irqsave(&local->queue_stop_reason_lock, flags)
 ...
 ieee80211_free_txskb()
  ieee80211_report_used_skb()
   ieee80211_report_ack_skb()
    cfg80211_mgmt_tx_status_ext()
     nl80211_frame_tx_status()
      genlmsg_multicast_netns()
       genlmsg_multicast_netns_filtered()
        nlmsg_multicast_filtered()
	 netlink_broadcast_filtered()
	  do_one_broadcast()
	   netlink_broadcast_deliver()
	    __netlink_sendskb()
	     netlink_deliver_tap()
	      __netlink_deliver_tap_skb()
	       dev_queue_xmit()
	        __dev_queue_xmit() ; with IRQS disabled
 ...
 spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags)

issues the warning (as reported by syzbot reproducer):

WARNING: CPU: 2 PID: 5128 at kernel/softirq.c:362 __local_bh_enable_ip+0xc3/0x120

Fix this by implementing a two-phase skb reclamation in
'ieee80211_do_stop()', where actual work is performed
outside of a section with interrupts disabled.

Fixes: 5061b0c2b906 ("mac80211: cooperate more with network namespaces")
Reported-by: syzbot+1a3986bbd3169c307819@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1a3986bbd3169c307819
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Link: https://patch.msgid.link/20240906123151.351647-1-dmantipov@yandex.ru
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/iface.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 358028a09ce4d..433083cc15331 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -798,6 +798,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_local *local = sdata->local;
 	unsigned long flags;
+	struct sk_buff_head freeq;
 	struct sk_buff *skb, *tmp;
 	u32 hw_reconf_flags = 0;
 	int i, flushed;
@@ -996,18 +997,32 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata,
 		skb_queue_purge(&sdata->skb_queue);
 	}
 
+	/*
+	 * Since ieee80211_free_txskb() may issue __dev_queue_xmit()
+	 * which should be called with interrupts enabled, reclamation
+	 * is done in two phases:
+	 */
+	__skb_queue_head_init(&freeq);
+
+	/* unlink from local queues... */
 	spin_lock_irqsave(&local->queue_stop_reason_lock, flags);
 	for (i = 0; i < IEEE80211_MAX_QUEUES; i++) {
 		skb_queue_walk_safe(&local->pending[i], skb, tmp) {
 			struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 			if (info->control.vif == &sdata->vif) {
 				__skb_unlink(skb, &local->pending[i]);
-				ieee80211_free_txskb(&local->hw, skb);
+				__skb_queue_tail(&freeq, skb);
 			}
 		}
 	}
 	spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);
 
+	/* ... and perform actual reclamation with interrupts enabled. */
+	skb_queue_walk_safe(&freeq, skb, tmp) {
+		__skb_unlink(skb, &freeq);
+		ieee80211_free_txskb(&local->hw, skb);
+	}
+
 	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 		ieee80211_txq_remove_vlan(local, sdata);
 
-- 
2.43.0




