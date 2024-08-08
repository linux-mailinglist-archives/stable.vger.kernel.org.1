Return-Path: <stable+bounces-66072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EF594C1EA
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 17:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355C61F23218
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 15:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB91518FDD6;
	Thu,  8 Aug 2024 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NTMLOTzz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5IxsyfeY"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A17618FC99;
	Thu,  8 Aug 2024 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132157; cv=none; b=mL2GhZaQroKEtH+j10sDNykRDdd64KMwahLBDUtWPTkETzfYf314sHx0jXUAJ2oD/H8G3NYHfkCt51oNY+TonJ1Kdrob5TN26e6H+bZ0cAxoG1N8SUtm4XiRaUV2H91agSi07RcqaOZPGC17lMAiaem9TC0i3TYnOdPvOlgfJ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132157; c=relaxed/simple;
	bh=fkjY3LBNweGNGEY95xeYnpit0RWxJ317N6XetQDQmBs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cvbqLZedf8EZSzH5Onl/00tmf7Djk0C45hxHDtNfKC64WVr7cl/eUJbEwCJedfS8dzfSGp8lTXtgCO8Wpgurtrq3X9EKbw4ep1EAGEmWO6wVshys4314UfanM1G13PKQ04FHEi6wUTyi7Qp+2Rl4kz4z6/Q82marPf/5VT1a/Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NTMLOTzz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5IxsyfeY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 15:49:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723132154;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6k7i/Y3LWtbpS6ERnU1JKVhQNbSPrtA3f0nnvlHY1k=;
	b=NTMLOTzzyIYPz6iVukzXTDkZ7FW0pA8GKGPPgQDa14uhuMx1b5aK2dBXdZr1SSYzv9k0U3
	qywNPopcThk1Chmkojev/dFD52EFF+GSi40G+QoZow8EI1veUoDTPtlYn/ahX0c6GmJlKQ
	SCDBtK+aREna140YfQOlbjciljZUNgQ2CFrwJtLfBCj9Uy+mkpDPGrc3RWacnQOjS1O3MO
	JH6obK+pAVO2TwDlsoPjev8xSM7XmXeUvJAV3mvMvEYxUoBfR0N1yMNEXqAj/s6/ajXFGJ
	damflwcDxcabZlxdWkBGfCVMLmkFsR7IKHLDw9hUhRmisG4F0ZbQZoQRXWX2kQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723132154;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6k7i/Y3LWtbpS6ERnU1JKVhQNbSPrtA3f0nnvlHY1k=;
	b=5IxsyfeYMZL3DIB5gfmPQkFnEVLB8PMA8IkfqnJbIasrPdxgoKYNQDkU0tUF/TgMyxTwKH
	61Xaaou/lpstW9Bg==
From: "tip-bot2 for Dmitry Vyukov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] module: Fix KCOV-ignored file name
Cc: Dmitry Vyukov <dvyukov@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <bc0cf790b4839c5e38e2fafc64271f620568a39e.1718092070.git.dvyukov@google.com>
References:
 <bc0cf790b4839c5e38e2fafc64271f620568a39e.1718092070.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172313215400.2215.12012900541594209721.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     f34d086fb7102fec895fd58b9e816b981b284c17
Gitweb:        https://git.kernel.org/tip/f34d086fb7102fec895fd58b9e816b981b284c17
Author:        Dmitry Vyukov <dvyukov@google.com>
AuthorDate:    Tue, 11 Jun 2024 09:50:32 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 Aug 2024 17:36:35 +02:00

module: Fix KCOV-ignored file name

module.c was renamed to main.c, but the Makefile directive was copy-pasted
verbatim with the old file name.  Fix up the file name.

Fixes: cfc1d277891e ("module: Move all into module/")
Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/bc0cf790b4839c5e38e2fafc64271f620568a39e.1718092070.git.dvyukov@google.com

---
 kernel/module/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index a10b2b9..50ffcc4 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -5,7 +5,7 @@
 
 # These are called from save_stack_trace() on slub debug path,
 # and produce insane amounts of uninteresting coverage.
-KCOV_INSTRUMENT_module.o := n
+KCOV_INSTRUMENT_main.o := n
 
 obj-y += main.o
 obj-y += strict_rwx.o

