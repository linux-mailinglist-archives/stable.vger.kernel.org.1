Return-Path: <stable+bounces-208314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A2DD1C17A
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 03:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57C993029C1E
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 02:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58D82F25FB;
	Wed, 14 Jan 2026 02:06:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E8A2F260E
	for <stable@vger.kernel.org>; Wed, 14 Jan 2026 02:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768356415; cv=none; b=gH8AIm8bpL5cIFdgcKsT3grSQXT+QXFHI8mLfzsdrdfNKYccJcfUjyKbK7yMDMZOs++VrR3J2YLSulaLrlbJVA28zlF2+KynXf85sFdKadgCbibl6kW/UnVLneRkaDF9KPdqNG7Yb4U6PytvbPasmtQi6MM+IqZlzNJ9L897Ieg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768356415; c=relaxed/simple;
	bh=NT5+oYctoZ4cueKggMKW1Uemo7m6uKkXoMSLZ/u5tF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k1cUN3rqUeKsCa+X6Ba60WQbInRqDxfXj8I/0Kpu6zQWDmskDPSDDRto9i7SNJQRDNt9cjfuG4TiBDYsE+7iCbYlpDUSI5yPWrNXaoM+Z6j3MUFDk2FB4iGyz0kgP1rlDP8W12sciwXBqqxvHh+Tn0F9pmV1fwLkWzMLT3zMVJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4drTwq2rtHzKHMSs
	for <stable@vger.kernel.org>; Wed, 14 Jan 2026 10:05:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BC5A940593
	for <stable@vger.kernel.org>; Wed, 14 Jan 2026 10:06:38 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgDHKPkS+mZp6CDoDg--.60102S2;
	Wed, 14 Jan 2026 10:06:38 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	chenridong@huaweicloud.com,
	lujialin4@huawei.com
Subject: [PATCH stable] cpuset: Fix missing adaptation for cpuset_is_populated
Date: Wed, 14 Jan 2026 01:51:29 +0000
Message-Id: <20260114015129.1156361-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026011258-raving-unlovable-5059@gregkh>
References: <2026011258-raving-unlovable-5059@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHKPkS+mZp6CDoDg--.60102S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFW3JF4xCw48AF1DCF1xXwb_yoW8JFyfpF
	WDW3W3A345WF17C3yDWaySga4Fy3WkGF1UtFn5K3s5X3W7JF1jkr1j93Z0qryrZFW7C345
	XFnIvr4FganFyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUym14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdEfOUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Commit b1bcaed1e39a ("cpuset: Treat cpusets in attaching as populated")
was backported to the long‑term support (LTS) branches. However, because
commit d5cf4d34a333 ("cgroup/cpuset: Don't track # of local child
partitions") was not backported, a corresponding adaptation to the
backported code is still required.

To ensure correct behavior, replace cgroup_is_populated with
cpuset_is_populated in the partition_is_populated function.

Cc: stable@vger.kernel.org	# 6.1+
Fixes: b1bcaed1e39a ("cpuset: Treat cpusets in attaching as populated")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f61dde0497f3..3c466e742751 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -486,7 +486,7 @@ static inline bool partition_is_populated(struct cpuset *cs,
 	    cs->attach_in_progress)
 		return true;
 	if (!excluded_child && !cs->nr_subparts_cpus)
-		return cgroup_is_populated(cs->css.cgroup);
+		return cpuset_is_populated(cs);
 
 	rcu_read_lock();
 	cpuset_for_each_descendant_pre(cp, pos_css, cs) {
-- 
2.34.1


