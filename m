Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6706FFD78
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 01:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239412AbjEKXrH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 11 May 2023 19:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238915AbjEKXrG (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 11 May 2023 19:47:06 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6031AC
        for <stable@vger.kernel.org>; Thu, 11 May 2023 16:47:05 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-24e4acd6b61so8735847a91.0
        for <stable@vger.kernel.org>; Thu, 11 May 2023 16:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683848825; x=1686440825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hDjdKrWUHGsVMJ2gMSx8epGixnLnx2dMDqo9vhiuXBs=;
        b=qhfsMa2jOiqkhf4RshIh3PEfjniiGYeJZDmwYo7xFuYeX8NBFb1lf+uO9tQ3WplQ/w
         cVkjbQau+GmcYpI3dJK+rjicYLHgj4wcOYfmY2DaMSUmr2qIah8WfJPUbXthoV2intEC
         xGDaGhz5sn9ApDEPBi0VVUyUlPNu1yUUYmKltJsQaKTSjSDE8uA6CYgaE8Bsdp8wRluO
         gug0ajehSHtekpAf9Z4bCcN4fewRrzhUJx50iTC25W4vdQxI8EszvPH/Ak4r01BwXhHn
         ax1kUgt+eqXoB7JOVaKfY8Sv6/EejSNC7saZhILGktquZbb5XvHdBDDV0s+xAXwpPMVD
         YKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683848825; x=1686440825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hDjdKrWUHGsVMJ2gMSx8epGixnLnx2dMDqo9vhiuXBs=;
        b=YwezTPT2BEJDevXacp/7UCx7JDyLeG3ewb1IvfoJu+y6jK3wmaQ+JGTQyYevDjnTFv
         b7bhZNE95mjRhQhvmwg07GzQWGav/3jb4zyqzeKznvoEXCi0BkV7zmJ8HifkCy6gpAlV
         vm5zesvesgNxI1iQAZWCGNKo4zjw42xpLFsNLrUM6hkVxWQPqWShYZAMceZwsXqh2NsU
         dhnU1nvhKYhoHUOmAgTiQ8EjnB4paBE3unEn1pLIgmlWOr12v6w9Mp4QIti8XQskMQlC
         KEqsy8u+x1C4toLRkFboqoXr6ybmF+9ka26ivxsSL174a6oTqiDJ+I7wTenGZ79+Rqym
         fAtw==
X-Gm-Message-State: AC+VfDyXUQ1JhvcBEqKXB5Tyd3CnvvagpiOBs1TVXylZXpx36GuzSBFp
        03GZYaakx2r76/CifZVPicf1uQkB64A=
X-Google-Smtp-Source: ACHHUZ7Mjlxci3PIOr9utUnGxTlbJJRsGOa3EtjmfyiADDuMluEgDU+fA16XjSxvBGqRMOfxImArZV1V5GY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:c7d0:b0:24d:df95:fdc5 with SMTP id
 gf16-20020a17090ac7d000b0024ddf95fdc5mr6945096pjb.2.1683848825348; Thu, 11
 May 2023 16:47:05 -0700 (PDT)
Date:   Thu, 11 May 2023 16:47:03 -0700
In-Reply-To: <ZF18X3e6rrkACcMf@sashalap>
Mime-Version: 1.0
References: <ZFuUstsT9plyGcTp@lorien.valinor.li> <ZF18X3e6rrkACcMf@sashalap>
Message-ID: <ZF1+d2XYcQ9xvUw1@google.com>
Subject: Re: Please apply commit 6470accc7ba9 ("KVM: x86: hyper-v: Avoid
 calling kvm_make_vcpus_request_mask() with vcpu_mask==NULL") to v5.10.y
From:   Sean Christopherson <seanjc@google.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Salvatore Bonaccorso <carnil@debian.org>,
        stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Jared Epp <jaredepp@pm.me>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, May 11, 2023, Sasha Levin wrote:
> On Wed, May 10, 2023 at 02:57:22PM +0200, Salvatore Bonaccorso wrote:
> > Hi
> > 
> > After we updated the kernel in Debian bullseye from 5.10.162 to
> > 5.10.178, we got a report from Jared Epp in
> > https://bugs.debian.org/1035779 that a Windows Guest VM no longer
> > booted, and Kernel reporting:
> 
> This KVM commit wasn't tagged for stable, and would need an ack from the
> KVM maintainers to apply.

For grabbing commit 6470accc7ba9,

  Acked-by: Sean Christopherson <seanjc@google.com>

If it helps,

  Fixes: 6100066358ee ("KVM: Optimize kvm_make_vcpus_request_mask() a bit")

That optimization got pulled in without the undocumented dependency due to:

  Stable-dep-of: 2b0128127373 ("KVM: Register /dev/kvm as the _very_ last thing during initialization")
