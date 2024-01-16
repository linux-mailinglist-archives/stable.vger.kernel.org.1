Return-Path: <stable+bounces-11033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DC382E44C
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 01:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBA5CB2200E
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 00:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F42E883A;
	Tue, 16 Jan 2024 00:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3zy1S7F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323A013FE9;
	Tue, 16 Jan 2024 00:09:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9980C43394;
	Tue, 16 Jan 2024 00:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705363772;
	bh=wUwrcFgdZKAw5vQdXsFRFC3WJb01sC1DeaFIPkJrp9Q=;
	h=From:To:Cc:Subject:Date:From;
	b=u3zy1S7FHcl+y2J5U19P2vjm1Dadc5BvZJsrsjqCBikaDT5bqAq0TWqtqtIwsErDy
	 ZSQFUfTfEWp0yBTsDDvY0fCDyjKguolirOWiNOkrm6bi7ZEl5vsIXoECLVQj5JkaP1
	 eeUJQ3PVpisfSla18Vvm+sPg+ru+LxhFQl6ztwXRy5tFGzzUNf2Vp7Q5LfASAOZeaU
	 TCRz1qDpZHiD72VTmYYoht9rn3OXVpZ2M+kjRLbOM2W1z0e3V2APnVymOCsZCU+1VP
	 VNnX8RmebhhQFuwAvq/MQQ0YfStmBJ0apZgmDVAJsfgaJuS7D8OmBgl2+KIkfN7EV8
	 tkTjfARwKj7zA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	acme@kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 1/2] perf/core: Fix narrow startup race when creating the perf nr_addr_filters sysfs file
Date: Mon, 15 Jan 2024 19:09:28 -0500
Message-ID: <20240116000929.212677-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
Content-Transfer-Encoding: 8bit

From: Greg KH <gregkh@linuxfoundation.org>

[ Upstream commit 652ffc2104ec1f69dd4a46313888c33527145ccf ]

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/2023061204-decal-flyable-6090@gregkh
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8c7d2f4f5fba..1e4841ebc22e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11223,9 +11223,32 @@ static DEVICE_ATTR_RW(perf_event_mux_interval_ms);
 static struct attribute *pmu_dev_attrs[] = {
 	&dev_attr_type.attr,
 	&dev_attr_perf_event_mux_interval_ms.attr,
+	&dev_attr_nr_addr_filters.attr,
+	NULL,
+};
+
+static umode_t pmu_dev_is_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pmu *pmu = dev_get_drvdata(dev);
+
+	if (!pmu->nr_addr_filters)
+		return 0;
+
+	return a->mode;
+
+	return 0;
+}
+
+static struct attribute_group pmu_dev_attr_group = {
+	.is_visible = pmu_dev_is_visible,
+	.attrs = pmu_dev_attrs,
+};
+
+static const struct attribute_group *pmu_dev_groups[] = {
+	&pmu_dev_attr_group,
 	NULL,
 };
-ATTRIBUTE_GROUPS(pmu_dev);
 
 static int pmu_bus_running;
 static struct bus_type pmu_bus = {
@@ -11261,18 +11284,11 @@ static int pmu_dev_alloc(struct pmu *pmu)
 	if (ret)
 		goto free_dev;
 
-	/* For PMUs with address filters, throw in an extra attribute: */
-	if (pmu->nr_addr_filters)
-		ret = device_create_file(pmu->dev, &dev_attr_nr_addr_filters);
-
-	if (ret)
-		goto del_dev;
-
-	if (pmu->attr_update)
+	if (pmu->attr_update) {
 		ret = sysfs_update_groups(&pmu->dev->kobj, pmu->attr_update);
-
-	if (ret)
-		goto del_dev;
+		if (ret)
+			goto del_dev;
+	}
 
 out:
 	return ret;
-- 
2.43.0


