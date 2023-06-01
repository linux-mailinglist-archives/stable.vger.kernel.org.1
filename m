Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB98771A3C1
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 18:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbjFAQHB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 12:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbjFAQG6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 12:06:58 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4E2198
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 09:06:57 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f60804faf4so9950465e9.3
        for <stable@vger.kernel.org>; Thu, 01 Jun 2023 09:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1685635616; x=1688227616;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KUa8I6nDdRDhcEArlmA7XYSBs+6p9bIszRl9ZEdg7KA=;
        b=N13WqBANUpwVKH4KPCzj5a8Z2Hy9GB7tjTrptwhhPbRKiJwhAjuVPguhvekylrwoDL
         EiuORtKOk9PZttRvoWEjpsWMSCi0geng5P5OioAASBBJEyGM+uezjyQgf32VeP5Z7AlC
         Qq4C5WoWR3Ahzf1uFI/UgwbzTox4tdHsO2c3yXgXx1qNZB8EgXC61ElkzRm1+DHX2/Dn
         H5ICbZzqoWQxx4pnwliM8lm1uZwGhfhGPOmsZXK3Hp5AW7n27xyyZNho1i4W7e+fYq2C
         Sfgy/RY1A8NEK8DFwdNirI3QFMP5ANA/VkM2UjdzfAVMWmsx8tgZGEkzW15Yz2UM6nhe
         /cRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685635616; x=1688227616;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUa8I6nDdRDhcEArlmA7XYSBs+6p9bIszRl9ZEdg7KA=;
        b=NSTFHo87YmSgIGpz2nMpLUw8nbXUwXK70x6zyccENPmrylb7jM4xdiU5ycu3ALOBpl
         4EOCenFDv7Bf+69FBnmE/99omxOOvjUGnY41gswZ1iI1Qtv60I0Mn3DioIrAuAezTks5
         NjdVE9gDhJLpA3DKGhMeQP11tVZiW+ELnSXYQH5XFDdUc74RD1sOhEz75NezlYUhGf0K
         1sGXLQj/BVEuRU2LrTIJEPNZd9uZBsxyyJTMWuS416of+yJ7R8E0VDYFgIuUIEK0nmvW
         UISgjSTjg3/t3+j8aprL4ARmZhpVpUSaYZGZC1tulB9lpczqiHNlg1EgFgjxqqgEeDZ3
         1X4A==
X-Gm-Message-State: AC+VfDzsMO8/VVcLxeeFHcRIB0Nk1QLWyaBvckz7lZi3Bh44g8Pl7nN/
        4411nSTD6RcDkCeJGJtXeUdg9B8t2M6MOLht3UQ=
X-Google-Smtp-Source: ACHHUZ7kLX1VS3odHanGMGZpl53RqiqNh+2hM63kNcga/gk2u9xC1R1bzo/awhc0ZpPfR4u/zqICkQ==
X-Received: by 2002:a7b:c44c:0:b0:3f6:d2f:27f7 with SMTP id l12-20020a7bc44c000000b003f60d2f27f7mr2407828wmi.17.1685635615809;
        Thu, 01 Jun 2023 09:06:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:a1c1:aac9:326c:88d7? ([2a01:e0a:b41:c160:a1c1:aac9:326c:88d7])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003f42d8dd7ffsm2830670wmc.19.2023.06.01.09.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 09:06:55 -0700 (PDT)
Message-ID: <8b45bb59-76ee-95c1-6ec6-fc6b2ca52908@6wind.com>
Date:   Thu, 1 Jun 2023 18:06:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH 6.1.y] ipv{4,6}/raw: fix output xfrm lookup wrt protocol
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
References: <2023052622-such-rearview-04a6@gregkh>
 <20230530163312.2550994-1-nicolas.dichtel@6wind.com>
 <2023060146-rewrap-vigorous-807a@gregkh>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <2023060146-rewrap-vigorous-807a@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Le 01/06/2023 à 11:30, Greg KH a écrit :
[snip]
>> This patch can be applied on 5.15, 5.10, 5.4 and 4.19 stable trees also.
> 
> Now queued up there, but not to 6.1.y as Sasha took the prereq commit
> instead and the original.
Thanks for the explanation, I didn't understand how Sasha applied it :)


Regards,
Nicolas
