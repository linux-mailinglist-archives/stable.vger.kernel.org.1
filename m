Return-Path: <stable+bounces-127664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F44A7A6E7
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 17:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23E6B1797EC
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 15:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232822505D6;
	Thu,  3 Apr 2025 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cbSk4pmZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DCA24CEE5;
	Thu,  3 Apr 2025 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743693994; cv=none; b=YfpvFFncmPBoydafdyF5f7S48mwjXEWWwaVMrIjx5TAnodcanRT5MOucxptQJh9bFBJZtAHd8ze1fPhAPVZdCniijKI79m7xaE6hVzldBCKhuAu2rImMKD2M8E/sksPf/p17AhrMeEZovO6UGcDCXSizbyF+lQ3MbGjaPIUQQnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743693994; c=relaxed/simple;
	bh=uPl2ulAGNvHazFddEYlHR+F7OWwCt44hX71oIeAGLa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUQ+dKC8c/R9KEgIHg7lON2rhDesrJiBRqLLPe8FX/NNVuqy/2BqPoVPCZkmvDH7crAE2PoI8+2GSgsVtnPEflZjB0awZFBdu3JJVHxHoXndR0NMDpnTe0NcG4u70FJ7kGCqKWtmavdZZHGy+23atossw/m3u4QLenz4kutHlJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cbSk4pmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E813C4CEE3;
	Thu,  3 Apr 2025 15:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743693994;
	bh=uPl2ulAGNvHazFddEYlHR+F7OWwCt44hX71oIeAGLa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cbSk4pmZjOQb0mZGSvlkbanF8nqwtxpLuj02N58lurvSG74/yNewaeovZ/SoEBuXw
	 Bgjim0x+aUMWjE2TRnS66TyhXPxxfa8E+G+JFiTTXnog9kR28CKkMr8dUgxX2PWa7U
	 7rEf+64JWac/VMnUZjTRodIH2D7LMUneogp6nT3Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Cameron Williams <cang1@live.co.uk>
Subject: [PATCH 6.6 18/26] tty: serial: 8250: Add some more device IDs
Date: Thu,  3 Apr 2025 16:20:39 +0100
Message-ID: <20250403151622.948900626@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403151622.415201055@linuxfoundation.org>
References: <20250403151622.415201055@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cameron Williams <cang1@live.co.uk>

commit be6a23650908e2f827f2e7839a3fbae41ccb5b63 upstream.

These card IDs got missed the first time around.

Cc: stable <stable@kernel.org>
Signed-off-by: Cameron Williams <cang1@live.co.uk>
Link: https://lore.kernel.org/r/DB7PR02MB380295BCC879CCF91315AC38C4C12@DB7PR02MB3802.eurprd02.prod.outlook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_pci.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -5107,6 +5107,14 @@ static const struct pci_device_id serial
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_2_115200 },
+	{       PCI_VENDOR_ID_INTASHIELD, 0x0BA2,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{       PCI_VENDOR_ID_INTASHIELD, 0x0BA3,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
 	/*
 	 * Brainboxes UC-235/246
 	 */
@@ -5227,6 +5235,14 @@ static const struct pci_device_id serial
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_4_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C42,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_4_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C43,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_4_115200 },
 	/*
 	 * Brainboxes UC-420
 	 */



