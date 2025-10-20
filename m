Return-Path: <stable+bounces-188007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 312ADBF0280
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 11:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9B844F1048
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 09:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D352F5A14;
	Mon, 20 Oct 2025 09:26:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52DE2E972E;
	Mon, 20 Oct 2025 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760952370; cv=none; b=Dp57GvwXZmS1r5HMfvepFouIEb2Y0yw4/d1p/wSHaEf2dBspMz1KBubUaVW1Ak20Al9LCLQWizSd4LX+T/gkYCnaAH7ENM+Q44BHigriXGdlhdFvOQbPxbgWjfikfmoJK9MBTrybqbM5sOhISiKpDVi/eIsygO9Dy2O6Fxpjppc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760952370; c=relaxed/simple;
	bh=VlK4pbHtdxuCcU3EC1hLI4n4MuD5ZK/hEeTodvq6FAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LPL81TeH1aeKkjkh8PYP6k91jkS67Hyki1TiqeRZuTiwvcLK/ri8erFcdBcDshknyOUZKgOCY/EJSQA/v31yZQtyJ6q5NhhPxsGM1eXgNW/Z6XZHdulWcgUyMTDj/mcgAOW9RnYRyw4oyXu9witq8enJuyD0qSxgfGnKw87jKOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DE341063;
	Mon, 20 Oct 2025 02:25:58 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 126FE3F66E;
	Mon, 20 Oct 2025 02:26:04 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: stable@vger.kernel.org
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.4-5.10 0/2] arm64: errata: Apply workarounds for Neoverse-V3AE
Date: Mon, 20 Oct 2025 10:25:51 +0100
Message-ID: <20251020092555.591819-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This series is a backport that applies to stable kernels 5.4 and 5.10, of the
recent errata workarounds for Neoverse-V3AE, which were originally posted at:

  https://lore.kernel.org/all/20250919145832.4035534-1-ryan.roberts@arm.com/

... and were originally merged upstream in v6.18-rc1.

Thanks,
Ryan

Mark Rutland (2):
  arm64: cputype: Add Neoverse-V3AE definitions
  arm64: errata: Apply workarounds for Neoverse-V3AE

 Documentation/arm64/silicon-errata.rst | 2 ++
 arch/arm64/Kconfig                     | 1 +
 arch/arm64/include/asm/cputype.h       | 2 ++
 arch/arm64/kernel/cpu_errata.c         | 1 +
 4 files changed, 6 insertions(+)

--
2.43.0


