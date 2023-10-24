Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46B57D54C3
	for <lists+stable@lfdr.de>; Tue, 24 Oct 2023 17:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjJXPJm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 24 Oct 2023 11:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjJXPJm (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 24 Oct 2023 11:09:42 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ED5EA
        for <stable@vger.kernel.org>; Tue, 24 Oct 2023 08:09:40 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b3ec45d6e9so2924664b6e.0
        for <stable@vger.kernel.org>; Tue, 24 Oct 2023 08:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698160179; x=1698764979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqT0ZpAwvVlI/uIx6DFzb3/0hYc00UNCYkZdfU6AruA=;
        b=A/ItjlqeUmlo5sqnPUfk6R+HnmTqxDoCeS4X2rbhTe62FtKJkKoth4O6ATkFdOU3QT
         Re9iLxpST3pLouPxiSWkO6mb972oGwhdbUVzEwErD0RtrukcHsdS6LQre+JkQEsOfdHW
         EXge491kmQzqOYV/0oiUx3YYlbJ08D2msQ2kQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698160179; x=1698764979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqT0ZpAwvVlI/uIx6DFzb3/0hYc00UNCYkZdfU6AruA=;
        b=llcIIUTBnyDX3sB/hL50PETmo4atRRTnv0yXBpF7eyOsIHcBoe1tlpCKjBlIq8ZLqR
         5NQ5HR8ZIQUBXwKwwoQ/T9LmQiVr/NTr1wwv49BbpZwY+Akd4VhPYj8izl0l6RUpIGN/
         bjH7OHVR0IEw1aMyFxXNd8ZvPizpNUpKIP8FZi45E2orQgF/Xio4jfaqbwtiowKdOR/K
         3rfbUYc4ygw5JDnECy3AjyPX1Wi5ZDQ0EbTjtJX97emgKlKjBpd4lq5nsSAu+v//7Jnc
         jQBCYPjpDJdoU4z5FuoduCUX77oUOfzBB29IBj4/PFfI0HNmnyaHFQXI04CcwN71iTKP
         DtnA==
X-Gm-Message-State: AOJu0YyFsPe+9h4IaiTHTCtqx9OrAMAAG0BsTGTGCKCof7TOIo/Dc5jY
        WDI33qGkfDTscHuoOv50ET8jc4hqOxHojk01BzY=
X-Google-Smtp-Source: AGHT+IFIgJ/6TU8uZbHbTWDTdHLHSmIU7ljtRCyJ0p0cTryxv4s0UzTJoM94YGnthzG5yj37i3pEyA==
X-Received: by 2002:aca:2107:0:b0:3b2:e799:97f6 with SMTP id 7-20020aca2107000000b003b2e79997f6mr12187750oiz.59.1698160179282;
        Tue, 24 Oct 2023 08:09:39 -0700 (PDT)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com. [209.85.167.182])
        by smtp.gmail.com with ESMTPSA id j9-20020a544809000000b003b2e4b72a75sm1957668oij.52.2023.10.24.08.09.36
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 08:09:37 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3b3ec45d6e9so2924603b6e.0
        for <stable@vger.kernel.org>; Tue, 24 Oct 2023 08:09:36 -0700 (PDT)
X-Received: by 2002:a54:4e84:0:b0:3af:75e2:4c34 with SMTP id
 c4-20020a544e84000000b003af75e24c34mr12647739oiy.50.1698160176277; Tue, 24
 Oct 2023 08:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230911134650.286315610@linuxfoundation.org> <20230911134651.582204417@linuxfoundation.org>
 <ZS6xYa_kjRGvdCG6@google.com> <bd5d2f882e47b904802023d5d4d54d8d4755440e.camel@linux.ibm.com>
 <CAHQZ30A8R+EDGbrngMOQrXabR=DTHL3Y-1Tv+3RF98VHQ5b68Q@mail.gmail.com>
 <c9b7de507e26cb4e5111cdc76998f1dcd3c0957a.camel@linux.ibm.com>
 <CAHQZ30BPUtNbQhxvUGMQWP3Ka4UxtaS_NUeK12jtdaheMq4EWw@mail.gmail.com> <e03ccb1e354cee0eea828cb6f2e6f91714218c49.camel@linux.ibm.com>
In-Reply-To: <e03ccb1e354cee0eea828cb6f2e6f91714218c49.camel@linux.ibm.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Tue, 24 Oct 2023 09:09:25 -0600
X-Gmail-Original-Message-ID: <CAHQZ30B+=v+QpXNiXDrmDPLf2k2_1zeXnK7kWok4VspurNQw4g@mail.gmail.com>
Message-ID: <CAHQZ30B+=v+QpXNiXDrmDPLf2k2_1zeXnK7kWok4VspurNQw4g@mail.gmail.com>
Subject: Re: [PATCH 6.4 041/737] ovl: Always reevaluate the file signature for IMA
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, Tim Bain <tbain@google.com>,
        Shuhei Takahashi <nya@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Oct 18, 2023 at 12:07=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> w=
rote:
>
> On Wed, 2023-10-18 at 10:35 -0600, Raul Rangel wrote:
>
> > > > > Instead of reverting the patch, perhaps allow users to take this =
risk
> > > > > by defining a Kconfig, since they're aware of their policy rules.
> > > > >
> > > >
> > > > That sounds good. Or would it make sense to add an option to the
> > > > policy file? i.e., `verifiable fsmagic=3D0x794c7630
> > >
> > > Perhaps instead of introducing a new "action" (measure/dont_measure,
> > > appraise/dont_appraise, audit), it should be more granular at the
> > > policy rule level.
> > > Something like ignore_cache/dont_ignore_cache, depending on the
> > > default.
> > >
> > > Eric, does that make sense?
> >
> > I guess if one of the lower layers was a tmpfs that no longer holds.
>
> I don't understand what's special about tmpfs.  The only reason the
> builtin "ima_tcb" policy includes a "dont_measure" tmpfs rule is
> because the initramfs doesn't support xattrs.

I mentioned tmpfs because as you said, it's listed in the ima_tcb policy
as dont_measure. I'm not sure why since according to the man page
https://man7.org/linux/man-pages/man5/tmpfs.5.html it does support xattrs:

> The tmpfs filesystem supports extended attributes (see xattr(7)),
> but user extended attributes are not permitted.

Maybe tmpfs can be removed from the dont_measure list?

>
> > Can overlayfs determine if the lower file is covered by a policy
> > before setting the SB_I_IMA_UNVERIFIABLE_SIGNATURE flag? This way the
> > policy writer doesn't need to get involved with the specifics of how
> > the overlayfs layers are constructed.
>
> A read-only filesystem (squashfs) as the lower filesystem obviously
> does not need to be re-evaluated.
>
> With the "audit" and perhaps "measure" rule examples, the policy can at
> least be finer grained.
>
> > In the original commit message it was mentioned that there was a more
> > fine grained approach. If that's in the pipeline, maybe it makes sense
> > to just wait for that instead of adding a new keyword? We just revered
> > this patch internally to avoid the performance penalty, but we don't
> > want to carry this patch indefinitely.
>
> I'm not aware of anyone else looking into it.
>
> Mimi
>

Thanks for working on a fix!

Raul
