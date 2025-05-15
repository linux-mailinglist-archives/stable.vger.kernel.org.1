Return-Path: <stable+bounces-144549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E53CAB8F5C
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 20:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB9873BE813
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 18:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D67285405;
	Thu, 15 May 2025 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RLas4Hmf"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f73.google.com (mail-vs1-f73.google.com [209.85.217.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3ED2690E0
	for <stable@vger.kernel.org>; Thu, 15 May 2025 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747335164; cv=none; b=StXqCn445HU/TGUAOgY6fL0mf1fsR9YIDx6ZQvI5ZfV5W2xPkQgyJyInxY6J9+xfipmJpHJFaDqaazm7NGkAazpzmDUP3ZJLoUYqad6zfUWDK/9w/u6dgXdIlhuDAIoHDdffiAgfcNiHV1Jp4ItM5kxxbPxWHrxlZjbOLzKxIJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747335164; c=relaxed/simple;
	bh=K63IL0wd/AKdNf65nemBDPL4UNxLf79dzeti/LRO/dc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N7I+l6IKnznrvY1WuMzwZTzY1GAQlDq4loBZ+8qOx+ttUeh2BFV1GID4vQ95gV6ZwkyrfCJKW9IF8n8/Io/X1VdUywfzxFnHS7X3xhIhWUL4r6QKmaNfcQqe4TdlX2PbgHIHBaDjuWtdeD0nTHYsWGLBHR1sBdtm8yiragKunS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--royluo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RLas4Hmf; arc=none smtp.client-ip=209.85.217.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--royluo.bounces.google.com
Received: by mail-vs1-f73.google.com with SMTP id ada2fe7eead31-4df5143c87aso1776122137.1
        for <stable@vger.kernel.org>; Thu, 15 May 2025 11:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747335162; x=1747939962; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tL75l/1ix6yb8tbp2dmZra7s66c/0nxAmQo/67QfY1c=;
        b=RLas4HmfZdBgXec0iVl9utjTrnZwrjBuxziIyXoYb9G5IBY5hNXLf7WqvI9MCWSCNs
         6Oj4PoTdn6RCgs2eILDJD5DbnUC0k11WkeeK99oQdR0Uqbigz4adZ7CvWBj5JOVsD0fN
         6aL1sKGDSwdmOeF1bhb0PYf+StEZTAeRM94yX4UpUWQ4E80oTV8ydrc0a/tGyEeVoV7P
         W6fQ09nwugMXQIgokTvofz8OUx1nAJAZd7LIaaibsJ+qYp4tdZeU7SLPa/BEODozD3CE
         bv3n3tIQfgWcR1BTMRZCmi4Rshzz7yutYedXREuyCT21JkJqZdJWPsYC3KoJoF0oI8oU
         LJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747335162; x=1747939962;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tL75l/1ix6yb8tbp2dmZra7s66c/0nxAmQo/67QfY1c=;
        b=qi9Q0Bj7GGIrhpxEYRrZGBqpbRY2MVZaw6IY1KD0wdFEcCPvcqDJNlMdcLjceyqaDm
         DjGiY/hQBBBpcENmv5hTvofJJFOBBIM8XUV6OIuWSC5BKUqw70XHnvgAs6qIu1Lltd9L
         mr5WseuGyEXwusN1U3AyWxubYwLDtpYDjSZTMypYzh+iNjq6MyX7WwuApyd8e1hxfIqr
         l1vSx7/LbA16vreC0MOkDZ9PGlKwcLD6ECbjlBrozcQCK9Q5yEqL7ZgOFS5bfjySBOfJ
         PgwSH+2dqoLRZLGq5JF1DbTfM3/13o0HDUe+L0n6x5/QJx+m1JnItN4OfPSFizUCgJzx
         ziRg==
X-Gm-Message-State: AOJu0Yydtgprt50AQsckGljWX981JNAQZaribSwfcHnMkrC2ek3/qcCN
	3k0EuxR4v8o5pLDM94767WO7gSilZnVfhdWjZCuVkSr6p0e+PSRi0R3ImY3d1S74sDE0aQ0Mgqs
	lI7ejCw==
