Return-Path: <stable+bounces-163502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A414DB0C010
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 11:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D45E117E6F0
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 09:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59AC28DF3F;
	Mon, 21 Jul 2025 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z2o9/WSh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6932728DB4E
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753089594; cv=none; b=G2cwi+80Tb7WGjopJyQzTP0wxMLt0WYb8Y2mdMFBnieuK+QbPCNxmQJQHd56UnmbneJNio5L7nCD7P8SteiP2xmeh7RZOHoLeiYXIQEaUP6piP/0Hb14pC1Ukjmq74XnpEeGyhK4IjrW6x8qv33RZfxoI7zCSddix0q0U4ACh+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753089594; c=relaxed/simple;
	bh=YCNrnYH4TqpHILoZAhk5ybo7OzaLnsDbP2t8ss+9wow=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CJuGbgRtWdyKMyWucfYS0NqXk7/31VAVz/wKFyrIU0/5TmrSnKjTG3tZI2tKRs/2jrXE8KU/3+Jv1xck/eX+Q2yecCmSf7i9IHi9pf00iRHTyrSVHCOVqB8Xyj1UpvOoVN4czVw3HIIT9l7zrDU5ChCulG4wP8XavSfWu0JtyG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z2o9/WSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0A4C4CEED;
	Mon, 21 Jul 2025 09:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753089594;
	bh=YCNrnYH4TqpHILoZAhk5ybo7OzaLnsDbP2t8ss+9wow=;
	h=Subject:To:Cc:From:Date:From;
	b=z2o9/WSha2X2AtkKzrzuJxZJ7bFD1+Mf8cajjz9otYzmyVob1hXpHlrVxuz0bPAB6
	 d6UDd+c6+OzmxAGjocem/rLhIZEMzNc8v7l3PP563woUPCgeoYY+iVnfwFOFteAtyz
	 8tRusNU51Y8JWAaE06ik5H7o4dAMi5JlSiLGz6aU=
Subject: FAILED: patch "[PATCH] usb: musb: fix gadget state on disconnect" failed to apply to 5.4-stable tree
To: drew.hamilton@zetier.com,gregkh@linuxfoundation.org,yehowshua.immanuel@twosixtech.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Jul 2025 11:19:33 +0200
Message-ID: <2025072133-unwatched-pushy-6a36@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 67a59f82196c8c4f50c83329f0577acfb1349b50
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072133-unwatched-pushy-6a36@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 67a59f82196c8c4f50c83329f0577acfb1349b50 Mon Sep 17 00:00:00 2001
From: Drew Hamilton <drew.hamilton@zetier.com>
Date: Tue, 1 Jul 2025 11:41:26 -0400
Subject: [PATCH] usb: musb: fix gadget state on disconnect

When unplugging the USB cable or disconnecting a gadget in usb peripheral mode with
echo "" > /sys/kernel/config/usb_gadget/<your_gadget>/UDC,
/sys/class/udc/musb-hdrc.0/state does not change from USB_STATE_CONFIGURED.

Testing on dwc2/3 shows they both update the state to USB_STATE_NOTATTACHED.

Add calls to usb_gadget_set_state in musb_g_disconnect and musb_gadget_stop
to fix both cases.

Fixes: 49401f4169c0 ("usb: gadget: introduce gadget state tracking")
Cc: stable@vger.kernel.org
Co-authored-by: Yehowshua Immanuel <yehowshua.immanuel@twosixtech.com>
Signed-off-by: Yehowshua Immanuel <yehowshua.immanuel@twosixtech.com>
Signed-off-by: Drew Hamilton <drew.hamilton@zetier.com>
Link: https://lore.kernel.org/r/20250701154126.8543-1-drew.hamilton@zetier.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 6869c58367f2..caf4d4cd4b75 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1913,6 +1913,7 @@ static int musb_gadget_stop(struct usb_gadget *g)
 	 * gadget driver here and have everything work;
 	 * that currently misbehaves.
 	 */
+	usb_gadget_set_state(g, USB_STATE_NOTATTACHED);
 
 	/* Force check of devctl register for PM runtime */
 	pm_runtime_mark_last_busy(musb->controller);
@@ -2019,6 +2020,7 @@ void musb_g_disconnect(struct musb *musb)
 	case OTG_STATE_B_PERIPHERAL:
 	case OTG_STATE_B_IDLE:
 		musb_set_state(musb, OTG_STATE_B_IDLE);
+		usb_gadget_set_state(&musb->g, USB_STATE_NOTATTACHED);
 		break;
 	case OTG_STATE_B_SRP_INIT:
 		break;


