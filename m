Return-Path: <stable+bounces-161967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 954E8B05A5C
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 14:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE2694A2FA2
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 12:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D310A2E03E6;
	Tue, 15 Jul 2025 12:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRa0+51G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CA5274670
	for <stable@vger.kernel.org>; Tue, 15 Jul 2025 12:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752583073; cv=none; b=Um/MgQIgnKWxyhIn/ngdBYiw23EIt3iwu3FnuP19Hz5HZDO1pSPKXRAA0PEuyZKwCA05QE4GfQbBZWVsCZmtGAdTf4qyepsHDtfn2hPYIQ+f++UZrtOwYfsIyhg91T6U1p9A5M9mxHHYgVVogROGW+PVwbLT2lSKLW/g3RsAnXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752583073; c=relaxed/simple;
	bh=IqsQI2EDdxDscLPQe3iVqKTFkx4b0uUUo+q9QU/mFhw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=n1zi1UCWMUdKPoDagCqF8AAAlHVJl3urDHfmaNvUohT1zHtDi1hc5MRf7myOqTTnktsS+OWWK9SIg6XfSXDr8JJB54t6nGhHkhVKtiySgud6euniovKhsMp0eIiQhZOOB6E3ubQN6hhV1gN2KA7l1bEfWZiMphf4HyebnHb+X5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRa0+51G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF2BC4CEE3;
	Tue, 15 Jul 2025 12:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752583073;
	bh=IqsQI2EDdxDscLPQe3iVqKTFkx4b0uUUo+q9QU/mFhw=;
	h=From:To:Subject:Date:From;
	b=SRa0+51GlB0MK67o7LDIp8nLSzHHAY9YXwXDJ0dXqxvS+BFr+JaESz5sOiZckh9aF
	 aKtgG21GWK5vAZwyCsS0N/SxrT3DEcz5zGGtuXX47uX4N8g9DPcCaNAe3mWbLdqcQl
	 iQxcADBN1bATfJ3KIDPZPDot3xJWt+FnC0BO7EAU1eQY/2NyswGFnvD27t3Bu8bGRo
	 xykW/c3RUmDop9kGHxvHlFbK5NZFoVKGdY0yNdCvmc7MY6VmTh1K7sorLoXd4PskUU
	 QWrQ+v6G+8SDRKGs1QvRDztTXoXfu+Od5/f01zNwSLEk/sarh0SIM8/elYfWpWFRJf
	 Y0fQb4+T6lAKA==
From: Borislav Petkov <bp@kernel.org>
To: <stable@vger.kernel.org>
Subject: [PATCH 0/5] TSA 5.10 backport
Date: Tue, 15 Jul 2025 14:37:44 +0200
Message-ID: <20250715123749.4610-1-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Hi,

this is a 5.10 backport of the AMD TSA mitigation.

It has been tested with the corresponding *upstream* qemu patches here:

https://lore.kernel.org/r/12881b2c03fa351316057ddc5f39c011074b4549.1752176771.git.babu.moger@amd.com

Thx.

Borislav Petkov (AMD) (4):
  x86/bugs: Rename MDS machinery to something more generic
  x86/bugs: Add a Transient Scheduler Attacks mitigation
  KVM: SVM: Advertise TSA CPUID bits to guests
  x86/process: Move the buffer clearing before MONITOR

Paolo Bonzini (1):
  KVM: x86: add support for CPUID leaf 0x80000021

 .../ABI/testing/sysfs-devices-system-cpu      |   1 +
 .../hw-vuln/processor_mmio_stale_data.rst     |   4 +-
 .../admin-guide/kernel-parameters.txt         |  13 ++
 arch/x86/Kconfig                              |   9 ++
 arch/x86/entry/entry.S                        |   8 +-
 arch/x86/include/asm/cpu.h                    |  13 ++
 arch/x86/include/asm/cpufeature.h             |   5 +-
 arch/x86/include/asm/cpufeatures.h            |   8 +-
 arch/x86/include/asm/disabled-features.h      |   2 +-
 arch/x86/include/asm/irqflags.h               |   4 +-
 arch/x86/include/asm/mwait.h                  |  19 ++-
 arch/x86/include/asm/nospec-branch.h          |  39 ++---
 arch/x86/include/asm/required-features.h      |   2 +-
 arch/x86/kernel/cpu/amd.c                     |  58 ++++++++
 arch/x86/kernel/cpu/bugs.c                    | 133 +++++++++++++++++-
 arch/x86/kernel/cpu/common.c                  |  14 +-
 arch/x86/kernel/process.c                     |  15 +-
 arch/x86/kvm/cpuid.c                          |  31 +++-
 arch/x86/kvm/cpuid.h                          |   1 +
 arch/x86/kvm/svm/vmenter.S                    |   3 +
 arch/x86/kvm/vmx/vmx.c                        |   2 +-
 drivers/base/cpu.c                            |   2 +
 include/linux/cpu.h                           |   1 +
 23 files changed, 339 insertions(+), 48 deletions(-)

-- 
2.43.0


