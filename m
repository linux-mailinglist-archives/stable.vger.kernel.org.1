Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418E975B91B
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 22:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjGTU7n (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 16:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjGTU7m (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 16:59:42 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6333B2D6B
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 13:59:09 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-346258cf060so36015ab.0
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 13:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689886748; x=1690491548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwZ5fXf8YtsT6+X1dt0HNi/DCNDf4xsCXWX4xprI2rw=;
        b=0tIvtBuLDGSc3J8LfcEzF3fWH2Po4Y6IfPf/u1bpSpAeHdEUr5qW/54AqEsUjRFE2r
         GHNTBEO6YRDgawyM4F7CGCHU616uETV86Qyr55dx/nol0vauyTUfSI+OgnwNKwpJCuU2
         C61nnSSa/B56qL4aiGipoLm8VrHLaQTmxwnCsYXLcuWzwUzAEaHFRdaHurql6Ihc2fio
         xu7pv+askxPkKnCnbvVuG7IR8WLLzGg+5+xiWR3kKTsXMLUgw8g/zJYwxp1in5kaj7xH
         4Lk9WHGa6k15Cif6z5/EZYZdhcakLgJxWhXFha2XbNwoUMKRfoeO9Zze+VnHMaCdVFGm
         pgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689886748; x=1690491548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DwZ5fXf8YtsT6+X1dt0HNi/DCNDf4xsCXWX4xprI2rw=;
        b=NB56mtqZLS7ihf/pasEtI10dNekJ+4xAiZpgnnANcTYPfqu9n4j5tQC83bLCdfMfHa
         X+su28FeAEHVEQ0Hpa4Eq3wqqegeSwqK6/4JGnof8pWaQyWfYQ+7UJXr5c6vWwLVG8NU
         HoqBDX/3jvTTuzTk8dya72xG75i7namAR1vfr9alq2v+4Hb8HMuGfRq7VRT5s4o1Gyww
         DdIOC6QF7wGOxLtyn+Oc4G/n4xvL0N5nb5yf/MVxM+BwAVkeLlMaOqD22bOPjgwVCzqk
         9v4JQG/UVLoDYuGYtWrBiubfQ3tBJBjV86nROCHOTDuChdq7R9Oie9tlhMaRUE8LR3Zm
         V/WA==
X-Gm-Message-State: ABy/qLbKsu0r7ZN0g+flvY4zoPlOxMl2MCBRKGmZzg8WsvtodzosMlZV
        SdAHlwuB3xQLdaXQfTZKrETjBvgIg8rT1I6HwSNpjQ==
X-Google-Smtp-Source: APBJJlEUJUtr2UHyBrENVzCQMi/MMfsg04kTIDa0DRLRTCfX8QZGwQ0UBo2yaVjKFMr8ia4N8qYiGUrFrP2cIEsi3JQ=
X-Received: by 2002:a05:6e02:12cf:b0:346:5a8b:545e with SMTP id
 i15-20020a056e0212cf00b003465a8b545emr71141ilm.14.1689886747689; Thu, 20 Jul
 2023 13:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230720194727.67022-1-kim.phillips@amd.com>
In-Reply-To: <20230720194727.67022-1-kim.phillips@amd.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 20 Jul 2023 13:58:56 -0700
Message-ID: <CALMp9eTBWWcApb50432zZEGg+PMCzUELaZvdkzYngNSrriimWA@mail.gmail.com>
Subject: Re: [PATCH] x86/cpu: Enable STIBP if Automatic IBRS is enabled
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Alexey Kardashevskiy <aik@amd.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jul 20, 2023 at 12:48=E2=80=AFPM Kim Phillips <kim.phillips@amd.com=
> wrote:
>
> Unlike Intel's Enhanced IBRS feature, AMD's Automatic IBRS does not
> provide protection to processes running at CPL3/user mode [1].
>
> Explicitly enable STIBP to protect against cross-thread CPL3
> branch target injections on systems with Automatic IBRS enabled.

Is there any performance penalty to enabling STIBP + AUTOIBRS, aside
from the lost sharing? Or does this just effectively tag the branch
prediction information with thread ID?
