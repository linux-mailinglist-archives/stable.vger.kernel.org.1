Return-Path: <stable+bounces-151849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6661AD0E21
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 17:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936AA188F600
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 15:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376A61E22E9;
	Sat,  7 Jun 2025 15:33:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51AF1362
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749310390; cv=none; b=Drf1hIYqGr2tLxESaiDAlwCEJk1DfnpWVGT5Layq+csjRd+UZkcZkgWTugyZtNRQUzsF5ba0uG20bk3phsivqJkCjF0CBQUthGrEiYXvdkhr7G+9c8+1eplmfd/tQurGpHJO89Lr6hhn2epoXBanBCJSNgJbPFXdMrMStTv+pfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749310390; c=relaxed/simple;
	bh=Uc25UzNY4qMg2Jg1k4cnIdycKULzdqII6wky9bj0PsE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RLB+yapk9eqwaWHs3zIPsDMumvHQKz12Zt9xQGzGpGi0vbGynQK6rE6rSih3pXdEdW0kYxhYS/G5S43suUF5poFunvLKduIvEj0QROczpzFMVg7s3QEQ5JXZeM3zSKb8oGNd+WUSdyNzuRPycpyscLyJRwJ1OOzWs4J6MYKguM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bF2JM3rL8zKHN0J
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 23:33:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id E16311A15C5
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 23:33:05 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgBH5sCwW0Rod05JOg--.5386S2;
	Sat, 07 Jun 2025 23:33:05 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: stable@vger.kernel.org
Cc: james.morse@arm.com,
	catalin.marinas@arm.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	xukuohai@huawei.com,
	pulehui@huawei.com
Subject: [PATCH 5.15 0/9] backport for CVE-2025-37948 and CVE-2025-37963
Date: Sat,  7 Jun 2025 15:35:26 +0000
Message-Id: <20250607153535.3613861-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBH5sCwW0Rod05JOg--.5386S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cry5Jry7KFW8WF18KrW3ZFb_yoW8Cr1Upa
	n5u3W3Gw4kWFyfA343X397CF1Fvan5trW5WryUK34DK3Z0vr1Fgr1FgF90krs2kF1Iqayj
	vr4qvr1rGF1kZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0x
	vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv
	6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IUbiF4tUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

The backport mainly refers to the merge tag [0], and the corresponding patches are:

arm64: proton-pack: Add new CPUs 'k' values for branch mitigation
arm64: bpf: Only mitigate cBPF programs loaded by unprivileged users
arm64: bpf: Add BHB mitigation to the epilogue for cBPF programs
arm64: proton-pack: Expose whether the branchy loop k value
arm64: proton-pack: Expose whether the platform is mitigated by firmware
arm64: insn: Add support for encoding DSB

Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.15&id=627277ba7c2398dc4f95cc9be8222bb2d9477800 [0]

Hou Tao (2):
  arm64: move AARCH64_BREAK_FAULT into insn-def.h
  arm64: insn: add encoders for atomic operations

James Morse (6):
  arm64: insn: Add support for encoding DSB
  arm64: proton-pack: Expose whether the platform is mitigated by
    firmware
  arm64: proton-pack: Expose whether the branchy loop k value
  arm64: bpf: Add BHB mitigation to the epilogue for cBPF programs
  arm64: bpf: Only mitigate cBPF programs loaded by unprivileged users
  arm64: proton-pack: Add new CPUs 'k' values for branch mitigation

Liu Song (1):
  arm64: spectre: increase parameters that can be used to turn off bhb
    mitigation individually

 .../admin-guide/kernel-parameters.txt         |   5 +
 arch/arm64/include/asm/cputype.h              |   2 +
 arch/arm64/include/asm/debug-monitors.h       |  12 --
 arch/arm64/include/asm/insn-def.h             |  14 ++
 arch/arm64/include/asm/insn.h                 |  81 ++++++-
 arch/arm64/include/asm/spectre.h              |   3 +
 arch/arm64/kernel/proton-pack.c               |  21 +-
 arch/arm64/lib/insn.c                         | 199 ++++++++++++++++--
 arch/arm64/net/bpf_jit.h                      |  11 +-
 arch/arm64/net/bpf_jit_comp.c                 |  58 ++++-
 10 files changed, 366 insertions(+), 40 deletions(-)

-- 
2.34.1


