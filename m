Return-Path: <stable+bounces-110123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 520F2A18DC7
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 09:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1503A3C04
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 08:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813A71537D4;
	Wed, 22 Jan 2025 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sVBWNlSK"
X-Original-To: stable@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325871F7569;
	Wed, 22 Jan 2025 08:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737535691; cv=none; b=iMMB3Sdhtr6LrgF20FlwiKCmfk534bsoOFRVEuJ/hm2BvO7u2QiZM+48y8mE5dym/SP6S9YySl92QVoQ9oh3zC9pDZd7C54OZERv/12Ez5D7B0jBLgMS/KpfdkCJ7qLWZKEUSZw0uRqqnLIDiUkNXZJyXEIWUIqRzteNUdYD/7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737535691; c=relaxed/simple;
	bh=PBw+2l4k/U/8zjU5cemT5owgK8Rdjbs+7eB+L9/Ycbc=;
	h=Date:Message-ID:From:To:Cc:Subject; b=jy4IFLPXlmn548AxRa22tSlceOrCtOjWW16LCrR1t+hJ7U4598vIfbx3B0fskjH4IKKLRgDjLrmWym6Pu/EsDrNVVDTEzUUGRiW4zRE/O7EdAEdBri242iqzEGJ09uGS5HTvTcfzMAZuzwPTM4tZiRVTvOvFXC1yOE89lsndAQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sVBWNlSK; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3D6F3138019D;
	Wed, 22 Jan 2025 03:48:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 22 Jan 2025 03:48:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1737535688; x=1737622088; bh=r29dMPQRv+Gn3SilhPT9HklbBYac
	hEKIULVz8FVwt98=; b=sVBWNlSKkTwm5W9vXSEs6umn0p8aMZm8VvntWbo/ugzW
	a413P9y3eao45N3+c2eWgRsg9weBYZZ0fuzwuRS7UfMg9QsLbm99pI2Z4SMB6X+p
	egTRIcrZyc73LV7jq+9c1oaZkAS0Zy8a+33Gmm2y7SYfNm10vubpttHVIO1+9lRr
	ajPhZgh0afVS+zmfyW9oMWmdwVrTb+89Gd66QzDAI+k+NAflevL5HD5Ze6luIx9q
	OLiUQULKyawVB1FVT+CirYOH3P6ZPzm/u6Q0HzQicN35qgi0WJGgqfTEDXBSMyF7
	doPbuXVdSbHDHlEStVXQOsEe/Toc5sOzeHXCbHk7ug==
X-ME-Sender: <xms:x7CQZ04cIDBpbmxRgP9YU1qefIr80sWeLvBoFXQBEigGvAdIFMy6DQ>
    <xme:x7CQZ149-FpLKw6ZtctGrtEVaMbsqnMxBgprA0V0vxFGB7MnDq46klzIHeTr8YGI8
    Rft8GPEwYaNr3-PC9Q>
X-ME-Received: <xmr:x7CQZzft3NABW2WdgUObfWt2pY2BbisDy2RIjgoXVslOq3mzsKqZuXnpebyDG-vBqm7Gr5nrzVVJvAovxJ-pfVPe3mMU59yFmcU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffkffhvfevufestddtjhdttddttdenucfhrhho
    mhephfhinhhnucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
    eqnecuggftrfgrthhtvghrnhepheetuddufffgfeekkeejudeivdfgfedtleetkeduleek
    ueefhfevueekkeeftdeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpvghnthhrhi
    drshgsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    fhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrghdpnhgspghrtghpthhtohephedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghgvvghrtheslhhinhhugidqmheikehkrdhorhhgpd
    hrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphht
    thhopehlihhnuhigqdhmieekkheslhhishhtshdrlhhinhhugidqmheikehkrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:x7CQZ5LWxxB-Xfc2hwJCtIbTAVhzFiD3em1PBS4Dc70El7v5E15DBQ>
    <xmx:x7CQZ4JMuVbsJz6RlB2EwqFgw_QlpHHYKUpF0hV_3PksTtNiGXAXRA>
    <xmx:x7CQZ6z7YCz65E9nr6ziqkGV_pnB0bcrIz5yhhjGw4Zc2T1TaOOE1g>
    <xmx:x7CQZ8JBlaR33R6OVUpY286W9dtfkRNKQEo9zOHub2feJbRg7xilhQ>
    <xmx:yLCQZ9GGED8H5URbWwBKNdFe9FgUixn2qIAKoEIANyFq2KtdcnpablqA>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 03:48:05 -0500 (EST)
Date: Wed, 22 Jan 2025 19:47:59 +1100
Message-ID: <590189176a007c7526f041dbf1ff0eea@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
To: stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5.4.y] m68k: Update ->thread.esp0 before calling syscall_trace() in ret_from_signal
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 50e43a57334400668952f8e551c9d87d3ed2dfef ]

We get there when sigreturn has performed obscene acts on kernel stack;
in particular, the location of pt_regs has shifted.  We are about to call
syscall_trace(), which might stop for tracer.  If that happens, we'd better
have task_pt_regs() returning correct result...

Fucked-up-by: Al Viro <viro@zeniv.linux.org.uk>
Fixes: bd6f56a75bb2 ("m68k: Missing syscall_trace() on sigreturn")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Tested-by: Michael Schmitz <schmitzmic@gmail.com>
Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
Tested-by: Finn Thain <fthain@linux-m68k.org>
Link: https://lore.kernel.org/r/YP2dMWeV1LkHiOpr@zeniv-ca.linux.org.uk
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 arch/m68k/kernel/entry.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
index 417d8f0e8962..0d03b4f2077b 100644
--- a/arch/m68k/kernel/entry.S
+++ b/arch/m68k/kernel/entry.S
@@ -182,6 +182,8 @@ ENTRY(ret_from_signal)
 	movel	%curptr@(TASK_STACK),%a1
 	tstb	%a1@(TINFO_FLAGS+2)
 	jge	1f
+	lea	%sp@(SWITCH_STACK_SIZE),%a1
+	movel	%a1,%curptr@(TASK_THREAD+THREAD_ESP0)
 	jbsr	syscall_trace
 1:	RESTORE_SWITCH_STACK
 	addql	#4,%sp

