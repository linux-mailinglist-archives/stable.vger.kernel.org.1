Return-Path: <stable+bounces-188023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A72DBF0358
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 11:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D29E93E3201
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 09:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE472F5334;
	Mon, 20 Oct 2025 09:36:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5542F6189;
	Mon, 20 Oct 2025 09:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953003; cv=none; b=pQgon+ZEKAEkeYmMGz3eNJpvg9x35tgekZnkLl2nxcXtVO8orJRlRLnD5uLBGfqmwFuFuHpAZYtpJMLxcxkse0VsIEXa4U7IlTPe/cWuOedte1JQn/LeutcfhkFyD+INYUn+bkT0MGbYcdqPLwTEiMhw4MBtplpv3jtPc39MJP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953003; c=relaxed/simple;
	bh=joXj06w73n0rY+/d9F0e5Np2WtABBHUJvjrkLlwZTLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lFGP1/7RcBO8qBjxDSUymR+54FY1/I66+99Z2wxkCOMuwF6A4hGwchsMrXZmjgGAHpm8tuB2LB9PaBFJP3KlMvJiGEpbcw+xkECqh/T8/InCLwSwHbK5QrceMpl9rtOYn3nbaoHbcUD4t5jpUzyQ/694WfUPNwzEupZupNS/5i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 503BD1063;
	Mon, 20 Oct 2025 02:36:31 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FA903F66E;
	Mon, 20 Oct 2025 02:36:38 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: stable@vger.kernel.org
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 6.16-6.17 0/2] arm64: errata: Apply workarounds for Neoverse-V3AE
Date: Mon, 20 Oct 2025 10:36:24 +0100
Message-ID: <20251020093628.592682-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This series is a backport that applies to stable kernels 6.16 and 6.17, of the
recent errata workarounds for Neoverse-V3AE, which were originally posted at:

  https://lore.kernel.org/all/20250919145832.4035534-1-ryan.roberts@arm.com/

... and were originally merged upstream in v6.18-rc1.

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


