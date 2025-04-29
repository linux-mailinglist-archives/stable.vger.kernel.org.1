Return-Path: <stable+bounces-138806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C713AA19C1
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B30504E070D
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55CB155333;
	Tue, 29 Apr 2025 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k5yZVj1m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE6E227BA9;
	Tue, 29 Apr 2025 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950409; cv=none; b=FdiS1wAMB3b6FGMAPKvwGu5undp/lLl+5urc0mJV0L66LICd1HR7J3+IC2NeqmhXsfbbJTmfIZFS1gmg8r0U29GRc6dAAwkoiJcjh8xOh4jR4cVhgC/PCBxSQkRGy/L0/hQAPTMp/t8QFuYb5NhIJ1Atewh5Q1WsjQ13xDEMPA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950409; c=relaxed/simple;
	bh=8Xz3RWIS7WRA7h57vLLo5SUkIR0J6nWT6U+mQhHsWYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kf3ODLSgItmN1/yQI4pg/h+dxj3IUgtIccvtF40xjjBoTXvdITbiCmhp3fStGMkTgxKdhQRjj6LtqbuyUEUDKlh1JgdX+bKQonLsPkMN6h3T5SVsQqbcE66GK0auno9xE2BrM0DKrqh/KnxLOjTet+XF+6SJTsuf2zEaWGsNnak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k5yZVj1m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2180C4CEE3;
	Tue, 29 Apr 2025 18:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745950409;
	bh=8Xz3RWIS7WRA7h57vLLo5SUkIR0J6nWT6U+mQhHsWYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k5yZVj1mOQeFFm4x+vkDK4+2IX9DzcVl9IVkpjEq6fogWCdqSr5wLklbyGD4C1dza
	 kFzk4D9RPGTyxxZjOM5J5k+zAlZWVpxGtEMtjvg7BBhJupgonBUnTucMYNyt+HllqW
	 cnTffotgb6SAvgM4J+Xmo5/MEFbZIbth5cLDahPQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Igor Pylypiv <ipylypiv@google.com>
Subject: [PATCH 6.6 086/204] ata: libata-scsi: Improve CDL control
Date: Tue, 29 Apr 2025 18:42:54 +0200
Message-ID: <20250429161102.943099522@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161059.396852607@linuxfoundation.org>
References: <20250429161059.396852607@linuxfoundation.org>
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

From: Damien Le Moal <dlemoal@kernel.org>

commit 17e897a456752ec9c2d7afb3d9baf268b442451b upstream.

With ATA devices supporting the CDL feature, using CDL requires that the
feature be enabled with a SET FEATURES command. This command is issued
as the translated command for the MODE SELECT command issued by
scsi_cdl_enable() when the user enables CDL through the device
cdl_enable sysfs attribute.

Currently, ata_mselect_control_ata_feature() always translates a MODE
SELECT command for the ATA features subpage of the control mode page to
a SET FEATURES command to enable or disable CDL based on the cdl_ctrl
field. However, there is no need to issue the SET FEATURES command if:
1) The MODE SELECT command requests disabling CDL and CDL is already
   disabled.
2) The MODE SELECT command requests enabling CDL and CDL is already
   enabled.

Fix ata_mselect_control_ata_feature() to issue the SET FEATURES command
only when necessary. Since enabling CDL also implies a reset of the CDL
statistics log page, avoiding useless CDL enable operations also avoids
clearing the CDL statistics log.

Also add debug messages to clearly signal when CDL is being enabled or
disabled using a SET FEATURES command.

Fixes: df60f9c64576 ("scsi: ata: libata: Add ATA feature control sub-page translation")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Igor Pylypiv <ipylypiv@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/libata-scsi.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3787,17 +3787,27 @@ static unsigned int ata_mselect_control_
 	/* Check cdl_ctrl */
 	switch (buf[0] & 0x03) {
 	case 0:
-		/* Disable CDL */
+		/* Disable CDL if it is enabled */
+		if (!(dev->flags & ATA_DFLAG_CDL_ENABLED))
+			return 0;
+		ata_dev_dbg(dev, "Disabling CDL\n");
 		cdl_action = 0;
 		dev->flags &= ~ATA_DFLAG_CDL_ENABLED;
 		break;
 	case 0x02:
-		/* Enable CDL T2A/T2B: NCQ priority must be disabled */
+		/*
+		 * Enable CDL if not already enabled. Since this is mutually
+		 * exclusive with NCQ priority, allow this only if NCQ priority
+		 * is disabled.
+		 */
+		if (dev->flags & ATA_DFLAG_CDL_ENABLED)
+			return 0;
 		if (dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED) {
 			ata_dev_err(dev,
 				"NCQ priority must be disabled to enable CDL\n");
 			return -EINVAL;
 		}
+		ata_dev_dbg(dev, "Enabling CDL\n");
 		cdl_action = 1;
 		dev->flags |= ATA_DFLAG_CDL_ENABLED;
 		break;



