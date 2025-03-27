Return-Path: <stable+bounces-126900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F825A74106
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 23:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B711894AF6
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 22:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93CD1D934D;
	Thu, 27 Mar 2025 22:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xhRmDhA1"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC441C5F28;
	Thu, 27 Mar 2025 22:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743115458; cv=none; b=HcL8cZ4oeDt/wwb6WZsrjUiEtO1/sZzhd+hhAMCkeCdwvVIvKI8a8nsCxQMm4/Y/LSmoATishYNySvfRYnCCinSToFr8CVVEwKvsNmR+QoNUTxqgqL1pTHsKrj4vnVqYZFNQMtLU0RqWNo2AplgPN5sOqNq/Q7K/sr0R8+WeYaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743115458; c=relaxed/simple;
	bh=uDqOaJetGvod+fFPZoCuGHoVSiv3OCbqbKddMAQJdD0=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=C9LZenqf23jXKJSAtjua+OwsPqaqGDG1SdkeELPVntwJhSdmqlIqF0lXV95RYOUhb2Oqhs29v3j48QtzPiXJgJdJA1YuWcjNMiWvHY0nM+MhFxC6gRlHfybGnpMsSQ4e+l9cdo4vfy6o0Ls+6gi0D/NOKtIKkOuwnbCpJ2jlfvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xhRmDhA1; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8A3AF25401E2;
	Thu, 27 Mar 2025 18:44:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 27 Mar 2025 18:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743115455; x=
	1743201855; bh=YoAucZtCMma1lcxFqynERyIEZTTs6k89qEgRCI1eRF8=; b=x
	hRmDhA1XbqLGzFjp3iYED1HNSZm8Sac5HEDbBkaQL0O/Vd7gM38W4xEjgcK8rD/e
	DuhIAk9DVEvhvfL2By6IBRw4PdJWwB/lY7W7GhGBouCc1IteC7Go3DtBtnr274do
	3gKHpEzScMA6Qyx919rVmVRMIP3vWtH+lhyTNPi9OwlhBJSXcXbq+vJcDQxqU+zC
	MHXikLwoUOLq4Xr99zHuokCQcldbWUHmhh3+vQJdknrNvpBIRqqLIvIPB6cYvU9r
	beennl7R31FDiO3CTElhrXRhqxB8hHYHySS1QXSLSHHCTcscMWE8TY/ulN5svC9H
	9k8xRIgNweROWeFyMMXrQ==
X-ME-Sender: <xms:v9TlZ3DCS87Zi-Pvdk_fNwUd9HRq_N7S-m6cmzYXxdRCxZbfVbPgkA>
    <xme:v9TlZ9iFKI6o2N2l61HSPNaAN82ZS-r3JWgxoExyp2E7my3QzNAsgNficiC5YE3tX
    YI-PD_txUveFZYh2vA>
X-ME-Received: <xmr:v9TlZyllAZoHyfkXy1lB5QSH6lhjmz3bcWOtsr97LbWXJk417-lESy9i7LsGbKml4MLchUQkU-4kRNoLl12DjNYB-ZnYMvSkq44>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieelieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepvfevkfgjfhfhufffsedttdertddttddtnecu
    hfhrohhmpefhihhnnhcuvfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrd
    horhhgqeenucggtffrrghtthgvrhhnpeelgefhvefgveduhefffeeuveehtdeigedukeef
    uddvhedvfefhkedugffffeetheenucffohhmrghinhephhgvrggurdhssgenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhi
    nhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhmieekkheslhhishhtshdrlhhinhhugidqmheikehkrdhorhhgpd
    hrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepshgthhifrggssehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:v9TlZ5xUKug-diLhHkJEVPIrR88osvRCsO8SEyhEMddu8ulrlEfOQw>
    <xmx:v9TlZ8TyHWY3ff8NgSa14wgKs59Es9Aawi9Muj0XlNgijYtzVmnpkg>
    <xmx:v9TlZ8YRc6jcS1AEUOr3aDJ7p7QIC0ZqWTaj0pYIsz7gYvy3REyzhQ>
    <xmx:v9TlZ9QGHKSK-cYBqQg5Q7T9EEGVto00x8e62KXxKNAm9bb9QayRDQ>
    <xmx:v9TlZyMccI0Gd2TfcALlTg0JfMCvXAexvlbbtO3z5MAprNBe1MkuIe8c>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 18:44:14 -0400 (EDT)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org,
    stable@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    Andreas Schwab <schwab@linux-m68k.org>
Message-ID: <9d4e8c68a456d5f2bc254ac6f87a472d066ebd5e.1743115195.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1743115195.git.fthain@linux-m68k.org>
References: <cover.1743115195.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 1/3] m68k: Fix lost column on framebuffer debug console
Date: Fri, 28 Mar 2025 09:39:55 +1100
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
Changed since v2:
 - addil and subil are now addql and subql resp.
---
 arch/m68k/kernel/head.S | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/m68k/kernel/head.S b/arch/m68k/kernel/head.S
index 852255cf60de..9bd8adaa756d 100644
--- a/arch/m68k/kernel/head.S
+++ b/arch/m68k/kernel/head.S
@@ -3400,6 +3400,7 @@ L(console_clear_loop):
 
 	movel	%d4,%d1				/* screen height in pixels */
 	divul	%a0@(FONT_DESC_HEIGHT),%d1	/* d1 = max num rows */
+	subql	#1,%d1				/* row range is 0 to num - 1 */
 
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
+	addql	#1,%d0
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
+	addql	#1,%d0
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


