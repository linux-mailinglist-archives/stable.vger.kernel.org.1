Return-Path: <stable+bounces-76570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D23797AE7C
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 12:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C82FA284F82
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 10:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537B6159571;
	Tue, 17 Sep 2024 10:07:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C432158D8F;
	Tue, 17 Sep 2024 10:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726567669; cv=none; b=Prb/rEg6FsSFjsjuzJNb05Y/1y7iZP21mlxmqphs9P9+fQOUucx3Y95cTJ4LaN/4okS4zddlU3Fw6fHwiz8kIuFxfnpdVvqZKZBPDNSU1cs2EJ6p4Cxrbo5PHO08G4+rSw4GEMfmavKYXl9kw/flIITs/abcXpvznANYxtV40Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726567669; c=relaxed/simple;
	bh=OvPvzmYVf5PPB6SaJ1tyg1h/ET1ohPg3n64z+iN4ZdY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A3DvviYctU6oAtpXgus+DXUS1nbs8fekRl9E3SZIgZDKENa6MaB5Oe3F+xGKOCOtmObW6ccK0vRobjIRuTWHzVz5NUnrAycxyjRAAJc7mR1eWKLJGfRpkUqm4pt0e+Ms3wdb1eDDpnZIHizJoSzN3yKEtpWVpWx/dAuvGYpInZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst083.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 17 Sep
 2024 13:07:23 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Roman Smirnov <r.smirnov@omp.ru>, Mark Brown <broonie@kernel.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, <linux-kernel@vger.kernel.org>, Sergey
 Shtylyov <s.shtylyov@omp.ru>, Karina Yankevich <k.yankevich@omp.ru>, Sergey
 Yudin <s.yudin@omp.ru>, <lvc-project@linuxtesting.org>, Mathias Nyman
	<mathias.nyman@linux.intel.com>
Subject: [PATCH 5.10] xhci: check virt_dev is valid before dereferencing it
Date: Tue, 17 Sep 2024 13:07:03 +0300
Message-ID: <20240917100703.80166-1-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/17/2024 09:55:40
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 187792 [Sep 17 2024]
X-KSE-AntiSpam-Info: Version: 6.1.1.5
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 34 0.3.34
 8a1fac695d5606478feba790382a59668a4f0039
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	lore.kernel.org:7.1.1;inp1wst083.omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;81.22.207.138:7.1.2;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 81.22.207.138
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/17/2024 09:59:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/17/2024 9:17:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit 03ed579d9d51aa018830b0de3e8b463faf6b87db upstream.

Check that the xhci_virt_dev structure that we dug out based
on a slot_id value from a command completion is valid before
dereferencing it.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20210129130044.206855-7-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
---
 drivers/usb/host/xhci-ring.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index fbb7a5b51ef4..a769803e7d38 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1415,6 +1415,8 @@ static void xhci_handle_cmd_config_ep(struct xhci_hcd *xhci, int slot_id,
 	 * is not waiting on the configure endpoint command.
 	 */
 	virt_dev = xhci->devs[slot_id];
+	if (!virt_dev)
+		return;
 	ctrl_ctx = xhci_get_input_control_ctx(virt_dev->in_ctx);
 	if (!ctrl_ctx) {
 		xhci_warn(xhci, "Could not get input context, bad type.\n");
@@ -1459,6 +1461,8 @@ static void xhci_handle_cmd_addr_dev(struct xhci_hcd *xhci, int slot_id)
 	struct xhci_slot_ctx *slot_ctx;
 
 	vdev = xhci->devs[slot_id];
+	if (!vdev)
+		return;
 	slot_ctx = xhci_get_slot_ctx(xhci, vdev->out_ctx);
 	trace_xhci_handle_cmd_addr_dev(slot_ctx);
 }
@@ -1470,13 +1474,15 @@ static void xhci_handle_cmd_reset_dev(struct xhci_hcd *xhci, int slot_id,
 	struct xhci_slot_ctx *slot_ctx;
 
 	vdev = xhci->devs[slot_id];
+	if (!vdev) {
+		xhci_warn(xhci, "Reset device command completion for disabled slot %u\n",
+			  slot_id);
+		return;
+	}
 	slot_ctx = xhci_get_slot_ctx(xhci, vdev->out_ctx);
 	trace_xhci_handle_cmd_reset_dev(slot_ctx);
 
 	xhci_dbg(xhci, "Completed reset device command.\n");
-	if (!xhci->devs[slot_id])
-		xhci_warn(xhci, "Reset device command completion "
-				"for disabled slot %u\n", slot_id);
 }
 
 static void xhci_handle_cmd_nec_get_fw(struct xhci_hcd *xhci,
-- 
2.34.1


