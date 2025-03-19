Return-Path: <stable+bounces-124893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C8EA68871
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 10:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09E7F188C044
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 09:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902E2253F2F;
	Wed, 19 Mar 2025 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tv3ajq5k"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEAF2517B7;
	Wed, 19 Mar 2025 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376861; cv=none; b=sEPjveOKVjsPHCYE+kc7cE5oMj890IFEeVEMLf0qbwwXMyBH90mVs1qIpiaDrUg0b7y/oMjeyNbT1SXYq0eG74r6cpmsiQ3yv9W448aTy3uXHBYUabL7A7Njx8jqcGI3LEV0sdDmeLWKRUayitJhmbfDfLer5XSkTXxHjVCtaF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376861; c=relaxed/simple;
	bh=EnKX+FpgRVCww3sHNiEFqjbbrZDHXTE15B4EpztQsrQ=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=CU2tHWRtVCQPuYq9mmYG3jftADMTSDKutwBCOQ5DCGA330vDW3qmGnRUdjuT67wiumsMjhlP+Wjaxrcldrih51L5GqA/Wnbcrk+cPCxMUwZiCeXMTiafqeaHkwnJ3BRWDRkGbHx061K5hbUwMJJSnau9zxy/q+KdJYYvDM2TIak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tv3ajq5k; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8B5972540147;
	Wed, 19 Mar 2025 05:34:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 19 Mar 2025 05:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742376858; x=
	1742463258; bh=15Kxgw62ZotKzngQbV6i/lyJjN7aLGDqI32o79dR9UQ=; b=t
	v3ajq5kGuojt4t83p1no0Aupru4nfsMPSkBxSCdwi2BskA4lRqvs79YsfT1KghgP
	XjMXIMMj6xyeov0ZRZEYzvwi3W3VTYgbul9k0egVB1ftRgorWijJWLOfCXwMYUHZ
	AxQUhx2PPhmV9ZXlXkm722BaBzYAFlqftJTdsRSSBCkybrUulYATYhSv15kmtW6S
	KGuUNqoQeP49TX9P7SXHByXn4SqAIhpX/1oZmlz/zuZCP+ynhnOOMD+g81fylrST
	4k4ccR7JMz7Qg8XISHIjzysXm+ovnZwNxLUblhyjYKcbYEXRYRis1BHJbGdheCaI
	zTTKqgCu8vwENY2aaptdw==
X-ME-Sender: <xms:mo_aZ73-6w5mZ1J7EIDUtKhv45EVvfcldzSHJ30cca2buf26hRlNtQ>
    <xme:mo_aZ6Fgi2UnyoUmxLqCqSJRmWlYGlpG3bkUmn3SeSPk1QjDW6RS2_veb77YtTOWB
    1eLqguCa9wUdNLCdRU>
X-ME-Received: <xmr:mo_aZ74i9R6OwcPL8xfYrNZZj446dMSqUuvwUd3jsAxsCIvvzmZWTKwT6wYz5ODFSukk4jfDNS6QAScBHdZTirzSYw8ntRIhxS0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepvfevkfgjfhfhufffsedttdertddttddtnecu
    hfhrohhmpefhihhnnhcuvfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrd
    horhhgqeenucggtffrrghtthgvrhhnpeelgefhvefgveduhefffeeuveehtdeigedukeef
    uddvhedvfefhkedugffffeetheenucffohhmrghinhephhgvrggurdhssgenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhi
    nhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhmieekkheslhhishhtshdrlhhinhhugidqmheikehkrdhorhhgpd
    hrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mo_aZw3roXtaqEysldB3IDnnIkziQv11BF-bWitMO23HeXwINUR6gQ>
    <xmx:mo_aZ-GGXk-QusEX1vHUAXIOx4cGeN1ZTHJ9qC9LV9b7BLjm5qX_-A>
    <xmx:mo_aZx8wwK6wQsKtGlIEaa3k98kqoVnI4fNZ15-5psiCsEISkecyuw>
    <xmx:mo_aZ7noQcSM6bsTa8THTix7cHEmGYRvPKJcE1o-fJnXHfGJNC8Ylg>
    <xmx:mo_aZ6DazP-nfLCTwt0fcEHu0f4FFEgY8xm5pWmjtWqGYYkTwrpPNpvi>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 05:34:13 -0400 (EDT)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org,
    stable@vger.kernel.org,
    linux-kernel@vger.kernel.org
