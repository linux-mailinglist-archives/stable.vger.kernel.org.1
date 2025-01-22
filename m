Return-Path: <stable+bounces-110124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D517A18DC9
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 09:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277B2188B7ED
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 08:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4AA20FA85;
	Wed, 22 Jan 2025 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pl9um91q"
X-Original-To: stable@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19F320F990;
	Wed, 22 Jan 2025 08:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737535700; cv=none; b=sT4xcvaPR2y1YIVZmFwkqxAKuoPY1ZddDoQ77cymuG8eJPW4jg+KVxVZ4n6GEYIzHZlEhOTmLkLwPIL2Ny9SuSwenFL3kEOSNfvVHdIcQVTSDX3BBgNL31kAo7lRWMPDE01d5/nNK5gHdM4EBxDLQVurPsEAxCC8gtovUMhkzSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737535700; c=relaxed/simple;
	bh=xrG9LIF/fHfeOPNdl6wGssMUkqv/ZQNpmH3fhzp0TT0=;
	h=Date:Message-ID:From:To:Cc:Subject; b=cJGVs/iBv9pH7leZdZ0OWDq30d4OL0jKJcxoitBd2YeknlLSWAhD851O2m7euJosOd/dnLt6mVHzeMEfxrDdO7KfB053Ji8p+y8cPit6id73h5VUcI6555BgTJ0dOsIDLoOJSFs5eHq/tuepOF+srimy0TMJbIr5iA400+EzahQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pl9um91q; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id CAA02138019D;
	Wed, 22 Jan 2025 03:48:17 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 22 Jan 2025 03:48:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1737535697; x=1737622097; bh=8lLsJIqL/6PoxS2ijobyqT6bj4Vf
	imlESCZI8eca0q0=; b=pl9um91qF4SJePfFscMXhJJL6J+jFmly0Xxex++NJenM
	zIPBF83va4ymEBHX07X7RC1QsaKgGB1Yh82QfEY2skYai2cDsjgyKHe8eTZNwBPQ
	LsgT9hiJm52bNyB8nQKgyD/uatysLoEhSKfHGGaf69Bat+gj3p8igxc0aX/BJOD4
	gX8gF+ZVP2Xir9w4Q+FQ07xhHZxfblc5Ym3CaU7ICY8xWLz6ysypcuWRFBcnVll/
	6lEU3UAJKAPvFHbpA7iTc8ZsQFv+m7FPfu8MiIddOzUrlnjrOqot9Ru95Q38WYET
	AU9t0mVN1hHJxUQjWB/OTrQ7OoLiau4SCIFGbA+Pag==
X-ME-Sender: <xms:0bCQZ_4OFtjuL4LFmjri-PTmIJuQhckE7ICUxH7pUFJFkViuNsO58Q>
    <xme:0bCQZ06y-jCa1yzz2HCFo4MEKnRftO1PiRv3ngbECNGRluEb8ILabs8Z9l9JrIs49
    GLTg48dQHGvKlQ7N-Y>
X-ME-Received: <xmr:0bCQZ2dXOBLaOQEwTwL4zuYgNUAmJlIZDrk9Ghf1KaNLtedPvr6kW-yccfOTXKoNKcmmymugxhrLhR-tglDCOjSIPtXbAnCPmYo>
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
X-ME-Proxy: <xmx:0bCQZwItW4pJd5Zi97qf8eeRbf-fwtAus8ac_IyibVCRKIPMIdw28Q>
    <xmx:0bCQZzK6XUknabjKXPL_l1ngubefnZznRVLQt7wO63zpW2cx3Lv-Ww>
    <xmx:0bCQZ5zPL_VLOUL-RUUL-PMwO9bkrReuRNaEB1wu_X1_wwVDkQUYKg>
    <xmx:0bCQZ_IeT3gw8jG4rm-UXszCSc6404RzS2oyV4vyC1yCkuDtdnGHew>
    <xmx:0bCQZwHaVsKpcIqiqqfjbB--EBIwjxC-Dz3T-bDaVw07NmTioJksPtqZ>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 03:48:16 -0500 (EST)
Date: Wed, 22 Jan 2025 19:48:09 +1100
Message-ID: <543c08353cd05bad3362e9c811ea6869@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
To: stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Eric W. Biederman <ebiederm@xmission.com>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5.10.y] signal/m68k: Use force_sigsegv(SIGSEGV) in fpsp040_die
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

