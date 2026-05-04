Return-Path: <stable+bounces-243059-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIzfDBGm+GkExgIAu9opvQ
	(envelope-from <stable+bounces-243059-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 15:58:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0844BE38C
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 15:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABC22301CDA8
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 13:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEED3D47D0;
	Mon,  4 May 2026 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hM96sQLv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED3A3D9DCF;
	Mon,  4 May 2026 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777902912; cv=none; b=RccNzns689osiyqbIzjAal0rzoQ0ZTnSKf+M4GzPVXUN1vK28duZ1cRu3ulkxyDuUk7ES1N3+EssVZ6GuvfDXYCQ4JokvQht++yiAtFUx3zJXPGPLQj4jA9Z8FTTkiZJx5sxD6pgCtw8jnVcxrjkfNHdZO/5mvgbo9CyPNmhD8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777902912; c=relaxed/simple;
	bh=0+OVFt+YqQ8FdcwV/1M5HLwucyxz8WEx7uXpnQorU2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/4wD8XF4JqkymVeDrIx6/5uZH2a5Adjp2PsduetzES9gtvWTPs9CqbnxKvpo8ytHTO3mHF4XLbtNnjf3cvckfd3hMq3ONCPSIXQBCeg04s6SCGXN2+L+v7tnPHQZsUZ/XNFWXnGF/frcbNu8lWWSvUb4lRTQfb4nHjCD/b2hIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hM96sQLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A268C2BCB8;
	Mon,  4 May 2026 13:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777902911;
	bh=0+OVFt+YqQ8FdcwV/1M5HLwucyxz8WEx7uXpnQorU2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hM96sQLvktsNNB2T85Qf3tPYGhQsXsEykGDIJ07E3NDHWp+17QvIOjWJRWosChW6Q
	 DjqhTTvEa2PdqiH+gD4Xtl4RTuPGMfYrSOq451401ucBuEMe7T72wxyd7m2rLWMjSx
	 /jG8gjcDkauom4owRmD9DL5mQ8uNxkn3AKykBCMU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Chen <peter.chen@kernel.org>,
	Xu Yang <xu.yang_2@nxp.com>
Subject: [PATCH 7.0 006/307] usb: chipidea: core: allow ci_irq_handler() handle both ID and VBUS change
Date: Mon,  4 May 2026 15:48:11 +0200
Message-ID: <20260504135143.065412690@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: BB0844BE38C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243059-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xu Yang <xu.yang_2@nxp.com>

commit b94b631d9f78e653855f7fb58dbcb86c2a856f6f upstream.

For USB role switch-triggered IRQ, ID and VBUS change come together, for
example when switching from host to device mode. ID indicate a role switch
and VBUS is required to determine whether the device controller can start
operating. Currently, ci_irq_handler() handles only a single event per
invocation. This can cause an issue where switching to device mode results
in the device controller not working at all. Allowing ci_irq_handler() to
handle both ID and VBUS change in one call resolves this issue.

Meanwhile, this change also affects the VBUS event handling logic.
Previously, if an ID event indicated host mode the VBUS IRQ will be
ignored as the device disable BSE when stop() is called. With the new
behavior, if ID and VBUS IRQ occur together and the target mode is host,
the VBUS event is queued and ci_handle_vbus_change() will call
usb_gadget_vbus_connect(), after which USBMODE is switched to device mode,
causing host mode to stop working. To prevent this, an additional check is
added to skip handling VBUS event when current role is not device mode.

Suggested-by: Peter Chen <peter.chen@kernel.org>
Fixes: e1b5d2bed67c ("usb: chipidea: core: handle usb role switch in a common way")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Link: https://patch.msgid.link/20260402071457.2516021-2-xu.yang_2@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/chipidea/core.c |   45 ++++++++++++++++++++++----------------------
 drivers/usb/chipidea/otg.c  |    3 ++
 2 files changed, 26 insertions(+), 22 deletions(-)

--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -544,30 +544,31 @@ static irqreturn_t ci_irq_handler(int ir
 			if (ret == IRQ_HANDLED)
 				return ret;
 		}
-	}
 
-	/*
-	 * Handle id change interrupt, it indicates device/host function
-	 * switch.
-	 */
-	if (ci->is_otg && (otgsc & OTGSC_IDIE) && (otgsc & OTGSC_IDIS)) {
-		ci->id_event = true;
-		/* Clear ID change irq status */
-		hw_write_otgsc(ci, OTGSC_IDIS, OTGSC_IDIS);
-		ci_otg_queue_work(ci);
-		return IRQ_HANDLED;
-	}
+		/*
+		 * Handle id change interrupt, it indicates device/host function
+		 * switch.
+		 */
+		if ((otgsc & OTGSC_IDIE) && (otgsc & OTGSC_IDIS)) {
+			ci->id_event = true;
+			/* Clear ID change irq status */
+			hw_write_otgsc(ci, OTGSC_IDIS, OTGSC_IDIS);
+		}
 
-	/*
-	 * Handle vbus change interrupt, it indicates device connection
-	 * and disconnection events.
-	 */
-	if (ci->is_otg && (otgsc & OTGSC_BSVIE) && (otgsc & OTGSC_BSVIS)) {
-		ci->b_sess_valid_event = true;
-		/* Clear BSV irq */
-		hw_write_otgsc(ci, OTGSC_BSVIS, OTGSC_BSVIS);
-		ci_otg_queue_work(ci);
-		return IRQ_HANDLED;
+		/*
+		 * Handle vbus change interrupt, it indicates device connection
+		 * and disconnection events.
+		 */
+		if ((otgsc & OTGSC_BSVIE) && (otgsc & OTGSC_BSVIS)) {
+			ci->b_sess_valid_event = true;
+			/* Clear BSV irq */
+			hw_write_otgsc(ci, OTGSC_BSVIS, OTGSC_BSVIS);
+		}
+
+		if (ci->id_event || ci->b_sess_valid_event) {
+			ci_otg_queue_work(ci);
+			return IRQ_HANDLED;
+		}
 	}
 
 	/* Handle device/host interrupt */
--- a/drivers/usb/chipidea/otg.c
+++ b/drivers/usb/chipidea/otg.c
@@ -130,6 +130,9 @@ enum ci_role ci_otg_role(struct ci_hdrc
 
 void ci_handle_vbus_change(struct ci_hdrc *ci)
 {
+	if (ci->role != CI_ROLE_GADGET)
+		return;
+
 	if (!ci->is_otg) {
 		if (ci->platdata->flags & CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS)
 			usb_gadget_vbus_connect(&ci->gadget);



