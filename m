Return-Path: <stable+bounces-74425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C695E972F3D
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BE2D1F240B3
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEB518C00D;
	Tue, 10 Sep 2024 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UzkrbBeF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B8918B487;
	Tue, 10 Sep 2024 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961767; cv=none; b=qNu9kzD0I5T2gNKMOFHAKpwbX8lkX31XXgx6qNBQ7Tikw4CGLRT+eSh+wRDQLC0yCivYrCnJ1Bowr78B5Gyl2KgNEsUO42Z7TNQ2gTygffvND+8AtALvE6gLtaNKR/qbMEwDkj7Nwseb6M/DvJcxQEZcyd7O0M9HquKgV/ll1uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961767; c=relaxed/simple;
	bh=ev+lkVt+LjHjMRGivQgTQ/8Bx4ZKzYiXwKKn1JtBefM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XY+LaVGyH2N8ikr050DuyJeMxpAih6f61nkFSBJ9r0LSdsZDeve5fb4p6hCrnXxtMujpMCU/uUjzlTq8XpG3gTUmSm6l3f1hq7KRi2u6XAG2KUpQ7Sinw4z0uPKyc7AwyfzCexcfH+epAyZB3o8iqkvX1W5mKUE7O/QvOzC+MmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UzkrbBeF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0066C4CEC3;
	Tue, 10 Sep 2024 09:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961767;
	bh=ev+lkVt+LjHjMRGivQgTQ/8Bx4ZKzYiXwKKn1JtBefM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UzkrbBeF1ecfJYYq3bFwNJRb9VyXJ9F41tJVum+zSJkuhNZKqNwkLH1uKzYz0BDOZ
	 F5BnleaHJD925e9L0GtrHjUwC8yS6kaapi2Y+aQLAxXh8BAFG+a8FxVY+GmBMHl1bD
	 lzoqGHZDAU0egLC14TOGL5NYLltmDGhSedKEGJMk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vadim Fedorenko <vadfed@meta.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 181/375] ptp: ocp: adjust sysfs entries to expose tty information
Date: Tue, 10 Sep 2024 11:29:38 +0200
Message-ID: <20240910092628.566321901@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vadim Fedorenko <vadfed@meta.com>

[ Upstream commit 82ace0c8fe9b025eaa273365e27057402cdaeb02 ]

Implement additional attribute group to expose serial port information.
Fixes tag points to the commit which introduced the change in serial
port subsystem and made it impossible to use symlinks.

Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be children of serial core port device")
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ptp/ptp_ocp.c | 62 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 51 insertions(+), 11 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 46369de8e30b..e7479b9b90cb 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -3361,6 +3361,54 @@ static EXT_ATTR_RO(freq, frequency, 1);
 static EXT_ATTR_RO(freq, frequency, 2);
 static EXT_ATTR_RO(freq, frequency, 3);
 
+static ssize_t
+ptp_ocp_tty_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct dev_ext_attribute *ea = to_ext_attr(attr);
+	struct ptp_ocp *bp = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "ttyS%d", bp->port[(uintptr_t)ea->var].line);
+}
+
+static umode_t
+ptp_ocp_timecard_tty_is_visible(struct kobject *kobj, struct attribute *attr, int n)
+{
+	struct ptp_ocp *bp = dev_get_drvdata(kobj_to_dev(kobj));
+	struct ptp_ocp_serial_port *port;
+	struct device_attribute *dattr;
+	struct dev_ext_attribute *ea;
+
+	if (strncmp(attr->name, "tty", 3))
+		return attr->mode;
+
+	dattr = container_of(attr, struct device_attribute, attr);
+	ea = container_of(dattr, struct dev_ext_attribute, attr);
+	port = &bp->port[(uintptr_t)ea->var];
+	return port->line == -1 ? 0 : 0444;
+}
+
+#define EXT_TTY_ATTR_RO(_name, _val)			\
+	struct dev_ext_attribute dev_attr_tty##_name =	\
+		{ __ATTR(tty##_name, 0444, ptp_ocp_tty_show, NULL), (void *)_val }
+
+static EXT_TTY_ATTR_RO(GNSS, PORT_GNSS);
+static EXT_TTY_ATTR_RO(GNSS2, PORT_GNSS2);
+static EXT_TTY_ATTR_RO(MAC, PORT_MAC);
+static EXT_TTY_ATTR_RO(NMEA, PORT_NMEA);
+static struct attribute *ptp_ocp_timecard_tty_attrs[] = {
+	&dev_attr_ttyGNSS.attr.attr,
+	&dev_attr_ttyGNSS2.attr.attr,
+	&dev_attr_ttyMAC.attr.attr,
+	&dev_attr_ttyNMEA.attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ptp_ocp_timecard_tty_group = {
+	.name = "tty",
+	.attrs = ptp_ocp_timecard_tty_attrs,
+	.is_visible = ptp_ocp_timecard_tty_is_visible,
+};
+
 static ssize_t
 serialnum_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -3790,6 +3838,7 @@ static const struct attribute_group fb_timecard_group = {
 
 static const struct ocp_attr_group fb_timecard_groups[] = {
 	{ .cap = OCP_CAP_BASIC,	    .group = &fb_timecard_group },
+	{ .cap = OCP_CAP_BASIC,	    .group = &ptp_ocp_timecard_tty_group },
 	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal0_group },
 	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal1_group },
 	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal2_group },
@@ -3829,6 +3878,7 @@ static const struct attribute_group art_timecard_group = {
 
 static const struct ocp_attr_group art_timecard_groups[] = {
 	{ .cap = OCP_CAP_BASIC,	    .group = &art_timecard_group },
+	{ .cap = OCP_CAP_BASIC,	    .group = &ptp_ocp_timecard_tty_group },
 	{ },
 };
 
@@ -3856,6 +3906,7 @@ static const struct attribute_group adva_timecard_group = {
 
 static const struct ocp_attr_group adva_timecard_groups[] = {
 	{ .cap = OCP_CAP_BASIC,	    .group = &adva_timecard_group },
+	{ .cap = OCP_CAP_BASIC,	    .group = &ptp_ocp_timecard_tty_group },
 	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal0_group },
 	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal1_group },
 	{ .cap = OCP_CAP_FREQ,	    .group = &fb_timecard_freq0_group },
@@ -4361,14 +4412,6 @@ ptp_ocp_complete(struct ptp_ocp *bp)
 {
 	struct pps_device *pps;
 	char buf[32];
-	int i;
-
-	for (i = 0; i < __PORT_COUNT; i++) {
-		if (bp->port[i].line != -1) {
-			sprintf(buf, "ttyS%d", bp->port[i].line);
-			ptp_ocp_link_child(bp, buf, ptp_ocp_tty_port_name(i));
-		}
-	}
 
 	sprintf(buf, "ptp%d", ptp_clock_index(bp->ptp));
 	ptp_ocp_link_child(bp, buf, "ptp");
@@ -4440,9 +4483,6 @@ ptp_ocp_detach_sysfs(struct ptp_ocp *bp)
 {
 	struct device *dev = &bp->dev;
 
-	sysfs_remove_link(&dev->kobj, "ttyGNSS");
-	sysfs_remove_link(&dev->kobj, "ttyGNSS2");
-	sysfs_remove_link(&dev->kobj, "ttyMAC");
 	sysfs_remove_link(&dev->kobj, "ptp");
 	sysfs_remove_link(&dev->kobj, "pps");
 }
-- 
2.43.0




