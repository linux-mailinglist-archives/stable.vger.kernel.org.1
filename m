Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA1A7A24F2
	for <lists+stable@lfdr.de>; Fri, 15 Sep 2023 19:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbjIORgk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 15 Sep 2023 13:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbjIORgR (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 15 Sep 2023 13:36:17 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB80F273C
        for <stable@vger.kernel.org>; Fri, 15 Sep 2023 10:35:20 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-649edb3a3d6so11154036d6.0
        for <stable@vger.kernel.org>; Fri, 15 Sep 2023 10:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694799320; x=1695404120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owNQ13PHd9ClWZJbvI5Hodz6Lzm8HqwmexoIjdWr1bU=;
        b=2cxw2psUbQ76cNQvcNHIoHBPu7P7Osx46XYh51MQloiHW4pEJ71ZVnZqv+16L+mKGH
         mX+2nUFo7CpSuGLxmlrVu7BAfoI/DAq6VbBZiCTk98WYv49KJ1UAqLwvCDvdz2LAO0iv
         dkLWJF5Vlbqg61Qu+ZR6FRSZR4TnX55fMWJpv4w42m0+7SWn+mQIOzRso83ggL/smrZp
         A5CJE461acstU0/h8MDywoP2fYCaNCa1NhQ/mHT2AfTLIUgCEz2meLkD5/s/tKM0XM6x
         MhNfUrA8vfJP6AoFHs/+CgHmDs8m5zEj4N4Y5qhiEsmol9CaZ4i2niZmpcphS9E3duYA
         H/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694799320; x=1695404120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owNQ13PHd9ClWZJbvI5Hodz6Lzm8HqwmexoIjdWr1bU=;
        b=ZoSkwztIEW8kBcA4Tt3XWCRJ8eYLEz9j9bD2eiowGfeJRJRAqx4RuwuN4tqQnto8ja
         D7W9+FVucwb5m8tr0IeAzqcwbACrIAO423OCUwbkvZOKGDHqfM9CcUErKWhvM5IlsZes
         Ut98ec0T1F7j2aW+6F5rFkTDna8iTJVhw3882b1L1bHt9tmJLGj4lS41Dy/ZjkipcEqq
         MhM1nDEDI5SuYPVy2G1zlAK5QD4OAndx9iDviymXz5V0fhVry2ePdXKeNhqWdkx7WoFc
         AdnluN9rx+MDrBH7X5dQFkxtldBrNoO19eCSfbWNkq1oeIkJKIE7yo3rAIS3RawywflI
         9m1Q==
X-Gm-Message-State: AOJu0YxcF/vz+Yy0Mk6n+MKs7f9SjP5N/0L9+kiQ40H+6P6FNiu64jX0
        80SrJiiWhFdjwa2sAc7e9kQc/bl1zWHEHD3JDIkvBw==
X-Google-Smtp-Source: AGHT+IHdGqPa14fW1RYWtKsSg3nKw+WZmvBbn9ell9GzXkK5NaK5II6nkrUV2Di/ifEhZ+uqQNXs4h3FFiBXu1c9pec=
X-Received: by 2002:a0c:f20a:0:b0:656:1dfa:d845 with SMTP id
 h10-20020a0cf20a000000b006561dfad845mr2919472qvk.3.1694799319895; Fri, 15 Sep
 2023 10:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230915-bpf_collision-v2-1-027670d38bdf@google.com>
 <20230915171814.GA1721473@dev-arch.thelio-3990X> <CAADnVQJVL7yo5ZrBZ99xO-MWHHg8L-SuSJrCTf-eUd-k5UO75g@mail.gmail.com>
 <CAKwvOdkbqHFTvRNWG==0FjOPHgnA-zqE2Gn_nB4ys6qvKR2+HA@mail.gmail.com>
 <CAADnVQLfdMuxWVGKSF+COp8Q7DnKxYL0w5crN19vPkSd0Gh7mg@mail.gmail.com>
 <CAADnVQKJbTM-1n8YKvpC9XN7=tZuJi9mhnmmZSTVFOeBDv+SGA@mail.gmail.com> <CAKwvOd=1X+2m2ZRUft9y+j8H0WBLWbM=VEiS+O0FfywnfpRYyA@mail.gmail.com>
In-Reply-To: <CAKwvOd=1X+2m2ZRUft9y+j8H0WBLWbM=VEiS+O0FfywnfpRYyA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 15 Sep 2023 10:35:07 -0700
Message-ID: <CAKwvOdmq2YTrgOztdVy8MEeKU1m8hScu42iyij6fj5nndRCN3A@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: Fix BTF_ID symbol generation collision
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, stable <stable@vger.kernel.org>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Marcus Seyfarth <m.seyfarth@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Sep 15, 2023 at 10:33=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Sep 15, 2023 at 10:28=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > And please use [PATCH bpf v3] in subject, so that BPF CI can test it pr=
operly.
>
> Testing `b4 prep --set-prefixes "PATCH bpf "`

Ah, should just be "bpf" for --set-prefixes (fixed before sending v3).


--=20
Thanks,
~Nick Desaulniers
