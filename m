Return-Path: <stable+bounces-175391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63643B367E8
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4BC1C20E95
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBB1343218;
	Tue, 26 Aug 2025 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ba4xY4EP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA3B2FDC5C;
	Tue, 26 Aug 2025 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216914; cv=none; b=Jo5WlbXPU6bVjMXLMbngNMeWERNgwv6HpUAAZpzoBNdc+537mVHOjviGEvXHFrReAGcQ98balDAdtz4DfGtlLo/OkAzdvTVGbirbFHl6WCR3zMKu5Ly2RxZ0+XZ4UtFOaB3zdBXSippAn4gBbI9IzKauyA77TubwBATMWz0nO58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216914; c=relaxed/simple;
	bh=jH2TAbOPwN0KHUtWPq5WTx+7fA6IXNxzOHlxa6ysoDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4JWoz45LWaVs2BV7vpSHimKeel2HhuvRE0jPph5rGz8rrooG8lEJSRWVvwuFw7w5WSpgy6HNKOwV3rxNLbZug1ds+jSDI/xSlslSbieBbvFf5qeOKhUBBLhC4837OEl6b9MFCg63jurbu+egi8v+hDKBGYey2MM37aq/P8ND5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ba4xY4EP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10BAC4CEF1;
	Tue, 26 Aug 2025 14:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216914;
	bh=jH2TAbOPwN0KHUtWPq5WTx+7fA6IXNxzOHlxa6ysoDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ba4xY4EPECKpz1W2ussYsKYsDpTxObESD6D084wh6Eu4MBZdRw8K+6ElCerNOK8LD
	 CS00+zHm2ybAEa3nlj6GTPZadvc60MGu/7Zj1heufujSg8GDqxmdeA6qVpI8tJSbxE
	 KJbyIdKPA8sufVAhnsASy1lLAeeQAQ56K1oJ/Fas=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Kuen-Han Tsai <khtsai@google.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 5.15 590/644] usb: dwc3: Ignore late xferNotReady event to prevent halt timeout
Date: Tue, 26 Aug 2025 13:11:21 +0200
Message-ID: <20250826111001.156487887@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3534,6 +3534,15 @@ static void dwc3_gadget_endpoint_transfe
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



