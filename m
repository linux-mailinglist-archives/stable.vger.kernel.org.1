Return-Path: <stable+bounces-169802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2021B285BD
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 20:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D0EE1CC3F3D
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 18:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A6C25EF81;
	Fri, 15 Aug 2025 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ZmcDUQco"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FC33176E2
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 18:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755281979; cv=none; b=lteT11N4Kvn5edlJducN/Gt1ibqvPGy53xE0ruNnvFGzvqbkFXQorOPfxtKzBCNnaUH8QgALSc0E7IMHkb9pX5l85+AUTUnkTxjTaGC9SP+BC19BJUwHZddVFpIgS/JtodGZciSNFP1xNX6e1ybkuhr4MXjIhcO8a3+p07KJhaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755281979; c=relaxed/simple;
	bh=0woZqxYLzFksyP392esa6wR10nLFwXCg0J7gbtdbdVk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EpEO0pHgkGr+SkeX5pFZVW//3MOVL5+fjXa2HxBrfSRJu4h/sPtrBRb8qsLJrCLnQ0pwI2MvSpF8gO1NxJakU1mbCreDKRyJP5A/0taiEYir88J2aukWIeYPSWU8PYWE7Sc13UgqLDvT4ueRgWFio+HmAiI0Vco+9ZqmFah1gEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ZmcDUQco; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1755281959;
	bh=hEkmBtbR6RrU6XF3WJRHwDNSN9Is//FBdVp0Gwl73UA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=ZmcDUQcoohkwtq9gMPNg8zfREOYiaUGyr9iSr1UMB4+R+yxSjwQ+WLYHuB6eqH3Z3
	 BBnkfw4ALlZtwKskZ8t892/AuS0UXr7fjGuwsnO2FBdTluyButzrwER1JE5W30SuJ9
	 S6zBM0KJuncH0smELe5w8aC7bCKcAwmXy9UmotLs=
X-QQ-mid: esmtpgz10t1755281944t1fedb935
X-QQ-Originating-IP: 6FxWn6AwgwJ2UrJoKnY8MiMhDD4Ys3OY2+sfLaoYxNA=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 16 Aug 2025 02:19:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2946362574445198740
EX-QQ-RecipientCnt: 3
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.6 0/8] Backport sched/schedutil fixes and depend patch series
Date: Sat, 16 Aug 2025 02:16:10 +0800
Message-Id: <20250815181618.3199442-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: NPMY/kDFuZb0KB+liUKaxb+Sf0kmWYyVXxTBdJDStxiYSxWTHltpes4k
	vw87PFnXBXzdoYhdgySqzW63+jG0FFP5oX6KvHrmlV11jcB1UUgiP22UHwvA938OhPApYXD
	22hrtYbUgMd3vaw1+FJN1hgbnEUgJXiNm2w/TR96CqK/rVWZhCSrNeQma3+bVPc7RxZLuGy
	0ocPh17Q0Xfe4LDwU8AjUH2f967Hzfrt9ByXkhVguOeTsb5qFX/VUCedLsmZg7OVF63aA/S
	mHY8HYz/4sKeCF6Kd8xPLVPmPhh7mdpDmuGrdBkyqfpYXksQ1b2vn/gVr8bBBzHurcJeHpn
	CKaAJIoOq/v8s0JBw7yA7vF59ruPsOsxi5tF7f5+b00rgZSPKaAHpKAQjYWBGgduNubHVvw
	zcR57wQ7vsXC8+pBE8nF6lX3kJf8vCoJi7fwahEUTjDN53DWhgPp6LU9UACazVy53yGJy35
	W7yHbxGnCHIiYttU/+5y5SwNNL3xXxtP4pK7QmrcbEBX48d97Afmnq+VSQxxV+JlD6Nc2et
	g3rvPAvdyLmj/ETwpKFkBuxkO4WweQO0qjvPxwIis88ZNFPsm4W91m1DMs0Ec9HiEtPMzeA
	+BCNI8ujXr7fyg/FsJx8dei+liWwD2i6BDqM88HOyJEWgWVW26q5mD2G/io1dgg0VigRC8v
	vcV/FmDfhWReuZRG6jV1trVJtAzl6UNVfucJgvWe7P3Nc2Cbw30sytwO738XX8Ke+V/TqXh
	5mzuPF2kKXzhxyTG2adY9lDLBIyo0kpfTd2uv/jnK2uoYdfRlQdCGX0PONNxXDUrFlW7qGV
	iHeZGrirfuFETLiTW9aWBKDW5r5f62ulRBbg2NnaQdw31AcToRlhGaAf4usiepX9oE4DXnb
	i6OoQAOcceaG0cdBfq/QE3cRjJrvGMzGol7iNbVJ8bkfCsXBa/uTRufWhcSbeFRK45DhJte
	5hzjwNSH+316qCgkSM/1wq/ETTUwyA99TthQtrO85RrC9tOtHOWGY/bii6qAHiMUVxbMvuf
	8JaBCbQM+YJH3nyVsKisFZTzRJQdF0GiUAO/Q76RdAdXcnG/UVv9C91UPYiWI=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Our user report a bug that his cpu keep the min cpu freq,
bisect to commit ada8d7fa0ad49a2a078f97f7f6e02d24d3c357a3
("sched/cpufreq: Rework schedutil governor performance estimation")
and test the fix e37617c8e53a1f7fcba6d5e1041f4fd8a2425c27
("sched/fair: Fix frequency selection for non-invariant case")
works.

And backport the "stable-deps-of" series:
"consolidate and cleanup CPU capacity"
Link: https://lore.kernel.org/all/20231211104855.558096-1-vincent.guittot@linaro.org/
PS:
commit 50b813b147e9eb6546a1fc49d4e703e6d23691f2 in series
("cpufreq/cppc: Move and rename cppc_cpufreq_{perf_to_khz|khz_to_perf}()")
merged in v6.6.59 as 33e89c16cea0882bb05c585fa13236b730dd0efa

Vincent Guittot (8):
  sched/topology: Add a new arch_scale_freq_ref() method
  cpufreq: Use the fixed and coherent frequency for scaling capacity
  cpufreq/schedutil: Use a fixed reference frequency
  energy_model: Use a fixed reference frequency
  cpufreq/cppc: Set the frequency used for computing the capacity
  arm64/amu: Use capacity_ref_freq() to set AMU ratio
  topology: Set capacity_freq_ref in all cases
  sched/fair: Fix frequency selection for non-invariant case

 arch/arm/include/asm/topology.h   |  1 +
 arch/arm64/include/asm/topology.h |  1 +
 arch/arm64/kernel/topology.c      | 26 ++++++------
 arch/riscv/include/asm/topology.h |  1 +
 drivers/base/arch_topology.c      | 69 ++++++++++++++++++++-----------
 drivers/cpufreq/cpufreq.c         |  4 +-
 include/linux/arch_topology.h     |  8 ++++
 include/linux/cpufreq.h           |  1 +
 include/linux/energy_model.h      |  6 +--
 include/linux/sched/topology.h    |  8 ++++
 kernel/sched/cpufreq_schedutil.c  | 30 +++++++++++++-
 11 files changed, 111 insertions(+), 44 deletions(-)

-- 
2.20.1


