Return-Path: <stable+bounces-73291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8056F96D42E
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 11:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1BEAB27A3A
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE301198A33;
	Thu,  5 Sep 2024 09:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mTGqE3GG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8253198A01;
	Thu,  5 Sep 2024 09:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529754; cv=none; b=gHLVmhLCBEDemXnrdEnp6AsOvqOxAQJ24EIsSH+CZflrndoe4fHCnAUVdx/gCq0SY7Tl35q6J9r221Jl0nQIkv1Am9f6QrytiH/bejBXu4t23thff7NFZHLqzJGGgS9fnrf7AnOBESC7IZkHdmh0lhxcbY4hkoih2MWxG7ZlWHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529754; c=relaxed/simple;
	bh=3zxn/jqeJ2XZvvT0booUKuF9CFJ9aI1eArZW5zY5r2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWKCwWyM0Be6/CAfzgKnSo87bo5z98V8kbgtx6ieZ2hvM3FYk2MuW3zdG59h5qOmTz2lFIhSnCWEuZ/cCS5TOgLzBD0+EGs6NI6HRPhd8rFVGUUrfgvBotv0UqemmshgWgC0w4No2O1EkJdNzO5v36cTqdCvwsng5LRObIrOY/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mTGqE3GG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FA8C4CEC3;
	Thu,  5 Sep 2024 09:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725529754;
	bh=3zxn/jqeJ2XZvvT0booUKuF9CFJ9aI1eArZW5zY5r2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mTGqE3GGCB47iXL4A1FKZnTJW7YBZcx9WQw8IPuiFhTWDLEf0UT0U1I0lCGZsh1wz
	 92/XHUBSsMTz3gvOUHTCgC5MPbzO74aq013zbulTWCHgSIsThzkbmer6axiofrQ5VR
	 /9FpYj3enqakLKXbMfxndmW8z/+EbpkASb8d9kWE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simon Holesch <simon@holesch.de>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Hongren Zheng <i@zenithal.me>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 133/184] usbip: Dont submit special requests twice
Date: Thu,  5 Sep 2024 11:40:46 +0200
Message-ID: <20240905093737.415509982@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905093732.239411633@linuxfoundation.org>
References: <20240905093732.239411633@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Simon Holesch <simon@holesch.de>

[ Upstream commit 8b6b386f9aa936ed0c190446c71cf59d4a507690 ]

Skip submitting URBs, when identical requests were already sent in
tweak_special_requests(). Instead call the completion handler directly
to return the result of the URB.

Even though submitting those requests twice should be harmless, there
are USB devices that react poorly to some duplicated requests.

