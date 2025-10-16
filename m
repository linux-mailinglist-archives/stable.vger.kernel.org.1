Return-Path: <stable+bounces-186002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9114ABE304E
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C0384FFBE1
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 11:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C573081D5;
	Thu, 16 Oct 2025 11:12:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A953D261B60;
	Thu, 16 Oct 2025 11:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760613141; cv=none; b=kPz3eW3DsTKfBe/WtkE1oE13oftjMjHNYjUYZFJ9/uedheXdoP0P6IuJd3awbhbxZiut53WBiACbTlbM+flKwOLbbL/LcCCpRpCxELLsHGgbZh0f8fr6cuSWGc9/AVNpvuBp//KvKaCxaHykalgRvevYWY3JN6kMsirh6VFu6RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760613141; c=relaxed/simple;
	bh=4BeoCGQkStDeuZLfd/henBCuCWg8sFQzH1BA+rp0Cow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m2dvRXXmRxmPlG7Dzmm3sDdLWsJnHHq8Is4hdU9H5/DmvrG7z3RL4ryGVkFHJcRV1CywGrp248CDjqRF4pahnH59hgXGIeAPCQKUkMkkeWXXbpq73oXb9nGDEhpUNSpvomx5v4XrK8MLxOyVcE31WD4FEe4FKpHjEShKptkQgpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C14631688;
	Thu, 16 Oct 2025 04:12:09 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D5E33F6A8;
	Thu, 16 Oct 2025 04:12:16 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: stable@vger.kernel.org
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.4-6.17 0/2] arm64: errata: Apply workarounds for Neoverse-V3AE
Date: Thu, 16 Oct 2025 12:12:04 +0100
Message-ID: <20251016111208.3983300-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This series is a backport intended for all supported stable kernels (5.4-6.17)
of the recent errata workarounds for Neoverse-V3AE, which were originally posted
at:

  https://lore.kernel.org/all/20250919145832.4035534-1-ryan.roberts@arm.com/

... and were originally merged upstream in v6.18-rc1.

I've tested that these patches apply to 5.4-6.12 without issue, but there is a
trivial conflict to resolve in silicon-errata.rst for it to apply to 6.16 and
6.17. Are you happy to deal with that or should I send a separate series?

Thanks,
Ryan

Mark Rutland (2):
  arm64: cputype: Add Neoverse-V3AE definitions
  arm64: errata: Apply workarounds for Neoverse-V3AE

 Documentation/arch/arm64/silicon-errata.rst | 2 ++
 arch/arm64/Kconfig                          | 1 +
 arch/arm64/include/asm/cputype.h            | 2 ++
 arch/arm64/kernel/cpu_errata.c              | 1 +
 4 files changed, 6 insertions(+)

--
2.43.0


