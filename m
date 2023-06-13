Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE2272EAF4
	for <lists+stable@lfdr.de>; Tue, 13 Jun 2023 20:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjFMS1m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 13 Jun 2023 14:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjFMS1l (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Jun 2023 14:27:41 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E100E1730
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 11:27:24 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1a67ff9d727so1799160fac.1
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 11:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1686680844; x=1689272844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OD/sBnMhOS+76TBbX745v9EyDJOqWBR1zdKjyXB6hEo=;
        b=TNvKEBQDz0UXjGY82Rdzzk7mJQiwrkyJVwvuxu8n8m0Pi2aswclN30CIh/rhXgR9EL
         GcUphBoC3mHb5JyYtboioVzFLX76O5uxbzvCqp58ta7SwnjUsDKVDt9AWw9Y9o3re5Ow
         1Btu5L4SF8IUndx5WaD12X8bmEvsxLbVgaYM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686680844; x=1689272844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OD/sBnMhOS+76TBbX745v9EyDJOqWBR1zdKjyXB6hEo=;
        b=jB8Fm9TScconoI5NaI+OG/1fH3u0Uiq7RuRDlBjgrhCCt9pbd9v80Cp7u9SedhRtYe
         ZSzEKdo0xAk3cwlKn0o54CCFmQSr0qD9Rcp6SFuFLwEQEx57RWLt1436cIJFWtRc5jjW
         hW/Jeegr2RQWbvylmaKhLPFkZrfoFYbUNxeEK7d4TWCybKa4n02m2j58PvhEbKqJ/ksy
         Kqe3FWgArrNDKxM2nGpPxfP4OWZqRhgSMdo1ZMSJWA7pAs7bDOcLBb8ulq7lL3Gg2b7Z
         Zs1N9jgdfJ1JjX89iW+r8Pn3rS8mJFwJMchFAraZplNgrQZ3zHu2wq32qhQtK6UzfKAj
         8JaQ==
X-Gm-Message-State: AC+VfDyfXP29bWBNudw5xjALkqfk0lsE/Nb7YB3GbdDe69p/Zvgmr9GZ
        C7IY6bw+WSFPiKpbGJFt111OBw==
X-Google-Smtp-Source: ACHHUZ7ahhE3kP1FUW/F7G37fNcHq4Fz7WbfGH3XVBVth497lPJQKvXVRBAUtifGjYjKR0kmMJqoLg==
X-Received: by 2002:a05:6871:69f:b0:1a6:b5e5:29c6 with SMTP id l31-20020a056871069f00b001a6b5e529c6mr1822097oao.2.1686680843802;
        Tue, 13 Jun 2023 11:27:23 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id k19-20020a05687015d300b001a66a48a68asm4236294oad.57.2023.06.13.11.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 11:27:23 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 13 Jun 2023 13:27:20 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.3 000/160] 6.3.8-rc1 review
Message-ID: <ZIi1CKTsIJo+wLaE@fedora64.linuxtx.org>
References: <20230612101715.129581706@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jun 12, 2023 at 12:25:32PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.8 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
