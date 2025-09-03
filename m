Return-Path: <stable+bounces-177664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39890B42B92
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 23:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13876174BF7
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 21:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A2D2EACE9;
	Wed,  3 Sep 2025 21:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDfX1pyV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E232C235A
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 21:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756933939; cv=none; b=dftk77OtnX0AklJQjoP/2m6oz9qXA0FugtcT/zH5CuvrVvP4xBVVW5LBpEkqd+Ne94ONFdyEhmCisIozvd13SufUcZO3g5BQMasDihylx7HLG5pPEheO4FremrM1z+lkxiMpVvXgekWhunWgydPAKgpFO6/n2dk74epgRmybiz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756933939; c=relaxed/simple;
	bh=eXH68fi0oBBW92ujAVQNdxDN9cWmORKtrc5sa0RT+xY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UZ7y8Tc+R4hlMU+nwi/R85gKXyrXNM9Be87qx08BshfVf5Kc00dTRZFA3nKCdkCmAbSVYrmfDoYWHDI46kMQMFefeSrwUbg9hlCFeOH4b3rqCOsYKu6K5hvDFZpWGhIg0UsnIeXUvlgTW/Myaof7bfW3COx978p8FrJgFrLgAa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDfX1pyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9759C4CEE7;
	Wed,  3 Sep 2025 21:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756933938;
	bh=eXH68fi0oBBW92ujAVQNdxDN9cWmORKtrc5sa0RT+xY=;
	h=From:To:Cc:Subject:Date:From;
	b=pDfX1pyVIvamffnSmVZqbAiL3Nf/w8yayG9ux8TCC9bOhGvwSLoZx0SNtwOHoGnGS
	 zGkjJISSKMLsR10tw/R18HQXkcc9D78JU4wezCn44TlcuOhg27ADEvSlZehlOnD3U+
	 2hEEPbePAcdgRQ8XdeRHQH4qZ9fZ/EKqU726/DS4J++5yLlY/l79hv/IttIAJFx0GB
	 MnRhWVaf+Glb+LqweSmw08J4S2hLyTqBWC8nEq33vxNuiR/WzaD2h0IYWbgDjwuEnQ
	 7PtFvuTQa4+hHC4OJsmKdJlDN5s7+ROt8+ZeBhn7TvWeF1/4hH959pYvjgVQ3kNGVj
	 rXlzzzr1+Hm+A==
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 5.4 only v2] powerpc: boot: Remove leading zero in label in udelay()
Date: Wed,  3 Sep 2025 14:11:58 -0700
Message-ID: <20250903211158.2844032-1-nathan@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When building powerpc configurations in linux-5.4.y with binutils 2.43
or newer, there is an assembler error in arch/powerpc/boot/util.S:

  arch/powerpc/boot/util.S: Assembler messages:
  arch/powerpc/boot/util.S:44: Error: junk at end of line, first unrecognized character is `0'
  arch/powerpc/boot/util.S:49: Error: syntax error; found `b', expected `,'
  arch/powerpc/boot/util.S:49: Error: junk at end of line: `b'

binutils 2.43 contains stricter parsing of certain labels [1], namely
that leading zeros are no longer allowed. The GNU assembler
documentation already somewhat forbade this construct:

  To define a local label, write a label of the form 'N:' (where N
  represents any non-negative integer).

Eliminate the leading zero in the label to fix the syntax error. This is
only needed in linux-5.4.y because commit 8b14e1dff067 ("powerpc: Remove
support for PowerPC 601") removed this code altogether in 5.10.

Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=226749d5a6ff0d5c607d6428d6c81e1e7e7a994b [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
v1 -> v2:
- Adjust commit message to make it clearer this construct was already
  incorrect under the existing GNU assembler documentation (Segher)

v1: https://lore.kernel.org/20250902235234.2046667-1-nathan@kernel.org/
---
 arch/powerpc/boot/util.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/util.S b/arch/powerpc/boot/util.S
index f11f0589a669..5ab2bc864e66 100644
--- a/arch/powerpc/boot/util.S
+++ b/arch/powerpc/boot/util.S
@@ -41,12 +41,12 @@ udelay:
 	srwi	r4,r4,16
 	cmpwi	0,r4,1		/* 601 ? */
 	bne	.Ludelay_not_601
-00:	li	r0,86	/* Instructions / microsecond? */
+0:	li	r0,86	/* Instructions / microsecond? */
 	mtctr	r0
 10:	addi	r0,r0,0 /* NOP */
 	bdnz	10b
 	subic.	r3,r3,1
-	bne	00b
+	bne	0b
 	blr
 
 .Ludelay_not_601:

base-commit: c25f780e491e4734eb27d65aa58e0909fd78ad9f
-- 
2.51.0


