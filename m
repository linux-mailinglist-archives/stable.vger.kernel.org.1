Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D375F7A24EC
	for <lists+stable@lfdr.de>; Fri, 15 Sep 2023 19:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbjIORgJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 15 Sep 2023 13:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236306AbjIORfy (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 15 Sep 2023 13:35:54 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CC83AA4
        for <stable@vger.kernel.org>; Fri, 15 Sep 2023 10:34:07 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-770ef96aa01so154640485a.2
        for <stable@vger.kernel.org>; Fri, 15 Sep 2023 10:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694799246; x=1695404046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0w0jftHrCKOLI2sub5u/VeO/32jPwYn8o9L7rrDhT8=;
        b=C3YzfpQnPRTWEN7YloNioiOpM10fq1DthdYTNZZ0GNMh/ulir/zHT00Fg6QNfrT3sn
         /eswteh+WFfHjQx5ww8hPcY+XbjR/2OfxI4ytHJTwllf0OwqslAPmzN/Vh3YvYDnyXNO
         pE9bqrY3ausXGLEwyt+821845V6vigVY4JpkedDbFCNMLqxkFj2J8bKZJCPM0iUyMz88
         2mq2cOwuSLRkxpdV4SvPKTfkiu3LLdJ27PODERWkoax51UatP+4ZwmqpoC8tTSz0KyxN
         LgYqX8nXLJV3fMYLgcoCctPXktq3ngzuXP5RvDNvkF5R2jOWehV9ZjVvwGh/q3kIyyHb
         a5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694799246; x=1695404046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0w0jftHrCKOLI2sub5u/VeO/32jPwYn8o9L7rrDhT8=;
        b=DryH9ZjeNw6TuCcIhtSAfn9thciGn5zuvj2Sx4O2uIumup952dJoTJPwK/jVka7OQw
         c/BVLwFq4kDw6OhpEBKANDyKFnREdSvD8U45xetAUlruFLgVvfywlJc2Bo4cjY2okVwW
         OUMI4g2A2Z4P6S0/0PsoAw+ohEuThr4IAZL6LkNOBj+bPNn2eDARNBsLO3Jz3o/L/3FL
         90QCi46xMvvd0ll77PzBwTr9RWN0IWsBnyfdugHJLqi5zjHZJEdMlSKvb4c5j2KdciZ8
         yInurnhITMxvb1BjDFin7xGmdWzuyKxpcKf2PskPYtv/I7FMuTknJU5zJIIeFYhmoHgd
         smKA==
X-Gm-Message-State: AOJu0YzlYjkme90YMTuI8TlhFaO2glygcuSNGaCk8/h5BVtzza/k7QLs
        URLLWtX7syk5PJ5fWIocwGaIj2WcVFsAuBw6M6fpPA==
X-Google-Smtp-Source: AGHT+IEZ/WDxzF/O9gB4A+40qEo3bPuHJhEt/xOjx6Re1kZpnRTINetruNrbaRwq/pC5z/EudhBlcPg80BxynPtATiE=
X-Received: by 2002:a0c:e094:0:b0:653:5961:f005 with SMTP id
 l20-20020a0ce094000000b006535961f005mr2596649qvk.26.1694799246336; Fri, 15
 Sep 2023 10:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230915-bpf_collision-v2-1-027670d38bdf@google.com>
 <20230915171814.GA1721473@dev-arch.thelio-3990X> <CAADnVQJVL7yo5ZrBZ99xO-MWHHg8L-SuSJrCTf-eUd-k5UO75g@mail.gmail.com>
 <CAKwvOdkbqHFTvRNWG==0FjOPHgnA-zqE2Gn_nB4ys6qvKR2+HA@mail.gmail.com>
 <CAADnVQLfdMuxWVGKSF+COp8Q7DnKxYL0w5crN19vPkSd0Gh7mg@mail.gmail.com> <CAADnVQKJbTM-1n8YKvpC9XN7=tZuJi9mhnmmZSTVFOeBDv+SGA@mail.gmail.com>
In-Reply-To: <CAADnVQKJbTM-1n8YKvpC9XN7=tZuJi9mhnmmZSTVFOeBDv+SGA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 15 Sep 2023 10:33:54 -0700
Message-ID: <CAKwvOd=1X+2m2ZRUft9y+j8H0WBLWbM=VEiS+O0FfywnfpRYyA@mail.gmail.com>
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

On Fri, Sep 15, 2023 at 10:28=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> And please use [PATCH bpf v3] in subject, so that BPF CI can test it prop=
erly.

Testing `b4 prep --set-prefixes "PATCH bpf "`

--=20
Thanks,
~Nick Desaulniers
