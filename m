Return-Path: <stable+bounces-64884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EAB943B85
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41041F21610
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0B9189B8C;
	Thu,  1 Aug 2024 00:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syg0R+dx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366FF189B84;
	Thu,  1 Aug 2024 00:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471295; cv=none; b=O2hb16Lxq4TZIIW8Vzhm8SH0qM8aplOISbPUHyeiVnD7y+ProawEPfEsfMI6pM/3ZtxUXePHPkHLjt6djTd2atS62OokwKMXQmvcvhZlWWad0H+bWTG9iAcD/9/VnFyUWEqJQLhTbdvCeemDH374mLXyoYFlcOI+hns5+AM9hSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471295; c=relaxed/simple;
	bh=HdHvwJvQdta7ijkZn4uMhGeMqyx6AbYsyh0Ms0akYLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhonEmE7uKu7+/5ag2xh1xmvW2W5DqTwozvqiAjlAqd/3OGbMxcITtnWPeJ1RNWyxUWNBzttBsXICyNnCZQMh6rTP70fSu5wA4kc6ol2gLw+36VUKuUnbXn9mkGx6QVkdwC0o76rqXuCH09LGthUn4S5qFzrtBV82M2rv1qj5ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syg0R+dx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65956C4AF0C;
	Thu,  1 Aug 2024 00:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471294;
	bh=HdHvwJvQdta7ijkZn4uMhGeMqyx6AbYsyh0Ms0akYLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=syg0R+dxB2gyZSjFFlb81KrxNbeNMTvqFaQzUxqlIAdqe/GJSf3sGI5PO9viBTCwd
	 jCLq8mwEyS5rquab9geSI/XfgMP+D7dl7HhMMKlnLsYZzjQVqdtb0dA0g2Z1sYtswl
	 qWlD8XF2SeFajkM8yqAZO+pHFvWKh8leLEfhWbUbZSOjVrCSX/hEnjlak7e4SkcCM/
	 hM4Jfr3bHbWfRygfKRxMdd6H/aOqHMyeVz2QJCD8fL1WkpwrNFLhJ9mO2BMPYNOHNy
	 ehKfodEM4IFG395ERl6Y7MiRcTVHN7YlDidwaBXK+lmY91EE1HLXxB68sx2GGwUSC1
	 Se5jU/ZNmMs5Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Richard Maina <quic_rmaina@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Chris Lew <quic_clew@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	corbet@lwn.net,
	linux-remoteproc@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 059/121] hwspinlock: Introduce hwspin_lock_bust()
Date: Wed, 31 Jul 2024 19:59:57 -0400
Message-ID: <20240801000834.3930818-59-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Richard Maina <quic_rmaina@quicinc.com>

[ Upstream commit 7c327d56597d8de1680cf24e956b704270d3d84a ]

When a remoteproc crashes or goes down unexpectedly this can result in
a state where locks held by the remoteproc will remain locked possibly
resulting in deadlock. This new API hwspin_lock_bust() allows
hwspinlock implementers to define a bust operation for freeing previously
acquired hwspinlocks after verifying ownership of the acquired lock.

Signed-off-by: Richard Maina <quic_rmaina@quicinc.com>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Chris Lew <quic_clew@quicinc.com>
Link: https://lore.kernel.org/r/20240529-hwspinlock-bust-v3-1-c8b924ffa5a2@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/locking/hwspinlock.rst     | 11 ++++++++++
 drivers/hwspinlock/hwspinlock_core.c     | 28 ++++++++++++++++++++++++
 drivers/hwspinlock/hwspinlock_internal.h |  3 +++
 include/linux/hwspinlock.h               |  6 +++++
 4 files changed, 48 insertions(+)

diff --git a/Documentation/locking/hwspinlock.rst b/Documentation/locking/hwspinlock.rst
index 6f03713b70039..2ffaa3cbd63f1 100644
--- a/Documentation/locking/hwspinlock.rst
+++ b/Documentation/locking/hwspinlock.rst
@@ -85,6 +85,17 @@ is already free).
 
 Should be called from a process context (might sleep).
 
+::
+
+  int hwspin_lock_bust(struct hwspinlock *hwlock, unsigned int id);
+
+After verifying the owner of the hwspinlock, release a previously acquired
+hwspinlock; returns 0 on success, or an appropriate error code on failure
+(e.g. -EOPNOTSUPP if the bust operation is not defined for the specific
+hwspinlock).
+
+Should be called from a process context (might sleep).
+
 ::
 
   int hwspin_lock_timeout(struct hwspinlock *hwlock, unsigned int timeout);
diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
index 0c0a932c00f35..6505261e60686 100644
--- a/drivers/hwspinlock/hwspinlock_core.c
+++ b/drivers/hwspinlock/hwspinlock_core.c
@@ -305,6 +305,34 @@ void __hwspin_unlock(struct hwspinlock *hwlock, int mode, unsigned long *flags)
 }
 EXPORT_SYMBOL_GPL(__hwspin_unlock);
 
+/**
+ * hwspin_lock_bust() - bust a specific hwspinlock
+ * @hwlock: a previously-acquired hwspinlock which we want to bust
+ * @id: identifier of the remote lock holder, if applicable
+ *
+ * This function will bust a hwspinlock that was previously acquired as
+ * long as the current owner of the lock matches the id given by the caller.
+ *
+ * Context: Process context.
+ *
+ * Returns: 0 on success, or -EINVAL if the hwspinlock does not exist, or
+ * the bust operation fails, and -EOPNOTSUPP if the bust operation is not
+ * defined for the hwspinlock.
+ */
+int hwspin_lock_bust(struct hwspinlock *hwlock, unsigned int id)
+{
+	if (WARN_ON(!hwlock))
+		return -EINVAL;
+
+	if (!hwlock->bank->ops->bust) {
+		pr_err("bust operation not defined\n");
+		return -EOPNOTSUPP;
+	}
+
+	return hwlock->bank->ops->bust(hwlock, id);
+}
+EXPORT_SYMBOL_GPL(hwspin_lock_bust);
+
 /**
  * of_hwspin_lock_simple_xlate - translate hwlock_spec to return a lock id
  * @hwlock_spec: hwlock specifier as found in the device tree
diff --git a/drivers/hwspinlock/hwspinlock_internal.h b/drivers/hwspinlock/hwspinlock_internal.h
index 29892767bb7a0..f298fc0ee5adb 100644
--- a/drivers/hwspinlock/hwspinlock_internal.h
+++ b/drivers/hwspinlock/hwspinlock_internal.h
@@ -21,6 +21,8 @@ struct hwspinlock_device;
  * @trylock: make a single attempt to take the lock. returns 0 on
  *	     failure and true on success. may _not_ sleep.
  * @unlock:  release the lock. always succeed. may _not_ sleep.
+ * @bust:    optional, platform-specific bust handler, called by hwspinlock
+ *	     core to bust a specific lock.
  * @relax:   optional, platform-specific relax handler, called by hwspinlock
  *	     core while spinning on a lock, between two successive
  *	     invocations of @trylock. may _not_ sleep.
@@ -28,6 +30,7 @@ struct hwspinlock_device;
 struct hwspinlock_ops {
 	int (*trylock)(struct hwspinlock *lock);
 	void (*unlock)(struct hwspinlock *lock);
+	int (*bust)(struct hwspinlock *lock, unsigned int id);
 	void (*relax)(struct hwspinlock *lock);
 };
 
diff --git a/include/linux/hwspinlock.h b/include/linux/hwspinlock.h
index bfe7c1f1ac6d1..f0231dbc47771 100644
--- a/include/linux/hwspinlock.h
+++ b/include/linux/hwspinlock.h
@@ -68,6 +68,7 @@ int __hwspin_lock_timeout(struct hwspinlock *, unsigned int, int,
 int __hwspin_trylock(struct hwspinlock *, int, unsigned long *);
 void __hwspin_unlock(struct hwspinlock *, int, unsigned long *);
 int of_hwspin_lock_get_id_byname(struct device_node *np, const char *name);
+int hwspin_lock_bust(struct hwspinlock *hwlock, unsigned int id);
 int devm_hwspin_lock_free(struct device *dev, struct hwspinlock *hwlock);
 struct hwspinlock *devm_hwspin_lock_request(struct device *dev);
 struct hwspinlock *devm_hwspin_lock_request_specific(struct device *dev,
@@ -127,6 +128,11 @@ void __hwspin_unlock(struct hwspinlock *hwlock, int mode, unsigned long *flags)
 {
 }
 
+static inline int hwspin_lock_bust(struct hwspinlock *hwlock, unsigned int id)
+{
+	return 0;
+}
+
 static inline int of_hwspin_lock_get_id(struct device_node *np, int index)
 {
 	return 0;
-- 
2.43.0


