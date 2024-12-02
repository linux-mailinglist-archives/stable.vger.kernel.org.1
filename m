Return-Path: <stable+bounces-95921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0B39DFA1C
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 06:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7538916255B
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 05:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621601F8AC5;
	Mon,  2 Dec 2024 05:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqWByXWs"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A177829405;
	Mon,  2 Dec 2024 05:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733115775; cv=none; b=QLOeLhYbCcPqGLn2K0cHuAVki4eSrByAWazT2lw0ewxkh7ToIC1zbkv2h5qgizLohhZACVZ1F8LEc7Yb5Q1MbCbmBTgBFlDivGHu5ef3Mi09jiWL1L160QJRbYswncGsNToYJNYN0OtqgGagFL5NQE4opTXDRFUqNYLJWkVQSOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733115775; c=relaxed/simple;
	bh=ZKE4oBnv2zgZSOkrAz0gDCFV2yg+msHydNjhYsmKTvg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mm6xMn/uBpdhcVMfA9jpUZ+eveJU0IE9rCGMifphsmTBxLZSFlaVInK80Ddfu60lu0HBNjQdmK8bbOUeNVf5G810Y+S0nrkZ1PgA7fYQqNEx6lCw42XhORqB5whK6wpJ4Qz7BJF4PnAjurvJF7ZdmoWO6r7Rzkq6ZpUAaNCm5Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqWByXWs; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-724e1b08fc7so3196432b3a.0;
        Sun, 01 Dec 2024 21:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733115773; x=1733720573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qx68TBqcI43nbGrz81Z92Q+4nosmkljQ413S8BW5BMc=;
        b=ZqWByXWsf4lSOcvJIncClnJlAEC3piG5F7cLfzYDhwSLC4sGoA66lsJwa/7acm14zb
         nbdvd4Etlp3hnPTFSI7zeCygGpJB/0OpuIqRRyh+9gfCCsqrGtnTboADcQYj5+CnbkRV
         A3pnALciumEx0HrGYdz3an6PwrUVlLb/yOwx9Dmao1iZD+20OxiKQdid08QE1k3ut54k
         oj7J0PlV6q0M2lN8MiYUrWPkK8bCo7LHBkQCMdpgqGLONewOOY0QAal/PtSzgyQ21iUw
         4Fv+94Kxf8PEv0R03Zhf+2c5M6ZmLLpKD27xfFOUaq0gSAKYNVK9iEO6WgqGZ5Ot46c5
         ESfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733115773; x=1733720573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qx68TBqcI43nbGrz81Z92Q+4nosmkljQ413S8BW5BMc=;
        b=nU1N2Z9v+h6rw/qI/ch99NFz2nEABqeRO83GXENYCRqCp+8FNR8Woq4PYxUrX5N+U5
         xdQKTCmBbrL2iVTwCsEhrmiZAYqLM7cXImVqKnfYOfyqSYjjXeVQnHS3nyB9CcHTnR0c
         p+3LlkDU3qbaXUgrZHM5lTSvi9LmO/PHs7tfdqC5hrDXGMmUilD7Jd4/1JhNmlDVrbbv
         1LjCtvZs8MKHd/pAwly2klrH+RPC6luxJrhndORvBRSnTnFv9OfnetsNkWdGgL99tl2l
         XYw5MryVFuxyz9tuKvN8jwh0IEtYbBgSIh1dyLS3YWY5oq+w+Aou8YKs/mOd8+BcRA3a
         xYFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsew7gkaDqeDbuGQi+W52StEfLzT16qhyXUEh+8YlkxG6Ra0g9aOZjv+nM8zy7YVKWH6wa5Lf78vGw/0g=@vger.kernel.org, AJvYcCVRDIPhBVRfvEfdAx0hwMQcyBKXjYXA5S68pLZolHiJtXIW7FymsPEytJRIIa+wwW/Yvc/ew/ZZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzqqkX3EgJQMAZLgO3Yu2LT0F4b7gMfu4e6Ce7nkQ3B0EUg5eaF
	7SrmUDrHGaY81zXUuw70todzbaboVqF1P3J7vEFHHaEAme8XTnPt
X-Gm-Gg: ASbGncvSA2lkdZYjRwPDuwcFd7mqq1pqcQE+kuYVw4ipX0hLpd4YgIok/WdjCsPA4Sm
	a/qKtyD/zL+ALSpo3fakPC0iKVHIELjwPSpOxci5iTzqTcqK/U/MPqQq5WTOIzf2XOqmsMrO6SD
	1c++qS3bEY5IKdKV2ku3yLtroA3NGowcAg93plHDtu6i3p1bCyKAQ3y8KWbVuxlB+KTYyXeje8f
	m0WFS65u5WBEwhbWkXOyEsdTyWZIXmV8ZNylPR8w51TT/XDJT9gfVYD0MUz0ktvsKGrE3zK+kLW
	B5ofnweNGP+Y9LtCaFzNLhdlX7zKW7u/5gGGYGkLgw==
X-Google-Smtp-Source: AGHT+IG4RCG80JO6KMFQtqzlF/lutuiuR7st5PdiP4x6BLlxx5oqoUleTr4ZWIVBDMLICtBD+NHVdQ==
X-Received: by 2002:a05:6a00:3cc9:b0:724:e80a:330 with SMTP id d2e1a72fcca58-7252ffd85d9mr33220853b3a.5.1733115772724;
        Sun, 01 Dec 2024 21:02:52 -0800 (PST)
