Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744E47C7D34
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 07:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjJMFvO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 01:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjJMFvN (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 01:51:13 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F73BE
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 22:51:11 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40675f06f1fso18012995e9.1
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 22:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697176270; x=1697781070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EQLiRaX/YffqZzPXqXx314gzGVTb/3QHRDs3oVcvjY=;
        b=egNF/XgWtEzGqyep6R9gKkukV05TsHGTl9UGImHNDCWKuxWPZ97yJIvrq3LqBgeS8R
         Bn2TNRVbuA9FgGbsWwxaK4NTl8zGGIPmCLv/zVVCP4YngNU/L23zRv3O9sLCtWkIO7q7
         qPpeKyyHoefVizaUwcM6rZrODNkefVjsdqr2gNTNnmsLWenXAPSpfVJf4rC3jUSwrpNt
         wUDTWGn+40sylQTIK+tB/qqp6QGVdKiPHdh1yVgF6JRlwcPARY2FYk2fKnDdiMBhdHYy
         ryBvCRP/HXtH0311i0g2/RgGRyLx7fRcKDv6IO2TuU7UdUnbWYo9CIHqglVNz4fxLPDj
         cOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697176270; x=1697781070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EQLiRaX/YffqZzPXqXx314gzGVTb/3QHRDs3oVcvjY=;
        b=gqIfB1CD+/MnTBiwzPQh7bX9q8T0l/VvEShe+bmuNuDRAvHwbttWHZR3V76LOaRUH+
         1kuxrPgglb46EON+l5kN+Upe1CsMs/MTh3Ft3LaBkHoNTVcFINCkNT/j6cQY/ZsSw29U
         8+pp3m+U/UbHkomXOXKqNqXuFvPtf4ixWdk0soBu3dw9jEdmx+vsA2ivrKhskQGcr0e7
         4616nCCSbppnKB9AvMlOe+QX3W6NV6bz8c1ynHdmLvqEyhnU1Of2GKHiL97rCIRvBrpO
         teCDS8ZtYTTTCZY6mRGN+QwIsIilGBG9aalCx0hgXo90spcaDTtl/XKIQ66yuqQdpSFv
         uGyA==
X-Gm-Message-State: AOJu0Yy8ltR/Cz8yQgP8jiRIg9EE/O4YCMBz2dZ/JHoFiL01FQYiHK84
        O9xVLqccbvyvD4pLooN05TbUi1Y25hE///4CrIo=
X-Google-Smtp-Source: AGHT+IHkI2kWCM7Bq5gbR/LxmGFIC+e7T2WpxA61ilAcHEMybrkDb0r5fV/J8slOb0gLYbNBxvDEt96kdNvF0VSrcPs=
X-Received: by 2002:a05:6000:71e:b0:329:2649:ced5 with SMTP id
 bs30-20020a056000071e00b003292649ced5mr24730387wrb.32.1697176269992; Thu, 12
 Oct 2023 22:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20231006135322epcas5p1c9acf38b04f35017181c715c706281dc@epcas5p1.samsung.com>
 <1891546521.01696823881551.JavaMail.epsvc@epcpadp4> <20231010074634.GA6514@lst.de>
 <CA+1E3r+2Ce4BCZ2feJX37e1-dtvpZtY6ajiaO_orn8Airu2Bqg@mail.gmail.com>
 <20231011050254.GA32444@lst.de> <ZSbVuuE8YxgwpqM8@kbusch-mbp.dhcp.thefacebook.com>
 <20231012043652.GA1368@lst.de> <ZSgRWrcw1FFw3XRJ@kbusch-mbp.dhcp.thefacebook.com>
 <CA+1E3r+gEPQgaieuwNXuXSDp5LHCQpUa8KFc80za4L9e88bUhg@mail.gmail.com> <20231013043806.GA5797@lst.de>
In-Reply-To: <20231013043806.GA5797@lst.de>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Fri, 13 Oct 2023 11:20:45 +0530
Message-ID: <CA+1E3rL8GtKBaRHLh1qYQNffbUpKHMAmBk226nR1LLSiKhfbGQ@mail.gmail.com>
Subject: Re: [PATCH v3] nvme: fix memory corruption for passthrough metadata
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>,
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

On Fri, Oct 13, 2023 at 10:08=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
>
> On Fri, Oct 13, 2023 at 07:49:19AM +0530, Kanchan Joshi wrote:
> > > precedent to start doing it.
> > In my mind, this was about dealing with the specific case when the
> > kernel memory is being used for device DMA.
> > We have just two cases: (i) separate meta buffer, and (ii) bounce
> > buffer for data (+metadata).
> > I had not planned sanity checks for user inputs for anything beyond tha=
t.
> > As opposed to being preventive (in all cases), it was about failing
> > only when we are certain that DMA will take place and it will corrupt
> > kernel memory.
> >
> > In the long-term, it may be possible for the path to do away with
> > memory copies. The checks can disappear with that.
>
> As soon as the user buffer is unaligned we need to bounce buffer,
> including for the data buffer.

Yes, but that also sprinkles a bunch of checks and goes against the
theme of  and doing as minimal as possible (at least for passthrough).
Had the plain buffer (potentially unaligned) gone down, either it
would have worked or the device would not like it and user space would
have got the error anyway. No?
