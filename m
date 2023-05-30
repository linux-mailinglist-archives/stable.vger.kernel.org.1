Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63722715DD4
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 13:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjE3LvP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 07:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjE3LvO (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 07:51:14 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84CBEA
        for <stable@vger.kernel.org>; Tue, 30 May 2023 04:51:10 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-510f525e06cso7622652a12.2
        for <stable@vger.kernel.org>; Tue, 30 May 2023 04:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685447469; x=1688039469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXw2bJhZ/bTyaEyxNQlJ8soVao7954SJAKnERIc09i4=;
        b=autIVxQ3xlvfVjTszY4j7+kzC2GuU0njfhIYohgWpp1qmD6xio9ea4zY0tbwtCd7Pk
         Cp3DjJqyNpteL0lGjtfZLLq18W210AQ+o7/oK1DpZxDqbJ4cNjOHvGDtVQMlFifBkNzb
         4AZEqwfIIoWEvuYWgOSyjyZ0AzjiTnaMh5JUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685447469; x=1688039469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXw2bJhZ/bTyaEyxNQlJ8soVao7954SJAKnERIc09i4=;
        b=WhCh4QESA/bjjCoDt8PsRfGRKt+imSUvWSmSD6CRpwl8VMUWDxnol/Hqh63DxId2Qt
         /3KBGKPx8S1qhxzillG6YXoYi4DEH6AYSYPhIrdjEyXTYIVxKX09r9/3B/uUcNSxHoeb
         E7H2PFuCVhaue+BM7lhW5YOmwtzCD/c42uSPNwr7zdu0kXp4Rx21Av1Qe4WsLVCGGq7i
         kgDljxqhUQNvu3xVA4/GhJQVrFGNicwsWY1cIam97Ueo4muORBEGEhV/l1o+D9CsMZE7
         Tyfe5QmUe+BX3UhGHavW8hKJTBFj0SImFZAHft+vnaFsTeAUb9c3sBPDya6YkQ8o+jF0
         F/XA==
X-Gm-Message-State: AC+VfDxodX7D/4/jA/gvXb4gzKgtYN1WwMKu4htX5bQSxDG/v0pigo9t
        CALgB3/3V94T1IBMefUGBYee471FkNsqTyE/lnYnTYFK
X-Google-Smtp-Source: ACHHUZ4HqTOnMr9jWM3Xaij/auI+yBjZTay482KnRRq9tq5N7rwAEzsDQGnBmUPIuKqc0/slpUNJ1g==
X-Received: by 2002:a17:907:6e25:b0:973:ea41:3f0c with SMTP id sd37-20020a1709076e2500b00973ea413f0cmr2388266ejc.20.1685447468834;
        Tue, 30 May 2023 04:51:08 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id lf4-20020a170907174400b0096f7500502csm7290265ejc.199.2023.05.30.04.51.08
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 04:51:08 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5147e8972a1so6984828a12.0
        for <stable@vger.kernel.org>; Tue, 30 May 2023 04:51:08 -0700 (PDT)
X-Received: by 2002:a17:907:3f11:b0:961:b0:3dfd with SMTP id
 hq17-20020a1709073f1100b0096100b03dfdmr2439731ejc.7.1685447467702; Tue, 30
 May 2023 04:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230528190835.386670951@linuxfoundation.org> <ZHXUGdFMIcB5HL8s@duo.ucw.cz>
In-Reply-To: <ZHXUGdFMIcB5HL8s@duo.ucw.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 May 2023 07:50:50 -0400
X-Gmail-Original-Message-ID: <CAHk-=wjekYoijzNK-MCQKvrO_7m0m9nRmt3ebKcHyhR-XJimUA@mail.gmail.com>
Message-ID: <CAHk-=wjekYoijzNK-MCQKvrO_7m0m9nRmt3ebKcHyhR-XJimUA@mail.gmail.com>
Subject: Re: Wrong/strange TPM patches was Re: [PATCH 6.1 000/119] 6.1.31-rc1 review
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, l.sanfilippo@kunbus.com,
        jarkko@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 30, 2023 at 6:46=E2=80=AFAM Pavel Machek <pavel@denx.de> wrote:
>
> > Lino Sanfilippo <l.sanfilippo@kunbus.com>
> >     tpm, tpm_tis: Avoid cache incoherency in test for interrupts
>
> Description on this one is wrong/confused.

Yes. Commit 858e8b792d06 ("tpm, tpm_tis: Avoid cache incoherency in
test for interrupts") in mainline.

The change to test_bit/set_bit may be a good one (and adding the
IRQ_TESTED case to the bit flags), but that commit wasn't it.

As you say, the enum should now enumerate bits, not bitmasks.

             Linus
