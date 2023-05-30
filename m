Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF80715A58
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 11:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjE3Jjl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 05:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjE3Jjk (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 05:39:40 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38529FE
        for <stable@vger.kernel.org>; Tue, 30 May 2023 02:39:37 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-96f5685f902so634676466b.2
        for <stable@vger.kernel.org>; Tue, 30 May 2023 02:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685439575; x=1688031575;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YRqiASN2Kmi3N/FjLZoykugsqpLt95mGg2ga2qP8t0k=;
        b=moZNHxMKQfc7KylSCti8ZIiOJsQYrtlm6EQJZnzkqeSxc66pmC13mKtPPhLC+uuPFF
         pJnyAVM6swCiAFZDgTlj4FRsAoIGSxRjOKQX98H/WfYS8K2jydUARLE0vc5j0uoPvIQD
         vuAUdFcHSEOR4LRyWviImHt/ARyW5j1lL7a4rn3qyfuSGm1AjEtKkvv/E4M10QjFmMLv
         lhet4mIsRkMadBLvFXqlEFdE+Svyw52H4yXVCALcfBBWFH+pwRiy6dkBrl8o+uPlAtnC
         L9FIRd1EJMOIFSWZjb+nR/39PMqsp0FeY51qpVg69W2d9Sxow+7A8ummBPPv9K7xK+Pq
         PaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685439575; x=1688031575;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRqiASN2Kmi3N/FjLZoykugsqpLt95mGg2ga2qP8t0k=;
        b=L0JJFH16bT9igEx4raM9g9i+LpKnwcyKPIYZrFkSBE+jloUuT7Tr+3WMrl1VbNUXh1
         7rYs9pJWGUvqmTDdsVasHEVJriytj99ImKoMEPsCebeR6TzZoHhdaoTSBpIimnjnf5s4
         ZVFaEwpqenmdRdCavjnb9SQfnfcSkZN2p8O6fcTFDVK6ckCoEiA8QPuQDvnu9lg82hWC
         iGjkRBLYOzslfscjI3gAy/Ictk94Fd7IIj+2nGdSXhxgnAx6SgmfNTaU3wKoSJNuzOrK
         eL+7Fa9CUkQLlVHs1zAZ3kSxoxKSd0J3Sx3FiFJZwyr9d4rL3mmyiVRBWDqa2jyeQ8tz
         6UgA==
X-Gm-Message-State: AC+VfDzG7FMHLia4yrpCFVU0doCg2O9JBIxsO7ha+0xI/eGjFb/Ihtlo
        zYRVrl0VVWd8z0XkUteqm0CF03e6pr5Tlz5Qn0zax70fVA23jw==
X-Google-Smtp-Source: ACHHUZ6bxaoh9Ba4yLpLutEJdBKukSolRXIWn9BKGnBlwbQu2ZMEk/xPPn1VxnopY1+zeIn1rUhxQfXZ5cJiVe/LYpo=
X-Received: by 2002:a2e:3c11:0:b0:2ac:7ae8:2c10 with SMTP id
 j17-20020a2e3c11000000b002ac7ae82c10mr528990lja.33.1685439574952; Tue, 30 May
 2023 02:39:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:1999:0:b0:22f:3a39:53c4 with HTTP; Tue, 30 May 2023
 02:39:33 -0700 (PDT)
Reply-To: officialeuromillions@gmail.com
From:   Euro Millions <pete.wetzlinger@gmail.com>
Date:   Tue, 30 May 2023 10:39:33 +0100
Message-ID: <CAAik_9S+2CGVc5nLRxy0PEirNyRBokXRbX8_wWjguMg61+NtMQ@mail.gmail.com>
Subject: Aw
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Herzlichen Gl=C3=BCckwunsch, Sie haben am 25.=C2=A0May,=C2=A02023 =E2=82=AC=
650.000,00 bei den
monatlichen Euro Millions/Google Promo-Gewinnspielen gewonnen.

Bitte geben Sie die folgenden Informationen ein, damit Ihr
Gewinnbetrag an Sie =C3=BCberwiesen werden kann.
1.) Vollst=C3=A4ndiger Name:
2.) Telefon- und Mobilfunknummern:
3.) Postanschrift:
4.) Beruf:
5.) Geburtsdatum:
6.) Geschlecht:


Herr Anthony Deiderich
Online-Koordinator
