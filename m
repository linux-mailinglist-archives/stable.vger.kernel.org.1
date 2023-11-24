Return-Path: <stable+bounces-198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A027F7567
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4850E281C65
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 13:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BBB28E20;
	Fri, 24 Nov 2023 13:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MmbEfU6E"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430A0A1
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 05:40:34 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 83A7140E0258;
	Fri, 24 Nov 2023 13:40:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fwQrJ6NQ4zVH; Fri, 24 Nov 2023 13:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1700833230; bh=9+EECxNZzVCG+ugZIdXxpu/B1KgUcYP6Mwg7nK9CK7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MmbEfU6ESqm8cZvTbuAIe/wgAvmgs2P5lQEE1fVDumEZm2g4JwxeaLtqvXfs/plZM
	 i9xH7nTA/2HgP1LhPfw6c2yL9AM9IbhiM9kfUz9YC1tCtJojuepPzs+hZS4e6t/OEn
	 gvK62M+iBH3MoWplRjXD6bYy6X+IpABt2Dz4XtPHfeZe8usDOt9UUnIDIBwf51NYgU
	 11Qus7CUmrzJhod7QlqdMkxWmmzp/6AbGxzc1L6YYazrsR/0TGKVxQMSrjP7EZXewb
	 r/w3RWO/m/OZ9dhZuIZSkngrO3stCPQGAKFqVj8YnPuKjGppezVACy2Lq+ZBCL2Brh
	 bXkoVdjK7TMLR+JQ/yqKf5dokRVlM9sldER9DlKkfxPaZuYPj2e2CENl4WouzEGAyG
	 JMq3maqekDKXfioZnrzcgAog5iF4s8uMPHI4FSK4Np6bwZchf+65PWbA+Fk74afwLV
	 cUV/u6NrCQCpaAx0Zf2TN+sCjK2qVs6NAb69XEsjIo3AcTeVD33GClgr8OnngZHT6u
	 UQOq/inuGesUCN76RlbrKe1pcYnqyufmQ0okZY75/zdYg/tYOOZt0DM6DfU+s0Y7cJ
	 PVE4+0KBYm1vNdeTbEVqjEybw/Mllp5KIDABEC5TYlYpm+jtL6lW4/gda/InFEwK8+
	 Sjt8WyyeLjvSofAgKwZCoINE=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A42B140E01A5;
	Fri, 24 Nov 2023 13:40:26 +0000 (UTC)
Date: Fri, 24 Nov 2023 14:40:25 +0100
From: Borislav Petkov <bp@alien8.de>
To: Caleb Jorden <cjorden@gmail.com>, stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Regression] Linux-6.6.2: SRSO kernel log messages incorrect
Message-ID: <20231124134025.GCZWCnyRX2wOZ7UM2z@fat_crate.local>
References: <CABD8wQkKEYULh1U1hm9BFft43rzvk5GQaV8D5-VQ3jkYdLa9DA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABD8wQkKEYULh1U1hm9BFft43rzvk5GQaV8D5-VQ3jkYdLa9DA@mail.gmail.com>

On Fri, Nov 24, 2023 at 01:34:35PM +0530, Caleb Jorden wrote:
> I have noticed on my zen3 and zen4 machines (Ryzen 9 5950x & Ryzen 9
> 7950x) that the kernel boot log regarding SRSO is suddenly incorrect
> with the 6.6.2 kernel.
> 
> I have observed this on a completely mainline/stable kernel that I
> compile regularly for my machines.  With the 6.6.1 and 6.7-rc2
> kernels, I see correct boot messages like this:
> 
> [    0.161327] Spectre V1 : Mitigation: usercopy/swapgs barriers and
> __user pointer sanitization
> [    0.161329] Spectre V2 : Mitigation: Retpolines
> [    0.161330] Spectre V2 : Spectre v2 / SpectreRSB mitigation:
> Filling RSB on context switch
> [    0.161331] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
> [    0.161332] Spectre V2 : Enabling Restricted Speculation for firmware calls
> [    0.161333] Spectre V2 : mitigation: Enabling conditional Indirect
> Branch Prediction Barrier
> [    0.161335] Spectre V2 : User space: Mitigation: STIBP always-on protection
> [    0.161336] Speculative Store Bypass: Mitigation: Speculative Store
> Bypass disabled via prctl
> [    0.161338] Speculative Return Stack Overflow: Mitigation: safe RET
> 
> However, with the 6.6.2 kernel, I see this:
> 
> [    0.164266] Spectre V1 : Mitigation: usercopy/swapgs barriers and
> __user pointer sanitization
> [    0.164268] Spectre V2 : Mitigation: Retpolines
> [    0.164269] Spectre V2 : Spectre v2 / SpectreRSB mitigation:
> Filling RSB on context switch
> [    0.164270] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
> [    0.164272] Spectre V2 : Enabling Restricted Speculation for firmware calls
> [    0.164273] Spectre V2 : mitigation: Enabling conditional Indirect
> Branch Prediction Barrier
> [    0.164275] Spectre V2 : User space: Mitigation: STIBP always-on protection
> [    0.164276] Speculative Store Bypass: Mitigation: Speculative Store
> Bypass disabled via prctl
> [    0.164278] Speculative Return Stack Overflow: IBPB-extending
> microcode not applied!
> [    0.164279] Speculative Return Stack Overflow: WARNING: See
> https://kernel.org/doc/html/latest/admin-guide/hw-vuln/srso.html for
> mitigation options.
> [    0.164280] Speculative Return Stack Overflow: Mitigation: Safe RET
> 
> Notice that in both cases the final SRSO message indicates (correctly)
> that my system is protected with Safe RET (because my BIOS has the
> updated microcode for SRSO).  However, in the 6.6.2 kernel I also get
> the microcode warning.
> 
> I tracked this down to, what I believe is, the following commit from
> the mainline kernel not being included in the 6.6.2 patch set:
> 351236947a45a512c517153bbe109fe868d05e6d x86/srso: Move retbleed IBPB
> check into existing 'has_microcode' code block
> 
> When I cherry-pick this commit to the 6.6.2 release, the log messages
> are correct.  Note that this patch does not obviously indicate there
> is a functional change introduced by applying it.  However (at least
> in the case of Zen3 and Zen4) when the updated microcode has been
> applied, the flow is different (specifically the situation that falls
> into the else statement that produces the pr-warn calls to indicate
> that the microcode fix needs applied).  I believe this might be
> because RETBLEED does not apply to Zen3 and Zen4.  Unfortunately I
> don't have a Zen1 or Zen2 system readily available on which to test
> this theory.
> 
> While this should only be a cosmetic change, I believe that there is
> value in having the correct messages in the kernel logs for SRSO in
> this LTS release.
> 
> Please feel free to correct my analysis above if it is incorrect.

No, you're correct, 6.6-stable needs that patch.

stable folks, can you pls pick up:

351236947a45 ("x86/srso: Move retbleed IBPB check into existing 'has_microcode' code block")

?

See above why.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

