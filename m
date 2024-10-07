Return-Path: <stable+bounces-81252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D89F992B02
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 14:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8A551F2356E
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 12:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10FD1B78F3;
	Mon,  7 Oct 2024 12:04:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16E118B483
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 12:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302668; cv=none; b=HrVMpm/LzfnNr/bUUnYEvSdGA0dJLHq7acb5osJAlas7Gwr183AJ+2DqEORCE0dGq8cFCPoxQ1UI186E8DEYWO4AsXfNdEj7OWXzqhq0rYYM5bxEqlQZLvqoInThu0vuU0f01VV7WRN1Pnc+841ORYLSH3agwypjV2eqUbx9m4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302668; c=relaxed/simple;
	bh=OIMh/O7dwpcn9AvxJYkbhEMxVEejnIW8LRax8ZbF3WQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kDK0EKiKHBNE77Q2HiXc5iUygNfSfZrmtzCNtw2OxHNmYT2wVMFi2tWPt5RZ33sJnNgxOz/5tiWNyzCV3N1Utdq00W9wlQdWd58et7rm8CA7o4JfhqzvFFddLgLc6KLzAua0TA5EyK2/PunAAZVG5J7PLOgyXHmUIMsoyDWO/DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E9CAFEC;
	Mon,  7 Oct 2024 05:04:55 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 91EE53F640;
	Mon,  7 Oct 2024 05:04:24 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: catalin.marinas@arm.com,
	eahariha@linux.microsoft.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	will@kernel.org
Subject: [PATCH 6.11 0/3] arm64: errata: Expand speculative SSBS workaround once more
Date: Mon,  7 Oct 2024 13:04:18 +0100
Message-Id: <20241007120421.547274-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is a v6.11.y only backport (based on v6.11.2) of the recent MIDR
updates for the speculative SSBS workaround, which were originally posted at:

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


