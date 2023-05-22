Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CF670C8B2
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbjEVTlE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbjEVTka (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:40:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BED19B
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCBD6629FC
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4628C433EF;
        Mon, 22 May 2023 19:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784423;
        bh=V9qfCXiqRnF5svfD+XiUfjcw4V4JRi/RM8set1IjB/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NPc0y5zkjhqi/44Lwl0LihWc3aDcDS1DEaqSvZUvXP0jAfCv531bax7RsyjUOyCmK
         eRykWdnzWjDB06bLgwEvGVxJ0QFfwGE9C9LAznMdfzO+ZhtNNdNejXUyzTE/YK1R2P
         f0SgyD2Zvk2VzLmdOggDFpWbjOijHKAIN89hzIqc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bingbu Cao <bingbu.cao@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 078/364] media: ipu3-cio2: support multiple sensors and VCMs with same HID
Date:   Mon, 22 May 2023 20:06:23 +0100
Message-Id: <20230522190414.719961480@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Bingbu Cao <bingbu.cao@intel.com>

[ Upstream commit 567f97bd381fd79fa8563808118fc757cb6fa4ff ]

In current cio2-bridge, it is using the hid name to register software
node and software node will create kobject and sysfs entry according to
the node name, if there are multiple sensors and VCMs which are sharing
same HID name, it will cause the software nodes registration failure:

sysfs: cannot create duplicate filename '/kernel/software_nodes/dw9714'
...
Call Trace:
software_node_register_nodes
cio2_bridge_init
...
kobject_add_internal failed for dw9714 with -EEXIST,
don't try to register things with the same name in the same directory.

One solution is appending the sensor link(Mipi Port) in SSDB as suffix
of the node name to fix this problem.

Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/intel/ipu3/cio2-bridge.c | 15 +++++++++++----
 drivers/media/pci/intel/ipu3/cio2-bridge.h |  3 ++-
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.c b/drivers/media/pci/intel/ipu3/cio2-bridge.c
index dfefe0d8aa959..45427a3a3a252 100644
--- a/drivers/media/pci/intel/ipu3/cio2-bridge.c
+++ b/drivers/media/pci/intel/ipu3/cio2-bridge.c
@@ -212,6 +212,7 @@ static void cio2_bridge_create_connection_swnodes(struct cio2_bridge *bridge,
 						  struct cio2_sensor *sensor)
 {
 	struct software_node *nodes = sensor->swnodes;
+	char vcm_name[ACPI_ID_LEN + 4];
 
 	cio2_bridge_init_swnode_names(sensor);
 
@@ -229,9 +230,13 @@ static void cio2_bridge_create_connection_swnodes(struct cio2_bridge *bridge,
 						sensor->node_names.endpoint,
 						&nodes[SWNODE_CIO2_PORT],
 						sensor->cio2_properties);
-	if (sensor->ssdb.vcmtype)
-		nodes[SWNODE_VCM] =
-			NODE_VCM(cio2_vcm_types[sensor->ssdb.vcmtype - 1]);
+	if (sensor->ssdb.vcmtype) {
+		/* append ssdb.link to distinguish VCM nodes with same HID */
+		snprintf(vcm_name, sizeof(vcm_name), "%s-%u",
+			 cio2_vcm_types[sensor->ssdb.vcmtype - 1],
+			 sensor->ssdb.link);
+		nodes[SWNODE_VCM] = NODE_VCM(vcm_name);
+	}
 
 	cio2_bridge_init_swnode_group(sensor);
 }
@@ -295,7 +300,6 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
 		}
 
 		sensor = &bridge->sensors[bridge->n_sensors];
-		strscpy(sensor->name, cfg->hid, sizeof(sensor->name));
 
 		ret = cio2_bridge_read_acpi_buffer(adev, "SSDB",
 						   &sensor->ssdb,
@@ -303,6 +307,9 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
 		if (ret)
 			goto err_put_adev;
 
+		snprintf(sensor->name, sizeof(sensor->name), "%s-%u",
+			 cfg->hid, sensor->ssdb.link);
+
 		if (sensor->ssdb.vcmtype > ARRAY_SIZE(cio2_vcm_types)) {
 			dev_warn(&adev->dev, "Unknown VCM type %d\n",
 				 sensor->ssdb.vcmtype);
diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.h b/drivers/media/pci/intel/ipu3/cio2-bridge.h
index b93b749c65bda..b76ed8a641e20 100644
--- a/drivers/media/pci/intel/ipu3/cio2-bridge.h
+++ b/drivers/media/pci/intel/ipu3/cio2-bridge.h
@@ -113,7 +113,8 @@ struct cio2_sensor_config {
 };
 
 struct cio2_sensor {
-	char name[ACPI_ID_LEN];
+	/* append ssdb.link(u8) in "-%u" format as suffix of HID */
+	char name[ACPI_ID_LEN + 4];
 	struct acpi_device *adev;
 	struct i2c_client *vcm_i2c_client;
 
-- 
2.39.2



