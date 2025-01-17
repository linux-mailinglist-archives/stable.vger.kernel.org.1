Return-Path: <stable+bounces-109327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B02FA148A5
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 05:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F0C716B273
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 04:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AF71F63DE;
	Fri, 17 Jan 2025 04:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="COF+b5Fn"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-63-194.mail.qq.com (out162-62-63-194.mail.qq.com [162.62.63.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BED22338;
	Fri, 17 Jan 2025 04:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.63.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737086452; cv=none; b=dzMAXxLAqTZtZ2h060v61Br5lbPPmw2ZiNM9gh4/ambnXcAjvr2Y5x2qBMgF1G7+7cEtEGGBQEXOISjEj8QjnbA3A9wuqyMjQ0GeEIuWAvfA6CmYUaXzht07dTYu1DG2uv6IwETUQcrll5KbUWQNMkixh5Z5a+YILxkjuREwets=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737086452; c=relaxed/simple;
	bh=DtCukCvfesqYwwk1NG6ak37+tEIeVyg1aWAS2tuNbMc=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=gm1lXQ/FBRqCrVmfLH51HjhBVJUh14WsWYBSYw56DfXiZIMaVXN3pES8TAChoZG4gYsj84efg9vvhxBCUOILVFcyc7RIzfy0AkrSR35CmqC97vbzTadCNF7G2pJSsHV5pvAXDOGaFLnUCgIp8zPGDWLAs+MehKMwMgZhbGJo39c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=COF+b5Fn; arc=none smtp.client-ip=162.62.63.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1737086434; bh=/+rtWKcCLn/Cu93OBLz7j1Rt6rH+SNavHX1FpALhJSY=;
	h=From:To:Cc:Subject:Date;
	b=COF+b5FnAgbVPrE3jXG0ubqb6CdH0oaRvrfOe43d9kKxK0WA0a3FOyk7BJLXKJ5uw
	 3c0irAOEzcHqwKrZZY1vqPJPUNutANRDPcGtVf0ec7i0P26nzED94yL47WmRLKOzuz
	 j4529YRJGXFmhFboCB3K1AEp7LLRSprXvT3qJ1RE=
Received: from localhost.localdomain ([116.237.13.216])
	by newxmesmtplogicsvrszgpua8-1.qq.com (NewEsmtp) with SMTP
	id 1F8EE19; Fri, 17 Jan 2025 12:00:31 +0800
X-QQ-mid: xmsmtpt1737086431tkpe6do49
Message-ID: <tencent_9DCAEBDF4D9BCDB4687B502DB6B608E4FB0A@qq.com>
X-QQ-XMAILINFO: N2T7jyym4eG7X9LX5KZWWl5V7vOxB2YQG9jMMQ7T61G3EQmbo/ibpbelN0eq2I
	 a/KlrK5GiETi+6ZJTO9C2ZP1nLYorrlz9OfJASzDZdDaBU6I3xpMHuv2+ND4ocXIexYyUMpzNTnW
	 QjE78JGFh6dTsHuEVtK5H+IIIgh+63kYwMgQAP6ZcWK0JQFKSc7BP7TDxsq2Cb3xuthGrNj1DNi8
	 cr7XTqncXkU56D9v1SKwPc07vUYP0kH1UG4/BaKXRynv+b8up+s+ZAJsKxMQxFtmL2jhxT6zfZMn
	 1bijXBd6IDAIR9NrWsTX01wBiKrPyPUoOQmn+WsujG1hnZqgO84L3yjGRSWJoHohB4aQJQtu56V8
	 1f4wsB0Nw0XPHOYJsXxPBerPs03XVXnkSBkTx8E8A1m/UB0+tUHuYr1o7nXNTrWxOTonnI7V+x4i
	 0CleXEQ4BM14fM5/dkAc4Yzy86EamoRJ7Nd8fWkfv0BFZjAB/6nelLS3WYLm6CyGyyKFi0HNNdu1
	 7dR30dYLCDl4AuLkmD3yTn9ABWEKjPfitaNzuPG6nGabpGWYvP94/V+i70iAKWqxrCUqhyeSGYdd
	 L/yuECc4X0Utd25pAd4TkC5Hwd+foNYnaq1LN8wZCfki0G8dVwxHLIAoDH+whECgtl9y3GVzopKb
	 1Y4QYQzoz5jV7z0BY2gkGsyz99RL1wPtwdbCK9Vv9Fh7Qn24Vtky34K8Ii6ChPvxgkRTQpD+cUwt
	 vRzgu9+Q3JcViU+IsS39UFtEpiF7eqR2gU3Ut6B/v3lw8OygeWqFtqVj5jdrzWzXzVdwv0b3AP6l
	 ysSOSLa1MRqjTm3tSYH8w6ehNh1bOjmIiUgqfM80t5wPVVwuaKal03T4EU4LvR3PRj4j1CtBO1Sc
	 iTi78GTcbRfS1ZDO3v39pCISOGCpGWtSxFwHTKK112brXOMxmTeJ1+a51n0L+9z0FRgKVGRMe8O7
	 tobKZU14s=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: 1534428646@qq.com
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: mark.rutland@arm.com,
	kristina.martsenko@arm.com,
	liaochang1@huawei.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yeoreum.yun@arm.com,
	"Yiren Xie" <1534428646@qq.com>
Subject: [PATCH] arm64: kprobe: fix an error in single stepping support
Date: Fri, 17 Jan 2025 12:00:28 +0800
X-OQ-MSGID: <20250117040028.763587-1-1534428646@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Yiren Xie" <1534428646@qq.com>

It is obvious a conflict between the code and the comment.
The function aarch64_insn_is_steppable is used to check if a mrs
instruction can be safe in single-stepping environment, in the
comment it says only reading DAIF bits by mrs is safe in 
single-stepping environment, and other mrs instructions are not. So 
aarch64_insn_is_steppable should returen "TRUE" if the mrs instruction
being single stepped is reading DAIF bits.

And have verified using a kprobe kernel module which reads the DAIF bits by
function arch_local_irq_save with offset setting to 0x4, confirmed that
without this modification, it encounters
"kprobe_init: register_kprobe failed, returned -22" error while inserting
the kprobe kernel module. and with this modification, it can read the DAIF
bits in single-stepping environment.

Fixes: 2dd0e8d2d2a1 ("arm64: Kprobes with single stepping support")
Cc: stable@vger.kernel.org
Signed-off-by: Yiren Xie <1534428646@qq.com>
---
 arch/arm64/kernel/probes/decode-insn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/probes/decode-insn.c b/arch/arm64/kernel/probes/decode-insn.c
index 6438bf62e753..22383eb1c22c 100644
--- a/arch/arm64/kernel/probes/decode-insn.c
+++ b/arch/arm64/kernel/probes/decode-insn.c
@@ -40,7 +40,7 @@ static bool __kprobes aarch64_insn_is_steppable(u32 insn)
 		 */
 		if (aarch64_insn_is_mrs(insn))
 			return aarch64_insn_extract_system_reg(insn)
-			     != AARCH64_INSN_SPCLREG_DAIF;
+			     == AARCH64_INSN_SPCLREG_DAIF;
 
 		/*
 		 * The HINT instruction is steppable only if it is in whitelist
-- 
2.34.1


