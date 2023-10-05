Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9807BA6B8
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 18:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjJEQlK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 5 Oct 2023 12:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjJEQjz (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Oct 2023 12:39:55 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEF41BD6
        for <stable@vger.kernel.org>; Thu,  5 Oct 2023 09:36:11 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6c4b9e09521so765991a34.3
        for <stable@vger.kernel.org>; Thu, 05 Oct 2023 09:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1696523770; x=1697128570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vYHj3JFmAZKHkL+wnxS109TagHXpAewcZFhlnZKyAfc=;
        b=JJTVJJHW5p7Pu59TFtLDMU6/XqrU+Eq9Y6zB8uHLHqubOUDW8Xump9BxEul2aKdODk
         JRcGJJ7pHYvxMp0q8d5Mzmzt9xx+RgE3Ut5oxsHSFAWhw4Rs4pu/WNLJK8j66MdhqpZG
         PdGDOyPLDiOBigUjkQWWHsZ65BF7uBD4ZQvgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696523770; x=1697128570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYHj3JFmAZKHkL+wnxS109TagHXpAewcZFhlnZKyAfc=;
        b=RI5GXVKzODUTXF7y1aF20UpHc44kRWSdY46jHHAyCSjiyhsmDE1hxFDhZnWJ5xg7AC
         9kgNf1MHlY0SE78GYHI0oxNYEMBdWsrU6cwXBft3j+TF11IJCjxOGTrhVeF70Pko8zk6
         v78gqqk0WCrP3HDjcWMHwIG0/5VpRuRk7ehEwkM2Waq6bWkLLdxFEXcUeaz/k/iaWu3i
         VV0ZJwuMNcjzspDTHUBOnsofydNBwIA9WojY2OM6vVEr09JdQcMtdH4lQd7OwC5eAX9o
         JJiCGqeRDMyAwVcYqAjTuigqB3Ay2zW+FagAID6YJ5Idvv2oOcAks3WwOhOP0eCGtCcn
         hMqA==
X-Gm-Message-State: AOJu0YzLEOFXzSVnOfiYVc/UUEQHh10jXRqxuOBtSCfqrD0MeWgOqf5U
        +hK/I2SLzopg19jJVX0KAasMJQ==
X-Google-Smtp-Source: AGHT+IF1vZ6WboGp9C0l3uWZGG1N65oSqv2B+LlOIp2OMdFj2L2Gs4NqCVYwe07cua6EJsyW/v3WUg==
X-Received: by 2002:a05:6830:22e6:b0:6bc:fdc8:d600 with SMTP id t6-20020a05683022e600b006bcfdc8d600mr5849783otc.25.1696523770407;
        Thu, 05 Oct 2023 09:36:10 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id q23-20020a9d6657000000b006b9734b9fafsm304356otm.13.2023.10.05.09.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 09:36:09 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Thu, 5 Oct 2023 11:36:08 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.5 000/321] 6.5.6-rc1 review
Message-ID: <ZR7l+IbugqOLaQtV@fedora64.linuxtx.org>
References: <20231004175229.211487444@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Oct 04, 2023 at 07:52:25PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.6 release.
> There are 321 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
