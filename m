Return-Path: <stable+bounces-251989-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MisC979DWok5QUAu9opvQ
	(envelope-from <stable+bounces-251989-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:30:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4F2596682
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 685C135F326A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846AD3F39C9;
	Wed, 20 May 2026 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bf+ZZBMi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDFE2F363F;
	Wed, 20 May 2026 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299454; cv=none; b=BitSxTMBJkG0Qtx82oxGJwYai4uNKVwLZHv2d9+vdvgi3odeyLhUwDzbf2c8sj39KTx1L1xYUodi6G3YB9FMkgXGaaMtLyynYLX2FsGYNaAwszkqU+FBLXsxPD6osVT4AMLIcatZoAMwtA1fMMkA9sTvDN4U6DlKsvpkJ7qiTT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299454; c=relaxed/simple;
	bh=68X+PEO5aWpI2TiQGsxLMyxA+WRENrZw588JGgqGxuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrPebm6ji6ts9bkPhIKEQukzjzNMpd5Ojx4ENWPqjbfbTMOPDtuDHWHaayGOqjg3xbLtzP2vpZglWRm/lRwT/JVPQwnHr92Q/5leFCFDn8J2fnnhCP466/gGQr8Qn+HGP67ROdC0wloet2mfnHyimO4qkZZiCyf7lOWcmOLron0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bf+ZZBMi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DF01F000E9;
	Wed, 20 May 2026 17:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299453;
	bh=RDhMdNnHU/QPGUqVH8XSJGP1mv1Nllq/+hb1/zDbmX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bf+ZZBMiVdduNnj31GIZJGYYeJA8ivqggY7X69D2qSNubm8s4VuFd/5yZ4Ft6CYje
	 0OKwZL6x5DJdDT3dqeM0mUCcBCylVeYzb963CV3OcSlY+/tOta6rKYmHPwshYofMyr
	 5AypEEzAehTn/OAPoFBkjfAIUvQOTElJJHwu/LG8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+3f46c095ac0ca048cb71@syzkaller.appspotmail.com,
	Andrew Lunn <andrew@lunn.ch>,
	Zhan Jun <zhanjun@uniontech.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 778/957] net: usb: rtl8150: fix use-after-free in rtl8150_start_xmit()
Date: Wed, 20 May 2026 18:21:01 +0200
Message-ID: <20260520162151.432663437@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-251989-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,3f46c095ac0ca048cb71];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,lunn.ch:email,syzkaller.appspot.com:url,uniontech.com:email,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,appspotmail.com:email]
X-Rspamd-Queue-Id: 7F4F2596682
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhan Jun <zhanjun@uniontech.com>

[ Upstream commit 23f0e34c64acba15cad4d23e50f41f533da195fa ]

syzbot reported a KASAN slab-use-after-free read in rtl8150_start_xmit()
when accessing skb->len for tx statistics after usb_submit_urb() has
been called:

  BUG: KASAN: slab-use-after-free in rtl8150_start_xmit+0x71f/0x760
    drivers/net/usb/rtl8150.c:712
  Read of size 4 at addr ffff88810eb7a930 by task kworker/0:4/5226

The URB completion handler write_bulk_callback() frees the skb via
dev_kfree_skb_irq(dev->tx_skb). The URB may complete on another CPU
in softirq context before usb_submit_urb() returns in the submitter,
so by the time the submitter reads skb->len the skb has already been
queued to the per-CPU completion_queue and freed by net_tx_action():

  CPU A (xmit)                      CPU B (USB completion softirq)
  ------------                      ------------------------------
  dev->tx_skb = skb;
  usb_submit_urb()      --+
                          |-------> write_bulk_callback()
                          |           dev_kfree_skb_irq(dev->tx_skb)
                          |         net_tx_action()
                          |           napi_skb_cache_put()   <-- free
  netdev->stats.tx_bytes  |
    += skb->len;          <-- UAF read

Fix it by caching skb->len before submitting the URB and using the
cached value when updating the tx_bytes counter.

The pre-existing tx_bytes semantics are preserved: the counter tracks
the original frame length (skb->len), not the ETH_ZLEN/USB-alignment
padded "count" value that is handed to the device.  Changing that
would be a user-visible accounting change and is out of scope for
this UAF fix.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+3f46c095ac0ca048cb71@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69e69ee7.050a0220.24bfd3.002b.GAE@google.com/
Closes: https://syzkaller.appspot.com/bug?extid=3f46c095ac0ca048cb71
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Zhan Jun <zhanjun@uniontech.com>
Link: https://patch.msgid.link/809895186B866C10+20260423004913.136655-1-zhangdandan@uniontech.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/rtl8150.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index e40b0669d9f4b..8700ae392b10a 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -685,6 +685,7 @@ static netdev_tx_t rtl8150_start_xmit(struct sk_buff *skb,
 					    struct net_device *netdev)
 {
 	rtl8150_t *dev = netdev_priv(netdev);
+	unsigned int skb_len;
 	int count, res;
 
 	/* pad the frame and ensure terminating USB packet, datasheet 9.2.3 */
@@ -696,6 +697,8 @@ static netdev_tx_t rtl8150_start_xmit(struct sk_buff *skb,
 		return NETDEV_TX_OK;
 	}
 
+	skb_len = skb->len;
+
 	netif_stop_queue(netdev);
 	dev->tx_skb = skb;
 	usb_fill_bulk_urb(dev->tx_urb, dev->udev, usb_sndbulkpipe(dev->udev, 2),
@@ -711,7 +714,7 @@ static netdev_tx_t rtl8150_start_xmit(struct sk_buff *skb,
 		}
 	} else {
 		netdev->stats.tx_packets++;
-		netdev->stats.tx_bytes += skb->len;
+		netdev->stats.tx_bytes += skb_len;
 		netif_trans_update(netdev);
 	}
 
-- 
2.53.0




