Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266E6784AD8
	for <lists+stable@lfdr.de>; Tue, 22 Aug 2023 21:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjHVTu5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 22 Aug 2023 15:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjHVTu4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 Aug 2023 15:50:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5081BCFE
        for <stable@vger.kernel.org>; Tue, 22 Aug 2023 12:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692733809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5uIJYLeugTPKBtvMobwrsQt5z9ywutDVYoAznOGuvDE=;
        b=YfSi/jPFvZWwK1x/1s1ouIlZgbIUsccpKAgeKAhJjBdb3IkU0IGE0mskGTE1r/qRr0zUW9
        NgCzHjenxtrn4JDo8tQEV28M5DpIBWai61Bnc0bGNNcNloHLqY4ZTe4Y1y+09zAidcS1NZ
        sVBXZJPLnC1MrpzAtrLeRT5gMbhXzbs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-TBrrV5HTPv6-xG2mZp015g-1; Tue, 22 Aug 2023 15:50:08 -0400
X-MC-Unique: TBrrV5HTPv6-xG2mZp015g-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-40fb76bd50aso50693231cf.0
        for <stable@vger.kernel.org>; Tue, 22 Aug 2023 12:50:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692733807; x=1693338607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uIJYLeugTPKBtvMobwrsQt5z9ywutDVYoAznOGuvDE=;
        b=L9tCWEO4j5lVXTJ4ltwVVajYFGv1S74uI62ZFcLu0jD9Ni+V7Qp/C1M1L7ncnx0G1S
         7yWmtKaVfmf9NBdo3GSFbJGej4TtU1omzrAqTkLxFcfdpMMoeIyDgM2m2iXfpmspjlvO
         F/9kNO5FQnoV1C8L0f4w6Bu32kb0QMHPzwsmxufzMz8qrL+26f4UZLp8JET7DScEeJCc
         GHhDQ1wwk/ModssEedipGzuL+yg1siBnZIIcTbMJ+ueGEq8yp5QB5+f2mRBMfDrOHz7E
         gTqjjY5g4mqGnnHMDVh7/xpBktpges/8s/bN3uNsxGpDut5YvYsF4jfjuCb25Ngl/3Sf
         r4+w==
X-Gm-Message-State: AOJu0YzhCahdB1qVNu0TStuTR3IiO5utV9gD1QXKMYfAWdBrrGPaKQjD
        SETMJ+Znvf4hT+dM7BXHP0RzB9tZmQGbcMJAY4d/P2y86sVsBTJWOd5Ese5s2Yduaj6AZaEj7vb
        UGnVpZJ3MGZFPlnvN
X-Received: by 2002:a05:622a:1704:b0:410:9836:8066 with SMTP id h4-20020a05622a170400b0041098368066mr7470576qtk.43.1692733807710;
        Tue, 22 Aug 2023 12:50:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeetPG2YXy4IAFns4Qfu2Vlw4IKcTAsHPQ8h2GvWhs0XnPN5M9EabaXvPVn2sLq0CDGJtCKg==
X-Received: by 2002:a05:622a:1704:b0:410:9836:8066 with SMTP id h4-20020a05622a170400b0041098368066mr7470566qtk.43.1692733807407;
        Tue, 22 Aug 2023 12:50:07 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id jk9-20020a05622a748900b00403c1a19a2bsm3220849qtb.92.2023.08.22.12.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 12:50:06 -0700 (PDT)
Date:   Tue, 22 Aug 2023 12:50:05 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Todd Brandt <todd.e.brandt@intel.com>,
        Patrick Steinhardt <ps@pks.im>, Ronan Pigott <ronan@rjp.ie>,
        Raymond Jay Golo <rjgolo@gmail.com>
