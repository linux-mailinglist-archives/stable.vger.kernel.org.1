Return-Path: <stable+bounces-261464-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0HjaLIdKJWoFGQIAu9opvQ
	(envelope-from <stable+bounces-261464-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:40:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 106C964FE39
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:40:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=cilEfJmI;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261464-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261464-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 082063036D44
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A73325706;
	Sun,  7 Jun 2026 10:37:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F193254A9;
	Sun,  7 Jun 2026 10:37:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828658; cv=none; b=h5r2tZ5HfaIividZ96+is9XkXq3hnB58Vfaqd/+F4nvxjbQl9h04UmTQFsuU/5rF/41v7OgewrNrGcvLiQABBMrxpiIKT6QRWsoSYSy7intK9EvKsd6Oc2rh373uE1Z+8YctxqeixcQhAVZ8esEbDIduqYIIFDoOpo4FxEQt3Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828658; c=relaxed/simple;
	bh=JQVDxoETcSP69uYFEJsNfl0LLfGNNxRRLP5zYWzKIUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfeDG5jS32tJjCQAIuEmwuWS6fv+FSrNbfFtY6lJPpoGDmdytNc7M/0WQ+ZAhoODLXtv+NE1F0w2M9duvVFBvyWF8nM/9ke8Y96XqJk6bQnFh/HyjtiOjlkhlQbcUAwORa3G6fRzYwDjkWoAI4v7AjhwVI1M9CwQfJq2frRw4j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cilEfJmI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD7A1F00898;
	Sun,  7 Jun 2026 10:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828657;
	bh=Glem2xpgTe1fnzd2YUMdESNejdz/EGWh3K42K4yj6Sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cilEfJmIp2tzPI8oyFQicVSMp0VBRw8irowfNNYWktIuqUHIEcCFf/RhXcymjnT4O
	 +KLBJa/7JLaeWyCeZ47hpUOY87//WYzhl5pe4SVsrycWR8V4GhNRgM3odORjZRrVRz
	 7tzNb0vfU+Ky7CIOVavRuGg5itjjXJ0LJUppEFLw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH 6.18 180/315] usb: dwc2: Fix use after free in debug code
Date: Sun,  7 Jun 2026 11:59:27 +0200
Message-ID: <20260607095734.191464037@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-261464-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:error27@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 106C964FE39

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <error27@gmail.com>

commit 9ea06a3fbf9f16e0d98c52cb3b99642be15ec281 upstream.

We're not allowed to dereference "urb" after calling
usb_hcd_giveback_urb() so save the urb->status ahead of time.

Fixes: 7359d482eb4d ("staging: HCD files for the DWC2 driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Dan Carpenter <error27@gmail.com>
Link: https://patch.msgid.link/ag1NwBpqT4IEQcdJ@stanley.mountain
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc2/hcd.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4804,6 +4804,7 @@ static int _dwc2_hcd_urb_dequeue(struct
 	struct dwc2_hsotg *hsotg = dwc2_hcd_to_hsotg(hcd);
 	int rc;
 	unsigned long flags;
+	int urb_status;
 
 	dev_dbg(hsotg->dev, "DWC OTG HCD URB Dequeue\n");
 	dwc2_dump_urb_info(hcd, urb, "urb_dequeue");
@@ -4828,11 +4829,12 @@ static int _dwc2_hcd_urb_dequeue(struct
 
 	/* Higher layer software sets URB status */
 	spin_unlock(&hsotg->lock);
+	urb_status = urb->status;
 	usb_hcd_giveback_urb(hcd, urb, status);
 	spin_lock(&hsotg->lock);
 
 	dev_dbg(hsotg->dev, "Called usb_hcd_giveback_urb()\n");
-	dev_dbg(hsotg->dev, "  urb->status = %d\n", urb->status);
+	dev_dbg(hsotg->dev, "  urb->status = %d\n", urb_status);
 out:
 	spin_unlock_irqrestore(&hsotg->lock, flags);
 



