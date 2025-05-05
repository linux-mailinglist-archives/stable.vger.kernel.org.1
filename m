Return-Path: <stable+bounces-140300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C061AAA744
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 579AC4A32BD
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D4127FB28;
	Mon,  5 May 2025 22:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6dF6FDh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3475C27FB1C;
	Mon,  5 May 2025 22:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484593; cv=none; b=VLIDgKqmrQPi/URihS9rmpUGmdTQ99VVaQo+ex77eQ2jUb5qD3x5Hu4MR239pRr4bzWK5MdjpS12EcNwWBLZtu7gBCs5Q+8XU8K4FIuOKs8DQFieIIb9uBGEP6wsohSZscYSv1kR92VuTcrLAYpey7lYDWn/+ls3FgDI8momMrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484593; c=relaxed/simple;
	bh=gBL44RYb/J6w7hGEKdPGMz8aL1hsFJmrypsznpqFECE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VqrWklbOVhuIURzpxEM9SIOFLPWo94V60yJ1tLwLQ4WIumiVA9sqLRj9AQBPtF+aGfY5jLPtoEiOB/R2QX3m07fDBuQSVbvFIIdyOr0BPrmYXixgLP8CM1PPK8PBL4XqjFSg2rurUOZ2Tf3fNURDmNySmeikazJjTI10fK+dgdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6dF6FDh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6F8C4CEE4;
	Mon,  5 May 2025 22:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484593;
	bh=gBL44RYb/J6w7hGEKdPGMz8aL1hsFJmrypsznpqFECE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t6dF6FDh4a9vwxRa/oUpZZerCO+i+6NRC3dwzmf7Cc87A9xQoYcr/mavsKP+NsSDf
	 ludZLb5P2/hpF1Yh7ja3ZTqa6R31g4naowwjlGyZgTrg0E8AOXZ0Ob8HXbBYeFpKlq
	 WvmAvKgj/HgNf8rB0NCJZLBEZYzsGHLSxFGzU5cO2gbFx0CHz7FTDiVjFex+v5mCVK
	 r6XAiNogy8nYBFcmfF5hX9kYJ8hTNsS2lPa0TmTiGVgD4btS70kE+6qV+ehuRyYKXY
	 o6ajyu6vWZYA3/3IAwpdhQVKLXJvW1ky3Etm4Bxrev9drEr8JmZwL+MVh09ryAs+vl
	 nPnk6YS2MiGag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Antoine Tenart <atenart@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	sdf@fomichev.me,
	jdamato@fastly.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 552/642] net-sysfs: remove rtnl_trylock from queue attributes
Date: Mon,  5 May 2025 18:12:48 -0400
Message-Id: <20250505221419.2672473-552-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Antoine Tenart <atenart@kernel.org>

[ Upstream commit b0b6fcfa6ad8433e22b050c72cfbeec2548744b9 ]

Similar to the commit removing remove rtnl_trylock from device
attributes we here apply the same technique to networking queues.

