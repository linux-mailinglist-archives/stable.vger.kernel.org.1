Return-Path: <stable+bounces-23689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9188675E9
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 14:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82AD71F241D6
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 13:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9F47F7F9;
	Mon, 26 Feb 2024 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fsGmzLeR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF955A7B9
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708952503; cv=none; b=gJWfdebvHtFLIG8g4SBII5dwY8+j3+SI/CykxYUn+/ia6FzJmoFEx6GqtCev4wUjC5yVSAjC/uljqTupaDKVux2p+fwJrxNXVU3PBTtOcjuilG0j9w16ZjVYqswydwh/fNWAxwCgqCh9UMukkhexgXq7krN1hcgAVlBxlje2fIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708952503; c=relaxed/simple;
	bh=+RGBByuYFhyK92UpvEbeHlmZA3ykbVo83BHYtF6pKvY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eYGPaevZHtM/VxTsE0/eDoveMbLX31MakU5y3ILb36Ann34vCSEta1UdsgqSrjIjzy9DubTOaSkHiZZtqN1QT2/r2c1e/sVhcPKrERsCofY6wJjQoSEaUGyZDDn3GikGRy6bySIgHwV2MKS1szbmGol8cYLzs65KI/8iOv/K2fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fsGmzLeR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD85C433C7;
	Mon, 26 Feb 2024 13:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708952502;
	bh=+RGBByuYFhyK92UpvEbeHlmZA3ykbVo83BHYtF6pKvY=;
	h=Subject:To:Cc:From:Date:From;
	b=fsGmzLeRUtJQ2ELXLnb0XLTIga2+HcOgkfrPDe4Bgv2bqZRBEg/vubUuu12/2i9Hb
	 fWLON9XwRp4GXVONGWuiY0dPno89PcVQ6InarfZS+Gef70sSDh68sFI2RpBGsrrwSc
	 X9zkFW2ffEhEsvCQkocZLHJL0+hvukWFr8u0MVy8=
Subject: FAILED: patch "[PATCH] usb: roles: fix NULL pointer issue when put module's" failed to apply to 4.19-stable tree
To: xu.yang_2@nxp.com,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Feb 2024 14:01:32 +0100
Message-ID: <2024022632-wise-dose-46ed@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 1c9be13846c0b2abc2480602f8ef421360e1ad9e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024022632-wise-dose-46ed@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

1c9be13846c0 ("usb: roles: fix NULL pointer issue when put module's reference")
044a61158b9e ("USB: roles: make role_class a static const structure")
1aaba11da9aa ("driver core: class: remove module * from class_create()")
6e30a66433af ("driver core: class: remove struct module owner out of struct class")
0b2a1a3938aa ("driver core: class: Clear private pointer on registration failures")
71a7507afbc3 ("Merge tag 'driver-core-6.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1c9be13846c0b2abc2480602f8ef421360e1ad9e Mon Sep 17 00:00:00 2001
From: Xu Yang <xu.yang_2@nxp.com>
Date: Mon, 29 Jan 2024 17:37:38 +0800
Subject: [PATCH] usb: roles: fix NULL pointer issue when put module's
 reference

In current design, usb role class driver will get usb_role_switch parent's
module reference after the user get usb_role_switch device and put the
reference after the user put the usb_role_switch device. However, the
parent device of usb_role_switch may be removed before the user put the
usb_role_switch. If so, then, NULL pointer issue will be met when the user
put the parent module's reference.

This will save the module pointer in structure of usb_role_switch. Then,
we don't need to find module by iterating long relations.

Fixes: 5c54fcac9a9d ("usb: roles: Take care of driver module reference counting")
cc: stable@vger.kernel.org
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20240129093739.2371530-1-xu.yang_2@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index ae41578bd014..2bad038fb9ad 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -21,6 +21,7 @@ static const struct class role_class = {
 struct usb_role_switch {
 	struct device dev;
 	struct mutex lock; /* device lock*/
+	struct module *module; /* the module this device depends on */
 	enum usb_role role;
 
 	/* From descriptor */
@@ -135,7 +136,7 @@ struct usb_role_switch *usb_role_switch_get(struct device *dev)
 						  usb_role_switch_match);
 
 	if (!IS_ERR_OR_NULL(sw))
-		WARN_ON(!try_module_get(sw->dev.parent->driver->owner));
+		WARN_ON(!try_module_get(sw->module));
 
 	return sw;
 }
@@ -157,7 +158,7 @@ struct usb_role_switch *fwnode_usb_role_switch_get(struct fwnode_handle *fwnode)
 		sw = fwnode_connection_find_match(fwnode, "usb-role-switch",
 						  NULL, usb_role_switch_match);
 	if (!IS_ERR_OR_NULL(sw))
-		WARN_ON(!try_module_get(sw->dev.parent->driver->owner));
+		WARN_ON(!try_module_get(sw->module));
 
 	return sw;
 }
@@ -172,7 +173,7 @@ EXPORT_SYMBOL_GPL(fwnode_usb_role_switch_get);
 void usb_role_switch_put(struct usb_role_switch *sw)
 {
 	if (!IS_ERR_OR_NULL(sw)) {
-		module_put(sw->dev.parent->driver->owner);
+		module_put(sw->module);
 		put_device(&sw->dev);
 	}
 }
@@ -189,15 +190,18 @@ struct usb_role_switch *
 usb_role_switch_find_by_fwnode(const struct fwnode_handle *fwnode)
 {
 	struct device *dev;
+	struct usb_role_switch *sw = NULL;
 
 	if (!fwnode)
 		return NULL;
 
 	dev = class_find_device_by_fwnode(&role_class, fwnode);
-	if (dev)
-		WARN_ON(!try_module_get(dev->parent->driver->owner));
+	if (dev) {
+		sw = to_role_switch(dev);
+		WARN_ON(!try_module_get(sw->module));
+	}
 
-	return dev ? to_role_switch(dev) : NULL;
+	return sw;
 }
 EXPORT_SYMBOL_GPL(usb_role_switch_find_by_fwnode);
 
@@ -338,6 +342,7 @@ usb_role_switch_register(struct device *parent,
 	sw->set = desc->set;
 	sw->get = desc->get;
 
+	sw->module = parent->driver->owner;
 	sw->dev.parent = parent;
 	sw->dev.fwnode = desc->fwnode;
 	sw->dev.class = &role_class;


