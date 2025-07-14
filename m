Return-Path: <stable+bounces-161856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A553B04387
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 17:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751B4188E0E7
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 15:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF6725EF9C;
	Mon, 14 Jul 2025 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m+ORuSzl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D89C25EF87;
	Mon, 14 Jul 2025 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506268; cv=none; b=Ve+nv10o7pNI4dEXob1fXlxXu1fbCu4G+Ih/G8RWAaEK2zTRCzQ7nKkDXed8lqw/b8Z17j4Htn2GfmZ2GRB6CBfYTUUrg+C+Z0lVnFPEuEuuGLixlWL3zHEoJfmlFl/E+zmoo5hwrRLWop3Z/wQVoXx9JGLZjT1jauUV+S3L/Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506268; c=relaxed/simple;
	bh=cUNIgJcVjTpFcArFOAzQ/cjJqb1SjX1Pfb2Fz7ACNUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=urw9ENhE2LDqz9Gt0oBKwirxyuHigzzxpNpz4iwi9GL1phi3zRBqyn/PatlSvB/6YNMgyhtFiU+mJ6UgNAtqzvhyso8uCJyEMTK5eSPdEUrpJFOaB2GJVJ66d92clC6u9pQvL/OuWTAE3M0MUAdSzcLl37LRrOHTuRi0efRIEA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m+ORuSzl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64D8C4CEED;
	Mon, 14 Jul 2025 15:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752506268;
	bh=cUNIgJcVjTpFcArFOAzQ/cjJqb1SjX1Pfb2Fz7ACNUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m+ORuSzl/FFfPPrNC9zxDenlK70zFbA9Z1dUyrIhQz4tusvTPWrbZvavyMjYTARZi
	 vMb+PMv8h3LxYf/1fBBJ4UUwd9aiWdQVWtelkB9PhMRMQ+WW4UlafDZccUJKfgP1mX
	 bJLkJnNy1+DAdO3rp9Yia08fc/7uZZ7aL9Fcsvlo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.145
Date: Mon, 14 Jul 2025 17:17:36 +0200
Message-ID: <2025071425-wound-slightly-60fd@gregkh>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025071424-rigid-dawdler-3bfc@gregkh>
References: <2025071424-rigid-dawdler-3bfc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 4efcf0614caf..ebcf5587ebf9 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 144
+SUBLEVEL = 145
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 3e3679709e90..4785d41558d6 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -561,6 +561,7 @@ static bool amd_check_tsa_microcode(void)
 
 	p.ext_fam	= c->x86 - 0xf;
 	p.model		= c->x86_model;
+	p.ext_model	= c->x86_model >> 4;
 	p.stepping	= c->x86_stepping;
 
 	if (c->x86 == 0x19) {
@@ -675,6 +676,8 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 	}
 
 	resctrl_cpu_detect(c);
+
+	tsa_init(c);
 }
 
 static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
@@ -719,8 +722,6 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
 			goto clear_sev;
 
 
-	tsa_init(c);
-
 		return;
 
 clear_all:

