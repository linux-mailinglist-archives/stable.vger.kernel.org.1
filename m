Return-Path: <stable+bounces-81256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0632F992B10
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 14:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6368283DB6
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 12:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D58F1D1E87;
	Mon,  7 Oct 2024 12:06:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B0F18B483
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 12:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302807; cv=none; b=dZi50DBENfSqacBejiIyJZg/zP50ZdYikfeVhaigTJc3Ht569izRu3mzKUpeX4htb4lLKna8o6myfZUR08ZZ7NXAPae+wUrOuVmgo6Tu30VVXpxUQt5vZ8FI/bpSGdMbzsypvRvMKzqRrNyJzFpISEMgH8It7Fq8zpYF+mBl1Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302807; c=relaxed/simple;
	bh=ee0mb7BeBtY4ldvfVFIj/WKNOV7b0JqboG4zuMDjG5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SC8INW3DN2qRvUHJiT7bl04QtshdMLfI00vamdXFMj2CN+bHLjGw+5lsy8kv7xSTiWJwfnB67yv2PA0Ys98ka8BGDPYO2nbPLS9Y8KXeAKvGJwWwdWPH9E7330Q+p+i0q+TLQmPWcUMIfjGNDnhUbm6D2V19bFMy1/bpjTk7SI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D744FEC;
	Mon,  7 Oct 2024 05:07:15 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 685853F640;
	Mon,  7 Oct 2024 05:06:44 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: catalin.marinas@arm.com,
	eahariha@linux.microsoft.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	will@kernel.org
Subject: [PATCH 6.10 0/3] arm64: errata: Expand speculative SSBS workaround once more
Date: Mon,  7 Oct 2024 13:06:36 +0100
Message-Id: <20241007120639.547444-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is a v6.10.y only backport (based on v6.10.13) of the recent
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


