Return-Path: <stable+bounces-112277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C409BA283BB
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 06:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FD2A1655F8
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 05:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E36321D58F;
	Wed,  5 Feb 2025 05:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rq7MPOCl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A58421516C;
	Wed,  5 Feb 2025 05:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738733937; cv=none; b=qqvlt+3UClUotEcHs9j+QlCQL7mJCYBwFP25IzPX5wqlABW1CNy1QKIya3As6ErK1ZiS1vkyesgBIkDXhzdxhK7dhQpZ3gaA0CYQiNlxsy41yjbDmhX5YiEg80mnDdyN7tSq66RJm8FByTrEFYcty+kmfmzW3kx0MHr/PBzdU8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738733937; c=relaxed/simple;
	bh=mmmtL63KI3AyB8ACGMZXLbFMGxTSjUhHH43kkAGv2/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jqqkyGhthT1fvg6tChJ9zRRDXjbA6GjS66O0mWoOLZAYAPsMMzth6u9n9kfpGUvx3uqx9bZ6epO4rZnDr6zij2ibTsElF9zuQTKMBit9fzrbg+EGAbIJ4BXYeCreG4hcQYQFajgJH0PENOo5OosAl8xKiGm6dv2paWPyOpUjX70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rq7MPOCl; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f9c69aefdbso2466273a91.2;
        Tue, 04 Feb 2025 21:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738733935; x=1739338735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eN1Ju7cqAFwnwTVKwvibE6YfRh2zoexdCMGAV5/2L/g=;
        b=Rq7MPOCl5LtyYM1n0jXEB6/rZUT8qZGI1KdsYjUFV2zp+jVopTUYU41TEQBuFLQDBp
         jzROg309riJ0GT0+X8pTbjr0veFl83UY6sErhFCn7bD61xJ2t/dyrQjsUjnis3lkFKWx
         L6AvuRYdYvQFoGpyejMaqlQ9QTItOqJFFYYCswC17Tifo94MqUlR2VKkdcm+047r9XJp
         wIEa/BIOLowCYy69nR7aFwbPy4MBHDbZ3xkMsQOSUr2WuxLj6q7BfT1FZmY/U6jjNz8g
         I9RzK4fLoE4RJMnfdhYBxjPaWHkLLjCvbGr91n2K7+AjZ8pE5BAks4I3nzSYhJzqUHTI
         B+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738733935; x=1739338735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eN1Ju7cqAFwnwTVKwvibE6YfRh2zoexdCMGAV5/2L/g=;
        b=PtaLpSjc76Okh5Qw0w2KfQ4oyzjgRoGHjlrfmOyrqg2dFdOGvcwG5FnBjxDfAV4def
         c/BTpJeWl5Kvbr5NhpvFZMCoUWTTwXkv2UWh4V2l4Fvf48/YY0vBS61UmHmeWtDdPsGK
         +t8IKBzGXrqlRtpwo1tbPszZVpejIZsdqkWqnjK5urFXOIe4LHkp/GBuzXLvlDlj9R1I
         4pHZ+oRFsSUjRV+Y1fAX1XMuAet/XI433DqWTl+DmtS/KBonOjvC7bGPZNi5L8+QZFe2
         9xhqbbLoUPAtfXW4lZCsZ/I4DAhrz6l2SOIey/PfIeYwAj49mALrgtHlsqhY1t+tvjZi
         bLhA==
X-Forwarded-Encrypted: i=1; AJvYcCUN39eI8hBG9E4p0qw/uFPBGBjFck5TN/u6CtJ99wtHpWozwIVhGv3rAE19f5qq7oIw1tk9k6fx0CLImSU=@vger.kernel.org, AJvYcCVjC9rSANrXNqN2GD5Aye2b9aSoesygwFx5yppquOwo2AfkjsH+HJEi3A2x3dFTkRl5BD0SKxPg@vger.kernel.org
X-Gm-Message-State: AOJu0YyQuzfPDPjPHyPTed65BWORbj0Rmdn1DifJRVY8pmR3T57TWvKC
	h2fNwsHbcu4/TmYZy/Etc4DVOmnAhtzSWwOC/Yxjw60h2ZwHEvMrFLcYIg==
X-Gm-Gg: ASbGncsYE266gb7L4J1Jq2VGUKE8WlijTqVcMHDFueywPbXwygVYK1274ofGIaLTdKu
	Y5ym0hNuqpvLXj0RSGy/iVjENRmvwLMwlKsEw619tu99x5quL4Qmeic05wQbNtFNctj2EzB/0v3
	iCEYPk6onDFLaBo9ln5tn1IFXKmC+oPicbSDDOLO3rZByEgwxyGrx52nNwj06+WAuBltJv9CHx5
	nZ30zo0T9A4F1MlLJIzaxVgJR/V8vpKC2NhDXV8hBctrAIYRQX/l2hZhkiMDMQeXcvV6IaqlFO+
	z6uBYnHrdZvVlMzJv6YBtvGv6x/vODoOTtpdwLkj25YGDbLkZOK1YqrH1AXYgvCh8p160CwSxq0
	qLBPevXvrxm4=
X-Google-Smtp-Source: AGHT+IEYomyw+d7yZMeBpLHzzGVeiaclVRDD2/yiguAttMA4WN0cdIkvBC/4QjZzCXBTMws9LcU96A==
X-Received: by 2002:a05:6a00:10cc:b0:72f:a0fe:d5ab with SMTP id d2e1a72fcca58-7303521cb75mr2492469b3a.23.1738733934455;
        Tue, 04 Feb 2025 21:38:54 -0800 (PST)
Received: from kic-machine.localdomain (122-117-151-175.hinet-ip.hinet.net. [122.117.151.175])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6424f8csm11608434b3a.44.2025.02.04.21.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 21:38:54 -0800 (PST)
From: Kuangyi Chiang <ki.chiang65@gmail.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ki.chiang65@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v4 1/1] xhci: Correctly handle last TRB of isoc TD on Etron xHCI host
Date: Wed,  5 Feb 2025 13:37:50 +0800
Message-Id: <20250205053750.28251-2-ki.chiang65@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250205053750.28251-1-ki.chiang65@gmail.com>
References: <20250205053750.28251-1-ki.chiang65@gmail.com>
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
index 965bffce301e..936fd9151ba8 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2452,8 +2452,10 @@ static void process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
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
@@ -2468,25 +2470,36 @@ static void process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
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
@@ -2519,7 +2532,7 @@ static void process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 
 finish_td:
 	/* Don't give back TD yet if we encountered an error mid TD */
-	if (td->error_mid_td && ep_trb != td->end_trb) {
+	if (td->error_mid_td) {
 		xhci_dbg(xhci, "Error mid isoc TD, wait for final completion event\n");
 		td->urb_length_set = true;
 		return;
-- 
2.25.1


