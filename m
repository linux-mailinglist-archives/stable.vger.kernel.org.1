Return-Path: <stable+bounces-81260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0947992B1A
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 14:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C89EB23226
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 12:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502AC1D1F54;
	Mon,  7 Oct 2024 12:08:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23D618B483
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 12:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302909; cv=none; b=k6Uds83riFsRph+CRDNDiJoOsEh6SwSg5+XliW5OY57bSfD6AuAyeHcOftvx/WrgSQc40hFLCjra2UtipnNP+39GImA7rMawz6QyjcETqc4+surIBQ9Jh24cD0sTYWXjbnLNxj5tmVF0Fu4PHcOJMmLen7IEnpPUPSnHvh+Qp5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302909; c=relaxed/simple;
	bh=7alOTSP+bGUdQ6gnaoPuf2RSL/NzFpySAhucgNOoMFE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pRFzyleu06UxpNPQPnOBwJvPVpr8gLai5gw9HsE0K69VsRfWxnihngCF50vAKHLFdLrXn5efv1JiZfWX1vEWztWbvU+Qr1q8RyiBqLgdpPumHgc7Bu7hDP8Efx6RH39XDRophY22p7pccnr0tME/nQmhaYPozjL8ebB4mHZKrhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2EA1FEC;
	Mon,  7 Oct 2024 05:08:56 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 413E43F640;
	Mon,  7 Oct 2024 05:08:26 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: catalin.marinas@arm.com,
	eahariha@linux.microsoft.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	will@kernel.org
Subject: [PATCH 6.6 0/3] arm64: errata: Expand speculative SSBS workaround once more
Date: Mon,  7 Oct 2024 13:08:19 +0100
Message-Id: <20241007120822.547619-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is a v6.6.y only backport (based on v6.6.54) of the recent
MIDR updates for the speculative SSBS workaround, which were originally
posted at:

  https://lore.kernel.org/linux-arm-kernel/20240930111705.3352047-1-mark.rutland@arm.com/
  https://lore.kernel.org/linux-arm-kernel/20241003225239.321774-1-eahariha@linux.microsoft.com/

... and were originally merged upstream in v6.12-rc2.

This series does not apply to earlier stable trees, which will receive a
separate backport.

Mark.
Easwar Hariharan (1):
  arm64: Subscribe Microsoft Azure Cobalt 100 to erratum 3194386

Mark Rutland (2):
  arm64: cputype: Add Neoverse-N3 definitions
  arm64: errata: Expand speculative SSBS workaround once more

 Documentation/arch/arm64/silicon-errata.rst | 6 ++++++
 arch/arm64/Kconfig                          | 2 ++
 arch/arm64/include/asm/cputype.h            | 2 ++
 arch/arm64/kernel/cpu_errata.c              | 3 +++
 4 files changed, 13 insertions(+)

-- 
2.30.2


