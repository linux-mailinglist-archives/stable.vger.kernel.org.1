Return-Path: <stable+bounces-68345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B6D9531C2
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92EF9287303
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379D319EECF;
	Thu, 15 Aug 2024 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2TCj8TXJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E939618D64F;
	Thu, 15 Aug 2024 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730274; cv=none; b=tl8Gshv/JXqf0z1cTdyoWzNWh6L89C5/PXaCrFTEWyUsuVAH+1phrLYhUXOttfZtOKuSzfJKyEmDzvh5nL0uUAV20O1cPojpGwmgW4xWIwaRjpnbSGnYUPJU5iFbOJ5m+hImNuI8b4iyJKHDHLpJCZh+fQl5IMYJUtdFOwoB+m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730274; c=relaxed/simple;
	bh=+AsYriu38sfGAoVMP8zX/a5/fHzB1JzmUO4LZrPxmV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEPGFVCIAXfqm6QSyc6JXOQs932B2eVFYR1nQht8hZMK8VZGB4UaAUiE5hbfk8P88EzOdOGE9kaOcwrV4W9Q1PoFrR//tLXvJwwWezxavohuhs0hhWUbj1kpbu9HO46x87B97w/gb7KnS7EPyyti+arqKfJBO1Yw0P0Pr9tDL3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2TCj8TXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7154EC32786;
	Thu, 15 Aug 2024 13:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723730273;
	bh=+AsYriu38sfGAoVMP8zX/a5/fHzB1JzmUO4LZrPxmV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2TCj8TXJj7YqQenuhgndNF0JtcoL1QmotLY4lAXpvDZyLP82+ssYExcLT0t8qke5j
	 o1R91TOVL8uJtQIgvCUslALJE4Lu7jPwb2K2+szM5qK5wcU9cMCEM3PzyspTwnG012
	 gFZ2Mc9um4TEcktEwKkeUuozV8ghLJw7hk3Mt/VY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 357/484] x86/mm: Fix pti_clone_entry_text() for i386
Date: Thu, 15 Aug 2024 15:23:35 +0200
Message-ID: <20240815131955.217633646@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
References: <20240815131941.255804951@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 3db03fb4995ef85fc41e86262ead7b4852f4bcf0 ]

While x86_64 has PMD aligned text sections, i386 does not have this
luxery. Notably ALIGN_ENTRY_TEXT_END is empty and _etext has PAGE
alignment.

This means that text on i386 can be page granular at the tail end,
which in turn means that the PTI text clones should consistently
account for this.

Make pti_clone_entry_text() consistent with pti_clone_kernel_text().

Fixes: 16a3fe634f6a ("x86/mm/pti: Clone kernel-image on PTE level for 32 bit")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/pti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index c11c808eeac26..189b242d3e897 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -496,7 +496,7 @@ static void pti_clone_entry_text(void)
 {
 	pti_clone_pgtable((unsigned long) __entry_text_start,
 			  (unsigned long) __entry_text_end,
-			  PTI_CLONE_PMD);
+			  PTI_LEVEL_KERNEL_IMAGE);
 }
 
 /*
-- 
2.43.0




