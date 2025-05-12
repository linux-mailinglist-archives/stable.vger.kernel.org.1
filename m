Return-Path: <stable+bounces-143864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B02AB4248
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE4A168CE5
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA2E2C032E;
	Mon, 12 May 2025 18:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eRPQPI3a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD052C0320;
	Mon, 12 May 2025 18:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073140; cv=none; b=hn6HGu9WULIcUraVIiB08BUE2OU8UdhSN288a/m0V+nYahT25/iaQ7hFBegyVCWA/9Dj+76Vmuj6sqrZ2yD7rbVJjnc+bCu7O6WkT1b2E7ddGcE+r6YLa1mZVe8r/3F4nCW7MZLVXTAN9jrbHPUUVuZpS4fcSZ9DeJUE38ivEA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073140; c=relaxed/simple;
	bh=sZHtw8Cf8o3Rl+ZjpFBT/A3rY838orpQP73sXYSLYAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7IDODYGGwg1JLqDfcpRToKHKEDJajzX9aOIabZZFr+oQQ5jtuN7yjOxij/pBzvR3nf1S+RZ4A8R5N9I+bdbJ7wAFzMXpzHH6oWyEQxqHaJgWiIqI9pphEITb43FliXCfZYxoy+AQVdz1GJQCq78aPLWXIW9427Z0eWJcbBro2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eRPQPI3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128F1C4CEE7;
	Mon, 12 May 2025 18:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747073139;
	bh=sZHtw8Cf8o3Rl+ZjpFBT/A3rY838orpQP73sXYSLYAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eRPQPI3aLI8KCM1U6V8G5xbg3p6uhf5Tc6ci1Qav9OEuitRbj9RIK80Lie9+WziJR
	 gxgPIRAhu4OD2hJ0yrn772jCyyBi+JJsRxYjrcwdG4rlWcvsgOgqxeab8WN1K8VAzf
	 rkS+6QrlGHI5BGStofGvV/0uYHqVhMgIPUYoyJeg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	James Morse <james.morse@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 6.12 167/184] arm64: proton-pack: Add new CPUs k values for branch mitigation
Date: Mon, 12 May 2025 19:46:08 +0200
Message-ID: <20250512172048.615123622@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172041.624042835@linuxfoundation.org>
References: <20250512172041.624042835@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Morse <james.morse@arm.com>

commit efe676a1a7554219eae0b0dcfe1e0cdcc9ef9aef upstream.

Update the list of 'k' values for the branch mitigation from arm's
website.

Add the values for Cortex-X1C. The MIDR_EL1 value can be found here:
https://developer.arm.com/documentation/101968/0002/Register-descriptions/AArch>

Link: https://developer.arm.com/documentation/110280/2-0/?lang=en
Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/cputype.h |    2 ++
 arch/arm64/kernel/proton-pack.c  |    1 +
 2 files changed, 3 insertions(+)

--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -81,6 +81,7 @@
 #define ARM_CPU_PART_CORTEX_A78AE	0xD42
 #define ARM_CPU_PART_CORTEX_X1		0xD44
 #define ARM_CPU_PART_CORTEX_A510	0xD46
+#define ARM_CPU_PART_CORTEX_X1C		0xD4C
 #define ARM_CPU_PART_CORTEX_A520	0xD80
 #define ARM_CPU_PART_CORTEX_A710	0xD47
 #define ARM_CPU_PART_CORTEX_A715	0xD4D
@@ -166,6 +167,7 @@
 #define MIDR_CORTEX_A78AE	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78AE)
 #define MIDR_CORTEX_X1	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X1)
 #define MIDR_CORTEX_A510 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A510)
+#define MIDR_CORTEX_X1C MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X1C)
 #define MIDR_CORTEX_A520 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A520)
 #define MIDR_CORTEX_A710 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A710)
 #define MIDR_CORTEX_A715 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A715)
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -891,6 +891,7 @@ static u8 spectre_bhb_loop_affected(void
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A78AE),
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A78C),
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_X1),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_X1C),
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_X2),
 		MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),



