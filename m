Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09C47CE35A
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 19:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjJRRFd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 13:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjJRRFc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 13:05:32 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266A8B0
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 10:05:30 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c3e23a818bso83101971fa.0
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 10:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697648728; x=1698253528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUgZsAMS7wlU8iBe6DF+4g+6G1i93WOvrNnJ1NaOaO8=;
        b=GyUl/qBLhUFD0XZJQJ39MMr+MkokXREtAQE+Fdyhcv5Y0Dr7RDWxJ/PARh7eRydivN
         8y6CuPjRt22GroPVcjawK/aYxb8ROrJQvwBIEaPi5jA7RofP8yJ8ByFGb/trsXL0pRWk
         0gCiATKAZ/JuM6cVokrd7N5pd5wRO/ouZ7bOVmgdmj5cx7xgUr/xmYKGswSXG/9FcxJA
         hj/Q8/basmozevkB5uM63FtbI4dcA5ui5KNT1RalPtDp87tJvqNcvEfCd/90OzRtWdoB
         lliVJzd1SYRY9TCuSwgAeGut7nK3RdrjOf4U6mn0cRHHHVK2BoS5ayOJgOqeIqDRhFwt
         vWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697648728; x=1698253528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUgZsAMS7wlU8iBe6DF+4g+6G1i93WOvrNnJ1NaOaO8=;
        b=GvfVqJCB+x8Yzx+UN6bRi9IHrl0NpYJn24J2tBxKYwDYBm3pRUABcIdNE5XrbaSkMz
         GIlIYu4MatZsVY749T//ZpEIDhDToVDTiPYd6L75RUnavU6AgCgLELnSFQ5r/LD9NWbO
         1LGSy0R4YRejISgGiSy3Dx6ck7JSOD8aoTOk3Cq16qzbxf1O4egSEgorFOXxAgHkcQig
         plTetVCBb98g4utip6ltITyNpIHPqVwfvu0uUFNCzKCzfcWTv8fZEJnYHNINwUCReSMd
         PJ/B1JoH+8glM8WIaty4X80BujY6ppkiWo613rT3PX6KZUYw21Q+NubeKxm9BRki+eBU
         p9pQ==
X-Gm-Message-State: AOJu0YysTrmikQGfT+NTEsbPVryO5VIMr0rJ8qCDalX8HX2F1zqaUoru
        2vYJd/mhu3UKpXYfU7LobOkvVfimKahq9Oqrr64=
X-Google-Smtp-Source: AGHT+IEv9805H0Xgn1SBo2V0yF090GSRt9N5C3D4shgi4o2GQQvWaomRiJ1+EaYJGNU9WFl702wdM6IbmdJhj1ZBHag=
X-Received: by 2002:a2e:a7ca:0:b0:2c1:7df1:14b1 with SMTP id
 x10-20020a2ea7ca000000b002c17df114b1mr2401346ljp.15.1697648728021; Wed, 18
 Oct 2023 10:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <CANT5p=rReboKPbEySnZsFAn8Zv2ZzgQQ8LhyTxkt538QgyxB7A@mail.gmail.com>
 <2023101757-dilation-femur-91b8@gregkh>
In-Reply-To: <2023101757-dilation-femur-91b8@gregkh>
From:   Shyam Prasad N <nspmangalore@gmail.com>
Date:   Wed, 18 Oct 2023 22:35:16 +0530
Message-ID: <CANT5p=oPGnCd4H5ppMbAiHsAKMor3LT_aQRqU7tKu=q6q1BGQg@mail.gmail.com>
Subject: Re: [request for patch inclusion to 5.15 stable] cifs: fix mid leak
 during reconnection after timeout threshold
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Stable <stable@vger.kernel.org>, Steve French <smfrench@gmail.com>
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

On Tue, Oct 17, 2023 at 1:14=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Oct 17, 2023 at 11:43:26AM +0530, Shyam Prasad N wrote:
> > Hi Greg,
> >
> > It recently came to my attention that this patch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/patc=
h/?id=3D69cba9d3c1284e0838ae408830a02c4a063104bc
> > [Upstream commit 69cba9d3c1284e0838ae408830a02c4a063104bc]
> > ... which is marked with Fixes tag for a change that went into 5.9
> > kernel, was taken into 6.4 and 6.1 stable trees.
> > However, I do not see this in the 5.15 stable tree.
> >
> > I got emails about this fix being taken to the 6.4 and 6.1 stable. But
> > I do not see any communication about 5.15 kernel.
> >
> > Was this missed? Or is there something in the process that I missed?
> > Based on the kernel documentation about commit tags, I assumed that
> > for commits that have the "Fixes: " tag, it was not necessary to add
> > the "CC: stable" as well.
> > Please let me know if that understanding is wrong.
>
> That understanding is wrong, and has never been the case.  Please see:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.ht=
ml
> for how to do this properly.
>

There were two statements that led me to making this assumption.

In the link that you provided:
=E2=80=9CNote, such tagging is unnecessary if the stable team can derive th=
e
appropriate versions from Fixes: tags.=E2=80=9D

Also, the below link says:
https://www.kernel.org/doc/html/v4.10/process/submitting-patches.html#using=
-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
=E2=80=9CA Fixes: tag indicates that the patch fixes an issue in a previous
commit. It is used to make it easy to determine where a bug
originated, which can help review a bug fix. This tag also assists the
stable kernel team in determining which stable kernel versions should
receive your fix. This is the preferred method for indicating a bug
fixed by the patch.=E2=80=9D

But I can now see how this can also mean that additional tagging is
not necessary if it has a "Fixes" tag, but "stable" tag is still
necessary.

> We just have been sweeping the tree at times to pick up the patches
> where people only put Fixes: tags.  And then we do a "best effort" type
> of backporting.

Understood.

>
> Odds are this commit does not apply to any older kernels, and yes, I
> just tried and it did not apply to 5.15 at all.  Please provide a
> working backport.
Will do that soon.

>
> > Regarding this particular fix, I discussed this with Steve, and he
> > agrees that this fix needs to go into all stable kernels as well.
>
> Great, please provide working backports and we will be glad to queue
> them up.
>
> And in the future, please properly mark your patches with cc: stable if
> you want to see them applied, AND for you to get FAILED notices if they
> do not apply as far back as you are asking them to be sent to.

Will do. Thanks.

>
> thanks,
>
> greg k-h



--=20
Regards,
Shyam