Signed-off-by: Antoine Tenart <atenart@kernel.org>
Link: https://patch.msgid.link/20250204170314.146022-5-atenart@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/net-sysfs.c | 147 ++++++++++++++++++++++++++-----------------
 1 file changed, 89 insertions(+), 58 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 07cb99b114bdd..77465dc3cd648 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1244,9 +1244,11 @@ static int net_rx_queue_change_owner(struct net_device *dev, int num,
  */
 struct netdev_queue_attribute {
 	struct attribute attr;
-	ssize_t (*show)(struct netdev_queue *queue, char *buf);
-	ssize_t (*store)(struct netdev_queue *queue,
-			 const char *buf, size_t len);
+	ssize_t (*show)(struct kobject *kobj, struct attribute *attr,
+			struct netdev_queue *queue, char *buf);
+	ssize_t (*store)(struct kobject *kobj, struct attribute *attr,
+			 struct netdev_queue *queue, const char *buf,
+			 size_t len);
 };
 #define to_netdev_queue_attr(_attr) \
 	container_of(_attr, struct netdev_queue_attribute, attr)
@@ -1263,7 +1265,7 @@ static ssize_t netdev_queue_attr_show(struct kobject *kobj,
 	if (!attribute->show)
 		return -EIO;
 
-	return attribute->show(queue, buf);
+	return attribute->show(kobj, attr, queue, buf);
 }
 
 static ssize_t netdev_queue_attr_store(struct kobject *kobj,
@@ -1277,7 +1279,7 @@ static ssize_t netdev_queue_attr_store(struct kobject *kobj,
 	if (!attribute->store)
 		return -EIO;
 
-	return attribute->store(queue, buf, count);
+	return attribute->store(kobj, attr, queue, buf, count);
 }
 
 static const struct sysfs_ops netdev_queue_sysfs_ops = {
@@ -1285,7 +1287,8 @@ static const struct sysfs_ops netdev_queue_sysfs_ops = {
 	.store = netdev_queue_attr_store,
 };
 
-static ssize_t tx_timeout_show(struct netdev_queue *queue, char *buf)
+static ssize_t tx_timeout_show(struct kobject *kobj, struct attribute *attr,
+			       struct netdev_queue *queue, char *buf)
 {
 	unsigned long trans_timeout = atomic_long_read(&queue->trans_timeout);
 
@@ -1303,18 +1306,18 @@ static unsigned int get_netdev_queue_index(struct netdev_queue *queue)
 	return i;
 }
 
-static ssize_t traffic_class_show(struct netdev_queue *queue,
-				  char *buf)
+static ssize_t traffic_class_show(struct kobject *kobj, struct attribute *attr,
+				  struct netdev_queue *queue, char *buf)
 {
 	struct net_device *dev = queue->dev;
-	int num_tc, tc;
-	int index;
+	int num_tc, tc, index, ret;
 
 	if (!netif_is_multiqueue(dev))
 		return -ENOENT;
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	ret = sysfs_rtnl_lock(kobj, attr, queue->dev);
+	if (ret)
+		return ret;
 
 	index = get_netdev_queue_index(queue);
 
@@ -1341,24 +1344,25 @@ static ssize_t traffic_class_show(struct netdev_queue *queue,
 }
 
 #ifdef CONFIG_XPS
-static ssize_t tx_maxrate_show(struct netdev_queue *queue,
-			       char *buf)
+static ssize_t tx_maxrate_show(struct kobject *kobj, struct attribute *attr,
+			       struct netdev_queue *queue, char *buf)
 {
 	return sysfs_emit(buf, "%lu\n", queue->tx_maxrate);
 }
 
-static ssize_t tx_maxrate_store(struct netdev_queue *queue,
-				const char *buf, size_t len)
+static ssize_t tx_maxrate_store(struct kobject *kobj, struct attribute *attr,
+				struct netdev_queue *queue, const char *buf,
+				size_t len)
 {
-	struct net_device *dev = queue->dev;
 	int err, index = get_netdev_queue_index(queue);
+	struct net_device *dev = queue->dev;
 	u32 rate = 0;
 
 	if (!capable(CAP_NET_ADMIN))
 		return -EPERM;
 
 	/* The check is also done later; this helps returning early without
-	 * hitting the trylock/restart below.
+	 * hitting the locking section below.
 	 */
 	if (!dev->netdev_ops->ndo_set_tx_maxrate)
 		return -EOPNOTSUPP;
@@ -1367,18 +1371,21 @@ static ssize_t tx_maxrate_store(struct netdev_queue *queue,
 	if (err < 0)
 		return err;
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	err = sysfs_rtnl_lock(kobj, attr, dev);
+	if (err)
+		return err;
 
 	err = -EOPNOTSUPP;
 	if (dev->netdev_ops->ndo_set_tx_maxrate)
 		err = dev->netdev_ops->ndo_set_tx_maxrate(dev, index, rate);
 
-	rtnl_unlock();
 	if (!err) {
 		queue->tx_maxrate = rate;
+		rtnl_unlock();
 		return len;
 	}
+
+	rtnl_unlock();
 	return err;
 }
 
@@ -1422,16 +1429,17 @@ static ssize_t bql_set(const char *buf, const size_t count,
 	return count;
 }
 
-static ssize_t bql_show_hold_time(struct netdev_queue *queue,
-				  char *buf)
+static ssize_t bql_show_hold_time(struct kobject *kobj, struct attribute *attr,
+				  struct netdev_queue *queue, char *buf)
 {
 	struct dql *dql = &queue->dql;
 
 	return sysfs_emit(buf, "%u\n", jiffies_to_msecs(dql->slack_hold_time));
 }
 
-static ssize_t bql_set_hold_time(struct netdev_queue *queue,
-				 const char *buf, size_t len)
+static ssize_t bql_set_hold_time(struct kobject *kobj, struct attribute *attr,
+				 struct netdev_queue *queue, const char *buf,
+				 size_t len)
 {
 	struct dql *dql = &queue->dql;
 	unsigned int value;
@@ -1450,15 +1458,17 @@ static struct netdev_queue_attribute bql_hold_time_attribute __ro_after_init
 	= __ATTR(hold_time, 0644,
 		 bql_show_hold_time, bql_set_hold_time);
 
-static ssize_t bql_show_stall_thrs(struct netdev_queue *queue, char *buf)
+static ssize_t bql_show_stall_thrs(struct kobject *kobj, struct attribute *attr,
+				   struct netdev_queue *queue, char *buf)
 {
 	struct dql *dql = &queue->dql;
 
 	return sysfs_emit(buf, "%u\n", jiffies_to_msecs(dql->stall_thrs));
 }
 
-static ssize_t bql_set_stall_thrs(struct netdev_queue *queue,
-				  const char *buf, size_t len)
+static ssize_t bql_set_stall_thrs(struct kobject *kobj, struct attribute *attr,
+				  struct netdev_queue *queue, const char *buf,
+				  size_t len)
 {
 	struct dql *dql = &queue->dql;
 	unsigned int value;
@@ -1484,13 +1494,15 @@ static ssize_t bql_set_stall_thrs(struct netdev_queue *queue,
 static struct netdev_queue_attribute bql_stall_thrs_attribute __ro_after_init =
 	__ATTR(stall_thrs, 0644, bql_show_stall_thrs, bql_set_stall_thrs);
 
-static ssize_t bql_show_stall_max(struct netdev_queue *queue, char *buf)
+static ssize_t bql_show_stall_max(struct kobject *kobj, struct attribute *attr,
+				  struct netdev_queue *queue, char *buf)
 {
 	return sysfs_emit(buf, "%u\n", READ_ONCE(queue->dql.stall_max));
 }
 
-static ssize_t bql_set_stall_max(struct netdev_queue *queue,
-				 const char *buf, size_t len)
+static ssize_t bql_set_stall_max(struct kobject *kobj, struct attribute *attr,
+				 struct netdev_queue *queue, const char *buf,
+				 size_t len)
 {
 	WRITE_ONCE(queue->dql.stall_max, 0);
 	return len;
@@ -1499,7 +1511,8 @@ static ssize_t bql_set_stall_max(struct netdev_queue *queue,
 static struct netdev_queue_attribute bql_stall_max_attribute __ro_after_init =
 	__ATTR(stall_max, 0644, bql_show_stall_max, bql_set_stall_max);
 
-static ssize_t bql_show_stall_cnt(struct netdev_queue *queue, char *buf)
+static ssize_t bql_show_stall_cnt(struct kobject *kobj, struct attribute *attr,
+				  struct netdev_queue *queue, char *buf)
 {
 	struct dql *dql = &queue->dql;
 
@@ -1509,8 +1522,8 @@ static ssize_t bql_show_stall_cnt(struct netdev_queue *queue, char *buf)
 static struct netdev_queue_attribute bql_stall_cnt_attribute __ro_after_init =
 	__ATTR(stall_cnt, 0444, bql_show_stall_cnt, NULL);
 
-static ssize_t bql_show_inflight(struct netdev_queue *queue,
-				 char *buf)
+static ssize_t bql_show_inflight(struct kobject *kobj, struct attribute *attr,
+				 struct netdev_queue *queue, char *buf)
 {
 	struct dql *dql = &queue->dql;
 
@@ -1521,13 +1534,16 @@ static struct netdev_queue_attribute bql_inflight_attribute __ro_after_init =
 	__ATTR(inflight, 0444, bql_show_inflight, NULL);
 
 #define BQL_ATTR(NAME, FIELD)						\
-static ssize_t bql_show_ ## NAME(struct netdev_queue *queue,		\
-				 char *buf)				\
+static ssize_t bql_show_ ## NAME(struct kobject *kobj,			\
+				 struct attribute *attr,		\
+				 struct netdev_queue *queue, char *buf)	\
 {									\
 	return bql_show(buf, queue->dql.FIELD);				\
 }									\
 									\
-static ssize_t bql_set_ ## NAME(struct netdev_queue *queue,		\
+static ssize_t bql_set_ ## NAME(struct kobject *kobj,			\
+				struct attribute *attr,			\
+				struct netdev_queue *queue,		\
 				const char *buf, size_t len)		\
 {									\
 	return bql_set(buf, len, &queue->dql.FIELD);			\
@@ -1613,19 +1629,21 @@ static ssize_t xps_queue_show(struct net_device *dev, unsigned int index,
 	return len < PAGE_SIZE ? len : -EINVAL;
 }
 
-static ssize_t xps_cpus_show(struct netdev_queue *queue, char *buf)
+static ssize_t xps_cpus_show(struct kobject *kobj, struct attribute *attr,
+			     struct netdev_queue *queue, char *buf)
 {
 	struct net_device *dev = queue->dev;
 	unsigned int index;
-	int len, tc;
+	int len, tc, ret;
 
 	if (!netif_is_multiqueue(dev))
 		return -ENOENT;
 
 	index = get_netdev_queue_index(queue);
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	ret = sysfs_rtnl_lock(kobj, attr, queue->dev);
+	if (ret)
+		return ret;
 
 	/* If queue belongs to subordinate dev use its map */
 	dev = netdev_get_tx_queue(dev, index)->sb_dev ? : dev;
@@ -1636,18 +1654,21 @@ static ssize_t xps_cpus_show(struct netdev_queue *queue, char *buf)
 		return -EINVAL;
 	}
 
-	/* Make sure the subordinate device can't be freed */
-	get_device(&dev->dev);
+	/* Increase the net device refcnt to make sure it won't be freed while
+	 * xps_queue_show is running.
+	 */
+	dev_hold(dev);
 	rtnl_unlock();
 
 	len = xps_queue_show(dev, index, tc, buf, XPS_CPUS);
 
-	put_device(&dev->dev);
+	dev_put(dev);
 	return len;
 }
 
-static ssize_t xps_cpus_store(struct netdev_queue *queue,
-			      const char *buf, size_t len)
+static ssize_t xps_cpus_store(struct kobject *kobj, struct attribute *attr,
+			      struct netdev_queue *queue, const char *buf,
+			      size_t len)
 {
 	struct net_device *dev = queue->dev;
 	unsigned int index;
@@ -1671,9 +1692,10 @@ static ssize_t xps_cpus_store(struct netdev_queue *queue,
 		return err;
 	}
 
-	if (!rtnl_trylock()) {
+	err = sysfs_rtnl_lock(kobj, attr, dev);
+	if (err) {
 		free_cpumask_var(mask);
-		return restart_syscall();
+		return err;
 	}
 
 	err = netif_set_xps_queue(dev, mask, index);
@@ -1687,26 +1709,34 @@ static ssize_t xps_cpus_store(struct netdev_queue *queue,
 static struct netdev_queue_attribute xps_cpus_attribute __ro_after_init
 	= __ATTR_RW(xps_cpus);
 
-static ssize_t xps_rxqs_show(struct netdev_queue *queue, char *buf)
+static ssize_t xps_rxqs_show(struct kobject *kobj, struct attribute *attr,
+			     struct netdev_queue *queue, char *buf)
 {
 	struct net_device *dev = queue->dev;
 	unsigned int index;
-	int tc;
+	int tc, ret;
 
 	index = get_netdev_queue_index(queue);
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	ret = sysfs_rtnl_lock(kobj, attr, dev);
+	if (ret)
+		return ret;
 
 	tc = netdev_txq_to_tc(dev, index);
+
+	/* Increase the net device refcnt to make sure it won't be freed while
+	 * xps_queue_show is running.
+	 */
+	dev_hold(dev);
 	rtnl_unlock();
-	if (tc < 0)
-		return -EINVAL;
 
-	return xps_queue_show(dev, index, tc, buf, XPS_RXQS);
+	ret = tc >= 0 ? xps_queue_show(dev, index, tc, buf, XPS_RXQS) : -EINVAL;
+	dev_put(dev);
+	return ret;
 }
 
-static ssize_t xps_rxqs_store(struct netdev_queue *queue, const char *buf,
+static ssize_t xps_rxqs_store(struct kobject *kobj, struct attribute *attr,
+			      struct netdev_queue *queue, const char *buf,
 			      size_t len)
 {
 	struct net_device *dev = queue->dev;
@@ -1730,9 +1760,10 @@ static ssize_t xps_rxqs_store(struct netdev_queue *queue, const char *buf,
 		return err;
 	}
 
-	if (!rtnl_trylock()) {
+	err = sysfs_rtnl_lock(kobj, attr, dev);
+	if (err) {
 		bitmap_free(mask);
-		return restart_syscall();
+		return err;
 	}
 
 	cpus_read_lock();
-- 
2.39.5


