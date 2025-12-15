Return-Path: <stable+bounces-200995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C80F7CBC409
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 03:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 447EE3009436
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 02:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A023126B7;
	Mon, 15 Dec 2025 02:27:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBD22C0275;
	Mon, 15 Dec 2025 02:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765765655; cv=none; b=CQxHIwZjhpnE3+qPZOFff/KkDKSULZvkDdWRy2vY7ZIsQYadZXyXJbV6xHLjcaatEj2fol39Nc3d0e5Bncb4tHO3MKiw3p7fz0ZEG1eJFVgtdQcS+q95djH5s4PSNzdWHvlLEjoNB5lOHNFgURcy+phBOoRHRyaT9gmHzZvMWHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765765655; c=relaxed/simple;
	bh=T/XvcEdUVYNVeTm93A6Iif4eSN3JUJWj5oJaAYyafmE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=KxUO5SK7HLmol0HAdufPQ3Y92shz0iS8R+Qe9roB+MvpEmlYe41l4PWp1oLVdKlRyUlCTy6asBmmK2sNAX64axxRijuCVTlR73ipnsgbDWNil7S9aevFJ3LOkuRgGS9k6MfOHiyN2IPL64+dTpn1ftg244sHI75evqM146adxns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-01 (Coremail) with SMTP id qwCowACHL2v+cT9p2CezAA--.45584S2;
	Mon, 15 Dec 2025 10:27:19 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: suzuki.poulose@arm.com,
	mike.leach@linaro.org,
	james.clark@linaro.org,
	alexander.shishkin@linux.intel.com,
	mathieu.poirier@linaro.org
Cc: coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2 RESEND] coresight: etm-perf: Fix reference count leak in etm_setup_aux
Date: Mon, 15 Dec 2025 10:27:09 +0800
Message-Id: <20251215022709.17220-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:qwCowACHL2v+cT9p2CezAA--.45584S2
X-Coremail-Antispam: 1UD129KBjvJXoW7XryfuFW3XryfKFy5JF1DJrb_yoW8JF18pF
	4DK39Iyr98GrWvv39rJr1DZFW5Ww1SyayagFy5K395uF4YqF9FvF15KFyFvrs7CrW8GF93
	Krs7tF48ZFyUXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67
	AK6r4UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb9NVDUU
	UUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

In etm_setup_aux(), when a user sink is obtained via
coresight_get_sink_by_id(), it increments the reference count of the
sink device. However, if the sink is used in path building, the path
holds a reference, but the initial reference from
coresight_get_sink_by_id() is not released, causing a reference count
leak. We should release the initial reference after the path is built.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 0e6c20517596 ("coresight: etm-perf: Allow an event to use different sinks")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v2:
- modified the patch as suggestions.
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 17afa0f4cdee..56d012ab6d3a 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -454,6 +454,11 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 		goto err;
 
 out:
+	if (user_sink) {
+		put_device(&user_sink->dev);
+		user_sink = NULL;
+	}
+
 	return event_data;
 
 err:
-- 
2.17.1


