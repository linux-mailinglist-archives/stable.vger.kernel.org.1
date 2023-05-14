Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10ABD701C0A
	for <lists+stable@lfdr.de>; Sun, 14 May 2023 09:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjENHCM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 14 May 2023 03:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjENHCL (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 14 May 2023 03:02:11 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E42D2681
        for <stable@vger.kernel.org>; Sun, 14 May 2023 00:02:10 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f24ddf514eso9348261e87.0
        for <stable@vger.kernel.org>; Sun, 14 May 2023 00:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684047728; x=1686639728;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ipeoKscHgah9xEaJz5t9ypcS1lPmng0xWHvZxTb6Jgg=;
        b=p2PhG4fkTRRBj7PIhMhYuICMkA5ckQnUayse9fleSx9KKhWa5MWWaJIyiRkvPfWri+
         3ArDHkL/VYyR1bxQ35eftG8+MtrzcjgSpSYxUo87cN+7gJtKtLJrJUf52DOWADtU+Dac
         aBmBt825gApA8vZFfnq1QHfcFj0f4Q3d3TN+PHMUQGLyuNG6Ogh84NI+CKtR9iAr0B9C
         Aod+l4VSAL8n2MKdnY43UFlTG7vghbVQ579aPgFvb+7GIfEKg1OPyQfL3vpQgQJPkWl/
         qON/TOV9XEBeCSz2zbVwnY4Y7HE2r0RJVKFdUf+UDlVvFlTYzDa4m1ZBBiSH6helQ2RL
         +Y1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684047728; x=1686639728;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipeoKscHgah9xEaJz5t9ypcS1lPmng0xWHvZxTb6Jgg=;
        b=Evy7e8UUkc2qkA+2v2nnlIeJf29l1FyhvTRaB9/TltBMvgyTVdcb9tRj8UTksoB5fF
         7w+PoBTkR7ikUg4TpaEaYTlgFdNNt6KOSFZp6W5hsjqBDgM5OJgj/8vFTBDimeyOGke1
         GQzwBVphYFR9uoB9SfgT0FMtkekyWKmjRI3zEpjPrSDI8zK4yQ6enHNEaaVEz6ro7sxH
         9vsVd3PsjeWMOeEAcLgZj1KnlwSFriCF5mdZNROZQOqmnOlonJFJgB6aDxeRmilrlZRp
         l+veo0PLsZoV/emKGMe/081uWlxlEqesy9Vn+zaASeJ2VABfgfADUUV9seSrz2opPZco
         bo4Q==
X-Gm-Message-State: AC+VfDxotzpimcQDrTT9os9wvzW7LkfdC5u9ZH9X3/a8tviT5ReBowPB
        BM9A2XZfSXE/RNVDNeDUD22fpbbmXFemcqpMVow=
X-Google-Smtp-Source: ACHHUZ5LFdOFCyzOlzh/l8eSfrvA3bTMfisLwVsFhHq0MBZBz2EqixIq1dkz2luzYFuHRtOqPhW4kJokWiaXDmNAWI0=
X-Received: by 2002:ac2:54ac:0:b0:4e7:4a3c:697 with SMTP id
 w12-20020ac254ac000000b004e74a3c0697mr5147170lfk.38.1684047728082; Sun, 14
 May 2023 00:02:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6022:738a:b0:3e:915f:349c with HTTP; Sun, 14 May 2023
 00:02:07 -0700 (PDT)
Reply-To: jennifermbaya036@gmail.com
From:   "Mrs.Jennifer Mbaya" <jennifermbaya03@gmail.com>
Date:   Sun, 14 May 2023 08:02:07 +0100
Message-ID: <CAJq9GYgwDBheZiP2v4gv7TbN3G1D1==woOO_joQ=Q+1UUcR2mQ@mail.gmail.com>
Subject: =?UTF-8?B?UHLDrWplbWNh?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Pr=C3=ADjemca
Dostali ste sa na ocenenie od Organiz=C3=A1cie Spojen=C3=BDch n=C3=A1rodov =
pridru=C5=BEenej k
medzin=C3=A1rodn=C3=BD menov=C3=BD fond, v ktorom bola va=C5=A1a e-mailov=
=C3=A1 adresa a fond
n=C3=A1m boli uvolnen=C3=A9 na v=C3=A1=C5=A1 prevod, preto po=C5=A1lite svo=
je =C3=BAdaje na prevod.

Dostali sme pokyn, aby sme v=C5=A1etky neuhraden=C3=A9 transakcie previedli=
 v
r=C3=A1mci nasleduj=C3=BAceho
48 hod=C3=ADn, alebo ste u=C5=BE dostali svoj fond, ak okam=C5=BEite nevyho=
viete. Pozn=C3=A1mka:
Potrebujeme va=C5=A1u naliehav=C3=BA odpoved, toto nie je jeden z t=C3=BDch
internetov=C3=BDch podvodn=C3=ADkov
tam vonku, je to =C3=BAlava od COVID-19.

Thanks
Jennifer
