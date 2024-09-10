Return-Path: <stable+bounces-74604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4C3973027
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A5128753C
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB5517C22F;
	Tue, 10 Sep 2024 09:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HJx1Wcmo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F008EEEC9;
	Tue, 10 Sep 2024 09:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962290; cv=none; b=ALXFrN/9UC6boreA253jfaIJnaubLGrDiTIuFKVLubOHZ9mnHv10B79/p9G/AbV6xVWME7ly/CBdRiXJtF3xUupchNX4QcKQ2GHjoEpSzouOwppkQQDw/JLDGsRAPlzEVUmEDq3U3oTC0ZKUo3QrsoSFLLDeG9si+xkMiFVPZq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962290; c=relaxed/simple;
	bh=yZdNvDOe//RMPkbr9tWt8jrYVCFc21cM2ppPVkq5XQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DhzDhGlvdLIIYXnsAsXCcIWz2LkKMuAWCqbl2dVxHQGc23QJRPbGQOPex9lxTHENGfvjsZSwLdZQS9MW5FSQdOLUZpemui5GKL/u8AVDyDCGqLK9ezp7kx7Ly/1Ja7MO8GR2SzOQUz8bNou/C0T+zBIS5JtQgMAD7fimaxJoEZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HJx1Wcmo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6900CC4CEC3;
	Tue, 10 Sep 2024 09:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725962289;
	bh=yZdNvDOe//RMPkbr9tWt8jrYVCFc21cM2ppPVkq5XQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HJx1WcmorKY31UwCnMASMNOtzutJyc7ZaqgbyQF/1jAtKMI+H93xz4qmJr5S9xMPv
	 rWgrl7FOhzMotf+3jk5C85SjBju3E9hqSGFVC+EUiTkbJdVVSrkqwlsx+LKRIlR2if
	 pul1A7wA60Z1rTy7oBn2QWY8r575WMn3nfS3gSdo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 359/375] riscv: Do not restrict memory size because of linear mapping on nommu
Date: Tue, 10 Sep 2024 11:32:36 +0200
Message-ID: <20240910092634.667876509@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Ghiti <alexghiti@rivosinc.com>

[ Upstream commit 5f771088a2b5edd6f2c5c9f34484ca18dc389f3e ]

It makes no sense to restrict physical memory size because of linear
mapping size constraints when there is no linear mapping, so only do
that when mmu is enabled.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/linux-riscv/CAMuHMdW0bnJt5GMRtOZGkTiM7GK4UaLJCDMF_Ouq++fnDKi3_A@mail.gmail.com/
Fixes: 3b6564427aea ("riscv: Fix linear mapping checks for non-contiguous memory regions")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240827065230.145021-1-alexghiti@rivosinc.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index c5c66f53971a..91346c9da8ef 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -251,7 +251,7 @@ static void __init setup_bootmem(void)
 	 * The size of the linear page mapping may restrict the amount of
 	 * usable RAM.
 	 */
-	if (IS_ENABLED(CONFIG_64BIT)) {
+	if (IS_ENABLED(CONFIG_64BIT) && IS_ENABLED(CONFIG_MMU)) {
 		max_mapped_addr = __pa(PAGE_OFFSET) + KERN_VIRT_SIZE;
 		memblock_cap_memory_range(phys_ram_base,
 					  max_mapped_addr - phys_ram_base);
-- 
2.43.0




