Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7947D106B
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 15:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377002AbjJTNVb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 09:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376933AbjJTNVa (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 09:21:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0081119E
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 06:21:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119FFC433C8;
        Fri, 20 Oct 2023 13:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697808088;
        bh=Y1j5viX6Gl+Sydww3OfQv6ZDfhK61Qe61IZAp1XHWmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=stgl1JKMYVimsSj5c2JTG9izcFXSTaTaqyBOO+qzvpdoTklOgDskhcjQYvLz4x31H
         Gh96Y9zgU4Mggez8NJ8F1S3xyi8Q5to8Xh24wQZqLSb4gPg6dFFBIcWzlcpV2SbdVL
         b6MyPL3ay5BQUQKjusE7HRbhQ55jITDjqHmg7Dck=
Date:   Fri, 20 Oct 2023 15:17:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, patches@lists.linux.dev,
        Tavis Ormandy <taviso@gmail.com>, stable@kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.4 02/68] x86/CPU/AMD: Disable XSAVES on AMD family 0x17
Message-ID: <2023102025-buffer-sneak-b784@gregkh>
References: <20230315115726.103942885@linuxfoundation.org>
 <20230315115726.197012029@linuxfoundation.org>
 <d0029d6b-2ddf-4723-ba93-3c7bb9580abc@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0029d6b-2ddf-4723-ba93-3c7bb9580abc@maciej.szmigiero.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 20, 2023 at 11:41:13AM +0200, Maciej S. Szmigiero wrote:
> On 15.03.2023 13:11, Greg Kroah-Hartman wrote:
> > From: Andrew Cooper <andrew.cooper3@citrix.com>
> > 
> > commit b0563468eeac88ebc70559d52a0b66efc37e4e9d upstream.
> > 
> > AMD Erratum 1386 is summarised as:
> > 
> >    XSAVES Instruction May Fail to Save XMM Registers to the Provided
> >    State Save Area
> > 
> > This piece of accidental chronomancy causes the %xmm registers to
> > occasionally reset back to an older value.
> > 
> > Ignore the XSAVES feature on all AMD Zen1/2 hardware.  The XSAVEC
> > instruction (which works fine) is equivalent on affected parts.
> > 
> >    [ bp: Typos, move it into the F17h-specific function. ]
> > 
> > Reported-by: Tavis Ormandy <taviso@gmail.com>
> > Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
> > Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> > Cc: <stable@kernel.org>
> > Link: https://lore.kernel.org/r/20230307174643.1240184-1-andrew.cooper3@citrix.com
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >   arch/x86/kernel/cpu/amd.c |    9 +++++++++
> >   1 file changed, 9 insertions(+)
> > 
> > --- a/arch/x86/kernel/cpu/amd.c
> > +++ b/arch/x86/kernel/cpu/amd.c
> > @@ -205,6 +205,15 @@ static void init_amd_k6(struct cpuinfo_x
> >   		return;
> >   	}
> >   #endif
> > +	/*
> > +	 * Work around Erratum 1386.  The XSAVES instruction malfunctions in
> > +	 * certain circumstances on Zen1/2 uarch, and not all parts have had
> > +	 * updated microcode at the time of writing (March 2023).
> > +	 *
> > +	 * Affected parts all have no supervisor XSAVE states, meaning that
> > +	 * the XSAVEC instruction (which works fine) is equivalent.
> > +	 */
> > +	clear_cpu_cap(c, X86_FEATURE_XSAVES);
> >   }
> 
> This is essentially a well-intended NOP since K6 well predates XSAVES,
> and init_amd_k6() is *not* called for Zen CPUs.
> 
> This workaround should have been added to init_amd_zn() function
> instead.
> 
> 4.19 and 4.14 backports of this patch have the same problem.

Ick, good catch!  Can you send a set of patches to fix this up?

thanks,

greg k-h
