Return-Path: <stable+bounces-138970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4154EAA3D29
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 01:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39BBC9A2E9B
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 23:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DEC2DFA23;
	Tue, 29 Apr 2025 23:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iN2HqKnb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803CD24676C;
	Tue, 29 Apr 2025 23:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970636; cv=none; b=bdR0QpcW8NwzD/PV2suFMSmpVptNfOlUcaC63LDbyAD4+QzQ983fMqO+K/ZZCE6tU9xJqskrbU4J7isobEQSSAC0D4APlNWPsuWxWLqA3uFv6Zc5WCiPqefYEY2HA57TmfAkXBuouSIVLKeFiaWYSV0qJpz6FAzYqRVUkHe3vi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970636; c=relaxed/simple;
	bh=6ZEJnPaJpOwZ0QFduELFZTqeO/rARVUjGYJCAGrpGMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qBRETJE1f7LdTbdYSO+go3DAdBTUEsKXAumrPv7a9T3VfblRbX3wT/ldJfMH3yma8iFyHlMpSkYawVrddqP2pJJJsBROW2hBfxr4Un7lTC+3WiauFvuHLSZS87cWGsHaPoa5brrHPLdRm//hjuZocw7ZnDwo4cWJFs9Z369y5Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iN2HqKnb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED9DC4CEE3;
	Tue, 29 Apr 2025 23:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970636;
	bh=6ZEJnPaJpOwZ0QFduELFZTqeO/rARVUjGYJCAGrpGMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iN2HqKnbIhPi9gQVcLr9VQqdBgxeyaHJyShNHbB7vOcPNhiJsrbfaC4Ulsw7NTjad
	 KMx9gdK3JjQ9EUwwetbTs5HAt/vnbg/mU/awGC1IPifNZNLfMVlsQpAynj02jatxMt
	 NtEvYbqKfeFdA+0EG0iby9FxsdC+xkZdIIzwo3PX43AOsmLqdZHxfie06L83KfBtpX
	 LSO5Hw0E5ikXQ0uEPg6p7aqygi0EKpJOXvs/IPMdiK7Va2+TkEbjdwYHtNEC0kJFZD
	 SEl9sEa40AyyyYSeMkRdlJGDZSl7clx68DeCykJ61LhbZpbVRoiUBdT81jM4njI9ZL
	 C8JELGW8BlZPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	dakr@kernel.org
Subject: [PATCH AUTOSEL 6.14 14/39] driver core: introduce device_set_driver() helper
Date: Tue, 29 Apr 2025 19:49:41 -0400
Message-Id: <20250429235006.536648-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235006.536648-1-sashal@kernel.org>
References: <20250429235006.536648-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.4
Content-Transfer-Encoding: 8bit

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 04d3e5461c1f5cf8eec964ab64948ebed826e95e ]

In preparation to closing a race when reading driver pointer in
dev_uevent() code, instead of setting device->driver pointer directly
introduce device_set_driver() helper.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20250311052417.1846985-2-dmitry.torokhov@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/base.h | 6 ++++++
 drivers/base/core.c | 2 +-
 drivers/base/dd.c   | 7 +++----
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 0042e4774b0ce..eb203cf8370bc 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -180,6 +180,12 @@ int driver_add_groups(const struct device_driver *drv, const struct attribute_gr
 void driver_remove_groups(const struct device_driver *drv, const struct attribute_group **groups);
 void device_driver_detach(struct device *dev);
 
+static inline void device_set_driver(struct device *dev, const struct device_driver *drv)
+{
+	// FIXME - this cast should not be needed "soon"
+	dev->driver = (struct device_driver *)drv;
+}
+
 int devres_release_all(struct device *dev);
 void device_block_probing(void);
 void device_unblock_probing(void);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 2fde698430dff..4a23dc8e2cdaf 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3700,7 +3700,7 @@ int device_add(struct device *dev)
 	device_pm_remove(dev);
 	dpm_sysfs_remove(dev);
  DPMError:
-	dev->driver = NULL;
+	device_set_driver(dev, NULL);
 	bus_remove_device(dev);
  BusError:
 	device_remove_attrs(dev);
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index f0e4b4aba885c..b526e0e0f52d7 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -550,7 +550,7 @@ static void device_unbind_cleanup(struct device *dev)
 	arch_teardown_dma_ops(dev);
 	kfree(dev->dma_range_map);
 	dev->dma_range_map = NULL;
-	dev->driver = NULL;
+	device_set_driver(dev, NULL);
 	dev_set_drvdata(dev, NULL);
 	if (dev->pm_domain && dev->pm_domain->dismiss)
 		dev->pm_domain->dismiss(dev);
@@ -629,8 +629,7 @@ static int really_probe(struct device *dev, const struct device_driver *drv)
 	}
 
 re_probe:
-	// FIXME - this cast should not be needed "soon"
-	dev->driver = (struct device_driver *)drv;
+	device_set_driver(dev, drv);
 
 	/* If using pinctrl, bind pins now before probing */
 	ret = pinctrl_bind_pins(dev);
@@ -1014,7 +1013,7 @@ static int __device_attach(struct device *dev, bool allow_async)
 		if (ret == 0)
 			ret = 1;
 		else {
-			dev->driver = NULL;
+			device_set_driver(dev, NULL);
 			ret = 0;
 		}
 	} else {
-- 
2.39.5


