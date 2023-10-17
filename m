Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086477CC33D
	for <lists+stable@lfdr.de>; Tue, 17 Oct 2023 14:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbjJQMeb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 17 Oct 2023 08:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbjJQMeb (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Oct 2023 08:34:31 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D1A95
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 05:34:25 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a7ac4c3666so69012597b3.3
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 05:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1697546065; x=1698150865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gIl0fBWnXD5rRLm1M66vQJGMMeQ035Rboe3KXMky3Ps=;
        b=NioR7hmav8+Xgzj30vXqSVt76/g/TS1ph2tPHu6sBjRYgZJjYMauXxlQdsBIcyXhAf
         L8EXrcq91X5gS/sWbJhyRnu2VSPyNE5LcU6haoRXDKNM3pHfAzstf5g2LNBaaqivz65v
         3l6N9HDYfgSkOyWRoBw0PjzZqZPhl5Xbfk8PE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697546065; x=1698150865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIl0fBWnXD5rRLm1M66vQJGMMeQ035Rboe3KXMky3Ps=;
        b=px18BFoF+tp3IbE+RmptGuUo6BF50AqMuRCbWJ49fqP6vgF5dCrlE24yk7hbYRM2Ac
         Ic3UhHebtyMQ3GOcFWDkzWohhaVKh7aWGvAua40cdo/33GHI3QzGkLDL+r5sTFzg+vLC
         KirDxX27xoUXHD6JOvzF4FkG7eFC+eEU1wK0idwkgMp+Sfrrq3OgN6RSAKjxN05+bcYp
         1vZNw0239abyukyfh/gNpXjad53NmwPC65jUJt6lgcUfZn2VooU8UkGK+KNxrCGWBtIk
         RRpQ+nsBHt8SR4I9BldsfsRJsZDoya3RGlzR+YTaMM/2r5o4R2hzbv8VNdkPEVmCOxwU
         v4kg==
X-Gm-Message-State: AOJu0Yy/HS08alM9ej5iZpwXzAUQwPEhdomafx1iissP2Qvp5fSN3Lrf
        11t7H59N/W07qOtZQp2T4Cc8hw==
X-Google-Smtp-Source: AGHT+IEuJvyjNMSwYyn5xvBEcpAUsKV61Cs7TO3ZfWjOoko2MioWCtZU9FfFVgeRolHZ3Xwronhczw==
X-Received: by 2002:a05:690c:387:b0:59b:ec11:7734 with SMTP id bh7-20020a05690c038700b0059bec117734mr2107670ywb.39.1697546064911;
        Tue, 17 Oct 2023 05:34:24 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id d77-20020a814f50000000b005a7ba08b2acsm587509ywb.0.2023.10.17.05.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:34:24 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 17 Oct 2023 07:34:22 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.5 000/190] 6.5.8-rc2 review
Message-ID: <ZS5/TktEeU//QCuJ@fedora64.linuxtx.org>
References: <20231016185002.371937173@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016185002.371937173@linuxfoundation.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 16, 2023 at 09:48:57PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.8 release.
> There are 190 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 Oct 2023 18:48:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.8-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
