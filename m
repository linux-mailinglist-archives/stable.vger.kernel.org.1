Return-Path: <stable+bounces-81272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6C4992B5E
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 14:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9731F24428
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 12:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433CB1D0F78;
	Mon,  7 Oct 2024 12:17:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5711381B1;
	Mon,  7 Oct 2024 12:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303436; cv=none; b=q75695lWnmD2urvuPFhWLwyuRbwhECgKjjq1kJjmPFwfG82O93A669gaDggFVJkSyJw3vBpd17e5dTtKtPqkS1I5wkWPgcORJt/EL26soAFndsrXLpHRzKQH/sY3u862BZCfWYx3SknGlYMXq1OinNUYhGDQ+Sv8aRYt8w0kHkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303436; c=relaxed/simple;
	bh=A3EquIChSA+4FcpKYZ5PMjmBMfZ7XbrjjQRXzq/imms=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B4FiEC0wQ1Ectv6Af5Jp7Z85/NPVm1hbcaZ2F9rZak1/jrfbpGawVadRN/ED2q/kJ/s8FybQ2KXL6A6/Ybjxz+r/Fa8tIBX6DPH7kS2GAboQhCz409bh1CfCf+xnImRzdrNTn2vuKXlaM80bgEerRJMCGJbouinesdMxjd6RVlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFFC5FEC;
	Mon,  7 Oct 2024 05:17:43 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0592E3F640;
	Mon,  7 Oct 2024 05:17:12 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	james.morse@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	suzuki.poulose@arm.com,
	will@kernel.org
Subject: [PATCH 5.10 0/3] arm64: errata: Expand speculative SSBS workaround once more
Date: Mon,  7 Oct 2024 13:17:06 +0100
Message-Id: <20241007121709.548505-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is a v5.10.y only backport (based on v5.10.226) of the
recent MIDR updates for the speculative SSBS workaround, which were
originally posted at:

  https://lore.kernel.org/linux-arm-kernel/20240930111705.3352047-1-mark.rutland@arm.com/

... and were originally merged upstream in v6.12-rc2.

The Cortex-A715 cputype definitions (which were originally merged
upstream in v6.2) are backported as a prerequisite.

This series does not apply to earlier stable trees, which will receive a
separate backport.

Mark.

Anshuman Khandual (1):
  arm64: Add Cortex-715 CPU part definition

Mark Rutland (2):
  arm64: cputype: Add Neoverse-N3 definitions
  arm64: errata: Expand speculative SSBS workaround once more

 Documentation/arm64/silicon-errata.rst | 4 ++++
 arch/arm64/Kconfig                     | 2 ++
 arch/arm64/include/asm/cputype.h       | 4 ++++
 arch/arm64/kernel/cpu_errata.c         | 2 ++
 4 files changed, 12 insertions(+)

-- 
2.30.2


