Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535AF7A5CBE
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 10:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjISIkF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 04:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjISIkF (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 04:40:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC8DE6
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 01:39:58 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32003aae100so1727358f8f.0
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 01:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695112797; x=1695717597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrX/o9IaaLd8C3/27VSA5k/8nslPmD25D5g+cKSefCE=;
        b=TkRNeB1LjZRKGNt2hb+BeHF1q7PTgHitFR1/x4BUsqVk72e1mmeLC8dvyov4ghKyB0
         CIfg+YOGbs9az9EiGjyuktglOPhg28Nh8PSWG2g7qbHqahcJt51k98iP1dNm1xhIyJo2
         382W6F+Ubmi1Ip5BQ+5reGsgRh7jV+5VpVHjphXEfHpCwXRuebbkQiSz0v7C90IBjId+
         QzRiuC9vtJy31v7HJM1w6Oku0cThIuktdtJVIbDW8x0vUB4Egjq/tTA92nagK9+jqoWS
         IMBIhNnNhda80fEi1qHdcyIQtT60UWzvyuqrGprWEB1Vgt2e7jen11yU11js4qRr9diI
         vUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695112797; x=1695717597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrX/o9IaaLd8C3/27VSA5k/8nslPmD25D5g+cKSefCE=;
        b=Gvh5RrJvFCH/cDeS5vU5Rt8MT26Gnt6qi9rMdl8KvktM6ePDGc9SZTKTTJ1s1FAbz+
         XJnkh2EzVkqp4/DIUjH+WSZ70XK4Y22WEsLZbvO8Mgwy0Iui+EHfQQ7otCRq9iTMJ+lb
         uh4FbXIfugSB/elwkFmuNhzMc37XDWs1GeQvHZAvD3kHtY7skis14N7p9A4OvEIcAZPj
         34OYdqUKPcNvdJJ+E+fxEiiS29ntzfFo6ly0wuZ6gRwp5dbfkVWe00TTI+DuvhR5LhPf
         pTxw3EutfmsfZJb5QzT5oYve5qv5MXlmMmRkY08InQEVFa1Mz4AH7p6NrdcbXkajuZd2
         rCTQ==
X-Gm-Message-State: AOJu0Yyh7Ekh3JKrlDJ54my74ALBcJy4LmKZU0vh44/9BgkiLwprECC4
        uTpvDMgiYJPaWTAg/x97iSs8wo4UqqMQ0CKr+fA=
X-Google-Smtp-Source: AGHT+IG8fnudphfgdHldNvvN6b9HAIfRVnw9j+S5EodSB92Oy7omzXNzKjvaXZIc8FjPg6CYiCvZuPP1S4vu4R1ZY4M=
X-Received: by 2002:adf:ed02:0:b0:31d:db2d:27c6 with SMTP id
 a2-20020adfed02000000b0031ddb2d27c6mr1286973wro.30.1695112797112; Tue, 19 Sep
 2023 01:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230911134650.200439213@linuxfoundation.org> <20230914085131.40974-1-gerhorst@amazon.de>
 <2023091653-peso-sprint-889d@gregkh> <b927046b-d1e7-8adf-ebc0-37b92d8d4390@iogearbox.net>
 <2023091959-heroics-banister-7d6d@gregkh>
In-Reply-To: <2023091959-heroics-banister-7d6d@gregkh>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 19 Sep 2023 01:39:44 -0700
Message-ID: <CAADnVQKXqaEC3SOP9eNQH1f3YF0E3A_54kSEsU2LvCL_4Awe8g@mail.gmail.com>
Subject: Re: [PATCH 6.1 562/600] bpf: Fix issue in verifying allow_ptr_leaks
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Luis Gerhorst <gerhorst@cs.fau.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Eddy Z <eddyz87@gmail.com>, Yafang Shao <laoar.shao@gmail.com>,
        patches@lists.linux.dev, stable <stable@vger.kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        Hagar Gamal Halim Hemdan <hagarhem@amazon.de>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Luis Gerhorst <gerhorst@amazon.de>
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

On Tue, Sep 19, 2023 at 1:34=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Sep 19, 2023 at 08:26:28AM +0200, Daniel Borkmann wrote:
> > On 9/16/23 1:35 PM, Greg KH wrote:
> > > On Thu, Sep 14, 2023 at 08:51:32AM +0000, Luis Gerhorst wrote:
> > > > > 6.1-stable review patch.  If anyone has any objections, please le=
t me know.
> > > > >
> > > > > From: Yafang Shao <laoar.shao@gmail.com>
> > > > >
> > > > > commit d75e30dddf73449bc2d10bb8e2f1a2c446bc67a2 upstream.
> > > >
> > > > I unfortunately have objections, they are pending discussion at [1]=
.
> > > >
> > > > Same applies to the 6.4-stable review patch [2] and all other backp=
orts.
> > > >
> > > > [1] https://lore.kernel.org/bpf/20230913122827.91591-1-gerhorst@ama=
zon.de/
> > > > [2] https://lore.kernel.org/stable/20230911134709.834278248@linuxfo=
undation.org/
> > >
> > > As this is in the tree already, and in Linus's tree, I'll wait to see
> > > if any changes are merged into Linus's tree for this before removing =
it
> > > from the stable trees.
> > >
> > > Let us know if there's a commit that resolves this and we will be gla=
d
> > > to queue that up.
> >
> > Commit d75e30dddf73 ("bpf: Fix issue in verifying allow_ptr_leaks") is =
not
> > stable material. It's not really a "fix", but it will simply make direc=
t
> > packet access available to applications without CAP_PERFMON - the latte=
r
> > was required so far given Spectre v1. However, there is ongoing discuss=
ion [1]
> > that potentially not much useful information can be leaked out and ther=
efore
> > lifting it may or may not be ok. If we queue this to stable and later f=
igure
> > we need to revert the whole thing again because someone managed to come=
 up
> > with a PoC in the meantime, then there's higher risk of breakage.
>
> Ick, ok, so just this one commit should be reverted?  Or any others as
> well?

I don't think revert is necessary. Just don't backport any further.
