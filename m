Return-Path: <stable+bounces-156706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3D8AE50C0
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CCD67AC932
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AAA1F582A;
	Mon, 23 Jun 2025 21:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g4wwlyJ6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A071819C554;
	Mon, 23 Jun 2025 21:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714069; cv=none; b=GL6pbEdHilWIWYOuHB32ZS7YGBMdKkUeK5OE6v3tvT1dnQkl4IstNeznsH3BBGsvdjjaK4MQ74Cedic+HlicPD3jf9hLPOEGNVMavPSZaqZwq1uqYl1bZg7TRByiUvw3n/eQ9HoleiHh8LjnJsYmhW8ZtSuUz3IMmXULqEqZ2Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714069; c=relaxed/simple;
	bh=At4CMw4r+c5cjlKEa7ofPaaaXVYdAd2iGIp+fjSsedQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJh1p8x0iE4WBO4Cbsbf4akTwP3tag4R9dx5oDe2SE+obMqJ2r/cBpcTT9EKS2e/ylSvlMWnk4sMWPLCDJDKJsxWFY2q+eVfkLJJzL6VXpnhcl257zwdId+c5tec7dGuFGbghIxvNgMO229TKnzadS/VR5w8IJinOkNZquvx9qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g4wwlyJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B315C4CEEA;
	Mon, 23 Jun 2025 21:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750714069;
	bh=At4CMw4r+c5cjlKEa7ofPaaaXVYdAd2iGIp+fjSsedQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g4wwlyJ6ReRiX1NGubVf8q+5S+G6qsJRQXVezCE2vfUY4qZpPaY7JUAv/Fy4LEQpi
	 vUPk2v1F8HGklnk2zvzAx9tnh7VQ7uOZCFJ22i/jRjw2TyDzU0eyrCbXKRFKOqlggD
	 qJMRcsLhJx75neC2xhk9yjHGbKJklE1RRalMtpU8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tasos Sahanidis <tasos@tasossah.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 5.10 182/355] ata: pata_via: Force PIO for ATAPI devices on VT6415/VT6330
Date: Mon, 23 Jun 2025 15:06:23 +0200
Message-ID: <20250623130632.162918336@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.716971725@linuxfoundation.org>
References: <20250623130626.716971725@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tasos Sahanidis <tasos@tasossah.com>

commit d29fc02caad7f94b62d56ee1b01c954f9c961ba7 upstream.

The controller has a hardware bug that can hard hang the system when
doing ATAPI DMAs without any trace of what happened. Depending on the
device attached, it can also prevent the system from booting.

In this case, the system hangs when reading the ATIP from optical media
with cdrecord -vvv -atip on an _NEC DVD_RW ND-4571A 1-01 and an
Optiarc DVD RW AD-7200A 1.06 attached to an ASRock 990FX Extreme 4,
running at UDMA/33.

The issue can be reproduced by running the same command with a cygwin
build of cdrecord on WinXP, although it requires more attempts to cause
it. The hang in that case is also resolved by forcing PIO. It doesn't
appear that VIA has produced any drivers for that OS, thus no known
workaround exists.

HDDs attached to the controller do not suffer from any DMA issues.

Cc: stable@vger.kernel.org
Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/916677
Signed-off-by: Tasos Sahanidis <tasos@tasossah.com>
Link: https://lore.kernel.org/r/20250519085508.1398701-1-tasos@tasossah.com
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/pata_via.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -368,7 +368,8 @@ static unsigned long via_mode_filter(str
 	}
 
 	if (dev->class == ATA_DEV_ATAPI &&
-	    dmi_check_system(no_atapi_dma_dmi_table)) {
+	    (dmi_check_system(no_atapi_dma_dmi_table) ||
+	     config->id == PCI_DEVICE_ID_VIA_6415)) {
 		ata_dev_warn(dev, "controller locks up on ATAPI DMA, forcing PIO\n");
 		mask &= ATA_MASK_PIO;
 	}



