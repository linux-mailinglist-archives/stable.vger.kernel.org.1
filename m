Return-Path: <stable+bounces-265419-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nOVPIcSJMWogmAUAu9opvQ
	(envelope-from <stable+bounces-265419-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:37:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CECE069350A
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:37:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=BD5e3kqw;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265419-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265419-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B037130F47F9
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABA447AF4D;
	Tue, 16 Jun 2026 17:31:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FD632E728;
	Tue, 16 Jun 2026 17:31:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631106; cv=none; b=nqK+OAc5G8aeUKBhD56if/+UNtl5uti4YZSW6C4kiYH+MTheBqWCH0DMJ+VIQLj0pRX2uo/By/v+jSJMc4qBnaB+2uIIvtMhmRVr6W03FpIZIhWPF69dgDqZ3frAzg1BZciTyU0IWI4DsrhSim0SHeHX6j6ibSYqIE4RR0+4Ado=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631106; c=relaxed/simple;
	bh=Xxobx/Y6/s9TbTAwM5sOy4Psoh9SkINTdI196j1GmQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ft/a/kdZuUCt1W6igF5i+2pgKBPWYyjDIChtembs8wb7+IUwgkQgJupOzBNWe5gZfzt+VXpeoEjaeA/rSeSvw4a5nC1HmVTQDgRYc1Q66NFQYxaEGhUfjjJ2Wtka/e8ujSS+PcrUaDFdo2OJOVGTMkUe2gcKUaX5pjQ5lcUMubY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BD5e3kqw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E031F000E9;
	Tue, 16 Jun 2026 17:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781631104;
	bh=Ti3rvR7BmvDhAYLGSUl7hiJ7b31Z4oTtlFNo7ySoneA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BD5e3kqwER6JhB7OEZgsPIKeLd3SKhRWs5fatM6ueFrFnWmuBLMTe2N16Fba8/iAn
	 gt2nPyKtQ9sf5dB+9L46Q1sGx/amTJqzreMQqRSaOQdFZM+kZpS9t30Qf2PabGL2JS
	 JA/e0AVPZD5FQ2zC0gwGfFyfRgB7UMQRAUIxXOb0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 6.1 157/522] usb: gadget: net2280: Fix double free in probe error path
Date: Tue, 16 Jun 2026 20:25:04 +0530
Message-ID: <20260616145133.454499228@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-265419-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:lgs201920130244@gmail.com,m:stern@rowland.harvard.edu,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,rowland.harvard.edu];
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
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,harvard.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CECE069350A

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guangshuo Li <lgs201920130244@gmail.com>

commit c8547c74988e0b5f4cbb1b895e2a57aae084f070 upstream.

usb_initialize_gadget() installs gadget_release() as the release
callback for the embedded gadget device.  The struct net2280 instance is
therefore released through gadget_release() when the gadget device's last
reference is dropped.

The probe error path calls net2280_remove(), which tears down the
partially initialized device and drops the gadget reference with
usb_put_gadget().  Calling kfree(dev) afterwards can free the same object
again.

Drop the explicit kfree() and let the gadget device release callback
handle the final free.  This issue was found by a static analysis tool
I am developing.

Fixes: f770fbec4165 ("USB: UDC: net2280: Fix memory leaks")
Cc: stable <stable@kernel.org>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://patch.msgid.link/20260427153651.337846-1-lgs201920130244@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/net2280.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/usb/gadget/udc/net2280.c
+++ b/drivers/usb/gadget/udc/net2280.c
@@ -3790,10 +3790,8 @@ static int net2280_probe(struct pci_dev
 	return 0;
 
 done:
-	if (dev) {
+	if (dev)
 		net2280_remove(pdev);
-		kfree(dev);
-	}
 	return retval;
 }
 



