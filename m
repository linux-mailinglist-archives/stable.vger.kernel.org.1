Return-Path: <stable+bounces-174772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BDDB36414
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 756AB7BE12B
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E80D334717;
	Tue, 26 Aug 2025 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D4ZeYPRG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD04200112;
	Tue, 26 Aug 2025 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215276; cv=none; b=fk9iNwUFBJrf6rlNK/zro/twci/4nPchsdNBWgrYk/V5veQvN0+CP9VkOYGz/RkjpDo4LSHHbGI6Wo6310uRu3pizR24zjE17Fxg3jc/BD3k0s9dzoQ70J0hRMBdqi7RrSGIi2MRbXqelLIDOFUD2eKfMJX6YISDcgb60psq9uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215276; c=relaxed/simple;
	bh=wWwbj8aqHPvAiNTZcspDmBdGCrBAKoWDz2orRmcq0AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gY4N9NWl+iCQ3MEeoC1DFLbnkr6L/I3oenOVxESxVAFJg99npvosNnB8742oTU4+wgY8RwZWwW0Xc+JCsdmUg1s1YvFrio4uczVkC9XaXL4Zmb6WJPh4clnDgagnQHkfPepE3NzYC06/vvZdovj7Fe6ssaSaPqpABvg81zJnJoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D4ZeYPRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2035C4CEF1;
	Tue, 26 Aug 2025 13:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756215276;
	bh=wWwbj8aqHPvAiNTZcspDmBdGCrBAKoWDz2orRmcq0AQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D4ZeYPRGXyqh36HoKrX/kviqeUoeQcy0PXGaIPttlZlYn0aKHODTqTjuN2R6uSumr
	 C7Gvpd7S69BruKUwY+TDo/KVrCTfEAf68bSBtq6BKJsrrfVT+k905vOogu+AE373GT
	 OT0BsT8rbOMVf01tFVUAU39i3mMzN7ETZi8U0/pg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Kuen-Han Tsai <khtsai@google.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 6.1 422/482] usb: dwc3: Ignore late xferNotReady event to prevent halt timeout
Date: Tue, 26 Aug 2025 13:11:15 +0200
Message-ID: <20250826110941.253326327@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
References: <20250826110930.769259449@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuen-Han Tsai <khtsai@google.com>

commit 58577118cc7cec9eb7c1836bf88f865ff2c5e3a3 upstream.

During a device-initiated disconnect, the End Transfer command resets
the event filter, allowing a new xferNotReady event to be generated
before the controller is fully halted. Processing this late event
incorrectly triggers a Start Transfer, which prevents the controller
from halting and results in a DSTS.DEVCTLHLT bit polling timeout.

Ignore the late xferNotReady event if the controller is already in a
disconnected state.

Fixes: 72246da40f37 ("usb: Introduce DesignWare USB3 DRD Driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/20250807090700.2397190-1-khtsai@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/gadget.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3590,6 +3590,15 @@ static void dwc3_gadget_endpoint_transfe
 static void dwc3_gadget_endpoint_transfer_not_ready(struct dwc3_ep *dep,
 		const struct dwc3_event_depevt *event)
 {
+	/*
+	 * During a device-initiated disconnect, a late xferNotReady event can
+	 * be generated after the End Transfer command resets the event filter,
+	 * but before the controller is halted. Ignore it to prevent a new
+	 * transfer from starting.
+	 */
+	if (!dep->dwc->connected)
+		return;
+
 	dwc3_gadget_endpoint_frame_from_event(dep, event);
 
 	/*



