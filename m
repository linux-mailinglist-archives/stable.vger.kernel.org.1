Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0F27015C1
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 11:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbjEMJcM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 05:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238193AbjEMJcJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 05:32:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410141BF8
        for <stable@vger.kernel.org>; Sat, 13 May 2023 02:31:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C28F261D43
        for <stable@vger.kernel.org>; Sat, 13 May 2023 09:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A4FC4339B;
        Sat, 13 May 2023 09:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683970317;
        bh=7tT1fhkFZZGbWasfIS3tzwDuOwvyCh4hWYUrD1uWxeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vljRjDNtSM7jWUm5EZTCLpEEKUVu4qXRJ1Y2wUsGzey7u4pZm58m8oq/LCkXl1DAC
         8loNr2tkNKbKEJI3S/hMykfk4RdBRC63UpjdPJxr1+MNbdd1MtGw3k2rXwrI0TiHKp
         fmDSv88lOz9LK3y1nu1dF1i5EZXWUU+ULlLJsM3g=
Date:   Sat, 13 May 2023 18:28:57 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        stable <stable@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Jared Epp <jaredepp@pm.me>
Subject: Re: Please apply commit 6470accc7ba9 ("KVM: x86: hyper-v: Avoid
 calling kvm_make_vcpus_request_mask() with vcpu_mask==NULL") to v5.10.y
Message-ID: <2023051349-waltz-designer-6a7e@gregkh>
References: <ZFuUstsT9plyGcTp@lorien.valinor.li>
 <ZF18X3e6rrkACcMf@sashalap>
 <ZF1+d2XYcQ9xvUw1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZF1+d2XYcQ9xvUw1@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, May 11, 2023 at 04:47:03PM -0700, Sean Christopherson wrote:
> On Thu, May 11, 2023, Sasha Levin wrote:
> > On Wed, May 10, 2023 at 02:57:22PM +0200, Salvatore Bonaccorso wrote:
> > > Hi
> > > 
> > > After we updated the kernel in Debian bullseye from 5.10.162 to
> > > 5.10.178, we got a report from Jared Epp in
> > > https://bugs.debian.org/1035779 that a Windows Guest VM no longer
> > > booted, and Kernel reporting:
> > 
> > This KVM commit wasn't tagged for stable, and would need an ack from the
> > KVM maintainers to apply.
> 
> For grabbing commit 6470accc7ba9,
> 
>   Acked-by: Sean Christopherson <seanjc@google.com>
> 
> If it helps,
> 
>   Fixes: 6100066358ee ("KVM: Optimize kvm_make_vcpus_request_mask() a bit")
> 
> That optimization got pulled in without the undocumented dependency due to:
> 
>   Stable-dep-of: 2b0128127373 ("KVM: Register /dev/kvm as the _very_ last thing during initialization")

Thanks, now queued up.

greg k-h
