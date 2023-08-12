Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0200A779C3D
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 03:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbjHLBYl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 21:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjHLBYl (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 21:24:41 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10FC30FD
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 18:24:40 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b72161c6e9so42281661fa.0
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 18:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691803479; x=1692408279;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FMtO+6FgeXIZDuZpJjyuw5qimvwIpKYDlrpPEPS7Cyk=;
        b=YvFh+vRRZOotbBdahFD3Tc5AflHnrd0pZyq9MUdPCG7bSWx0W2dHpvprMSeedRpNKi
         KPyM4ckOMMs8ZmV2zL2hRtBl1DBlQ7uhpAxlOeek88ELmzIMfIqlks2MhzJ3kwd4fhw0
         Vd/2HJ7+hWjyN2kFxLHwy11DqRry+roXUg0d0WqBYAFZgou9qq8xwt7ahVE0AhiAjoUf
         fqtreFoYIiAfB1ZEFVJ4O/lwteYFXxcWjlJNyohIp4tc3RsCJckNyUknWDqvrpXwx3uU
         rOXdTrdpwF8b46Ly6PM7mOfocsvzOjaxXDrUVdb9aVHOaCxTq7Fs/e09+Gkngoe7yYJ4
         tVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691803479; x=1692408279;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FMtO+6FgeXIZDuZpJjyuw5qimvwIpKYDlrpPEPS7Cyk=;
        b=Bu1Wq4QpkJjwIr60pX+zQPfXUB0DFcNg1vezE2ac7T/u0VvMw2Ok4Hz6iuRxIh7Zeo
         Ntgh7Q0HlpELovHzm1DSdmDdorwdzRZjCeu47vDYMyVXITgAlbXtdHAa91karkRWd1si
         a2nIdSt5cH4hpiK3aGq2QoodhttDEb0AdJobgLqlWHpb2HUXOoaMuFxX7uWdXt5mALdz
         E4I9LrpyB8/RK8LERx2oO8Me5jhcrletqrmbfakZ4eX+Bwa6d/Yrg3RTFao+2xwQKYwu
         5hyK1dU303+kfqhO68hYrHUdiCJNhYK7WGF9eSM6zFlHPnh32dGb/ALfP4HF7lamUUr6
         TH2g==
X-Gm-Message-State: AOJu0Yw3TVnINL7dSOkeZdB3ZyiVokLZ2fDA/MTBRVKMULIkUBN9sD6Y
        HgQw/RkJPOcRlA8wlJ0iH0BD65IoSNgADsLH5dg=
X-Google-Smtp-Source: AGHT+IEwv7+RFlKErIQQ3USTnlOgBF6Vho70+JWMu3EzLXbwZdB6oRtghtUsahItyl85yk4yT/hdTOBFcfshg9stICk=
X-Received: by 2002:a2e:9b58:0:b0:2b6:cd70:2781 with SMTP id
 o24-20020a2e9b58000000b002b6cd702781mr1226688ljj.12.1691803478777; Fri, 11
 Aug 2023 18:24:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6022:2385:b0:44:311e:8afd with HTTP; Fri, 11 Aug 2023
 18:24:38 -0700 (PDT)
From:   audu bello <a12udube@gmail.com>
Date:   Sat, 12 Aug 2023 03:24:38 +0200
Message-ID: <CAHRZggkakQ1nu+4WG+uN9xfopwMM=b5v4tbzgdPC-A+LAggEuw@mail.gmail.com>
Subject: =?UTF-8?B?YnVlbiBkw61h?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

--=20
Me preguntaba si recibiste mi correo electr=C3=B3nico anterior. este correo
electr=C3=B3nico ha cambiado a : a00728298@yahoo.com

Atentamente
Gerente de Auditor=C3=ADa
