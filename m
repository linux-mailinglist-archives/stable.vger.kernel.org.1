Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B9C711364
	for <lists+stable@lfdr.de>; Thu, 25 May 2023 20:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjEYSO0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 25 May 2023 14:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjEYSOZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 25 May 2023 14:14:25 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29289E2
        for <stable@vger.kernel.org>; Thu, 25 May 2023 11:14:24 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-96f6a9131fdso142932266b.1
        for <stable@vger.kernel.org>; Thu, 25 May 2023 11:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685038462; x=1687630462;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XI35elI6ccao2NTbZ6G9feXJUfFKH8iakzLZ6UuwH4w=;
        b=GkHeXBm/QM//5tB6Bl1h/wzvGI618RSnO9mjQ+eJwYcct2WxnGYR96BZIzHDJpVBqz
         jbq2okOdpgfGI4lyyIoHMM1CutaihA7UnHJG7Mw+RWfIATOdPk9QDzZF8iebW6/T3hfX
         vjo9RyUjjVsKGPhApr7k9aJG4cdSNnYZKZ8bBfdc66ryPYD9knQ61IXcDFqASsZ4MT6Z
         R4QMb8FaNl3qONpW1vcrL13kutXF+2eCu13MWlXS4CNm5d7xzauH+H0lgMvAsyHla/Gm
         /RpAVGbhRYjbOKUc+QmTP7DqZbuvtXkGMUPiIBHv9EzvghIuJZQv3Wa8DrXpO6/v/f8I
         t8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685038462; x=1687630462;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XI35elI6ccao2NTbZ6G9feXJUfFKH8iakzLZ6UuwH4w=;
        b=Rd+g0IG195AP2hZH6uvIprqGYpqZS39f1M8WSVpS7ihqxaimB35UHremoTv20C5ggF
         aEY2vwd9aIKUWWUM5UjRfKeWdv8dAeHGQr/q1k7d/6sFbxCbTU1S/Ctm9BEP6zbocPBQ
         GTGV5U6IHx/Kpql3cS9uLNBzKExld2A2t2MgtDMeQjehc5YPaj3WKklYSKl0eiTgEo3w
         DaFI8YYn0Qpj+KDRuDfKPX4+SIPZK44LzXbvxh5y9ixP6/f3gnbi5R+0sM7dUmyJlgPv
         p02Fv/nMhkXAzOZEOQtabBDxfg4Irp3/SkLBOnGvQnDX7i31YlIrzp/JZydBGJ4Njkcs
         wL4Q==
X-Gm-Message-State: AC+VfDwC4JOHdaGGXv+U2PmEiYN9K5tSrYFisfs1sBlNIhe4CC/alrFQ
        IdaW+/6S1Ln3tKrggqo1db/AsukFYC+laG29Qw==
X-Google-Smtp-Source: ACHHUZ5lQUFsyZpVJ502AWBeaqZ95CzIqADRrELiJ2tnkiuog62d9b9FxQiRJmY2S72Z8rkb8GpAXKNYahVbvAB6w+s=
X-Received: by 2002:a17:907:9309:b0:96a:ca96:3e49 with SMTP id
 bu9-20020a170907930900b0096aca963e49mr1867213ejc.13.1685038462592; Thu, 25
 May 2023 11:14:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:5d07:b0:957:2933:8891 with HTTP; Thu, 25 May 2023
 11:14:22 -0700 (PDT)
Reply-To: naromharrison23@gmail.com
From:   Narom <kindomarou30@gmail.com>
Date:   Thu, 25 May 2023 18:14:22 +0000
Message-ID: <CADGpXnztPL5yA2_puoa1mQ+__3ORv1DFC1cfVUY3=f-Qs7PUbA@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello,
Greetings
do=C2=A0 you see my message please reply me
