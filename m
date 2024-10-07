Return-Path: <stable+bounces-81264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5BE992B37
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 14:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 229D3B23647
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 12:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7831D2715;
	Mon,  7 Oct 2024 12:12:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C575E1D26EA;
	Mon,  7 Oct 2024 12:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303177; cv=none; b=go30NcURWNpIjpfm1PBzM10l5gGTFR0gJjWjnle+DGxW2O6lN2/f+AP2R522GekkHqBWUBp/1K8DF7dnHBrg6rVPG/Vfxf3IwtD0O1E2HY2wr9Ls0iYgInquUB+MG8GtJpMzbw0dhfopRbVXAkDmlw0vlrbWuMJMGKnB1qnOXYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303177; c=relaxed/simple;
	bh=rwYxoCC1WMrcufUms44Hr060jiw3mxuKA9IJ5lJcqME=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VP1Wapwextx85ZRomnnYUWwp6BlllK1+McpP5Cd9uGrnSkZkzu7kACB1EPQykExD/e+QX1TzdFzKcSMn3f6irqKILPOSwNUOuwwTrSA4dmGZuV26lGS+PlyZ0FUTWICTGF4mciuI99Z8J3knJTR/fiSCtSGOVAQCyNcRoJsfMz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5024FEC;
	Mon,  7 Oct 2024 05:13:24 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C9E143F640;
	Mon,  7 Oct 2024 05:12:53 -0700 (PDT)
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
Subject: [PATCH 6.1 0/3] arm64: errata: Expand speculative SSBS workaround once more
Date: Mon,  7 Oct 2024 13:12:46 +0100
Message-Id: <20241007121249.548113-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is a v6.1 only backport (based on v6.1.112) of the recent MIDR
updates for the speculative SSBS workaround, which were originally posted at:

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


