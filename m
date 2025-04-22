Return-Path: <stable+bounces-134920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A33A95B33
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDE53AC36E
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934D824EF6F;
	Tue, 22 Apr 2025 02:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0jZ0Upx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDFF24C664;
	Tue, 22 Apr 2025 02:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288191; cv=none; b=kUGl78ln+vGgnctPVZOlfLkkmUZteRY2+GY6EgEAutMksE3+UuWZnYUpJE2SIddse/qr8VJyvasyvYWrY8L4WTr67MAqYmIH8F8lpztBIjoraNCJvvGtx1yZK2YwqPJY66diZGfCmTSUAeKHZj9YSPlyl2asxggzLYE5BYNkIcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288191; c=relaxed/simple;
	bh=BHpfc/S9C0le1JKbMWpHG10wMqwtDyGvp4bw7ETO/Uk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QrlxUyKgh8bxg1ibubONY32Vpfu3z6mmeqbxOrOomwXz7PGNTplSrSSiR3LEmqIE8yhFgEd3VQOVA8jXvqTHauWdQ3ZV3ibD2TW3JXhvBmVJFIhmJcvBd7ElKB9Q0xf9OXiRK3IMhjJCuaY2qRE5OyZpDwpSV4hK/pU/+BCH/gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0jZ0Upx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D142FC4CEED;
	Tue, 22 Apr 2025 02:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288190;
	bh=BHpfc/S9C0le1JKbMWpHG10wMqwtDyGvp4bw7ETO/Uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X0jZ0UpxuAg213BfUZ0ceUV690dEiEOVdzHrSTuBYNKB/gFYRsm298oXZi00Sf+dG
	 q9GRkpG7LoWDkZJtDMFvpVlZ3Yk0ptNST/IEqLqdVtzdpeJZmC6+VUcPoYEI/S6jii
	 jTo7CZSY8utXg0Nf901PGSIiDhTfj2/5Qqpb4PvqOvF2zXEgUPeRFxSAe4rXllQkLI
	 a6SQ9/obnoaQw2Mm/uVpoSg37tlKg0Q2PUovTzvimV9ijul3uPmD686SoyETZeHy9h
	 JPg0WUskgPMAFL+mIdOKRxjkhVIh3pjpfYX9eR9gvDcfWG9qxIhwBgOxKugatVfBFq
	 ddT4woWdOr8Qw==
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
Subject: [PATCH AUTOSEL 6.14 22/30] x86/cpu: Add CPU model number for Bartlett Lake CPUs with Raptor Cove cores
Date: Mon, 21 Apr 2025 22:15:42 -0400
Message-Id: <20250422021550.1940809-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021550.1940809-1-sashal@kernel.org>
References: <20250422021550.1940809-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.3
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
index 6d7b04ffc5fd0..ef5a06ddf0287 100644
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


