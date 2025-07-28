Return-Path: <stable+bounces-164872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 687BFB13353
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 05:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88A523A2285
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 03:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57CC20127D;
	Mon, 28 Jul 2025 03:08:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB79D1F5847
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 03:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753672132; cv=none; b=tFVPqgzQyOyQucqtaMKevR63FwOA/i3XrV7/nP7E51q3mTf7VxfxpAte/SluJuPfnWa6x77hauUkrI1YClA+yWol9uJn/GNxcvbe1+aZcc7lD5la190UBP6HOzd6C7Dsr8ElNaYj1UUS4CjCPp0km5NUzqE2cyw3Zd/DoXbAKPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753672132; c=relaxed/simple;
	bh=19esnPw9oPLaOU22cf2Kn+OhRJVK1QW/drD/tiTZC/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qe1A1TphnHI8DzF9biIBHNlAfMnCjELmyAzOUzao1ruPTtGVFwM+lpid3LrzYf5IRq9GH7W6hIu34U4OkMkv2xb/aUPP92mcoItdEFA4sSuvdUTQTD3Ls9sMIGM8u8xC2ad1LpWXiJVGIA98iIuLC93Sy0l6nVDu6GrvPBZ3TqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4br3N22W5DzYQv5l
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 11:08:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0D6AC1A1048
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 11:08:49 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgCXExS56YZokj7rBg--.58859S6;
	Mon, 28 Jul 2025 11:08:48 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	rafael@kernel.org,
	pavel@ucw.cz
Cc: stable@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH 6.6 4/5] freezer,sched: Clean saved_state when restoring it during thaw
Date: Mon, 28 Jul 2025 02:54:43 +0000
Message-Id: <20250728025444.34009-5-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250728025444.34009-1-chenridong@huaweicloud.com>
References: <2025072421-deviate-skintight-bbd5@gregkh>
 <20250728025444.34009-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXExS56YZokj7rBg--.58859S6
X-Coremail-Antispam: 1UD129KBjvdXoW7Xry3Gr15AFyxArWUCF4Durg_yoWDGwc_Ka
	y8Gr4093ykJF10gas3Kr45X3W8K34DJw18uw1UXr45uryYvF98JayrXr95GrZ8Wrs2kFyq
	kF1fGwsrKr10qjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbg8YFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s
	0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26F4UJVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
	v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	W8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U07KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Elliot Berman <quic_eberman@quicinc.com>

[ Upstream commit 418146e39891ef1fb2284dee4cabbfe616cd21cf ]

Clean saved_state after using it during thaw. Cleaning the saved_state
allows us to avoid some unnecessary branches in ttwu_state_match.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20231120-freezer-state-multiple-thaws-v1-2-f2e1dd7ce5a2@quicinc.com
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/freezer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/freezer.c b/kernel/freezer.c
index 759006a9a910..f57aaf96b829 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -187,6 +187,7 @@ static int __restore_freezer_state(struct task_struct *p, void *arg)
 
 	if (state != TASK_RUNNING) {
 		WRITE_ONCE(p->__state, state);
+		p->saved_state = TASK_RUNNING;
 		return 1;
 	}
 
-- 
2.34.1


