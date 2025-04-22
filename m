Return-Path: <stable+bounces-134963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79881A95BB6
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF3C189873C
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2C6267381;
	Tue, 22 Apr 2025 02:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6ei8UkQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34679266F05;
	Tue, 22 Apr 2025 02:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288301; cv=none; b=gHQLrriVWfWgo6RYHTs7rxq4/vOyJiGRsZ0IwpjVu+BTHKZkP5ZqFom7pePVQc4dm6HayOVYnHESspRnquNlB3xs7DyPAH7SrixtRVvD4h4QsNEgH5woi42urZm6gwkqtwkL2ISBIp67U8o6JBG67bLNcUH2G554xJWQzcPZ9cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288301; c=relaxed/simple;
	bh=O+m1Kxfwp/lWgbsyzp5zqA4MZ2qMtE9NiXlS7BI0B9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LD5Yn3uH3vsoaWGLATrwwPkTPRJK8WRoV/b0N0JqUtORC/9Sxu/IU5EzpPryap1UoFTaNluMLP/T//K3D0TSiEsXC8IQ+8Noc9kD8Fli3lFUE6yS4AiJvLHb6ML/VM4xkcdOql7kij1iXTXYObe/51KXYwEVGD/76x4umvCA69Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6ei8UkQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C6EC4CEEC;
	Tue, 22 Apr 2025 02:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288301;
	bh=O+m1Kxfwp/lWgbsyzp5zqA4MZ2qMtE9NiXlS7BI0B9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s6ei8UkQBxPiVdKM+sTSTq0kt95F7orgM3ekcSs2K+SFZJnAytV2/TaPVSjtgw2lm
	 y5yIVzUrkbm8yV2lzxzXB/RTIbwpp+4gUERBlF4zLdPiueJ92W1+TYe9tLQp1CUy4d
	 RRF4FStTJ1UoAKtfwbM5NCDx21ZTdhH4exqAqLdSoemNdvohekz2rjvRbkuoNe1L7O
	 39hRCB2P8OeqtTCjCUp8a3WPX61YA2Iq9yQ2rMIli79GJsRD+Ro18QUx1A38VDKf+H
	 tni2pEv1CL5q46uUWal155lsboLCF4pyvWeAPSlVFiK1BDAjGIprZbrLNAbOyCujEY
	 FjPucNE2z8BWg==
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
Subject: [PATCH AUTOSEL 6.6 12/15] x86/cpu: Add CPU model number for Bartlett Lake CPUs with Raptor Cove cores
Date: Mon, 21 Apr 2025 22:17:56 -0400
Message-Id: <20250422021759.1941570-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021759.1941570-1-sashal@kernel.org>
References: <20250422021759.1941570-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.87
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
index f81a851c46dca..652c0137e909f 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -159,6 +159,8 @@
 #define INTEL_FAM6_GRANITERAPIDS_D	0xAE
 #define INTEL_GRANITERAPIDS_D		IFM(6, 0xAE)
 
+#define INTEL_BARTLETTLAKE		IFM(6, 0xD7) /* Raptor Cove */
+
 /* "Hybrid" Processors (P-Core/E-Core) */
 
 #define INTEL_FAM6_LAKEFIELD		0x8A	/* Sunny Cove / Tremont */
-- 
2.39.5


