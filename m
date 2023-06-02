Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00FA7207F9
	for <lists+stable@lfdr.de>; Fri,  2 Jun 2023 18:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbjFBQ4y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 2 Jun 2023 12:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjFBQ4x (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Jun 2023 12:56:53 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6F5C0
        for <stable@vger.kernel.org>; Fri,  2 Jun 2023 09:56:50 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6af6ec6d73bso1310185a34.3
        for <stable@vger.kernel.org>; Fri, 02 Jun 2023 09:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1685725009; x=1688317009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UpFkoBOgIhm6mVYnAm3/uE52vs/uGNgQbLUnzZ8e50A=;
        b=OYTGcuM33CecRMp0bGXgKRvNrSjIqKgpvkYDOSRdh6fe8CHOCEdAr1Frby7/3YtOWq
         seQc9WxsFfEXsBsVEPABs2F5x4iUvW4Fju58l4vzqWHstTxWJun+rg22pagiK7Z6HpEA
         W/72rYdED9jIxY/+FA+YrIo2TEfPcD2bQNRT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685725009; x=1688317009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpFkoBOgIhm6mVYnAm3/uE52vs/uGNgQbLUnzZ8e50A=;
        b=j2674xzqQgo6tdqY+AKhds8YeHtOy5XPnNSej9z3hkAugVopyMyDmbET2Fb7ZcvdRh
         e/Tat2bqWOyEdmVDzGxaLWBnxnlcszyCwNJpv7NnsWYU3IlqI99RveOb4L4pKRCLJNYh
         /07CdMRsZZIhhSja2uKPcriMXgYI2TA7kDDhbk0Te6qP8Tf51EMXWzPO+/FvIEL3vaQF
         BCUmalvgNBtFuH1kTOXQn7oLguOVjcapYPQEm4PZJUinqh9s2S+i+nokgfn9cO7s/MmH
         j/y1+d+WzAOZ2K2rVsX1OnFjc3NFf189qhRvNM36jI8s+YJjKqW8og/vZYqZS7KAFE6w
         +bGw==
X-Gm-Message-State: AC+VfDzg7eQh3f9jG9rfBVJ4kyi9amyYPMg4+sS3Ks6lil34FIlI5iq6
        a3oF9CjLPw4C9TlKZy+7ieVXQQ==
X-Google-Smtp-Source: ACHHUZ7/PTjo9k0bGsi3dIeEZREUXDAf8wSbxwJM45eAIKUPenOyP0DS66nNoBJMRzqoRnm6VX+zDg==
X-Received: by 2002:a05:6830:1042:b0:6af:7493:79be with SMTP id b2-20020a056830104200b006af749379bemr1930925otp.10.1685725009629;
        Fri, 02 Jun 2023 09:56:49 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id l2-20020a0568301d6200b006ab305429e7sm807579oti.0.2023.06.02.09.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 09:56:49 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Fri, 2 Jun 2023 11:56:47 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.3 00/45] 6.3.6-rc1 review
Message-ID: <ZHofTwvKfnZmRhww@fedora64.linuxtx.org>
References: <20230601131938.702671708@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601131938.702671708@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 01, 2023 at 02:20:56PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.6 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 03 Jun 2023 13:19:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.6-rc1.gz
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
