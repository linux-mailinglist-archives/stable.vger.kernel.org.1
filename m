Return-Path: <stable+bounces-250145-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDc8LWvuDWp+4wUAu9opvQ
	(envelope-from <stable+bounces-250145-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:24:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A9F59396E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28F533326297
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1B0369992;
	Wed, 20 May 2026 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FMa97O/Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D153371056;
	Wed, 20 May 2026 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294662; cv=none; b=LIGiYtD/4GGoONgP0gZzsh+xYybXB20XkWJvo27pmZbzuuo2gtk6htbOM8sM2KRjX+6uXuZaeUS2eyIlkMH3znlg79o42w3oecuSLj6oWLNbA3XCxMvSXvYSMeMuiwcl7MhOmLDWTJOilGYCtLsx4SPy3pvuFZHnj4xQNThKCKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294662; c=relaxed/simple;
	bh=e9vH84b+qa+1z+9XKdIXNrFxvnZzxrdry/50Y9Bh3Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXHIiPfwwXYkWVOz57l97QZs5sz3XAbo7ICXNWIr7MVXfEOl8ngXrbXVQeDaJD50rrBJMYyzc6DoZtdJcur3p/N27YNW+u2jHaNjDibMmpCMdwgAvUD4KsDqJJLYtcvmyfRtgHX3mRJrk70RrJ4rfpJ/GMZBgpEeD1UEvpMKu/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FMa97O/Q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0501F000E9;
	Wed, 20 May 2026 16:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294661;
	bh=JfVhUficy7+ghZiYWykBn1wKPze6w2Xvgv3A1KjmfEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FMa97O/QCD0Byh4h+YFT8B2QFdosUETuCtS++pz+cUnomqBOuNiwcueOvlZJUbYec
	 0HtgUfflg19PWC7DIV+eh0z+9XpONxIM4M/zpyOHP5KvZrRoTODO8+7hnpkUq3YgG9
	 qRkE+jfMTPPYF4YO1lbQOi3ucsXALQN+MPihZf2w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heitor Alves de Siqueira <halves@igalia.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0084/1146] wifi: libertas: use USB anchors for tracking in-flight URBs
Date: Wed, 20 May 2026 18:05:34 +0200
Message-ID: <20260520162150.253665533@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-250145-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,intel.com:email,igalia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 32A9F59396E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heitor Alves de Siqueira <halves@igalia.com>

[ Upstream commit a57f35fc19add4dfe33703af575a2c19c2cef9c7 ]

