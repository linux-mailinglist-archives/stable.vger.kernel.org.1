Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81B86FFD65
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 01:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238053AbjEKXiK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 11 May 2023 19:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239465AbjEKXiJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 11 May 2023 19:38:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA015170D
        for <stable@vger.kernel.org>; Thu, 11 May 2023 16:38:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 872DE65291
        for <stable@vger.kernel.org>; Thu, 11 May 2023 23:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE015C433D2;
        Thu, 11 May 2023 23:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683848287;
        bh=ChDXdSwpdLo8x277mIT+lr5GQ5FKLUXSifAXrBAX0Ow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lJPznTtCjrsmLZigd1IZUz8QC/iVwtPjAlc5l4PbaOvhAJmFtMjr5z3Eu1qsNp5Qi
         iGPKXqqpcUDWaSKhg6EMRfw9CjmcD4xZRETArrJmTUW4YSgv81Mvzeu00JOkTgKULI
         szbjs/dpeVM+UD1M9etfy1VttnZbWpPOYKdmjXrrNyJ/ctkNlEnmQm8WFwkY3s/fiG
         1jcNPLOqP5YsBE8eQ9HoDc9NWPP1a8hmLcKK0BFzs2uWEC7GiUcB/9hzMPlj4cjhbi
         /MbjabqbtduCen9LU5AOdE3kMiCxhlZF0W03GSqelh5AGOO3uFxppyZ8wxhoNoGnBe
         QylxHIt4uzbTw==
Date:   Thu, 11 May 2023 19:38:07 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Jared Epp <jaredepp@pm.me>
Subject: Re: Please apply commit 6470accc7ba9 ("KVM: x86: hyper-v: Avoid
 calling kvm_make_vcpus_request_mask() with vcpu_mask==NULL") to v5.10.y
Message-ID: <ZF18X3e6rrkACcMf@sashalap>
References: <ZFuUstsT9plyGcTp@lorien.valinor.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZFuUstsT9plyGcTp@lorien.valinor.li>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, May 10, 2023 at 02:57:22PM +0200, Salvatore Bonaccorso wrote:
>Hi
>
>After we updated the kernel in Debian bullseye from 5.10.162 to
>5.10.178, we got a report from Jared Epp in
>https://bugs.debian.org/1035779 that a Windows Guest VM no longer
>booted, and Kernel reporting:

This KVM commit wasn't tagged for stable, and would need an ack from the
KVM maintainers to apply.

-- 
Thanks,
Sasha
