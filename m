Return-Path: <stable+bounces-114909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6288FA30BCD
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 13:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1459188A7F3
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 12:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4ED1FCFE5;
	Tue, 11 Feb 2025 12:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kvji4oGh"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB206FB9;
	Tue, 11 Feb 2025 12:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739277383; cv=none; b=YkQOLMO9/fOuBOpdwwUUvkdVsWTRQVM1jZhgKrcIe4uJvqs1QVwnPRlTimSPnZMhAV/ss2kYatSog7WJ/8QBvsGt9vyLpvCp4iivh9k3BnDX/z301yUuLDUjPpELVbLLfnu6J11JczEN3HT7KFVDjpR532d4gznKy6+VaBzThNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739277383; c=relaxed/simple;
	bh=sZG1112UKEcmLgh4KS5IXeQ2vd73nCQ0xdUMTVgWqJU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f58T2mF+y+QP9j3efZ6Bk2IJF0opWm+f59zd5MfKuw1R2v6bUzNZsI3UKcW7NLsBxfH6sNfc9HUVO+ftrkiIjwOZsoW13ulcwPu3aoPdo9XvkWXIO0bK6APQbgFzx7BRX8r97DAJwrYF3pcVtQrhI+FdPiiaAld78c0tinzl2Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kvji4oGh; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab7ca64da5dso310178266b.0;
        Tue, 11 Feb 2025 04:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739277380; x=1739882180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bP5m1MKlTrOTM+BW8w3Lgsy0b/m3aaXuVq/Pw4K70rk=;
        b=Kvji4oGhY17Z/QKNyOGH7TGlTvQVHHV+22FCuc3dpVfsFktxrzuNYVvLBSuY5ox5t+
         EPgniFD/2lGTcQMRyNnJSLtqS/InpD6D8v8fXFpV0SchmKXBL1lGJV5XPzxaT8yltABe
         o8eDYtqgDizWP8UfqABpO4MwZ4Bsq1MHB/jtWl2s3D8kcdam8chJN9LliXefkZaRUd4c
         9dk2T9IT6owxph2UHNp4Lia/gd4oBlYBreDF3U20DmfnzwMANHGxFQlIufqEE6p7FFOu
         3xq0OWQ+E7kqnngXnRa9PzsT+h5hPjsqXRjspnydlBN4WfdeDRcbn/oYKRDiJEfHrFok
         QjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739277380; x=1739882180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bP5m1MKlTrOTM+BW8w3Lgsy0b/m3aaXuVq/Pw4K70rk=;
        b=r2ddIevwnHojHDm56iiV+AiJ7y9FNdmrlyqczsrPdJ+uJBkZTr4sesLpBXa9Kpz+B4
         uZaPSH5ZifpnvQxud1sbDDwgkJqnEcG2jRvIj0kwhUdBrZbv060v7fYl9gsh51W033uD
         H/dYXk+PcPz1Z+WyG7+WKK6LVgP4wFpnIAZWoQGMY7Og774Nc1hRivEIf8rY4qHB8mzz
         hssUA14q2HH45xinkVcKiBwhE1FUaYImQt0BjEDMDABDsDZEGKU7QyqaNp0IzzkLNUQV
         OEWA0p/ohzoNqTydwvlSShns9rFeLi2a97HFyZVnr2VGnAKZ/QqzGvjHZqgEEi1bTfgB
         OQdg==
X-Forwarded-Encrypted: i=1; AJvYcCVP8R+u/9wTq5i7Lfr086xpOnzAaKlFFEKoPaqFhR9MTEFGsTLgUkDdLtImjR0rcOpMAnoCUpxwy6sO/uQ=@vger.kernel.org, AJvYcCVaSBdu/XM44uUpF775IqWZLMfF14lUA7Rg/SMP0exBXWhm1DeW1WSeFzV15fb13jysO8p0p8vT@vger.kernel.org, AJvYcCWmHGFhRtbtF9Q24X5VXEhFFPBaEln7qkaNkToXXEXVmGmC5exmxZK8p/3IVUopEHwKud5AI/mOdxzX@vger.kernel.org
X-Gm-Message-State: AOJu0YylfHmc3QnLDdCekLJnG/nU7pZ3ZfuiA+7FC8WRiHfWU7zufmNW
	Eq435nGpb2YGLN0D69jZW2F5bZLyS54QGclFlbr14kyYxGx4/IEx
