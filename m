Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AC57905C1
	for <lists+stable@lfdr.de>; Sat,  2 Sep 2023 09:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351732AbjIBH2H (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 2 Sep 2023 03:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351721AbjIBH2G (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 2 Sep 2023 03:28:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE771709
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 00:27:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5091B8275C
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 07:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393DFC433C7;
        Sat,  2 Sep 2023 07:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693639673;
        bh=nMMYL+i7WdDVENXSyAHAGZh2mlfpJ8nGwZ9EhdQEjZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gwiMogFDAIv8ck5EtlDn/JaBsLGxFhtWY9sXdJns8R9ZQ8+P9mPLH5g4l0jMhcjv7
         dC+s5oE3TFp9DY3ExvxYZSHPYo+OpOX9RUl7CdCKLlEFoH7mk3D5PK/cEFtOsYoUcP
         Z6OSPq5w4Nv1LuY9zEI9ZWZaK/uuooW0l5j0C8zU=
Date:   Sat, 2 Sep 2023 09:27:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luiz Capitulino <luizcap@amazon.com>
Cc:     stable@vger.kernel.org, seanjc@google.com,
        christophe.jaillet@wanadoo.fr, lcapitulino@gmail.com
Subject: Re: [PATH 6.1.y 0/2] Backport KVM's nx_huge_pages=never module
 parameter
Message-ID: <2023090211-tainted-gonad-f78f@gregkh>
References: <cover.1693593288.git.luizcap@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1693593288.git.luizcap@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Sep 01, 2023 at 06:34:51PM +0000, Luiz Capitulino wrote:
> Hi,
> 
> As part of the mitigation for the iTLB multihit vulnerability, KVM creates
> a worker thread in KVM_CREATE_VM ioctl(). This thread calls
> cgroup_attach_task_all() which takes cgroup_threadgroup_rwsem for writing
> which may incur 100ms+ latency since upstream commit
> 6a010a49b63ac8465851a79185d8deff966f8e1a.
> 
> However, if the CPU is not vulnerable to iTLB multihit one could just
> disable the mitigation (and the worker thread creation) with the
> newly added KVM module parameter nx_huge_pages=never. This avoids the issue
> altogether.
> 
> While there's an alternative solution for this issue already supported
> in 6.1-stable (ie. cgroup's favordynmods), disabling the mitigation in
> KVM is probably preferable if the workload is not impacted by dynamic
> cgroup operations since one doesn't need to decide between the trade-off
> in using favordynmods, the thread creation code path is avoided at
> KVM_CREATE_VM and you avoid creating a thread which does nothing.
> 
> Tests performed:
> 
> * Measured KVM_CREATE_VM latency and confirmed it goes down to less than 1ms
> * We've been performing latency measurements internally w/ this parameter
>   for some weeks now

What about the 6.4.y kernel for these changes?  Anyone moving from 6.1
to 6.4 will have a regression, right?

Or you can wait a week or so for 6.4.y to go end-of-life, your choice :)

thanks,

greg k-h
