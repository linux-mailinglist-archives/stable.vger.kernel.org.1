Return-Path: <stable+bounces-106702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7C2A00ADE
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 15:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3004188195A
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 14:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED961F9A81;
	Fri,  3 Jan 2025 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e56W0IeE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE6D1F8EEB
	for <stable@vger.kernel.org>; Fri,  3 Jan 2025 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735915809; cv=none; b=n2MMga9NThSJPkMwuWC8G1+MSOURl+5/DL9hqElJL9rlRLdFvG7LY8udeVyNkygU5oA8bBkEKTb1p/eakTQu9E37Xw28GUnMCCqSpvXws/6D6c5kMiOvCtuPJ9LC9NM6sclMUwo9OjutuJ8uUa8yfrrSgsPs5JO4NT6R5hwyOBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735915809; c=relaxed/simple;
	bh=hhZKHdqmR6Ik2yBDI7U800lNWHtLSXL2BA+OUXqmUYA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FjasLLr3G2NIxscVyNghNcB0r05tHMNJLwR1p27Gd9Py/EY//BG/9OS9aAQ+FT/JhKNi+64+j1LACA0W+tCC2sbxz96KzKEE9gcBo4bPRReqOlz/f1XGCRoREqT9YqXJ/+uWXfDpxZNXDpTzPO1KshyKHfgpT5StkxicJgLI38M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e56W0IeE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1895DC4CED6;
	Fri,  3 Jan 2025 14:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735915809;
	bh=hhZKHdqmR6Ik2yBDI7U800lNWHtLSXL2BA+OUXqmUYA=;
	h=Subject:To:Cc:From:Date:From;
	b=e56W0IeEJIrbSHptk5RlbIB1LIoPMq9KNjmqhSib8oTrLU4KNqnjl67BHqEvIqak8
	 1FST/BzKF2UCmhFSFTlH4/l/FbGSwXICbZgBtxqJYLl6zhs13dB+63Z2dFk/bUUHTQ
	 NNatl9CKkhs0IgN5sDR0ft13dzQTNlYxBjNBfccQ=
Subject: FAILED: patch "[PATCH] pmdomain: core: add dummy release function to genpd device" failed to apply to 6.6-stable tree
To: l.stach@pengutronix.de,luca.ceresoli@bootlin.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 03 Jan 2025 15:50:06 +0100
Message-ID: <2025010306-chooser-varmint-6746@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f64f610ec6ab59dd0391b03842cea3a4cd8ee34f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025010306-chooser-varmint-6746@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


