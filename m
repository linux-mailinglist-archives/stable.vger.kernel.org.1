Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D6D7A52C9
	for <lists+stable@lfdr.de>; Mon, 18 Sep 2023 21:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjIRTOX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 18 Sep 2023 15:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjIRTOX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 18 Sep 2023 15:14:23 -0400
Received: from mail-lj1-x263.google.com (mail-lj1-x263.google.com [IPv6:2a00:1450:4864:20::263])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A7C114
        for <stable@vger.kernel.org>; Mon, 18 Sep 2023 12:14:15 -0700 (PDT)
Received: by mail-lj1-x263.google.com with SMTP id 38308e7fff4ca-2bffdf50212so27907851fa.1
        for <stable@vger.kernel.org>; Mon, 18 Sep 2023 12:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=valis-email.20230601.gappssmtp.com; s=20230601; t=1695064454; x=1695669254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycWlLp+ly44V6fwuApdFKo/ERnrPwmBjEIYtwLm8qg8=;
        b=gkG2B8Bd7GO5qa8PBuubMAvtlAiojA4HiYyQgsEUB9Id9h+wQLUYKdlCuN0/t7NYjx
         Ahqwg2ElkAJA2ylMIcR19wP40d/uqaR+p+N3slzjhinv9OWeN872OgwDteKxH17mhpal
         3GHV/UvdvoYBEBBgT0Q4xaQ2potaJ7M8J5bNxgxInZ0k45J/9UAuN/L+IrRSNPKJlbZj
         7t6H/hlSLZXEOQqZl+x8JvSXvnEApZ5a+OE5wsXDac1UuOKrxEOfLT4oLCjLFtZGuCvV
         jCNSMxQMqiOJ5g9ddTA9SPxKRegFbHUykcVO7oPvrWa+Fzchucd/eDZxW5FHaVT0uFW6
         tSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695064454; x=1695669254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ycWlLp+ly44V6fwuApdFKo/ERnrPwmBjEIYtwLm8qg8=;
        b=TYmuM2JVlBMu3QB1zTBLzUqlAu0msZePLsegbfb+vPPIRJKl1J1QL/iuKD3a0UQ818
         imI/alkPLG9u0cBa6rekFE+VMt+2vH5kd6csaPs8t0ANSTffX1Dd6GVnLjAKubySXA+B
         jyhfkbG2ZHia8bqfMd3kBd7fJpinstPHJwylzIwdoRQkB2Idmu/OqwI55Ttml9mywAh3
         hBFNPd2gzyEG2xkGP2dfU9cayRxg6MwG9zE+Fz5oiIGhnBCjr/9O5KKJDPxIos6lcIi/
         Qb3FjAj8NXfvOs/P68oT4IRXNxgbAj1fPrdOHJlbx2DIPewotVkld/YaxcggGwUHn+gd
         p1Ug==
X-Gm-Message-State: AOJu0YxPjn558D5W1Hf7S7u2NBoXxnLhikBSu20SbC+ahSP0GfSRN3Lz
        2VH9kcAMAshYkf9JeeeqDAK54jnmB4ctLs2QSpsOeN/yeMLPSIIJyEVJ
X-Google-Smtp-Source: AGHT+IGpHNuOZcVnZy+CqtdkxWVhB9tBtptbFrk4zwXjNv1snyItEe6bR+CwuStDpBkNgaRrTqIxrXx1bBLJ
X-Received: by 2002:a2e:96cf:0:b0:2bf:a961:2374 with SMTP id d15-20020a2e96cf000000b002bfa9612374mr9043545ljj.47.1695064453717;
        Mon, 18 Sep 2023 12:14:13 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp-relay.gmail.com with ESMTPS id qt6-20020a170906ece600b00991e20d3befsm1462429ejb.119.2023.09.18.12.14.13
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 12:14:13 -0700 (PDT)
X-Relaying-Domain: valis.email
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-9a6190af24aso653348266b.0
        for <stable@vger.kernel.org>; Mon, 18 Sep 2023 12:14:13 -0700 (PDT)
X-Received: by 2002:a17:907:775a:b0:9a2:16e2:353 with SMTP id
 kx26-20020a170907775a00b009a216e20353mr9200235ejc.6.1695064453158; Mon, 18
 Sep 2023 12:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230918180859.24397-1-luizcap@amazon.com>
In-Reply-To: <20230918180859.24397-1-luizcap@amazon.com>
From:   valis <sec@valis.email>
Date:   Mon, 18 Sep 2023 21:17:30 +0200
X-Gmail-Original-Message-ID: <CAEBa_SCoUVCwVAZOtYfdtinbnF85-0fCYVbT-KAiBi4f75fWtQ@mail.gmail.com>
Message-ID: <CAEBa_SCoUVCwVAZOtYfdtinbnF85-0fCYVbT-KAiBi4f75fWtQ@mail.gmail.com>
Subject: Re: [PATH 4.14.y] net/sched: cls_fw: No longer copy tcf_result on
 update to avoid use-after-free
To:     Luiz Capitulino <luizcap@amazon.com>
Cc:     stable@vger.kernel.org, Bing-Jhong Billy Jheng <billy@starlabs.sg>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Victor Nogueira <victor@mojatatu.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        M A Ramdhan <ramdhan@starlabs.sg>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Sep 18, 2023 at 8:09=E2=80=AFPM Luiz Capitulino <luizcap@amazon.com=
> wrote:

> Valis, Greg,
>
> I noticed that 4.14 is missing this fix while we backported all three fix=
es
> from this series to all stable kernels:
>
> https://lore.kernel.org/all/20230729123202.72406-1-jhs@mojatatu.com
>
> Is there a reason to have skipped 4.14 for this fix? It seems we need it.

Hi Luiz!

I see no reason why it should be skipped for 4.14
I've just checked 4.14.325 - it is vulnerable and needs this fix.

Best regards,

valis


>
> This is only compiled-tested though, would be good to have a confirmation
> from Valis that the issue is present on 4.14 before applying.
>
> - Luiz
>
> diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
> index e63f9c2e37e5..7b04b315b2bd 100644
> --- a/net/sched/cls_fw.c
> +++ b/net/sched/cls_fw.c
> @@ -281,7 +281,6 @@ static int fw_change(struct net *net, struct sk_buff =
*in_skb,
>                         return -ENOBUFS;
>
>                 fnew->id =3D f->id;
> -               fnew->res =3D f->res;
>  #ifdef CONFIG_NET_CLS_IND
>                 fnew->ifindex =3D f->ifindex;
>  #endif /* CONFIG_NET_CLS_IND */
> --
> 2.40.1
>
