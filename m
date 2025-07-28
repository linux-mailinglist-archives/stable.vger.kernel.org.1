Return-Path: <stable+bounces-164871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 923C9B13352
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 05:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD13163E5C
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 03:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993351F1313;
	Mon, 28 Jul 2025 03:08:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB11F1E6DC5
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 03:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753672132; cv=none; b=lGFusLCllHFy2boKk0wO3Yw7KW1i3BIsxeU1eL3wwvzVCIpsIa1TkttAzYbE+2fbGd62T57mgmohFmkwBxZWfCC5aI+B1f3RfISNk2ny9GDZia04EoGdQCCH2LLX/FMoNjszGF1QiarEbo14RvBuS7ItBvCpXi6SlwL4nlXhi+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753672132; c=relaxed/simple;
	bh=+oL54au+1m3Cp1wMvpFxeLnh9JqL0aaVe+vXbVFj9mE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FLcysWAflPNnIUAk0L3IOKO/luVBb/sTcUM/qfV5OtAhpEvR8AXrIgiwZ8H5F4tJjMtG1rrDE1YJNDAiQ2S07d0BZVLWtOr7AiISc3jJdaipQI+aGLvaQ7abYqHNthnMdoAtdZbv8fcYY2KRTYWSubp16jBqsBWLQEMgJgixAZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4br3N14vP4zKHMgK
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 11:08:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 81A521A142F
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 11:08:48 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgCXExS56YZokj7rBg--.58859S2;
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
Subject: [PATCH 6.6 0/5] [Backport] sched,freezer: Remove unnecessary warning in __thaw_task
Date: Mon, 28 Jul 2025 02:54:39 +0000
Message-Id: <20250728025444.34009-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025072421-deviate-skintight-bbd5@gregkh>
References: <2025072421-deviate-skintight-bbd5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXExS56YZokj7rBg--.58859S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF1fGF1DCF48Gry7XrykGrg_yoWkJwb_Ka
	4fGFyxtrykJF1UGFW7KF97XryDKayUJr18GF1qqr45Zry2vr95XF43GrWkur1rX3Z7Xr1D
	Aryftan7Ar1DKjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07j4eHgUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

To fix the [1] issue, it needs to backport:
9beb8c5e77dc ("sched,freezer: Remove unnecessary warning...")
14a67b42cb6f ("Revert 'cgroup_freezer: cgroup freezing: Check if not...'").

This series aims to backport 9beb8c5e77dc. To avoid conflicts, backport the
missing patches[2].

[1] https://lore.kernel.org/lkml/20250717085550.3828781-1-chenridong@huaweicloud.com/
[2] https://lore.kernel.org/stable/2025072421-deviate-skintight-bbd5@gregkh/

Chen Ridong (1):
  sched,freezer: Remove unnecessary warning in __thaw_task

Elliot Berman (4):
  sched/core: Remove ifdeffery for saved_state
  freezer,sched: Use saved_state to reduce some spurious wakeups
  freezer,sched: Do not restore saved_state of a thawed task
  freezer,sched: Clean saved_state when restoring it during thaw

 include/linux/sched.h |  2 --
 kernel/freezer.c      | 51 +++++++++++++++++--------------------------
 kernel/sched/core.c   | 31 +++++++++++++-------------
 3 files changed, 35 insertions(+), 49 deletions(-)

-- 
2.34.1