Received: from kic-machine.localdomain (122-117-151-175.hinet-ip.hinet.net. [122.117.151.175])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c3034c8sm6844302a12.31.2024.12.01.21.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 21:02:52 -0800 (PST)
From: Kuangyi Chiang <ki.chiang65@gmail.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ki.chiang65@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3 1/1] xhci: Correctly handle last TRB of isoc TD on Etron xHCI host
Date: Mon,  2 Dec 2024 13:01:35 +0800
Message-Id: <20241202050135.13504-2-ki.chiang65@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241202050135.13504-1-ki.chiang65@gmail.com>
References: <20241202050135.13504-1-ki.chiang65@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unplugging a USB3.0 webcam while streaming results in errors like this:

[ 132.646387] xhci_hcd 0000:03:00.0: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 18 comp_code 13
[ 132.646446] xhci_hcd 0000:03:00.0: Looking for event-dma 000000002fdf8630 trb-start 000000002fdf8640 trb-end 000000002fdf8650 seg-start 000000002fdf8000 seg-end 000000002fdf8ff0
[ 132.646560] xhci_hcd 0000:03:00.0: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 18 comp_code 13
[ 132.646568] xhci_hcd 0000:03:00.0: Looking for event-dma 000000002fdf8660 trb-start 000000002fdf8670 trb-end 000000002fdf8670 seg-start 000000002fdf8000 seg-end 000000002fdf8ff0

If an error is detected while processing the last TRB of an isoc TD,
the Etron xHC generates two transfer events for the TRB where the
error was detected. The first event can be any sort of error (like
USB Transaction or Babble Detected, etc), and the final event is
Success.

The xHCI driver will handle the TD after the first event and remove it
from its internal list, and then print an "Transfer event TRB DMA ptr
not part of current TD" error message after the final event.

Commit 5372c65e1311 ("xhci: process isoc TD properly when there was a
transaction error mid TD.") is designed to address isoc transaction
errors, but unfortunately it doesn't account for this scenario.

To work around this by reusing the logic that handles isoc transaction
errors, but continuing to wait for the final event when this condition
occurs. Sometimes we see the Stopped event after an error mid TD, this
is a normal event for a pending TD and we can think of it as the final
event we are waiting for.

Check if the XHCI_ETRON_HOST quirk flag is set before invoking the
workaround in process_isoc_td().

Fixes: 5372c65e1311 ("xhci: process isoc TD properly when there was a transaction error mid TD.")
Cc: <stable@vger.kernel.org>
Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 4cf5363875c7..a51eb3526ae3 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2450,8 +2450,10 @@ static void process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 	switch (trb_comp_code) {
 	case COMP_SUCCESS:
 		/* Don't overwrite status if TD had an error, see xHCI 4.9.1 */
-		if (td->error_mid_td)
+		if (td->error_mid_td) {
+			td->error_mid_td = false;
 			break;
+		}
 		if (remaining) {
 			frame->status = short_framestatus;
 			sum_trbs_for_length = true;
@@ -2466,25 +2468,36 @@ static void process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 	case COMP_BANDWIDTH_OVERRUN_ERROR:
 		frame->status = -ECOMM;
 		break;
+	case COMP_USB_TRANSACTION_ERROR:
 	case COMP_BABBLE_DETECTED_ERROR:
 		sum_trbs_for_length = true;
 		fallthrough;
 	case COMP_ISOCH_BUFFER_OVERRUN:
 		frame->status = -EOVERFLOW;
+		if (trb_comp_code == COMP_USB_TRANSACTION_ERROR)
+			frame->status = -EPROTO;
 		if (ep_trb != td->end_trb)
 			td->error_mid_td = true;
+		else
+			td->error_mid_td = false;
+
+		/*
+		 * If an error is detected on the last TRB of the TD,
+		 * wait for the final event.
+		 */
+		if ((xhci->quirks & XHCI_ETRON_HOST) &&
+		    td->urb->dev->speed >= USB_SPEED_SUPER &&
+		    ep_trb == td->end_trb)
+			td->error_mid_td = true;
 		break;
 	case COMP_INCOMPATIBLE_DEVICE_ERROR:
 	case COMP_STALL_ERROR:
 		frame->status = -EPROTO;
 		break;
-	case COMP_USB_TRANSACTION_ERROR:
-		frame->status = -EPROTO;
-		sum_trbs_for_length = true;
-		if (ep_trb != td->end_trb)
-			td->error_mid_td = true;
-		break;
 	case COMP_STOPPED:
+		/* Think of it as the final event if TD had an error */
+		if (td->error_mid_td)
+			td->error_mid_td = false;
 		sum_trbs_for_length = true;
 		break;
 	case COMP_STOPPED_SHORT_PACKET:
@@ -2517,7 +2530,7 @@ static void process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 
 finish_td:
 	/* Don't give back TD yet if we encountered an error mid TD */
-	if (td->error_mid_td && ep_trb != td->end_trb) {
+	if (td->error_mid_td) {
 		xhci_dbg(xhci, "Error mid isoc TD, wait for final completion event\n");
 		td->urb_length_set = true;
 		return;
-- 
2.25.1


