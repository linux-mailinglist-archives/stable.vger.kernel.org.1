Return-Path: <stable+bounces-134946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B76D5A95B83
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514C9176AD9
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A44025E812;
	Tue, 22 Apr 2025 02:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvrFtDBd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468FD25E47D;
	Tue, 22 Apr 2025 02:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288254; cv=none; b=I3494+ys/hCeb7g4d7eaLlzITzny9q4yQjEaXE/KNsQh9rT0sJUt3icVj735IlXRXMoGmBCcosN77XfliWXeCIdFC+jEIu60j8O5CZz+sCAj54fhbSDcVAIvr+JxZ066SNKUaOKie6/61bwFt5cNQRd1YxIf+umMQ2wTSICkSVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288254; c=relaxed/simple;
	bh=aa1A2mSz9WINcgudlJitBlD+EzdY8YT96sD7O0GzGi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hxjROf0azPhoaA/WkxaZYv9EXlr4hS9mPPbetluI64cpNk7MGumMJqj+dqLds8C/xg29QTzKMav3Ngerg/kYCaxbdgy5KSKf2bwS4TEuxRalAnojf5ouJtfclbhlgZ/i/QPRAZim3NF2inN6TLz7vs1c6HbD5eust+HvlvLJbNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvrFtDBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC71C4CEEE;
	Tue, 22 Apr 2025 02:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288254;
	bh=aa1A2mSz9WINcgudlJitBlD+EzdY8YT96sD7O0GzGi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AvrFtDBdZDGPr6qsdY08i3D3gRlMRXoee1vSc1EhgNmvxkTuGlTNcr+lZZPiHySa1
	 pDWn0urckhSRZC/J0E7YWNtIGqa6YAoHsTH/7+QXBlIrbWVUQ8sUwqzsbq1VK8GY88
	 UdIr6R4n4ldjPgJwqf6/DhOl5c+C1t9iifE50nJrxEXfPdg5/dqAQX3TU8dl/mVV+U
	 VeCs5v4flQ6cLlCYiNWHJdy3rLpCaFZViMjnFryikz70wokXmhCgPKokd/pHLehiMR
	 c1fgGNz/lU5zOfxNabgrIPLHSv46KUmJwQT0dnWdRihOOm1uRnNX0t6Y+EN8A0SIHG
	 sjv3OJ60pTEig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pi Xiange <xiange.pi@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Christian Ludloff <ludloff@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tony Luck <tony.luck@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	x86-cpuid@lists.linux.dev,
	Sasha Levin <sashal@kernel.org>,
	x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Subject: [PATCH AUTOSEL 6.12 18/23] x86/cpu: Add CPU model number for Bartlett Lake CPUs with Raptor Cove cores
Date: Mon, 21 Apr 2025 22:16:58 -0400
Message-Id: <20250422021703.1941244-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021703.1941244-1-sashal@kernel.org>
References: <20250422021703.1941244-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.24
Content-Transfer-Encoding: 8bit

From: Pi Xiange <xiange.pi@intel.com>

[ Upstream commit d466304c4322ad391797437cd84cca7ce1660de0 ]

Bartlett Lake has a P-core only product with Raptor Cove.

[ mingo: Switch around the define as pointed out by Christian Ludloff:
         Ratpr Cove is the core, Bartlett Lake is the product.

Signed-off-by: Pi Xiange <xiange.pi@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Christian Ludloff <ludloff@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: x86-cpuid@lists.linux.dev
Link: https://lore.kernel.org/r/20250414032839.5368-1-xiange.pi@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/intel-family.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 1a42f829667a3..62d8b9448dc5c 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -115,6 +115,8 @@
 #define INTEL_GRANITERAPIDS_X		IFM(6, 0xAD)
 #define INTEL_GRANITERAPIDS_D		IFM(6, 0xAE)
 
+#define INTEL_BARTLETTLAKE		IFM(6, 0xD7) /* Raptor Cove */
+
 /* "Hybrid" Processors (P-Core/E-Core) */
 
 #define INTEL_LAKEFIELD			IFM(6, 0x8A) /* Sunny Cove / Tremont */
-- 
2.39.5


