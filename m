Return-Path: <stable+bounces-66083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D128C94C567
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 21:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788741F23347
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 19:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC47A155A59;
	Thu,  8 Aug 2024 19:42:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3908615572F
	for <stable@vger.kernel.org>; Thu,  8 Aug 2024 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723146134; cv=none; b=DnTwxALNxFM32jDbcyA+I2A/WFgwluUzpljypE66VlSbCJAq7umpEThRdYdTG+P4g9ZdmX8JA4jwAIkrtaHywYt7kVkdmnTAp96l5bAq487f9l8peG/ACqpbPZZRYXhOUGEaupVXxhZGcZvGDlW1qEyhWLa2mXzN5jBkKwPALSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723146134; c=relaxed/simple;
	bh=KDw8CT6xodJzHz0eF8ANHtSBdptXiQK0j6MN2UKrMRo=;
	h=From:Date:Subject:To:Cc:Message-Id; b=EBAO2cYYsTf+Ltfpg8/cQl+9JDQ0FU4cY81h4SyrJ1V52l6QCTBjVaEWzynqpeq13hr/3FAdmAxLbxCLZ2wJNEIuja5jPcRXtYPA3jgrteb7ByXSuE51EVNkx4v9QWvBYmIPH2d+JcAZcGeTFL0zfBQ3Q9qHg9IdVOX+rpM2Vfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from mchehab by linuxtv.org with local (Exim 4.96)
	(envelope-from <mchehab@linuxtv.org>)
	id 1sc91Y-0004An-2b;
	Thu, 08 Aug 2024 19:42:12 +0000
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Thu, 08 Aug 2024 19:40:34 +0000
Subject: [git:media_stage/fixes] media: Revert "media: dvb-usb: Fix unexpected infinite loop in dvb_usb_read_remote_control()"
To: linuxtv-commits@linuxtv.org
Cc: stable@vger.kernel.org, Sean Young <sean@mess.org>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1sc91Y-0004An-2b@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: Revert "media: dvb-usb: Fix unexpected infinite loop in dvb_usb_read_remote_control()"
Author:  Sean Young <sean@mess.org>
Date:    Thu Aug 8 10:35:19 2024 +0200

This reverts commit 2052138b7da52ad5ccaf74f736d00f39a1c9198c.

This breaks the TeVii s480 dual DVB-S2 S660. The device has a bulk in
endpoint but no corresponding out endpoint, so the device does not pass
the "has both receive and send bulk endpoint" test.

Seemingly this device does not use dvb_usb_generic_rw() so I have tried
removing the generic_bulk_ctrl_endpoint entry, but this resulted in
different problems.

As we have no explanation yet, revert.

$ dmesg | grep -i -e dvb -e dw21 -e usb\ 4
[    0.999122] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    1.023123] usb 4-1: new high-speed USB device number 2 using ehci-pci
[    1.130247] usb 1-1: New USB device found, idVendor=9022, idProduct=d482,
+bcdDevice= 0.01
[    1.130257] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.152323] usb 4-1: New USB device found, idVendor=9022, idProduct=d481,
+bcdDevice= 0.01
[    1.152329] usb 4-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    6.701033] dvb-usb: found a 'TeVii S480.2 USB' in cold state, will try to
+load a firmware
[    6.701178] dvb-usb: downloading firmware from file 'dvb-usb-s660.fw'
[    6.701179] dw2102: start downloading DW210X firmware
[    6.703715] dvb-usb: found a 'Microsoft Xbox One Digital TV Tuner' in cold
+state, will try to load a firmware
[    6.703974] dvb-usb: downloading firmware from file 'dvb-usb-dib0700-1.20.fw'
[    6.756432] usb 1-1: USB disconnect, device number 2
[    6.862119] dvb-usb: found a 'TeVii S480.2 USB' in warm state.
[    6.862194] dvb-usb: TeVii S480.2 USB error while loading driver (-22)
[    6.862209] dvb-usb: found a 'TeVii S480.1 USB' in cold state, will try to
+load a firmware
[    6.862244] dvb-usb: downloading firmware from file 'dvb-usb-s660.fw'
[    6.862245] dw2102: start downloading DW210X firmware
[    6.914811] usb 4-1: USB disconnect, device number 2
[    7.014131] dvb-usb: found a 'TeVii S480.1 USB' in warm state.
[    7.014487] dvb-usb: TeVii S480.1 USB error while loading driver (-22)
[    7.014538] usbcore: registered new interface driver dw2102

