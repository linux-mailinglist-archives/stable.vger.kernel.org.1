Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D201D7D357C
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbjJWLs7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbjJWLsz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:48:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3F1FD
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:48:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B91DC433C8;
        Mon, 23 Oct 2023 11:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061731;
        bh=UtZ/XSDVwY08IM+f877s0u+Oc4SGyNd7y6cChupQpw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rVMPoQhmikrWOq2PDOjzt+r2x2cp7Tg30yDflpVKHTGrDgKm/siNZ4ww+D+noSPTd
         r4TRNgPn78ukisUh0w23wrKi0q47/gyxHvbOYBviA0wVnG/05S4B+gRaZPKyLrOi5E
         rCPvl/1HX17kKfB56J+YGcDUpMBTbQh6D4Qw3ugc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 145/202] drm/connector: Give connector sysfs devices there own device_type
Date:   Mon, 23 Oct 2023 12:57:32 +0200
Message-ID: <20231023104830.775596985@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 331de7db3012b8e8e8d77beebc8f743e288d4c42 ]

Give connector sysfs devices there own device_type, this allows us to
check if a device passed to functions dealing with generic devices is
a drm_connector or not.

A check like this is necessary in the drm_connector_acpi_bus_match()
function added in the next patch in this series.

Tested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Link: https://lore.kernel.org/r/20210817215201.795062-2-hdegoede@redhat.com
Stable-dep-of: 89434b069e46 ("usb: typec: altmodes/displayport: Signal hpd low when exiting mode")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_sysfs.c | 50 +++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index f0336c8046392..a3b71478c5904 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -50,6 +50,10 @@ static struct device_type drm_sysfs_device_minor = {
 	.name = "drm_minor"
 };
 
+static struct device_type drm_sysfs_device_connector = {
+	.name = "drm_connector",
+};
+
 struct class *drm_class;
 
 static char *drm_devnode(struct device *dev, umode_t *mode)
@@ -102,6 +106,11 @@ void drm_sysfs_destroy(void)
 	drm_class = NULL;
 }
 
+static void drm_sysfs_release(struct device *dev)
+{
+	kfree(dev);
+}
+
 /*
  * Connector properties
  */
@@ -274,27 +283,47 @@ static const struct attribute_group *connector_dev_groups[] = {
 int drm_sysfs_connector_add(struct drm_connector *connector)
 {
 	struct drm_device *dev = connector->dev;
+	struct device *kdev;
+	int r;
 
 	if (connector->kdev)
 		return 0;
 
-	connector->kdev =
-		device_create_with_groups(drm_class, dev->primary->kdev, 0,
-					  connector, connector_dev_groups,
-					  "card%d-%s", dev->primary->index,
-					  connector->name);
+	kdev = kzalloc(sizeof(*kdev), GFP_KERNEL);
+	if (!kdev)
+		return -ENOMEM;
+
+	device_initialize(kdev);
+	kdev->class = drm_class;
+	kdev->type = &drm_sysfs_device_connector;
+	kdev->parent = dev->primary->kdev;
+	kdev->groups = connector_dev_groups;
+	kdev->release = drm_sysfs_release;
+	dev_set_drvdata(kdev, connector);
+
+	r = dev_set_name(kdev, "card%d-%s", dev->primary->index, connector->name);
+	if (r)
+		goto err_free;
+
 	DRM_DEBUG("adding \"%s\" to sysfs\n",
 		  connector->name);
 
-	if (IS_ERR(connector->kdev)) {
-		DRM_ERROR("failed to register connector device: %ld\n", PTR_ERR(connector->kdev));
-		return PTR_ERR(connector->kdev);
+	r = device_add(kdev);
+	if (r) {
+		drm_err(dev, "failed to register connector device: %d\n", r);
+		goto err_free;
 	}
 
+	connector->kdev = kdev;
+
 	if (connector->ddc)
 		return sysfs_create_link(&connector->kdev->kobj,
 				 &connector->ddc->dev.kobj, "ddc");
 	return 0;
+
+err_free:
+	put_device(kdev);
+	return r;
 }
 
 void drm_sysfs_connector_remove(struct drm_connector *connector)
@@ -375,11 +404,6 @@ void drm_sysfs_connector_status_event(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_sysfs_connector_status_event);
 
-static void drm_sysfs_release(struct device *dev)
-{
-	kfree(dev);
-}
-
 struct device *drm_sysfs_minor_alloc(struct drm_minor *minor)
 {
 	const char *minor_str;
-- 
2.40.1



