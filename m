Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1817729714
	for <lists+stable@lfdr.de>; Fri,  9 Jun 2023 12:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239720AbjFIKiI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 9 Jun 2023 06:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238551AbjFIKh0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Jun 2023 06:37:26 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C81D3A8C
        for <stable@vger.kernel.org>; Fri,  9 Jun 2023 03:36:20 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-976a0a1a92bso301018266b.1
        for <stable@vger.kernel.org>; Fri, 09 Jun 2023 03:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1686306978; x=1688898978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYsNQRTKdujJx2uaKy6pB5AMEs2kGLaS/0Oqa5TB6fk=;
        b=pyipid6tIaqGfyMEv8vLUpcXRSslEE0efeDr4g0WPHZpsNn3WuIV0B021YfT0MOWz0
         XDyxFN42z3Sii7FI7CLMI8oUHi9zkqUMLGKeKuPNWQQjhQCiD2zdzJ9f7x67y+3Sbikp
         Exbfw/GIchK0ExSn89XQjQ4LJhqzm1nP5crjZQo2Z1ccQwGOCuTCM4ucHzM3hUHmvsxO
         7iJEp+ei5EobD8tPbsvNJOqLJRECO900/S2Csw2hok/2iYYXOfPQXvHI5q1/mYIoJkt2
         e4j0/fs1InEjtDVkPW6OqS2udLPiSW8IROgc6nS0r6H3hLscRDVzjNCs3Q0yyBaREnRM
         xFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686306978; x=1688898978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYsNQRTKdujJx2uaKy6pB5AMEs2kGLaS/0Oqa5TB6fk=;
        b=HchtkIMOZ6IlQ65JYT9NGOjvd2c4GTbIzdLQaODMppcCcMqvYiOCf6a6V6puHR1EAU
         QyUHlbjY+DudnCEodRkzTJ9tcpaCBGeph3cOSoP25QQnzby4A5Rp/h20c/ts68nU74+5
         AkBHheSZiNiSEhpB3vdMeF/wMbhvytVujWkgg3ylwaUXx6WXUBLFDMfe8MAqVIGXj/qD
         Li5W2kGnyUxAw/H6tEtH/e5itZhSZX1Rn0p9DxUjwyttti/SB+Osw8h0Ldxd6++Jk0oS
         i/DOtIvRFzWRjJJ39NIpJ5vRUQCqfxEekNxMy/5pGLAQLzuOPuYrpXdQv3djWrzxHZpJ
         nuDw==
X-Gm-Message-State: AC+VfDy+Q7PGXDnlEYP3s9kMQTF+yRNRIXu3WGdT5TURF7/qvNa1AVIo
        NlObFqr/pRePZiTJ601Y6tfdCy7Mkr8s7YN1+2/siA==
X-Google-Smtp-Source: ACHHUZ5+jPqCDQMhOX/CgsZBGYIrgMvqz2bph7TIpaL4dzCNGHPGzqjekpisjQiaEJan20arvC3F8yFVGwsbATqRsO0=
X-Received: by 2002:a17:907:970a:b0:961:69a2:c8d6 with SMTP id
 jg10-20020a170907970a00b0096169a2c8d6mr1706812ejc.69.1686306978577; Fri, 09
 Jun 2023 03:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230608175726.909746266@linuxfoundation.org>
In-Reply-To: <20230608175726.909746266@linuxfoundation.org>
From:   ogasawara takeshi <takeshi.ogasawara@futuring-girl.com>
Date:   Fri, 9 Jun 2023 19:36:07 +0900
Message-ID: <CAKL4bV5VJ_K7wRzFvWah92zchvwJOPHTAP5akKcurn6+iV4mwg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/224] 6.1.33-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg

On Fri, Jun 9, 2023 at 3:00=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.33 release.
> There are 224 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 10 Jun 2023 17:56:43 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.33-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.1.33-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64), arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
