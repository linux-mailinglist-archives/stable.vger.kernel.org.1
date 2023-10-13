Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB6D7C7B8D
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 04:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjJMCTr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 22:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJMCTr (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 22:19:47 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF2395
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 19:19:45 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40651a726acso16436585e9.1
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 19:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697163584; x=1697768384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4FeNWprudZxQlt1QL8KDXCBzcl81LLzp84ZGP+Pd/I=;
        b=KxVKPLw/ign65aeutjaX3G1EhK17lp+CTOtkDbdEg1L4sxOmvVdLwTvPO0iOvjEA12
         U49X1otX1ZAM9Bmugq/2G/1k11XL/KmZfBpP0Hg51rtl16u/toq/JbPlcd0/kiA6XTSL
         W8h5tGfrBu7P9XuC70o+E10kyn6JwDYbtoztrpNf453citMkCscOKQmm9DwXrk/aXg2T
         GFt3Wv6ga7GJFWSJ3xQjSvFSL9nbikYWbZ5oNJjMjJLrPg+NTTnR3HQgricHuWyO9AVw
         EmauvVrViTPJHPzSpLQzgPpHNDgvONK/2wiNkv/GADuNT11Ke6ChAwGwEztIMuzvt1Ix
         TZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697163584; x=1697768384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4FeNWprudZxQlt1QL8KDXCBzcl81LLzp84ZGP+Pd/I=;
        b=phIz9oz8bPf8K71N4qvFn9Qbaij94xOMcW7nXb+86RIqAqzFsle1RjY30lVDGEQEq6
         VbR+Gg8/KJRQQ3+YFzkYx9tF1QQtzsPItnlhmoMMXlYBC8no39tgP4U5y7tbGDST10Yi
         ZWZVpC/c1Jl6A1I2iDZtU8sCuzPMffo1LmyWmo/M/QafMQrPDTLSF7mpIUPIHtL1vtSq
         y4h2/90Wd/o34tua4TDGNZB+8DAO4pH6PtIv7BYc1eFp+4eoIY7vBIReh5aDEv6CtX/B
         0IVF3h7e2N3/Y2I51Q0TpsI/QvD9SQfvnnk96DSL/QC+Mj6km9Q4vnVvA10yNKUNhQCN
         Eo9Q==
X-Gm-Message-State: AOJu0YwLnsvh9WxZbXZu0BkehBchf2L1bWz2ExWUiVY2QTMx6UN3vFty
        rPp1R/spKUgSmWN3ia7j0EZv4mC8o7v0s/xooQc=
X-Google-Smtp-Source: AGHT+IHbEdeP/FvLtQBUA8coqiiD4ImLqKj5OYOku5Eh7GTT7WjD2zfvAGRtXD7pgWQNFNXZBRhDrLU3s/uj6iW5gk8=
X-Received: by 2002:a05:6000:109:b0:320:9e2:b3a2 with SMTP id
 o9-20020a056000010900b0032009e2b3a2mr22835447wrx.33.1697163583792; Thu, 12
 Oct 2023 19:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20231006135322epcas5p1c9acf38b04f35017181c715c706281dc@epcas5p1.samsung.com>
 <1891546521.01696823881551.JavaMail.epsvc@epcpadp4> <20231010074634.GA6514@lst.de>
 <CA+1E3r+2Ce4BCZ2feJX37e1-dtvpZtY6ajiaO_orn8Airu2Bqg@mail.gmail.com>
 <20231011050254.GA32444@lst.de> <ZSbVuuE8YxgwpqM8@kbusch-mbp.dhcp.thefacebook.com>
 <20231012043652.GA1368@lst.de> <ZSgRWrcw1FFw3XRJ@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZSgRWrcw1FFw3XRJ@kbusch-mbp.dhcp.thefacebook.com>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Fri, 13 Oct 2023 07:49:19 +0530
Message-ID: <CA+1E3r+gEPQgaieuwNXuXSDp5LHCQpUa8KFc80za4L9e88bUhg@mail.gmail.com>
Subject: Re: [PATCH v3] nvme: fix memory corruption for passthrough metadata
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        vincentfu@gmail.com, ankit.kumar@samsung.com, cpgs@samsung.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Oct 12, 2023 at 9:01=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Thu, Oct 12, 2023 at 06:36:52AM +0200, Christoph Hellwig wrote:
> > On Wed, Oct 11, 2023 at 11:04:58AM -0600, Keith Busch wrote:
> >
> > > I don't think it's reasonable for the driver to decode every passthro=
ugh
> > > command to validate the data lengths, or reject ones that we don't kn=
ow
> > > how to decode. SG_IO doesn't do that either.
> >
> > I don't want that either, but what can we do against a (possibly
> > unprivileged) user corrupting data?
>
> The unpriviledged access is kind of recent. Maybe limit the scope of
> decoding to that usage?

I can send an iteration today that takes this route.
Maybe that can be considered over dropping a useful feature.

> We've always known the interface can be misused to corrupt memory and/or
> data, and it was always user responsibility to use this interface
> reponsibly. We shouldn't disable something people have relied on for
> over 10 years just because someone rediscovered ways to break it.
>
> It's not like this is a "metadata" specific thing either; you can
> provide short user space buffers and corrupt memory with regular admin
> commands, and we have been able to that from day 1. But if you abuse
> this interface, it was always your fault; the kernel never took
> responsibility to sanity check your nvme input, and I think it's a bad
> precedent to start doing it.

In my mind, this was about dealing with the specific case when the
kernel memory is being used for device DMA.
We have just two cases: (i) separate meta buffer, and (ii) bounce
buffer for data (+metadata).
I had not planned sanity checks for user inputs for anything beyond that.
As opposed to being preventive (in all cases), it was about failing
only when we are certain that DMA will take place and it will corrupt
kernel memory.

In the long-term, it may be possible for the path to do away with
memory copies. The checks can disappear with that.
