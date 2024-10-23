Return-Path: <stable+bounces-87921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6DB9ACD4C
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235FA1F248C5
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5E7216A30;
	Wed, 23 Oct 2024 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEMIYVea"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AF0216A28;
	Wed, 23 Oct 2024 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693988; cv=none; b=lvkFfbX47Ts/2LZN9izheKm8zWGP+fckUFuU26lEegYRN5hBWRaqjyu2116j9r24obs7L0tkNWrqHca295x1NKkwi5beLZGmML4bS5Mcdt7mzEh/b4FJ1OUSVH8y7shboMqaNracyhev3ozIpm5W08JD0IIQ6wF9IH13tN5HL7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693988; c=relaxed/simple;
	bh=8x4gbOVWk2fS1hTMUlUz7MC4z/meP6ZjHOlPHNJjRgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZV7p2301wHEna2iwPXQJLrQPvvT+0+hMamW+W7UUzr6rXRVdEW/hPp3H0fl4WDXEna6pFXDnP/m5qRJWtTXmu6W+a8KGZpMpmjlsx7FFk//gK679cb9G/RFxbNvnyibJsjq1qUY7HMAFU400SEW3DnlO+xD5wMxk9y8Geo4d7HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEMIYVea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AB3C4CEC6;
	Wed, 23 Oct 2024 14:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693988;
	bh=8x4gbOVWk2fS1hTMUlUz7MC4z/meP6ZjHOlPHNJjRgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IEMIYVeaQw3EjpZ85UREWfx6eDDnU4FPQFe5w/H9bipbuhtiIzsSrikKVH6QVRzbn
	 BaudYdH4AndjpO/2NhxcWrW8xjuWp8X1fzztyXhDbcpWv/gppzgisIG6T9mKNOR/mp
	 f8St9VnDWBXtkDtXecMUjRUeSOcYN9DtvbSe4lik91sOQPtofvsnxMLSLFh5gaq+jP
	 wTzqa/lP22E1S0WlG4MmBfrMm6FFxRQUC6xx9H5/6LRXpbiEHGWzGcMx0Np3od5efn
	 uSRz44VgG17JJwjnLcsIMQ4apUP9ismGliV1iO7kbBf6pYyme0ndW0DyuztN5NjpNb
	 nkh9df/OaSfjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	2639161967 <2639161967@qq.com>,
	Sasha Levin <sashal@kernel.org>,
	chentao@kylinos.cn,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.10 6/6] powerpc/powernv: Free name on error in opal_event_init()
Date: Wed, 23 Oct 2024 10:32:53 -0400
Message-ID: <20241023143257.2982585-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143257.2982585-1-sashal@kernel.org>
References: <20241023143257.2982585-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.228
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