The libertas driver currently handles URB lifecycles manually, which
makes it non-trivial to check if specific URBs are pending or not. Add
anchors for TX/RX URBs, and use those to track in-flight requests.

Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
Link: https://patch.msgid.link/20260313-libertas-usb-anchors-v1-1-915afbe988d7@igalia.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Stable-dep-of: 7c5c2b661bdb ("wifi: libertas: don't kill URBs in interrupt context")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/marvell/libertas/if_usb.c    | 27 ++++++++++++-------
 .../net/wireless/marvell/libertas/if_usb.h    |  3 +++
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/if_usb.c b/drivers/net/wireless/marvell/libertas/if_usb.c
index 8a6bf1365cfab..11cd1422f46a3 100644
--- a/drivers/net/wireless/marvell/libertas/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas/if_usb.c
@@ -114,8 +114,8 @@ static void if_usb_write_bulk_callback(struct urb *urb)
 static void if_usb_free(struct if_usb_card *cardp)
 {
 	/* Unlink tx & rx urb */
-	usb_kill_urb(cardp->tx_urb);
-	usb_kill_urb(cardp->rx_urb);
+	usb_kill_anchored_urbs(&cardp->tx_submitted);
+	usb_kill_anchored_urbs(&cardp->rx_submitted);
 
 	usb_free_urb(cardp->tx_urb);
 	cardp->tx_urb = NULL;
@@ -221,6 +221,9 @@ static int if_usb_probe(struct usb_interface *intf,
 		     udev->descriptor.bDeviceSubClass,
 		     udev->descriptor.bDeviceProtocol);
 
+	init_usb_anchor(&cardp->rx_submitted);
+	init_usb_anchor(&cardp->tx_submitted);
+
 	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
 		endpoint = &iface_desc->endpoint[i].desc;
 		if (usb_endpoint_is_bulk_in(endpoint)) {
@@ -426,7 +429,7 @@ static int usb_tx_block(struct if_usb_card *cardp, uint8_t *payload, uint16_t nb
 		goto tx_ret;
 	}
 
-	usb_kill_urb(cardp->tx_urb);
+	usb_kill_anchored_urbs(&cardp->tx_submitted);
 
 	usb_fill_bulk_urb(cardp->tx_urb, cardp->udev,
 			  usb_sndbulkpipe(cardp->udev,
@@ -435,8 +438,10 @@ static int usb_tx_block(struct if_usb_card *cardp, uint8_t *payload, uint16_t nb
 
 	cardp->tx_urb->transfer_flags |= URB_ZERO_PACKET;
 
+	usb_anchor_urb(cardp->tx_urb, &cardp->tx_submitted);
 	if ((ret = usb_submit_urb(cardp->tx_urb, GFP_ATOMIC))) {
 		lbs_deb_usbd(&cardp->udev->dev, "usb_submit_urb failed: %d\n", ret);
+		usb_unanchor_urb(cardp->tx_urb);
 	} else {
 		lbs_deb_usb2(&cardp->udev->dev, "usb_submit_urb success\n");
 		ret = 0;
@@ -467,8 +472,10 @@ static int __if_usb_submit_rx_urb(struct if_usb_card *cardp,
 			  cardp);
 
 	lbs_deb_usb2(&cardp->udev->dev, "Pointer for rx_urb %p\n", cardp->rx_urb);
+	usb_anchor_urb(cardp->rx_urb, &cardp->rx_submitted);
 	if ((ret = usb_submit_urb(cardp->rx_urb, GFP_ATOMIC))) {
 		lbs_deb_usbd(&cardp->udev->dev, "Submit Rx URB failed: %d\n", ret);
+		usb_unanchor_urb(cardp->rx_urb);
 		kfree_skb(skb);
 		cardp->rx_skb = NULL;
 		ret = -1;
@@ -838,8 +845,8 @@ static void if_usb_prog_firmware(struct lbs_private *priv, int ret,
 	}
 
 	/* Cancel any pending usb business */
-	usb_kill_urb(cardp->rx_urb);
-	usb_kill_urb(cardp->tx_urb);
+	usb_kill_anchored_urbs(&cardp->rx_submitted);
+	usb_kill_anchored_urbs(&cardp->tx_submitted);
 
 	cardp->fwlastblksent = 0;
 	cardp->fwdnldover = 0;
@@ -869,8 +876,8 @@ static void if_usb_prog_firmware(struct lbs_private *priv, int ret,
 	if (cardp->bootcmdresp == BOOT_CMD_RESP_NOT_SUPPORTED) {
 		/* Return to normal operation */
 		ret = -EOPNOTSUPP;
-		usb_kill_urb(cardp->rx_urb);
-		usb_kill_urb(cardp->tx_urb);
+		usb_kill_anchored_urbs(&cardp->rx_submitted);
+		usb_kill_anchored_urbs(&cardp->tx_submitted);
 		if (if_usb_submit_rx_urb(cardp) < 0)
 			ret = -EIO;
 		goto done;
@@ -900,7 +907,7 @@ static void if_usb_prog_firmware(struct lbs_private *priv, int ret,
 	wait_event_interruptible(cardp->fw_wq, cardp->surprise_removed || cardp->fwdnldover);
 
 	timer_delete_sync(&cardp->fw_timeout);
-	usb_kill_urb(cardp->rx_urb);
+	usb_kill_anchored_urbs(&cardp->rx_submitted);
 
 	if (!cardp->fwdnldover) {
 		pr_info("failed to load fw, resetting device!\n");
@@ -960,8 +967,8 @@ static int if_usb_suspend(struct usb_interface *intf, pm_message_t message)
 		goto out;
 
 	/* Unlink tx & rx urb */
-	usb_kill_urb(cardp->tx_urb);
-	usb_kill_urb(cardp->rx_urb);
+	usb_kill_anchored_urbs(&cardp->tx_submitted);
+	usb_kill_anchored_urbs(&cardp->rx_submitted);
 
  out:
 	return ret;
diff --git a/drivers/net/wireless/marvell/libertas/if_usb.h b/drivers/net/wireless/marvell/libertas/if_usb.h
index 7d0daeb33c3f7..a0cd36197c2b0 100644
--- a/drivers/net/wireless/marvell/libertas/if_usb.h
+++ b/drivers/net/wireless/marvell/libertas/if_usb.h
@@ -48,6 +48,9 @@ struct if_usb_card {
 	struct urb *rx_urb, *tx_urb;
 	struct lbs_private *priv;
 
+	struct usb_anchor rx_submitted;
+	struct usb_anchor tx_submitted;
+
 	struct sk_buff *rx_skb;
 
 	uint8_t ep_in;
-- 
2.53.0




