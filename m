Return-Path: <stable+bounces-87926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2048C9ACD58
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0E40B25ED5
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07749217907;
	Wed, 23 Oct 2024 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jiyc8PLU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B711D2178FE;
	Wed, 23 Oct 2024 14:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693999; cv=none; b=cqixATTfvXROVl9MA7hEYvPSOsdOgfAmiSF3ODJ/n6X5LHARiJFcY+ts1NR8KVSaXRVomWw0LCqavkWIj0BRpm0d+or/mbyEGLiKvc9NlY9M/yoUpcWU2rKa63dvNcVj/LqnuIaSWcSOLFPWKlJ/SH55MOuZdYX7kCsk6LJUFYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693999; c=relaxed/simple;
	bh=8x4gbOVWk2fS1hTMUlUz7MC4z/meP6ZjHOlPHNJjRgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=US89GGzfWBRiCIyU7YCHzysCT61gPghex8ZrLIpguN6rQTDr6p8jXhtJ3F0zT6bfHxjhI4NJ8ZRZqNqoqaG9Y56/VUf1soLm183tKNRe3HTZ/0zBYC72dxHTMtYod+GVIapjLGKAWiQjXFDvpCV/kfj2JG+AEsp7hKdxRhm+CmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jiyc8PLU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC531C4CEC6;
	Wed, 23 Oct 2024 14:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693999;
	bh=8x4gbOVWk2fS1hTMUlUz7MC4z/meP6ZjHOlPHNJjRgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jiyc8PLUbGjx57lukD/YERhjbg1R6SiTOdR/9O3pI4EF8OsF2fYwi2CiODSxdnDxH
	 QJ7in2WJQ+kQIrotpRj6eBV0Zudinx2EsoeEtDADqPJ2J6a2LJiplmDpubhpeyt65t
	 e5tTsiVMTxeIBsd2nsSqa05+/lsYSnwEXM3VWIO5qwBQ5cCmnPgyow5DFwOAfYyXAg
	 tDEHwIhzuNw7TRi/hdRGX2/gLY7NggpttLaRW80k6PjhHvxUYVBszVWM/a5Rkz6tWt
	 jW9u9fzlCU8K/J9Ozk7bweklQlvIkeKStjmwZk/i25za0jPY0AgRwmkOSm37mFwku4
	 nKOZRQny0MEoA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	2639161967 <2639161967@qq.com>,
	Sasha Levin <sashal@kernel.org>,
	chentao@kylinos.cn,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.4 5/5] powerpc/powernv: Free name on error in opal_event_init()
Date: Wed, 23 Oct 2024 10:33:08 -0400
Message-ID: <20241023143310.2982725-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143310.2982725-1-sashal@kernel.org>
References: <20241023143310.2982725-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.284
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
index dcec0f760c8f8..522bda391179a 100644
--- a/arch/powerpc/platforms/powernv/opal-irqchip.c
+++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
@@ -285,6 +285,7 @@ int __init opal_event_init(void)
 				 name, NULL);
 		if (rc) {
 			pr_warn("Error %d requesting OPAL irq %d\n", rc, (int)r->start);
+			kfree(name);
 			continue;
 		}
 	}
-- 
2.43.0


