Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B03479B365
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238893AbjIKUyc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239271AbjIKOQP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:16:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B74BE0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:16:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC3CC433C8;
        Mon, 11 Sep 2023 14:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441771;
        bh=jkM3kiUiwKBjNWksBLmKywPI4ZysbmLHvkphlbG9pUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KWn2WR3mXBDdPp/CxjhyAPGgweM2klPk4X33bzhl6rFcvSG7RYzII7T1rv/MPL1t0
         jN9shLBETsaWbp27G18LTrXmbApJkGHtTCvOjUbHhXM3Rna8zOz8D19fl/OCfxtqZy
         2g+x1qA+Vn/FY1XseBpklWNselwvYlVkqKf9nDW8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bingbu Cao <bingbu.cao@intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 531/739] media: ipu-bridge: Do not use on stack memory for software_node.name field
Date:   Mon, 11 Sep 2023 15:45:30 +0200
Message-ID: <20230911134705.940292901@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 11e0a7c8e04ee5f406f2baa27761746cbedcfa11 ]

Commit 567f97bd381f ("media: ipu3-cio2: support multiple sensors and VCMs
with same HID") introduced an on stack vcm_name and then uses this for
the name field of the software_node struct used for the vcm.

But the software_node struct is much longer lived then the current
stack-frame, so this is no good.

Instead extend the ipu_node_names struct with an extra field to store
the vcm software_node name and use that.

Note this also changes the length of the allocated buffer from
ACPI_ID_LEN + 4 to 16. the name is filled with "<ipu_vcm_types[x]>-%u"
where ipu_vcm_types[x] is not an ACPI_ID. The maximum length of
the strings in the ipu_vcm_types[] array is 11 + 5 bytes for "-255\0"
means 16 bytes are needed in the worst case scenario.

Fixes: 567f97bd381f ("media: ipu3-cio2: support multiple sensors and VCMs with same HID")
Cc: Bingbu Cao <bingbu.cao@intel.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/intel/ipu-bridge.c | 7 +++----
 drivers/media/pci/intel/ipu-bridge.h | 1 +
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index 38fa756602bc0..88490ea304dee 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -220,7 +220,6 @@ static void ipu_bridge_create_connection_swnodes(struct ipu_bridge *bridge,
 						 struct ipu_sensor *sensor)
 {
 	struct software_node *nodes = sensor->swnodes;
-	char vcm_name[ACPI_ID_LEN + 4];
 
 	ipu_bridge_init_swnode_names(sensor);
 
@@ -240,10 +239,10 @@ static void ipu_bridge_create_connection_swnodes(struct ipu_bridge *bridge,
 						sensor->ipu_properties);
 	if (sensor->ssdb.vcmtype) {
 		/* append ssdb.link to distinguish VCM nodes with same HID */
-		snprintf(vcm_name, sizeof(vcm_name), "%s-%u",
-			 ipu_vcm_types[sensor->ssdb.vcmtype - 1],
+		snprintf(sensor->node_names.vcm, sizeof(sensor->node_names.vcm),
+			 "%s-%u", ipu_vcm_types[sensor->ssdb.vcmtype - 1],
 			 sensor->ssdb.link);
-		nodes[SWNODE_VCM] = NODE_VCM(vcm_name);
+		nodes[SWNODE_VCM] = NODE_VCM(sensor->node_names.vcm);
 	}
 
 	ipu_bridge_init_swnode_group(sensor);
diff --git a/drivers/media/pci/intel/ipu-bridge.h b/drivers/media/pci/intel/ipu-bridge.h
index d35b5f30ac3fc..1ff0b2d04d929 100644
--- a/drivers/media/pci/intel/ipu-bridge.h
+++ b/drivers/media/pci/intel/ipu-bridge.h
@@ -104,6 +104,7 @@ struct ipu_node_names {
 	char port[7];
 	char endpoint[11];
 	char remote_port[7];
+	char vcm[16];
 };
 
 struct ipu_sensor_config {
-- 
2.40.1



