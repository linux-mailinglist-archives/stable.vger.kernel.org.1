Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32CD7932CA
	for <lists+stable@lfdr.de>; Wed,  6 Sep 2023 02:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236879AbjIFADs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 5 Sep 2023 20:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjIFADr (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 5 Sep 2023 20:03:47 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADC31AB
        for <stable@vger.kernel.org>; Tue,  5 Sep 2023 17:03:44 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1bf525c269cso30900995ad.1
        for <stable@vger.kernel.org>; Tue, 05 Sep 2023 17:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693958624; x=1694563424; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FGAB1MO2HHzJgJgBozr6g7Uu4eIWXaKZdm2RFBtZLPU=;
        b=znZOxeuKuWnjm8XB2F6XRB8jn7l7QfyUepzLuFHxv9+NV5+ozIpRvcrr5sssWJYGxz
         ZeNofVLnKr8gixWPtat8mQNmA0vKkdaMAGrMUlctvOhfTLrszESuce6If2JwT9Ktp28V
         2qGsrszP5dYPccmev/XqvoC76rUAYK/zCnbh7MAcOvbwm1uU27uydqXncJZxz/yXd2X5
         yOol5JDFoRBjm4nh67WBocZ078Kgfuo7KicZLiqQV8w11e0uXMY6CiWpcL+WvL/p4+Db
         WecsNBBv7EeaUUmS3FXDPq5D6ZqapZusxVWYTewcvBOChQJWEmLdsDnGPIJyu6k89+h/
         SbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693958624; x=1694563424;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FGAB1MO2HHzJgJgBozr6g7Uu4eIWXaKZdm2RFBtZLPU=;
        b=ha3WhYdsDMEcCO2ae5ACLweBQU6fC5Fl8v2dFYdhWrCCnwoYeaF2NSfsxAi1pGop+S
         LhLFhIRw6f+3ytdOousheura3P0C/nYF4SWy8hZEmmqi8XTH0q078Wbtvalh/vjPzift
         ExjqhqGowTqqi29Qe+kgJV6jVv9RoeGzjY4ziD1rsZbOrXA6TBQ9GpZ30jYUTbE8NAUO
         6JhdyPnE3YjUdAcdVkDQ5bxqosNjDaaK9K7FkiCPM9uJBfGjLTFqEklrQe+1kNQUUbwe
         oQfI+S1m85Bn02G4Ns3pJyj2E1UM0CWg8vFDFlYTGiVgTnqMbiqdEQOnbx5l9zaZM27Y
         VcrA==
X-Gm-Message-State: AOJu0YxgbZr13wYXe6+a9/SZouBLi3kYk3kwvs42unmFWsPjNpDqCCUx
        IjmG5lhCrTey/OEhGdlrJ/hN0BthWWY=
X-Google-Smtp-Source: AGHT+IFxPM6iyCiExg8LHg80qP5o6h3X7HEzlad7OgyXqlM4MTnPU+zyFvwv7tnpDtfnI3tpv+Pal7RkZ+I=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:b490:b0:1c1:fc5c:b32e with SMTP id
 y16-20020a170902b49000b001c1fc5cb32emr4264049plr.10.1693958623334; Tue, 05
 Sep 2023 17:03:43 -0700 (PDT)
Date:   Tue, 5 Sep 2023 17:03:41 -0700
In-Reply-To: <20230905145412.12011-1-luizcap@amazon.com>
Mime-Version: 1.0
References: <20230905145412.12011-1-luizcap@amazon.com>
Message-ID: <ZPfB3XGhP13xC9Ba@google.com>
Subject: Re: [PATH 6.4.y] KVM: x86/mmu: Add "never" option to allow sticky
 disabling of nx_huge_pages
From:   Sean Christopherson <seanjc@google.com>
To:     Luiz Capitulino <luizcap@amazon.com>
Cc:     stable@vger.kernel.org, lcapitulino@gmail.com,
        Li RongQing <lirongqing@baidu.com>,
        Yong He <zhuangel570@gmail.com>,
        Robert Hoo <robert.hoo.linux@gmail.com>,
        Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Sep 05, 2023, Luiz Capitulino wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Commit 0b210faf337314e4bc88e796218bc70c72a51209 upstream.
> 
> Add a "never" option to the nx_huge_pages module param to allow userspace
> to do a one-way hard disabling of the mitigation, and don't create the
> per-VM recovery threads when the mitigation is hard disabled.  Letting
> userspace pinky swear that userspace doesn't want to enable NX mitigation
> (without reloading KVM) allows certain use cases to avoid the latency
> problems associated with spawning a kthread for each VM.
> 
> E.g. in FaaS use cases, the guest kernel is trusted and the host may
> create 100+ VMs per logical CPU, which can result in 100ms+ latencies when
> a burst of VMs is created.
> 
> Reported-by: Li RongQing <lirongqing@baidu.com>
> Closes: https://lore.kernel.org/all/1679555884-32544-1-git-send-email-lirongqing@baidu.com
> Cc: Yong He <zhuangel570@gmail.com>
> Cc: Robert Hoo <robert.hoo.linux@gmail.com>
> Cc: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Robert Hoo <robert.hoo.linux@gmail.com>
> Acked-by: Kai Huang <kai.huang@intel.com>
> Tested-by: Luiz Capitulino <luizcap@amazon.com>
> Reviewed-by: Li RongQing <lirongqing@baidu.com>
> Link: https://lore.kernel.org/r/20230602005859.784190-1-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Luiz Capitulino <luizcap@amazon.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 41 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 36 insertions(+), 5 deletions(-)
> 
> I submitted this backport for 6.1.y[1] but we agreed that having it for 6.4.y
> is desirable to allow upgrade path.

Heh, I would have personally just let 6.4 suffer, but since you went through the
effort:

Acked-by: Sean Christopherson <seanjc@google.com>
