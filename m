Return-Path: <stable+bounces-96283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 324F99E19FE
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 11:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBCFE28434A
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 10:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3956F1E283E;
	Tue,  3 Dec 2024 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yf17q+6i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC62B1DE3BD
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 10:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733223188; cv=none; b=sxtnE/ZCCtOM7SLyXmH7lScncrYhb/ZyB3jv42HQX4fsuWTCAQ3PbqeLPkCRDFmfOgbSf7w0Y0pHTYlNG62s8kGkzo65rIm429o3n0EiAU05c6rO3WxLTTaQmiHui6lE1mk2M3GuaE8zfUk3inJLVR3ERINf+woIYNNKj9aZCNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733223188; c=relaxed/simple;
	bh=wILkb+irU8mCmcT27hu6UCuWzLKTckM4xBcQkuRLopo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dd+OL7X9JlE4X5/ZK/sn0Ltbr3KCZ0v4ZQdlbMRudQb6MKT81wx58L++CNpOwGj6XMo8/tG1Pig8086X9xNWrrPx0aN2QTxQBQbA3FQMzItkS9AWgRjRX8fiXWMtBPsA61OjrjNDuremjNfQGs6gFEYQOYc2ci6bJibBlShf9To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yf17q+6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB0BC4CECF;
	Tue,  3 Dec 2024 10:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733223186;
	bh=wILkb+irU8mCmcT27hu6UCuWzLKTckM4xBcQkuRLopo=;
	h=Subject:To:Cc:From:Date:From;
	b=yf17q+6iFEfhLY0EmXQKGbR6hpYd+6KWW1nOq7g33fLWxgsD22FAx0j4BAqfJNQ8B
	 7EWqCuMFaNLvSZXzWfqnDNtxRMRi5Jhj3VGJZoht721xy/7tw1hcW1cLM3aCL3MoJP
	 rQlc1UE/o9U+iDcI5sgrzeZFVy0LcpmQXbdL3QxE=
Subject: FAILED: patch "[PATCH] usb: dwc3: ep0: Don't clear ep0 DWC3_EP_TRANSFER_STARTED" failed to apply to 6.1-stable tree
To: Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Dec 2024 11:52:23 +0100
Message-ID: <2024120322-lurk-clutch-522d@gregkh>
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
git cherry-pick -x 5d2fb074dea289c41f5aaf2c3f68286bee370634
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120322-lurk-clutch-522d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5d2fb074dea289c41f5aaf2c3f68286bee370634 Mon Sep 17 00:00:00 2001
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Date: Thu, 14 Nov 2024 01:02:06 +0000
Subject: [PATCH] usb: dwc3: ep0: Don't clear ep0 DWC3_EP_TRANSFER_STARTED

The driver cannot issue the End Transfer command to the SETUP transfer.
Don't clear DWC3_EP_TRANSFER_STARTED flag to make sure that the driver
won't send Start Transfer command again, which can cause no-resource
error. For example this can occur if the host issues a reset to the
device.

Cc: stable@vger.kernel.org
Fixes: 76cb323f80ac ("usb: dwc3: ep0: clear all EP0 flags")
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/d3d618185fd614bb7426352a9fc1199641d3b5f5.1731545781.git.Thinh.Nguyen@synopsys.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index f3d97ad5156e..666ac432f52d 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -232,7 +232,7 @@ void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
 	/* stall is always issued on EP0 */
 	dep = dwc->eps[0];
 	__dwc3_gadget_ep_set_halt(dep, 1, false);
-	dep->flags &= DWC3_EP_RESOURCE_ALLOCATED;
+	dep->flags &= DWC3_EP_RESOURCE_ALLOCATED | DWC3_EP_TRANSFER_STARTED;
 	dep->flags |= DWC3_EP_ENABLED;
 	dwc->delayed_status = false;
 


