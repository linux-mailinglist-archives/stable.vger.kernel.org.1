Return-Path: <stable+bounces-235202-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cC3qCR6s1mmZHAgAu9opvQ
	(envelope-from <stable+bounces-235202-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:27:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB0F3C302E
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85EEB31210E8
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 19:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2530A37DE90;
	Wed,  8 Apr 2026 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V1m3/ZHh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB62A2857C1;
	Wed,  8 Apr 2026 19:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674832; cv=none; b=A7Pe8+tW3DKVmmJYsP11HraWg4YLxFv4kqi/8uP1DXovEZLGn7dlRZUDZZ8abzdZ7EyENUnLLMja018yLyYF8n1x7K44UBr+wRIuPzt1iVrvg6Va49LLmH9v68SoBaUOGx13aDI+qkF79mPRIsERZyX3b25X7l+DdJtmGMBvqq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674832; c=relaxed/simple;
	bh=U6BkfyOm8knfHTLpou4VPXFcIguoZoJSeFJdP/ZPMDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BybKygioH3Hd7C7wOwqfR40/wmWwpC7hAGwk1ZJSagVWJ5EZZ3akxyWa/q6d1qKpV0sggdeXsxWbl8/FEbrkhwzBZhsHRxijItRFz5cajtGbuBoFlunrKnf8O8Mhg3vu7qH0J/NP4kpadFO9R9fAPjIA8EHdGWyOmEACJXNIIB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V1m3/ZHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71749C2BC87;
	Wed,  8 Apr 2026 19:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674832;
	bh=U6BkfyOm8knfHTLpou4VPXFcIguoZoJSeFJdP/ZPMDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V1m3/ZHhQfLyZhWc84+G4ztu8hbbs0/h3e3m434u6YKExP1e2mBjcH3A8yVOQNiGn
	 +Pla5IsbsaFykHFTeh5SblbPV2xljwZ6IAoBDKwveBcjxVMzVRYMCNlA48Y/3aZEh7
	 5IP937HOKwsoHtZ+nkFnb1yEhIocS9+yve0waCBs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Juno Choi <juno.choi@lge.com>
Subject: [PATCH 6.19 243/311] usb: dwc2: gadget: Fix spin_lock/unlock mismatch in dwc2_hsotg_udc_stop()
Date: Wed,  8 Apr 2026 20:04:03 +0200
Message-ID: <20260408175948.466234317@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-235202-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 5CB0F3C302E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juno Choi <juno.choi@lge.com>

commit 9bb4b5ed7f8c4f95cc556bdf042b0ba2fa13557a upstream.

dwc2_gadget_exit_clock_gating() internally calls call_gadget() macro,
which expects hsotg->lock to be held since it does spin_unlock/spin_lock
around the gadget driver callback invocation.

However, dwc2_hsotg_udc_stop() calls dwc2_gadget_exit_clock_gating()
without holding the lock. This leads to:
 - spin_unlock on a lock that is not held (undefined behavior)
 - The lock remaining held after dwc2_gadget_exit_clock_gating() returns,
   causing a deadlock when spin_lock_irqsave() is called later in the
   same function.

Fix this by acquiring hsotg->lock before calling
dwc2_gadget_exit_clock_gating() and releasing it afterwards, which
satisfies the locking requirement of the call_gadget() macro.

Fixes: af076a41f8a2 ("usb: dwc2: also exit clock_gating when stopping udc while suspended")
Cc: stable <stable@kernel.org>
Signed-off-by: Juno Choi <juno.choi@lge.com>
Link: https://patch.msgid.link/20260324014910.2798425-1-juno.choi@lge.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc2/gadget.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -4607,7 +4607,9 @@ static int dwc2_hsotg_udc_stop(struct us
 	/* Exit clock gating when driver is stopped. */
 	if (hsotg->params.power_down == DWC2_POWER_DOWN_PARAM_NONE &&
 	    hsotg->bus_suspended && !hsotg->params.no_clock_gating) {
+		spin_lock_irqsave(&hsotg->lock, flags);
 		dwc2_gadget_exit_clock_gating(hsotg, 0);
+		spin_unlock_irqrestore(&hsotg->lock, flags);
 	}
 
 	/* all endpoints should be shutdown */



