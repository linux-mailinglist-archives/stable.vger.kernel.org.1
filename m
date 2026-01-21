Return-Path: <stable+bounces-211041-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOCpElcxcWmcfAAAu9opvQ
	(envelope-from <stable+bounces-211041-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:04:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FA75CC9D
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B87976FFBF
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E3733B945;
	Wed, 21 Jan 2026 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aInskDGH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC11332EDD;
	Wed, 21 Jan 2026 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020238; cv=none; b=OL3moarkwysNZW3hkHOOdI1yXMIpMxkV2z1z/EgwwACB12uVxzaNsN4TtYFsxjevk/YbHBs1RrG9wKxSK32xG16cKbPxTMQmOwO4nDulGf4NLYMe5yp/WDWOfrg3/y/8xbMSly+lazZhf38rj/oTKq4ncGLMr9dkGPKGjxtdtSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020238; c=relaxed/simple;
	bh=m6UczAJzSKC2WondLH11piZAm8BgGTmvCwRbw2FnJWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQnvYcqKD8cQeS6QU0Q8zRjUdQ7LKCroKb7OCYZSCrh2HcbfyRQBdw6g3TBaL+/q9GSVd9IGVFHqsSZPSRLjYYxs+tN18mS2S/2UasahnZgEZjNXTI1t0ehoG8XsUBn7Q9o2jPf/FAWyixcop7JMeIqzqCStUopLaW6IC9ljWIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aInskDGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C4FC4CEF1;
	Wed, 21 Jan 2026 18:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020238;
	bh=m6UczAJzSKC2WondLH11piZAm8BgGTmvCwRbw2FnJWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aInskDGHRuru79x7i2K+4MP1E3PiBl3D3zwlPdFC3FBLuLmfo5i0MrnEJlDdpEaXJ
	 dyo7UNHYlLLUg9SsiHmU5JHxP6aSRPndODsWWYQq40ZJ6WLbhfAJY2Ti0iEXa2qEfX
	 mtYQ9ENAtldWIndXQzN47oP6713M3P2GMDYyFyDg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.18 098/198] can: gs_usb: gs_usb_receive_bulk_callback(): fix URB memory leak
Date: Wed, 21 Jan 2026 19:15:26 +0100
Message-ID: <20260121181422.081522624@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211041-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: A4FA75CC9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Kleine-Budde <mkl@pengutronix.de>

commit 7352e1d5932a0e777e39fa4b619801191f57e603 upstream.

In gs_can_open(), the URBs for USB-in transfers are allocated, added to the
parent->rx_submitted anchor and submitted. In the complete callback
gs_usb_receive_bulk_callback(), the URB is processed and resubmitted. In
gs_can_close() the URBs are freed by calling
usb_kill_anchored_urbs(parent->rx_submitted).

However, this does not take into account that the USB framework unanchors
the URB before the complete function is called. This means that once an
in-URB has been completed, it is no longer anchored and is ultimately not
released in gs_can_close().

Fix the memory leak by anchoring the URB in the
gs_usb_receive_bulk_callback() to the parent->rx_submitted anchor.

Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260105-gs_usb-fix-memory-leak-v2-1-cc6ed6438034@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/usb/gs_usb.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -751,6 +751,8 @@ resubmit_urb:
 			  hf, parent->hf_size_rx,
 			  gs_usb_receive_bulk_callback, parent);
 
+	usb_anchor_urb(urb, &parent->rx_submitted);
+
 	rc = usb_submit_urb(urb, GFP_ATOMIC);
 
 	/* USB failure take down all interfaces */



