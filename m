Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162D378F27B
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 20:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242621AbjHaSW4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 14:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241457AbjHaSWz (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 14:22:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321C7E5F
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 11:22:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB6CE6286B
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 18:22:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8708FC433C7;
        Thu, 31 Aug 2023 18:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693506169;
        bh=UsPVzhfl5atThqg7VRSQ1hLtUsNy9T14DE3Ae1I/ytU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AbGS00eUL0CIenMT+snjbejpLBTlSUI9vzCgv1BvBY/EO5OffcGKGT+s9br47qR/U
         gyMa0qyrwIS5nZyKpvM4pg7Y6k09vI48CmMmmKUvLNh5XA5glYxXByMbchZ0fdvk8q
         u/zl3Sd98AMlk0KDp1BpFh53OgIJn8r+OoMhKB6c=
Date:   Thu, 31 Aug 2023 20:22:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luiz Capitulino <luizcap@amazon.com>
Cc:     stable@vger.kernel.org, juri.lelli@redhat.com, longman@redhat.com,
        neelx@redhat.com, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, lcapitulino@gmail.com
Subject: Re: [PATH 6.1.y 0/5] Backport "sched cpuset: Bring back cpuset_mutex"
Message-ID: <2023083107-agent-overload-e3e7@gregkh>
References: <cover.1693505570.git.luizcap@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1693505570.git.luizcap@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Aug 31, 2023 at 06:13:01PM +0000, Luiz Capitulino wrote:
> Hi,
> 
> When using KVM on systems that require iTLB multihit mitigation enabled[1],
> we're observing very high latency (70ms+) in KVM_CREATE_VM ioctl() in 6.1
> kernel in comparison to older stable kernels such as 5.10. This is true even
> when using favordynmods mount option.
> 
> We debugged this down to the cpuset controller trying to acquire cpuset_rwsem
> in cpuset_can_attach(). This happens because KVM creates a worker thread which
> calls cgroup_attach_task_all() during KVM_CREATE_VM. I don't know if
> favordynmods is supposed to cover this case or not, but removing cpuset_rwsem
> certainly solves the issue.
> 
> For the backport I tried to pick as many dependent commits as required to avoid
> conflicts. I would highly appreciate review from cgroup people.
> 
> Tests performed:
>  * Measured latency in KVM_CREATE_VM ioctl(), it goes down to less than 1ms
>  * Ran the cgroup kselftest tests, got same results with or without this series
>     * However, some tests such as test_memcontrol and test_kmem are failing
>       in 6.1. This probably needs to be looked at
>     * To make test_cpuset_prs.sh work, I had to increase the timeout on line
>       592 to 1 second. With this change, the test runs and passes
>  * I run our downstream test suite against our downstream 6.1 kernel with this
>    series applied, it passed
> 
>  [1] For the case where the CPU is not vulnerable to iTLB multihit we can
>      simply disable the iTLB multihit mitigation in KVM which avoids this
>      whole situation. Disabling the mitigation is possible since upstream
>      commit 0b210faf337 which I plan to backport soon

Please try 6.1.50, I think you will find that this issue is resolved
there, right?

if not, please rebase your series on top of that, as obviously, it does
not still apply anymore.

thanks,

greg k-h
