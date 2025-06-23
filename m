Return-Path: <stable+bounces-156054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27053AE451F
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852B83BD8AA
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9B4250BEC;
	Mon, 23 Jun 2025 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cJZRaQdI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ABE2F24;
	Mon, 23 Jun 2025 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686023; cv=none; b=tLaNi/yB6dM42EDWWCJamTOJScou9GiZP8jiKrpiqrWwpYtR/nJ+AgYlUYwaektkSe5Vjx+kyHtGeMd+nPkiTvn4TtYcBj8pFI+YIQiuWxPEWrO87ZqhkO99f9be++M94t1R/ojqzDSewAD3SxQyY0LDckhhPnkhyI4BrW0OVRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686023; c=relaxed/simple;
	bh=dbjPAMx8T9HxwW7MbkH8UuPi8UHN/esm65OzT/5uzNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r5FkM2/UFS3qU4oGZuSOLJKBZHkT8Rcxx+/wMe/FU8UUe2zXv+sRwgUBEevoflvpVJazjIMyxvMwkah8k5so9ptUMprAbpc2KglnsHnxh82TcjKY7jXHnNtf6XdYLafJPa6Z3gSjNMW5J0NIF4raE6u2T/LS/MTj41OyslmRyhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cJZRaQdI; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750686022; x=1782222022;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dbjPAMx8T9HxwW7MbkH8UuPi8UHN/esm65OzT/5uzNg=;
  b=cJZRaQdIqqTYgsLIMCDsW65tSNeSf222ZXoeWAIkslzyu9LlUNT1cwv1
   r9GBhgOrkAim/D8reYIgvfRCycIMfv1039NP5h+kuWvYYCRG+lwQp9uVc
   7mJNjMv+YKl6P1ra/nrDxzDr1lqCf/pXA8GPoa0wLK18tsngHGk9HLFFV
   B+py503bkeX0nd/TqbTNNbQzjzp5gT9cNULTHgeQLomtx/tnAwnNeFyH/
   qnLq7oGM5IaGoDz0aDQ9NpO/4wDoZJx7Dw54SxUPLVbzk+K0c35lgGHqv
   9CS6loCpzKMqPYTSRM8gOZGjKKhr54Uw8ql78KQA1TGW0dEKKptGqtdRD
   A==;
X-CSE-ConnectionGUID: YVbH18PZTFOpNN/zsCbaIg==
X-CSE-MsgGUID: LfgfzRQvRw2TUmJR4j1zOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="70320566"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="70320566"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 06:40:21 -0700
X-CSE-ConnectionGUID: nq6zh+X0RKmTkXOZ8FrkWA==
X-CSE-MsgGUID: IthY0cp2R8CIp83Qx2c2Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="182650970"
Received: from unknown (HELO mnyman-desk.fi.intel.com) ([10.237.72.199])
  by orviesa002.jf.intel.com with ESMTP; 23 Jun 2025 06:40:19 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	<stern@rowland.harvard.edu>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>
Subject: [PATCH] usb: hub: Don't try to recover devices lost during warm reset.
Date: Mon, 23 Jun 2025 16:39:47 +0300
Message-ID: <20250623133947.3144608-1-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hub driver warm-resets ports in SS.Inactive or Compliance mode to
recover a possible connected device. The port reset code correctly
detects if a connection is lost during reset, but hub driver
port_event() fails to take this into account in some cases.
port_event() ends up using stale values and assumes there is a
connected device, and will try all means to recover it, including
power-cycling the port.

Details:
This case was triggered when xHC host was suspended with DbC (Debug
Capability) enabled and connected. DbC turns one xHC port into a simple
usb debug device, allowing debugging a system with an A-to-A USB debug
cable.

xhci DbC code disables DbC when xHC is system suspended to D3, and
enables it back during resume.
We essentially end up with two hosts connected to each other during
suspend, and, for a short while during resume, until DbC is enabled back.
The suspended xHC host notices some activity on the roothub port, but
can't train the link due to being suspended, so xHC hardware sets a CAS
(Cold Attach Status) flag for this port to inform xhci host driver that
the port needs to be warm reset once xHC resumes.

CAS is xHCI specific, and not part of USB specification, so xhci driver
tells usb core that the port has a connection and link is in compliance
mode. Recovery from complinace mode is similar to CAS recovery.

xhci CAS driver support that fakes a compliance mode connection was added
in commit 8bea2bd37df0 ("usb: Add support for root hub port status CAS")

Once xHCI resumes and DbC is enabled back, all activity on the xHC
roothub host side port disappears. The hub driver will anyway think
port has a connection and link is in compliance mode, and hub driver
will try to recover it.

The port power-cycle during recovery seems to cause issues to the active
DbC connection.

Fix this by clearing connect_change flag if hub_port_reset() returns
-ENOTCONN, thus avoiding the whole unnecessary port recovery and
initialization attempt.

Cc: stable@vger.kernel.org
Fixes: 8bea2bd37df0 ("usb: Add support for root hub port status CAS")
Tested-by: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/core/hub.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 6bb6e92cb0a4..f981e365be36 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -5754,6 +5754,7 @@ static void port_event(struct usb_hub *hub, int port1)
 	struct usb_device *hdev = hub->hdev;
 	u16 portstatus, portchange;
 	int i = 0;
+	int err;
 
 	connect_change = test_bit(port1, hub->change_bits);
 	clear_bit(port1, hub->event_bits);
@@ -5850,8 +5851,11 @@ static void port_event(struct usb_hub *hub, int port1)
 		} else if (!udev || !(portstatus & USB_PORT_STAT_CONNECTION)
 				|| udev->state == USB_STATE_NOTATTACHED) {
 			dev_dbg(&port_dev->dev, "do warm reset, port only\n");
-			if (hub_port_reset(hub, port1, NULL,
-					HUB_BH_RESET_TIME, true) < 0)
+			err = hub_port_reset(hub, port1, NULL,
+					     HUB_BH_RESET_TIME, true);
+			if (!udev && err == -ENOTCONN)
+				connect_change = 0;
+			else if (err < 0)
 				hub_port_disable(hub, port1, 1);
 		} else {
 			dev_dbg(&port_dev->dev, "do warm reset, full device\n");
-- 
2.43.0