X-Gm-Gg: ASbGnct+SFoF+Yom4aJnS4cmETuLhjr0wgF0i659hW8IGAO6UeBbwfQA8Z6K3Tc0AYU
	YBDjxABwLchEh99WSMvYel/XZwa7ykSU0Vfmyv/6985tNl3IyRDP1maq3ocGJfFI8Fo3dcZMXXE
	sTYS432XdM3MJTFT4YGVMZNQdsE++EqUrAsHd1zgSTdVvumPUSn+O4SqiFHKEXyunoQLrslaIhn
	TxOTaODAnAivI+5x6MxDltnhEiFqKiO4ghTGdLiUoQEOGx8jgvHtJjw6El2MNgNMx0v+Eknw6s9
	vhs5idATFhT3/vz5ZhLoNb2J5QT90KJj
X-Google-Smtp-Source: AGHT+IGTQCQjV5wM3AQyayoBB6ZBZZQoah7NqJFP8fRvEp4YFg+UYl4JLydhWL7qT31mKO1xEQp6Aw==
X-Received: by 2002:a17:907:a78a:b0:ab7:843c:2cbb with SMTP id a640c23a62f3a-ab7daf31171mr259405066b.11.1739277379803;
        Tue, 11 Feb 2025 04:36:19 -0800 (PST)
