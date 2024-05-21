Return-Path: <stable+bounces-45537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAA98CB494
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 22:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BB9A1C219C7
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 20:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC62A149C49;
	Tue, 21 May 2024 20:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="yIH9eNAQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RNpzSdDS"
X-Original-To: stable@vger.kernel.org
Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E477149C4D;
	Tue, 21 May 2024 20:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716322344; cv=none; b=Ui+Ntaiv8ct61jMFA/fmOTKNGyDeo8Qh9vIVOUlAdt+PwlkBSowkPUSxT9kkmFNT/z7TMFy2UkpMh9GwtvhXXc3LBGAW2yflzClcfr+Pz9182r4XhbYCZQRY6FdDjOCoWaqMUJvVQ0NhCNboaKHwrysQ5mecYCvEjZIuvz8V+0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716322344; c=relaxed/simple;
	bh=yVZuZGhQZlh0GBb5JOMcxygXqnWx2vLCWpjVfeLHzuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J5cz1PlH1OMcpBYJIdJcxkPsQk8H5hHOChgsUtEnGExX4mEy9NxBLS2EsKocw5unUrvOfXwL7wcTfu2RCPP/V1ukTntWi5xiEK0wlB1aiEWULj3hBciz7/TMIvhOEexcWFjs7v2GXtWgGItX//zxuf+da9xtKedfx+UaODhIdGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=yIH9eNAQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RNpzSdDS; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 143A118000FE;
	Tue, 21 May 2024 16:12:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 21 May 2024 16:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1716322341;
	 x=1716408741; bh=p2kGiIFKBT2fprtsSCD0V29yACfwyWhwUJ1YJx6S6zY=; b=
	yIH9eNAQsjg5W2u0uBhrbqcAOJjBmPfDIrQ6EdQAVz+feWyeN6fwoXAn+9oCChYK
	DYLkS5RYqZeAUu8lAOiC755Vwde2csY+/aFJocxCL/DPt+zcIbZF51/CxrfKuO/K
	JfvuxWRK7kTzF91IRoZLAjfd8uQHgfV5Le7lLx1E40rCtuAQz8dn8ARktdv9FmEv
	Av1gTMfdl+kqgZfgwiRWu+jGRX2W0Ds7f8WKr7ECXi0NEkWatGr3u2GbRzGCEsXT
	+6JK72YLSizGEBzzZctY53Q7v4STRe+FAbX2dFot3wvlddwnr/shs3x8f7hjCSmi
	0gfxLIV1wsh7lZUi3q2m3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716322341; x=
	1716408741; bh=p2kGiIFKBT2fprtsSCD0V29yACfwyWhwUJ1YJx6S6zY=; b=R
	NpzSdDSLzGY6oadjEvc/P3bJJURFBN2+UJaqGAREEN2juEPrhXk+hrecyi8aY3Fn
	i3Ixr7/QJmxTgYyDKgqgdf1ifKmi2W1+8ChgkAJiKoCfvjO///5V6r1mwfTKTsWN
	g/EoQATSALOnhREv5n8AUa0M8YGUJhCB76ZIgd5Tg9MwRg8Fk/eO9tOqShLkLzgz
	3VkGlrcAY6nuzL6FEMN9Gx+Vuoa0dEdt4CzzxnCiysEc6xG/FWRxV56zA+iEKAjx
	pmM5LD9xBx7kbMqTzyZsXoL2rXxuZH9HFVSPD8wzwyVxWgDs8IxHRXlvr5odGr/l
	5mDSc6XLjI4aA/ri+n5vw==
X-ME-Sender: <xms:JQBNZmM0fzcHcTKa58E-6ljvVCJMLKlk-xOsxYt2m77JLmKz2yPVXQ>
    <xme:JQBNZk9cdFcg9Zx8Z_s80DXV5EOfOFn_vhvDbHVlSGMSiDiK4riVsBvguYp_9vHuX
    jL02CvS0sBtQ8wp2Lw>
X-ME-Received: <xmr:JQBNZtSfrll9323p4Yc8JaRsLn3fL8O5TtaSepHZ5aip60dc-_TdWNc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeivddgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
    ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:JQBNZmvxRYdp-fZcCcsewZETZJD8C4P7rZaApLrDeSWlNAhqQyF3qA>
    <xmx:JQBNZuewlQTureEZcs7_f3dwcmzeSJpmNp_Y67146a0y8EjHsOmoaw>
    <xmx:JQBNZq14hlgMu-tR2zVSuCsEZhuPsDWGuKzVAIM80q36sQN6vRZr6w>
    <xmx:JQBNZi9hxjlBFN2ttjgz2LKNZ_UqY7U-qmvrgcgTt34iMomVZtd-QQ>
    <xmx:JQBNZmR4_p2OLaRLL7kgAUksAhcfrBkdcaBPKvU5h9vMZ5VYMmfqFYgU>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 May 2024 16:12:20 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 21 May 2024 21:12:13 +0100
Subject: [PATCH 2/4] LoongArch: smp: Add all CPUs enabled by fdt to NUMA
 node 0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-loongarch-booting-fixes-v1-2-659c201c0370@flygoat.com>
References: <20240521-loongarch-booting-fixes-v1-0-659c201c0370@flygoat.com>
In-Reply-To: <20240521-loongarch-booting-fixes-v1-0-659c201c0370@flygoat.com>
To: Huacai Chen <chenhuacai@kernel.org>, 
 Binbin Zhou <zhoubinbin@loongson.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1173;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=yVZuZGhQZlh0GBb5JOMcxygXqnWx2vLCWpjVfeLHzuM=;
 b=kA0DAAoWQ3EMfdd3KcMByyZiAGZNACChHjrVcsyIHyzheKMNj1SUKWaWkZhhLmsXhkYGfdMve
 4h1BAAWCgAdFiEEVBAijrCB0aDX4Gr8Q3EMfdd3KcMFAmZNACAACgkQQ3EMfdd3KcMsVgEA3Rz2
 35ZT8Tpot634lFZd4LP2GxGhbR/n7U+p0fLrqEIBALH0+M4jEJ3fyOz+IM4VzffcSxTHMAIC/gv
 yOPb0Ue4M
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


