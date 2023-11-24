Return-Path: <stable+bounces-252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 910D67F75E5
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 15:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20B4EB213B1
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A782C84B;
	Fri, 24 Nov 2023 14:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vkCyPOa9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D40B2C1B2
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 14:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39512C433CA;
	Fri, 24 Nov 2023 14:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700834675;
	bh=uG6dhQuOoMM3xyams7jRSYqiDUzEOwS1fTtWuudY+OU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vkCyPOa9y0I5geawcSNyzcJdmCsgHnnWWvlv8MHjK/TGr6RJ22FJy3zFf9YyZP/0V
	 y+weqXb7CIsjiPq82xfCUDk2FaD+6eqS815iyGyoluhfTA5mjRcp3LIoTf/0x+q/MN
	 mRjUId4JqjqLugR6VKY2J+/7/hMBWFHjG6bruhic=
Date: Fri, 24 Nov 2023 14:04:33 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Caleb Jorden <cjorden@gmail.com>, stable@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Regression] Linux-6.6.2: SRSO kernel log messages incorrect
Message-ID: <2023112422-probable-scrabble-913b@gregkh>
References: <CABD8wQkKEYULh1U1hm9BFft43rzvk5GQaV8D5-VQ3jkYdLa9DA@mail.gmail.com>
 <20231124134025.GCZWCnyRX2wOZ7UM2z@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124134025.GCZWCnyRX2wOZ7UM2z@fat_crate.local>

On Fri, Nov 24, 2023 at 02:40:25PM +0100, Borislav Petkov wrote:
> On Fri, Nov 24, 2023 at 01:34:35PM +0530, Caleb Jorden wrote:
> > I have noticed on my zen3 and zen4 machines (Ryzen 9 5950x & Ryzen 9
> > 7950x) that the kernel boot log regarding SRSO is suddenly incorrect
> > with the 6.6.2 kernel.
> > 
> > I have observed this on a completely mainline/stable kernel that I
> > compile regularly for my machines.  With the 6.6.1 and 6.7-rc2
> > kernels, I see correct boot messages like this:
> > 
> > [    0.161327] Spectre V1 : Mitigation: usercopy/swapgs barriers and
> > __user pointer sanitization
> > [    0.161329] Spectre V2 : Mitigation: Retpolines
> > [    0.161330] Spectre V2 : Spectre v2 / SpectreRSB mitigation:
> > Filling RSB on context switch
> > [    0.161331] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
> > [    0.161332] Spectre V2 : Enabling Restricted Speculation for firmware calls
> > [    0.161333] Spectre V2 : mitigation: Enabling conditional Indirect
> > Branch Prediction Barrier
> > [    0.161335] Spectre V2 : User space: Mitigation: STIBP always-on protection
> > [    0.161336] Speculative Store Bypass: Mitigation: Speculative Store
> > Bypass disabled via prctl
> > [    0.161338] Speculative Return Stack Overflow: Mitigation: safe RET
> > 
> > However, with the 6.6.2 kernel, I see this:
> > 
> > [    0.164266] Spectre V1 : Mitigation: usercopy/swapgs barriers and
> > __user pointer sanitization
> > [    0.164268] Spectre V2 : Mitigation: Retpolines
> > [    0.164269] Spectre V2 : Spectre v2 / SpectreRSB mitigation:
> > Filling RSB on context switch
> > [    0.164270] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
> > [    0.164272] Spectre V2 : Enabling Restricted Speculation for firmware calls
> > [    0.164273] Spectre V2 : mitigation: Enabling conditional Indirect
> > Branch Prediction Barrier
> > [    0.164275] Spectre V2 : User space: Mitigation: STIBP always-on protection
> > [    0.164276] Speculative Store Bypass: Mitigation: Speculative Store
> > Bypass disabled via prctl
> > [    0.164278] Speculative Return Stack Overflow: IBPB-extending
> > microcode not applied!
> > [    0.164279] Speculative Return Stack Overflow: WARNING: See
> > https://kernel.org/doc/html/latest/admin-guide/hw-vuln/srso.html for
> > mitigation options.
> > [    0.164280] Speculative Return Stack Overflow: Mitigation: Safe RET
> > 
> > Notice that in both cases the final SRSO message indicates (correctly)
> > that my system is protected with Safe RET (because my BIOS has the
> > updated microcode for SRSO).  However, in the 6.6.2 kernel I also get
> > the microcode warning.
> > 
> > I tracked this down to, what I believe is, the following commit from
> > the mainline kernel not being included in the 6.6.2 patch set:
> > 351236947a45a512c517153bbe109fe868d05e6d x86/srso: Move retbleed IBPB
> > check into existing 'has_microcode' code block
> > 
> > When I cherry-pick this commit to the 6.6.2 release, the log messages
> > are correct.  Note that this patch does not obviously indicate there
> > is a functional change introduced by applying it.  However (at least
> > in the case of Zen3 and Zen4) when the updated microcode has been
> > applied, the flow is different (specifically the situation that falls
> > into the else statement that produces the pr-warn calls to indicate
> > that the microcode fix needs applied).  I believe this might be
> > because RETBLEED does not apply to Zen3 and Zen4.  Unfortunately I
> > don't have a Zen1 or Zen2 system readily available on which to test
> > this theory.
> > 
> > While this should only be a cosmetic change, I believe that there is
> > value in having the correct messages in the kernel logs for SRSO in
> > this LTS release.
> > 
> > Please feel free to correct my analysis above if it is incorrect.
> 
> No, you're correct, 6.6-stable needs that patch.
> 
> stable folks, can you pls pick up:
> 
> 351236947a45 ("x86/srso: Move retbleed IBPB check into existing 'has_microcode' code block")
> 
> ?
> 
> See above why.

Now queued up, thanks!

greg k-h

