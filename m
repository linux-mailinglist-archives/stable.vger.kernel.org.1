Return-Path: <stable+bounces-161854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ED9B0437A
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 17:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB3CC188535C
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 15:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF5425D1FC;
	Mon, 14 Jul 2025 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="085nVXDs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAEE25C713;
	Mon, 14 Jul 2025 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506246; cv=none; b=e/EoamsviRborMdyP0OZq+tchQgpzGOoR4nGigXsnwTVXFMoUAwIoPlzXNpRF/6eSvkTwLbdUsWgE6GI/bDem7vGORjf8BcAqbB+3p/RoZ15P14+mKpiArNyrPjw/aJQzKf0bWdDOOIOj5wVS/2BmZYtEFkCLuVccI/ZsVWTMWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506246; c=relaxed/simple;
	bh=rYDjal0ZCK11t3U/HqYjD6S7Yv6UsQPq3XxtWaX5V18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4IeQvIcnsga3zxyLWcIVieIxgvvpp37S7lhwd8nrIK+5YaQuXqZzHIpvtxYU0aB/0P1uU67/47ypG6bybJmfrBK//lAEsGqWcX6fgYqm9GW83j9Jzqj41WkhzCDzjHFiB4ZaRuIcCB9K4y+x46PsGHT6KT26f8I7hDv1eqsdjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=085nVXDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA533C4CEF0;
	Mon, 14 Jul 2025 15:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752506246;
	bh=rYDjal0ZCK11t3U/HqYjD6S7Yv6UsQPq3XxtWaX5V18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=085nVXDsWSdAO1liwDC/RF6i+ulYZMUvgb4kJxxPiTGA9NVEDizZ+jbgfx4m6fu7A
	 X3maeUsyHv3b28oHnxFd6pcGD6BKSKF84yoNVR1ULltecPJzAtMHb4bq+V1iZqIiy+
	 PRHL/TIOBfUfG5hxN0PuqJcHlZko+s1nHCXeUnHs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.188
Date: Mon, 14 Jul 2025 17:17:14 +0200
Message-ID: <2025071438-underhand-rebate-5774@gregkh>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025071438-wrinkle-luridness-84ab@gregkh>
References: <2025071438-wrinkle-luridness-84ab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 6c9463d296dc..86a5048e9816 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 187
+SUBLEVEL = 188
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index d409ba7fba85..04ac18ff022f 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -590,6 +590,7 @@ static bool amd_check_tsa_microcode(void)
 
 	p.ext_fam	= c->x86 - 0xf;
 	p.model		= c->x86_model;
+	p.ext_model	= c->x86_model >> 4;
 	p.stepping	= c->x86_stepping;
 
 	if (c->x86 == 0x19) {
@@ -704,6 +705,8 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 	}
 
 	resctrl_cpu_detect(c);
+
+	tsa_init(c);
 }
 
 static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
@@ -743,8 +746,6 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
 			goto clear_sev;
 
 
-	tsa_init(c);
-
 		return;
 
 clear_all:

