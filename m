Return-Path: <stable+bounces-121349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED2DA56350
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 10:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE74C1895FDA
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 09:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072D71E1E0B;
	Fri,  7 Mar 2025 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PrZzu2Tm"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22671A8F60;
	Fri,  7 Mar 2025 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741338773; cv=none; b=j7pNuTV3fevLbFvXaD5Z+T7ZkvIDPusKNcUzCxF0TS68mRr4aJASLWnHJjstgN3GeTa004vDywjHjqrYaoBRTRhr/+RTKEj3Y5/ywrF+ZVdMevavEcngEU9w75DjWLFzidSRyAoz6ObQKFFlUbiLqt051uHIigiD+RwK+bSisbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741338773; c=relaxed/simple;
	bh=SI7/zfo5ZeW1S7cwDCksy4BuoO+WtxO6HWfPQp20Qec=;
	h=To:Cc:Message-ID:From:Subject:Date; b=A9CiBngo56uWQASA+/BcPgjBZIU/PCsP2SliZdV8KXwIRkuJjajSDHo3fTs2JkEjm04ppl57VkVFIdHoJMtWqJxXRpXHJd2CSJCrh1bvH0EYVSW7CwkKQqWDJ+l8zBnDJNegAwcQBlwQ8kG2H31lm3IxfM1HlHs9qy8hHne0/fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PrZzu2Tm; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E6162114010A;
	Fri,  7 Mar 2025 04:12:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 07 Mar 2025 04:12:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1741338769; x=1741425169; bh=hg3PLU/0C0HunaKuqzKlrTLma1Fo
	k3lK/tApVH6mYfQ=; b=PrZzu2TmVZzHwRZMKfKbOy3jtmB7DIBbdVm7Jsv/BwOp
	FjXDLjWijBZG65WRlzfKdX7mjWuHZaMNHVVo51d5LLV3gclEK0EfcL6IhYhz7mcb
	bY1KZ/wC0R4wqZg2HGh+lIgSDHwQ9ygfMznmKB9hAIDjn1ZLssGrvn59IzOZNMOh
	jfymPWlunWBvmD7i6fhlXeBUoIZ1t3Owfn4YPwEr+2Ek5xnPz2ujN5MD3bmXEd7I
	79Gf8Cuk/1r4qsr+URN9aZRNsj0JtC5uhg1oc+vx4Zmlcp6Ce+y21ANsoOgM4VSF
	yKq3FbSHovCbMpX5c0DeCnSI6kF4HluVn9JJqXdSWA==
X-ME-Sender: <xms:kbjKZ0laZAw_DfXw_Ax4hIsjzEO52Bnwseiuxp_lTgBtPO5Nv2jcTA>
    <xme:kbjKZz0jGkHdTKwA83nx7E9kubZae_B87dyfPZa3qtcALPU--pfot3YjXxieAw5Ec
    BUawVDnxsxjBW7KT5k>
X-ME-Received: <xmr:kbjKZyonZo1gpzJyhz4G7p3KXiJtlvWpqwVvljS-kKdZ3goc_WBdiUtDbOUQDjbXFaiBzJqwrIYUFvnkHaX1RP2D20TlijMULLU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepvfevkffhufffsedttdertddttddtnecuhfhr
    ohhmpefhihhnnhcuvfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorh
    hgqeenucggtffrrghtthgvrhhnpefgheduvdegffektdehjeejhfekieelleffgffgjeff
    hfffueefgefhvdevudegtdenucffohhmrghinhephhgvrggurdhssgenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhu
    gidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthho
    pehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhmieekkheslhhishhtshdrlhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:kbjKZwnVSccfYx3he3o3jtcVXBtcm2thVSsuO5s4g_kZsjLSFSgTuw>
    <xmx:kbjKZy2PZZ7PJyGMCTuOvfFLc4M8EMtqQPMK1__XSOV79-T5HlqlWw>
    <xmx:kbjKZ3sAQzQtC8j8bufK7unYyfLDpgUtquNswau4ngPrNqsTtEGsHQ>
    <xmx:kbjKZ-VH9wCx1M5z1vfAByKu-xJPVNqqwv4pkXy4mk4L4AyjAbQTBQ>
    <xmx:kbjKZ3zaXrYUoLoP5FKU-TJZwYd3_CdtSvCrplvW5y9l83P8-5YdHu0Q>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 04:12:47 -0500 (EST)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: stable@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <c03e60ce451e4ccdf12830192080be4262b31b89.1741338535.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] m68k: Fix lost column on framebuffer debug console
Date: Fri, 07 Mar 2025 20:08:55 +1100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

When long lines are sent to the debug console on the framebuffer, the
right-most column is lost. Fix this by subtracting 1 from the column
count before comparing it with console_struct_cur_column, as the latter
counts from zero.

Linewrap is handled with a recursive call to console_putc, but this
alters the console_struct_cur_row global. Store the old value before
calling console_putc, so the right-most character gets rendered on the
correct line.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 arch/m68k/kernel/head.S | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/kernel/head.S b/arch/m68k/kernel/head.S
index 852255cf60de..9c60047764d0 100644
--- a/arch/m68k/kernel/head.S
+++ b/arch/m68k/kernel/head.S
@@ -3583,11 +3583,16 @@ L(console_not_home):
 	movel	%a0@(Lconsole_struct_cur_column),%d0
 	addql	#1,%a0@(Lconsole_struct_cur_column)
 	movel	%a0@(Lconsole_struct_num_columns),%d1
+	subil	#1,%d1
 	cmpl	%d1,%d0
 	jcs	1f
-	console_putc	#'\n'	/* recursion is OK! */
+	/*	recursion will alter console_struct so load d1 register first */
+	movel	%a0@(Lconsole_struct_cur_row),%d1
+	console_putc	#'\n'
+	jmp	2f
 1:
 	movel	%a0@(Lconsole_struct_cur_row),%d1
+2:
 
 	/*
 	 *	At this point we make a shift in register usage
-- 
2.45.3


