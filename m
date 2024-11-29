Return-Path: <stable+bounces-94198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E990E9D3B84
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAFA1281C3C
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 13:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32601DFEF;
	Wed, 20 Nov 2024 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2jdSP+xp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CF11A2C25;
	Wed, 20 Nov 2024 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732107549; cv=none; b=QfX7TUU6CeFf+2rQxC4izen81Zwep1u9IRGU1588M0dMV8AdpAeAZvgJl/1SacfgvEa3TyR+t45Aow22vbUmZfV1lDC/guG/E5RnAaM+UobaQlQK83ar101GSIKq8UFmi+b9TUaHr+KniQvj2LKJLZNxjBlyqC4/0K/TtbxbQhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732107549; c=relaxed/simple;
	bh=h5cQahmjUjw2fbv3KZtAMNKXqeCgejShrgFPb3fUntk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qeLGqQWcDtRVg6M9BoJl746Vf5B4sWh8UTBStyTLbRzzDi9GvKXJvalBFxJCJC9aYmr6aTtSm5JyqJinJB+sjxBgFJudid6+rJ12OO5NCYQgmUK+0suCFS1eUryOGnfvsqHR1Ypu/gHcoSZ82aZlCPL3+HBwVnJgE3LaBxTI+tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2jdSP+xp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD882C4CED6;
	Wed, 20 Nov 2024 12:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732107549;
	bh=h5cQahmjUjw2fbv3KZtAMNKXqeCgejShrgFPb3fUntk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2jdSP+xp80vj1f8PWBdSuT/ewSFnwHKUWtkpaYGkpge7h4zlqTnhIxQhjhK5jUKH0
	 hox5sKxtHY5956FSyhGLeclExNQNsuU7EwuhQb5b13H5hM+2ZSMwYuAPHt4WaGOcqn
	 GwVOj0mCnvtIh7RpXy4wzl8L4KCV3A46AjhflHfc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan+linaro@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 6.11 088/107] pmdomain: core: Add GENPD_FLAG_DEV_NAME_FW flag
Date: Wed, 20 Nov 2024 13:57:03 +0100
Message-ID: <20241120125631.690765107@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120125629.681745345@linuxfoundation.org>
References: <20241120125629.681745345@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sibi Sankar <quic_sibis@quicinc.com>

commit 899f44531fe6cac4b024710fec647ecc127724b8 upstream.

Introduce GENPD_FLAG_DEV_NAME_FW flag which instructs genpd to generate
an unique device name using ida. It is aimed to be used by genpd providers
which derive their names directly from FW making them susceptible to
debugfs node creation failures.

Reported-by: Johan Hovold <johan+linaro@kernel.org>
Closes: https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
Fixes: 718072ceb211 ("PM: domains: create debugfs nodes when adding power domains")
Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
Cc: stable@vger.kernel.org
Message-ID: <20241030125512.2884761-5-quic_sibis@quicinc.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pmdomain/core.c   |   49 +++++++++++++++++++++++++++++++---------------
 include/linux/pm_domain.h |    6 +++++
 2 files changed, 40 insertions(+), 15 deletions(-)

--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -7,6 +7,7 @@
 #define pr_fmt(fmt) "PM: " fmt
 
 #include <linux/delay.h>
+#include <linux/idr.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
@@ -23,6 +24,9 @@
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
 
+/* Provides a unique ID for each genpd device */
+static DEFINE_IDA(genpd_ida);
+
 #define GENPD_RETRY_MAX_MS	250		/* Approximate */
 
 #define GENPD_DEV_CALLBACK(genpd, type, callback, dev)		\
@@ -129,6 +133,7 @@ static const struct genpd_lock_ops genpd
 #define genpd_is_cpu_domain(genpd)	(genpd->flags & GENPD_FLAG_CPU_DOMAIN)
 #define genpd_is_rpm_always_on(genpd)	(genpd->flags & GENPD_FLAG_RPM_ALWAYS_ON)
 #define genpd_is_opp_table_fw(genpd)	(genpd->flags & GENPD_FLAG_OPP_TABLE_FW)
+#define genpd_is_dev_name_fw(genpd)	(genpd->flags & GENPD_FLAG_DEV_NAME_FW)
 
 static inline bool irq_safe_dev_in_sleep_domain(struct device *dev,
 		const struct generic_pm_domain *genpd)
