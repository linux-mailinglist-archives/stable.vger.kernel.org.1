Return-Path: <stable+bounces-80818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63064990B69
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CCD8280A48
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210CE1E2839;
	Fri,  4 Oct 2024 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRpR0qAH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C371E2834;
	Fri,  4 Oct 2024 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065981; cv=none; b=hILjX1SKdkCDs0rFSUtXO4ZgsBXJ8aqXAvawUvzLV7LNfIqrNxn0DTRz1AZY5vt/pXQx1YUDheUcfQOKDLhZ7icTvMlbWlR+ok9yewAljhVfRDiW+2gMe+INUnhV0id5/Fe2/wmmo6Z6gDQbPUTvbS5c6R1+VJ44kUM1Jsy7rIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065981; c=relaxed/simple;
	bh=/B2Gc/EMzBDQckZ37mMVoHmmOAbe4wh83yczyv1hib4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKi3K0Ea6us3fcb806/ilOgTCPjwaBnZW5Zbd6wg4k9AqfZZ+FJMj7bT3VVDKwuTKLws/j8hpWn7jRv7oqmJtAAli5PSlN4mGFqoUI71mq7fO99w6sNqx0XaDipTRdnLBTxk6/UKhUnA3Yn9WLsj3hSCzqWuH3q90fqyhI/uPr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRpR0qAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC948C4CECC;
	Fri,  4 Oct 2024 18:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065981;
	bh=/B2Gc/EMzBDQckZ37mMVoHmmOAbe4wh83yczyv1hib4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QRpR0qAH6GYeq6glzx9ToEMJfToDw4n7+EdDkIbcHzr1A/OQgVsXzRf9AooKXMkRU
	 TTZJJp9qwPAS2sHtJ9t7PXSpmWUZqKLPI8vzZB//wlNdmqho4LIPvZd4PtaZX1xAK/
	 icGetN0JwzyZn4AVy6XBJfkyAy8wCbKb5FrXEBUBwH5dOdOHNAtERiSpNJX+6NIrDT
	 sxJQlBXnVkXIMQ9V1A/hDRegPYPqBj1XVykte4eSHwN4flwHir97fm/d8NPQYaSAHG
	 DGTyHaUVMJNFGJUrYlcQooc7t5s7LztOwCgYPpNvS00rEqqCui0DGnC96kMryY4dwX
	 t7hz8u2rzGpOA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Cyril Bur <cyrilbur@tenstorrent.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	samitolvanen@google.com,
	cleger@rivosinc.com,
	guoren@kernel.org,
	namcaov@gmail.com,
	debug@rivosinc.com,
	antonb@tenstorrent.com,
	andy.chiu@sifive.com,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.11 38/76] riscv: avoid Imbalance in RAS
Date: Fri,  4 Oct 2024 14:16:55 -0400
Message-ID: <20241004181828.3669209-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
Content-Transfer-Encoding: 8bit

From: Jisheng Zhang <jszhang@kernel.org>

[ Upstream commit 8f1534e7440382d118c3d655d3a6014128b2086d ]

Inspired by[1], modify the code to remove the code of modifying ra to
avoid imbalance RAS (return address stack) which may lead to incorret
predictions on return.

Link: https://lore.kernel.org/linux-riscv/20240607061335.2197383-1-cyrilbur@tenstorrent.com/ [1]
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Cyril Bur <cyrilbur@tenstorrent.com>
Link: https://lore.kernel.org/r/20240720170659.1522-1-jszhang@kernel.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/entry.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index ac2e908d4418d..fefb8e7d957a0 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -239,8 +239,8 @@ SYM_CODE_START(ret_from_fork)
 	jalr s0
 1:
 	move a0, sp /* pt_regs */
-	la ra, ret_from_exception
-	tail syscall_exit_to_user_mode
+	call syscall_exit_to_user_mode
+	j ret_from_exception
 SYM_CODE_END(ret_from_fork)
 
 #ifdef CONFIG_IRQ_STACKS
-- 
2.43.0


