Return-Path: <stable+bounces-138100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B773AA1696
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C75F17354C
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1836F2528FB;
	Tue, 29 Apr 2025 17:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0mYJWyyw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67942459FE;
	Tue, 29 Apr 2025 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948153; cv=none; b=I5CwWK5IcLi5Iszd1zwdlrKzFT3pqXknUOxeHkre+IVf12Ovp1kLKXtZ4gmz9pz8OeXXMR1cOIX21nOsyjRoT9gNmbuU/6h6l4XEicpkR9s4/NRoE78sKWGPmwFAcGKrDQ9MsdvxH4lr3iOeBOJJrGRZxjzCiAnwWytFwyAcjSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948153; c=relaxed/simple;
	bh=5y9H/H6q/QxZQ4rjbkOYjFtlBlzv0v0ZJId/CbxkK48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FkeBy3C3TvcYHOGXMul0gMg0aAZ4v8Xjfm2XG7M7ooL/T/p1S2Eck9sysJmzMLskRoWyF/AgoMOXF+TIJ5jHw/0oCd8FfQEe0BVJczp289drlxZX2qztksZYAoM0Ij4rB2JgE5c6mu8j/iPCYzkp4+X05QlZj/LRFO/ZEnraqxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0mYJWyyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A34CC4CEE9;
	Tue, 29 Apr 2025 17:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745948153;
	bh=5y9H/H6q/QxZQ4rjbkOYjFtlBlzv0v0ZJId/CbxkK48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0mYJWyyw1zX4ZOFF+3DJnDfrjZago7aeFZRdf5Vx5OadSDFb88wFLtoTrsVRte6bg
	 M1+K+Fqu5Okt0GxTtDv6QdCr57ff8H9NzIyA1S6f+QItcH3aRIYe9H/vZUM7bx9wti
	 Snq0SdRGPVsQVdcnpSoRxc+DEW72+GWMu46fRiMM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ferry Toth <fntoth@gmail.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 174/280] usb: dwc3: gadget: Avoid using reserved endpoints on Intel Merrifield
Date: Tue, 29 Apr 2025 18:41:55 +0200
Message-ID: <20250429161122.231595939@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161115.008747050@linuxfoundation.org>
References: <20250429161115.008747050@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 461f24bff86808ee5fbfe74751a825f8a7ab24e0 ]

Intel Merrifield SoC uses these endpoints for tracing and they cannot
be re-allocated if being used because the side band flow control signals
are hard wired to certain endpoints:

• 1 High BW Bulk IN (IN#1) (RTIT)
• 1 1KB BW Bulk IN (IN#8) + 1 1KB BW Bulk OUT (Run Control) (OUT#8)

In device mode, since RTIT (EP#1) and EXI/RunControl (EP#8) uses
External Buffer Control (EBC) mode, these endpoints are to be mapped to
EBC mode (to be done by EXI target driver). Additionally TRB for RTIT
and EXI are maintained in STM (System Trace Module) unit and the EXI
target driver will as well configure the TRB location for EP #1 IN
and EP#8 (IN and OUT). Since STM/PTI and EXI hardware blocks manage
these endpoints and interface to OTG3 controller through EBC interface,
there is no need to enable any events (such as XferComplete etc)
for these end points.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Ferry Toth <fntoth@gmail.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/20250212193116.2487289-5-andriy.shevchenko@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/dwc3-pci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 052852f801467..54a4ee2b90b7f 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -148,11 +148,21 @@ static const struct property_entry dwc3_pci_intel_byt_properties[] = {
 	{}
 };
 
+/*
+ * Intel Merrifield SoC uses these endpoints for tracing and they cannot
+ * be re-allocated if being used because the side band flow control signals
+ * are hard wired to certain endpoints:
+ * - 1 High BW Bulk IN (IN#1) (RTIT)
+ * - 1 1KB BW Bulk IN (IN#8) + 1 1KB BW Bulk OUT (Run Control) (OUT#8)
+ */
+static const u8 dwc3_pci_mrfld_reserved_endpoints[] = { 3, 16, 17 };
+
 static const struct property_entry dwc3_pci_mrfld_properties[] = {
 	PROPERTY_ENTRY_STRING("dr_mode", "otg"),
 	PROPERTY_ENTRY_STRING("linux,extcon-name", "mrfld_bcove_pwrsrc"),
 	PROPERTY_ENTRY_BOOL("snps,dis_u3_susphy_quirk"),
 	PROPERTY_ENTRY_BOOL("snps,dis_u2_susphy_quirk"),
+	PROPERTY_ENTRY_U8_ARRAY("snps,reserved-endpoints", dwc3_pci_mrfld_reserved_endpoints),
 	PROPERTY_ENTRY_BOOL("snps,usb2-gadget-lpm-disable"),
 	PROPERTY_ENTRY_BOOL("linux,sysdev_is_parent"),
 	{}
-- 
2.39.5




