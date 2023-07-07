Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59D474B7C0
	for <lists+stable@lfdr.de>; Fri,  7 Jul 2023 22:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjGGUS4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 7 Jul 2023 16:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjGGUSz (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 7 Jul 2023 16:18:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A075F1FEB
        for <stable@vger.kernel.org>; Fri,  7 Jul 2023 13:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688761090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QsU9CpQJcJnSyC5QilPYtQblG/4GpfxRSns3tJv6ujw=;
        b=DN0FIn7GvhC2WKK18ZlhgGyLaQjmaNib0XduFLEyMDQ8mK1v4lLUIVtWMwX3+FH5jNQnaD
        v2Gu4udQzV8xpmTL1zrhPRxAlnL9/CKkXI9OeDL8xRjWrcsQBhE7eI2/qf+/C+OfQ37MoT
        oYTb4qScCxUJRaLXijMjy+LRxGSHFyU=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-8iMRmt1FOVuiAUl43d1LRQ-1; Fri, 07 Jul 2023 16:18:07 -0400
X-MC-Unique: 8iMRmt1FOVuiAUl43d1LRQ-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-56942667393so25941847b3.2
        for <stable@vger.kernel.org>; Fri, 07 Jul 2023 13:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688761087; x=1691353087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsU9CpQJcJnSyC5QilPYtQblG/4GpfxRSns3tJv6ujw=;
        b=hD03nO8O2T/oPXcDyFOswSzI0lIdOyrlo0qOUcQ5EABAB9Y4Pa5xf4qRTmYJfH2s8w
         w0SBMbHROaQ7IYuO8g4UNDdBzcMej0oycevF2Zah/LH38zsDSXMJea/mHzqU3iT0eFGT
         P/ce7XLXRxjfgSHeKnaG/2nqDTq6pXweyqvvsls/XNTSWHsrcfymNpG0bF/4rpmcWN30
         W4Pn2+Svjo7hNFo4lc4J0zpEyvXkPaVb/NFZnpB0D+VBcv5JE6ETR02j1c3gzGRRALuj
         2d5U6fb7u/8GzWGjgteQgiQJgVxIOkulGUcyIsy0HbAPGhZYyw99qSqkjCkIAEa3nXzG
         1D3A==
X-Gm-Message-State: ABy/qLYLtp9mck9nV5YXZRqqUXh7H+nvOOujHSIxHOMoPkWrMIzPRTDh
        Sf0yznPL8XWFSKu798r6M7gldcGXAY7UZuAKu5C1IJmaJLXse6sLTQwk50HH9LijQ25/CQftgT8
        9g0JwaalGykh52vA2
X-Received: by 2002:a0d:df03:0:b0:573:44b3:bf7f with SMTP id i3-20020a0ddf03000000b0057344b3bf7fmr5574320ywe.41.1688761086844;
        Fri, 07 Jul 2023 13:18:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEcy1F3qiLujYMIH1fTZqShj4I/wz9gAu5axzhCWv+xGy36lu6+2plJw0mwuczqS0vLSBTefg==
X-Received: by 2002:a0d:df03:0:b0:573:44b3:bf7f with SMTP id i3-20020a0ddf03000000b0057344b3bf7fmr5574300ywe.41.1688761086534;
        Fri, 07 Jul 2023 13:18:06 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id x7-20020a817c07000000b005707fb5110bsm1269237ywc.58.2023.07.07.13.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 13:18:06 -0700 (PDT)
Date:   Fri, 7 Jul 2023 13:18:04 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>, stable@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Sachin Sant <sachinp@linux.ibm.com>
Subject: Re: [PATCH] tpm: return false from tpm_amd_is_rng_defective on
 non-x86 platforms
Message-ID: <b4lqa5urhgbnvtqon6qgoaftr6ut32mbq4uosugr7w6ar2uqis@lbwodwhrfchs>
References: <20230629204147.1852823-1-jsnitsel@redhat.com>
 <CTPWGNGECE0A.7MSU6S60YWDK@suppilovahvero>
 <mbbb2mdlmkhnkgmw37glklmllzelolmdvmdgz5pziidromxsh5@gkflot73u6gd>
 <5b9ec275-31b5-7b77-d00b-da128bea8bb3@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b9ec275-31b5-7b77-d00b-da128bea8bb3@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Jul 07, 2023 at 06:07:49PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> for once, to make this easily accessible to everyone.
> 
> So what's the way forward now? It sounded like Jarkko wanted to apply
> the patch from this thread days ago, but that didn't happen afaics. Then
> below message showed up, but Marios patch also wasn't applied.
> 
> Is this intentional, or did something somewhere fall through the cracks?
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

I haven't seen any update to Jarkko's repo.

My patch resolves the immediate issue being seen on the ppc system,
and was mostly just me asking why even go through this amd specific
code on non-x86 systems.

The vio bus shutdown code only does the remove call when kexec is in
progress. The pnp and platform bus type shutdown calls do not do
something similar so maybe the check in Mario's patch isn't needed,
but I don't think it would hurt to have it in there.

Regards,
Jerry

> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> #regzbot poke
> 
> On 05.07.23 19:04, Jerry Snitselaar wrote:
> > On Fri, Jun 30, 2023 at 01:07:00PM +0300, Jarkko Sakkinen wrote:
> >> On Thu Jun 29, 2023 at 11:41 PM EEST, Jerry Snitselaar wrote:
> >>> tpm_amd_is_rng_defective is for dealing with an issue related to the
> >>> AMD firmware TPM, so on non-x86 architectures just have it inline and
> >>> return false.
> >>>
> >>> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> >>> Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> >>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> >>> Cc: Peter Huewe <peterhuewe@gmx.de>
> >>> Cc: stable@vger.kernel.org
> >>> Cc: Linux regressions mailing list <regressions@lists.linux.dev>
> >>> Cc: Mario Limonciello <mario.limonciello@amd.com>
> >>> Reported-by: Aneesh Kumar K. V <aneesh.kumar@linux.ibm.com>
> >>> Reported-by: Sachin Sant <sachinp@linux.ibm.com>
> >>> Closes: https://lore.kernel.org/lkml/99B81401-DB46-49B9-B321-CF832B50CAC3@linux.ibm.com/
> >>> Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs")
> >>> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> >>> ---
> >>>  drivers/char/tpm/tpm-chip.c | 7 +++++++
> >>>  1 file changed, 7 insertions(+)
> >>>
> >>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> >>> index cd48033b804a..cf5499e51999 100644
> >>> --- a/drivers/char/tpm/tpm-chip.c
> >>> +++ b/drivers/char/tpm/tpm-chip.c
> >>> @@ -518,6 +518,7 @@ static int tpm_add_legacy_sysfs(struct tpm_chip *chip)
> >>>   * 6.x.y.z series: 6.0.18.6 +
> >>>   * 3.x.y.z series: 3.57.y.5 +
> >>>   */
> >>> +#ifdef CONFIG_X86
> >>>  static bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
> >>>  {
> >>>  	u32 val1, val2;
> >>> @@ -566,6 +567,12 @@ static bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
> >>>  
> >>>  	return true;
> >>>  }
> >>> +#else
> >>> +static inline bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
> >>> +{
> >>> +	return false;
> >>> +}
> >>> +#endif /* CONFIG_X86 */
> >>>  
> >>>  static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
> >>>  {
> >>> -- 
> >>> 2.38.1
> >>
> >> Sanity check, this was the right patch, right?
> >>
> >> I'll apply it.
> >>
> >> BR, Jarkko
> > 
> > Sorry, I've been dealing with a family health issue the past week. It wasn't clear
> > to me why chip->ops was null when I first took a look, but I think I understand
> > now looking at it again this morning. The stack trace shows it in the device_shutdown() path:
> > 
> >     [ 34.381674] NIP [c0000000009db1e4] tpm_amd_is_rng_defective+0x74/0x240
> >     [ 34.381681] LR [c0000000009db928] tpm_chip_unregister+0x138/0x160
> >     [ 34.381685] Call Trace:
> >     [ 34.381686] [c00000009742faa0] [c0000000009db928] tpm_chip_unregister+0x138/0x160
> >     [ 34.381690] [c00000009742fae0] [c0000000009eab94] tpm_ibmvtpm_remove+0x34/0x130
> >     [ 34.381695] [c00000009742fb50] [c000000000115738] vio_bus_remove+0x58/0xd0
> >     [ 34.381701] [c00000009742fb90] [c000000000a01ecc] device_shutdown+0x21c/0x39c
> >     [ 34.381705] [c00000009742fc20] [c0000000001a2684] kernel_restart_prepare+0x54/0x70
> >     [ 34.381710] [c00000009742fc40] [c000000000292c48] kernel_kexec+0xa8/0x100
> >     [ 34.381714] [c00000009742fcb0] [c0000000001a2cd4] __do_sys_reboot+0x214/0x2c0
> >     [ 34.381718] [c00000009742fe10] [c000000000034adc] system_call_exception+0x13c/0x340
> >     [ 34.381723] [c00000009742fe50] [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec
> > 
> > So I think what happened is:
> > 
> > device_shutdown -> dev->class->shutdown_pre (tpm_class_shutdown) // clears chip->ops
> >                 -> dev->bus->shutdown (vio_bus_shutdown) -> vio_bus_remove -> viodrv->remove (tpm_ibmvtpm_remove) -> tpm_chip_unregister -> tpm_amd_is_rng_defective -> oops!
> > 
> > 
> > I guess anything that gets called in the tpm_chip_unregister path
> > should be doing a check of chip->ops prior to using it. So I think
> > Mario's patch would still be a good thing to have.
> > 
> > Regards,
> > Jerry
> > 
> > 
> > 

