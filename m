Return-Path: <stable+bounces-20349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA33857B73
	for <lists+stable@lfdr.de>; Fri, 16 Feb 2024 12:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C366228201E
	for <lists+stable@lfdr.de>; Fri, 16 Feb 2024 11:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879DD612D7;
	Fri, 16 Feb 2024 11:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZ60BuJG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442B460BAD;
	Fri, 16 Feb 2024 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082419; cv=none; b=TDZKYUSaaFyxo9xHPlfI46gMSK8Zo+2Te4WUFRjsBjzpuuFjbwNY5pCZpOeDs9DJbizMhfpq20xoncaXsxG/HC10xsaY6gA8IE+bVEB5aV5hbvd87Ys+QLGDdlpKiOHlncVfmlx26pYl7nTHnxFqQcPA7bepn6qeXgSFNYVG8HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082419; c=relaxed/simple;
	bh=VHv3IYjlHR6MUnfBc57C98lM3wMHgx0zJpPwl1b5C0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WQG4U0vsdgOsYvv3nFQH/g1znJCui0LrlMLF/LHJ4KFnUP56pcNN8JR1KOJb444GS/qEqtqrXtritHvl/0APIkHTkFGS2fuvbiYs54n0VVM2QmPevnuZcrYpKnlpJNcQO9VyywyD15x7NehQq2frnnjA5vBAtMUOo8xOk7DN0c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZ60BuJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080C5C433F1;
	Fri, 16 Feb 2024 11:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708082418;
	bh=VHv3IYjlHR6MUnfBc57C98lM3wMHgx0zJpPwl1b5C0Q=;
	h=From:To:Cc:Subject:Date:From;
	b=gZ60BuJG169m3E1IZ7ML64F+uRom6HmsZtlRer3uqK7WqWJ2+dVoPcUpbFjCFFfGl
	 mMuYVxSELFmwv0Lg2QMgcqvdl0JOansiVbg69U349nkxaUzUQLiz+CPgIk1VuQ0xd4
	 u8LYksz9+KfqwLN95UiLuXjekq7xDyIsbdhaH06Y4m5UzIcgUlLVYzb9LL+EbjI3XA
	 hstuFIzojYR6SZEYg1tyKhLPsdo//eKxVHpoKZ1N5/QdnjqJBcOElcToe0pouqjaYh
	 Mk6ERg5jACqPfSCFVATKzDTmW59upV5ZKfVjaFSxD/mn3THiOJ5oRujYQr7/tFWScA
	 k/bK96BOid4nw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: stable@vger.kernel.org,
	Niklas Cassel <niklas.cassel@wdc.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata-core: Do not call ata_dev_power_set_standby() twice
Date: Fri, 16 Feb 2024 12:20:07 +0100
Message-ID: <20240216112008.1112538-1-cassel@kernel.org>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Damien Le Moal <dlemoal@kernel.org>

For regular system shutdown, ata_dev_power_set_standby() will be
executed twice: once the scsi device is removed and another when
ata_pci_shutdown_one() executes and EH completes unloading the devices.

Make the second call to ata_dev_power_set_standby() do nothing by using
ata_dev_power_is_active() and return if the device is already in
standby.

Fixes: 2da4c5e24e86 ("ata: libata-core: Improve ata_dev_power_set_active()")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
This fix was originally part of patch that contained both a fix and
a revert in a single patch:
https://lore.kernel.org/linux-ide/20240111115123.1258422-3-dlemoal@kernel.org/

This patch contains the only the fix (as it is valid even without the
revert), without the revert.

Updated the Fixes tag to point to a more appropriate commit, since we
no longer revert any code.

 drivers/ata/libata-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d9f80f4f70f5..af2334bc806d 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -85,6 +85,7 @@ static unsigned int ata_dev_init_params(struct ata_device *dev,
 static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
 static void ata_dev_xfermask(struct ata_device *dev);
 static unsigned long ata_dev_blacklisted(const struct ata_device *dev);
+static bool ata_dev_power_is_active(struct ata_device *dev);
 
 atomic_t ata_print_id = ATOMIC_INIT(0);
 
@@ -2017,8 +2018,9 @@ void ata_dev_power_set_standby(struct ata_device *dev)
 	struct ata_taskfile tf;
 	unsigned int err_mask;
 
-	/* If the device is already sleeping, do nothing. */
-	if (dev->flags & ATA_DFLAG_SLEEPING)
+	/* If the device is already sleeping or in standby, do nothing. */
+	if ((dev->flags & ATA_DFLAG_SLEEPING) ||
+	    !ata_dev_power_is_active(dev))
 		return;
 
 	/*
-- 
2.43.1


