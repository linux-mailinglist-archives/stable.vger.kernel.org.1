Return-Path: <stable+bounces-127877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F2FA7ACDB
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B58CF17E2AB
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6F7280CD3;
	Thu,  3 Apr 2025 19:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFcfZdPZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24599280CCD;
	Thu,  3 Apr 2025 19:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707298; cv=none; b=dfunIJu2T3vuhylIEoBOZjMKYj8expckiZehtEceG5l8IO+HJGdb/wWNzI63ln+81gynlsP1ptLkfCvcrsbbQTVmrrS+wtlVqSw0WukwxVNIZF0DDuaIgmjbPD5rXJQXq3nNeRVepFI5arX5a3q1KXIawhA/WeJVWwG1qXzXThc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707298; c=relaxed/simple;
	bh=EqgthMe/ybxzBKOL3auf3kwi4fu/9h9nVy80O0xqMR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RxYpSIqLUvoSHy9iKd42kQsEJ6MGOojeLOr8xyPMnBo9+Ax1hPKIhFuU+jlPzwHOy35scvFThE+h0QdcDE0ArupnZjsYYyx1igg6qrdIp7zTmrVmH2y2HeNJ3JPcoX27jM8ptE7X0Tjm5ZbOtE2rcT898caLCLcEx2fL9Q3PFD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFcfZdPZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA249C4CEEC;
	Thu,  3 Apr 2025 19:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707296;
	bh=EqgthMe/ybxzBKOL3auf3kwi4fu/9h9nVy80O0xqMR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iFcfZdPZ3Xyivo4lLXVtVbuCUOelGw2c9+s/5FdE46K65XkSuc0DYwkOGwVvReo+z
	 w0Py4tjnOg92H9yJb7yHKTeiOyUNTJFIptp+GG3S3IEu/NbRc2YHcVFoxpLmA3ZTxk
	 VwaM9ZxPaL9BW4rkhqPc3/WMp/4OWfEGZvZ1ozXtdRVX4uPmhj9NjB05W2lr1BnusQ
	 esgG5RkUmQ/u9CZfNaY/9/lCxeLZEhTGWR1UqlMOD/tjGft7xoVB6+ID8eJ/g8FUFs
	 e1D6laLLt5io0lTA3WtjbcUTKRfFztpC/kGpfEAAr9c0Ww1YXuRZwKIq8p2YmUH8N+
	 0z3VZ4yQUCS9A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	Philip Pemberton <lists@philpem.me.uk>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 12/26] ata: libata-eh: Do not use ATAPI DMA for a device limited to PIO mode
Date: Thu,  3 Apr 2025 15:07:31 -0400
Message-Id: <20250403190745.2677620-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190745.2677620-1-sashal@kernel.org>
References: <20250403190745.2677620-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
Content-Transfer-Encoding: 8bit

From: Niklas Cassel <cassel@kernel.org>

[ Upstream commit 91ec84f8eaddbc93d7c62e363d68aeb7b89879c7 ]

atapi_eh_request_sense() currently uses ATAPI DMA if the SATA controller
has ATA_FLAG_PIO_DMA (PIO cmds via DMA) set.

However, ATA_FLAG_PIO_DMA is a flag that can be set by a low-level driver
on a port at initialization time, before any devices are scanned.

If a controller detects a connected device that only supports PIO, we set
the flag ATA_DFLAG_PIO.

Modify atapi_eh_request_sense() to not use ATAPI DMA if the connected
device only supports PIO.

Reported-by: Philip Pemberton <lists@philpem.me.uk>
Closes: https://lore.kernel.org/linux-ide/c6722ee8-5e21-4169-af59-cbbae9edc02f@philpem.me.uk/
Tested-by: Philip Pemberton <lists@philpem.me.uk>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Link: https://lore.kernel.org/r/20250221015422.20687-2-cassel@kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-eh.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 9cc0225221849..3263fc13491e1 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1496,8 +1496,15 @@ unsigned int atapi_eh_request_sense(struct ata_device *dev,
 	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf.command = ATA_CMD_PACKET;
 
-	/* is it pointless to prefer PIO for "safety reasons"? */
-	if (ap->flags & ATA_FLAG_PIO_DMA) {
+	/*
+	 * Do not use DMA if the connected device only supports PIO, even if the
+	 * port prefers PIO commands via DMA.
+	 *
+	 * Ideally, we should call atapi_check_dma() to check if it is safe for
+	 * the LLD to use DMA for REQUEST_SENSE, but we don't have a qc.
+	 * Since we can't check the command, perhaps we should only use pio?
+	 */
+	if ((ap->flags & ATA_FLAG_PIO_DMA) && !(dev->flags & ATA_DFLAG_PIO)) {
 		tf.protocol = ATAPI_PROT_DMA;
 		tf.feature |= ATAPI_PKT_DMA;
 	} else {
-- 
2.39.5


