Return-Path: <stable+bounces-81280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3C2992B83
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 14:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133D11F2490F
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 12:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F421D26F1;
	Mon,  7 Oct 2024 12:20:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844B118A952;
	Mon,  7 Oct 2024 12:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303635; cv=none; b=LHmm2MHOrw0BvLKS4rJpdscvtntcSE7ygzkAH2t52n4ibviVfkW8ffimF7YPAGe61elzngMGffjT8EiiPodsmo7RDYE9XZPu8CJdptvnxD29QkL134gdiWyeLs/P27u1EzgB7n2Z7eM2CWxrXCesOshqP0vP0lcrbLgpQcgSAsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303635; c=relaxed/simple;
	bh=RosvRryno0BruJyqkuhZfczz/e8kf9/ZI4apYOw34FE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=usIDhb3AdruFRwI7cZ9UqjYlZvjh5SAQmonuWagZi5W+km3aUoxlgNOWI3Ss2U3CYgY7+DsFqL1k0hj01iksE4gdcfT/hMQzBzmP0iyAF1uC+F9XFqTTpx5ituHBqvTrcqOPef3jV2n+FvhSViqT6AthWjXD1NcJlVxkfsuijzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24146FEC;
	Mon,  7 Oct 2024 05:21:03 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 29E033F640;
	Mon,  7 Oct 2024 05:20:32 -0700 (PDT)
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
Subject: [PATCH 4.19 0/3] arm64: errata: Expand speculative SSBS workaround once more
Date: Mon,  7 Oct 2024 13:20:25 +0100
Message-Id: <20241007122028.548836-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is a v4.19 only backport (based on v4.19.322) of the recent
MIDR updates for the speculative SSBS workaround, which were originally
posted at:

  https://lore.kernel.org/linux-arm-kernel/20240930111705.3352047-1-mark.rutland@arm.com/

... and were originally merged upstream in v6.12-rc2.

The Cortex-A715 cputype definitions (which were originally merged
upstream in v6.2) are backported as a prerequisite.

Mark.

Anshuman Khandual (1):
  arm64: Add Cortex-715 CPU part definition

Mark Rutland (2):
  arm64: cputype: Add Neoverse-N3 definitions
  arm64: errata: Expand speculative SSBS workaround once more

 Documentation/arm64/silicon-errata.txt | 2 ++
 arch/arm64/Kconfig                     | 2 ++
 arch/arm64/include/asm/cputype.h       | 4 ++++
 arch/arm64/kernel/cpu_errata.c         | 2 ++
 4 files changed, 10 insertions(+)

-- 
2.30.2


