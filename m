Return-Path: <stable+bounces-43232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6A98BF060
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC1E281714
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD3B1304A3;
	Tue,  7 May 2024 22:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y70/XhEo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB5B130491;
	Tue,  7 May 2024 22:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122719; cv=none; b=WdYWElaJqBRDwJJGkjIzKVW6l/o7uw2isfH/g7lUk2q8qLaXCWbmrYNLElJg6wjnrwlYYDYdyCwgRLzXwvdbJ7AJ1A77h0Nwj4hcTW09yH8U0ki/kf6h5d/gR9YT0lH8oVl0YCmc7olpT+x8rBH3TcGSv7rWjPknyL5bmTcozxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122719; c=relaxed/simple;
	bh=JyGWNzf2bX/DbV0OLPxeQ4X+rfNpuJCLVzX52aXUeDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G3sZr7YK4HHMTcnGok4eDyhKyBK5PIisKlWPlwZyhzO+C6z/wTK02MOWbdthLFlvN4Yi2LzGWOcFf1GkHXAr1jYnjgLU9nnhm0KUlK9aCqf5+jyciVQj76WtnwzgiIgGEwZRJUD0CyU4F6wXk309eRwqw89PFHnmh0rnUnH2WW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y70/XhEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C699C3277B;
	Tue,  7 May 2024 22:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122718;
	bh=JyGWNzf2bX/DbV0OLPxeQ4X+rfNpuJCLVzX52aXUeDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y70/XhEotLIJZDe05ChMzbT+3B5smH+DlxKijEaWhGzW736cA/ftHuQx3XnAU+QZ+
	 sdDooQpcFmbBdM8sK1AN7m8GZIuqztK0BClAsZEWmNSpgka2cvT78uyBVCAdJqafeM
	 lgzGDNGsyaXtdy8uecZpEl/iP8wYuoHQA2jpNYDv5U0FrFOQtjnR1c+sR+kQi/bHgB
	 D4ds1LkL/mGglPUrwMq2y2u3kPBZhXKyzQ/5vFiztyJiHZUqsKA37N9Vn4dWJMMTTU
	 qv4fXjOj514uOaW+5rl8kodJSRaeMUTNV033eOtzSQXpqztuckWJnDuw93rPp9UL03
	 bOMwY3z+KB6IQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	jszhang@kernel.org,
	guoren@kernel.org,
	evan@rivosinc.com,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.8 22/23] riscv: T-Head: Test availability bit before enabling MAE errata
Date: Tue,  7 May 2024 18:56:48 -0400
Message-ID: <20240507225725.390306-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507225725.390306-1-sashal@kernel.org>
References: <20240507225725.390306-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit

From: Christoph Müllner <christoph.muellner@vrull.eu>

[ Upstream commit 65b71cc35cc6631cb0a5b24f961fe64c085cb40b ]

T-Head's memory attribute extension (XTheadMae) (non-compatible
equivalent of RVI's Svpbmt) is currently assumed for all T-Head harts.
However, QEMU recently decided to drop acceptance of guests that write
reserved bits in PTEs.
As XTheadMae uses reserved bits in PTEs and Linux applies the MAE errata
for all T-Head harts, this broke the Linux startup on QEMU emulations
of the C906 emulation.

This patch attempts to address this issue by testing the MAE-enable bit
in the th.sxstatus CSR. This CSR is available in HW and can be
emulated in QEMU.

This patch also makes the XTheadMae probing mechanism reliable, because
a test for the right combination of mvendorid, marchid, and mimpid
is not sufficient to enable MAE.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Link: https://lore.kernel.org/r/20240407213236.2121592-3-christoph.muellner@vrull.eu
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/errata/thead/errata.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index 6e7ee1f16bee3..bf6a0a6318ee3 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -19,6 +19,9 @@
 #include <asm/patch.h>
 #include <asm/vendorid_list.h>
 
+#define CSR_TH_SXSTATUS		0x5c0
+#define SXSTATUS_MAEE		_AC(0x200000, UL)
+
 static bool errata_probe_mae(unsigned int stage,
 			     unsigned long arch_id, unsigned long impid)
 {
@@ -28,11 +31,14 @@ static bool errata_probe_mae(unsigned int stage,
 	if (arch_id != 0 || impid != 0)
 		return false;
 
-	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT ||
-	    stage == RISCV_ALTERNATIVES_MODULE)
-		return true;
+	if (stage != RISCV_ALTERNATIVES_EARLY_BOOT &&
+	    stage != RISCV_ALTERNATIVES_MODULE)
+		return false;
 
-	return false;
+	if (!(csr_read(CSR_TH_SXSTATUS) & SXSTATUS_MAEE))
+		return false;
+
+	return true;
 }
 
 /*
-- 
2.43.0


