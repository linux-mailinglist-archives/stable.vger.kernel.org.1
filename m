Return-Path: <stable+bounces-22410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 737FC85DBE9
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129741F21137
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4934677A03;
	Wed, 21 Feb 2024 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a+jEomft"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082C51E4B2;
	Wed, 21 Feb 2024 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523205; cv=none; b=b2L0pdZlvrfY0pGSv5uJnNHOE9kJr6Vt67fFk7+SOc/keEoiPnngSP1e0EzOJIWChDJ1zUFTnOWbTOFrcxcVoGK6Z9ceRRm0sjtjvk453MXS6TFviAtkv5XC7VkOhXj2MyQuvjc7vR3Qqm08tBqjeSNcgyW5kQFXvInCNOja8Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523205; c=relaxed/simple;
	bh=xS8puSolasXwKy9m2X4SqetjbC2BRBb2cZYyutOl4V0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1Rf2dtCYIeQUvoLxkXvqxyvvAsyVfl3S06+dQymkwfv+qobErgKIYSrXD+g0fCt33ZpGOyjDTutD4g/iehqRhlZUWtl2sAczmnbwWEU01vXUOS1AUsASG1/Sw/Zv9zC/syYdRExApbkOzwZfaLe3PCIio+NgTA+I0Icr1tjct4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a+jEomft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D01C433F1;
	Wed, 21 Feb 2024 13:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708523204;
	bh=xS8puSolasXwKy9m2X4SqetjbC2BRBb2cZYyutOl4V0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a+jEomfttXuhqqDurR1bAVJuK9vJHfIzxdLw7BwsXb2r42cHdyvryaCFyhS9rq0pS
	 G/E1B2yOUpxzVF2z1R8Q/BX0pK5xa6d5tXLy/boPrGhlUQsbCwgCTezMvIO4Q608Ta
	 BmF2aVvwUD22viqhbZwKtjjCBdTwzPUi3J9LzGew=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oliver Neukum <oneukum@suse.com>,
	stable <stable@kernel.org>
Subject: [PATCH 5.15 367/476] USB: hub: check for alternate port before enabling A_ALT_HNP_SUPPORT
Date: Wed, 21 Feb 2024 14:06:58 +0100
Message-ID: <20240221130021.602312434@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221130007.738356493@linuxfoundation.org>
References: <20240221130007.738356493@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit f17c34ffc792bbb520e4b61baa16b6cfc7d44b13 upstream.

The OTG 1.3 spec has the feature A_ALT_HNP_SUPPORT, which tells
a device that it is connected to the wrong port. Some devices
refuse to operate if you enable that feature, because it indicates
to them that they ought to request to be connected to another port.

According to the spec this feature may be used based only the following
three conditions:

6.5.3 a_alt_hnp_support
Setting this feature indicates to the B-device that it is connected to
an A-device port that is not capable of HNP, but that the A-device does
have an alternate port that is capable of HNP.
The A-device is required to set this feature under the following conditions:
• the A-device has multiple receptacles
• the A-device port that connects to the B-device does not support HNP
• the A-device has another port that does support HNP

A check for the third and first condition is missing. Add it.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Cc: stable <stable@kernel.org>
Fixes: 7d2d641c44269 ("usb: otg: don't set a_alt_hnp_support feature for OTG 2.0 device")
Link: https://lore.kernel.org/r/20240122153545.12284-1-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/hub.c |   30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2368,17 +2368,25 @@ static int usb_enumerate_device_otg(stru
 			}
 		} else if (desc->bLength == sizeof
 				(struct usb_otg_descriptor)) {
-			/* Set a_alt_hnp_support for legacy otg device */
-			err = usb_control_msg(udev,
-				usb_sndctrlpipe(udev, 0),
-				USB_REQ_SET_FEATURE, 0,
-				USB_DEVICE_A_ALT_HNP_SUPPORT,
-				0, NULL, 0,
-				USB_CTRL_SET_TIMEOUT);
-			if (err < 0)
-				dev_err(&udev->dev,
-					"set a_alt_hnp_support failed: %d\n",
-					err);
+			/*
+			 * We are operating on a legacy OTP device
+			 * These should be told that they are operating
+			 * on the wrong port if we have another port that does
+			 * support HNP
+			 */
+			if (bus->otg_port != 0) {
+				/* Set a_alt_hnp_support for legacy otg device */
+				err = usb_control_msg(udev,
+					usb_sndctrlpipe(udev, 0),
+					USB_REQ_SET_FEATURE, 0,
+					USB_DEVICE_A_ALT_HNP_SUPPORT,
+					0, NULL, 0,
+					USB_CTRL_SET_TIMEOUT);
+				if (err < 0)
+					dev_err(&udev->dev,
+						"set a_alt_hnp_support failed: %d\n",
+						err);
+			}
 		}
 	}
 #endif



