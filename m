Return-Path: <stable+bounces-67743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 453E7952971
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 08:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B183287301
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 06:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E2A179654;
	Thu, 15 Aug 2024 06:40:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8221C176FD2
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 06:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723704040; cv=none; b=pBCxJdSvSD+locKnRbWEkkjSX4eC2i952FStLdcvfdZPDuUgS5PGUSBVK1LRlf912rAKuivuAcNJrki9VMrMQoxQ0C9cDtPkFWtlSmWOQHzrk9fjpIkJgiaNp+CncDhoPNR+mslQC4bS90fuiY0dxTXN9qje4s+u37Xv5erlbS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723704040; c=relaxed/simple;
	bh=Vy2YoRP3WMBL9Q0m0cvv2z3doL40ax72V/J2g22sdOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DEIj46r2oeR7LeIFVIWxi+VnrasJEtxQ3QdqTMsa7/Tl07NTnsQJQz7989RFmQpTVmqAiqaULzsSOJPJwR2OcXw0ylqCXk4D+6fT4Ja67rSw9Ethjusaew56tJA68QWZNsHFQoQUVMAmgBwZ7S55AOgNJROvENFzHPClyvNZv8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1seU9u-0002L8-Ty; Thu, 15 Aug 2024 08:40:30 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1seU9t-000XGZ-Oj; Thu, 15 Aug 2024 08:40:29 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1seU9t-002CsL-2H;
	Thu, 15 Aug 2024 08:40:29 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Thu, 15 Aug 2024 08:40:29 +0200
Subject: [PATCH v2] usb: dwc3: ep0: Don't reset resource alloc flag
 (including ep0)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-dwc3hwep0reset-v2-1-29e1d7d923ea@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIANyivWYC/3WOOw6DMBBEr4K2jiP/FEiq3COiwHjB2xi0JkCEu
 HsMXYqUbzRPMxskZMIEj2IDxpkSDTGDvhTQhib2KMhnBi21lZWywi+tCQuOkjHhJJz1plRVaez
 dQpZck1A4bmIbDu23fRRGxo7Wc/FVZw6UpoE/54FZHenfrVkJJWRVOun1rTNePkeM/XviIdJ69
 Qj1vu9fEiwMaNIAAAA=
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1784;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=Vy2YoRP3WMBL9Q0m0cvv2z3doL40ax72V/J2g22sdOI=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmvaLd76WjuTzBse4a1zQhSPCx4BbCb63ZKWekQ
 78y4MU4I5mJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZr2i3QAKCRC/aVhE+XH0
 q/F6D/9egYIhDfTzbtMWhwhK6deKJS363ZTXV5Xq9R8Bt6wjqDfp8yz9StX0LewcdFcKBPbb/NC
 LiJPB1yWimhY8ENM+KLjb63lzgvkiYR0fLC2Ruzo9ZpCBSflWy4xAPLiPICVr3ghxaT7wxQs+Ha
 qGJnp1dsIbuhtATkniT6HtAtFHsNEu8jamCuHy8r9+94C1R1CUcOvf0RXbq/fftGJOZgaOLe3GE
 8gFUo8PRG6gsArFmU0+lUyN+HHIpOKAsi1xl3bUyhwLGuwdonUrdpYFjCm0RVFEHMCAObC7GeCI
 6WzLPiCNP1aUB0b99AxUC3tIb0/Pi7DEudPOYKw2iZwJoGuv0ZZjuiIKK2Wt01K3R2XaAQIWSIo
 Y0L3YpzJ7l4k0DaFNWKhPVeZHRrxkYmT88INiACI/ICsCAcD3SdbQLe3PuBGybpVaX/coEnrS7p
 xWWYQlLGZ7pt4gqKDT2QwwEKQzWaWb5UAkWRu8XOVsYvAQ1h3yeum5+zApVhHrnn1M3woRvoFDV
 q7RhUCfdU5ubUq6O3l8uioR5DsRKzboitMEDpQ3StXrNpB88cm7MqJvy3o0mnd4shM6duI3m/V8
 BSqlmXWLxEFQariB6S2CCuH5vuOmOSc0w31IAPvnV52h7wbOprmk1N+GnDLx9xTiwne+H2zRaCE
 0992l7kkJRLM5ag==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

The DWC3_EP_RESOURCE_ALLOCATED flag ensures that the resource of an
endpoint is only assigned once. Unless the endpoint is reset, don't
clear this flag. Otherwise we may set endpoint resource again, which
prevents the driver from initiate transfer after handling a STALL or
endpoint halt to the control endpoint.

Commit f2e0eee47038 ("usb: dwc3: ep0: Don't reset resource alloc flag")
was fixing the initial issue, but did this only for physical ep1. Since
the function dwc3_ep0_stall_and_restart is resetting the flags for both
physical endpoints, this also has to be done for ep0.

Cc: stable@vger.kernel.org
Fixes: b311048c174d ("usb: dwc3: gadget: Rewrite endpoint allocation flow")
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
v2: Added missing double quotes in the referenced patch name

- Link to v1: https://lore.kernel.org/r/20240814-dwc3hwep0reset-v1-1-087b0d26f3d0@pengutronix.de
---
 drivers/usb/dwc3/ep0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index d96ffbe520397..c9533a99e47c8 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -232,7 +232,8 @@ void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
 	/* stall is always issued on EP0 */
 	dep = dwc->eps[0];
 	__dwc3_gadget_ep_set_halt(dep, 1, false);
-	dep->flags = DWC3_EP_ENABLED;
+	dep->flags &= DWC3_EP_RESOURCE_ALLOCATED;
+	dep->flags |= DWC3_EP_ENABLED;
 	dwc->delayed_status = false;
 
 	if (!list_empty(&dep->pending_list)) {

---
base-commit: 38343be0bf9a7d7ef0d160da5f2db887a0e29b62
change-id: 20240814-dwc3hwep0reset-b4d371873494

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>


