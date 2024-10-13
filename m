Return-Path: <stable+bounces-83646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA53799BA0F
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 17:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25712B21001
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 15:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C180146A83;
	Sun, 13 Oct 2024 15:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rAByCOkM"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD9014600F
	for <Stable@vger.kernel.org>; Sun, 13 Oct 2024 15:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728833246; cv=none; b=e362WE9mrO9vmWtasHySaLeEKPhDUD4qYIfAKoe6PQN15dl23n7aPm4osmUZBDtmRLhAmUE/FVae6os3dXesF5liVdrwUdrpNHS+SUpnMmSLIx6Mk9Lg0rwJr0ayUXkd3d1B7gglprYyGTMFg3izsSFiI9zRuJfmK5p2jJaUfQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728833246; c=relaxed/simple;
	bh=nrpckQPbJ2S0SkXLO5lo68MQrOXTxv/TDnX9S5CRT+0=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=E7UbZ3EqSyCV3yyBptdjmJ2XdEwfu6aBwNvlbQ/0WZl150kxcv2kwAA6tI/n8NYl9f39//wmYDSbNOwb5vlgtYslHDfj/btykRb9V5bacen7JAJ4xSzlJKgnlzD/9nn3Pi6wSGuac5Ri3NgAwUKeiR9pGzw1sJYQ4RfqPxplYlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rAByCOkM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBF7C4CEC5;
	Sun, 13 Oct 2024 15:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728833246;
	bh=nrpckQPbJ2S0SkXLO5lo68MQrOXTxv/TDnX9S5CRT+0=;
	h=Subject:To:From:Date:From;
	b=rAByCOkMGZUEDjHBlr0IZit3fmbWv18Jx80a1kVHLASwFR+4FTyHgkRZSYfjocpGD
	 bBP5UC7aoPB8VbkXsVTleA3jSmQW68ArvTLwhnKTp8YxH1RrG9/bGU1MpzgpvyD5kN
	 OjuUDHAhM0AdM/dcANUj3Q9KR4d3bI52EpAe8oRg=
Subject: patch "iio: hid-sensors: Fix an error handling path in" added to char-misc-linus
To: christophe.jaillet@wanadoo.fr,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,srinivas.pandruvada@linux.intel.com
From: <gregkh@linuxfoundation.org>
Date: Sun, 13 Oct 2024 17:26:07 +0200
Message-ID: <2024101307-shorty-simmering-d20b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: hid-sensors: Fix an error handling path in

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 3a29b84cf7fbf912a6ab1b9c886746f02b74ea25 Mon Sep 17 00:00:00 2001
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Thu, 3 Oct 2024 20:41:12 +0200
Subject: iio: hid-sensors: Fix an error handling path in
 _hid_sensor_set_report_latency()

If hid_sensor_set_report_latency() fails, the error code should be returned
instead of a value likely to be interpreted as 'success'.

Fixes: 138bc7969c24 ("iio: hid-sensor-hub: Implement batch mode")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/c50640665f091a04086e5092cf50f73f2055107a.1727980825.git.christophe.jaillet@wanadoo.fr
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index ad8910e6ad59..abb09fefc792 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -32,7 +32,7 @@ static ssize_t _hid_sensor_set_report_latency(struct device *dev,
 	latency = integer * 1000 + fract / 1000;
 	ret = hid_sensor_set_report_latency(attrb, latency);
 	if (ret < 0)
-		return len;
+		return ret;
 
 	attrb->latency_ms = hid_sensor_get_report_latency(attrb);
 
-- 
2.47.0



