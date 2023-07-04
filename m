Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D3874724A
	for <lists+stable@lfdr.de>; Tue,  4 Jul 2023 15:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjGDNJK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 4 Jul 2023 09:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjGDNJJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 4 Jul 2023 09:09:09 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44875E64
        for <stable@vger.kernel.org>; Tue,  4 Jul 2023 06:09:08 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1b8a462e0b0so4778945ad.3
        for <stable@vger.kernel.org>; Tue, 04 Jul 2023 06:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688476148; x=1691068148;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PLCdGNeHnov65Y+Zq20pjDQdE63Mou+yTmivLkBstDM=;
        b=ntvKmZ0QkrPEiBKcZ5YItMdgNXlOG0CcsGrCulXMg6ohdnMRJkL/uQC5Ydw7sPKelI
         OV3dpuOSViyRz3U0W1tXuR8z7Xiw0sk3r4McUsDMePT4ZGS05Gj73oqPD6MTo8sAIwNq
         XhdVfM8/wNefLpxCfBNcFphPRf0C6IZWQL6nexBhs5UicH0J6MaTiIDOD97yOAjdpl4w
         kKzcQ/0dLYsLoyn6F7OWHfRMto3rbVfk6MI2FaWoQwjH+5hbHE3Aa0zOAgM0thhkWqtq
         jMNqdwSr9/iVThVALIyAjS2mGkKvg5HMa8IUJ8+ylHVGS3PKMldmHvHMCZtvYVTa/cgF
         jObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688476148; x=1691068148;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PLCdGNeHnov65Y+Zq20pjDQdE63Mou+yTmivLkBstDM=;
        b=hZaLG/YdRcIQilwp1M/a39ULai/aG4wJuAZGaX0zgObJQIVlYA2oTCIm2/mbgahcIc
         k94NMMTmgbRhJ1d6JLzq0sucIAzezqELjIzvklXfoLfOH4lUVyTprQHuR8jOvx3CpIpN
         tdF5jVac2kJ7SDzE8NrkEUoaAWEFleK7B4urKFDaNfVakoZBNo3iBN/Lwhl3Lrj9wUGR
         AKgjqPL/qeaL4qPZnHW2xN1r8OeRRthcQswcz4kbBjmLwvHBfKwmjtR4yD7KOSYndDtf
         oc5rriCh2MK3aCczwphOq/e3UP/ABO+FuEywBJQH2qYfgKjYonYUhSkToHKvIlLvNFXg
         IYMg==
X-Gm-Message-State: ABy/qLY9JSwnrzfsOeWpTBOh74n56bDnSGahCoN4u4xHqhl7sKF9u06M
        OcC/JGc1HI3viIeZ/f3K8EKDFZGmne39PcRvkgg=
X-Google-Smtp-Source: APBJJlG+k9+B9IBtVLnIeO4e19Jmk3MZQBOjiLUeq+hHbq9XcrNsKQkCbEoiSTSkGVBIz6pCzubmA3GjuyqMdNop0YE=
X-Received: by 2002:a17:90a:fa95:b0:263:76e8:b66f with SMTP id
 cu21-20020a17090afa9500b0026376e8b66fmr9744957pjb.30.1688476147511; Tue, 04
 Jul 2023 06:09:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a11:af1f:b0:4be:8032:9815 with HTTP; Tue, 4 Jul 2023
 06:09:06 -0700 (PDT)
Reply-To: philipsjohnsongoodp@gmail.com
From:   philips <okeyyoyopa7@gmail.com>
Date:   Tue, 4 Jul 2023 15:09:06 +0200
Message-ID: <CAH8nkvaG2hPnX17J_tg2yrEkYGrWsOcFo=cL5jQPyA78aZmP1w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

