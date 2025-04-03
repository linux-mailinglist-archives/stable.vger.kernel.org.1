Return-Path: <stable+bounces-127899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7741FA7AD09
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 848793BBD59
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBDF290BC6;
	Thu,  3 Apr 2025 19:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdmKh2tI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EA9290BBF;
	Thu,  3 Apr 2025 19:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707347; cv=none; b=pl74p8kE4co1LtQ36sWJoOKY8lzWViB2iXtAiJj8D9mWdiEBOq3GYgVolqk2eilKtxR1DTaBkdGIc4PX8kX/XZjEGcPaxSSf7I2yh9kss3NbsFZzsHHQ9bWvPkv/M7u34Kc151QOHF3LFXElPZIF6bgCC+1PsLqcW5utQGKNrjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707347; c=relaxed/simple;
	bh=vzZz1AkG22CglZ5ijuwVEv2MycnZbPnoy7xDovhMsWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gW2R7RHrF29uw3kidv6SKC8WSwXUhPxGHLimQYuE4LEE10xGAQ+VvJG/sdzpEve2kYxBL1M2nd3s+McC2dqS1VEN+ZJDq6FccmYalKUMfg0puHmKUJgMFpnAU3VRSI4LfvVCUQoEBz4RrnCsAGOedkF5hSs155pGK8KCNv4oyNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdmKh2tI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37D4C4CEE9;
	Thu,  3 Apr 2025 19:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707346;
	bh=vzZz1AkG22CglZ5ijuwVEv2MycnZbPnoy7xDovhMsWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JdmKh2tILV56Xsauqu9FK4ExUzT10jysrZE0m2OAT9NX0CZ9x9KHf3PBVO9odQ8Dh
	 In8HVDm45rYGQbKk0GN0jymV/OUT0VZpv+LeceSp7LCUT5tG/ah4uB389Huz8j3vDx
	 VAYjyFx6JeKWaoTho6ZlO0QHmZXN8d9SKm/6Eaw/4lL7e7hN6XLljjAR6U5KAnaG2i
	 HEpk/q8JQqL2UMssBLKh4UnmjahsCOxlXHxLVIE2UH5euTI2VkhhF9F336vp/WbTaq
	 MWqxuiz7uaGutIeqqvMRV1GrLs2aaTLwPumSQqi7T9HzR4bpeh0Oy146NPMnwRXEYu
	 vvee66aVbkDYQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	Philip Pemberton <lists@philpem.me.uk>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 08/18] ata: libata-eh: Do not use ATAPI DMA for a device limited to PIO mode
Date: Thu,  3 Apr 2025 15:08:34 -0400
Message-Id: <20250403190845.2678025-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190845.2678025-1-sashal@kernel.org>
References: <20250403190845.2678025-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.132
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
index 3f327ba759fd9..586982a2a61ff 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1510,8 +1510,15 @@ unsigned int atapi_eh_request_sense(struct ata_device *dev,
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


