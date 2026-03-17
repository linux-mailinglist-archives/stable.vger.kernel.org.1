Return-Path: <stable+bounces-226279-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFuuD4iFuWkPJAIAu9opvQ
	(envelope-from <stable+bounces-226279-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:47:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A9B2AE66D
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C3886303DA13
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7DB3F23CC;
	Tue, 17 Mar 2026 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s1EGL4CK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020C03F2108;
	Tue, 17 Mar 2026 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766002; cv=none; b=XyhRp6/02H9HPeDukDGQmk1iC61Q2L3lLy0g6TMpi+WvEhSaOIjawIs3zWybCkZ/4pQyiwT+HH7P3YaX9SJuc8lKw2YYOBqggZXZxIUDULC+DOR8/SIXSi7G9G6FwHvFxNiLzGzZ14dEDu+ldSIuvBFrxGt8S8G4pMIK3ug6dxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766002; c=relaxed/simple;
	bh=xqkgcR7gUsTG0JY8Om3+/YgRz4IIYrb7N2dRBf54NDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjpvU/FccsMG95Uy0wWznQc5x6a/376dgpHIAA0627Qua4Yg8/D7Tn/vFLxBc/evinglODlJNi65xfZRsiNYyBrR28WgDp+kwHIl8yCuWgjz7djFXlnHC7Ku34ngW20Kkz0ojD8s1FpUK/NVyvOw2XLw4beosJ6sDwZEsmV1gnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s1EGL4CK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23141C4CEF7;
	Tue, 17 Mar 2026 16:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766001;
	bh=xqkgcR7gUsTG0JY8Om3+/YgRz4IIYrb7N2dRBf54NDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s1EGL4CK6c3T5+rD1UNb5Fz7ZpXgPo5EGgLV9EIU4IZkQrWT5fO7d3jEfqlR1bRag
	 hMQ9PvQ0RQGueNLHMktqYpI/f220yOQabJiqYop56gV8xksiyn3/t4Pvv7easePOFS
	 2E+G3zjPWyxRmNrE/HhijD+5HZmM5cRHTY+6Il4s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 6.19 148/378] usb: yurex: fix race in probe
Date: Tue, 17 Mar 2026 17:31:45 +0100
Message-ID: <20260317163012.458767905@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-226279-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 03A9B2AE66D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit 7a875c09899ba0404844abfd8f0d54cdc481c151 upstream.

The bbu member of the descriptor must be set to the value
standing for uninitialized values before the URB whose
completion handler sets bbu is submitted. Otherwise there is
a window during which probing can overwrite already retrieved
data.

Cc: stable <stable@kernel.org>
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Link: https://patch.msgid.link/20260209143720.1507500-1-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/misc/yurex.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -272,6 +272,7 @@ static int yurex_probe(struct usb_interf
 			 dev->int_buffer, YUREX_BUF_SIZE, yurex_interrupt,
 			 dev, 1);
 	dev->urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+	dev->bbu = -1;
 	if (usb_submit_urb(dev->urb, GFP_KERNEL)) {
 		retval = -EIO;
 		dev_err(&interface->dev, "Could not submitting URB\n");
@@ -280,7 +281,6 @@ static int yurex_probe(struct usb_interf
 
 	/* save our data pointer in this interface device */
 	usb_set_intfdata(interface, dev);
-	dev->bbu = -1;
 
 	/* we can register the device now, as it is ready */
 	retval = usb_register_dev(interface, &yurex_class);