0JTQvtGA0L7Qs9C+0Lkg0LTRgNGD0LMsDQrQnNC10L3RjyDQt9C+0LLRg9GCINCR0LDRgC7QpNC4
0LvQuNC/0YEg0JTQttC+0L3RgdC+0L0sINGPINCw0LTQstC+0LrQsNGCINC4INGH0LDRgdGC0L3R
i9C5DQrQvNC10L3QtdC00LbQtdGAINC/0L4g0YDQsNCx0L7RgtC1INGBINC60LvQuNC10L3RgtCw
0LzQuCDQvNC+0LXQvNGDINC/0L7QutC+0LnQvdC+0LzRgyDQutC70LjQtdC90YLRgy4g0JIgMjAx
NyDQs9C+0LTRgw0K0LzQvtC5INC60LvQuNC10L3RgiDQv9C+INC40LzQtdC90LgNCtCc0LjRgdGC
0LXRgCDQnNC10YjQtdC7KSwg0L/RgNC40YfQuNC90LAsINC/0L4g0LrQvtGC0L7RgNC+0Lkg0Y8g
0YHQstGP0LfQsNC70YHRjyDRgSDQstCw0LzQuCwg0LfQsNC60LvRjtGH0LDQtdGC0YHRjyDQsiDR
gtC+0LwsINGH0YLQviDQstGLDQrQvdC+0YHQuNGC0Ywg0L7QtNC90YMg0YTQsNC80LjQu9C40Y4g
0YEg0L/QvtC60L7QudC90YvQvCwg0Lgg0Y8g0LzQvtCz0YMg0L/RgNC10LTRgdGC0LDQstC40YLR
jCDQstCw0YEg0LrQsNC6DQrQsdC10L3QtdGE0LjRhtC40LDRgCDQuCDQsdC70LjQttCw0LnRiNC4
0Lkg0YDQvtC00YHRgtCy0LXQvdC90LjQuiDRgdGA0LXQtNGB0YLQsiDQvNC+0LXQs9C+INC/0L7Q
utC+0LnQvdC+0LPQviDQutC70LjQtdC90YLQsCwg0YLQvtCz0LTQsCDQstGLDQrQstGL0YHRgtGD
0L/QuNGC0Ywg0LIg0LrQsNGH0LXRgdGC0LLQtSDQtdCz0L4g0LHQu9C40LbQsNC50YjQtdCz0L4g
0YDQvtC00YHRgtCy0LXQvdC90LjQutCwINC4INC/0L7RgtGA0LXQsdC+0LLQsNGC0YwNCtGB0YDQ
tdC00YHRgtCy0LAuINC+0YHRgtCw0LLQu9GP0YLRjCDQvdCw0LvQuNGH0L3Ri9C1DQrQvdCw0YHQ
u9C10LTRgdGC0LLQviDRgdC10LzQuCDQvNC40LvQu9C40L7QvdC+0LIg0L/Rj9GC0LjRgdC+0YIg
0YLRi9GB0Y/RhyDQodC+0LXQtNC40L3QtdC90L3Ri9GFINCo0YLQsNGC0L7Qsg0K0JTQvtC70LvQ
sNGA0L7QsiAoNyA1MDAgMDAwLDAwINC00L7Qu9C70LDRgNC+0LIg0KHQqNCQKS4g0JzQvtC5INC/
0L7QutC+0LnQvdGL0Lkg0LrQu9C40LXQvdGCINC4INC30LDQutCw0LTRi9GH0L3Ri9C5DQrQtNGA
0YPQsyDQstGL0YDQvtGBINCyDQrCq9CU0L7QvCDQsdC10Lcg0LzQsNGC0LXRgNC4wrsuINCjINC9
0LXQs9C+INC90LUg0LHRi9C70L4g0L3QuCDRgdC10LzRjNC4LCDQvdC4INCx0LXQvdC10YTQuNGG
0LjQsNGA0LAsINC90Lgg0YHQu9C10LTRg9GO0YnQtdCz0L4NCtGA0L7QtNGB0YLQstC10L3QvdC4
0LrQvtCyINCyINC90LDRgdC70LXQtNGB0YLQstC+INCh0YDQtdC00YHRgtCy0LAg0L7RgdGC0LDQ
stC70LXQvdGLINCyINCx0LDQvdC60LUuDQrQktGLINC00L7Qu9C20L3RiyDRgdCy0Y/Qt9Cw0YLR
jNGB0Y8g0YHQviDQvNC90L7QuSDRh9C10YDQtdC3INC80L7QuSDQu9C40YfQvdGL0Lkg0LDQtNGA
0LXRgSDRjdC70LXQutGC0YDQvtC90L3QvtC5INC/0L7Rh9GC0Ys6DQpwaGlsaXBzam9obnNvbmdv
b2RwQGdtYWlsLmNvbQ0K0KEg0L3QsNC40LvRg9GH0YjQuNC80Lgg0L/QvtC20LXQu9Cw0L3QuNGP
0LzQuCwNCtCR0LDRgC4g0KTQuNC70LjQv9GBINCU0LbQvtC90YHQvtC9DQo=
