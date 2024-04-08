Return-Path: <stable+bounces-37090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D890C89C345
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 173281C22105
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EAC7C09F;
	Mon,  8 Apr 2024 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bES8VubY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B516FE1A;
	Mon,  8 Apr 2024 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583221; cv=none; b=hZOz1ua/5wbxPotV9YpQzLz4q4cGI9dAmcsjsUGiMBvLpEQcP1pnNPrJ+mEXavKKAR3enJl7kFqXLoD06O6w06t3zbF6DM2sEGx2GMEeDda/sTA0h8iNdXT+cz2cEOIDKoHOIOcUBCZc7adHFmWYFOA1vNM6i7moZALknw8DX18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583221; c=relaxed/simple;
	bh=NyJAEG/bExymQlPVNFZr4CiMG0Cd1UiWsus/ixV89nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FukUiMqQ/6AH9q4QDfE4Ntar1MfvbNQ857w+JDMCYCPm4ZkLB3yxSOEms6/07GufuGgrGcL/upkvloKFKFFYjjqQJ76wQu6Tfe79Oc8ZkNYTkGFRikZt2aAMmHgTI0lK7zydsMYUbMNNDGp5c1vakZMiELfBb1v8MI0HMbQINCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bES8VubY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA87C433C7;
	Mon,  8 Apr 2024 13:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583220;
	bh=NyJAEG/bExymQlPVNFZr4CiMG0Cd1UiWsus/ixV89nE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bES8VubYFoZN3ZQgSOwV2oNV+ZkxuUOgWAMYf5JJg2DUF553SJoJ1E9m4W8bbrb4E
	 KQSs+VfqxTPojRegE0ArXPo7tI1m0Ag+KR+C2eQM3U8tdpT1wIj5t/bNJIzC6I/9kb
	 fVvefIB47jEoDtTLU5B56nkslz3WJ0XP7g8fN1/k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ivan Komarov <ivan.komarov@dfyz.info>,
	Victor Isaev <isv@google.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 162/252] RISC-V: Update AT_VECTOR_SIZE_ARCH for new AT_MINSIGSTKSZ
Date: Mon,  8 Apr 2024 14:57:41 +0200
Message-ID: <20240408125311.681070756@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
References: <20240408125306.643546457@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Victor Isaev <victor@torrio.net>

[ Upstream commit 13dddf9319808badd2c1f5d7007b4e82838a648e ]

"riscv: signal: Report signal frame size to userspace via auxv" (e92f469)
has added new constant AT_MINSIGSTKSZ but failed to increment the size of
auxv, keeping AT_VECTOR_SIZE_ARCH at 9.
This fix correctly increments AT_VECTOR_SIZE_ARCH to 10, following the
approach in the commit 94b07c1 ("arm64: signal: Report signal frame size
to userspace via auxv").

Link: https://lore.kernel.org/r/73883406.20231215232720@torrio.net
Link: https://lore.kernel.org/all/20240102133617.3649-1-victor@torrio.net/
Reported-by: Ivan Komarov <ivan.komarov@dfyz.info>
Closes: https://lore.kernel.org/linux-riscv/CY3Z02NYV1C4.11BLB9PLVW9G1@fedora/
Fixes: e92f469b0771 ("riscv: signal: Report signal frame size to userspace via auxv")
Signed-off-by: Victor Isaev <isv@google.com>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/include/uapi/asm/auxvec.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/uapi/asm/auxvec.h b/arch/riscv/include/uapi/asm/auxvec.h
index 10aaa83db89ef..95050ebe9ad00 100644
--- a/arch/riscv/include/uapi/asm/auxvec.h
+++ b/arch/riscv/include/uapi/asm/auxvec.h
@@ -34,7 +34,7 @@
 #define AT_L3_CACHEGEOMETRY	47
 
 /* entries in ARCH_DLINFO */
-#define AT_VECTOR_SIZE_ARCH	9
+#define AT_VECTOR_SIZE_ARCH	10
 #define AT_MINSIGSTKSZ		51
 
 #endif /* _UAPI_ASM_RISCV_AUXVEC_H */
-- 
2.43.0




