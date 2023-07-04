Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3F2746FE7
	for <lists+stable@lfdr.de>; Tue,  4 Jul 2023 13:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjGDL17 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 4 Jul 2023 07:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjGDL16 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 4 Jul 2023 07:27:58 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C333D9D
        for <stable@vger.kernel.org>; Tue,  4 Jul 2023 04:27:56 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51cb40f13f6so6911343a12.2
        for <stable@vger.kernel.org>; Tue, 04 Jul 2023 04:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1688470075; x=1691062075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEHN8kv/zUiWgy4LCdHK93+q2EPHQUuAQ4UHUBp2+7o=;
        b=TMKyon/RMqj8v3axB/OMKH7FLtiDFJ9dKfeRHovlqyfJE5uDkbvTNEg8qdIT3Blp/y
         rcKityLrQhpDrrLqRsd30fWApdFILzX+KuXWhzvQID3oN84HJfrmkt7os7WgoLxii2Xm
         eaUJ5HCnwOODeVMWFTxV6H62t3UwAAProjDxgam7RL7jccDLRU+1vwoNq80xLiSgkhL/
         /K/IpxfgLWm8SaXpx1JmhV2EfmKj95/0Kxe3doqE7iE8F0JPiCJAzEtcSLStQE7uWxDM
         a8KK7/R5rsfN+cIHTmEvRgU/OyVuMUcY9akXi8EOJw6oCTWPJwhc2GQecvqLA/sVPQ+/
         ItiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688470075; x=1691062075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEHN8kv/zUiWgy4LCdHK93+q2EPHQUuAQ4UHUBp2+7o=;
        b=g9dP9F/o2vlrb6Rrg+tj0u+61pnBzolQWYeGcGTKsZpz1rKQsGT+2wycYqKBf90EZq
         52JFW2DB9XhE4ovsGvL4FoXVUsqkKedAMyyrjzW7Sy1D6b4W3KpigNrGjTscAZgnD0BA
         wrhpiu8l15Vfxx7XQcEp9yxGQMaUvyU+k3o3tbt3o+dw1IX2YcTKGTpysmAYZJwaU3SY
         IWXcQniUeMpu4eRD7Mx6z+Qfaasfl/Sj2yHtXf5aqU5D3zbYUSofY04LGCUnNPaeOUn2
         4rGIHphKLfqHuxZ0u2PofpzEBr9RrAxw+o3V/ggpRRFHQLj6daEUxK/T9Bpeoy6mtNQx
         DqXQ==
X-Gm-Message-State: ABy/qLZCJ+/CRbv2N7nFhjhR7+cKW5FKJfnCIgszkUIInVR+nMPKjaLc
        fZ3Pm5FIDZcRotr71v7cIbq9lrIJS8eDblsxJfVUNQ==
X-Google-Smtp-Source: APBJJlHGu4FFmWCFmb+vUNh9gFQsSwpK9KXjYVAgV/FEhd+i6bDEYar8yytbjOvvBmWmwyyYiDsyRN8kw99pc17rxrs=
X-Received: by 2002:a05:6402:2ca:b0:51d:955f:9e17 with SMTP id
 b10-20020a05640202ca00b0051d955f9e17mr9928219edx.16.1688470075098; Tue, 04
 Jul 2023 04:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230704084611.071971014@linuxfoundation.org>
In-Reply-To: <20230704084611.071971014@linuxfoundation.org>
From:   ogasawara takeshi <takeshi.ogasawara@futuring-girl.com>
Date:   Tue, 4 Jul 2023 20:27:44 +0900
Message-ID: <CAKL4bV4H62QdBJ7G6=QpPRqaG+OkYJ=F9HReS+oyGzKpUCDTNw@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/13] 6.1.38-rc2 review
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

On Tue, Jul 4, 2023 at 5:49=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.38 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 06 Jul 2023 08:46:01 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.38-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.1.38-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64), arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
