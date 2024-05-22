Return-Path: <stable+bounces-45600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0DA8CC8B0
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 00:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A9C281FD7
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 22:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6371474AB;
	Wed, 22 May 2024 22:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="yLv6Zc1C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eb/UX+9g"
X-Original-To: stable@vger.kernel.org
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51E0145FEA;
	Wed, 22 May 2024 22:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716415348; cv=none; b=TJ7u1yNld6rlJA5r7zQIewiyXIkDRVfNGQ44+4hxSnOwNTqMSZOwn3/G1VdknmlfprTZFepI1vEFm5N6NW1HtwV1qVeu4kC+Cq8D2u1DJ4+csXL2mbS7vQngDQgSTBtOp2g1MS4Jf58/uYw0doH2oCyxb117jJ1kRsOwphZEChQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716415348; c=relaxed/simple;
	bh=bV5a8vIs5ZyqDK7Cv5/U4BfY0cbpI8aMAyoT7FuVxIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iUnvVXsbDPi+IgIyF3gyAkUa9ARxXRVe6ZSkX035MhiAhLLAlmh1brr/dlPXegFuUvICJPyw3v6qiP7f760KmmtuSBCaeN4TMxJyJaXPBgbu8G4sgot0Aplc4oFoHksy4kb/c03971f+8bXTV9u4FEGpz5OkPNefd1/Oa7cbvHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=yLv6Zc1C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eb/UX+9g; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id F1C5C1C0015C;
	Wed, 22 May 2024 18:02:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 22 May 2024 18:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1716415345;
	 x=1716501745; bh=FkzvYbbtwbTq/IMNI6fnNl25+bgGMeKMwC6fOZkXiYQ=; b=
	yLv6Zc1CrvK0e6hDMvGwqAe9LREkNt3ezKRFs1f53rCgNVvkigIWykcKrgsngHbK
	3Z7u9f/PGbbehU+8ZC2g63ZGOPyoBFfxB9RPhNs4rAtD5PTrpelUjNzPsWOJsJjb
	CHOIOs65ykVpEvlg+gbpYKfxZVmfzCzH8nsJZUXzZdtTqiwQpF76Mtdg+H/KXfNh
	KybSMudHQqEiZtZTVXCJPVhq2lc/9UF7KpXM11weRgSWvGXGJ+ifEufFTl5Stsfk
	J5rcjVKX8ErgI30Lo+coKavpf30HoS7OC2h+j9hIbxxP8Vlpz6FY7nKwswgf5PC7
	BestVd4xWTEqZUO5TKzKow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716415345; x=
	1716501745; bh=FkzvYbbtwbTq/IMNI6fnNl25+bgGMeKMwC6fOZkXiYQ=; b=e
	b/UX+9gHdH3XgGWYyfE+YH1vtrwMLlFXebfqhNi7yNed4JwOdKHfHsPKJSm4SnJ5
	oOOnoq0a4BxJsbk+pmP9YuS6QFoRt6/A4RiL+RmG1ZKmvO1xs9tMxrP6dK3+EZud
	OcP7+g/pLXTDSc2EOIcSv/uVV32zcwjQAX1ND75JKpiZkzfC/zVS4Pj2QOHuIlo7
	HDXn+77EC64qy6XRwX3VtGsiRxBt+WUbLP5NWwACqT6wYilWh7yFyCicDIDEI3H+
	QIg9p2bUxvGrwuQSb82bs4NDgEhXPLKpACjAzwxj6iFBA0DkqzmXIBP0JsYi0HKq
	Ox3OAM32zSU2ImC2klqYA==
X-ME-Sender: <xms:cWtOZh5FqG8MjBK65IQjQ3bee5MUUJ70RqOCKlWrTr2fdVY8aYyM8Q>
    <xme:cWtOZu59XLyTRAxSiAK8DWyNL4h7_CpJx6h2M8faLli2bOv9jb5TZoeq3uV6iGl0Q
    a8zbpJNE2QoaJxVWig>
