Return-Path: <stable+bounces-127741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4FFA7AA3E
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2837179ECF
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB016258CC8;
	Thu,  3 Apr 2025 19:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVk6qFzA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15592586FE;
	Thu,  3 Apr 2025 19:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743706992; cv=none; b=WgyoTDMxMppfJ8CUy+fhMu1vwCP0MxkJGlej+L0LTlJ5muchQQlJes//sj13gcaHPwaZxC7h3oq+XtacOea/wuQiBg3Q+5s/hBBPpR0/LSlKKdq3m8mqlZfSoSjAdSiHdMD924l+WqMc5/WEkDrsEHJS6W6dntIJJVqyFjurEWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743706992; c=relaxed/simple;
	bh=ZCC9jh7ZVX2fGD7QT2FFdDBEpGSuODp4SIPv7b74Fa0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NggwZTWcyy3b1GxWkH7sH9fFEDEpDZNqw7h22LmnDXZicRPZhLrjD16BJ4MxQlxHX6/jRM/fXZRfBtX+guL+jGq+fAJGXubH3eHEEWGyAUDkR/kHyoX2TK+Ndnyr4fZlTCfZtiEqb4oyU/ajBNdX+uUuRvdrikNZAGkBCgMYdtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVk6qFzA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C27C4CEE8;
	Thu,  3 Apr 2025 19:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743706992;
	bh=ZCC9jh7ZVX2fGD7QT2FFdDBEpGSuODp4SIPv7b74Fa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JVk6qFzAm3dctCyKtljgQcwzh3hQLSIujXw24z6VrOTVpX01hg4MJOy73N2ohUz0k
	 NKLsbRFtW2lcN5SbT3TaXh5rUMJaU0Hg7hvbWbj5CQ1uX8BVrFy9HDjL+K/FCAl4ta
	 OViBpbLNxot3WVhpMU4Gp8Yi2hH+qBVXgVHWo7mKiedMBnaApgZWd0A9IoiWKOBWfx
	 LmxkNy0GeO/2zwsBi4F00B/GWIyw58KDJtZId8KwSMZUZGtA8gVNDu9j1A6Kg1h16F
	 Yduu7vjClhsDGWIL5Sqref/cmWvRTz1vQ3zvhP+QZavYHv83Aso78X0478vL8xG9Gg
	 hbZgE0BLGS7fQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	Philip Pemberton <lists@philpem.me.uk>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 26/54] ata: libata-eh: Do not use ATAPI DMA for a device limited to PIO mode
Date: Thu,  3 Apr 2025 15:01:41 -0400
Message-Id: <20250403190209.2675485-26-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190209.2675485-1-sashal@kernel.org>
References: <20250403190209.2675485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
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
index 3b303d4ae37a0..16cd676eae1f9 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1542,8 +1542,15 @@ unsigned int atapi_eh_request_sense(struct ata_device *dev,
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


