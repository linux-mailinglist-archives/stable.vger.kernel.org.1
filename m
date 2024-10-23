Return-Path: <stable+bounces-87901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8EE9ACD15
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6831C210E2
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC65621018F;
	Wed, 23 Oct 2024 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J81qSgJF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D4920FA91;
	Wed, 23 Oct 2024 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693944; cv=none; b=NDaT0boGCdCIoQ4u5AHqFKompPaLjw/xMIWYbISc9WWe2Ez7cUu99nZ0OPvFAxKyznb0PrTDa3pye4zqF0Aj8QmHssgKdM4uitOAdfnCmmH+eNcm2j95GrawoGByJ30jkm4YCA+vdn/7sISaa5Ii48cl05LH8qWpuEuQ4f/yQfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693944; c=relaxed/simple;
	bh=ps2pio6F3j0r+hhv1BZ70KY2snpn9xRXWVZg2U276Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGdrT7mWBE0LOXhRsYbrUsJrUgNaiGywyp/WfaTWcjqb0NS/00sS4MN7Bji9bOxLa8xsMMSfe5TWGnajN1vya4rqPequYQzyZDvUHioZQxdr56ZD9P5264gnUlnwL90jlReJOZUstvrV7r8tu+2+6PF7ClohVUDOnaaPMeTWJ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J81qSgJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3D3C4CEC6;
	Wed, 23 Oct 2024 14:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693944;
	bh=ps2pio6F3j0r+hhv1BZ70KY2snpn9xRXWVZg2U276Hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J81qSgJFpjyeoc3DxQxBaFqXCkgX1c4Xnj6oaUPijsX5rIj8FTS6q9TnRIXOeMTkT
	 b+NyqCgXd8FDTY1mONqj891mJxVlDdX/XvsDrRlBBO9Nd3zWS6sK8jV6YLv57IrZuX
	 1ZPVhOrCa+IkVwWM5ocB+N8Vtdx/+96W7jMin90GRF7TSLeshHhD2KFonlebT01jJr
	 JkIbO83Cobkxa2iqRhOA6mcVZHI0U1ENg97wRFcTfzjD9399mfXtsecEDhUHFV0M+7
	 Uiv63HJGzqUfw9pYLL+DrbSxpwJWHXiyirq4CZWD4ios92cAyDvm6ArWKVIUgPXZST
	 HLk+su6TPbfNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joey Gouly <joey.gouly@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Kevin Brodsky <Kevin.Brodsky@arm.com>,
	Sasha Levin <sashal@kernel.org>,
	pcc@google.com,
	dawei.li@shingroup.cn,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 13/17] arm64: set POR_EL0 for kernel threads
Date: Wed, 23 Oct 2024 10:31:52 -0400
Message-ID: <20241023143202.2981992-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143202.2981992-1-sashal@kernel.org>
References: <20241023143202.2981992-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.114
Content-Transfer-Encoding: 8bit

From: Joey Gouly <joey.gouly@arm.com>

[ Upstream commit e3e85271330b18f487ab3032ea9ca0601efeafaf ]

Restrict kernel threads to only have RWX overlays for pkey 0.  This matches
what arch/x86 does, by defaulting to a restrictive PKRU.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Kevin Brodsky <Kevin.Brodsky@arm.com>
Link: https://lore.kernel.org/r/20241001133618.1547996-2-joey.gouly@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/process.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 044a7d7f1f6ad..048fe09da8a07 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -399,6 +399,9 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 
 		p->thread.cpu_context.x19 = (unsigned long)args->fn;
 		p->thread.cpu_context.x20 = (unsigned long)args->fn_arg;
+
+		if (system_supports_poe())
+			p->thread.por_el0 = POR_EL0_INIT;
 	}
 	p->thread.cpu_context.pc = (unsigned long)ret_from_fork;
 	p->thread.cpu_context.sp = (unsigned long)childregs;
-- 
2.43.0


