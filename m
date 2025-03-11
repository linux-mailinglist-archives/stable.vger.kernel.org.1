Return-Path: <stable+bounces-123443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D14A5C597
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D39A3B5D63
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FFD25DD0F;
	Tue, 11 Mar 2025 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n4gx3f/0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133B225D8F9;
	Tue, 11 Mar 2025 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705970; cv=none; b=FYLsiIY+1PJJX90UnXyV+928cYMCG+cYes8IDEy91GZq7VHpm1ZllWyHIWivgJJEpF0FBluFMMBkzuSAdfhcss2xojoaJ55q8R4+uOUoLqQqCf8AcJaqiu+CF9RLCbhcNkgnkSA/Ksf5jEQjfCk2zJtBUgxkvBoBXKz3lMcskac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705970; c=relaxed/simple;
	bh=witE3sD9lM79GurezhQU6gZOzEpjQ2yBDp1bz+9pYKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UfIkDOzWU0Eu75JSttzqrVjsoajmCqSqmcXd/UkWp78mKf8p5t0Te4qHfEiAjOi755pb3c+NTN9f1GAM5rK3ooEyoDVVf7DFD2MHU7g8yJFToIOV1nfqReBb9BsB8C/8VBdhtw0tIUD7elsCmD8x0oWTm83JzTDRs6wKryZhdSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n4gx3f/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D078C4CEE9;
	Tue, 11 Mar 2025 15:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741705969;
	bh=witE3sD9lM79GurezhQU6gZOzEpjQ2yBDp1bz+9pYKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n4gx3f/0V3EhpwiU07clbxiNFQJ2B6q68UmlfhLbTaPpdOR4TpSY3mRW6hU70V/WG
	 dCncBcLdrrFfJVEaH1MhOjGHCs+pY6ZzOptm2FBd7P4tRTFwpeyuMG4op1lD4eUruj
	 75Xa7rcITMb5dO9iCvx0zkYMB2im95a/VQbJFtXs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiaqing Zhao <jiaqing.zhao@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH 5.4 218/328] parport_pc: add support for ASIX AX99100
Date: Tue, 11 Mar 2025 15:59:48 +0100
Message-ID: <20250311145723.567902924@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145714.865727435@linuxfoundation.org>
References: <20250311145714.865727435@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>

commit 16aae4c64600a6319a6f10dbff833fa198bf9599 upstream.

The PCI function 2 on ASIX AX99100 PCIe to Multi I/O Controller can be
configured as a single-port parallel port controller. The subvendor id
is 0x2000 when configured as parallel port. It supports IEEE-1284 EPP /
ECP with its ECR on BAR1.

Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Link: https://lore.kernel.org/r/20230724083933.3173513-5-jiaqing.zhao@linux.intel.com
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/parport/parport_pc.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2624,6 +2624,7 @@ enum parport_pc_pci_cards {
 	netmos_9815,
 	netmos_9901,
 	netmos_9865,
+	asix_ax99100,
 	quatech_sppxp100,
 	wch_ch382l,
 	brainboxes_uc146,
@@ -2689,6 +2690,7 @@ static struct parport_pc_pci {
 	/* netmos_9815 */		{ 2, { { 0, 1 }, { 2, 3 }, } },
 	/* netmos_9901 */               { 1, { { 0, -1 }, } },
 	/* netmos_9865 */               { 1, { { 0, -1 }, } },
+	/* asix_ax99100 */		{ 1, { { 0, 1 }, } },
 	/* quatech_sppxp100 */		{ 1, { { 0, 1 }, } },
 	/* wch_ch382l */		{ 1, { { 2, -1 }, } },
 	/* brainboxes_uc146 */	{ 1, { { 3, -1 }, } },
@@ -2779,6 +2781,9 @@ static const struct pci_device_id parpor
 	  0xA000, 0x1000, 0, 0, netmos_9865 },
 	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9865,
 	  0xA000, 0x2000, 0, 0, netmos_9865 },
+	/* ASIX AX99100 PCIe to Multi I/O Controller */
+	{ PCI_VENDOR_ID_ASIX, PCI_DEVICE_ID_ASIX_AX99100,
+	  0xA000, 0x2000, 0, 0, asix_ax99100 },
 	/* Quatech SPPXP-100 Parallel port PCI ExpressCard */
 	{ PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_SPPXP_100,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, quatech_sppxp100 },



