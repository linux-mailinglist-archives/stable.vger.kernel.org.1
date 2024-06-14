Return-Path: <stable+bounces-52193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C63908B9B
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 14:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9555A1C25EB5
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 12:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98193196C8B;
	Fri, 14 Jun 2024 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYdBguBr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AB9195F00;
	Fri, 14 Jun 2024 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718367838; cv=none; b=JJrRfaryBPXNDFsUxK30bxdY6OpiMgrjP/uHqRzTaN3NC7/hSO4IxyRxuC9FQTiw2eh6+4fn9yFzaSczQBvvApt/O0CzIJSUtVzb8mhIduRwhM+RAdwsHh7JHZTFcFbRNd/ITxHjHyLC6xMqrHEGfSAEDk0leqEfUN3YlnmYaGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718367838; c=relaxed/simple;
	bh=DGzoCCxLNYT6BKKWvGiqwmKAtrD18PJlb8XGaVgkId4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P8DmzG/flIf5bx04yrtoW8uzEKDNQWtkY/Pp8TnoX/iOtzno+oBwGq8uXNTwmdx5f634hjxkC2znJ4whc1mPYwFApTThrcwE0NRWUj323NcWss9BtP+HMwxrtD2eLFpr+5H132AwRdqYMQCWhx3EZ2Yap7TsKH8NF9NqRlFwqOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYdBguBr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4F7C2BD10;
	Fri, 14 Jun 2024 12:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718367837;
	bh=DGzoCCxLNYT6BKKWvGiqwmKAtrD18PJlb8XGaVgkId4=;
	h=From:To:Cc:Subject:Date:From;
	b=FYdBguBramcWq1BCVB4FTHYaixFhRO/ff49NWxw4unPedzyvLlBQL+JPrFdRq1Txc
	 Y16GBVMP5AA42jYfr8GiA83cGDp84Ij3bL6DxS2Fyh/kF8teegHyC/t50VADivGi/b
	 NijQ21DE8ej34YN+nScgod2LgjoXyDyzw6bi4K1AXgYrx2ojj/7EVxQIkPZdkJPP1A
	 lG07zjADYMLJka+d9hTTTAPWJmu6T4DEU2eeKVkjOV4vcEFrcHaef0XWZ29kVdptwn
	 iA8u0tOxKbwM+4IL8RfT6VLEXuUXRqxwShFGXR48Z3hnvcfifsLNZZxTG+n9h47NEE
	 L728qiABhCZ6Q==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Cc: Manuel Lauss <manuel.lauss@gmail.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-ide@vger.kernel.org
Subject: [PATCH v2] ata: libata-scsi: Set the RMB bit only for removable media devices
Date: Fri, 14 Jun 2024 14:23:45 +0200
Message-ID: <20240614122344.1577261-2-cassel@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4082; i=cassel@kernel.org; h=from:subject; bh=HS/n3PxLTOvnvuCou+RcDHhcilzm+RDmUNKnYhgZQ3g=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJyzALv+5eVnfoYbJPr9STYkb+34G62YMCchbbdUx9KL vR95ljSUcrCIMbFICumyOL7w2V/cbf7lOOKd2xg5rAygQxh4OIUgIkYNzEyzI3OYdZJC/g801VM yYD1dUBG+3aZuHjZ9sRZ9gfk+b+WMTKc87yyvmnO/uVtx4y/Ntcf6ZWQ2fKw+0qVQa6unPI3/Rx 2AA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

From: Damien Le Moal <dlemoal@kernel.org>

The SCSI Removable Media Bit (RMB) should only be set for removable media,
where the device stays and the media changes, e.g. CD-ROM or floppy.

The ATA removable media device bit is obsoleted since ATA-8 ACS (2006),
but before that it was used to indicate that the device can have its media
removed (while the device stays).

Commit 8a3e33cf92c7 ("ata: ahci: find eSATA ports and flag them as
removable") introduced a change to set the RMB bit if the port has either
the eSATA bit or the hot-plug capable bit set. The reasoning was that the
author wanted his eSATA ports to get treated like a USB stick.

This is however wrong. See "20-082r23SPC-6: Removable Medium Bit
Expectations" which has since been integrated to SPC, which states that:

"""
Reports have been received that some USB Memory Stick device servers set
the removable medium (RMB) bit to one. The rub comes when the medium is
actually removed, because... The device server is removed concurrently
with the medium removal. If there is no device server, then there is no
device server that is waiting to have removable medium inserted.

Sufficient numbers of SCSI analysts see such a device:
- not as a device that supports removable medium;
but
- as a removable, hot pluggable device.
"""

The definition of the RMB bit in the SPC specification has since been
clarified to match this.

Thus, a USB stick should not have the RMB bit set (and neither shall an
eSATA nor a hot-plug capable port).

Commit dc8b4afc4a04 ("ata: ahci: don't mark HotPlugCapable Ports as
external/removable") then changed so that the RMB bit is only set for the
eSATA bit (and not for the hot-plug capable bit), because of a lot of bug
reports of SATA devices were being automounted by udisks. However,
treating eSATA and hot-plug capable ports differently is not correct.

From the AHCI 1.3.1 spec:
Hot Plug Capable Port (HPCP): When set to '1', indicates that this port's
signal and power connectors are externally accessible via a joint signal
and power connector for blindmate device hot plug.

So a hot-plug capable port is an external port, just like commit
45b96d65ec68 ("ata: ahci: a hotplug capable port is an external port")
claims.

In order to not violate the SPC specification, modify the SCSI INQUIRY
data to only set the RMB bit if the ATA device can have its media removed.

This fixes a reported problem where GNOME/udisks was automounting devices
connected to hot-plug capable ports.

Fixes: 45b96d65ec68 ("ata: ahci: a hotplug capable port is an external port")
Cc: stable@vger.kernel.org
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Tested-by: Thomas Weißschuh <linux@weissschuh.net>
Reported-by: Thomas Weißschuh <linux@weissschuh.net>
Closes: https://lore.kernel.org/linux-ide/c0de8262-dc4b-4c22-9fac-33432e5bddd3@t-8ch.de/
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
[cassel: wrote commit message]
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes since v1:
-Added Cc: stable.
-Updated comment and commit message to correctly state that the
 ATA removable media device bit is obsoleted since ATA-8 ACS.

 drivers/ata/libata-scsi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index cdf29b178ddc..bb4d30d377ae 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1831,11 +1831,11 @@ static unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf)
 		2
 	};
 
-	/* set scsi removable (RMB) bit per ata bit, or if the
-	 * AHCI port says it's external (Hotplug-capable, eSATA).
+	/*
+	 * Set the SCSI Removable Media Bit (RMB) if the ATA removable media
+	 * device bit (obsolete since ATA-8 ACS) is set.
 	 */
-	if (ata_id_removable(args->id) ||
-	    (args->dev->link->ap->pflags & ATA_PFLAG_EXTERNAL))
+	if (ata_id_removable(args->id))
 		hdr[1] |= (1 << 7);
 
 	if (args->dev->class == ATA_DEV_ZAC) {
-- 
2.45.2


