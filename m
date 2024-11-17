Return-Path: <stable+bounces-93731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F819D060E
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 22:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 917E6B220CA
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 21:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641C41DBB32;
	Sun, 17 Nov 2024 21:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sa/rzM8F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248C91DB956
	for <stable@vger.kernel.org>; Sun, 17 Nov 2024 21:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731877677; cv=none; b=DOf0PziWaW8Kk64xxv9FSmFcIHFAdkERjK2IKw6eZgnggsRzs9POIOyUe/IiN51SV9n4FSLTqSj8ZjnPHp2/Mm3IJYBWNyFdjB3+lXxdZQJaBALSkLzbcMUwjvQ8IVj6p/sPLvjIr1WbO4Owecc7sSHs+zQhsWEX6Y5Fos7BQao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731877677; c=relaxed/simple;
	bh=Vru7imjlyK7k7DIscMyIj10+MfV3swx22O1zqqdvOIg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KnnyNhiwmIE7nHwpThyqxXamlGeJoaxHXeglm9PLQ3rIrJt/uEymslkEVL9Y+WhpEXlgZDBBS/mtDCknyDDtJ8TYtVvZvBWNejyH/23OBjUvADy3sdSb/WJ7K8dZZGiLU8Cr17i2YJ167K17/VDVjexee//Hg7eCAGEPObBVwC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sa/rzM8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD07C4CECD;
	Sun, 17 Nov 2024 21:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731877676;
	bh=Vru7imjlyK7k7DIscMyIj10+MfV3swx22O1zqqdvOIg=;
	h=Subject:To:Cc:From:Date:From;
	b=Sa/rzM8FjXWhd26dmjVeH1VRNuVkP+2dRrGDVMQtD8SWIszb91v71sBJnyT4QpKnW
	 orp0v1SqxC45ouOUtmt21RZhVCjpV9gIgSV11d6oBukS8v1OHw7k9KZSZnHoi2GG1r
	 WFJuVnKQJd1D/MEtHCtwNFz0J7C5CT2rczXzEs6M=
Subject: FAILED: patch "[PATCH] pmdomain: core: Add GENPD_FLAG_DEV_NAME_FW flag" failed to apply to 6.6-stable tree
To: quic_sibis@quicinc.com,dmitry.baryshkov@linaro.org,johan+linaro@kernel.org,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 17 Nov 2024 22:07:32 +0100
Message-ID: <2024111731-overheat-eraser-3483@gregkh>
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
git cherry-pick -x 899f44531fe6cac4b024710fec647ecc127724b8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111731-overheat-eraser-3483@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 899f44531fe6cac4b024710fec647ecc127724b8 Mon Sep 17 00:00:00 2001
From: Sibi Sankar <quic_sibis@quicinc.com>
Date: Wed, 30 Oct 2024 18:25:10 +0530
Subject: [PATCH] pmdomain: core: Add GENPD_FLAG_DEV_NAME_FW flag

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

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 5ede0f7eda09..29ad510e881c 100644
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
@@ -171,6 +175,7 @@ static const struct genpd_lock_ops genpd_raw_spin_ops = {
 #define genpd_is_cpu_domain(genpd)	(genpd->flags & GENPD_FLAG_CPU_DOMAIN)
 #define genpd_is_rpm_always_on(genpd)	(genpd->flags & GENPD_FLAG_RPM_ALWAYS_ON)
 #define genpd_is_opp_table_fw(genpd)	(genpd->flags & GENPD_FLAG_OPP_TABLE_FW)
+#define genpd_is_dev_name_fw(genpd)	(genpd->flags & GENPD_FLAG_DEV_NAME_FW)
 
 static inline bool irq_safe_dev_in_sleep_domain(struct device *dev,
 		const struct generic_pm_domain *genpd)
@@ -189,7 +194,7 @@ static inline bool irq_safe_dev_in_sleep_domain(struct device *dev,
 
 	if (ret)
 		dev_warn_once(dev, "PM domain %s will not be powered off\n",
-				genpd->name);
+			      dev_name(&genpd->dev));
 
 	return ret;
 }
