Return-Path: <stable+bounces-87861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D95F89ACCA0
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB241F241A1
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B9C1D5AD7;
	Wed, 23 Oct 2024 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DP2cTU/m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32891C9B86;
	Wed, 23 Oct 2024 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693859; cv=none; b=HEVuESdP6mHNm2r0Q+hUvSAWxqZRzosOe8kaZDVcl20GDYVdp+z2WnkUY4D4z+eySwogYJESGjKjjVCDEQcyZLzaRMV2SZVrvuIxH0U+OnSBDTS31/92cmDFNRQcL16JUfeK0r+oUnmRaeRPGvUwod05Yrbc9F9haGhwzlkwnWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693859; c=relaxed/simple;
	bh=ZDtV8Qyy4tkPd4t6rHAqBBHuwolPefaey8Kua1fEOgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRprb22RpR3fRumCKbFYbWZfin8z+3w7V3BZqBcVuJmdSNns2x91JRQvHZtF8Oy8r8DIze8a02LJHEPi7iYCEfFTq9CNzkWUIgGH6SZ60iQBrjl3W1lzNFRil/rOZyv5B81tAnzCfL7AEMCpQWmStxNPv8Rc9AwqGAAQjwYqsvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DP2cTU/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA8BC4CEC6;
	Wed, 23 Oct 2024 14:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693859;
	bh=ZDtV8Qyy4tkPd4t6rHAqBBHuwolPefaey8Kua1fEOgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DP2cTU/mwWt7Qaf09GrjR8ellg3ueTDXs1bfJxHaskrbLGz1SEMYJ5PF/fnYTrX25
	 64f234Q/JU99gh6ajczoKspY2cyCA1FLjssyc8En7AkleEN7kU5xzqwBp7FJULc3gU
	 od5FziRxz/J0EeQbf2xbVcBsUYXPoi5YgkcQ7hMM+G0ZlYtAtSvlnPial1ucr9n2UL
	 Se2+NfAL4hMhIESuuXybRBTBsEGlzUWwM/dSoWD33/ZEh5vFGXdr1pbMT93LfLCsaC
	 BJCy8Mf/3LBcF3k+Q4fO6kjluR1kSDVqcjVrPadImvN7qy5uITVxMB6+lEj2GCYX6t
	 fiRv3z1+gESeQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	2639161967 <2639161967@qq.com>,
	Sasha Levin <sashal@kernel.org>,
	chentao@kylinos.cn,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.11 26/30] powerpc/powernv: Free name on error in opal_event_init()
Date: Wed, 23 Oct 2024 10:29:51 -0400
Message-ID: <20241023143012.2980728-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143012.2980728-1-sashal@kernel.org>
References: <20241023143012.2980728-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
Content-Transfer-Encoding: 8bit

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit cf8989d20d64ad702a6210c11a0347ebf3852aa7 ]

In opal_event_init() if request_irq() fails name is not freed, leading
to a memory leak. The code only runs at boot time, there's no way for a
user to trigger it, so there's no security impact.

Fix the leak by freeing name in the error path.

Reported-by: 2639161967 <2639161967@qq.com>
Closes: https://lore.kernel.org/linuxppc-dev/87wmjp3wig.fsf@mail.lhotse
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://patch.msgid.link/20240920093520.67997-1-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/powernv/opal-irqchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
index 56a1f7ce78d2c..d92759c21fae9 100644
--- a/arch/powerpc/platforms/powernv/opal-irqchip.c
+++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
@@ -282,6 +282,7 @@ int __init opal_event_init(void)
 				 name, NULL);
 		if (rc) {
 			pr_warn("Error %d requesting OPAL irq %d\n", rc, (int)r->start);
+			kfree(name);
 			continue;
 		}
 	}
-- 
2.43.0


