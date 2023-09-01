Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697C478F7E8
	for <lists+stable@lfdr.de>; Fri,  1 Sep 2023 07:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345281AbjIAFOC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 1 Sep 2023 01:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348243AbjIAFN4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 1 Sep 2023 01:13:56 -0400
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C678310C4
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 22:13:50 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-500913779f5so2945379e87.2
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 22:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693545229; x=1694150029;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:reply-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=af/4U1Rpctq0xn22z8gnl3fN8uEEmTY03VxkSbZqf7w=;
        b=kf67HKBPIvtTYOmZYUJ3hJCveUUwrF1f2YNWvKMTb/2lYQ9YhW9zi6cYiZXaWzOlXn
         CEReiB4IsKJQFUNlAbiVG21EL0URZpsvqrQ7Dlslr6x5Czwrn04CEC0eN44ZFG6YcUPP
         EtZXLdjPg+c9yAlNgyE9X/1lw+fU4vc5ZlKGBywnK1AJrYCc5U5KDfGRqbkjE0q8OVbp
         l4E3ZIgvee74vPDPqhkkI5Q0/L71GS/DyqIqDuFTaALcXFRxoJ1QmkhVOp4i9WF4kMui
         OQ/CXeOAGWJmFSjZrGsWR7CKOip9yaQEkod/W2bbHQ1grMQfM7I/fXfD7jgptC3W2YFi
         QwKw==
X-Gm-Message-State: AOJu0Yy/CfCYGdnBqU4b66NHOU1iDcqX5FtodQj+PG3eYv+ePaMkJlx9
        90ZnArPBVObnHEJy450IeR5rYg==
X-Google-Smtp-Source: AGHT+IH6lMHGk3UIs0Aikzj/5UPchwNn22edRT/IVO/IuY1Z60LnUxSEWtAJ+o7L1HOvG/YdosozOA==
X-Received: by 2002:a05:6512:2302:b0:4f9:cd02:4aec with SMTP id o2-20020a056512230200b004f9cd024aecmr1069353lfu.29.1693545228858;
        Thu, 31 Aug 2023 22:13:48 -0700 (PDT)
Received: from fedora.fritz.box (p549458cf.dip0.t-ipconnect.de. [84.148.88.207])
        by smtp.gmail.com with ESMTPSA id lh7-20020a170906f8c700b0098e34446464sm1549982ejb.25.2023.08.31.22.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 22:13:47 -0700 (PDT)
Date:   Fri, 1 Sep 2023 07:13:45 +0200
From:   Damian Tometzki <dtometzki@fedoraproject.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Jeff Xu <jeffxu@google.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        stable@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/5] memfd: improve userspace warnings for missing
 exec-related flags
Message-ID: <ZPFzCSIgZ4QuHsSC@fedora.fritz.box>
Reply-To: Damian Tometzki <dtometzki@fedoraproject.org>
Mail-Followup-To: Aleksa Sarai <cyphar@cyphar.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Jeff Xu <jeffxu@google.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>, stable@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20230814-memfd-vm-noexec-uapi-fixes-v2-0-7ff9e3e10ba6@cyphar.com>
 <20230814-memfd-vm-noexec-uapi-fixes-v2-3-7ff9e3e10ba6@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814-memfd-vm-noexec-uapi-fixes-v2-3-7ff9e3e10ba6@cyphar.com>
User-Agent: Mutt
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, 14. Aug 18:40, Aleksa Sarai wrote:
> In order to incentivise userspace to switch to passing MFD_EXEC and
> MFD_NOEXEC_SEAL, we need to provide a warning on each attempt to call
> memfd_create() without the new flags. pr_warn_once() is not useful
> because on most systems the one warning is burned up during the boot
> process (on my system, systemd does this within the first second of
> boot) and thus userspace will in practice never see the warnings to push
> them to switch to the new flags.
> 
> The original patchset[1] used pr_warn_ratelimited(), however there were
> concerns about the degree of spam in the kernel log[2,3]. The resulting
> inability to detect every case was flagged as an issue at the time[4].
> 
> While we could come up with an alternative rate-limiting scheme such as
> only outputting the message if vm.memfd_noexec has been modified, or
> only outputting the message once for a given task, these alternatives
> have downsides that don't make sense given how low-stakes a single
> kernel warning message is. Switching to pr_info_ratelimited() instead
> should be fine -- it's possible some monitoring tool will be unhappy
> with a stream of warning-level messages but there's already plenty of
> info-level message spam in dmesg.
> 
> [1]: https://lore.kernel.org/20221215001205.51969-4-jeffxu@google.com/
> [2]: https://lore.kernel.org/202212161233.85C9783FB@keescook/
> [3]: https://lore.kernel.org/Y5yS8wCnuYGLHMj4@x1n/
> [4]: https://lore.kernel.org/f185bb42-b29c-977e-312e-3349eea15383@linuxfoundation.org/
> 
> Cc: stable@vger.kernel.org # v6.3+
> Fixes: 105ff5339f49 ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC")
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  mm/memfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memfd.c b/mm/memfd.c
> index d65485c762de..aa46521057ab 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -315,7 +315,7 @@ SYSCALL_DEFINE2(memfd_create,
>  		return -EINVAL;
>  
>  	if (!(flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
> -		pr_warn_once(
> +		pr_info_ratelimited(
>  			"%s[%d]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set\n",
>  			current->comm, task_pid_nr(current));
>  	}
> 
> -- 
> 2.41.0
>
Hello Sarai,

i got a lot of messages in dmesg with this. DMESG is unuseable with
this. 
[ 1390.349462] __do_sys_memfd_create: 5 callbacks suppressed
[ 1390.349468] pipewire-pulse[2930]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1390.350106] pipewire[2712]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1390.350366] pipewire[2712]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1390.359390] pipewire[2712]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1390.359453] pipewire[2712]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1390.848813] pipewire-pulse[2930]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1390.849425] pipewire[2712]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1390.849673] pipewire[2712]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1390.857629] pipewire[2712]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1390.857674] pipewire[2712]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1404.819637] __do_sys_memfd_create: 105 callbacks suppressed
[ 1404.819641] pipewire-pulse[2930]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1404.819950] pipewire[2712]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1404.820054] pipewire[2712]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1404.824240] pipewire[2712]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1404.824279] pipewire[2712]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1430.373186] pipewire-pulse[2930]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1430.373906] pipewire[2712]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1430.374131] pipewire[2712]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1430.382397] pipewire[2712]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1430.382485] pipewire[2712]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1430.499581] pipewire-pulse[2930]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1430.500077] pipewire[2712]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1430.500265] pipewire[2712]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1430.512772] pipewire[2712]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1430.512840] pipewire[2712]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1444.388519] __do_sys_memfd_create: 60 callbacks suppressed
[ 1444.388525] pipewire-pulse[2930]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1444.389061] pipewire[2712]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1444.389335] pipewire[2712]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1444.397909] pipewire[2712]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1444.397965] pipewire[2712]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1444.503514] pipewire-pulse[2930]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1444.503658] pipewire[2712]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1444.503726] pipewire[2712]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1444.507841] pipewire[2712]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1444.507870] pipewire[2712]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[ 1449.707966] __do_sys_memfd_create: 25 callbacks suppressed

Best regards
Damian
 
