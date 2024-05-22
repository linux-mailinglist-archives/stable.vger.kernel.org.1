Return-Path: <stable+bounces-45554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FA98CBB58
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 08:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5311C21EAD
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 06:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C5E79B8E;
	Wed, 22 May 2024 06:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="sKEp+mbL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O+xs9O7P"
X-Original-To: stable@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56B57BB19;
	Wed, 22 May 2024 06:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716359428; cv=none; b=j1cHjRpz9IDM/W36IpjbTUFjgUheKiY8E/DqWchwydZXqWeluN4XEaO3JWYaEk8Zc6LlYWHosTDNhrsQV4UCoKX1sn10BG8JC9YafICqQUhaefclcpF8otwu9mxSh744SMtcv00E6P4h9xFjEWUVu90Lga1Wuk9KTCyLu8P0XqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716359428; c=relaxed/simple;
	bh=yVZuZGhQZlh0GBb5JOMcxygXqnWx2vLCWpjVfeLHzuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i9tEEZzc6k+O+MRKKyQGXd+jfTq70EOA1SWG1h7rXlH8h6cqfsHAEZhoESTW2mn1OOPKEfebYcPAgMm9TwEDXMIznzDEfolJvB0YY6+XGFlkFBilUg9pR/+hYtq4mdTn091s9pftFwiejyYncy9D8JP7vTrn6zOXcAXajQrWxpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=sKEp+mbL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O+xs9O7P; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id EE30C138013A;
	Wed, 22 May 2024 02:30:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 22 May 2024 02:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1716359425;
	 x=1716445825; bh=p2kGiIFKBT2fprtsSCD0V29yACfwyWhwUJ1YJx6S6zY=; b=
	sKEp+mbL+1SBLXJxbQxpcLEtCe61MhItTeOUfSkS4At++p3TTyxzn96POgYe0rlp
	Z/OkPq6eWDnA2xdbYxS8xX+1pTbXv9FeIEE35T4plFpcio8Ta4QM/fd5NIzYeFX8
	jnwsYoEZfdNURrt55id9daj6ifRqfFuPHaidwqpf0I6xUTbDRSD0dCq8zPz3XLQD
	TCnxsjSgL3T53VZ1p3ebuqaoWQcwBEX0aKuJuTEGSg+QecU8PWeiePDoyQewjxgs
	2kCSavbigmplHG9CAc35H8nHEYNe2PQMQIAsMpp0S7amcmQMmIRimKHB3RDccfC9
	CHL7KqTK2Zx3AP5TC0EUfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716359425; x=
	1716445825; bh=p2kGiIFKBT2fprtsSCD0V29yACfwyWhwUJ1YJx6S6zY=; b=O
	+xs9O7POV4ctK95Xav1n+MZfyzxptnN8L0mpWyoj1s9C3Jc1rS4y8UAgUwGI7GnJ
	mrySG6dy7M2/tgaElli+NWhHJ0oDZoGIgKbEw5qMzBFRpkpgQs5fZP64DHA5s4ga
	xODbMA6my83O/xyWQgSwNjOd74gYbaYDYKa/K81iBnuT0VGzBCDFM4fdJLedO83t
	35QPgGIK7AknQ5PdijYbcHZdxvxMVo19gFnJp4W11uIK9R4+m15yrKtTTCr5K/TR
	k+E/mw081LWLmyowJud9UVl2fkNXCpXSGwjQuIdBy3Tq16xQ1EGIDrVYDIJadenk
	ea26eWf11DZvtnFIv86JQ==
X-ME-Sender: <xms:AZFNZuy04R4IYYRwjYJixFHtr06-13ht2VJsi7gpc_xQ91cycrPAEw>
    <xme:AZFNZqQsLKgaYfodc0K_Usl8R521T2kglfOKHu-P0YYB9V2SYlqTCXis1PdQvJgUH
    qzPRWDMegNZYBFRd14>
X-ME-Received: <xmr:AZFNZgWyeqFzygvSZaAuebqFJ19ekrsDPb0q_9r3tjiGBc4gSetjbDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeifedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
    veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:AZFNZki2rbQlXleKJt0V0r8Y-Bi2pwYesoxj_I1bFZo5gvZqxwSdzg>
    <xmx:AZFNZgARX7ZPBcbmd6MOgNOhWCB0X4PvZY6UpXgwtBnYTZsDOCLCMQ>
    <xmx:AZFNZlLZpjyNhXTjl4alO7RSsBCXK8VRkNWApZHDrlDfppHTGunJwA>
    <xmx:AZFNZnDFf6ATTNhqknhnFseWop1YO6PCOOgbCpXDPDiEaNkPDi0dqQ>
    <xmx:AZFNZi0tFsHDJSfrMceRCJY0cjGAsy-6bS4GfN585OJ79oXZWAc_luTF>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 02:30:24 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 22 May 2024 07:30:21 +0100
Subject: [PATCH v2 2/4] LoongArch: smp: Add all CPUs enabled by fdt to NUMA
 node 0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-loongarch-booting-fixes-v2-2-727edb96e548@flygoat.com>
References: <20240522-loongarch-booting-fixes-v2-0-727edb96e548@flygoat.com>
In-Reply-To: <20240522-loongarch-booting-fixes-v2-0-727edb96e548@flygoat.com>
To: Huacai Chen <chenhuacai@kernel.org>, 
 Binbin Zhou <zhoubinbin@loongson.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1173;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=yVZuZGhQZlh0GBb5JOMcxygXqnWx2vLCWpjVfeLHzuM=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjTfCf/i38wyc/PVFnjwk2GbR9v31gbjL4vYWjeyLnDlv
 8zBaefcUcrCIMbFICumyBIioNS3ofHigusPsv7AzGFlAhnCwMUpABNZPZ2RYdVnSfZv8iZnIhm9
 TwtP+H/5/80tarkTHl57UWahl+5/lo/hv6fW0Vlcx7e3WV8pnjeposG/cgvrU979EvOnfFz77PG
 HDUwA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

NUMA enabled kernel on FDT based machine fails to boot
because CPUs are all in NUMA_NO_NODE and mm subsystem
won't accept that.

Fix by adding them to default NUMA node for now.

Cc: stable@vger.kernel.org
Fixes: 88d4d957edc7 ("LoongArch: Add FDT booting support from efi system table")
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/loongarch/kernel/smp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 0dfe2388ef41..866757b76ecb 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -273,7 +273,6 @@ static void __init fdt_smp_setup(void)
 
 		if (cpuid == loongson_sysconf.boot_cpu_id) {
 			cpu = 0;
-			numa_add_cpu(cpu);
 		} else {
 			cpu = cpumask_next_zero(-1, cpu_present_mask);
 		}
@@ -283,6 +282,10 @@ static void __init fdt_smp_setup(void)
 		set_cpu_present(cpu, true);
 		__cpu_number_map[cpuid] = cpu;
 		__cpu_logical_map[cpu] = cpuid;
+
+		early_numa_add_cpu(cpu, 0);
+		set_cpuid_to_node(cpuid, 0);
+		numa_add_cpu(cpu);
 	}
 
 	loongson_sysconf.nr_cpus = num_processors;

-- 
2.43.0


