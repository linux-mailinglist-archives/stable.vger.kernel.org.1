Return-Path: <stable+bounces-100756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8069ED5A8
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 20:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DC5D280E92
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91098251AEE;
	Wed, 11 Dec 2024 18:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxnVUstg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BEF251AE6;
	Wed, 11 Dec 2024 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943212; cv=none; b=AtLV9DSbGQ2jMRYk2f1DjlxPIo+K8L3vYyvOvQN+UGiiOVBuT2oOEgLwPVHxIlCoOwcOBRMUmOg02wjaVkousjQcnLXEOTutD4Zge0upKei30W7d5/83OkLhAyv3zWbghYSkHrrfEUhzDk3v3arWWoZW0DUsq3W1Q5a8N7ukMHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943212; c=relaxed/simple;
	bh=X3wiaJxIS4lxBQlb7qMsw8iFHOWvQiEHsMe0A6POmJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKqKGd1gaD87XIsO7Z5RpvNbKZHoe3Xgh2PokaASwyKas7B/HxOu2mtkruUV4OEUL46NgZSixFcvmNT8eM+HccF9QR2vD0KhN+Ku8era4DNSDj+UZRhDSFfxJKLUrrykNFRabLAsXC76b2K06eDjx1DB9IJHRybHpKSTmaZUouk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxnVUstg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BAEC4CEDE;
	Wed, 11 Dec 2024 18:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943211;
	bh=X3wiaJxIS4lxBQlb7qMsw8iFHOWvQiEHsMe0A6POmJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HxnVUstgkTeRZRJcOZBhXEHH7dfxHJPOH81ybdMWNc7WcAc/FHXQMAoIZ+ItBqAw3
	 pAoUQI7LgpOjpOqk8Xx7Dsq8f/C0ZTAsV0Pa1eUvNlT1HZtqnGjrCte4zDVlwie4b/
	 iuqvIQU1tiP5SYmc+WLCG6+WXrKRxP0NIWQZ/5IZfeorPp0nmKm+gPNbsRUq6eKda/
	 H/3O+6SvnsveRsV6p/cXpL8UL4dj7hEay8OwV3rwkw/iD25hy8SDNf3wMVbggqL09O
	 tD/Ui7eChz/muWj0dhnRe9KjzEgRD3lytcO3gYJit790/UCL+xVnbxHjNM8+3a91Ko
	 dZMa318FQFHqg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Wang <00107082@163.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	tglx@linutronix.de,
	maobibo@loongson.cn,
	lvjianmin@loongson.cn,
	zhangtianyang@loongson.cn,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 07/15] LoongArch/irq: Use seq_put_decimal_ull_width() for decimal values
Date: Wed, 11 Dec 2024 13:52:59 -0500
Message-ID: <20241211185316.3842543-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185316.3842543-1-sashal@kernel.org>
References: <20241211185316.3842543-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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
index 18a2b37f4aea3..6e361de705e48 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -84,7 +84,7 @@ void show_ipi_list(struct seq_file *p, int prec)
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


