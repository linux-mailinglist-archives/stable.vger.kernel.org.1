Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DC57B8AA1
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244449AbjJDSh0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244462AbjJDShZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:37:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D3898
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:37:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49561C433C8;
        Wed,  4 Oct 2023 18:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444641;
        bh=rSb2y//9mlAAfnFhpZI6PL4Qz4SpRx7O8kIon6ytwZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N1CQeMPybLXRwm+D8WHrai8yN798aZjToohiG+UMfR1mm8kCV4lbPbkPe83Murh+q
         g9Y17E+CQQpRuDPaLV8mq42Se+zfYcetp6ZDwdiP5YSvra+IURN6kiGR3YuDrEHFM4
         rb5njxOUAbOPIPb9ExV1n90CMYGukW2s0mAXVN+g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        John Garry <john.g.garry@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.5 305/321] ata: libata-core: Do not register PM operations for SAS ports
Date:   Wed,  4 Oct 2023 19:57:30 +0200
Message-ID: <20231004175243.427125600@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <dlemoal@kernel.org>

commit 75e2bd5f1ede42a2bc88aa34b431e1ace8e0bea0 upstream.

libsas does its own domain based power management of ports. For such
ports, libata should not use a device type defining power management
operations as executing these operations for suspend/resume in addition
to libsas calls to ata_sas_port_suspend() and ata_sas_port_resume() is
not necessary (and likely dangerous to do, even though problems are not
seen currently).

Introduce the new ata_port_sas_type device_type for ports managed by
libsas. This new device type is used in ata_tport_add() and is defined
without power management operations.

Fixes: 2fcbdcb4c802 ("[SCSI] libata: export ata_port suspend/resume infrastructure for sas")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Tested-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/libata-core.c      |    2 +-
 drivers/ata/libata-transport.c |    9 ++++++++-
 drivers/ata/libata.h           |    2 ++
 3 files changed, 11 insertions(+), 2 deletions(-)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5396,7 +5396,7 @@ EXPORT_SYMBOL_GPL(ata_host_resume);
 #endif
 
 const struct device_type ata_port_type = {
-	.name = "ata_port",
+	.name = ATA_PORT_TYPE_NAME,
 #ifdef CONFIG_PM
 	.pm = &ata_port_pm_ops,
 #endif
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -266,6 +266,10 @@ void ata_tport_delete(struct ata_port *a
 	put_device(dev);
 }
 
+static const struct device_type ata_port_sas_type = {
+	.name = ATA_PORT_TYPE_NAME,
+};
+
 /** ata_tport_add - initialize a transport ATA port structure
  *
  * @parent:	parent device
@@ -283,7 +287,10 @@ int ata_tport_add(struct device *parent,
 	struct device *dev = &ap->tdev;
 
 	device_initialize(dev);
-	dev->type = &ata_port_type;
+	if (ap->flags & ATA_FLAG_SAS_HOST)
+		dev->type = &ata_port_sas_type;
+	else
+		dev->type = &ata_port_type;
 
 	dev->parent = parent;
 	ata_host_get(ap->host);
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -30,6 +30,8 @@ enum {
 	ATA_DNXFER_QUIET	= (1 << 31),
 };
 
+#define ATA_PORT_TYPE_NAME	"ata_port"
+
 extern atomic_t ata_print_id;
 extern int atapi_passthru16;
 extern int libata_fua;


