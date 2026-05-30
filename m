Return-Path: <stable+bounces-257254-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMjINaAZG2oq/QgAu9opvQ
	(envelope-from <stable+bounces-257254-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:08:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D72060EF81
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE74730F5E87
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A32C33FE15;
	Sat, 30 May 2026 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NSgAO5bM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B222E92B3;
	Sat, 30 May 2026 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160355; cv=none; b=bFcRjKKLEUmGRAiHq8l88pfIBRP3ScIH07cm3CF3o6p6m4qvDqSnylafWkBnCx9ZEByuisMaDYhigbmngrtAXSK81gon83T0NaYbv19dXXHOHxkXKjhGoxBO+i0c37By81AIplHC5dblaM4VrOu8gs1KBNnKmJzxEbCkQbaPJ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160355; c=relaxed/simple;
	bh=1lY2roEFSG8l3pkXqXaP8bz6oZThuIijmXQLeKxMSjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+u8Cox3UyQI0XQvBcZ/v5Lt8BjkTqX0pWCUdG1+7TjAyDlIYYAl662GdU7zzgBM8dh0j43zBaww5aoqJ/5CY7zWP1tyMvUS/9CkSBay1xYzYF56Rv0MfTvf8jxMfqWgxAop2iihW0XCOCiIhg+zrbP1xXQyGQS+VNqpn9CRxZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NSgAO5bM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FEC1F00893;
	Sat, 30 May 2026 16:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780160354;
	bh=G/yOOcG+1H5I4UR1pp0JVT+H5SKP9BIXiZ+VW6cSnr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NSgAO5bMJPcFPd1icTUxvl7HoSStbncIWCxDULFRiD0LggI6BE8hHRv/D+qouB6aL
	 LdoT84X8ra8DhgkA5dx8bsRLXm7iWzvu+0G5BIiSCUg+AGO7WKH2wsyyyGwTd/4q4Y
	 SAQh6IH1qO3r1OzPR3S9+fHG5xArxmQ70SlK5fnw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Soenke Huster <soenke.huster@eknoes.de>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.1 316/969] Bluetooth: virtio_bt: clamp rx length before skb_put
Date: Sat, 30 May 2026 17:57:20 +0200
Message-ID: <20260530160309.134758394@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257254-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,eknoes.de,gmail.com,intel.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5D72060EF81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Bommarito <michael.bommarito@gmail.com>

commit 21bd244b6de5d2fe1063c23acc93fbdd2b20d112 upstream.

virtbt_rx_work() calls skb_put(skb, len) where len comes directly
from virtqueue_get_buf() with no validation against the buffer we
posted to the device. The RX skb is allocated in virtbt_add_inbuf()
and exposed to virtio as exactly 1000 bytes via sg_init_one().

Checking len against skb_tailroom(skb) is not sufficient because
alloc_skb() can leave more tailroom than the 1000 bytes actually
handed to the device. A malicious or buggy backend can therefore
report used.len between 1001 and skb_tailroom(skb), causing skb_put()
to include uninitialized kernel heap bytes that were never written by
the device.

The same path also accepts len == 0, in which case skb_put(skb, 0)
leaves the skb empty but virtbt_rx_handle() still reads the pkt_type
byte from skb->data, consuming uninitialized memory.

Define VIRTBT_RX_BUF_SIZE once and reuse it in alloc_skb() and
sg_init_one(), and gate virtbt_rx_work() on that same constant so
the bound checked matches the buffer actually exposed to the device.
Reject used.len == 0 in the same gate so an empty completion can
no longer reach virtbt_rx_handle().

Use bt_dev_err_ratelimited() because the length value comes from an
untrusted backend that can otherwise flood the kernel log.

Same class of bug as commit c04db81cd028 ("net/9p: Fix buffer
overflow in USB transport layer"), which hardened the USB 9p
transport against unchecked device-reported length.

Fixes: 160fbcf3bfb9 ("Bluetooth: virtio_bt: Use skb_put to set length")
Cc: stable@vger.kernel.org
Cc: Soenke Huster <soenke.huster@eknoes.de>
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/virtio_bt.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -12,6 +12,7 @@
 #include <net/bluetooth/hci_core.h>
 
 #define VERSION "0.1"
+#define VIRTBT_RX_BUF_SIZE 1000
 
 enum {
 	VIRTBT_VQ_TX,
@@ -33,11 +34,11 @@ static int virtbt_add_inbuf(struct virti
 	struct sk_buff *skb;
 	int err;
 
-	skb = alloc_skb(1000, GFP_KERNEL);
+	skb = alloc_skb(VIRTBT_RX_BUF_SIZE, GFP_KERNEL);
 	if (!skb)
 		return -ENOMEM;
 
-	sg_init_one(sg, skb->data, 1000);
+	sg_init_one(sg, skb->data, VIRTBT_RX_BUF_SIZE);
 
 	err = virtqueue_add_inbuf(vq, sg, 1, skb, GFP_KERNEL);
 	if (err < 0) {
@@ -219,8 +220,15 @@ static void virtbt_rx_work(struct work_s
 	if (!skb)
 		return;
 
-	skb_put(skb, len);
-	virtbt_rx_handle(vbt, skb);
+	if (!len || len > VIRTBT_RX_BUF_SIZE) {
+		bt_dev_err_ratelimited(vbt->hdev,
+				       "rx reply len %u outside [1, %u]\n",
+				       len, VIRTBT_RX_BUF_SIZE);
+		kfree_skb(skb);
+	} else {
+		skb_put(skb, len);
+		virtbt_rx_handle(vbt, skb);
+	}
 
 	if (virtbt_add_inbuf(vbt) < 0)
 		return;



