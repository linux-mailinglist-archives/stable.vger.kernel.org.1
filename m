Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB097378CF
	for <lists+stable@lfdr.de>; Wed, 21 Jun 2023 03:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjFUBn7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 20 Jun 2023 21:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjFUBn6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Jun 2023 21:43:58 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013BA1733
        for <stable@vger.kernel.org>; Tue, 20 Jun 2023 18:43:56 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-55b85b94bb0so2723590eaf.0
        for <stable@vger.kernel.org>; Tue, 20 Jun 2023 18:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1687311835; x=1689903835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SiQP1jHlYts9ei42Kje7uuybDGFkCPMKW6fLxqW0GiQ=;
        b=eyo2+1tt/wjSAvh/4eqexOZDURyX977loFHrLQnKsrHGxskNH7ih/3HVCpYB9ojeKI
         p/zcgnVaOXxZnb30n1yG2vWeKs5o7hm485rJnho6CjE79pZvj6udvWxW2cU1sbXQYJis
         9qarAptK2F8vgDD7vVq1ICwfuqvm0eDjs4lS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687311835; x=1689903835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiQP1jHlYts9ei42Kje7uuybDGFkCPMKW6fLxqW0GiQ=;
        b=hIx4geiIk0xEK7uIOQgJA2sGzRaJmIN4AWprN+xdYq12Nmfc9Bz/wqB/4n7Hr4GKKl
         9xmdoEHvTktbA5rh0P3EUjyu7j9l5OZfT+KSefNyxwJ6a1kThpgu1m1sqZ49v/jLmELX
         Hm6XlJR7t0NGpoiXGeqN7yAZUeJt4rFsM1rjWWQW7eIktnC5n0sjBQXA8aapFgcmAMbr
         Gfg65J6jrBhj9cFxDWZIRCHQh979evvvUbbpwuFWGEH5Xa1D/xrycpjcBwDsok7pwC5R
         XAwtf8F8FS2qmH/c1x183oFUDs+gP0y6JARA8ycIOIyW7rL7V10zq7riRy3XcwGj0ooj
         a9FQ==
X-Gm-Message-State: AC+VfDy+gtvSqGa5nqkSqa3t4Fi2RxAh4tQ3cifNQfroWqo9LF3uhrW+
        JX3/U+iv01NjDj+fBcthmIpX1Q==
X-Google-Smtp-Source: ACHHUZ72lHHABBGAJJ86M1jspfPWwX/74CyldiRGocbUhmTFZQaawSSzMyZO2vBmaiYBbJyJ5Vn1eQ==
X-Received: by 2002:a4a:e888:0:b0:55e:5c65:c6d6 with SMTP id g8-20020a4ae888000000b0055e5c65c6d6mr4697130ooe.6.1687311835171;
        Tue, 20 Jun 2023 18:43:55 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id i3-20020a4aa6c3000000b005607e78c3a9sm1511758oom.40.2023.06.20.18.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 18:43:54 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 20 Jun 2023 20:43:52 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.3 000/187] 6.3.9-rc1 review
Message-ID: <ZJJV2CUyz6E6Rftr@fedora64.linuxtx.org>
References: <20230619102157.579823843@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jun 19, 2023 at 12:26:58PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.9 release.
> There are 187 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.9-rc1.gz
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
