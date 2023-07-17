Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CE675708D
	for <lists+stable@lfdr.de>; Tue, 18 Jul 2023 01:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjGQXgW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 17 Jul 2023 19:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjGQXgP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 17 Jul 2023 19:36:15 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D0C19B2
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 16:35:25 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51e344efd75so10485905a12.1
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 16:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1689636819; x=1692228819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtXV9MJdcWQ3yaerrpPcjHyyt3tkQWswQOvaKX/GEv4=;
        b=AXom64Os+zYpFFbJFpA7yN+yjwv7MLG+dd1a10zyYdYkUiY+hVeeuTcd8Qzhwq1sFl
         +FVQvNGvvll/9H0+ds/XeV8zxRgFCk/4R2TjVZlQp2fFJPEABK7U6eydAvx92FJtNXLv
         IRk3v2qOB0qe1Ji7EpHJFmj/DAzwXKRZbNbklizNqEY/yoIN4clW4oIpQTQe7NX2T1xM
         6EsZBknMshQHJvLfQsW3RHZYjm9XP1REIBCjl94Hrlu/FwuZRuSsPFSANYpvguJ0PtFL
         cL+di9cryna8vWVRysZViHLhsO0msQBJ267NT1QwJC1uYWSmN/arM18LljigrsnBCFQC
         7EGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689636819; x=1692228819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtXV9MJdcWQ3yaerrpPcjHyyt3tkQWswQOvaKX/GEv4=;
        b=JTe9riJfr5YwnZ4XLCaVPTK4CwmlkNh+slK5RVRzotpnZqESLDJdQMKYKC6R876bGV
         4R0BGi81YzhfQIMJ9EpqIGz3Nlc7vKLlPxdGK3tqyHh+h+352lMeoBXxL3DAaA1gHeZV
         9BZqD/i74Cb1ugrjxszbxb46qMle1TMM8M5KHpLMsUZG8ieXqVVgqDhvQhwZJj/Bxesr
         WwoBqwU7F9XImf/OLJSiU+1tv9WLu8L9MVl2JhEKusFgjLDtg++tFu99Iv+JxA+GiMki
         d9s76rDjT/r5mMolQfe3bo0HNNKgYnd9dt/EFRuOmWSpCSekMWIeTxK1tqP7YGuPurVT
         tQWA==
X-Gm-Message-State: ABy/qLZycmeBwfhhRiab94c9LBijrQDRwwbMOwf/+9MXqNOUJ72yYzja
        DHG9s2grE6wYn0L6Yfgg7gs+PRv+XdYLv6PMUhZIaA==
X-Google-Smtp-Source: APBJJlEkO9vBaq0tdrTZcAH9NKIi3lBK7EEzRiXGXEIxDfsWPOwtrZFhOu+BC/Mbx5dohxK7P4AbEru/SpswUzzgcaE=
X-Received: by 2002:a05:6402:2695:b0:51e:5bd5:fe7e with SMTP id
 w21-20020a056402269500b0051e5bd5fe7emr13121576edd.17.1689636818850; Mon, 17
 Jul 2023 16:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230717201547.359923764@linuxfoundation.org>
In-Reply-To: <20230717201547.359923764@linuxfoundation.org>
From:   ogasawara takeshi <takeshi.ogasawara@futuring-girl.com>
Date:   Tue, 18 Jul 2023 08:33:27 +0900
Message-ID: <CAKL4bV4TnJamH7j3Z8OF=r706KSe4cv9Z-rYteeNJxD1ktgqrw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/589] 6.1.39-rc3 review
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg

On Tue, Jul 18, 2023 at 5:34=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.39 release.
> There are 589 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 19 Jul 2023 20:14:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.39-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.1.39-rc3 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
