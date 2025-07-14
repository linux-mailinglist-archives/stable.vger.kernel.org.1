Return-Path: <stable+bounces-161860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2BBB04379
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 17:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 559747B25FC
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 15:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D73026058B;
	Mon, 14 Jul 2025 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AflgOKSp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F23E258CED;
	Mon, 14 Jul 2025 15:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506313; cv=none; b=RO+0Nrl7kyTL+/GlIOHhrP6lIFVug9foXe1iNaYYTDuJjkkjh8tM9TcbVbdadkX6JYtE0yZNLnFB7Mq+GdaCq2dB9Z2+fda2h6MuVIqQsWJtkt7pBaNtmQQbQZTEEF+p7pK5QM2YK35oEnYMdDzelZgxv1aUq3nx8pYX31UE0o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506313; c=relaxed/simple;
	bh=EvBPgLtUAatPVRSzxSQeE96iLRZBFymEF36IJGVuuBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKEWjFMqzhkO8Q9R6AFhuCplvEQuRw8ZLbS8+TuajWKO9gtlCkeYprqWdWIGeURgDp89Hgj32DAPtg10OtOT2AFIzNXLe0S5NuqCLMWieVpqwCjG9vvLxWghqsIk4ID7uKjZRBVsoWsF6v+5j1pvI4AmwP8YtQ8M8cHWEGXtlSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AflgOKSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C66C4CEF0;
	Mon, 14 Jul 2025 15:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752506312;
	bh=EvBPgLtUAatPVRSzxSQeE96iLRZBFymEF36IJGVuuBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AflgOKSpIlFAGV2zH9afuwB1/N7FjxE7ggO57+A1AKUz5mAvn9o5tyCTb4NdwQPDH
	 0loQmnOzTWvvA2pHMFiEs1jyz3pkOSCtIUIeL7LZyKemYx2sP4wJm3G3dpfoDM9yQt
	 tpU9CZxTo1tMseL99qGscrho9LDDt+MoKGf9uBGA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.38
Date: Mon, 14 Jul 2025 17:18:20 +0200
Message-ID: <2025071408-confidant-bulldozer-e5d1@gregkh>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025071408-skimmed-demise-ab18@gregkh>
References: <2025071408-skimmed-demise-ab18@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index ca3225cbf130..28c9acdd9b35 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 37
+SUBLEVEL = 38
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 8a740e92e483..b42307200e98 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -376,6 +376,7 @@ static bool amd_check_tsa_microcode(void)
 
 	p.ext_fam	= c->x86 - 0xf;
 	p.model		= c->x86_model;
+	p.ext_model	= c->x86_model >> 4;
 	p.stepping	= c->x86_stepping;
 
 	if (cpu_has(c, X86_FEATURE_ZEN3) ||

