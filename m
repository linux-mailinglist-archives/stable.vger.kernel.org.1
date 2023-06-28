Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4C0740B47
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 10:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjF1IZX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 04:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbjF1IWJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 04:22:09 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940024C1C;
        Wed, 28 Jun 2023 01:12:34 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5768a7e3adbso10996957b3.0;
        Wed, 28 Jun 2023 01:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687939954; x=1690531954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/F4R2xIwhAteDzm26GEr3kEl3pSlXhCeAsnchT8YT0=;
        b=TtzQfna7QT2BvJR5Z0EzlNkXatiyhK7kSS/wrXDnPn6DbRXPLQ37ZY/Jwb2Z9VCiKX
         xaD/UA42fWbVueyaYU5oengpDLFo+Pv7n+NibeSURhnulZAB4XPUyfVd3EopxVyI+YvP
         IQ4gktTBwH344w1zoATsc7CfP7kbNBAOaG1UPLJaDzzBxddCDlqhP+1ZfQHJg+Oi6ESE
         1Gw6gypghTyMRis7qiggm5epq4grFWV+kEhtfoytY5+UirWh4ah8nYjXYu96f995bI+E
         09XQXZWDmUlV77uuHAqUU3OBb/F/LSpQBI75FfkdnS64RobLZa0ewxHq/JSHeNi+JAug
         eZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687939954; x=1690531954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/F4R2xIwhAteDzm26GEr3kEl3pSlXhCeAsnchT8YT0=;
        b=F2V97fkI3FYzL2Cbs8jvb4+bfenU38OBHu9SR9GZ4k9PfZ3MwGkPzD8tVemTYW1pV6
         SSRwcDWPm1hMMx3OKBzIatrVK3ZnrFcq9ItzisGnYg9GtR/kYsAkHrFz0aoaQrzfA3+L
         Sm5CrYdjTgLiUBdse19LfiJkV1vK3l/YHAf8mYIH52wxkzS1C5+INglVxLRqN/0J5g8h
         vWA9s+M/zy20cjndXn1l+KzN4ziC9NxlYHImqVp9HvzYqvUKFp3EHpVSwL20wJUiU8uS
         BRNII3ZA6OiDTBZnkFy3Z6lD313jFJuD/dCjyYKiYrGm31gTQam6OqrtiYh5QX+vTPX1
         EK9g==
X-Gm-Message-State: ABy/qLayFTYRglJ6YIhzMP8Au3NAE4Wg0MAL22GOXzsGVMpxLSYH3tNC
        xtjb+nL8aeBAqFFWFIQXLtZy9ggYXng0LPbICFc=
X-Google-Smtp-Source: APBJJlFZg1vdM0bJKcJW2dZtFWmRG/uWyW1nykdLe6Drgc1ce5ksLQ54e8wjqbpPEeF3txbVgDIOJU1iYRycd8Q+CZQ=
X-Received: by 2002:a25:2007:0:b0:b9e:c516:6e32 with SMTP id
 g7-20020a252007000000b00b9ec5166e32mr603794ybg.24.1687939953777; Wed, 28 Jun
 2023 01:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230627035000.1295254-1-moritzf@google.com> <ZJrc5xjeHp5vYtAO@boxer>
 <35db66a9-d478-4b15-ad30-bfc4cded0b5c@lunn.ch> <CAFyOScpRDOvVrCsrwdxFstoNf1tOEnGbPSt5XDM1PKhCDyUGaw@mail.gmail.com>
 <ZJr1Ifp9cOlfcqbE@boxer> <9a42d3d3-a142-4e4a-811b-0b3b931e798b@lunn.ch>
In-Reply-To: <9a42d3d3-a142-4e4a-811b-0b3b931e798b@lunn.ch>
From:   Moritz Fischer <moritz.fischer.private@gmail.com>
Date:   Wed, 28 Jun 2023 10:12:22 +0200
Message-ID: <CAJYdmeOatYbZo616HZv_peyqQRa38gtF9eT483wKNkG8gfN84g@mail.gmail.com>
Subject: Re: [PATCH net v3] net: lan743x: Don't sleep in atomic context
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Moritz Fischer <moritzf@google.com>, netdev@vger.kernel.org,
        pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
        davem@davemloft.net, bryan.whitehead@microchip.com,
        UNGLinuxDriver@microchip.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Andrew,

On Tue, Jun 27, 2023 at 4:51=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Side note would be that I don't see much value in iopoll.h's macros
> > returning
> >
> >       (cond) ? 0 : -ETIMEDOUT; \
> >
> > this could be just !!cond but given the count of the callsites...probab=
ly
> > better to leave it as is.
>
> The general pattern everywhere in linux is:
>
>     err =3D foo(bar);
>     if (err)
>         return err;
>
> We want functions to return meaningful error codes, otherwise the
> caller needs to figure out an error code and return it. Having iopoll
> return an error code means we have consistency. Otherwise i would
> expect some developers to decide on EIO, ETIMEDOUT, EINVAL, maybe
> ENXIO?

Can you clarify if you suggest to leave this alone as-is in patch, or
replace with something returning one of the errors above?

If the former, anything else missing in the patch?

Thanks,
Moritz