@@ -274,7 +279,7 @@ static void genpd_debug_remove(struct generic_pm_domain *genpd)
 	if (!genpd_debugfs_dir)
 		return;
 
-	debugfs_lookup_and_remove(genpd->name, genpd_debugfs_dir);
+	debugfs_lookup_and_remove(dev_name(&genpd->dev), genpd_debugfs_dir);
 }
 
 static void genpd_update_accounting(struct generic_pm_domain *genpd)
@@ -731,7 +736,7 @@ static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 	genpd->states[state_idx].power_on_latency_ns = elapsed_ns;
 	genpd->gd->max_off_time_changed = true;
 	pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
-		 genpd->name, "on", elapsed_ns);
+		 dev_name(&genpd->dev), "on", elapsed_ns);
 
 out:
 	raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_ON, NULL);
@@ -782,7 +787,7 @@ static int _genpd_power_off(struct generic_pm_domain *genpd, bool timed)
 	genpd->states[state_idx].power_off_latency_ns = elapsed_ns;
 	genpd->gd->max_off_time_changed = true;
 	pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
-		 genpd->name, "off", elapsed_ns);
+		 dev_name(&genpd->dev), "off", elapsed_ns);
 
 out:
 	raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_OFF,
@@ -1940,7 +1945,7 @@ int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb)
 
 	if (ret) {
 		dev_warn(dev, "failed to add notifier for PM domain %s\n",
-			 genpd->name);
+			 dev_name(&genpd->dev));
 		return ret;
 	}
 
@@ -1987,7 +1992,7 @@ int dev_pm_genpd_remove_notifier(struct device *dev)
 
 	if (ret) {
 		dev_warn(dev, "failed to remove notifier for PM domain %s\n",
-			 genpd->name);
+			 dev_name(&genpd->dev));
 		return ret;
 	}
 
@@ -2013,7 +2018,7 @@ static int genpd_add_subdomain(struct generic_pm_domain *genpd,
 	 */
 	if (!genpd_is_irq_safe(genpd) && genpd_is_irq_safe(subdomain)) {
 		WARN(1, "Parent %s of subdomain %s must be IRQ safe\n",
-				genpd->name, subdomain->name);
+		     dev_name(&genpd->dev), subdomain->name);
 		return -EINVAL;
 	}
 
@@ -2088,7 +2093,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 
 	if (!list_empty(&subdomain->parent_links) || subdomain->device_count) {
 		pr_warn("%s: unable to remove subdomain %s\n",
-			genpd->name, subdomain->name);
+			dev_name(&genpd->dev), subdomain->name);
 		ret = -EBUSY;
 		goto out;
 	}
@@ -2225,6 +2230,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->status = is_off ? GENPD_STATE_OFF : GENPD_STATE_ON;
 	genpd->device_count = 0;
 	genpd->provider = NULL;
+	genpd->device_id = -ENXIO;
 	genpd->has_provider = false;
 	genpd->accounting_time = ktime_get_mono_fast_ns();
 	genpd->domain.ops.runtime_suspend = genpd_runtime_suspend;
@@ -2265,7 +2271,18 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
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
@@ -2287,13 +2304,13 @@ static int genpd_remove(struct generic_pm_domain *genpd)
 
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
 
@@ -2307,9 +2324,11 @@ static int genpd_remove(struct generic_pm_domain *genpd)
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
@@ -3272,12 +3291,12 @@ static int genpd_summary_one(struct seq_file *s,
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
@@ -3502,7 +3521,7 @@ static void genpd_debug_add(struct generic_pm_domain *genpd)
 	if (!genpd_debugfs_dir)
 		return;
 
-	d = debugfs_create_dir(genpd->name, genpd_debugfs_dir);
+	d = debugfs_create_dir(dev_name(&genpd->dev), genpd_debugfs_dir);
 
 	debugfs_create_file("current_state", 0444,
 			    d, genpd, &status_fops);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index b637ec14025f..cf4b11be3709 100644
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


