Return-Path: <stable+bounces-224660-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMwKGRwysWm0rwIAu9opvQ
	(envelope-from <stable+bounces-224660-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 10:13:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D5D260159
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 10:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CD91300E256
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 09:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F1D3C5DB7;
	Wed, 11 Mar 2026 09:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LF5uY5OZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CED3C1415
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 09:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773220362; cv=none; b=tliZ0rOHL8/1I961CpKAdsd0cN+An5Mh1uHvDZYHPOeOz5XctEGS+V5VYwQTxs5LgxLLrtdf3h8PUhKqWSBna+5svL4IIbJk6pZTuuzmB+UjfPKNCMKmlmekrX76cEAFNN1HXQTfi5Ha9Hz609pVUUj0E3L7Z2z1weXS2mGp65A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773220362; c=relaxed/simple;
	bh=IuJEJeZeAA0dtPdJGCR2Y6So5KmMJbEcKNQPLePgIVk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=I5A9VjiX1ccZ9mSkA1J4RJscsVMoj5qW0XK9zaWXLMbGf4EXs5T3MGfdVgFlmkWYwfSwhzBEe0jckiA2/brReGkkmUziN2xtmRPbMQsm5eFlDPCs+5LQEj2CQT0KG4D6Ti71J26jknDNgDaLDjasYOpuZGNQM6wURqxDaxu2i0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LF5uY5OZ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae502a1dd9so128551435ad.3
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 02:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773220354; x=1773825154; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CfExovoAn7o/levAKL1G/GcHLpVojQhg0czDHj9L5ow=;
        b=LF5uY5OZctOYzLVhoMiE1XP6YQAez1/qTF8BV54ijBQQ9IYMmFWr2ZJuV3Rmw7mwh+
         7/m9R6bhH2rbCVvMeCVP+HpMEw4PA/HAh6BVbgBA9lTLxnsTBjSFQmfUEe2WZaEtTYPY
         xsL5cNPfZUNW/AakqiPO0RJ/cz8VKHQ0AZJQKIO5UrTEaRZeeKylrkfjFV0/vqjVO2np
         zKpF40JHapezhjIbxooK45UwFVW+Tlb4nQApYAxN74ZniyA2O9O7RYHNRkc3f+JpGUjD
         ptj1afAErakMZpfoahzIeeEpx1meQY3LhoXx4sFUwM4bbgWCpQgIMsbNuWii0LezIq8/
         ZC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773220354; x=1773825154;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CfExovoAn7o/levAKL1G/GcHLpVojQhg0czDHj9L5ow=;
        b=PBEhAwsR0M0oEDaobc50NuNJyGRHGK8rZ3VmYGlQMa2gM43se4nY29GrsauBWsx2vR
         zQNAssN6TQXeoS/qZbL+z23gheHqt7+W/0LaQWpuSmRNpeST9V/boUdtmtcYUQowoko/
         F9VfC0DQbAY3ZBGtf3IA4Tk4gmrDaHU+v7FoGVD3AQbCofeTPiY7KvhEYAQEnFWkoxB6
         KI42qm5/hFs3Yc25mj/k4dBKKJljnyIN7BkUM8MQleG95BkYLdY2QwNiY7V/9Rc3UMDC
         UMcSF6QndrkCvAROV6GJjlq7EIIMcrJC3pwO2UeRYaqSYtb9VTioG6wUjXAum1ZyZmNr
         y92A==
X-Forwarded-Encrypted: i=1; AJvYcCXx+r4i7MwbtRFWxoOqZGY0lU+yIJjaipDM7az3ZFBikejL7+yHD/PdE5TkOtvK8g4dj8EWiwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcKiYKdb3+fpSgozKAnjRnVUiJblL1/hhCgS5nExtvA4AxFA29
	UHaIkrgpYafQrkt4EDj2zSQOux5Nrm/4YWKwQ396/HkabYtzykIfZfLPYHz+g2p0f8NYhYoxXmk
	e8/A03w==
X-Received: from pfbbk8.prod.google.com ([2002:aa7:8308:0:b0:829:753a:73c1])
 (user=khtsai job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a110:b0:398:9b42:69f7
 with SMTP id adf61e73a8af0-398c60e40e9mr1761475637.39.1773220353942; Wed, 11
 Mar 2026 02:12:33 -0700 (PDT)
Date: Wed, 11 Mar 2026 17:12:15 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAO4xsWkC/x3MwQpAQBCH8VfRnE0ZIryKHLT7X+YytCspeXeb4
 +/wfQ8lREWisXgo4tKku2VIWZDbFlvB6rOpruquakR4xbkhstfkdjO4k+0At30nfugb8SFQbo+ IoPf/neb3/QAKuI/CZwAAAA==
X-Change-Id: 20260311-gether-disconnect-npe-5861d9831dff
X-Developer-Key: i=khtsai@google.com; a=ed25519; pk=abA4Pw6dY2ZufSbSXW9mtp7xiv1AVPtgRhCFWJSEqLE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773220352; l=2489;
 i=khtsai@google.com; s=20250916; h=from:subject:message-id;
 bh=IuJEJeZeAA0dtPdJGCR2Y6So5KmMJbEcKNQPLePgIVk=; b=RULJ9mQMu2H/bZkTzSiCY3jQvdU2YAWixzuX8Ru1zDG+HqQwUttR/mnK7HLj9mn01Vabu+zY/
 I3rYDCiho2GBChi++LgedTLhr40Ti6DPsaTCvVbuYvZucu927qnf03s
X-Mailer: b4 0.14.3
Message-ID: <20260311-gether-disconnect-npe-v1-1-454966adf7c7@google.com>
Subject: [PATCH] usb: gadget: u_ether: Fix race between gether_disconnect and eth_stop
From: Kuen-Han Tsai <khtsai@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	David Brownell <dbrownell@users.sourceforge.net>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Kuen-Han Tsai <khtsai@google.com>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: E7D5D260159
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224660-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khtsai@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

A race condition between gether_disconnect() and eth_stop() leads to a
NULL pointer dereference. Specifically, if eth_stop() is triggered
concurrently while gether_disconnect() is tearing down the endpoints,
eth_stop() attempts to access the cleared endpoint descriptor, causing
the following NPE:

  Unable to handle kernel NULL pointer dereference
  Call trace:
   __dwc3_gadget_ep_enable+0x60/0x788
   dwc3_gadget_ep_enable+0x70/0xe4
   usb_ep_enable+0x60/0x15c
   eth_stop+0xb8/0x108

Because eth_stop() crashes while holding the dev->lock, the thread
running gether_disconnect() fails to acquire the same lock and spins
forever, resulting in a hardlockup:

  Core - Debugging Information for Hardlockup core(7)
  Call trace:
   queued_spin_lock_slowpath+0x94/0x488
   _raw_spin_lock+0x64/0x6c
   gether_disconnect+0x19c/0x1e8
   ncm_set_alt+0x68/0x1a0
   composite_setup+0x6a0/0xc50

The root cause is that the clearing of dev->port_usb in
gether_disconnect() is delayed until the end of the function.

Move the clearing of dev->port_usb to the very beginning of
gether_disconnect() while holding dev->lock. This cuts off the link
immediately, ensuring eth_stop() will see dev->port_usb as NULL and
safely bail out.

Fixes: 2b3d942c4878 ("usb ethernet gadget: split out network core")
Cc: stable@vger.kernel.org
Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
---
 drivers/usb/gadget/function/u_ether.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 338f6e2a85a9..2c970a0eafd9 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -1246,6 +1246,11 @@ void gether_disconnect(struct gether *link)
 
 	DBG(dev, "%s\n", __func__);
 
+	spin_lock(&dev->lock);
+	dev->port_usb = NULL;
+	link->is_suspend = false;
+	spin_unlock(&dev->lock);
+
 	netif_stop_queue(dev->net);
 	netif_carrier_off(dev->net);
 
@@ -1283,11 +1288,6 @@ void gether_disconnect(struct gether *link)
 	dev->header_len = 0;
 	dev->unwrap = NULL;
 	dev->wrap = NULL;
-
-	spin_lock(&dev->lock);
-	dev->port_usb = NULL;
-	link->is_suspend = false;
-	spin_unlock(&dev->lock);
 }
 EXPORT_SYMBOL_GPL(gether_disconnect);
 

---
base-commit: 1be3b77de4eb89af8ae2fd6610546be778e25589
change-id: 20260311-gether-disconnect-npe-5861d9831dff

Best regards,
-- 
Kuen-Han Tsai <khtsai@google.com>


