Return-Path: <stable+bounces-16113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6672683F073
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54FB1F24477
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A913C1D533;
	Sat, 27 Jan 2024 22:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lp5EjJjX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5021CFB7
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 22:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706393045; cv=none; b=fXlFoi7BrDu3opl0LwmdVjw5hlh7EsdJb/i6FktRDrUaqGsm9FbLdNln2taq/HCHsPgjy7BlBPRxTApd1wsezirQObRDmInrxvgW8zZ99BZqICPeG8V5y1SkADDyI0raRBz78Y9o7P+VMQCJCwIWS0z1tk/Ht+YqZrb6ywEk3N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706393045; c=relaxed/simple;
	bh=4LQ6tSaGXd1ubOk0pKkf/dPrmFgaSjOxP75h/xgKcUI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VwWWfyrPQp2z4apJcgNSlWGv2XzA/c5nxh6rYuxQ63E3ocPS2HfyK2ibNavmvcEnN/BOPr8PwHtmHJDY03Q6O3Z1TbKvDUg5JF0ZnTW5EKLj5hcRdalkpf++dVRl1OKtZ/y8xudXDsF0bzr9huG1lDcMYpebZ6GUGcDdh+aATI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lp5EjJjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5838C433F1;
	Sat, 27 Jan 2024 22:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706393044;
	bh=4LQ6tSaGXd1ubOk0pKkf/dPrmFgaSjOxP75h/xgKcUI=;
	h=Subject:To:Cc:From:Date:From;
	b=Lp5EjJjXvEEZ0eeSH33+3/zKI28+QFCrL+YB3bEhfizGlXCzFQ5lZZg1tO31inNkO
	 0Lj7qgSOELqsde3iqJZ3pQCNfWXqMdAJTrH+oqkyGxnkW5HdonOCK5Ck12bvpa+0mn
	 VYiP/onsyq2/RnxfLdVsHSvFmxqaNYf/33fOrTt8=
