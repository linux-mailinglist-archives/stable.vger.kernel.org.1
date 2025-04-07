Return-Path: <stable+bounces-128684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A027CA7EAA6
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BDFD17E413
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CCB265CC6;
	Mon,  7 Apr 2025 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y46iPY+U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679F0265CBA;
	Mon,  7 Apr 2025 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049666; cv=none; b=qH3Btv9vzEGKNQRgTO4d5isB2voxeKnF0OUH2Vz1Ty7/c4UjH3XlmvToBwsPLEC9FZZRIelRU1EX6A5z4unI835lcPAcBEDFJwzCYrJ/eBk4xEYUvNs3o9XVa3gx9NIIJzeB7nvuAT4uatmeo4pKru9tN9LJmkrID83Du+kvidY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049666; c=relaxed/simple;
	bh=P9IARbyBPJ3Osu5SDwsFJok3oD6DIO0uGCgbsgkHuDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vFlIxfm/kCOC4BJhD3X1SAlNVF6I1I4oP0B6xoGcBJvNsSXK1gj59c+sWjlvhCMV496rgZ+/2SJptuDPOxuB1LNfpkHhNfHWYFGLTRjIqytEYtmXPJBRX7C6wL18cR88Dqm1Yp32pq+btoz1pWO+EYHPXPayGJcIWq/hs8A2IUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y46iPY+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D84C4CEDD;
	Mon,  7 Apr 2025 18:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049666;
	bh=P9IARbyBPJ3Osu5SDwsFJok3oD6DIO0uGCgbsgkHuDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y46iPY+UqnkiScNlE8tsKqk3Y+OHWjG7ive0Q6eN4F/1ZPxij+AE0BfVDtHYBG3yE
	 B3N+RQHP2wLGg04OsQ5EVifUD2+UTRIC2FOXAkA4dLh9JPjvSf7ahGOzMElZiCC3qk
	 pQexgxdd05JOWgYuteGOEqORhfzPYyi/9QOxW9BJpYfWXPU3GgO3H2VRyAO7ayYNWB
	 KuF5duqZrGxRVsHmzY4/ddUuN4MgDlNXpTqxsfJHc26QwLO+582JgwRPnpuvtujBH2
	 NggH3PQYOgo6VUqYK+Mv1NI2HGr8BbqDxiJVHxP3+9S+m2+PU2zPySdo2+vqx4M4SL
	 rrsyDjjXyywaw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ferry Toth <fntoth@gmail.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 04/15] usb: dwc3: gadget: Avoid using reserved endpoints on Intel Merrifield
Date: Mon,  7 Apr 2025 14:14:04 -0400
Message-Id: <20250407181417.3183475-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181417.3183475-1-sashal@kernel.org>
References: <20250407181417.3183475-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.86
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