@@ -147,7 +152,7 @@ static inline bool irq_safe_dev_in_sleep
 
 	if (ret)
 		dev_warn_once(dev, "PM domain %s will not be powered off\n",
-				genpd->name);
+			      dev_name(&genpd->dev));
 
 	return ret;
 }
@@ -232,7 +237,7 @@ static void genpd_debug_remove(struct ge
 	if (!genpd_debugfs_dir)
 		return;
 
-	debugfs_lookup_and_remove(genpd->name, genpd_debugfs_dir);
+	debugfs_lookup_and_remove(dev_name(&genpd->dev), genpd_debugfs_dir);
 }
 
 static void genpd_update_accounting(struct generic_pm_domain *genpd)
@@ -689,7 +694,7 @@ static int _genpd_power_on(struct generi
 	genpd->states[state_idx].power_on_latency_ns = elapsed_ns;
 	genpd->gd->max_off_time_changed = true;
 	pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
-		 genpd->name, "on", elapsed_ns);
+		 dev_name(&genpd->dev), "on", elapsed_ns);
 
 out:
 	raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_ON, NULL);
@@ -740,7 +745,7 @@ static int _genpd_power_off(struct gener
 	genpd->states[state_idx].power_off_latency_ns = elapsed_ns;
 	genpd->gd->max_off_time_changed = true;
 	pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
-		 genpd->name, "off", elapsed_ns);
+		 dev_name(&genpd->dev), "off", elapsed_ns);
 
 out:
 	raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_OFF,
@@ -1898,7 +1903,7 @@ int dev_pm_genpd_add_notifier(struct dev
 
 	if (ret) {
 		dev_warn(dev, "failed to add notifier for PM domain %s\n",
-			 genpd->name);
+			 dev_name(&genpd->dev));
 		return ret;
 	}
 
@@ -1945,7 +1950,7 @@ int dev_pm_genpd_remove_notifier(struct
 
 	if (ret) {
 		dev_warn(dev, "failed to remove notifier for PM domain %s\n",
-			 genpd->name);
+			 dev_name(&genpd->dev));
 		return ret;
 	}
 
@@ -1971,7 +1976,7 @@ static int genpd_add_subdomain(struct ge
 	 */
 	if (!genpd_is_irq_safe(genpd) && genpd_is_irq_safe(subdomain)) {
 		WARN(1, "Parent %s of subdomain %s must be IRQ safe\n",
-				genpd->name, subdomain->name);
+		     dev_name(&genpd->dev), subdomain->name);
 		return -EINVAL;
 	}
 
@@ -2046,7 +2051,7 @@ int pm_genpd_remove_subdomain(struct gen
 
 	if (!list_empty(&subdomain->parent_links) || subdomain->device_count) {
 		pr_warn("%s: unable to remove subdomain %s\n",
-			genpd->name, subdomain->name);
+			dev_name(&genpd->dev), subdomain->name);
 		ret = -EBUSY;
 		goto out;
 	}
