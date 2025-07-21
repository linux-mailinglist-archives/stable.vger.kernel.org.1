Return-Path: <stable+bounces-163499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFF1B0C013
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 11:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 827A93BF27F
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 09:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7432E28C5C9;
	Mon, 21 Jul 2025 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yxlihtnB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F5028DF1D
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 09:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753089584; cv=none; b=iShdvMuTk6rJ8Q978Cc8QRiC5z5aTQO3KiMRPfRq90JgLTIoCUIxhKP10T2SMrziiTykzSufa46ZRhmzIUu8shU6rcixcpnw5vbQJrN8WwGM6dKjpelesKQauVSwlVmWuilEw501xl19ZB4k9GIr2+Ibqxdbe1L3kpvUhJNRbNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753089584; c=relaxed/simple;
	bh=4IyhDs3vliSHOuZgbHXQAkfpc5SG6ipDEdoWTO8Cb1E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OT4d6dsh/QnQZXNvOjQ8M4cqvLbhHBcxahXaVoElm1O/RSdiwcskBhtKvy9vTgMb4KsWEN8tw3fW5aOdoFjXqQS7X8S/SdhXN7Q4Ee/x1xBlbH1YINEnBba06bvHgwHIT1THibH+FplfdgY052nb3naJsUMvBpiF/Xt5iR+dGTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yxlihtnB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF5CC4CEF1;
	Mon, 21 Jul 2025 09:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753089583;
	bh=4IyhDs3vliSHOuZgbHXQAkfpc5SG6ipDEdoWTO8Cb1E=;
	h=Subject:To:Cc:From:Date:From;
	b=yxlihtnBu946oxFz/saW7lR0HZFZe2pgVUgSwekHkPW8kQ2rIaKG0GB3l2uudNOqI
	 Ccq4DMUCJSZpa5im2aLSPtEGi8TJdtxMeoT30gZ1qNMM9ugTJE5ZU5sIkdk/kHwUfm
	 6Fchg/Kv5a7Pg6vUNUUw+TFKAFL25keNY8Fky2r8=
Subject: FAILED: patch "[PATCH] usb: musb: fix gadget state on disconnect" failed to apply to 6.1-stable tree
To: drew.hamilton@zetier.com,gregkh@linuxfoundation.org,yehowshua.immanuel@twosixtech.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Jul 2025 11:19:31 +0200
Message-ID: <2025072131-crushing-unsworn-a3b0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 67a59f82196c8c4f50c83329f0577acfb1349b50
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072131-crushing-unsworn-a3b0@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


