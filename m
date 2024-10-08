Return-Path: <stable+bounces-83042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B29C9950D1
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3255B23A2D
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4832D1DF25B;
	Tue,  8 Oct 2024 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UO9zwAAM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0322926ADD;
	Tue,  8 Oct 2024 13:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395936; cv=none; b=PZppYBuosfYCJD6+4CENAiFylL0LfAcvsgisGAtEjREhza3DLpf+l2+SSEiAQLh/1sRJc4vO+z+tOpQ/cA8eEC9XWsgMWxp8Z6C3SdGXs4KjVQt9e1oRB8S1os3DGHPxgBUiD4ERdjfL7LRZ36787WlxYMekljgGEsqVXeJdkg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395936; c=relaxed/simple;
	bh=YmX97+ILNhhY6E3q/z3GV+Ne8aaE7cHz7ZJ2+X6660M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gv9cuxnacXmX/pYzNa7KiZnkuD2Zhf+u4sI3kCsCG0r6UUiIX36GZTevQPlQo6Kg8ghAQ972LE/t42S5BngU/LkA12v6sn8TeLPFBcWkEgjIMJhc2/KnKI9p+fAM5oNWptCnA7c7a9AErf8v1c94WK7Qxbnbm8yWuGBsgFY7CoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UO9zwAAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8867C4CEC7;
	Tue,  8 Oct 2024 13:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728395935;
	bh=YmX97+ILNhhY6E3q/z3GV+Ne8aaE7cHz7ZJ2+X6660M=;
	h=From:To:Cc:Subject:Date:From;
	b=UO9zwAAMP5bi+y58CSW+CpgxYfPsCm+Br7XdQtH0rnKxjFIX06exZnbBNdveGa5BY
	 2MrG8D3ii+dUPB2WEmcWx+ZQJ/eHpXQPFH3rO9+hCL279hE47f8vrXWg3jjdmtu7to
	 I1ZecYmNmXuMeNq6EqgAw8wS7F0ffbflDashjoqXyMPnothsf4ko2sElDaf3Jrdt32
	 ythG3g6Pt88F5BMkLI5xwaWmUH5iXgpi0gIHgSR9v6zFrPs4TYPAPMIbRfGma8yJTb
	 3Q+I2UkqR9G9h/hdGETZRxdUiVFuPPd96bKQg7PNwj+P5tV8jwYWcW+e/wsH/Oxmhh
	 ZhEQXRFccSRHA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: W <linuxcdeveloper@gmail.com>,
	stable@vger.kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH v2] ata: libata: avoid superfluous disk spin down + spin up during hibernation
Date: Tue,  8 Oct 2024 15:58:44 +0200
Message-ID: <20241008135843.1266244-2-cassel@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2926; i=cassel@kernel.org; h=from:subject; bh=YmX97+ILNhhY6E3q/z3GV+Ne8aaE7cHz7ZJ2+X6660M=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJZrSZ/VJtX0P23odBlytOXBp02z7J8BaICg2VNe6QXV Ux9+Me5o5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABNZ/pKRYUfzoVBL365rnUIf 4iQP5d/UXrRnO0eTjM126Y8ciR9juRgZpuXn13j6CX6OUz27wfXPiavnUgt8FmtOE7QwzpBn3/m TFwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

A user reported that commit aa3998dbeb3a ("ata: libata-scsi: Disable scsi
device manage_system_start_stop") introduced a spin down + immediate spin
up of the disk both when entering and when resuming from hibernation.
This behavior was not there before, and causes an increased latency both
when when entering and when resuming from hibernation.

Hibernation is done by three consecutive PM events, in the following order:
1) PM_EVENT_FREEZE
2) PM_EVENT_THAW
3) PM_EVENT_HIBERNATE

Commit aa3998dbeb3a ("ata: libata-scsi: Disable scsi device
manage_system_start_stop") modified ata_eh_handle_port_suspend() to call
ata_dev_power_set_standby() (which spins down the disk), for both event
PM_EVENT_FREEZE and event PM_EVENT_HIBERNATE.

Documentation/driver-api/pm/devices.rst, section "Entering Hibernation",
explicitly mentions that PM_EVENT_FREEZE does not have to be put the device
in a low-power state, and actually recommends not doing so. Thus, let's not
spin down the disk on PM_EVENT_FREEZE. (The disk will instead be spun down
during the subsequent PM_EVENT_HIBERNATE event.)

This way, PM_EVENT_FREEZE will behave as it did before commit aa3998dbeb3a
("ata: libata-scsi: Disable scsi device manage_system_start_stop"), while
PM_EVENT_HIBERNATE will continue to spin down the disk.

This will avoid the superfluous spin down + spin up when entering and
resuming from hibernation, while still making sure that the disk is spun
down before actually entering hibernation.

Cc: stable@vger.kernel.org # v6.6+
Fixes: aa3998dbeb3a ("ata: libata-scsi: Disable scsi device manage_system_start_stop")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes since v1:
-Add stable to cc.

 drivers/ata/libata-eh.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 3f0144e7dc80..fa41ea57a978 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -4099,10 +4099,20 @@ static void ata_eh_handle_port_suspend(struct ata_port *ap)
 
 	WARN_ON(ap->pflags & ATA_PFLAG_SUSPENDED);
 
-	/* Set all devices attached to the port in standby mode */
-	ata_for_each_link(link, ap, HOST_FIRST) {
-		ata_for_each_dev(dev, link, ENABLED)
-			ata_dev_power_set_standby(dev);
+	/*
+	 * We will reach this point for all of the PM events:
+	 * PM_EVENT_SUSPEND (if runtime pm, PM_EVENT_AUTO will also be set)
+	 * PM_EVENT_FREEZE, and PM_EVENT_HIBERNATE.
+	 *
+	 * We do not want to perform disk spin down for PM_EVENT_FREEZE.
+	 * (Spin down will be performed by the subsequent PM_EVENT_HIBERNATE.)
+	 */
+	if (!(ap->pm_mesg.event & PM_EVENT_FREEZE)) {
+		/* Set all devices attached to the port in standby mode */
+		ata_for_each_link(link, ap, HOST_FIRST) {
+			ata_for_each_dev(dev, link, ENABLED)
+				ata_dev_power_set_standby(dev);
+		}
 	}
 
 	/*
-- 
2.46.2


