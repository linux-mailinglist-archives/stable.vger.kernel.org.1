Return-Path: <stable+bounces-200461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADC5CAFE3E
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 13:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A7DB300C0DF
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 12:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA2127FD51;
	Tue,  9 Dec 2025 12:15:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C84322768;
	Tue,  9 Dec 2025 12:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765282522; cv=none; b=hVMlfTHU3NyDN53wNi5DWaeUyWTQckjfJnHwlqEvZWALxaJw0uVjMrQSnxqd5zlG6rghEJXfvPaTGvDeKvcxwOncqRxjEZfCcLy43EdjC1oGeq6tuyhUm507hx35BYnBTxzsqxZ3OyoZGf6KW8QSLtVg/TMhtyrHV7br/frQ5ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765282522; c=relaxed/simple;
	bh=D0rgNdgr0tTf8Grn66z+GY32XPahI4OGYdzds76lgVs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kz/KaMu6B4xjjRLXxEtsUgLcHZJ3R74oUU8Y+x7Y1onl7nEnFaCYTpdSqFhrbgVNHDXSQDSPy5PzX4CGCRdB/q1Fp7bMhxYtyIDb6zieKz+KrnQpAAbl87Rul8QXyWk6XriccB9/wDA/rcWYz7niyIcHN/RaC/XkrzE6tYQUydc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.239])
	by APP-03 (Coremail) with SMTP id rQCowAA3WeDGEjhpSrAbAA--.8366S2;
	Tue, 09 Dec 2025 20:15:03 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: lihaoxiang@isrc.iscas.ac.cn,
	paulus@ozlabs.org,
	benh@kernel.crashing.org
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] macintosh: smu_sensors: Drop the reference in smu_cpu_power_create()
Date: Tue,  9 Dec 2025 20:15:01 +0800
Message-Id: <20251209121501.35012-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAA3WeDGEjhpSrAbAA--.8366S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFykKw4xuw17WF1kGrWfKrg_yoW3KwcEvw
	12qwn7Xr4UKw40vr1DtFn3Zryqka4Duw1kWF4Fg393uFy8Xw1UJayDJrZ3ZF1xXF40yFyD
	Gw15AryUuw129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbckFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
	Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Jr0_Gr
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUSNtxUUUUU=
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiBwsLE2k35veKUQAAsA

In 'fail' error path, call wf_put_sensor() to drop the reference
obtained by wf_get_sensor().

Fixes: 75722d3992f5 ("[PATCH] ppc64: Thermal control for SMU based machines")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 drivers/macintosh/windfarm_smu_sensors.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/macintosh/windfarm_smu_sensors.c b/drivers/macintosh/windfarm_smu_sensors.c
index 2bdb73b34d29..5441a55732f1 100644
--- a/drivers/macintosh/windfarm_smu_sensors.c
+++ b/drivers/macintosh/windfarm_smu_sensors.c
@@ -374,6 +374,8 @@ smu_cpu_power_create(struct wf_sensor *volts, struct wf_sensor *amps)
 		goto fail;
 	return pow;
  fail:
+	wf_put_sensor(amps);
+	wf_put_sensor(volts);
 	kfree(pow);
 	return NULL;
 }
-- 
2.25.1


