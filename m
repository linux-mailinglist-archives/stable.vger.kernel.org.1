Return-Path: <stable+bounces-120910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C69A508EA
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2BC168D54
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50324251788;
	Wed,  5 Mar 2025 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UEcxtSYV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7FB1D6DB4;
	Wed,  5 Mar 2025 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198329; cv=none; b=ZzmDJbHja6kiDmcJhBlnSEfjKSKOkjkgIYHSB80FNtxga9rKjpp1TRE7ViFChGpdZY6cYtb4eFolNS1saFoBeaI8FaAQpljhQZkWH6gRxIs2Lyp7U5Ye4AhGMowsc4gKxZSShicJ62lGPAgnPziGCrM7um1vkiARuq4miXpSi0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198329; c=relaxed/simple;
	bh=AH1rOWPqDOMfGh5CdVCXtuE55AwywalZwCDkQaknb7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YpqpQSy5VvtaPu/oX640ajebeqVeiwknr5ETZr/3yBJsiDpR0AP1O74K1CX3VVW7tu5hSyJMGz8QOSTnfiTV3PYK/+5O7nmsDe396a0wNQ/HKaxG2SeZNuAv4yGJNrrBHtEmzw9oI2tltmo77CR40i47H59A4OhG4dQx3dfbpP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UEcxtSYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8492CC4CED1;
	Wed,  5 Mar 2025 18:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741198328;
	bh=AH1rOWPqDOMfGh5CdVCXtuE55AwywalZwCDkQaknb7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UEcxtSYVs9ZUjIIwfZhyI7ZDcTdl0XxZXL2AoPBleSPKL5zwZiGfRcGeYIC4tnsw8
	 5jx8jIWyCgUW6Fv59KgwXFUTHUt5toWDoSCa+8M8KFLo37ujxAmyVbSXiR6u7UzYyk
	 j92VjE6UnTY+oz4yjCVm8gI4VSht/KfdFR+kPiQg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 6.12 140/150] riscv: cpufeature: use bitmap_equal() instead of memcmp()
Date: Wed,  5 Mar 2025 18:49:29 +0100
Message-ID: <20250305174509.439354439@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174503.801402104@linuxfoundation.org>
References: <20250305174503.801402104@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Clément Léger <cleger@rivosinc.com>

commit c6ec1e1b078d8e2ecd075e46db6197a14930a3fc upstream.

Comparison of bitmaps should be done using bitmap_equal(), not memcmp(),
use the former one to compare isa bitmaps.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Fixes: 625034abd52a8c ("riscv: add ISA extensions validation callback")
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250210155615.1545738-1-cleger@rivosinc.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/kernel/cpufeature.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -454,7 +454,7 @@ static void __init riscv_resolve_isa(uns
 			if (bit < RISCV_ISA_EXT_BASE)
 				*this_hwcap |= isa2hwcap[bit];
 		}
-	} while (loop && memcmp(prev_resolved_isa, resolved_isa, sizeof(prev_resolved_isa)));
+	} while (loop && !bitmap_equal(prev_resolved_isa, resolved_isa, RISCV_ISA_EXT_MAX));
 }
 
 static void __init match_isa_ext(const char *name, const char *name_end, unsigned long *bitmap)



