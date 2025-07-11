Return-Path: <stable+bounces-161665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2291B02093
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 17:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 587947BBDCE
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 15:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBEC2E7BD4;
	Fri, 11 Jul 2025 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YyKuJDUn"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714371DBB3A
	for <stable@vger.kernel.org>; Fri, 11 Jul 2025 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248164; cv=none; b=IuVM/gnzjmCIFjLcXX6b3f35pzm7R/s+c78FJvPnrqTF4fKBZC2PjvVH82M6Q+TsZf394Pw9fzKTfL9kVLrvVCvVGB00jz/AOJL0RGkT6Eh0LDHhwSa+lfuqF6Nkpz83QaU39Nnau0mcoUASd0XoMhs/ozgAcp0lU1sVGgat4A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248164; c=relaxed/simple;
	bh=682DAqKUkDA43Y9XPUmnrVkV9JDKl/2yQuYKfpfB8O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxUkNd56T8dnzjKcI7TBYksiJoPRM/5EOkTPSfvlv+PV2b+59kqV41dWmTOWoP6KNG+t+mKWcMWBLxzlTFWERP3BVjuOB24dht7tlaiEUJH4lguR0g5nKdcx1m/e0104rmdEUgHZjBBoyIX9AV2sghrRWiSGRrRhbofErlT4LPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YyKuJDUn; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A045140E0218;
	Fri, 11 Jul 2025 15:35:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id j3uIQfxajnty; Fri, 11 Jul 2025 15:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752248155; bh=34lWoKlmUoD1UWYuqU4jme1HIMWU+Xxyhy0Tg3uyC/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YyKuJDUnZe2KNy19WOb1l7bEEUf/3uZX3nxSiikRFRgXuen4Diz3IQwWyTGl98ebf
	 eLp4ilvcxRPU9xvWN3PUbEO5vBD5PSLIFn55HujQpLpkR/7nAKjlajmmNIZI3PJymG
	 0Ootx51j7dHuQhNaJaBWkrRO7vTitf28iLs+Otbk8J/E0HkaQdOvZnBsGHGiwrqhZ3
	 msh6Eh00TdHZ+csnGA3fKaxQ+TPhS88dzoNLzAUyCo6mL+kQ3k/X+ZIl3qP1aMe5/j
	 rqLb2NZDrl5hQnDZfZjcYaqkl4bSz+DRofUFd5JHAzze6OZUKRoGOmgSBAmEQ4QNrD
	 EwczGDw1qwPBi1kjfoRPXqZyJAFrOfMWHPX5GhJobqeYJMch84lXyaK93PiDAhY8Y1
	 xAHGfoChT31eRqM8nNb//nX+9LHCp4CxqbR3vWBphmrPziOKkyjXZWia/PjeixwhKw
	 4xXv1PUVWqXQSlJD2jSlivsSLNS1gUdYjNA6uAqm+GYJoSONyuuoVbRVzG7vbFHj1b
	 +VR+8cBtx70db2CF/2ZEXxXxKi3NHaVO6l/VGUeCX0HnEvn6Fxpaj0UmIlRQ52qsiG
	 Sl8K1u5U/bXrIb3PYXs6ys8Bkxq6XbJ3gzleCGFwiqlthLkurg8acFwym0liz75DH+
	 NR+r5zJcIaAay2YuoenT4mcE=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B1FDE40E0202;
	Fri, 11 Jul 2025 15:35:52 +0000 (UTC)
Date: Fri, 11 Jul 2025 17:35:46 +0200
From: Borislav Petkov <bp@alien8.de>
To: Thomas Voegtle <tv@lio96.de>
Cc: stable@vger.kernel.org, kim.phillips@amd.com
Subject: Re: TSA mitigation doesn't work on 6.6.y
Message-ID: <20250711153546.GBaHEvUmfVORJmONfh@fat_crate.local>
References: <04ea0a8e-edb0-c59e-ce21-5f3d5d167af3@lio96.de>
 <20250711122541.GAaHECxVpy31mIrqDb@fat_crate.local>
 <c7f1bb7d-ec91-ca9d-981a-a0bd5e484d05@lio96.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c7f1bb7d-ec91-ca9d-981a-a0bd5e484d05@lio96.de>

On Fri, Jul 11, 2025 at 03:15:22PM +0200, Thomas Voegtle wrote:
> dmesg | grep -E '(micro|min_rev)'
> [    0.000000] amd_check_tsa_microcode: ucode_rev: 0xa001000, current
> revision: 0xa20102e

Damn ext model.

Try the below and send dmesg again pls. I think this should work.

---

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 1180689a2390..6717abe569c8 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -547,6 +547,7 @@ static bool amd_check_tsa_microcode(void)
 
 	p.ext_fam	= c->x86 - 0xf;
 	p.model		= c->x86_model;
+	p.ext_model	= c->x86_model >> 4;
 	p.stepping	= c->x86_stepping;
 
 	if (cpu_has(c, X86_FEATURE_ZEN3) ||
@@ -569,12 +570,15 @@ static bool amd_check_tsa_microcode(void)
 		case 0xa70c0:	min_rev = 0x0a70c008; break;
 		case 0xaa002:	min_rev = 0x0aa00216; break;
 		default:
-			pr_debug("%s: ucode_rev: 0x%x, current revision: 0x%x\n",
+			pr_info("%s: ucode_rev: 0x%x, current revision: 0x%x\n",
 				 __func__, p.ucode_rev, c->microcode);
 			return false;
 		}
 	}
 
+	pr_info("c->microcode: 0x%x, min_rev: 0x%x, ucode_rev: 0x%x\n",
+		c->microcode, min_rev, p.ucode_rev);
+
 	if (!min_rev)
 		return false;
 