Subject: FAILED: patch "[PATCH] platform/x86: intel-uncore-freq: Fix types in sysfs callbacks" failed to apply to 6.1-stable tree
To: nathan@kernel.org,hdegoede@redhat.com,samitolvanen@google.com,srinivas.pandruvada@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 14:04:03 -0800
Message-ID: <2024012703-mosaic-geriatric-232b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 416de0246f35f43d871a57939671fe814f4455ee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012703-mosaic-geriatric-232b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 416de0246f35f43d871a57939671fe814f4455ee Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 4 Jan 2024 15:59:03 -0700
Subject: [PATCH] platform/x86: intel-uncore-freq: Fix types in sysfs callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When booting a kernel with CONFIG_CFI_CLANG, there is a CFI failure when
accessing any of the values under
/sys/devices/system/cpu/intel_uncore_frequency/package_00_die_00:

  $ cat /sys/devices/system/cpu/intel_uncore_frequency/package_00_die_00/max_freq_khz
  fish: Job 1, 'cat /sys/devices/system/cpu/int…' terminated by signal SIGSEGV (Address boundary error)

  $ sudo dmesg &| grep 'CFI failure'
  [  170.953925] CFI failure at kobj_attr_show+0x19/0x30 (target: show_max_freq_khz+0x0/0xc0 [intel_uncore_frequency_common]; expected type: 0xd34078c5

The sysfs callback functions such as show_domain_id() are written as if
they are going to be called by dev_attr_show() but as the above message
shows, they are instead called by kobj_attr_show(). kCFI checks that the
destination of an indirect jump has the exact same type as the prototype
of the function pointer it is called through and fails when they do not.

These callbacks are called through kobj_attr_show() because
uncore_root_kobj was initialized with kobject_create_and_add(), which
means uncore_root_kobj has a ->sysfs_ops of kobj_sysfs_ops from
kobject_create(), which uses kobj_attr_show() as its ->show() value.

The only reason there has not been a more noticeable problem until this
point is that 'struct kobj_attribute' and 'struct device_attribute' have
the same layout, so getting the callback from container_of() works the
same with either value.

Change all the callbacks and their uses to be compatible with
kobj_attr_show() and kobj_attr_store(), which resolves the kCFI failure
and allows the sysfs files to work properly.

Closes: https://github.com/ClangBuiltLinux/linux/issues/1974
Fixes: ae7b2ce57851 ("platform/x86/intel/uncore-freq: Use sysfs API to create attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://lore.kernel.org/r/20240104-intel-uncore-freq-kcfi-fix-v1-1-bf1e8939af40@kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
index 33ab207493e3..33bb58dc3f78 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
@@ -23,23 +23,23 @@ static int (*uncore_read)(struct uncore_data *data, unsigned int *min, unsigned
 static int (*uncore_write)(struct uncore_data *data, unsigned int input, unsigned int min_max);
 static int (*uncore_read_freq)(struct uncore_data *data, unsigned int *freq);
 
-static ssize_t show_domain_id(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_domain_id(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
-	struct uncore_data *data = container_of(attr, struct uncore_data, domain_id_dev_attr);
+	struct uncore_data *data = container_of(attr, struct uncore_data, domain_id_kobj_attr);
 
 	return sprintf(buf, "%u\n", data->domain_id);
 }
 
-static ssize_t show_fabric_cluster_id(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_fabric_cluster_id(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
-	struct uncore_data *data = container_of(attr, struct uncore_data, fabric_cluster_id_dev_attr);
+	struct uncore_data *data = container_of(attr, struct uncore_data, fabric_cluster_id_kobj_attr);
 
 	return sprintf(buf, "%u\n", data->cluster_id);
 }
 
-static ssize_t show_package_id(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_package_id(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
-	struct uncore_data *data = container_of(attr, struct uncore_data, package_id_dev_attr);
+	struct uncore_data *data = container_of(attr, struct uncore_data, package_id_kobj_attr);
 
 	return sprintf(buf, "%u\n", data->package_id);
 }
@@ -97,30 +97,30 @@ static ssize_t show_perf_status_freq_khz(struct uncore_data *data, char *buf)
 }
 
 #define store_uncore_min_max(name, min_max)				\
-	static ssize_t store_##name(struct device *dev,		\
-				     struct device_attribute *attr,	\
+	static ssize_t store_##name(struct kobject *kobj,		\
+				     struct kobj_attribute *attr,	\
 				     const char *buf, size_t count)	\
 	{								\
-		struct uncore_data *data = container_of(attr, struct uncore_data, name##_dev_attr);\
+		struct uncore_data *data = container_of(attr, struct uncore_data, name##_kobj_attr);\
 									\
 		return store_min_max_freq_khz(data, buf, count,	\
 					      min_max);		\
 	}
 
 #define show_uncore_min_max(name, min_max)				\
-	static ssize_t show_##name(struct device *dev,		\
-				    struct device_attribute *attr, char *buf)\
+	static ssize_t show_##name(struct kobject *kobj,		\
+				    struct kobj_attribute *attr, char *buf)\
 	{                                                               \
-		struct uncore_data *data = container_of(attr, struct uncore_data, name##_dev_attr);\
+		struct uncore_data *data = container_of(attr, struct uncore_data, name##_kobj_attr);\
 									\
 		return show_min_max_freq_khz(data, buf, min_max);	\
 	}
 
 #define show_uncore_perf_status(name)					\
-	static ssize_t show_##name(struct device *dev,		\
-				   struct device_attribute *attr, char *buf)\
+	static ssize_t show_##name(struct kobject *kobj,		\
+				   struct kobj_attribute *attr, char *buf)\
 	{                                                               \
-		struct uncore_data *data = container_of(attr, struct uncore_data, name##_dev_attr);\
+		struct uncore_data *data = container_of(attr, struct uncore_data, name##_kobj_attr);\
 									\
 		return show_perf_status_freq_khz(data, buf); \
 	}
@@ -134,11 +134,11 @@ show_uncore_min_max(max_freq_khz, 1);
 show_uncore_perf_status(current_freq_khz);
 
 #define show_uncore_data(member_name)					\
-	static ssize_t show_##member_name(struct device *dev,	\
-					   struct device_attribute *attr, char *buf)\
+	static ssize_t show_##member_name(struct kobject *kobj,	\
+					   struct kobj_attribute *attr, char *buf)\
 	{                                                               \
 		struct uncore_data *data = container_of(attr, struct uncore_data,\
-							  member_name##_dev_attr);\
+							  member_name##_kobj_attr);\
 									\
 		return sysfs_emit(buf, "%u\n",				\
 				 data->member_name);			\
@@ -149,29 +149,29 @@ show_uncore_data(initial_max_freq_khz);
 
 #define init_attribute_rw(_name)					\
 	do {								\
-		sysfs_attr_init(&data->_name##_dev_attr.attr);	\
-		data->_name##_dev_attr.show = show_##_name;		\
-		data->_name##_dev_attr.store = store_##_name;		\
-		data->_name##_dev_attr.attr.name = #_name;		\
-		data->_name##_dev_attr.attr.mode = 0644;		\
+		sysfs_attr_init(&data->_name##_kobj_attr.attr);	\
+		data->_name##_kobj_attr.show = show_##_name;		\
+		data->_name##_kobj_attr.store = store_##_name;		\
+		data->_name##_kobj_attr.attr.name = #_name;		\
+		data->_name##_kobj_attr.attr.mode = 0644;		\
 	} while (0)
 
 #define init_attribute_ro(_name)					\
 	do {								\
-		sysfs_attr_init(&data->_name##_dev_attr.attr);	\
-		data->_name##_dev_attr.show = show_##_name;		\
-		data->_name##_dev_attr.store = NULL;			\
-		data->_name##_dev_attr.attr.name = #_name;		\
-		data->_name##_dev_attr.attr.mode = 0444;		\
+		sysfs_attr_init(&data->_name##_kobj_attr.attr);	\
+		data->_name##_kobj_attr.show = show_##_name;		\
+		data->_name##_kobj_attr.store = NULL;			\
+		data->_name##_kobj_attr.attr.name = #_name;		\
+		data->_name##_kobj_attr.attr.mode = 0444;		\
 	} while (0)
 
 #define init_attribute_root_ro(_name)					\
 	do {								\
-		sysfs_attr_init(&data->_name##_dev_attr.attr);	\
-		data->_name##_dev_attr.show = show_##_name;		\
-		data->_name##_dev_attr.store = NULL;			\
-		data->_name##_dev_attr.attr.name = #_name;		\
-		data->_name##_dev_attr.attr.mode = 0400;		\
+		sysfs_attr_init(&data->_name##_kobj_attr.attr);	\
+		data->_name##_kobj_attr.show = show_##_name;		\
+		data->_name##_kobj_attr.store = NULL;			\
+		data->_name##_kobj_attr.attr.name = #_name;		\
+		data->_name##_kobj_attr.attr.mode = 0400;		\
 	} while (0)
 
 static int create_attr_group(struct uncore_data *data, char *name)
@@ -186,21 +186,21 @@ static int create_attr_group(struct uncore_data *data, char *name)
 
 	if (data->domain_id != UNCORE_DOMAIN_ID_INVALID) {
 		init_attribute_root_ro(domain_id);
-		data->uncore_attrs[index++] = &data->domain_id_dev_attr.attr;
+		data->uncore_attrs[index++] = &data->domain_id_kobj_attr.attr;
 		init_attribute_root_ro(fabric_cluster_id);
-		data->uncore_attrs[index++] = &data->fabric_cluster_id_dev_attr.attr;
+		data->uncore_attrs[index++] = &data->fabric_cluster_id_kobj_attr.attr;
 		init_attribute_root_ro(package_id);
-		data->uncore_attrs[index++] = &data->package_id_dev_attr.attr;
+		data->uncore_attrs[index++] = &data->package_id_kobj_attr.attr;
 	}
 
-	data->uncore_attrs[index++] = &data->max_freq_khz_dev_attr.attr;
-	data->uncore_attrs[index++] = &data->min_freq_khz_dev_attr.attr;
-	data->uncore_attrs[index++] = &data->initial_min_freq_khz_dev_attr.attr;
-	data->uncore_attrs[index++] = &data->initial_max_freq_khz_dev_attr.attr;
+	data->uncore_attrs[index++] = &data->max_freq_khz_kobj_attr.attr;
+	data->uncore_attrs[index++] = &data->min_freq_khz_kobj_attr.attr;
+	data->uncore_attrs[index++] = &data->initial_min_freq_khz_kobj_attr.attr;
+	data->uncore_attrs[index++] = &data->initial_max_freq_khz_kobj_attr.attr;
 
 	ret = uncore_read_freq(data, &freq);
 	if (!ret)
-		data->uncore_attrs[index++] = &data->current_freq_khz_dev_attr.attr;
+		data->uncore_attrs[index++] = &data->current_freq_khz_kobj_attr.attr;
 
 	data->uncore_attrs[index] = NULL;
 
diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h
index 7afb69977c7e..0e5bf507e555 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h
@@ -26,14 +26,14 @@
  * @instance_id:	Unique instance id to append to directory name
  * @name:		Sysfs entry name for this instance
  * @uncore_attr_group:	Attribute group storage
- * @max_freq_khz_dev_attr: Storage for device attribute max_freq_khz
- * @mix_freq_khz_dev_attr: Storage for device attribute min_freq_khz
- * @initial_max_freq_khz_dev_attr: Storage for device attribute initial_max_freq_khz
- * @initial_min_freq_khz_dev_attr: Storage for device attribute initial_min_freq_khz
- * @current_freq_khz_dev_attr: Storage for device attribute current_freq_khz
- * @domain_id_dev_attr: Storage for device attribute domain_id
- * @fabric_cluster_id_dev_attr: Storage for device attribute fabric_cluster_id
- * @package_id_dev_attr: Storage for device attribute package_id
+ * @max_freq_khz_kobj_attr: Storage for kobject attribute max_freq_khz
+ * @mix_freq_khz_kobj_attr: Storage for kobject attribute min_freq_khz
+ * @initial_max_freq_khz_kobj_attr: Storage for kobject attribute initial_max_freq_khz
+ * @initial_min_freq_khz_kobj_attr: Storage for kobject attribute initial_min_freq_khz
+ * @current_freq_khz_kobj_attr: Storage for kobject attribute current_freq_khz
+ * @domain_id_kobj_attr: Storage for kobject attribute domain_id
+ * @fabric_cluster_id_kobj_attr: Storage for kobject attribute fabric_cluster_id
+ * @package_id_kobj_attr: Storage for kobject attribute package_id
  * @uncore_attrs:	Attribute storage for group creation
  *
  * This structure is used to encapsulate all data related to uncore sysfs
@@ -53,14 +53,14 @@ struct uncore_data {
 	char name[32];
 
 	struct attribute_group uncore_attr_group;
-	struct device_attribute max_freq_khz_dev_attr;
-	struct device_attribute min_freq_khz_dev_attr;
-	struct device_attribute initial_max_freq_khz_dev_attr;
-	struct device_attribute initial_min_freq_khz_dev_attr;
-	struct device_attribute current_freq_khz_dev_attr;
-	struct device_attribute domain_id_dev_attr;
-	struct device_attribute fabric_cluster_id_dev_attr;
-	struct device_attribute package_id_dev_attr;
+	struct kobj_attribute max_freq_khz_kobj_attr;
+	struct kobj_attribute min_freq_khz_kobj_attr;
+	struct kobj_attribute initial_max_freq_khz_kobj_attr;
+	struct kobj_attribute initial_min_freq_khz_kobj_attr;
+	struct kobj_attribute current_freq_khz_kobj_attr;
+	struct kobj_attribute domain_id_kobj_attr;
+	struct kobj_attribute fabric_cluster_id_kobj_attr;
+	struct kobj_attribute package_id_kobj_attr;
 	struct attribute *uncore_attrs[9];
 };
 


