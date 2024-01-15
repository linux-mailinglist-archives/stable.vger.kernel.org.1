Return-Path: <stable+bounces-10946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CD282E345
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 00:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA991F22F03
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 23:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE471B7EA;
	Mon, 15 Jan 2024 23:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNnCmS6w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427691B963;
	Mon, 15 Jan 2024 23:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3ECCC433C7;
	Mon, 15 Jan 2024 23:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705361039;
	bh=psqCfDKQSKwB2pk7KyaWBlnHeEG8IWloOXUH8t0qbCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oNnCmS6wQt5yROsx3/lkW7SuymF+Zmy3yr/tZbkDbs+yiVxWu5IDXS8DtezyX4pUM
	 Ku4MjoRhpR43y+OHK9Y7nLQoxCqxdA5tl5I0KEMoMiDeVSg2AMunYu3+ShEy1QVTvC
	 qwAxRHUMe71skkJI3n6UDxEStuTuLqgjDVBC1I69vlXzJUMTNvMPt3nMBGLJ1CilkS
	 /wTN8WmeZblTy3Rls8q704o+7yq6RdA6z5zJFzYzJ3KQeisvkEjAQZ3gTIltwwtTsa
	 MnKmlwTg4yXuDBbzKBfKZxn3oxyHrDJawkt6wCmz7T2EjqgvB9Xn9Ndog+NDpaV2MA
	 v8yehs9SE5YJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.7 03/14] powerpc/mm: Fix null-pointer dereference in pgtable_cache_add
Date: Mon, 15 Jan 2024 18:23:17 -0500
Message-ID: <20240115232351.208489-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115232351.208489-1-sashal@kernel.org>
References: <20240115232351.208489-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <chentao@kylinos.cn>

[ Upstream commit f46c8a75263f97bda13c739ba1c90aced0d3b071 ]

kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure. Ensure the allocation was successful
by checking the pointer validity.

Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20231204023223.2447523-1-chentao@kylinos.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/init-common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index 119ef491f797..d3a7726ecf51 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -126,7 +126,7 @@ void pgtable_cache_add(unsigned int shift)
 	 * as to leave enough 0 bits in the address to contain it. */
 	unsigned long minalign = max(MAX_PGTABLE_INDEX_SIZE + 1,
 				     HUGEPD_SHIFT_MASK + 1);
-	struct kmem_cache *new;
+	struct kmem_cache *new = NULL;
 
 	/* It would be nice if this was a BUILD_BUG_ON(), but at the
 	 * moment, gcc doesn't seem to recognize is_power_of_2 as a
@@ -139,7 +139,8 @@ void pgtable_cache_add(unsigned int shift)
 
 	align = max_t(unsigned long, align, minalign);
 	name = kasprintf(GFP_KERNEL, "pgtable-2^%d", shift);
-	new = kmem_cache_create(name, table_size, align, 0, ctor(shift));
+	if (name)
+		new = kmem_cache_create(name, table_size, align, 0, ctor(shift));
 	if (!new)
 		panic("Could not allocate pgtable cache for order %d", shift);
 
-- 
2.43.0


