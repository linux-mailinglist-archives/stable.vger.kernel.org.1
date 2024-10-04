Return-Path: <stable+bounces-80958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D194990D3A
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 054A1280E07
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871082071F2;
	Fri,  4 Oct 2024 18:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMhwOui6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465772071EE;
	Fri,  4 Oct 2024 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066361; cv=none; b=CZNYI/Giaqg2w498bW1NU7IHWVQqf/E09rOrK4TAqkSdFh3pV2JicD7jIe0Nw2W2O4Y9EaHxeKN8TsHcpSBH4KxVcCJO51Arw5qsKzogaWEy0Sh8LNXau3jWcgepLU084LTyXWljDmOoEpT/NCIkYCvWT4so3WwbAMRA73gloMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066361; c=relaxed/simple;
	bh=KEHGx5ZxOwmv3mqRRP4gulTwHNAd9PJT3vm70lAVmY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARygTQmK2Ea1GT6zw6wdr6GdvsYtcEKaqKYj+i3LUZmmOoKlcaFfL23BjRkYdgbXho/vWmT9KLoJajYi8yCc9zLTe4c/IhXwjvVRuwIwOMAp7dclMgY7T9uqNW+Hbdvs/mKJuEpTuHAovWIeXS85d+FS5ddvlOEd0eunSyVITBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMhwOui6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288A7C4CECC;
	Fri,  4 Oct 2024 18:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066360;
	bh=KEHGx5ZxOwmv3mqRRP4gulTwHNAd9PJT3vm70lAVmY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GMhwOui6NifvV0XMnaswzCogywNQ3ugAmVOhFFYu19hf2Da/RyF6pVYdUOqniqVs8
	 wsaC0GjhyE0JQzKY+BqE5dzv2nVK++UZgYbbbMVuc38HMgS/uu60Djcv2Yxl1iNSvX
	 ReVrBu6ZUHgOXWcK46C3XkrC40mcACe3RoRH3FAaydjHTM8z4lKCa3QnMq5gogPRGv
	 KBG8IIxkTLWvlDpFLB10CksvOjSByYhaShfirlZ7FzFtCWRbpdJlIIIZ5sqEYw0dQ5
	 DweFebealMUilmhzrk0XVQS+9iRKGDImPA7jDMGyWOYoZRyZrTTLYI7e052jmIJPkh
	 Z8EomJy/lpF7w==
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
	antonb@tenstorrent.com,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 32/58] riscv: avoid Imbalance in RAS
Date: Fri,  4 Oct 2024 14:24:05 -0400
Message-ID: <20241004182503.3672477-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
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
index ed7baf2cf7e87..1f90fee24a8ba 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -219,8 +219,8 @@ SYM_CODE_START(ret_from_fork)
 	jalr s0
 1:
 	move a0, sp /* pt_regs */
-	la ra, ret_from_exception
-	tail syscall_exit_to_user_mode
+	call syscall_exit_to_user_mode
+	j ret_from_exception
 SYM_CODE_END(ret_from_fork)
 
 /*
-- 
2.43.0


