Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A7A76CD64
	for <lists+stable@lfdr.de>; Wed,  2 Aug 2023 14:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbjHBMqu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 2 Aug 2023 08:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbjHBMqq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 Aug 2023 08:46:46 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A943835A5
        for <stable@vger.kernel.org>; Wed,  2 Aug 2023 05:46:26 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so1947080a12.1
        for <stable@vger.kernel.org>; Wed, 02 Aug 2023 05:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1690980384; x=1691585184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jPNTUnEQLa/vby68PUQOq0gidCidKmFF2Y70Baz8cg=;
        b=Y/sN+v9e/KjFR3mHRAQJs7ZXEWv/HN8IJxocaNZrmUrou/Vfoah2wKf7LegCZwT2e6
         5wcmbTbByU81XUuM+bGm3DLUe6HsWj4YiY1rhTJPHW+7dkHjJyE7LeaubYV2fm3eWcut
         FN6rwaB7QV3Bafw7RPfZyB1qH1FIIH+vekFB7KijWb9WPRuJHkAbfHvPBY07JLp1mbiK
         sXoQW1hR579ea5ZtccrHX91aR2LjH5sRuYwF6HowWtSSV3JIwIVNu+XkJ5iCd9s3vFDO
         KKlsLN/+0CFE9lfBeTPeAUjWvYP2MWXTKU/tj9H32/MtbRCNvh8SLVRZ8rrxhZWz1Je5
         b4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690980384; x=1691585184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jPNTUnEQLa/vby68PUQOq0gidCidKmFF2Y70Baz8cg=;
        b=LrSlVLWFRC17B0er7ld4yoTkTZ9tyQke0qHyVb7801M9XnoSSiLv19bIhCTt3h6UoU
         uGsWCqUTF+/ZiW8X2by4KQs941e8N+jCcRR2fr5U/5082TQBG6TJsQtyuIMnccP9P71M
         IXopRJeZl0UteJrQl0EhJRrT21jeUmu/bRRBwTvppasBXaLJIhTDJoR0nTdcriPdNVbe
         X+hP48isoilSwXu2eDl5UYd1UOvxCA577uKXfaLbsNSOj4Pd5uTpdW69HVktO/veSoWU
         wfPHcTsiApRgZ1e4X/i+Mwd+DFxBTPjLM1tGTsIYygTGwBO+6cqtnLcodcHkrF9RuP12
         fIrQ==
X-Gm-Message-State: ABy/qLZQgnAQbuFdOg0pj2/AclNsWp0eA8ejPg2a17S/xYnbwMYc+yhY
        gkXBYOSzqfgAVE1ZGybvMa7sN0gB2gTf5/KM1iRSnA==
X-Google-Smtp-Source: APBJJlG6MH+8DtLRZ0WDEr8YewPHyaBOyzfa56SZBQSo3KmJOimYMnNRDNJs1dvfRqY+rJfMJ4O6XPXbj5Ej1gME1UA=
X-Received: by 2002:a05:6402:518b:b0:522:ddeb:cdcb with SMTP id
 q11-20020a056402518b00b00522ddebcdcbmr5854329edd.18.1690980383950; Wed, 02
 Aug 2023 05:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230802065510.869511253@linuxfoundation.org>
In-Reply-To: <20230802065510.869511253@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Wed, 2 Aug 2023 21:46:13 +0900
Message-ID: <CAKL4bV6VSG8rsu2tM8A9Mrp=khz33YxTMkx53HZytk4Z9izJGQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/225] 6.1.43-rc2 review
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
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg

On Wed, Aug 2, 2023 at 4:44=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.43 release.
> There are 225 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 04 Aug 2023 06:54:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.43-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.1.43-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