Message-ID: <0fa5e203bb2f811e36e9711dfd461a8f760a1ed6.1742376675.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1742376675.git.fthain@linux-m68k.org>
References: <cover.1742376675.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 1/3] m68k: Fix lost column on framebuffer debug console
Date: Wed, 19 Mar 2025 20:31:15 +1100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Move the cursor position rightward after rendering the character,
not before. This avoids complications that arise when the recursive
console_putc call has to wrap the line and/or scroll the display.
This also fixes the linewrap bug that crops off the rightmost column.

When the cursor is at the bottom of the display, a linefeed will not
move the cursor position further downward. Instead, the display scrolls
upward. Avoid the repeated add/subtract sequence by way of a single
subtraction at the initialization of console_struct_num_rows.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 arch/m68k/kernel/head.S | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/m68k/kernel/head.S b/arch/m68k/kernel/head.S
index 852255cf60de..d0d77b1adbde 100644
--- a/arch/m68k/kernel/head.S
+++ b/arch/m68k/kernel/head.S
@@ -3400,6 +3400,7 @@ L(console_clear_loop):
 
 	movel	%d4,%d1				/* screen height in pixels */
 	divul	%a0@(FONT_DESC_HEIGHT),%d1	/* d1 = max num rows */
+	subil	#1,%d1				/* row range is 0 to num - 1 */
 
 	movel	%d0,%a2@(Lconsole_struct_num_columns)
 	movel	%d1,%a2@(Lconsole_struct_num_rows)
@@ -3546,15 +3547,14 @@ func_start	console_putc,%a0/%a1/%d0-%d7
 	cmpib	#10,%d7
 	jne	L(console_not_lf)
 	movel	%a0@(Lconsole_struct_cur_row),%d0
-	addil	#1,%d0
-	movel	%d0,%a0@(Lconsole_struct_cur_row)
 	movel	%a0@(Lconsole_struct_num_rows),%d1
 	cmpl	%d1,%d0
 	jcs	1f
-	subil	#1,%d0
-	movel	%d0,%a0@(Lconsole_struct_cur_row)
 	console_scroll
+	jra	L(console_exit)
 1:
+	addil	#1,%d0
+	movel	%d0,%a0@(Lconsole_struct_cur_row)
 	jra	L(console_exit)
 
 L(console_not_lf):
@@ -3581,12 +3581,6 @@ L(console_not_cr):
  */
 L(console_not_home):
 	movel	%a0@(Lconsole_struct_cur_column),%d0
-	addql	#1,%a0@(Lconsole_struct_cur_column)
-	movel	%a0@(Lconsole_struct_num_columns),%d1
-	cmpl	%d1,%d0
-	jcs	1f
-	console_putc	#'\n'	/* recursion is OK! */
-1:
 	movel	%a0@(Lconsole_struct_cur_row),%d1
 
 	/*
@@ -3633,6 +3627,23 @@ L(console_do_font_scanline):
 	addq	#1,%d1
 	dbra	%d7,L(console_read_char_scanline)
 
+	/*
+	 *	Register usage in the code below:
+	 *	a0 = pointer to console globals
+	 *	d0 = cursor column
+	 *	d1 = cursor column limit
+	 */
+
+	lea	%pc@(L(console_globals)),%a0
+
+	movel	%a0@(Lconsole_struct_cur_column),%d0
+	addil	#1,%d0
+	movel	%d0,%a0@(Lconsole_struct_cur_column)	/* Update cursor pos */
+	movel	%a0@(Lconsole_struct_num_columns),%d1
+	cmpl	%d1,%d0
+	jcs	L(console_exit)
+	console_putc	#'\n'		/* Line wrap using tail recursion */
+
 L(console_exit):
 func_return	console_putc
 
-- 
2.45.3


