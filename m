Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5F47C8D1C
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 20:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjJMSfs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 14:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJMSfr (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 14:35:47 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE3AC0
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 11:35:45 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3296b3f03e5so2140705f8f.2
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 11:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697222144; x=1697826944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6iO0mscVZltk/HGalOm5s5AtgW0RI/j46gDoeifEAU=;
        b=QyVlSvghwW3Ykr3tG6yTumxgcs3jJc2gCcLrYAcseepHZNCUV/dbbvGrpFRwIjERgU
         FqKgQGEt5I8IvWh54Eqd8h9ktcnc2ABOLqiBCTV/a4Heh373robhjiLhHfNoBMWY4Whl
         33GXy4mOikbOwsh/B48N9zA0WdjjY+iiWMjCTDebidTMmPNsF65Io8jQLFI9N6QL/KwE
         qvCTE2+yuBqqn2k+D8d+BWIBgAsbfykDkpGiMGtHHealtrPfXDJQoFAVmPyWFoVvMdT2
         RQfk8ysgFJJbnbN9DNlqKIrM7lG6IrMEZbBJgRjWvNK4WRcx29MoGatrx4FTahnl3Pca
         Ikbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697222144; x=1697826944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6iO0mscVZltk/HGalOm5s5AtgW0RI/j46gDoeifEAU=;
        b=jvqGEueMAOoMZbbTPFU9rC0hrzG8rEiZdJH0tYMr5VaPSLxkghjtTMGeDz+VfXMPc8
         DH+x5PeFa1CaXYHR18yN7i/nl2N8rl+N9TLeHWlGzz2pDk5omPXguOC4+NGAWwUoGyVL
         qT+ie3571yBODeIJuJuLQsDMc0x97kp40/AeIRj20MltXNAqSktT7Q1MJ2ER8RwKa3Be
         ICgUzjpogyRx3riKsIgWjOM1T8OJTy1ny2XgrAhviCfpFr4+kOAvNlfFWrrLwrDRf5Kg
         YX7sCg5Razebaa8URFmKEvP/ZHhoGSd5NamJY75arXUmGpm+JI3m5X53KJvk+K31cl45
         3/NA==
X-Gm-Message-State: AOJu0YwiE0To4q2dZ+JkwhlaOvd2TZeGx9QlhfRB6RpIYnNB5M1d40aL
        t5ED8CZoHR4i3MTQy+a5g1kwx0eUAV3vOLVAI+BfyWVa1zY4dQ==
X-Google-Smtp-Source: AGHT+IGwYvFbMeA4IHW8jmxr+wUkgsFLxnKr66nqs6vB98wMt5LihFSiEIQs/EF43V9R+rHiSeT1pIuKKbnHVh6rCbs=
X-Received: by 2002:a5d:628a:0:b0:320:254:b874 with SMTP id
 k10-20020a5d628a000000b003200254b874mr25160488wru.11.1697222143924; Fri, 13
 Oct 2023 11:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c@epcas5p3.samsung.com>
 <20231013051458.39987-1-joshi.k@samsung.com> <20231013052612.GA6423@lst.de>
 <8c755915-2366-28ff-ffd4-be17d797557c@samsung.com> <ZSlL-6Oa5J9duahR@kbusch-mbp>
 <3438f3b8-f7d4-f0bd-44ef-7efb09ed6151@samsung.com> <20231013154708.GA17455@lst.de>
In-Reply-To: <20231013154708.GA17455@lst.de>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Sat, 14 Oct 2023 00:05:17 +0530
Message-ID: <CA+1E3r+gSWvN3VR38Uu=rHLy=9+iC-G5ta2sXq6LEXTG+OK_-g@mail.gmail.com>
Subject: Re: [PATCH v4] nvme: fix corruption for passthrough meta/data
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kanchan Joshi <joshi.k@samsung.com>,
        Keith Busch <kbusch@kernel.org>, axboe@kernel.dk,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        vincentfu@gmail.com, ankit.kumar@samsung.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 13, 2023 at 9:17=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Fri, Oct 13, 2023 at 08:41:54PM +0530, Kanchan Joshi wrote:
> > It seems we will have two limitations with this approach - (i) sgl for
> > the external metadata buffer, and (ii) using sgl for data-transfer will
> > reduce the speed of passthrough io, perhaps more than what can happen
> > using the checks. And if we make the sgl opt-in, that means leaving the
> > hole for the case when this was not chosen.
>
> The main limitation is that the device needs to support SGLs, and

Indeed. Particularly on non-enterprise drives, SGL is a luxury.

> we need to as well (we currently don't for metadata).  But for any
> non-stupid workload SGLs should be at least as fast if not faster
> with modern hardware.

But nvme-pcie selects PRP for the small IO.

> But I see no way out.
> Now can we please get a patch to disable the unprivileged passthrough
> ASAP to fix this probably exploitable hole?  Or should I write one?

I can write. I was waiting to see whether Keith has any different
opinion on the route that v4 takes.
It seems this is a no go from him.

Disabling is possible with a simple patch that just returns false from
nvme_cmd_allowed() if CAP_SYS_ADMIN is not present.
I assume that is not sought?  But a deep revert that removes all the
things such as carrying the file-mode to various functions.
Hope tomorrow is ok for that.
