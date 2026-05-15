Return-Path: <stable+bounces-248012-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFAAJ7NFB2qgvwIAu9opvQ
	(envelope-from <stable+bounces-248012-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:11:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 494F4552CC2
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 081D93077557
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F72B30569F;
	Fri, 15 May 2026 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mHILNYks"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B73305668;
	Fri, 15 May 2026 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860642; cv=none; b=TBdwLLcnfAGFk0G2nTw6HM+x86zdidhFzfU1v8EFT3n+QKHTaBBxXCig1B3wEfqZqikS5pkAzE+azsHdn1hZMKu/VNJNgbFa8EBfRihrM+PVCg+m1t7IrWeHFYq2V5nHXw/wYGgMrMgMjZSlODT1dUP/loYEQQ4I/xia8EFUZhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860642; c=relaxed/simple;
	bh=ixAueIqPy52hm25NWalXkgb7b8QycRSoaki5gyqp4L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lfBpqzXXY+zwHlvIDxfkOA/mLFGdEFgLH2lJPY3su5V9DVeWTcgUz+drX8Wxg4t7hzCTpiqyTjetO6InaNrJBceDW6iStmM8LdHUtn5LAFMtxeWHGrL8YRm8K1M3vcUpneiHkmizbZ5tgfWrL+dJ+crqcJ+bXrdLnu0wnOoAIF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mHILNYks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB76C2BCB0;
	Fri, 15 May 2026 15:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860642;
	bh=ixAueIqPy52hm25NWalXkgb7b8QycRSoaki5gyqp4L0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mHILNYksCpc7jvIWy2FFneYm6V00ebjPkVvUUZWx5kSvqeFSDRjbJMMNCKteAUvPJ
	 7qS15grB7ZqWQXF+lqNAmG4KbxYlWxU7PskQBWEHwZnr041VsfVM6cwhUGmElyyurz
	 NCa6/cgWXrtGi0xPs/iT+BqK6lkN7RQCOXOsnf2Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Chen <peter.chen@kernel.org>,
	Xu Yang <xu.yang_2@nxp.com>
Subject: [PATCH 6.6 006/474] usb: chipidea: core: allow ci_irq_handler() handle both ID and VBUS change
Date: Fri, 15 May 2026 17:41:55 +0200
Message-ID: <20260515154715.193166068@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 494F4552CC2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248012-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,nxp.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

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



