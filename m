Return-Path: <stable+bounces-123193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B307AA5BECF
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 12:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68EE31898592
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 11:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE39252913;
	Tue, 11 Mar 2025 11:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="abrIuDzw"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215D9225776;
	Tue, 11 Mar 2025 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741692094; cv=none; b=cui5HdmMXpHqTFB7Ni+/rSBQgiaDQjkAtW1CzBxveK2UKmiPQJoXLg1wuj2QhFbJQkwrDVwPz4+vNqdtKb4u411G6V3EVxjfyTTSQhDJHTM8JOvOqN9q7XRpxk1oYkyseGJ0NqnqR6GNsGmRG8xbNtE5krXlteSR6x6L2e8N6/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741692094; c=relaxed/simple;
	bh=jydYuG3vuU1FezH+tqOnk9r4VSw0d+cxBK9lpGFEs+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTjLbNuokL3BxOu6x+VXBeTyBBQkD+n5dYgX1L6uwAZAN69ZW2XZ3ms08y+EUTXNCG+Af7VKwhchmEtdoL2Uwh7y81T8XwvsUJnHdkseyslq3xGmViod6Hn6PZylUqUEhDzmjZzapGHYzpn3tYm881004lufuZCxOWe/U6YiAhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=abrIuDzw; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CDF2240E0217;
	Tue, 11 Mar 2025 11:21:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2Y4aPF-aVWv2; Tue, 11 Mar 2025 11:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741692087; bh=Ce6J6jDj++AS87wKAEmhpt22NGBdfSW+V1qOd38OraM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=abrIuDzwqQxsPoqzbIJH/gnwwZZiQn+YIKngs264c08c8thE63KbfuJtC4/LbZW7j
	 /K+erTiWoWCIy1bU1tGCqpNKvxWxUNCN3GTTgYQGmCnvEJiGTLgL0F8dVx96dxbQ56
	 E/AcngScR5Ifb0eeHtyBaoklgnDnSNE/NdXAcR25EnE/09aLoFddi01LVgWuYJ2mN2
	 7gyYL168BnWv3tauJN5t7amBMz8Hvba3DeY2Dh9UqTcItWZih1coi9WnNtTjYkD6wP
	 GvPsyVE9jeVqzXJVm94wHlXao6KnqbxbrHtEc9F73Jli9shl/85dq7SVP0SNK2izN5
	 KBrZVEMjrXh+pDYWX5r7BjaculBjd3KYGbkwA8XDJ57ks8qpul3Ka+Mmfsdos+FCH6
	 59/5cH4AA53Qctwt4Y7ACXdlxl3d2hnBTionNh1pGUqIPX9fx6u/fgk+GsVC56/DoP
	 pqCljhp36QPDmGWQ0GP7+NaZuZq9EHaX2c9qgkIBtPeZH/8rItpDy7ThUeC7FSlpCR
	 uOeSrnx6IxzUNr7FKsH+uCkevTSSWScqnTq4GyjVuxRZsLGSwPz3eCez1+NAGRMp3t
	 jYAW0h72wTs9y9pAZHna017MBEOgP6buhUk/hnIjCOTkDXInNYWR880Rh08NOn6JNx
	 TIuJ83s819uO3f2u1K4aTZmc=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DB18240E015D;
	Tue, 11 Mar 2025 11:21:13 +0000 (UTC)
Date: Tue, 11 Mar 2025 12:21:12 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>, stable@vger.kernel.org,
	Fangrui Song <i@maskray.me>, Nathan Chancellor <nathan@kernel.org>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] x86/stackprotector: fix build failure with
 CONFIG_STACKPROTECTOR=n
Message-ID: <20250311112112.GEZ9AcqM2ceIQVUA0N@fat_crate.local>
References: <20241206123207.GA2091@redhat.com>
 <CAMj1kXGKCJfBVqgsqjX1bA_SY=503Z-tJV893y5JAwoVs0BUfw@mail.gmail.com>
 <20241206142152.GB31748@redhat.com>
 <CAMj1kXGo5yv56VvNMvYBohxgyoyDtZhr4d4kjRdGTDQchHW0Gw@mail.gmail.com>
 <CAMzpN2iUi_q_CfDa53H8MEV_zkb8NRtXtQPvOwDrEks58=3uAg@mail.gmail.com>
 <CAMj1kXF8PZq4660mzNYcT=QmWywB1gOOfZGzZhi1sQxQacUX=g@mail.gmail.com>
 <20250310214402.GBZ89dIo_NLF4zOSKh@fat_crate.local>
 <CAMj1kXEK0Kgx-C8sOvWJ9rkmC0ioWDEb+tpM9BTeWVwOWyGNog@mail.gmail.com>
 <20250311102326.GAZ9APHqe5aSQ1m5ND@fat_crate.local>
 <CAMj1kXHTLz4onmR5iyowptRE38RCK4jNT3BoURBkq2FoDOMTxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHTLz4onmR5iyowptRE38RCK4jNT3BoURBkq2FoDOMTxQ@mail.gmail.com>

On Tue, Mar 11, 2025 at 11:37:59AM +0100, Ard Biesheuvel wrote:
> There are many occurrences of
> 
> ffffffff8373cb87: 49 c7 c6 20 c0 55 86 mov    $0xffffffff8655c020,%r14
> ffffffff8373cb8a:         R_X86_64_32S __ref_stack_chk_guard
> 
> whereas the ordinary Clang uses R_X86_64_REX_GOTPCRELX here, which are
> relaxed by the linker.
> 
> I suspect that Ubuntu's Clang 15 has some additional patches that
> trigger this behavior.

... and then we don't know what else out there does other "additional" patches

;-\
 
> We could add __no_stack_protector to __head to work around this.

Yap, that fixes the build:

diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
index 0e82ebc5d1e1..6cf4ea847dc3 100644
--- a/arch/x86/include/asm/init.h
+++ b/arch/x86/include/asm/init.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_INIT_H
 #define _ASM_X86_INIT_H
 
-#define __head __section(".head.text") __no_sanitize_undefined
+#define __head __section(".head.text") __no_sanitize_undefined __no_stack_protector
 
 struct x86_mapping_info {
        void *(*alloc_pgt_page)(void *); /* allocate buf for page table */

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

