Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C0B792483
	for <lists+stable@lfdr.de>; Tue,  5 Sep 2023 17:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjIEP7H (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 5 Sep 2023 11:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354294AbjIEKga (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 5 Sep 2023 06:36:30 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2303C199
        for <stable@vger.kernel.org>; Tue,  5 Sep 2023 03:36:27 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a63b2793ecso343519566b.2
        for <stable@vger.kernel.org>; Tue, 05 Sep 2023 03:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1693910185; x=1694514985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n//JsbAqJl43/3z76uxSBfdA6pqPBsVtnNqowg+JJfc=;
        b=QN0cnNRJlEdtnlq56z8uS0V5xZBsFoQ3N1cZo/p3AwlDTLm+0Ia3mYHvKj1hKusykD
         yN5ORex2YP8ZfbJ54xm3L+J4cEbZOdUhAkAMhg0rIVZSfTN+ggvhD4N0nwjWUDuCoA4y
         ICYo7PjyGD9uscE6qTMEikel/MXHoOuZRQ566HGz/6tBqEbc7NNvoA809KvXeVRhf30W
         T0L0YVE5RO+4OoOlkrZ+qD9cKjDC+B4YHxyALhqj6tAHNqHMGWInV5dp6F8EyLO867pO
         HUcDYM2XrKCsou1TWDQqZsvGpOh32c1XxrFuh9DlPLTKYLPPCJz7JrhcpDPX6Fo+a+B7
         B7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693910185; x=1694514985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n//JsbAqJl43/3z76uxSBfdA6pqPBsVtnNqowg+JJfc=;
        b=c5r7DTqmw302Z0vOrYlCWWXkWTVhPWNqGJ4nQgq8EJP1J+WDlJhkfZU+609t14nykb
         KLxyGIWOnKLdX0WWdN/COqnbLwQ/TRCN/4dfaVWC+PFJiRfmZjdrACfYYc4objgucg3m
         9CinKnO+Ynm73SOYdBTbc0sPZZ1qAGTXPMqeOjuDlK+hgxd9Tnp0OocrWMzr73di0c0S
         GAUGyyFKpwz03O9T2KhUGoUkO3t2IGjhj4DG+Gkou84WUCuj8wOASSbhoO4SWzuKAE+K
         y6uA4pree5xJcVSAW1FO3N/m/QMXFS6pI+zsdZmG07rEzHRX5/7covSHjoQjkN1aWP8j
         eWNg==
X-Gm-Message-State: AOJu0Yxds+f8RLNNPvZOhoUynH1QOJMnExnmXgOByPdQtuiM75AtiZZL
        3PHL2hdwBYXqDaurBdsAHmCZnqmo+5XcfEcB3z7wbg==
X-Google-Smtp-Source: AGHT+IGk65q316yA74m9Njl60GqhKD5C+6Jk5pCTD3ZA10kctBccJ5mubYoybICOrFhMVMZNtx67xxH9l03lI4UlA2w=
X-Received: by 2002:a17:907:2c44:b0:9a1:bcac:8174 with SMTP id
 hf4-20020a1709072c4400b009a1bcac8174mr8805350ejc.37.1693910185521; Tue, 05
 Sep 2023 03:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230904182946.999390199@linuxfoundation.org>
In-Reply-To: <20230904182946.999390199@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Tue, 5 Sep 2023 19:36:14 +0900
Message-ID: <CAKL4bV6sKyfTe9G-fY464EFenGC97DaUrkNE36fR=GM5uNA1fg@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/31] 6.1.52-rc1 review
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

On Tue, Sep 5, 2023 at 3:35=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.52 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 06 Sep 2023 18:29:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.52-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.1.52-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