@@ -2180,6 +2185,7 @@ int pm_genpd_init(struct generic_pm_doma
 	genpd->status = is_off ? GENPD_STATE_OFF : GENPD_STATE_ON;
 	genpd->device_count = 0;
 	genpd->provider = NULL;
+	genpd->device_id = -ENXIO;
 	genpd->has_provider = false;
 	genpd->accounting_time = ktime_get_mono_fast_ns();
 	genpd->domain.ops.runtime_suspend = genpd_runtime_suspend;
@@ -2220,7 +2226,18 @@ int pm_genpd_init(struct generic_pm_doma
 		return ret;
 
 	device_initialize(&genpd->dev);
-	dev_set_name(&genpd->dev, "%s", genpd->name);
+
+	if (!genpd_is_dev_name_fw(genpd)) {
+		dev_set_name(&genpd->dev, "%s", genpd->name);
+	} else {
+		ret = ida_alloc(&genpd_ida, GFP_KERNEL);
+		if (ret < 0) {
+			put_device(&genpd->dev);
+			return ret;
+		}
+		genpd->device_id = ret;
+		dev_set_name(&genpd->dev, "%s_%u", genpd->name, genpd->device_id);
+	}
 
 	mutex_lock(&gpd_list_lock);
 	list_add(&genpd->gpd_list_node, &gpd_list);
@@ -2242,13 +2259,13 @@ static int genpd_remove(struct generic_p
 
 	if (genpd->has_provider) {
 		genpd_unlock(genpd);
-		pr_err("Provider present, unable to remove %s\n", genpd->name);
+		pr_err("Provider present, unable to remove %s\n", dev_name(&genpd->dev));
 		return -EBUSY;
 	}
 
 	if (!list_empty(&genpd->parent_links) || genpd->device_count) {
 		genpd_unlock(genpd);
-		pr_err("%s: unable to remove %s\n", __func__, genpd->name);
+		pr_err("%s: unable to remove %s\n", __func__, dev_name(&genpd->dev));
 		return -EBUSY;
 	}
 
@@ -2262,9 +2279,11 @@ static int genpd_remove(struct generic_p
 	genpd_unlock(genpd);
 	genpd_debug_remove(genpd);
 	cancel_work_sync(&genpd->power_off_work);
+	if (genpd->device_id != -ENXIO)
+		ida_free(&genpd_ida, genpd->device_id);
 	genpd_free_data(genpd);
 
-	pr_debug("%s: removed %s\n", __func__, genpd->name);
+	pr_debug("%s: removed %s\n", __func__, dev_name(&genpd->dev));
 
 	return 0;
 }
@@ -3226,12 +3245,12 @@ static int genpd_summary_one(struct seq_
 	else
 		snprintf(state, sizeof(state), "%s",
 			 status_lookup[genpd->status]);
-	seq_printf(s, "%-30s  %-30s  %u", genpd->name, state, genpd->performance_state);
+	seq_printf(s, "%-30s  %-30s  %u", dev_name(&genpd->dev), state, genpd->performance_state);
 
 	/*
 	 * Modifications on the list require holding locks on both
 	 * parent and child, so we are safe.
-	 * Also genpd->name is immutable.
+	 * Also the device name is immutable.
 	 */
 	list_for_each_entry(link, &genpd->parent_links, parent_node) {
 		if (list_is_first(&link->parent_node, &genpd->parent_links))
@@ -3456,7 +3475,7 @@ static void genpd_debug_add(struct gener
 	if (!genpd_debugfs_dir)
 		return;
 
-	d = debugfs_create_dir(genpd->name, genpd_debugfs_dir);
+	d = debugfs_create_dir(dev_name(&genpd->dev), genpd_debugfs_dir);
 
 	debugfs_create_file("current_state", 0444,
 			    d, genpd, &status_fops);
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -92,6 +92,10 @@ struct dev_pm_domain_list {
  * GENPD_FLAG_OPP_TABLE_FW:	The genpd provider supports performance states,
  *				but its corresponding OPP tables are not
  *				described in DT, but are given directly by FW.
+ *
+ * GENPD_FLAG_DEV_NAME_FW:	Instructs genpd to generate an unique device name
+ *				using ida. It is used by genpd providers which
+ *				get their genpd-names directly from FW.
  */
 #define GENPD_FLAG_PM_CLK	 (1U << 0)
 #define GENPD_FLAG_IRQ_SAFE	 (1U << 1)
@@ -101,6 +105,7 @@ struct dev_pm_domain_list {
 #define GENPD_FLAG_RPM_ALWAYS_ON (1U << 5)
 #define GENPD_FLAG_MIN_RESIDENCY (1U << 6)
 #define GENPD_FLAG_OPP_TABLE_FW	 (1U << 7)
+#define GENPD_FLAG_DEV_NAME_FW	 (1U << 8)
 
 enum gpd_status {
 	GENPD_STATE_ON = 0,	/* PM domain is on */
@@ -163,6 +168,7 @@ struct generic_pm_domain {
 	atomic_t sd_count;	/* Number of subdomains with power "on" */
 	enum gpd_status status;	/* Current state of the domain */
 	unsigned int device_count;	/* Number of devices */
+	unsigned int device_id;		/* unique device id */
 	unsigned int suspended_count;	/* System suspend device counter */
 	unsigned int prepared_count;	/* Suspend counter of prepared devices */
 	unsigned int performance_state;	/* Aggregated max performance state */



