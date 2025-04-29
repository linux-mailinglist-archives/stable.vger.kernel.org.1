Return-Path: <stable+bounces-138832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2781EAA19E8
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E80B2172EFE
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE9E227E95;
	Tue, 29 Apr 2025 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jYVbGwcF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D028D3FFD;
	Tue, 29 Apr 2025 18:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950491; cv=none; b=BNKEjn881xSV2zfzxtOHwpMQ2T4EpjFHUlpXwISOu4l8BEvM/b8JyHOwDHLpfs3aBNBpoJIh5c2fsXgrsFIhxtkts3IH2nlqJ5oeC1CBln2u/+qRWuSf5kr5lpaigPvyjzntWtVH9vYMj8gtcxEZJoCoA9gJeV6a4Lr/xloZJkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950491; c=relaxed/simple;
	bh=FRyfkxPmO/HnXaf/WISFTn1m3mzk18rQ91EahgYIQN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDAUctSrm42sqs3I+15lf7M5wwHQFOdyXTCGGnnawaPkqCPDVFbI+Go+ljZsWtOu59BfrZO3cJaYyNJy62nAKgXjTxCPXdl3FmbVCxkWaZNHH64Be3oZsvh5D77uhiyVGPqJWBD6ofmGLx+jvQo6kqROmQpwadA/Bu01Zae6LLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jYVbGwcF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBFCC4CEE3;
	Tue, 29 Apr 2025 18:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745950491;
	bh=FRyfkxPmO/HnXaf/WISFTn1m3mzk18rQ91EahgYIQN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jYVbGwcFYvo3SjVUABOATKEoIBS4X0Uy4+fqbNA7JDFS3u36xv61Ry3PFrzH0uUiW
	 UcfdhKHdB1kjKOrGltS+w3eokULSp1+1/1Hu3YMyieuxA9b5XenjoiYCwMUSK6R8MY
	 oDr4MmIuBw7NZI8HQU4HVekmauYsI19+M6Y+BIxk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 6.6 113/204] USB: wdm: handle IO errors in wdm_wwan_port_start
Date: Tue, 29 Apr 2025 18:43:21 +0200
Message-ID: <20250429161104.059075986@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161059.396852607@linuxfoundation.org>
References: <20250429161059.396852607@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit 9697f5efcf5fdea65b8390b5eb81bebe746ceedc upstream.

In case submitting the URB fails we must undo
what we've done so far.

Fixes: cac6fb015f71 ("usb: class: cdc-wdm: WWAN framework integration")
Cc: stable <stable@kernel.org>
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Link: https://lore.kernel.org/r/20250401084749.175246-2-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/class/cdc-wdm.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -829,6 +829,7 @@ static struct usb_class_driver wdm_class
 static int wdm_wwan_port_start(struct wwan_port *port)
 {
 	struct wdm_device *desc = wwan_port_get_drvdata(port);
+	int rv;
 
 	/* The interface is both exposed via the WWAN framework and as a
 	 * legacy usbmisc chardev. If chardev is already open, just fail
@@ -848,7 +849,15 @@ static int wdm_wwan_port_start(struct ww
 	wwan_port_txon(port);
 
 	/* Start getting events */
-	return usb_submit_urb(desc->validity, GFP_KERNEL);
+	rv = usb_submit_urb(desc->validity, GFP_KERNEL);
+	if (rv < 0) {
+		wwan_port_txoff(port);
+		desc->manage_power(desc->intf, 0);
+		/* this must be last lest we race with chardev open */
+		clear_bit(WDM_WWAN_IN_USE, &desc->flags);
+	}
+
+	return rv;
 }
 
 static void wdm_wwan_port_stop(struct wwan_port *port)



