Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5BD728644
	for <lists+stable@lfdr.de>; Thu,  8 Jun 2023 19:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbjFHRZe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 8 Jun 2023 13:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjFHRZd (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Jun 2023 13:25:33 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE6A1BDF
        for <stable@vger.kernel.org>; Thu,  8 Jun 2023 10:25:30 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-39a3f2668d5so644729b6e.1
        for <stable@vger.kernel.org>; Thu, 08 Jun 2023 10:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1686245130; x=1688837130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wKBFg60cWuUD0LVXfKP1NLor9h+suWJBlukHsIpPRjk=;
        b=iN4601uPzHQNLlzHwONjgwmNfEIBvmsDmgCm/86VWnFj8eqqG5HfcIJ/UGRBQRWvx4
         XFXWZawEJTYwWvbjnrscXdqQKlMR0XbL6Uo5I3vARcoICcNg+nToGmS0AIRbeFa9xIAA
         vLuLsWl46WOIo7q48TpF7VYlxLPixAtY8C3CU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686245130; x=1688837130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKBFg60cWuUD0LVXfKP1NLor9h+suWJBlukHsIpPRjk=;
        b=HvRDBYYnvGBQB7eWUr+abJIIhx8fZpN2LEqZhbU1Y7Dyr2sXmNXDSH5HFS4kmegQ0Z
         scyFwE27mBZBxxRIAvFAKPuCio0igcd1DuNI5GQPwaRWKhgnjNpmWJJM0bT6S2rM/r0t
         40CXHC3tTpogf69SUkb3qhXcrXJtaOlWPxUC/zEafBteZa9pW2TBawXtg/DA/hwntpOf
         rqhLonzm9EcQOTZay0ffy4wLxzt6WGgXXtBGAXk0TqK/OwQ8AxMZYqe8i4gtSoBGmKSc
         +mp/2Drs0fYJQKMJJM9WW3MKVhS5mpoU1NOsT1E5YI6U3ksmEwd3jXuMYi9McGcC/Hv1
         RFZg==
X-Gm-Message-State: AC+VfDx+6+IZtC3WBla/wp5mYqFa/FQSe9k8MQlIeUS0HgqRX1cEqyxW
        AEM6bAv773cVILvnfGf//nWuLg==
X-Google-Smtp-Source: ACHHUZ6oHplnoBJLkNML8qJBJBs2hZ6s/0SNRjXynHk9itwTvZD42Auwlu154ksXHwS5kgYjwfAPqQ==
X-Received: by 2002:a05:6808:98b:b0:398:2b78:5a53 with SMTP id a11-20020a056808098b00b003982b785a53mr5626118oic.40.1686245128739;
        Thu, 08 Jun 2023 10:25:28 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id j132-20020aca3c8a000000b0038c0a359e74sm626111oia.31.2023.06.08.10.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 10:25:28 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Thu, 8 Jun 2023 12:25:26 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.3 000/286] 6.3.7-rc1 review
Message-ID: <ZIIPBuKQzllrV7pC@fedora64.linuxtx.org>
References: <20230607200922.978677727@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jun 07, 2023 at 10:11:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.7 release.
> There are 286 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.7-rc1.gz
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