Subject: Re: [PATCH v2] tpm: Don't make vendor check required for probe
Message-ID: <lpt7tqahlsekfyfh7qwlznxpitpcqjxwmeps7lljnuzdygkaqp@xcqfenucomie>
References: <20230821140230.1168-1-mario.limonciello@amd.com>
 <CUZ3T3G99JG2.29X1G67HRO9QT@suppilovahvero>
 <b7d45df7-3d1c-4b31-9da1-5f81d3e5b279@amd.com>
 <CUZ5SUEX8IUC.2LBS3FZP9XUTA@suppilovahvero>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CUZ5SUEX8IUC.2LBS3FZP9XUTA@suppilovahvero>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Aug 22, 2023 at 05:56:03PM +0300, Jarkko Sakkinen wrote:
> On Tue Aug 22, 2023 at 5:05 PM EEST, Mario Limonciello wrote:
> > On 8/22/2023 08:22, Jarkko Sakkinen wrote:
> > > On Mon Aug 21, 2023 at 5:02 PM EEST, Mario Limonciello wrote:
> > >> The vendor check introduced by commit 554b841d4703 ("tpm: Disable RNG for
> > >> all AMD fTPMs") doesn't work properly on a number of Intel fTPMs.  On the
> > >> reported systems the TPM doesn't reply at bootup and returns back the
> > >> command code. This makes the TPM fail probe.
> > >>
> > >> As this isn't crucial for anything but AMD fTPM and AMD fTPM works, check
> > >> the chip vendor and if it's not AMD don't run the checks.
> > >>
> > >> Cc: stable@vger.kernel.org
> > >> Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
> > >> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> > >> Reported-by: Patrick Steinhardt <ps@pks.im>
> > >> Reported-by: Ronan Pigott <ronan@rjp.ie>
> > >> Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
> > >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217804
> > >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > >> ---
> > >> v1->v2:
> > >>   * Check x86 vendor for AMD
> > >> ---
> > >>   drivers/char/tpm/tpm_crb.c | 7 ++++++-
> > >>   1 file changed, 6 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> > >> index 9eb1a18590123..7faf670201ccc 100644
> > >> --- a/drivers/char/tpm/tpm_crb.c
> > >> +++ b/drivers/char/tpm/tpm_crb.c
> > >> @@ -465,8 +465,12 @@ static bool crb_req_canceled(struct tpm_chip *chip, u8 status)
> > >>   
> > >>   static int crb_check_flags(struct tpm_chip *chip)
> > >>   {
> > >> +	int ret = 0;
> > >> +#ifdef CONFIG_X86
> > >>   	u32 val;
> > >> -	int ret;
> > >> +
> > >> +	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
> > >> +		return ret;
> > >>   
> > >>   	ret = crb_request_locality(chip, 0);
> > >>   	if (ret)
> > >> @@ -481,6 +485,7 @@ static int crb_check_flags(struct tpm_chip *chip)
> > >>   
> > >>   release:
> > >>   	crb_relinquish_locality(chip, 0);
> > >> +#endif
> > > 
> > > Looks much better but the main question here is that is this combination
> > > possible:
> > > 
> > > 1. AMD CPU
> > > 2. Non-AMD fTPM (i.e. manufacturer property differs)
> > > 
> > > BR, Jarkko
> >
> > Yes that combination is possible.
> >
> > Pluton TPM uses the tpm_crb driver.
> 
> Then I guess we'll go with this for now. Thanks for the effort.
> 
> Tested-by: Jarkko Sakkinen <jarkko@kernel.org> # QEMU + swtpm
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> I'm planning to send a pull request right after this with the fix so it
> will land to v6.6-rc1 or v6.6-rc2:
> https://lore.kernel.org/linux-integrity/20230817201935.31399-1-jarkko@kernel.org/
> 
> BR, Jarkko


Super minor nit that isn't this patch in particular so don't hold this
up, but it seems like the function name for the earlier attempt to
solve this issue that mentioned amd and ftpm was a clearer description
of what was happening than crb_check_flags.

Regards,
Jerry

