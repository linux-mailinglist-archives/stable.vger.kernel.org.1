Return-Path: <stable+bounces-11331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FD182ED54
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 12:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5471F241C5
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 11:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9351A5BB;
	Tue, 16 Jan 2024 11:02:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9AE1AAA3
	for <stable@vger.kernel.org>; Tue, 16 Jan 2024 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DCC8FEC;
	Tue, 16 Jan 2024 03:03:20 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 251723F6C4;
	Tue, 16 Jan 2024 03:02:26 -0800 (PST)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	robh@kernel.org,
	stable@vger.kernel.org,
	will@kernel.org
Subject: [PATCH 0/2] arm64: fix+cleanup for ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
Date: Tue, 16 Jan 2024 11:02:19 +0000
Message-Id: <20240116110221.420467-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

While testing an unrelated patch on the arm64 for-next/core branch, I
spotted an issue in the ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
workaround. The first patch fixes that issue, and the second patch
cleans up the remaining logic.

The issue has existed since the workaround was introduced in commit:

  471470bc7052d28c ("arm64: errata: Add Cortex-A520 speculative unprivileged load workaround")

As that logic has recently been reworked in the arm64 for-next/core
branch, these patches are based atop that rework, specifically atop
commit:

  546b7cde9b1dd360 ("arm64: Rename ARM64_WORKAROUND_2966298")

As the patches alter the KPTI exception return logic, I've given this
testing with KPTI forced on, forced off, and disabled at build time,
which all appear to be fine. I don't have any hardware requiring the
ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD workaround, but as the
resulting logic for this is very simple I do not expect any issues with
that part of the logic.

Mark.

Mark Rutland (2):
  arm64: entry: fix ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
  arm64: entry: simplify kernel_exit logic

 arch/arm64/kernel/entry.S | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

-- 
2.30.2


