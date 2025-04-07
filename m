Return-Path: <stable+bounces-128712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7B0A7EAD5
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2383F18887ED
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718DA269AF2;
	Mon,  7 Apr 2025 18:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVYr0hu5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275D52550C7;
	Mon,  7 Apr 2025 18:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049724; cv=none; b=t0q+j4esiPZDrUVbVSrUL+iBfEmu+//HnF3roAUn8bfI6R+PwrCGyAVyFyhtidiqffNtpN67VpOtaMIJbduDtELVZjPue/SWo4IGh2RnWlBeLcfYduYnpwQuAZKap9IhIHXzclNPCKNozWRgxDYqXE8RA2KknftEKbM4Fv1oiaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049724; c=relaxed/simple;
	bh=uuDdzrXe7hIa2fRDKBV1y84OU1qD7FqqEWcopua3u9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=plbywRf8S6OWxMfdJyKvICWRp7RpQ0qTcXomP3Y1I7bKM8J0P8EgD8WqYa+x+Vev/meh6pJpAAFIAMNvXNr0WRm3RTmxW26SQ54ZQqk6zrLcl6GIQGaqCcXe8EcL1nq+gS8mhW4AHvFpv6OhQRsxDSpQXq7K2fpbPCBj8XjG9sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVYr0hu5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9B0C4CEEE;
	Mon,  7 Apr 2025 18:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049724;
	bh=uuDdzrXe7hIa2fRDKBV1y84OU1qD7FqqEWcopua3u9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hVYr0hu5SbNsWFTfLOwf1f5qADdwxgSPTjV/E40OFjGtoBvqahuVQcjzSmwk1klXT
	 8XC/9vHPEP/7DdW3FUySe6kbPTRzCLr5e0Y9tckjeWWcnlBR0prDypzPtLJEd6sCEt
	 01NwfWILgG+W9OC3puOHfnOhukjuaWCyDPPu4NE0DRzIf7gMf/JHWHqXYkIs+xqnav
	 rmVsYHkGSSlxDLtt+BU8tyZY3QD/k/0IyhaIbVTLvo3n4Mn8daj8jbqMVWYBRx80td
	 wV8LQJd9pK/PnRLkM6ljhbMW7sWj3fFrugc0qlRb4Fzg6vxTlnI2voY0Gt4+BHqllY
	 3qQEFU8x9t0iQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ferry Toth <fntoth@gmail.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 3/8] usb: dwc3: gadget: Avoid using reserved endpoints on Intel Merrifield
Date: Mon,  7 Apr 2025 14:15:09 -0400
Message-Id: <20250407181516.3183864-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181516.3183864-1-sashal@kernel.org>
References: <20250407181516.3183864-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
Content-Transfer-Encoding: 8bit

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
index 1872de3ce98bd..5e0b326875fac 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -132,11 +132,21 @@ static const struct property_entry dwc3_pci_intel_byt_properties[] = {
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


