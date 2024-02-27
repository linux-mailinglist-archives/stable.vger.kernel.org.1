Return-Path: <stable+bounces-25041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CA5869777
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1510F283162
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722CC13EFF4;
	Tue, 27 Feb 2024 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cBaVguGQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5B813B2B8;
	Tue, 27 Feb 2024 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043691; cv=none; b=nrmpFd1tFTUr3UwWRh+JQWGpvHqtBpD7Ilo8D15WyWd/RpRuuRRnBpoIObfLsGQ6WsUYa0D1zj5V5WsAH/kXZ4QNTXE9qT97SOxrd/iPpXRZzzeZJkbbhOLZAD6Iy/PxQ9xbh+P00vRtlM5rkn5WkeO8tWLuaZysPwulKnxd6aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043691; c=relaxed/simple;
	bh=8oRDPVICwAFDHM6AlbL9zPx5vYcFq3m2atInnC2eFcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngXqgilEIeDGi7Rvcuc7dwGmvJ6+XgMDbYKAk0gmZmfzRFtkr7pLvC9Km1NhSYDG1NDz1eLm39lzq+8BK7AAlUvljTMPSBqLuMsgARMAPfpJ2gclriA3O41a5m9Ae72ur8ofKa0bWu4vX50Nce8Mjw8kDRAm0hLArc5KmpL0UVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cBaVguGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03F9C433C7;
	Tue, 27 Feb 2024 14:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709043691;
	bh=8oRDPVICwAFDHM6AlbL9zPx5vYcFq3m2atInnC2eFcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cBaVguGQDgaBH3HqiBK3FiWE9+HzY478YNF5kO/PjhBE/OBoOO4txTv97fOAaN+7d
	 CrCmwSmeievweWFPMwEn7j4IO838Xm871sRJuidaV5xdN0fbCjmUmAhW60cBKz2Byt
	 fTORWsYQzlit6XQs0zVe8FGJn0xbopnIr2mF2Mrw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Szuying Chen <Chloe_Chen@asmedia.com.tw>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 6.1 192/195] ata: ahci: add identifiers for ASM2116 series adapters
Date: Tue, 27 Feb 2024 14:27:33 +0100
Message-ID: <20240227131616.743241499@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131610.391465389@linuxfoundation.org>
References: <20240227131610.391465389@linuxfoundation.org>
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

From: Szuying Chen <chensiying21@gmail.com>

commit 3bf6141060948e27b62b13beb216887f2e54591e upstream.

Add support for PCIe SATA adapter cards based on Asmedia 2116 controllers.
These cards can provide up to 10 SATA ports on PCIe card.

Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/ahci.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -613,6 +613,11 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci },   /* ASM1061R */
 	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci },   /* ASM1062R */
 	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci },   /* ASM1062+JMB575 */
+	{ PCI_VDEVICE(ASMEDIA, 0x1062), board_ahci },	/* ASM1062A */
+	{ PCI_VDEVICE(ASMEDIA, 0x1064), board_ahci },	/* ASM1064 */
+	{ PCI_VDEVICE(ASMEDIA, 0x1164), board_ahci },   /* ASM1164 */
+	{ PCI_VDEVICE(ASMEDIA, 0x1165), board_ahci },   /* ASM1165 */
+	{ PCI_VDEVICE(ASMEDIA, 0x1166), board_ahci },   /* ASM1166 */
 
 	/*
 	 * Samsung SSDs found on some macbooks.  NCQ times out if MSI is



