Return-Path: <stable+bounces-80891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18020990C65
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48C62822E6
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAF71F7064;
	Fri,  4 Oct 2024 18:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+eBHfI+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC3821C18E;
	Fri,  4 Oct 2024 18:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066190; cv=none; b=ss7nwiZl18894iemoBIPvI4+3FMcevKMLtZEBAWWtZQJW2/ikvY50eDArRg4IXTnJlb1fWVGaoYjAaHYWU3sY7it03maopeKoOgIngN+6ZoHDtBPFkM12TeBlLENJjluFPYdfBNDkQFYP/SzIHx8x/rHqvid8nOhpuXUR5h/6ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066190; c=relaxed/simple;
	bh=4+o4vbfqOTWQ+9y71GdIYZ4+aq+GqIgpKBjO5m4MQWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTeWSbTWoRb93xKbMFk3RjySjjFQWAxUfzc6neccjSX6xwX0VBmvAE1Q3Tnxdd4L7/X8w4h1a6D6FE7dUVZ/dPCl6tZdA3yysL7m/zSFgPfYDWGno3q92eFYnhxA9sZ3LqE32VgvP+wwtZAeO0aEhunmsBnPYc22mg54zS1VvD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+eBHfI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7636AC4CECC;
	Fri,  4 Oct 2024 18:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066190;
	bh=4+o4vbfqOTWQ+9y71GdIYZ4+aq+GqIgpKBjO5m4MQWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L+eBHfI+0byHTcEhgeJLnq9d9vpcuXb2eNIMhjqYDwTsUj4nRgYldoYAV+duPAqFa
	 osiQRBLdxK3vOkynN3/27dmHYM6izDa0IktA55v00/EOH+EUOM9l9BzWITBnw18JyJ
	 Ud1hWsczP09hJdhMFFzu7uHfBQN26YpkIRbK4cjTzx1L615qIxv77R+bjXRb8jrE9T
	 OUF9kDGrN2mNm/yws6AmXwOqySkzKsQowEeFABfHdvw7YXDJM8rDMZu50P2MtSr2fI
	 HtWoplEj9ta08AQ4A7PGAK+mpq5EeYULh8lpiauz4BnGcgIdROFg1MJH9b131YXPVl
	 QNcj3xv/o9Mow==
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
	ajones@ventanamicro.com,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	antonb@tenstorrent.com,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.10 35/70] riscv: avoid Imbalance in RAS
Date: Fri,  4 Oct 2024 14:20:33 -0400
Message-ID: <20241004182200.3670903-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
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
index 68a24cf9481af..d143dde853b51 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -232,8 +232,8 @@ SYM_CODE_START(ret_from_fork)
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


