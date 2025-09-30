Return-Path: <stable+bounces-182849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0DFBAE2CF
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 19:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1C13C72BF
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B89730DD21;
	Tue, 30 Sep 2025 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H08aOUdp"
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB1B30CDA4
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253304; cv=none; b=ErnTNGAFxJoKzGQpVzgsSlkDrfAd3SQNIILBU+PZ2OMHuEiaOmclUHOe+i8PS74LcHHJdEgsS35D1wmdY6yeFv5k/iECcblMawUUIjopWF5iRv4Y6wCiFap2keAqF/+8d8Zd19wTuo20qPgsaEQE3nI9BUrefWQqYjBQgY9Q3Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253304; c=relaxed/simple;
	bh=KDxXnQWIvOcKAO0hI30SHajWm44YowjQ1adjboWQSLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m4JUZ9XNueH0G4ZkYveTjHWOJqVJYidl7eL6tKYU8ZH2zNqU3QZQ97n4HuVH5h3oUCQ7ZX4qnXPv3CkOqjjbWMiEThUnd3E5Ii1IA6bpi9Lr6x/IOHhN0njdIVT2WuSd8/5KdN8UiImamx28btUilpbr3GEL6cRqtqVRnoB/gWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H08aOUdp; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759253300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UFWKO6GpxxXfQR03xrZB6itiN9eZ29IE+Uu8QNdt3u8=;
	b=H08aOUdpCg0muQbe+GP9q+U9qUWIPixcaCRBdvb1w+R5qCIfR4wTeWaM3yJdWwi28UkHnD
	bF62Ua/mVcuM4pF6YQfpnbqJ2m6ZzOns+mc4MRkv9a06DQzdHHCuDIGdRb6MrGwVMcBTAg
	Pr45V4ZiVvKm40aNQkEvrerjw+KiwQo=
From: Wen Yang <wen.yang@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pierre Gondois <pierre.gondois@arm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 6.1 3/6] cacheinfo: Check 'cache-unified' property to count cache leaves
Date: Wed,  1 Oct 2025 01:27:28 +0800
Message-Id: <36bc21af9dee720394ea691c26b3d40eb1da546f.1759251543.git.wen.yang@linux.dev>
In-Reply-To: <cover.1759251543.git.wen.yang@linux.dev>
References: <cover.1759251543.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Pierre Gondois <pierre.gondois@arm.com>

[ Upstream commit de0df442ee49cb1f6ee58f3fec5dcb5e5eb70aab ]
The DeviceTree Specification v0.3 specifies that the cache node
'[d-|i-|]cache-size' property is required. The 'cache-unified'
property is specifies whether the cache level is separate
or unified.

If the cache-size property is missing, no cache leaves is accounted.
This can lead to a 'BUG: KASAN: slab-out-of-bounds' [1] bug.

Check 'cache-unified' property and always account for at least
one cache leaf when parsing the device tree.

[1] https://lore.kernel.org/all/0f19cb3f-d6cf-4032-66d2-dedc9d09a0e3@linaro.org/

Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230104183033.755668-4-pierre.gondois@arm.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 drivers/base/cacheinfo.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 480007210bcc..ab99b0f0d010 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -224,12 +224,9 @@ static int cache_setup_of_node(unsigned int cpu)
 	return 0;
 }
 
-int init_of_cache_level(unsigned int cpu)
+static int of_count_cache_leaves(struct device_node *np)
 {
-	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-	struct device_node *np = of_cpu_device_node_get(cpu);
-	struct device_node *prev = NULL;
-	unsigned int levels = 0, leaves = 0, level;
+	unsigned int leaves = 0;
 
 	if (of_property_read_bool(np, "cache-size"))
 		++leaves;
@@ -237,6 +234,28 @@ int init_of_cache_level(unsigned int cpu)
 		++leaves;
 	if (of_property_read_bool(np, "d-cache-size"))
 		++leaves;
+
+	if (!leaves) {
+		/* The '[i-|d-|]cache-size' property is required, but
+		 * if absent, fallback on the 'cache-unified' property.
+		 */
+		if (of_property_read_bool(np, "cache-unified"))
+			return 1;
+		else
+			return 2;
+	}
+
+	return leaves;
+}
+
+int init_of_cache_level(unsigned int cpu)
+{
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	struct device_node *np = of_cpu_device_node_get(cpu);
+	struct device_node *prev = NULL;
+	unsigned int levels = 0, leaves, level;
+
+	leaves = of_count_cache_leaves(np);
 	if (leaves > 0)
 		levels = 1;
 
@@ -250,12 +269,8 @@ int init_of_cache_level(unsigned int cpu)
 			goto err_out;
 		if (level <= levels)
 			goto err_out;
-		if (of_property_read_bool(np, "cache-size"))
-			++leaves;
-		if (of_property_read_bool(np, "i-cache-size"))
-			++leaves;
-		if (of_property_read_bool(np, "d-cache-size"))
-			++leaves;
+
+		leaves += of_count_cache_leaves(np);
 		levels = level;
 	}
 
-- 
2.25.1