One example is the ChipIdea controller implementation in U-Boot: The
second SET_CONFIGURATION request makes U-Boot disable and re-enable all
endpoints. Re-enabling an endpoint in the ChipIdea controller, however,
was broken until U-Boot commit b272c8792502 ("usb: ci: Fix gadget
reinit").

Signed-off-by: Simon Holesch <simon@holesch.de>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Hongren Zheng <i@zenithal.me>
Tested-by: Hongren Zheng <i@zenithal.me>
Link: https://lore.kernel.org/r/20240519141922.171460-1-simon@holesch.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/usbip/stub_rx.c | 77 ++++++++++++++++++++++++-------------
 1 file changed, 50 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
index fc01b31bbb87..6338d818bc8b 100644
--- a/drivers/usb/usbip/stub_rx.c
+++ b/drivers/usb/usbip/stub_rx.c
@@ -144,53 +144,62 @@ static int tweak_set_configuration_cmd(struct urb *urb)
 	if (err && err != -ENODEV)
 		dev_err(&sdev->udev->dev, "can't set config #%d, error %d\n",
 			config, err);
-	return 0;
+	return err;
 }
 
 static int tweak_reset_device_cmd(struct urb *urb)
 {
 	struct stub_priv *priv = (struct stub_priv *) urb->context;
 	struct stub_device *sdev = priv->sdev;
+	int err;
 
 	dev_info(&urb->dev->dev, "usb_queue_reset_device\n");
 
-	if (usb_lock_device_for_reset(sdev->udev, NULL) < 0) {
+	err = usb_lock_device_for_reset(sdev->udev, NULL);
+	if (err < 0) {
 		dev_err(&urb->dev->dev, "could not obtain lock to reset device\n");
-		return 0;
+		return err;
 	}
-	usb_reset_device(sdev->udev);
+	err = usb_reset_device(sdev->udev);
 	usb_unlock_device(sdev->udev);
 
-	return 0;
+	return err;
 }
 
 /*
  * clear_halt, set_interface, and set_configuration require special tricks.
+ * Returns 1 if request was tweaked, 0 otherwise.
  */
-static void tweak_special_requests(struct urb *urb)
+static int tweak_special_requests(struct urb *urb)
 {
+	int err;
+
 	if (!urb || !urb->setup_packet)
-		return;
+		return 0;
 
 	if (usb_pipetype(urb->pipe) != PIPE_CONTROL)
-		return;
+		return 0;
 
 	if (is_clear_halt_cmd(urb))
 		/* tweak clear_halt */
-		 tweak_clear_halt_cmd(urb);
+		err = tweak_clear_halt_cmd(urb);
 
 	else if (is_set_interface_cmd(urb))
 		/* tweak set_interface */
-		tweak_set_interface_cmd(urb);
+		err = tweak_set_interface_cmd(urb);
 
 	else if (is_set_configuration_cmd(urb))
 		/* tweak set_configuration */
-		tweak_set_configuration_cmd(urb);
+		err = tweak_set_configuration_cmd(urb);
 
 	else if (is_reset_device_cmd(urb))
-		tweak_reset_device_cmd(urb);
-	else
+		err = tweak_reset_device_cmd(urb);
+	else {
 		usbip_dbg_stub_rx("no need to tweak\n");
+		return 0;
+	}
+
+	return !err;
 }
 
 /*
@@ -468,6 +477,7 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
 	int support_sg = 1;
 	int np = 0;
 	int ret, i;
+	int is_tweaked;
 
 	if (pipe == -1)
 		return;
@@ -580,8 +590,11 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
 		priv->urbs[i]->pipe = pipe;
 		priv->urbs[i]->complete = stub_complete;
 
-		/* no need to submit an intercepted request, but harmless? */
-		tweak_special_requests(priv->urbs[i]);
+		/*
+		 * all URBs belong to a single PDU, so a global is_tweaked flag is
+		 * enough
+		 */
+		is_tweaked = tweak_special_requests(priv->urbs[i]);
 
 		masking_bogus_flags(priv->urbs[i]);
 	}
@@ -594,22 +607,32 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
 
 	/* urb is now ready to submit */
 	for (i = 0; i < priv->num_urbs; i++) {
-		ret = usb_submit_urb(priv->urbs[i], GFP_KERNEL);
+		if (!is_tweaked) {
+			ret = usb_submit_urb(priv->urbs[i], GFP_KERNEL);
 
-		if (ret == 0)
-			usbip_dbg_stub_rx("submit urb ok, seqnum %u\n",
-					pdu->base.seqnum);
-		else {
-			dev_err(&udev->dev, "submit_urb error, %d\n", ret);
-			usbip_dump_header(pdu);
-			usbip_dump_urb(priv->urbs[i]);
+			if (ret == 0)
+				usbip_dbg_stub_rx("submit urb ok, seqnum %u\n",
+						pdu->base.seqnum);
+			else {
+				dev_err(&udev->dev, "submit_urb error, %d\n", ret);
+				usbip_dump_header(pdu);
+				usbip_dump_urb(priv->urbs[i]);
 
+				/*
+				 * Pessimistic.
+				 * This connection will be discarded.
+				 */
+				usbip_event_add(ud, SDEV_EVENT_ERROR_SUBMIT);
+				break;
+			}
+		} else {
 			/*
-			 * Pessimistic.
-			 * This connection will be discarded.
+			 * An identical URB was already submitted in
+			 * tweak_special_requests(). Skip submitting this URB to not
+			 * duplicate the request.
 			 */
-			usbip_event_add(ud, SDEV_EVENT_ERROR_SUBMIT);
-			break;
+			priv->urbs[i]->status = 0;
+			stub_complete(priv->urbs[i]);
 		}
 	}
 
-- 
2.43.0