X-ME-Received: <xmr:cWtOZofKTb9RJRrKQVuRkXU1b8PaO7p5VtIE64VofoYh3e_kPmkAGcs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeihedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
    veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:cWtOZqLxa2Mj8ViSFYCbnuujgsLlggtReFAwejbq-d4PGT-0zHfUQA>
    <xmx:cWtOZlIyqckX2lasdfU8czab1AxTlWmXTIiU2-NsHhfBj3MclknVoA>
    <xmx:cWtOZjy1vuBkFol_cvN3Sic3NydJ_ohE4FwK8CS5O8wFmMNIrnRxJA>
    <xmx:cWtOZhKk9JUrmDPrbq6COKoI64WfYDwpxwjWoivewBdMANQ4WE64lw>
    <xmx:cWtOZt8tSecXNaK5jwBmRV0Pyo4Awiwe1j4230DMvXGS2z4OYiNuJ1Cm>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 18:02:24 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 22 May 2024 23:02:18 +0100
Subject: [PATCH v3 2/4] LoongArch: smp: Add all CPUs enabled by fdt to NUMA
 node 0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-loongarch-booting-fixes-v3-2-25e77a8fc86e@flygoat.com>
References: <20240522-loongarch-booting-fixes-v3-0-25e77a8fc86e@flygoat.com>
In-Reply-To: <20240522-loongarch-booting-fixes-v3-0-25e77a8fc86e@flygoat.com>
To: Huacai Chen <chenhuacai@kernel.org>, 
 Binbin Zhou <zhoubinbin@loongson.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1531;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=bV5a8vIs5ZyqDK7Cv5/U4BfY0cbpI8aMAyoT7FuVxIU=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjS/7Jylzhde9yt3RJXxCgo7TjN2sLr/ZI6r7OHIX5Fnr
 joolhR2lLIwiHExyIopsoQIKPVtaLy44PqDrD8wc1iZQIYwcHEKwE2exfDfV+QYU/OpOyW3uKrf
 nnpnNaEiemr2+7qtCn8/qtnNL9z0kpHhnNbPi//PcX/tWBIQXevZ0hKrdrvUVkB2/u1fasXqbeX
 cAA==
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

NUMA enabled kernel on FDT based machine fails to boot
because CPUs are all in NUMA_NO_NODE and mm subsystem
won't accept that.

Fix by adding them to default NUMA node at FDT parsing
phase and move numa_add_cpu(0) to a later point.

Cc: stable@vger.kernel.org
Fixes: 88d4d957edc7 ("LoongArch: Add FDT booting support from efi system table")
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v3: Move numa_add_cpu(0) to a later point to ensure per_cpu
is ready.
---
 arch/loongarch/kernel/smp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 0dfe2388ef41..1436d2465939 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -273,7 +273,6 @@ static void __init fdt_smp_setup(void)
 
 		if (cpuid == loongson_sysconf.boot_cpu_id) {
 			cpu = 0;
-			numa_add_cpu(cpu);
 		} else {
 			cpu = cpumask_next_zero(-1, cpu_present_mask);
 		}
@@ -283,6 +282,9 @@ static void __init fdt_smp_setup(void)
 		set_cpu_present(cpu, true);
 		__cpu_number_map[cpuid] = cpu;
 		__cpu_logical_map[cpu] = cpuid;
+
+		early_numa_add_cpu(cpu, 0);
+		set_cpuid_to_node(cpuid, 0);
 	}
 
 	loongson_sysconf.nr_cpus = num_processors;
@@ -468,6 +470,7 @@ void smp_prepare_boot_cpu(void)
 	set_cpu_possible(0, true);
 	set_cpu_online(0, true);
 	set_my_cpu_offset(per_cpu_offset(0));
+	numa_add_cpu(0);
 
 	rr_node = first_node(node_online_map);
 	for_each_possible_cpu(cpu) {

-- 
2.43.0


