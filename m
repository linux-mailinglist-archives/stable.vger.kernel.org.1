Return-Path: <stable+bounces-110126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC4FA18DCE
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 09:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A59807A51CC
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 08:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6358E20FA8F;
	Wed, 22 Jan 2025 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ycserzwV"
X-Original-To: stable@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D29153824;
	Wed, 22 Jan 2025 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737535709; cv=none; b=pu8sG8TerkK6usW06z98hqgzllFM13BPirDwmirDz9ciwyu1ze2uzzX/AyARKlYGU7b8GTubAu5Phb9TOOwe1Tp8uF2HsBxTLA6rH5bFObDJmYtG/6EGpLiKXsy4cWaIDkzVGjoaToG1UTYCLknTy4+IjpqHdUHOmMrLqy2fDdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737535709; c=relaxed/simple;
	bh=xrG9LIF/fHfeOPNdl6wGssMUkqv/ZQNpmH3fhzp0TT0=;
	h=Date:Message-ID:From:To:Cc:Subject; b=av5PRmB+O9HYaLkLwnjlcNXa189RCnsu/yBpJ7wVdLctars53HumZB6uqETIcg9NL1HQdMW1N3uXcbODhdc3B+B8L2XrvUuDW9rlKTnJzWppBvmmRvKuXQAbdFXHRFidqoUttRbP4vcZefjjpUK1hahn0a2vetlXJbfelZ62N4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ycserzwV; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 02F2A1380178;
	Wed, 22 Jan 2025 03:48:27 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 22 Jan 2025 03:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1737535707; x=1737622107; bh=8lLsJIqL/6PoxS2ijobyqT6bj4Vf
	imlESCZI8eca0q0=; b=ycserzwVsWzha6oqp2MeCpSBxiY3jHlA2qo6ErMglRr4
	QtCD78dw+pCKwKxZBtBEOAGaNT/GLZaAJ5UieXcRBt0jOKG20ByVNT74qsfVA/lN
	J6JNxcBq3Okh4i4kUHUYz26JW8Uo6uE3/FclnRFK4hYV7jRGx/A9Is5Ng3CTZByv
	/hr3tP57gk/DBaMAgKnDcgjL5aSN//7de+Ha+Ki/BmYo5fPHOkSNAEEauldLG4xM
	rZaZQMAGaKO2Kjbc5rMLircjTQo0MSNigM+kUVZ08WK0GAXo8BFAsdnCRxheSXCt
	7wheuJihJcsewvBBHwz6aAymcz1Y31ViPcvlhjIV9g==
X-ME-Sender: <xms:2rCQZ0VoSLxNJ1zB69VJPNHs9bS-Z0-9HLmi0biiIkX3Ww5MWPe0HQ>
    <xme:2rCQZ4l_FHZThmQeSNP8tiw1idp-o4BbRx5vz2cWmto7AXh3JTvXoQ6l5kgcsxXzv
    Z44Aj9_y6m7GwuSGHo>
X-ME-Received: <xmr:2rCQZ4a7-wgrx6NDae7pK1yCwrFfUqsH0c0aOQ3Pbb7AIFXAX1-aG3NCf8TcwwQt3E9yaJk_Coma-C43EX6Ml_wp-D4Cy7OFsns>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffkffhvfevufestddtjhdttddttdenucfhrhho
    mhephfhinhhnucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
    eqnecuggftrfgrthhtvghrnheptdfhleduudejjefgvdetfeeijedtfeeukeduteeuffeu
    veejieevhefgleeuffffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpshhkvghlvg
    htohhnrdhssgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhope
    ehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdroh
    hrghdprhgtphhtthhopegvsghivgguvghrmhesgihmihhsshhiohhnrdgtohhmpdhrtghp
    thhtoheplhhinhhugidqmheikehksehlihhsthhsrdhlihhnuhigqdhmieekkhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:2rCQZzWoFFZBiS5JBvxxbZRolyOGD6LiRnFFRS4W385cSlgck0naGg>
    <xmx:2rCQZ-kAC3kng_Tpi9fT3OgzSdwDFg31vxd2i2GYuPmn0BnVAimZpQ>
    <xmx:2rCQZ4dVM9Ich7iQO2BCyFL2n35tVaIqThQh65LyJzn5Tu6xCEfkmw>
    <xmx:2rCQZwFGxPurWjOWs5bkxDslWk_QdZecTZhm-3F_NueH-hVfDyFCuw>
    <xmx:2rCQZ_Az3m2L6bBlAxJoOQmXYBpSAbNRiP6cUY9hg4IubTkdiAQZQwLG>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 03:48:25 -0500 (EST)
Date: Wed, 22 Jan 2025 19:48:18 +1100
Message-ID: <dd7ca3ed8cfac012d6001fe4d3e8d604@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
To: stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Eric W. Biederman <ebiederm@xmission.com>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5.4.y] signal/m68k: Use force_sigsegv(SIGSEGV) in fpsp040_die
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: "Eric W. Biederman" <ebiederm@xmission.com>

[ Upstream commit a3616a3c02722d1edb95acc7fceade242f6553ba ]

In the fpsp040 code when copyin or copyout fails call
force_sigsegv(SIGSEGV) instead of do_exit(SIGSEGV).

This solves a couple of problems.  Because do_exit embeds the ptrace
stop PTRACE_EVENT_EXIT a complete stack frame needs to be present for
that to work correctly.  There is always the information needed for a
ptrace stop where get_signal is called.  So exiting with a signal
solves the ptrace issue.

Further exiting with a signal ensures that all of the threads in a
process are killed not just the thread that malfunctioned.  Which
avoids confusing userspace.

To make force_sigsegv(SIGSEGV) work in fpsp040_die modify the code to
save all of the registers and jump to ret_from_exception (which
ultimately calls get_signal) after fpsp040_die returns.

v2: Updated the branches to use gas's pseudo ops that automatically
    calculate the best branch instruction to use for the purpose.

v1: https://lkml.kernel.org/r/87a6m8kgtx.fsf_-_@disp2133
Link: https://lkml.kernel.org/r/87tukghjfs.fsf_-_@disp2133
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 arch/m68k/fpsp040/skeleton.S | 3 ++-
 arch/m68k/kernel/traps.c     | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/fpsp040/skeleton.S b/arch/m68k/fpsp040/skeleton.S
index 31a9c634c81e..081922c72daa 100644
--- a/arch/m68k/fpsp040/skeleton.S
+++ b/arch/m68k/fpsp040/skeleton.S
@@ -502,7 +502,8 @@ in_ea:
 	.section .fixup,"ax"
 	.even
 1:
-	jbra	fpsp040_die
+	jbsr	fpsp040_die
+	jbra	.Lnotkern
 
 	.section __ex_table,"a"
 	.align	4
diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index 35f706d836c5..c6f18dc5884b 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -1155,7 +1155,7 @@ asmlinkage void set_esp0(unsigned long ssp)
  */
 asmlinkage void fpsp040_die(void)
 {
-	do_exit(SIGSEGV);
+	force_sigsegv(SIGSEGV);
 }
 
 #ifdef CONFIG_M68KFPU_EMU

