Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C88B7D3581
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbjJWLtG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbjJWLtF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:49:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43CCE8
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:49:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E689EC433C7;
        Mon, 23 Oct 2023 11:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061743;
        bh=IjjfcJuMDyru9+CyHjpeMvxkkmCfNsS3Lnsi6XlywI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gazvga1zMUKLJB0bXq9JbbmiPBsHu8ofPdzPyd8sBOTkTo7ZNDRR78mTxQoOb1EkU
         /qOq22oLpcQfBByNX0LWL3j7iL2YmlSO8HsPQNKjZpB/pE/1OFPQHMP3if7/mDUtfO
         3wUwB1QjnyXNJfsKHNThkgCToHzqyy3rleQtR89s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 149/202] usb: typec: altmodes/displayport: Notify drm subsys of hotplug events
Date:   Mon, 23 Oct 2023 12:57:36 +0200
Message-ID: <20231023104830.883973906@linuxfoundation.org>
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

[ Upstream commit 7f811394878535ed9a6849717de8c2959ae38899 ]

Use the new drm_connector_oob_hotplug_event() functions to let drm/kms
drivers know about DisplayPort over Type-C hotplug events.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Tested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Link: https://lore.kernel.org/r/20210817215201.795062-9-hdegoede@redhat.com
Stable-dep-of: 89434b069e46 ("usb: typec: altmodes/displayport: Signal hpd low when exiting mode")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/altmodes/Kconfig       |  1 +
 drivers/usb/typec/altmodes/displayport.c | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/usb/typec/altmodes/Kconfig b/drivers/usb/typec/altmodes/Kconfig
index 60d375e9c3c7c..1a6b5e872b0d9 100644
--- a/drivers/usb/typec/altmodes/Kconfig
+++ b/drivers/usb/typec/altmodes/Kconfig
@@ -4,6 +4,7 @@ menu "USB Type-C Alternate Mode drivers"
 
 config TYPEC_DP_ALTMODE
 	tristate "DisplayPort Alternate Mode driver"
+	depends on DRM
 	help
 	  DisplayPort USB Type-C Alternate Mode allows DisplayPort
 	  displays and adapters to be attached to the USB Type-C
diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 0d4b1c0eeefb3..8083d5faf0c98 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -11,8 +11,10 @@
 #include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/usb/pd_vdo.h>
 #include <linux/usb/typec_dp.h>
+#include <drm/drm_connector.h>
 #include "displayport.h"
 
 #define DP_HEADER(_dp, cmd)		(VDO((_dp)->alt->svid, 1, cmd) | \
@@ -57,11 +59,13 @@ struct dp_altmode {
 	struct typec_displayport_data data;
 
 	enum dp_state state;
+	bool hpd;
 
 	struct mutex lock; /* device lock */
 	struct work_struct work;
 	struct typec_altmode *alt;
 	const struct typec_altmode *port;
+	struct fwnode_handle *connector_fwnode;
 };
 
 static int dp_altmode_notify(struct dp_altmode *dp)
@@ -122,6 +126,7 @@ static int dp_altmode_configure(struct dp_altmode *dp, u8 con)
 static int dp_altmode_status_update(struct dp_altmode *dp)
 {
 	bool configured = !!DP_CONF_GET_PIN_ASSIGN(dp->data.conf);
+	bool hpd = !!(dp->data.status & DP_STATUS_HPD_STATE);
 	u8 con = DP_STATUS_CONNECTION(dp->data.status);
 	int ret = 0;
 
@@ -134,6 +139,11 @@ static int dp_altmode_status_update(struct dp_altmode *dp)
 		ret = dp_altmode_configure(dp, con);
 		if (!ret)
 			dp->state = DP_STATE_CONFIGURE;
+	} else {
+		if (dp->hpd != hpd) {
+			drm_connector_oob_hotplug_event(dp->connector_fwnode);
+			dp->hpd = hpd;
+		}
 	}
 
 	return ret;
@@ -526,6 +536,7 @@ static const struct attribute_group dp_altmode_group = {
 int dp_altmode_probe(struct typec_altmode *alt)
 {
 	const struct typec_altmode *port = typec_altmode_get_partner(alt);
+	struct fwnode_handle *fwnode;
 	struct dp_altmode *dp;
 	int ret;
 
@@ -554,6 +565,11 @@ int dp_altmode_probe(struct typec_altmode *alt)
 	alt->desc = "DisplayPort";
 	alt->ops = &dp_altmode_ops;
 
+	fwnode = dev_fwnode(alt->dev.parent->parent); /* typec_port fwnode */
+	dp->connector_fwnode = fwnode_find_reference(fwnode, "displayport", 0);
+	if (IS_ERR(dp->connector_fwnode))
+		dp->connector_fwnode = NULL;
+
 	typec_altmode_set_drvdata(alt, dp);
 
 	dp->state = DP_STATE_ENTER;
@@ -569,6 +585,13 @@ void dp_altmode_remove(struct typec_altmode *alt)
 
 	sysfs_remove_group(&alt->dev.kobj, &dp_altmode_group);
 	cancel_work_sync(&dp->work);
+
+	if (dp->connector_fwnode) {
+		if (dp->hpd)
+			drm_connector_oob_hotplug_event(dp->connector_fwnode);
+
+		fwnode_handle_put(dp->connector_fwnode);
+	}
 }
 EXPORT_SYMBOL_GPL(dp_altmode_remove);
 
-- 
2.40.1



