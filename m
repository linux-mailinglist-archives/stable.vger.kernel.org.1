Return-Path: <stable+bounces-172769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADABB333D5
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 04:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94BF017C9E8
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 02:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D620A221736;
	Mon, 25 Aug 2025 02:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jkCBQaeW"
X-Original-To: stable@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EF022576C;
	Mon, 25 Aug 2025 02:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756087534; cv=none; b=NbjEUqZ+r9rl8YRpggRCDF+4gNJAL9lNt99ziXqwEeQaD+qv9c6+g5NLuew6lU7ko3VXcdN8wdd4rqQ3kt73Iv2OVSLwur2mipm4cQDjEY1drtk/gc9GLDoIh/FdtK/miDeMqxive+8qftQ6BM+enwry7/oSSnq3X+yFiVkHm10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756087534; c=relaxed/simple;
	bh=jRE0j/a3Blw5jBzPmdqmicKxGpOIJhBd9aEt46ekE8w=;
	h=To:Cc:Message-ID:From:Subject:Date; b=blOYsH5NGKSYsytK/t0SWmCeBoeLtgTfZjUFA7TeGAJa5Ei8od1zQ9sgPgZIRN1Xi8v3o55Sp4i4DJt824NhhCelzIvSbylVG2W6/NkbVu6ja/ernC008pZVDoNE6ge4RkfQou+A8F+YcwTh9oXUc1+j1ERAN1aKb+7WGcdg9eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jkCBQaeW; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id E3AC51D00067;
	Sun, 24 Aug 2025 22:05:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 24 Aug 2025 22:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1756087529; x=1756173929; bh=voARBgy3yx2HVaACbb8e7bteXCgR
	0SdI2PllfVi1VYk=; b=jkCBQaeWkjCpG1BqyqE9iUJVlv5bsJJ2HDilUQ0ACr4m
	1dVvtykKrU9iNo5k2yEoqkxhwMgxzSQR/3trTEvGaJ3ha3NSNNxQBJ6ZRlQPU1zL
	EVItXdRyNAgneww5s1t1W8cygfvw6vsnURSRNQEoJ8bnW47TNCuaEpyYHaQUBMCv
	f15EKPIsXkyRS6eFWnGJSroHMntk7hyF2Khy4MoD5SIrG0ifxt5G8u4ReI0A9EG+
	ADxXfjtHBZGoF41tP67ZBO09ssku/l8tgZO0rDGUbmsjjYzjEB6pYE0mgcszsSmV
	dRvqhX5IW3JTYJF8ByjojIw2/w42Woqqm5TTQR4n+A==
X-ME-Sender: <xms:6MSraLFGnPpNIoSVFu_rv9SGHpbKf9aaX6vgTHaSDQgfQ23361Zmdw>
    <xme:6MSraC9PuUbW8u10ErM0X3ixRliV8-ZXAewSLyjK1Gh5HJ7nVDfe--iteual1EulF
    nJIgmuyzsLQ1hvWyAk>
X-ME-Received: <xmr:6MSraDKnAG3iOInLTndKNAFwbOMi8rcbCxHM-T_QNxWTDs94y2eit3twqO9hTmVXwgwDLsE2Wq7HmMNdZbPOoAnRLVbKnFMRCaU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeduudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepvfevkffhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghinhcu
    oehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrhhnpe
    ekffejgfehheehkeekffffveekteevvddvveelhffgffetteefgfeutdehleetheenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrghdp
    nhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghkph
    hmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlrghntggv
    rdihrghngheslhhinhhugidruggvvhdprhgtphhtthhopehgvggvrhhtsehlihhnuhigqd
    hmieekkhdrohhrghdprhgtphhtthhopehmhhhirhgrmhgrtheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepohgrkheshhgvlhhsihhnkhhinhgvthdrfhhipdhrtghpthhtohepph
    gvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:6MSraIsYnUYfkrNA3bAy28j1s24RmytNegZACNFlHr4WWHgdmuUT4g>
    <xmx:6MSraCA84Nb8T58XzY2F9v3-JoXtXa-fUf4709pReOhmmNE8jU7_Wg>
    <xmx:6MSraIOSpJSyVl8AmGyceQgDK7Q7RmNXP01UrV-1u5LSw5ztm-AtgQ>
    <xmx:6MSraCAV7QBrT5wXKirU9XjlmYUBCal_u2EJYfMJo9afGAh0ff5FPw>
    <xmx:6cSraFvqtx2G3U_PnXk4vZ8fa9Ji3RYm3Sx7r53A1UIurqIfQQZhYoN1>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 22:05:25 -0400 (EDT)
To: "Andrew Morton" <akpm@linux-foundation.org>,
    "Lance Yang" <lance.yang@linux.dev>
Cc: "Geert Uytterhoeven" <geert@linux-m68k.org>,
    "Masami Hiramatsu" <mhiramat@kernel.org>,
    "Eero Tamminen" <oak@helsinkinet.fi>,
    "Peter Zijlstra" <peterz@infradead.org>,
    "Will Deacon" <will@kernel.org>,
    stable@vger.kernel.org,
    linux-kernel@vger.kernel.org
Message-ID: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] atomic: Specify natural alignment for atomic_t
Date: Mon, 25 Aug 2025 12:03:05 +1000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Some recent commits incorrectly assumed the natural alignment of locks.
That assumption fails on Linux/m68k (and, interestingly, would have failed
on Linux/cris also). This leads to spurious warnings from the hang check
code. Fix this bug by adding the necessary 'aligned' attribute.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Eero Tamminen <oak@helsinkinet.fi>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: stable@vger.kernel.org
Reported-by: Eero Tamminen <oak@helsinkinet.fi>
Closes: https://lore.kernel.org/lkml/CAMuHMdW7Ab13DdGs2acMQcix5ObJK0O2dG_Fxzr8_g58Rc1_0g@mail.gmail.com/
Fixes: e711faaafbe5 ("hung_task: replace blocker_mutex with encoded blocker")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
I tested this on m68k using GCC and it fixed the problem for me. AFAIK,
the other architectures naturally align ints already so I'm expecting to
see no effect there.
---
 include/linux/types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/types.h b/include/linux/types.h
index 6dfdb8e8e4c3..cd5b2b0f4b02 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -179,7 +179,7 @@ typedef phys_addr_t resource_size_t;
 typedef unsigned long irq_hw_number_t;
 
 typedef struct {
-	int counter;
+	int counter __aligned(sizeof(int));
 } atomic_t;
 
 #define ATOMIC_INIT(i) { (i) }
-- 
2.49.1


