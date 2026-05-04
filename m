Return-Path: <stable+bounces-243357-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJujNzOp+Gl+xgIAu9opvQ
	(envelope-from <stable+bounces-243357-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:12:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C38374BEC4C
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3799304838F
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633063DDDDF;
	Mon,  4 May 2026 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xd/7XTfo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CAC3DE43B;
	Mon,  4 May 2026 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903678; cv=none; b=IwSVVuzFxeE6KRqUW/64Q6EDawP1dPJ1CDrSYdDJ+ovMl1S40Ut4/cZL5HvcRSPnGLdC8lwE3F4rtWZhvSRqbwPl6C2eVfFC21DwL+ss/t02lI+1QaEJzpqQn/n6JvNCJ+1HjmEnyayb1kKsF6GWN4BeJS4UN0qRQVob9CDpwP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903678; c=relaxed/simple;
	bh=bygP9lZ1qrIdJmtWd3eCwuKpfj+67qZOZOVP82HDDaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eqt5TH4F9bHs6OBXhBCAKDgDYbvwLzgaBGMSibRL7MojglWfPLdz50eAHfMMq0R04wHyfznAsIqoOzjJWs43jvkvy7LCsq99dW28cGCeRsn7E21Q4AnSh+43Bf+HP9bu237WcwySir5JP8k5DjolfzWNOGezc6P2Ss0FChiqV+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xd/7XTfo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A965DC2BCB8;
	Mon,  4 May 2026 14:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903678;
	bh=bygP9lZ1qrIdJmtWd3eCwuKpfj+67qZOZOVP82HDDaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xd/7XTforjGHyrwVc21JcogYCPRC4oEJqiAn2DomhXiFcnx3oISobCb2CaPLaAE/y
	 F7BfmP1gAVtJBeWOxZDH0OSSu21Swr91EQnFbQbIG4TQWgAPH43ysQ5599NK1mA5Gc
	 xOS1/zGCjicnivjrX4cV1qpnTta/pPrwGNa7hEN0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Chen <peter.chen@kernel.org>,
	Xu Yang <xu.yang_2@nxp.com>
Subject: [PATCH 6.18 006/275] usb: chipidea: core: allow ci_irq_handler() handle both ID and VBUS change
Date: Mon,  4 May 2026 15:49:06 +0200
Message-ID: <20260504135143.173870966@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
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
X-Rspamd-Queue-Id: C38374BEC4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243357-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email]

6.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -543,30 +543,31 @@ static irqreturn_t ci_irq_handler(int ir
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



