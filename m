Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C057DD4A4
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346839AbjJaRZk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346187AbjJaRZj (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:25:39 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA349F
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:25:36 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32f78dcf036so32533f8f.0
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698773135; x=1699377935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIZWJCwKHax9C+QeJXWOHZLwvnY52iGQdM+VZvg0M0A=;
        b=ANERs4dqvMB5fwWq1Vay2aQQFCQuBZjvegOLurpcI5XN3YHZ0sMo8Nhi8DX3Yr5gPQ
         uDC8WWzfY47a+2B+ApPWqdz0VZiXZDbtfx94jU19xYWXqq97gxleucrFLmPQ43reW0ZS
         KgAu0TX7+8Av5/oM+lH909TkdpD+5eRs1R4gwap3Ywu8sdbNilUkYdvXlDLfIlFHnfiY
         Sl1WFAOgG54TukUZHyUqsa/FPqmMqIczvFGAsxG33ezJwzMQWEGb+6mbIasD0WGZ6avF
         8STkOSJqj+zwbTiWrVqF68x0WP5PJB4Ow4RN1NPkltpQey+tN8z89yU87kO+BoiMdynW
         LJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698773135; x=1699377935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LIZWJCwKHax9C+QeJXWOHZLwvnY52iGQdM+VZvg0M0A=;
        b=vjRVxkfPs/2ZHaEV8El7IzAbyEtijPyLwz8FnFPiioMukprCYejJ6lz9Id+9DqJmMS
         YEjIJ2fTMMSXElg1WDdGiLftPjT7n5sfOIqM+dEQIPmAFAqcaEmNRN047FqDlyTfQcD2
         Bs+St2/fWvr77zeqeo6FK9yy2VgQocGJ3tPxBuMaY0iM1RPdCTPZO6Tyr+PI/vXpxkaE
         onljA2JY6UKOYLSB9JEKF3RXWxTMG53LOF/6fGKGVjxR5HO3KxhV+GX2ggpPhN7cywlF
         6K88J8qB5sPeHDKRFyH8vorHB5ocm/S4Gifo8FqhfeX1BN05cGdJSrh0awhW+fkKy9yC
         skCQ==
X-Gm-Message-State: AOJu0YygR1qFi5PEQ+y/Afi3eeZ88VE+ypGmuOm11QRsJrdsTVPNpWJs
        vbCwspH6YvB9tC57DoNs1WuiY3Pv2FrDUYW06wW0dQ==
X-Google-Smtp-Source: AGHT+IHux+m96y0lCL+d12a7bhvX7+Q5EnTHuKeVN73NlNvG2clvOGpDegK2A8iqftutQWfanFMOPkQy/Qjxos8moeQ=
X-Received: by 2002:a5d:6947:0:b0:32d:a129:3b6e with SMTP id
 r7-20020a5d6947000000b0032da1293b6emr3337486wrw.14.1698773135066; Tue, 31 Oct
 2023 10:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231031172217.27147-1-paul.barker.ct@bp.renesas.com>
In-Reply-To: <20231031172217.27147-1-paul.barker.ct@bp.renesas.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 31 Oct 2023 10:25:20 -0700
Message-ID: <CAKwvOdkX83OxM5myi93g_4wRWf5prVZse2s0do8QxGWV0TyJ+g@mail.gmail.com>
Subject: Re: [PATCH 4.14/4.19] ARM: 8933/1: replace Sun/Solaris style flag on
 section directive
To:     Paul Barker <paul.barker.ct@bp.renesas.com>
Cc:     stable@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Fangrui Song <maskray@google.com>,
        Jian Cai <jiancai@google.com>,
        Peter Smith <peter.smith@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        martin@kaiser.cx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 31, 2023 at 10:22=E2=80=AFAM Paul Barker
<paul.barker.ct@bp.renesas.com> wrote:
>
> From: Nick Desaulniers <ndesaulniers@google.com>
>
> commit 790756c7e0229dedc83bf058ac69633045b1000e upstream

Thanks for the patch, but Martin beat you to the punch by 1 day!
https://lore.kernel.org/stable/20231030212510.equbu7lxlslgoy3t@viti.kaiser.=
cx/

Sasha already has picked it up.
https://lore.kernel.org/stable/ZUA5BDnos1ASlFqM@sashalap/
--=20
Thanks,
~Nick Desaulniers
