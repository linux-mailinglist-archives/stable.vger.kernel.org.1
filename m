Return-Path: <stable+bounces-135626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F03A98F67
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD071894429
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F38328134C;
	Wed, 23 Apr 2025 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZDFIK9QQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAD1280CC8;
	Wed, 23 Apr 2025 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420419; cv=none; b=UqUvaL80L5JLQ03WFCqACS/fG78Mlp3zKqfR9bfICBWFum4HKNjS0vM7LjWxi9F2EzZItPXGPuvV6Iq3sAnCkflkfhn1lCuIXmjC65GlfbLqcCpWCsaAo9QXwPi8c2mw6n5hHoB9qCt4Ih+9YfrMeDpsq8Ww6d+b4YNv2s2Q8kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420419; c=relaxed/simple;
	bh=BiyU+7nFuHPsSj/Q7uuZyInzi2IKbgSkiu5rzlS3cCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fe4cAvOqZv/DmQDKTpC7SsoiEw530iCAVHqnl153oGcqY+8RehyAlBnp1t1Dd5hGzw9coFsfz9/k6OEEtyF5AxeYnDmfmWUQX/wXJwl3tCpcH8sPkwiYHIubExpfJau0sKaeG4+hmZ8m9fMvePPLilTvMpTBZZT6ZJe1jPIbx+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZDFIK9QQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E7BC4CEE2;
	Wed, 23 Apr 2025 15:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745420418;
	bh=BiyU+7nFuHPsSj/Q7uuZyInzi2IKbgSkiu5rzlS3cCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZDFIK9QQWsG3VfOg9LPpA1PgNs0NWBEly9o2IjJdHVnQ9e+7a53PUiQYnch5R6p+d
	 3XnjJD4DycsKx7fes21P0EEfvEnNnUBe1A+a5lUgaXSk7BQ08AVf9T3A5OXQ3BacpZ
	 eRf+MWAEAY4m63T72/gnNtJaO+Hf4RVYxpkRFOws=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 090/241] riscv: module: Allocate PLT entries for R_RISCV_PLT32
Date: Wed, 23 Apr 2025 16:42:34 +0200
Message-ID: <20250423142624.259281956@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142620.525425242@linuxfoundation.org>
References: <20250423142620.525425242@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Samuel Holland <samuel.holland@sifive.com>

[ Upstream commit 1ee1313f4722e6d67c6e9447ee81d24d6e3ff4ad ]

apply_r_riscv_plt32_rela() may need to emit a PLT entry for the
referenced symbol, so there must be space allocated in the PLT.

Fixes: 8fd6c5142395 ("riscv: Add remaining module relocations")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Link: https://lore.kernel.org/r/20250409171526.862481-2-samuel.holland@sifive.com
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/module-sections.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kernel/module-sections.c b/arch/riscv/kernel/module-sections.c
index e264e59e596e8..91d0b355ceeff 100644
--- a/arch/riscv/kernel/module-sections.c
+++ b/arch/riscv/kernel/module-sections.c
@@ -73,16 +73,17 @@ static bool duplicate_rela(const Elf_Rela *rela, int idx)
 static void count_max_entries(Elf_Rela *relas, int num,
 			      unsigned int *plts, unsigned int *gots)
 {
-	unsigned int type, i;
-
-	for (i = 0; i < num; i++) {
-		type = ELF_RISCV_R_TYPE(relas[i].r_info);
-		if (type == R_RISCV_CALL_PLT) {
+	for (int i = 0; i < num; i++) {
+		switch (ELF_R_TYPE(relas[i].r_info)) {
+		case R_RISCV_CALL_PLT:
+		case R_RISCV_PLT32:
 			if (!duplicate_rela(relas, i))
 				(*plts)++;
-		} else if (type == R_RISCV_GOT_HI20) {
+			break;
+		case R_RISCV_GOT_HI20:
 			if (!duplicate_rela(relas, i))
 				(*gots)++;
+			break;
 		}
 	}
 }
-- 
2.39.5