Received: from foxbook (adtq181.neoplus.adsl.tpnet.pl. [79.185.228.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab79d28723esm747793166b.64.2025.02.11.04.36.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Feb 2025 04:36:19 -0800 (PST)
Date: Tue, 11 Feb 2025 13:36:14 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: gregkh@linuxfoundation.org, ki.chiang65@gmail.com,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 mathias.nyman@intel.com, stable@vger.kernel.org
Subject: [PATCH] usb: xhci: Handle quirky SuperSpeed isoc error reporting by
 Etron HCs
Message-ID: <20250211133614.5d64301f@foxbook>
In-Reply-To: <20250210095736.6607f098@foxbook>
References: <20250205234205.73ca4ff8@foxbook>
	<b19218ab-5248-47ba-8111-157818415247@linux.intel.com>
	<20250210095736.6607f098@foxbook>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

xHCI 4.9.1 requires HCs to obey the IOC flag we set on the last TRB even
after an error has been reported on an earlier TRB. This typically means
that an error mid TD is followed by a success event for the last TRB.

On SuperSpeed (and only SS) isochronous endpoints Etron hosts were found
to emit a success event also after an error on the last TRB of a TD.

Reuse the machinery for handling errors mid TD to handle these otherwise
unexpected events. Avoid printing "TRB not part of current TD" errors,
ensure proper tracking of HC's internal dequeue pointer and distinguish
this known quirk from other bogus events caused by ordinary bugs.

This patch was found to eliminate all related warnings and errors while
running for 30 minutes with a UVC camera on a flaky cable which produces
transaction errors about every second. An altsetting was chosen which
causes some TDs to be multi-TRB, dynamic debug was used to confirm that
errors both mid TD and on the last TRB are handled as expected:

[ 6028.439776] xhci_hcd 0000:06:00.0: Transfer error for slot 1 ep 2 on endpoint
[ 6028.439784] xhci_hcd 0000:06:00.0: Error 4 mid isoc TD, wait for final completion event, is_last_trb=1
[ 6028.440268] xhci_hcd 0000:06:00.0: Successful completion on short TX for slot 1 ep 2 with last td short 0
[ 6028.440270] xhci_hcd 0000:06:00.0: Got event 1 after mid TD error
[ 6029.123683] xhci_hcd 0000:06:00.0: Transfer error for slot 1 ep 2 on endpoint
[ 6029.123694] xhci_hcd 0000:06:00.0: Error 4 mid isoc TD, wait for final completion event, is_last_trb=0
[ 6029.123697] xhci_hcd 0000:06:00.0: Successful completion on short TX for slot 1 ep 2 with last td short 0
[ 6029.123700] xhci_hcd 0000:06:00.0: Got event 1 after mid TD error

Handling of Stopped events is unaffected: finish_td() is called but it
does nothing and the TD waits until it's unlinked:

[ 7081.705544] xhci_hcd 0000:06:00.0: Transfer error for slot 1 ep 2 on endpoint
[ 7081.705546] xhci_hcd 0000:06:00.0: Error 4 mid isoc TD, wait for final completion event, is_last_trb=1
[ 7081.705630] xhci_hcd 0000:06:00.0: Stopped on Transfer TRB for slot 1 ep 2
[ 7081.705633] xhci_hcd 0000:06:00.0: Got event 26 after mid TD error
[ 7081.705678] xhci_hcd 0000:06:00.0: Stopped on Transfer TRB for slot 1 ep 2
[ 7081.705680] xhci_hcd 0000:06:00.0: Got event 26 after mid TD error
[ 7081.705759] xhci_hcd 0000:06:00.0: Stopped on No-op or Link TRB for slot 1 ep 2
[ 7081.705799] xhci_hcd 0000:06:00.0: Stopped on No-op or Link TRB for slot 1 ep 2

Reported-by: Kuangyi Chiang <ki.chiang65@gmail.com>
Closes: https://lore.kernel.org/linux-usb/20250205053750.28251-1-ki.chiang65@gmail.com/T/
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---



Hi Mathias,

This is the best I was able to do. It does add a few lines, but I don't
think it's too scary and IMO the switch looks even better this way. It
accurately predicts those events while not breaking anything else that
I can see or think of, save for the risk of firmware bugfix adding one
ESIT of latency on errors.

I tried to also test your Etron patch but it has whitespace damage all
over the place and would be hard to apply.

Regards,
Michal


 drivers/usb/host/xhci-ring.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 965bffce301e..7ff5075e5890 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2437,6 +2437,7 @@ static void process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 	bool sum_trbs_for_length = false;
 	u32 remaining, requested, ep_trb_len;
 	int short_framestatus;
+	bool error_event = false, etron_quirk = false;
 
 	trb_comp_code = GET_COMP_CODE(le32_to_cpu(event->transfer_len));
 	urb_priv = td->urb->hcpriv;
@@ -2473,8 +2474,7 @@ static void process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		fallthrough;
 	case COMP_ISOCH_BUFFER_OVERRUN:
 		frame->status = -EOVERFLOW;
-		if (ep_trb != td->end_trb)
-			td->error_mid_td = true;
+		error_event = true;
 		break;
 	case COMP_INCOMPATIBLE_DEVICE_ERROR:
 	case COMP_STALL_ERROR:
@@ -2483,8 +2483,7 @@ static void process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 	case COMP_USB_TRANSACTION_ERROR:
 		frame->status = -EPROTO;
 		sum_trbs_for_length = true;
-		if (ep_trb != td->end_trb)
-			td->error_mid_td = true;
+		error_event = true;
 		break;
 	case COMP_STOPPED:
 		sum_trbs_for_length = true;
@@ -2518,8 +2517,17 @@ static void process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 	td->urb->actual_length += frame->actual_length;
 
 finish_td:
+	/* An error event mid TD will be followed by more events, xHCI 4.9.1 */
+	td->error_mid_td |= error_event && (ep_trb != td->end_trb);
+
+	/* Etron treats *all* SuperSpeed isoc errors like errors mid TD */
+	if (xhci->quirks & XHCI_ETRON_HOST && td->urb->dev->speed == USB_SPEED_SUPER) {
+		td->error_mid_td |= error_event;
+		etron_quirk |= error_event;
+	}
+
 	/* Don't give back TD yet if we encountered an error mid TD */
-	if (td->error_mid_td && ep_trb != td->end_trb) {
+	if (td->error_mid_td && (ep_trb != td->end_trb || etron_quirk)) {
 		xhci_dbg(xhci, "Error mid isoc TD, wait for final completion event\n");
 		td->urb_length_set = true;
 		return;
-- 
2.48.1

