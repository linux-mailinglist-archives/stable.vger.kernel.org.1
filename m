Return-Path: <stable+bounces-100708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 462799ED518
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5BC41625C4
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 18:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063CD23E6D3;
	Wed, 11 Dec 2024 18:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwJhUyMr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B441F23A1B1;
	Wed, 11 Dec 2024 18:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943067; cv=none; b=Xy+o6ndTNR8igNhGxd/itBkUU75fWwGirrPo2vRsnBlbj5Pusc+TtbTPMteWyCoN3ouH4wIi9i+WYRiTt5a/VrXySbLokFBdhQzn1vaxT9IUsOFncL6kMmVPg71PE50ib3GD2uL7DebOl7I/EE6PE5OvlZj+YzCV4uSVpygcWTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943067; c=relaxed/simple;
	bh=VvSnKD/ii8WcC963q8ATxiPa1fQ9EHrtimAAmDV7xWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERMUoaC9zBKSjtLsm4F6nNdGMoX46yabNuqMLlA6QqJcGA75j8g3uRzOuyZar90ZXE0SgVJmR4rTPKYz/qc6PfsUG5V6r4zPKmq5e+cPwitL0jUc6sPUeuKBU2qidTga74Z988RwpLzzolzazqbJAKM8Vs5DrKgBpXCc4cMPeRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwJhUyMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4A7C4CED2;
	Wed, 11 Dec 2024 18:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943067;
	bh=VvSnKD/ii8WcC963q8ATxiPa1fQ9EHrtimAAmDV7xWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HwJhUyMrXVJiHj9uJoJ55PxodYAeNlEvo1Gz2SVm1PiUcntUoEYOuPc6RatZTcMTf
	 8C+sLOdqCj6EILyeYFkabs/kpo3k7yGWo8E1h3+epUpPPM7IZN0gzJU+Cel9W/hoeH
	 QPZHlTplpzjAHTu7hUIfxypHYcomMXkO1aaHOCnf3sJa+39J6FhcrzznVz99P1s/68
	 LvwmxN8+4yHEhJe7m3z17i7yLWCo4BHSyUZhmdYQ/YrGubPlGc/trxdf+eSpIvQMFD
	 0ebO4GIYrOpTMsa+dDOutQn+9JV2Xb1mJtJJCwiVjwvcVl5vnb4jzYi/L77OZd9kl2
	 8vZ3NoSbedpvw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Wang <00107082@163.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	maobibo@loongson.cn,
	tglx@linutronix.de,
	wangliupu@loongson.cn,
	lvjianmin@loongson.cn,
	zhangtianyang@loongson.cn,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 18/36] LoongArch/irq: Use seq_put_decimal_ull_width() for decimal values
Date: Wed, 11 Dec 2024 13:49:34 -0500
Message-ID: <20241211185028.3841047-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185028.3841047-1-sashal@kernel.org>
References: <20241211185028.3841047-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.4
Content-Transfer-Encoding: 8bit

From: David Wang <00107082@163.com>

[ Upstream commit ad2a05a6d287aef7e069c06e329f1355756415c2 ]

Performance improvement for reading /proc/interrupts on LoongArch.

On a system with n CPUs and m interrupts, there will be n*m decimal
values yielded via seq_printf(.."%10u "..) which is less efficient than
seq_put_decimal_ull_width(), stress reading /proc/interrupts indicates
~30% performance improvement with this patch (and its friends).

Signed-off-by: David Wang <00107082@163.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 5d59e9ce2772d..fbf747447f13f 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -82,7 +82,7 @@ void show_ipi_list(struct seq_file *p, int prec)
 	for (i = 0; i < NR_IPI; i++) {
 		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i, prec >= 4 ? " " : "");
 		for_each_online_cpu(cpu)
-			seq_printf(p, "%10u ", per_cpu(irq_stat, cpu).ipi_irqs[i]);
+			seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, cpu).ipi_irqs[i], 10);
 		seq_printf(p, " LoongArch  %d  %s\n", i + 1, ipi_types[i]);
 	}
 }
-- 
2.43.0


