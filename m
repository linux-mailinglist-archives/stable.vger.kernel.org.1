Return-Path: <stable+bounces-188977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFCABFBBBE
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 13:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A5044E854B
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 11:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8331933EB0A;
	Wed, 22 Oct 2025 11:53:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EC12F8BF7;
	Wed, 22 Oct 2025 11:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761134032; cv=none; b=gR6opx2RZFw4NIAzD7P7E/MpUHsGjUm8UGXxPqPEqgxSOoxkdG9TyCuEuip//gwgl89HNNtFWohc8FkJb/AZeVoXvBM3d6uUuEZ4lyB35Jm3PGaRr4RNZyhHXrlS6wLeRc5IIRq/qn+bDd5g9hC/cq4AIDhWWXs9G3gXEggM0A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761134032; c=relaxed/simple;
	bh=pwQk5zAt/ju7QPDJfmEeV5nnlUGY2G1Vk6+0+y39tYM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=mPa8yxzUlDPbFltS3iSDikCJDaeR7WGUlUInXCN3Kt86kUTO0ctCPNzwR0mgyWMz5GHgWYATRzrpyd+TAQLqOycnVRz6w/txTQFrr/LWskVnJ8xf3uB2WT6E9vF6ouTXkarPQ69IxkA5dIQ8Fvj+CjaMqVbG1EYsN9L9oCw+k2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-01 (Coremail) with SMTP id qwCowACnAaS3xfho7Kr3Ew--.6894S2;
	Wed, 22 Oct 2025 19:53:35 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: will@kernel.org,
	mark.rutland@arm.com,
	robin.murphy@arm.com,
	james.clark@linaro.org,
	ilkka@os.amperecomputing.com,
	make24@iscas.ac.cn,
	u.kleine-koenig@baylibre.com,
	bwicaksono@nvidia.com,
	suzuki.poulose@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: [PATCH RESEND] perf: arm_cspmu: fix error handling in arm_cspmu_impl_unregister()
Date: Wed, 22 Oct 2025 19:53:25 +0800
Message-Id: <20251022115325.25900-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:qwCowACnAaS3xfho7Kr3Ew--.6894S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF1DtrWrtF1DCry5Xr43KFg_yoW8GryUpF
	47CFW5ZFyvgr4UK39rA3yUZFWUCa1YkwnYkry8G34F9Fn3Zry3t348Kr9ag3W8JFZ8Jayj
	q34aqrn5G3W5t3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14
	v_Gw4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUO38nUUUU
	U
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

driver_find_device() calls get_device() to increment the reference
count once a matching device is found. device_release_driver()
releases the driver, but it does not decrease the reference count that
was incremented by driver_find_device(). At the end of the loop, there
is no put_device() to balance the reference count. To avoid reference
count leakage, add put_device() to decrease the reference count.

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


