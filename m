Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07674788789
	for <lists+stable@lfdr.de>; Fri, 25 Aug 2023 14:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjHYMeI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 25 Aug 2023 08:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244878AbjHYMdt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 25 Aug 2023 08:33:49 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050D926B1
        for <stable@vger.kernel.org>; Fri, 25 Aug 2023 05:33:22 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52a40cf952dso1342773a12.2
        for <stable@vger.kernel.org>; Fri, 25 Aug 2023 05:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1692966797; x=1693571597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32P+ZFI1tSBojfi+E4xOhhTXJzH5jER+YjKVHzgSHAY=;
        b=3/pPdnklLTkdbJrgJjjALLC8S9ds83NXjsVorOj0iSf6+JOH8lir8uFRqKG6jmWPy1
         SPr0o3gfGT5Yfn4LFHq8NhmF9KpZg9EefVxYUchbr1wIVAD2jLL+PhrhAHICCuCvBKm4
         m8NhhP4ncZ34L9rcscQKJpyU4MiofBRki8f6WMlhJkpPvyLDKS7LLuF1EqJ4w1+pnE90
         2dQxfBLlvVTHhMst30TsErK2v1ph3CGs6lAQ5AJsMTTDWg61TVnHRE/NdShkd40W3WFF
         diaqMnMWOIzFox+XEC8ibWHvaos6f33EItwBcHkzIwQBQd0fKs4YOqEuxvyEgmvEA7yx
         Cyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692966797; x=1693571597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32P+ZFI1tSBojfi+E4xOhhTXJzH5jER+YjKVHzgSHAY=;
        b=eIOvNSzjzUD3DTUtopBl6Pd1RnulokzX5B40hzVMkKjX8HbjMrNh++uC6hU0sSqCL0
         x+JgC/CFFG53mruLbrByt4Ol59k/GGAINbeALBytg9Cp8UaYEdXE4QbSC2uucQ6GQniW
         lo0wDIIVzeI9mo8wnFvjYz82HnxFhZcLRhtVqOdSrJuGTC9ofr4gZtvKQKp5ZeWWjPUb
         JjnoRXONtsKQxbhQM9NB+QIR9EqgEnrQre623zFGRlhTX2sZjYDLS9JDV6cIh2LfX7yn
         mj39znYoIKkeyp+yPuBWPnrbYpbpNluFMKb0+JKV9FpAl/DTRRAnOYmm7xn6Mhc8LcyA
         zJ2A==
X-Gm-Message-State: AOJu0Yz2pbZajbWWwXKNSgNaFD6gVsRSGq2388P2OpR+ktR/ywV9SMr4
        9i88Lj9aLrjRzGs2UsKFbFfSzaqR3NT6Hmt3MdEoBA==
X-Google-Smtp-Source: AGHT+IGaKjOzBddpOyoRZ6/22JOWZ17clvrTJvTI5coC7kWzoLT+Rqa0qdBOS3qSGTaXHQW2d05vTnDmbIn4hnC0mD4=
X-Received: by 2002:a17:906:cc4e:b0:9a1:bccc:ef5f with SMTP id
 mm14-20020a170906cc4e00b009a1bcccef5fmr7737503ejb.53.1692966797212; Fri, 25
 Aug 2023 05:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230824141447.155846739@linuxfoundation.org>
In-Reply-To: <20230824141447.155846739@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Fri, 25 Aug 2023 21:33:06 +0900
Message-ID: <CAKL4bV7tpe696zsOWxF7uv5J-Rm0E=b5BVLw=+pbe7Wpmwv17w@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/15] 6.1.48-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg

On Thu, Aug 24, 2023 at 11:16=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.48 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 26 Aug 2023 14:14:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.48-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.1.48-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