Closes: https://lore.kernel.org/stable/20240801165146.38991f60@mir/

Fixes: 2052138b7da5 ("media: dvb-usb: Fix unexpected infinite loop in dvb_usb_read_remote_control()")
Reported-by: Stefan Lippers-Hollmann <s.l-h@gmx.de>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

 drivers/media/usb/dvb-usb/dvb-usb-init.c | 35 ++++----------------------------
 1 file changed, 4 insertions(+), 31 deletions(-)

---

diff --git a/drivers/media/usb/dvb-usb/dvb-usb-init.c b/drivers/media/usb/dvb-usb/dvb-usb-init.c
index 22d83ac18eb7..fbf58012becd 100644
--- a/drivers/media/usb/dvb-usb/dvb-usb-init.c
+++ b/drivers/media/usb/dvb-usb/dvb-usb-init.c
@@ -23,40 +23,11 @@ static int dvb_usb_force_pid_filter_usage;
 module_param_named(force_pid_filter_usage, dvb_usb_force_pid_filter_usage, int, 0444);
 MODULE_PARM_DESC(force_pid_filter_usage, "force all dvb-usb-devices to use a PID filter, if any (default: 0).");
 
-static int dvb_usb_check_bulk_endpoint(struct dvb_usb_device *d, u8 endpoint)
-{
-	if (endpoint) {
-		int ret;
-
-		ret = usb_pipe_type_check(d->udev, usb_sndbulkpipe(d->udev, endpoint));
-		if (ret)
-			return ret;
-		ret = usb_pipe_type_check(d->udev, usb_rcvbulkpipe(d->udev, endpoint));
-		if (ret)
-			return ret;
-	}
-	return 0;
-}
-
-static void dvb_usb_clear_halt(struct dvb_usb_device *d, u8 endpoint)
-{
-	if (endpoint) {
-		usb_clear_halt(d->udev, usb_sndbulkpipe(d->udev, endpoint));
-		usb_clear_halt(d->udev, usb_rcvbulkpipe(d->udev, endpoint));
-	}
-}
-
 static int dvb_usb_adapter_init(struct dvb_usb_device *d, short *adapter_nrs)
 {
 	struct dvb_usb_adapter *adap;
 	int ret, n, o;
 
-	ret = dvb_usb_check_bulk_endpoint(d, d->props.generic_bulk_ctrl_endpoint);
-	if (ret)
-		return ret;
-	ret = dvb_usb_check_bulk_endpoint(d, d->props.generic_bulk_ctrl_endpoint_response);
-	if (ret)
-		return ret;
 	for (n = 0; n < d->props.num_adapters; n++) {
 		adap = &d->adapter[n];
 		adap->dev = d;
@@ -132,8 +103,10 @@ static int dvb_usb_adapter_init(struct dvb_usb_device *d, short *adapter_nrs)
 	 * when reloading the driver w/o replugging the device
 	 * sometimes a timeout occurs, this helps
 	 */
-	dvb_usb_clear_halt(d, d->props.generic_bulk_ctrl_endpoint);
-	dvb_usb_clear_halt(d, d->props.generic_bulk_ctrl_endpoint_response);
+	if (d->props.generic_bulk_ctrl_endpoint != 0) {
+		usb_clear_halt(d->udev, usb_sndbulkpipe(d->udev, d->props.generic_bulk_ctrl_endpoint));
+		usb_clear_halt(d->udev, usb_rcvbulkpipe(d->udev, d->props.generic_bulk_ctrl_endpoint));
+	}
 
 	return 0;
 

