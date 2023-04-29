Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A115F6F245F
	for <lists+stable@lfdr.de>; Sat, 29 Apr 2023 12:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjD2K4P (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 29 Apr 2023 06:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjD2K4O (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 29 Apr 2023 06:56:14 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E251737
        for <stable@vger.kernel.org>; Sat, 29 Apr 2023 03:56:13 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2a8bae45579so6683491fa.0
        for <stable@vger.kernel.org>; Sat, 29 Apr 2023 03:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682765771; x=1685357771;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xpFpHPrlBzxjQNXmyCpRnWgUSDJxwQtxmcSzkiEKFxY=;
        b=TRY0yPmd+xo9PAMgU/wTT8Iz8eP6FfinDoB6eFeHPY9+IquXMPhjYfkJgRszXNkrsS
         981RddSQsX50Z6izQCPtXqLJ1/Bbe1GUFf1eBjLobzd6baCI7rC26pgfB26eLNNs0ZdG
         XQNmwpMxLB9zQ27MIfEWBcaCQQhdCloHbuFkfLowt3iCZVZCFnNFRAH3D0QkjaZcteJ2
         FOnVDhVls31E2ckiU3tLXvW9cSWKjv/xZiS4fR2gAaMpBcJTDTLu5n3Nl3aCSXN5XvqS
         V2W/QvJkK+b8tKCUwv3jQ+egrwpSfpdubBo6lPm8XlsQeDdyvGnXa1xTR7QbcPUtljvr
         dXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682765771; x=1685357771;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpFpHPrlBzxjQNXmyCpRnWgUSDJxwQtxmcSzkiEKFxY=;
        b=kG0Q/LcKkw7GpLwK/UVm1OWNTqUv5z0IaFly31In3PlHWRy7cAHTAcIpXviTsSDws/
         t4fKG1JpzaQSlyRY1nxgDopuMWFdyieY0hS9TqCPmucRabkixYXhC2DSOqmSd0npVzi5
         h+k5DPzkPVVPjEzLJKeZ9mmCnFMo9oE05ENpzxi1ciRsVS1gZowfuOXfG6EHVNLok3Fo
         G/1RDYl+yetDttOSEnbxH4Y9rgi8z9eCxMSrQM2ec6MYXfTOjmTJIxCNJ5WO826HBxOM
         ZNCD24u6yU2Qz/joXgSzXUPNjxEOR3qOrmOoZgBuIhMReQs2bTNnzNk4KlM/OZ4+zqKU
         UouA==
X-Gm-Message-State: AC+VfDxjCONuMmZ/Yg/TdC411beGmuF3yc9KZqRC7BgPVI3zaiKYTqzY
        aZSLimHFsuH6LkF8RSLqlm9t4BuVz3h3qSflB3M=
X-Google-Smtp-Source: ACHHUZ5REBDyFgSJCH5VZ2ScGA3k+SFq2DyYNVd45yDSdXp1A2NChYVtDCktsHOiAeMrzYLGoUVqerNlqNphxGY7l8c=
X-Received: by 2002:a05:651c:146:b0:2a8:c4d0:b135 with SMTP id
 c6-20020a05651c014600b002a8c4d0b135mr2165957ljd.49.1682765771657; Sat, 29 Apr
 2023 03:56:11 -0700 (PDT)
MIME-Version: 1.0
Reply-To: jolinewilliam86@gmail.com
Sender: annwilliam297@gmail.com
Received: by 2002:a05:6022:8401:b0:3b:cff0:28c7 with HTTP; Sat, 29 Apr 2023
 03:56:11 -0700 (PDT)
From:   Joline William <jolinewilliam88@gmail.com>
Date:   Sat, 29 Apr 2023 10:56:11 +0000
X-Google-Sender-Auth: _vhcMC057Srvev6_ktG7ZknCG1U
Message-ID: <CANvyKwkVcxLmHjj4A6sUbNzJUcFfO34jb_P4cskU0FHuBP2ZEQ@mail.gmail.com>
Subject: Da MISS Joline William
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

Meu querido

Eu sou a Srta. Joline William, do Canad=C3=A1, escrevendo da Costa do Marfi=
m.
   Por favor, quero que voc=C3=AA me ajude a investir um total de 8,5
milh=C3=B5es de d=C3=B3lares que herdei de meu falecido pai. Oferecerei a v=
oc=C3=AA
35% imediatamente ap=C3=B3s receber o fundo em sua conta.

Vou atualizar quando ouvir de voc=C3=AA

seu amor para sempre

Senhorita Joline William
