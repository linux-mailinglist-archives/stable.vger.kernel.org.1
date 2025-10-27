Return-Path: <stable+bounces-189908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AF2C0BBCF
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 04:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 75F9234906E
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 03:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DE72D4B66;
	Mon, 27 Oct 2025 03:23:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792B886340;
	Mon, 27 Oct 2025 03:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761535417; cv=none; b=ZByVoz8NwzJ3Uu36/Z8urGAjYw2HAP5gdLP02x4LRswiMoNSt52YADdDM6vs/dpch2mKlaAR8Vgq+rZVXofnJl+jW3+wbCYq49PzGoO+taP+QChZSbbyhMo1lQzhGijhcYSmiBCF8jSlZNrUEt0IHQSlFsdKx4HidqPkqMe1hCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761535417; c=relaxed/simple;
	bh=YiWTZNMYlWlwFBnF0F4D6Wxru2/5KnyGEA5TuYud0Ak=;
	h=From:To:Cc:Subject:Date:Message-Id; b=dm/speXjhHk2YvKBUAiFqd06hqiH1YSQ6BLxTkmi4GOY8t42rjx/8qfFZeOGZVuIpU5Y1eiMhXnX3E/f1LpxsW4KYqswpTswo3HNqk1wRme2p0ymLLH+GYDerU7LVcXY0U94zSNZDDPg/YFZ3EQlllmqxXbYmb2Uaa5Hu3fsIaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-01 (Coremail) with SMTP id qwCowACHY7aU5f5oAK+HAg--.18889S2;
	Mon, 27 Oct 2025 11:23:09 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: will@kernel.org,
	mark.rutland@arm.com,
	james.clark@linaro.org,
	robin.murphy@arm.com,
	ilkka@os.amperecomputing.com,
	make24@iscas.ac.cn,
	u.kleine-koenig@baylibre.com,
	suzuki.poulose@arm.com,
	bwicaksono@nvidia.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: [PATCH] perf: arm_cspmu: fix device leak in arm_cspmu_impl_unregister
Date: Mon, 27 Oct 2025 11:22:59 +0800
Message-Id: <20251027032259.5818-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:qwCowACHY7aU5f5oAK+HAg--.18889S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF1fZrW3ArW5GF17JF43Wrg_yoW8Xry3pr
	48CFyYvFyjgr4UK39rZay8ZFWUGa1ru3s5CryxK34F9F9rZry8t348tr9xK3W8JFWUJayU
	t34aqr1kWa15JFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwV
	AFwVW8GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU3kucU
	UUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

arm_cspmu_impl_unregister() utilizes driver_find_device() to locate
matching devices. driver_find_device() increments the ref count of the
found device by calling get_device(), but arm_cspmu_impl_unregister()
fails to call put_device() to decrement the reference count after
processing each device. This results in a reference count leak of the
device objects, which prevents devices from being properly released
and causes a memory leak. Fix the leak by adding put_device() after
device_release_driver() in the while loop.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: bfc653aa89cb ("perf: arm_cspmu: Separate Arm and vendor module")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index efa9b229e701..e0d4293f06f9 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -1365,8 +1365,10 @@ void arm_cspmu_impl_unregister(const struct arm_cspmu_impl_match *impl_match)
 
 	/* Unbind the driver from all matching backend devices. */
 	while ((dev = driver_find_device(&arm_cspmu_driver.driver, NULL,
-			match, arm_cspmu_match_device)))
+			match, arm_cspmu_match_device))) {
 		device_release_driver(dev);
+		put_device(dev);
+	}
 
 	mutex_lock(&arm_cspmu_lock);
 
-- 
2.17.1


