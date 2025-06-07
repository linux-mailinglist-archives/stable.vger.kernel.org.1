Return-Path: <stable+bounces-151837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E26AAD0E0B
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 17:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7DC83AF47A
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 15:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD371C5D59;
	Sat,  7 Jun 2025 15:23:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2497188CB1
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749309784; cv=none; b=COSLN6fguSpb7UH5SXwbwpKj9aPT2JdzsnykRFAo1UEyEQfefwrZOooehiaKsOoGcx1PfOdjiBRCBJz6xn2Upm1xexoaizslFKaYK7IoxRCSIRdbYvrbxxSKxN44CIOesPuhpTjPCNWML3GqW4HyDkuE/2+2d3OwtFAX3I6PAF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749309784; c=relaxed/simple;
	bh=4kX2mlvRWGcUf9X8ohB1l+O2JduQwzM2qmeWE3vjLso=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GcJXns9ioHaw1L1sS+DAsR0PIpho74vbF8jW66HAI5P6tNoLyEoUm7CP/qUfqIZXSk3voMiMO9H+1676xJhklV+qPY8RzNlIp5pjJBCxzPvY1HAk/gA7MayNKZpcjQN0xTsEdAkd+vkyQWfqfbFzFvenvCM4BsoUqRtcOgxZ6jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bF24b4LgkzYQtsV
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 23:22:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 9F8861A1293
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 23:22:54 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgB3ycNKWURof5hIOg--.36463S2;
	Sat, 07 Jun 2025 23:22:51 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: stable@vger.kernel.org
Cc: james.morse@arm.com,
	catalin.marinas@arm.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	xukuohai@huawei.com,
	pulehui@huawei.com
Subject: [PATCH 5.10 00/14] backport for CVE-2025-37948 and CVE-2025-37963
Date: Sat,  7 Jun 2025 15:25:07 +0000
Message-Id: <20250607152521.2828291-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgB3ycNKWURof5hIOg--.36463S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cry5Jry7KFW8Wr47tF13urg_yoW8tr1kpa
	1rC3W3CrWkWFyfA343X3s7GF1F9ayrtr43Wryjk34kK3yYvr1Fgr1fKFyDKrs2yFyxtayj
	vr4qvr15GF4kX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
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

Douglas Anderson (3):
  arm64: errata: Assume that unknown CPUs _are_ vulnerable to Spectre
    BHB
  arm64: errata: Add KRYO 2XX/3XX/4XX silver cores to Spectre BHB safe
    list
  arm64: errata: Add newer ARM cores to the spectre_bhb_loop_affected()
    lists

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

Julien Thierry (1):
  arm64: insn: Add barrier encodings

Liu Song (1):
  arm64: spectre: increase parameters that can be used to turn off bhb
    mitigation individually

Will Deacon (1):
  arm64: errata: Add missing sentinels to Spectre-BHB MIDR arrays

 .../admin-guide/kernel-parameters.txt         |   5 +
 arch/arm64/include/asm/cputype.h              |   2 +
 arch/arm64/include/asm/debug-monitors.h       |  12 -
 arch/arm64/include/asm/insn.h                 | 114 +++++++++-
 arch/arm64/include/asm/spectre.h              |   4 +-
 arch/arm64/kernel/insn.c                      | 199 +++++++++++++++--
 arch/arm64/kernel/proton-pack.c               | 206 +++++++++++-------
 arch/arm64/net/bpf_jit.h                      |  11 +-
 arch/arm64/net/bpf_jit_comp.c                 |  58 ++++-
 9 files changed, 488 insertions(+), 123 deletions(-)

-- 
2.34.1


