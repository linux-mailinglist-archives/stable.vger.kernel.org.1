Return-Path: <stable+bounces-32978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C6688E895
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 16:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D49295849
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 15:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A05C3A297;
	Wed, 27 Mar 2024 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LJaUkYKG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7645672
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552093; cv=none; b=SXkvOfTy3xd/THZsaZqIoix+RyADGPCBEljSQplqfCK8RvrWqlSo61fgbZkmKJgIAWLAh7BOaxLeyE/uy2ZH+gbJ+JyDSjP4k0Ad1sCXWs0wx1zLAboKRTPukGp9T+oj1Bs3rOMfcTNtUL3rNwI29eHCsfWw8IbnpH56VwqdHqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552093; c=relaxed/simple;
	bh=Bb/1KeIEEx9dIuE5m/tl9NTV1VtTjCmupyY94PZUjW0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Yj31JO1Ce4dTUiNx9sXqUwc/+dOhpU2yByV6iQSQQMKe0qmQ8MmrlAGu8s2ZmTnrtkFAc7PRK0PGtFrq9zGjPgDnKTC+9XvmcLcqEa5qFWmE/H1KqU7LLESibOARaWd7ZBUN5DLBGpvIoMhX2j630lbQt2vKU+ECix3p7se+/8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LJaUkYKG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27175C433F1;
	Wed, 27 Mar 2024 15:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711552092;
	bh=Bb/1KeIEEx9dIuE5m/tl9NTV1VtTjCmupyY94PZUjW0=;
	h=Subject:To:Cc:From:Date:From;
	b=LJaUkYKGOrDQmMbKU/HWjdSpgj0LJWrNurkhLujyDsZmTSC3JPLXvGWI/Lzq4E0BL
	 ig8JEQTg5vzsT+0MlIWTulW2TrgxrgXpbbCj7RuIRNN3ZcD0qt8fOLR9RLhkvLEYk3
	 WgcbO0eeaGLS/z5TyVI4kBWYC9/XA1tjHQV/hrX0=
Subject: FAILED: patch "[PATCH] usb: typec: altmodes/displayport: create sysfs nodes as" failed to apply to 5.10-stable tree
To: rdbabiera@google.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 27 Mar 2024 16:08:00 +0100
Message-ID: <2024032700-hardship-clubhouse-8ed7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 165376f6b23e9a779850e750fb2eb06622e5a531
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024032700-hardship-clubhouse-8ed7@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

165376f6b23e ("usb: typec: altmodes/displayport: create sysfs nodes as driver's default device attribute group")
001b0c780eac ("usb: typec: altmodes/displayport: Add hpd sysfs attribute")
7f8113948785 ("usb: typec: altmodes/displayport: Notify drm subsys of hotplug events")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 165376f6b23e9a779850e750fb2eb06622e5a531 Mon Sep 17 00:00:00 2001
From: RD Babiera <rdbabiera@google.com>
Date: Thu, 29 Feb 2024 00:11:02 +0000
Subject: [PATCH] usb: typec: altmodes/displayport: create sysfs nodes as
 driver's default device attribute group

The DisplayPort driver's sysfs nodes may be present to the userspace before
typec_altmode_set_drvdata() completes in dp_altmode_probe. This means that
a sysfs read can trigger a NULL pointer error by deferencing dp->hpd in
hpd_show or dp->lock in pin_assignment_show, as dev_get_drvdata() returns
NULL in those cases.

Remove manual sysfs node creation in favor of adding attribute group as
default for devices bound to the driver. The ATTRIBUTE_GROUPS() macro is
not used here otherwise the path to the sysfs nodes is no longer compliant
with the ABI.

Fixes: 0e3bb7d6894d ("usb: typec: Add driver for DisplayPort alternate mode")
Cc: stable@vger.kernel.org
Signed-off-by: RD Babiera <rdbabiera@google.com>
Link: https://lore.kernel.org/r/20240229001101.3889432-2-rdbabiera@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index f81bec0c7b86..f8ea3054be54 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -559,16 +559,21 @@ static ssize_t hpd_show(struct device *dev, struct device_attribute *attr, char
 }
 static DEVICE_ATTR_RO(hpd);
 
-static struct attribute *dp_altmode_attrs[] = {
+static struct attribute *displayport_attrs[] = {
 	&dev_attr_configuration.attr,
 	&dev_attr_pin_assignment.attr,
 	&dev_attr_hpd.attr,
 	NULL
 };
 
-static const struct attribute_group dp_altmode_group = {
+static const struct attribute_group displayport_group = {
 	.name = "displayport",
-	.attrs = dp_altmode_attrs,
+	.attrs = displayport_attrs,
+};
+
+static const struct attribute_group *displayport_groups[] = {
+	&displayport_group,
+	NULL,
 };
 
 int dp_altmode_probe(struct typec_altmode *alt)
@@ -576,7 +581,6 @@ int dp_altmode_probe(struct typec_altmode *alt)
 	const struct typec_altmode *port = typec_altmode_get_partner(alt);
 	struct fwnode_handle *fwnode;
 	struct dp_altmode *dp;
-	int ret;
 
 	/* FIXME: Port can only be DFP_U. */
 
@@ -587,10 +591,6 @@ int dp_altmode_probe(struct typec_altmode *alt)
 	      DP_CAP_PIN_ASSIGN_DFP_D(alt->vdo)))
 		return -ENODEV;
 
-	ret = sysfs_create_group(&alt->dev.kobj, &dp_altmode_group);
-	if (ret)
-		return ret;
-
 	dp = devm_kzalloc(&alt->dev, sizeof(*dp), GFP_KERNEL);
 	if (!dp)
 		return -ENOMEM;
@@ -624,7 +624,6 @@ void dp_altmode_remove(struct typec_altmode *alt)
 {
 	struct dp_altmode *dp = typec_altmode_get_drvdata(alt);
 
-	sysfs_remove_group(&alt->dev.kobj, &dp_altmode_group);
 	cancel_work_sync(&dp->work);
 
 	if (dp->connector_fwnode) {
@@ -649,6 +648,7 @@ static struct typec_altmode_driver dp_altmode_driver = {
 	.driver = {
 		.name = "typec_displayport",
 		.owner = THIS_MODULE,
+		.dev_groups = displayport_groups,
 	},
 };
 module_typec_altmode_driver(dp_altmode_driver);