X-Google-Smtp-Source: AGHT+IHwuQNwb0vPJPmRY4g+OzhIySpP7oIxTudeED3uvgNH9M4u5I7QlZs6oj9hjEmhqlFSDJT1BU6HPfA=
X-Received: from uabjd12.prod.google.com ([2002:a05:6130:678c:b0:879:ee02:ddc8])
 (user=royluo job=prod-delivery.src-stubby-dispatcher) by 2002:a67:ff90:0:b0:4db:10bf:6f2c
 with SMTP id ada2fe7eead31-4df900f5181mr5384781137.11.1747335161968; Thu, 15
 May 2025 11:52:41 -0700 (PDT)
Date: Thu, 15 May 2025 18:52:26 +0000
In-Reply-To: <20250515185227.1507363-1-royluo@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250515185227.1507363-1-royluo@google.com>
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <20250515185227.1507363-2-royluo@google.com>
Subject: [PATCH v2 1/2] xhci: Add a quirk for full reset on removal
From: Roy Luo <royluo@google.com>
To: royluo@google.com, mathias.nyman@intel.com, quic_ugoswami@quicinc.com, 
	Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 6ccb83d6c497 ("usb: xhci: Implement xhci_handshake_check_state()
helper") introduced an optimization to xhci_reset() during xhci removal,
allowing it to bail out early without waiting for the reset to complete.

This behavior can cause issues on SNPS DWC3 USB controller with dual-role
capability. When the DWC3 controller exits host mode and removes xhci
while a reset is still in progress, and then tries to configure its
hardware for device mode, the ongoing reset leads to register access
issues; specifically, all register reads returns 0. These issues extend
beyond the xhci register space (which is expected during a reset) and
affect the entire DWC3 IP block, causing the DWC3 device mode to
malfunction.

To address this, introduce the `XHCI_FULL_RESET_ON_REMOVE` quirk. When this
quirk is set, xhci_reset() always completes its reset handshake, ensuring
the controller is in a fully reset state before proceeding.

Cc: stable@vger.kernel.org
Fixes: 6ccb83d6c497 ("usb: xhci: Implement xhci_handshake_check_state() helper")
Signed-off-by: Roy Luo <royluo@google.com>
---
 drivers/usb/host/xhci-plat.c | 3 +++
 drivers/usb/host/xhci.c      | 8 +++++++-
 drivers/usb/host/xhci.h      | 1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 3155e3a842da..19c5c26a8e63 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -265,6 +265,9 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 		if (device_property_read_bool(tmpdev, "xhci-skip-phy-init-quirk"))
 			xhci->quirks |= XHCI_SKIP_PHY_INIT;
 
+		if (device_property_read_bool(tmpdev, "xhci-full-reset-on-remove-quirk"))
+			xhci->quirks |= XHCI_FULL_RESET_ON_REMOVE;
+
 		device_property_read_u32(tmpdev, "imod-interval-ns",
 					 &xhci->imod_interval);
 	}
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 90eb491267b5..4f091d618c01 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -198,6 +198,7 @@ int xhci_reset(struct xhci_hcd *xhci, u64 timeout_us)
 	u32 command;
 	u32 state;
 	int ret;
+	unsigned int exit_state;
 
 	state = readl(&xhci->op_regs->status);
 
@@ -226,8 +227,13 @@ int xhci_reset(struct xhci_hcd *xhci, u64 timeout_us)
 	if (xhci->quirks & XHCI_INTEL_HOST)
 		udelay(1000);
 
+	if (xhci->quirks & XHCI_FULL_RESET_ON_REMOVE)
+		exit_state = 0;
+	else
+		exit_state = XHCI_STATE_REMOVING;
+
 	ret = xhci_handshake_check_state(xhci, &xhci->op_regs->command,
-				CMD_RESET, 0, timeout_us, XHCI_STATE_REMOVING);
+				CMD_RESET, 0, timeout_us, exit_state);
 	if (ret)
 		return ret;
 
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 242ab9fbc8ae..ac65af788298 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1637,6 +1637,7 @@ struct xhci_hcd {
 #define XHCI_WRITE_64_HI_LO	BIT_ULL(47)
 #define XHCI_CDNS_SCTX_QUIRK	BIT_ULL(48)
 #define XHCI_ETRON_HOST	BIT_ULL(49)
+#define XHCI_FULL_RESET_ON_REMOVE	BIT_ULL(50)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
-- 
2.49.0.1112.g889b7c5bd8-goog


