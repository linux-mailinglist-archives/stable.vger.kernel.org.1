Return-Path: <stable+bounces-106703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4C5A00ADF
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 15:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FB61163AE9
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 14:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8605C1B415D;
	Fri,  3 Jan 2025 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QYU96N2i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4515F2941C
	for <stable@vger.kernel.org>; Fri,  3 Jan 2025 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735915818; cv=none; b=AhuiGCauU4HY5mfhakH+3TjxBrg6m78b+0YcF4Lg7zr8sqaltF8fg8Ahoma0PLBlM9Fh+gBTFOLVlwwReC8YHrCdICRAvNcR28sTosoRY28gQGwjIYImTJWPfIxosHU5l3rEFWGNb3dR6U5bAMkjdnHcRBfJ0t3Zv2FbdrQKN68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735915818; c=relaxed/simple;
	bh=LVSfTJ1FmTV1b0RRseGszFk9WFDxQzWebnDdIpouPEA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S3xnyyTLWyIRDkNpcq76CeL/4TWDGF+6nYNJ4ugwdUB4Htmv6ljSEzw59x6+4UhCHVea0MmqUGTyeVU1NOmOzSd0iPJSGwgKfU6UuYcvA364WuHGZC6L+a81O/Hn6sCQTWmEEbqDnH3zysXWi4tkjurdLjvqaHFj29JB3A/Jn1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QYU96N2i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFECEC4CECE;
	Fri,  3 Jan 2025 14:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735915818;
	bh=LVSfTJ1FmTV1b0RRseGszFk9WFDxQzWebnDdIpouPEA=;
	h=Subject:To:Cc:From:Date:From;
	b=QYU96N2iu2nPvrLgV8osTwat7OX5VZ3xSgJw8S2uff/MLdwgHYc3ZorjObsuU8gp1
	 58Fr2IqjZoNJlCZta2QPGv59G7ypLkU5Rz2jVFB9+mgO6sQqdTMTsRbv4s+bL1E3Gz
	 LBILnM2VHSAlPk1ap2dkbSqTSYJ6Tj4RSTccmFVg=
Subject: FAILED: patch "[PATCH] pmdomain: core: add dummy release function to genpd device" failed to apply to 6.1-stable tree
To: l.stach@pengutronix.de,luca.ceresoli@bootlin.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 03 Jan 2025 15:50:07 +0100
Message-ID: <2025010307-papaya-expenses-89a5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f64f610ec6ab59dd0391b03842cea3a4cd8ee34f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025010307-papaya-expenses-89a5@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f64f610ec6ab59dd0391b03842cea3a4cd8ee34f Mon Sep 17 00:00:00 2001
From: Lucas Stach <l.stach@pengutronix.de>
Date: Wed, 18 Dec 2024 19:44:33 +0100
Subject: [PATCH] pmdomain: core: add dummy release function to genpd device

The genpd device, which is really only used as a handle to lookup
OPP, but not even registered to the device core otherwise and thus
lifetime linked to the genpd struct it is contained in, is missing
a release function. After b8f7bbd1f4ec ("pmdomain: core: Add
missing put_device()") the device will be cleaned up going through
the driver core device_release() function, which will warn when no
release callback is present for the device. Add a dummy release
function to shut up the warning.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Fixes: b8f7bbd1f4ec ("pmdomain: core: Add missing put_device()")
Cc: stable@vger.kernel.org
Message-ID: <20241218184433.1930532-1-l.stach@pengutronix.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index bb11f467dc78..20a9efebbcb7 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2142,6 +2142,11 @@ static int genpd_set_default_power_state(struct generic_pm_domain *genpd)
 	return 0;
 }
 
+static void genpd_provider_release(struct device *dev)
+{
+	/* nothing to be done here */
+}
+
 static int genpd_alloc_data(struct generic_pm_domain *genpd)
 {
 	struct genpd_governor_data *gd = NULL;
@@ -2173,6 +2178,7 @@ static int genpd_alloc_data(struct generic_pm_domain *genpd)
 
 	genpd->gd = gd;
 	device_initialize(&genpd->dev);
+	genpd->dev.release = genpd_provider_release;
 
 	if (!genpd_is_dev_name_fw(genpd)) {
 		dev_set_name(&genpd->dev, "%s", genpd->name);


