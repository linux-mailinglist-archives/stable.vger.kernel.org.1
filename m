Return-Path: <stable+bounces-19825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8114185376C
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 18:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B37BF1C265BC
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 17:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7540C5FEE0;
	Tue, 13 Feb 2024 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CUoydzKQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344545FB86;
	Tue, 13 Feb 2024 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845115; cv=none; b=aUR3IBndp3LjrWyJqzQVkZhOdQ6nzNzpSMAVoOasGnCgAupgLJjt6kvHbg97zW7jbk+F0Ap42wNAkdawpfAnJh1t8c8LnnW6hNQvzjdELtDynA78hVhOWcRscz7GJL1tSmfBJ7dCNLgimUSN7GstU5k2jYGRnOepe4Vx+l99hBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845115; c=relaxed/simple;
	bh=n4vyoxFqrDb+RBOi+9WxTCPwCzzAGNoVD/N0+Qh28sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZsWewWgVk1GTDkEiDK2/LcxS3CGIYOX9J6gadGUQeAbJRjLPE6h+QiSTUQpL/7UErurOILzHCszYFVwJAAEgUvgdlwVPkt1r5UUtZxU5cJktNFkB+ZUc8F2RpnY/9C3djGvNEo+pEv+w+j4SFb/Lvcd6hYYVJW/V6XP7Mh//C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CUoydzKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48C1C433F1;
	Tue, 13 Feb 2024 17:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707845115;
	bh=n4vyoxFqrDb+RBOi+9WxTCPwCzzAGNoVD/N0+Qh28sA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CUoydzKQIPSW2wlMUIAiNPG87KODWs/2RZT28vVtsdhb3PMEjV+waF28M59n9rbd0
	 73pqBeBHTNISAVMpOceOrQ/JApwx0YJllDVMIFtZDrfVh0a+ZioiwP3GMFPipohyQu
	 YI7ranBtHnOjjKfl2kbEoWyRnoy7AIn/dCvrExt0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Prashanth K <quic_prashk@quicinc.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 6.1 51/64] usb: dwc3: host: Set XHCI_SG_TRB_CACHE_SIZE_QUIRK
Date: Tue, 13 Feb 2024 18:21:37 +0100
Message-ID: <20240213171846.343318398@linuxfoundation.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240213171844.702064831@linuxfoundation.org>
References: <20240213171844.702064831@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Prashanth K <quic_prashk@quicinc.com>

commit 817349b6d26aadd8b38283a05ce0bab106b4c765 upstream.

Upstream commit bac1ec551434 ("usb: xhci: Set quirk for
XHCI_SG_TRB_CACHE_SIZE_QUIRK") introduced a new quirk in XHCI
which fixes XHC timeout, which was seen on synopsys XHCs while
using SG buffers. But the support for this quirk isn't present
in the DWC3 layer.

We will encounter this XHCI timeout/hung issue if we run iperf
loopback tests using RTL8156 ethernet adaptor on DWC3 targets
with scatter-gather enabled. This gets resolved after enabling
the XHCI_SG_TRB_CACHE_SIZE_QUIRK. This patch enables it using
the xhci device property since its needed for DWC3 controller.

In Synopsys DWC3 databook,
Table 9-3: xHCI Debug Capability Limitations
Chained TRBs greater than TRB cache size: The debug capability
driver must not create a multi-TRB TD that describes smaller
than a 1K packet that spreads across 8 or more TRBs on either
the IN TR or the OUT TR.

Cc: stable@vger.kernel.org #5.11
Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/20240116055816.1169821-2-quic_prashk@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/host.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -66,7 +66,7 @@ out:
 
 int dwc3_host_init(struct dwc3 *dwc)
 {
-	struct property_entry	props[4];
+	struct property_entry	props[5];
 	struct platform_device	*xhci;
 	int			ret, irq;
 	int			prop_idx = 0;
@@ -94,6 +94,8 @@ int dwc3_host_init(struct dwc3 *dwc)
 
 	memset(props, 0, sizeof(struct property_entry) * ARRAY_SIZE(props));
 
+	props[prop_idx++] = PROPERTY_ENTRY_BOOL("xhci-sg-trb-cache-size-quirk");
+
 	if (dwc->usb3_lpm_capable)
 		props[prop_idx++] = PROPERTY_ENTRY_BOOL("usb3-lpm-capable");
 



