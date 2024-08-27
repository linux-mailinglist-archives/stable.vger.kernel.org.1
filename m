Return-Path: <stable+bounces-71258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A53F961297
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39913B24D33
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B96E1CE6F8;
	Tue, 27 Aug 2024 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="koTEZkxf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D6DD517;
	Tue, 27 Aug 2024 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772617; cv=none; b=uoUeYF11t4edT9A99ZH1/EHp9VqjPl3pC7O+la3pwy36Xr44mT7PAC0vVlqU9BVAX3lqb/6tt/JqoaS//JavDjFZSyvwP5uQzB0YO00b+h14OIYpxxgqwTBxJ+AmgiPhena4Gb+QS++9XCKpefb2nwz17KLB7YMTFIHg4ISh9Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772617; c=relaxed/simple;
	bh=HhKGzgy+cVa4kgMw/YXbfcUM94Kn1uEJjdSHKXmRDi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oeFEk3eLJBxT0vC72KPvbhxhCxLMYUFGLxcX7U7hMA1a4tzM1LMidl2RWRjtlyXlIpeb9MVpQJfgD26GIfiL3XHcJZOb3JpnFOXSE0XqH56iaGoXf5tiB0Bo3/s/B98/ayOO7m8LbFotUnnDZL7L16qGjGg8D2xIf6P+LtIa45o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=koTEZkxf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFFEC4AF65;
	Tue, 27 Aug 2024 15:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724772617;
	bh=HhKGzgy+cVa4kgMw/YXbfcUM94Kn1uEJjdSHKXmRDi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=koTEZkxfpxi6FrtSgzfmj99oAE2/mAoDBNDZM4fKPaspDfySlgDhsF2IwfYVHkznI
	 7zLHZDkNTRDKTqNTyJY6n3NVGwNvPgv3g/TEEeR30+cx3uBmiyOFp4uxhQBcv5oIEH
	 kj1wTeGDOU7/dEsDNtSfAVESuYesvzHopdrw6GMg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 6.1 267/321] MIPS: Loongson64: Set timer mode in cpu-probe
Date: Tue, 27 Aug 2024 16:39:35 +0200
Message-ID: <20240827143848.416378818@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
References: <20240827143838.192435816@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

commit 1cb6ab446424649f03c82334634360c2e3043684 upstream.

Loongson64 C and G processors have EXTIMER feature which
is conflicting with CP0 counter.

Although the processor resets in EXTIMER disabled & INTIMER
enabled mode, which is compatible with MIPS CP0 compare, firmware
may attempt to enable EXTIMER and interfere CP0 compare.

Set timer mode back to MIPS compatible mode to fix booting on
systems with such firmware before we have an actual driver for
EXTIMER.

Cc: stable@vger.kernel.org
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/kernel/cpu-probe.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1723,12 +1723,16 @@ static inline void cpu_probe_loongson(st
 		c->ases |= (MIPS_ASE_LOONGSON_MMI | MIPS_ASE_LOONGSON_CAM |
 			MIPS_ASE_LOONGSON_EXT | MIPS_ASE_LOONGSON_EXT2);
 		c->ases &= ~MIPS_ASE_VZ; /* VZ of Loongson-3A2000/3000 is incomplete */
+		change_c0_config6(LOONGSON_CONF6_EXTIMER | LOONGSON_CONF6_INTIMER,
+				  LOONGSON_CONF6_INTIMER);
 		break;
 	case PRID_IMP_LOONGSON_64G:
 		__cpu_name[cpu] = "ICT Loongson-3";
 		set_elf_platform(cpu, "loongson3a");
 		set_isa(c, MIPS_CPU_ISA_M64R2);
 		decode_cpucfg(c);
+		change_c0_config6(LOONGSON_CONF6_EXTIMER | LOONGSON_CONF6_INTIMER,
+				  LOONGSON_CONF6_INTIMER);
 		break;
 	default:
 		panic("Unknown Loongson Processor ID!");



