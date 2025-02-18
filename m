Return-Path: <stable+bounces-116788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F056A3A07B
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 15:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8FB3B0B57
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 14:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3757E26A0EC;
	Tue, 18 Feb 2025 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xGfMV3n3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A8526A1CE
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889916; cv=none; b=cJOVGIHXyeSmgAC+RvqxUFK9NgnwdSTkCU2AnZ3JxXJtEgC1UUfREvmYkFknVrl8DZI/nbmQkUxSqNPwd54sTQvu8xuzUXrG+CsvlwtMOz+3JgexYmah4wVzSdhNQTmdu1F/mLFJ3oJJraEgEWFjSxjPouUHSdL4NLbYfEDiFuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889916; c=relaxed/simple;
	bh=KWZp564WMapVtxqlGtG9YU6UdpBFypVsuDScLbADuvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqTssi2f5kvglHB8R+bWp40eLKftGxxS6ebiLrvDcIwWluPWY4ATKURplppmei/Ffm2CdSYLuCrCXMVMHTJyV/On86VJrtXgsl8W6c7hKXhLhJqRSteGKQYV+vEv+MCPxbhuL7WF0lCHVDXk70mz+9w3UpiVRpHbguOZt+hVKuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xGfMV3n3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004D2C4CEE2;
	Tue, 18 Feb 2025 14:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739889915;
	bh=KWZp564WMapVtxqlGtG9YU6UdpBFypVsuDScLbADuvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xGfMV3n3lMFig/aMdGGWBSsL5CXZ6v6QYMihYKgzpIF2fslvE+JHouWvqkmCoYeir
	 d/CnTWMIa4+ddEhBSxyVyvXUEZuKBJV7D8paMOEwoLSMDvdKImCjf5M30BFI8mPICI
	 64AanHgiDl/VB8qP+/lAazgc02by96hhOelZ7IZ0=
Date: Tue, 18 Feb 2025 15:45:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Marc Smith <msmith626@gmail.com>
Cc: jakobkoschel@gmail.com, stable@vger.kernel.org, aahringo@redhat.com,
	teigland@redhat.com
Subject: Re: Linux 5.4.x DLM Regression
Message-ID: <2025021843-percolate-crewmate-6325@gregkh>
References: <CAH6h+hfg4RcwuNUDspMrEt+5Gk5hBhE-pfLTF29M9qJLiYtoAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH6h+hfg4RcwuNUDspMrEt+5Gk5hBhE-pfLTF29M9qJLiYtoAQ@mail.gmail.com>

On Mon, Feb 17, 2025 at 02:23:43PM -0500, Marc Smith wrote:
> Hi,
> 
> I noticed there appears to be a regression in DLM (fs/dlm/) when
> moving from Linux 5.4.229 to 5.4.288; I get a kernel panic when using
> dlm_ls_lockx() (DLM user) with a timeout >0, and the panic occurs when
> the timeout is reached (eg, attempting to take a lock on a resource
> that is already locked); the host where the timeout occurs is the one
> that panics:
> ...
> [  187.976007]
>                DLM:  Assertion failed on line 1239 of file fs/dlm/lock.c
>                DLM:  assertion:  "!lkb->lkb_status"
>                DLM:  time = 4294853632
> [  187.976009] lkb: nodeid 2 id 1 remid 2 exflags 40000 flags 800001
> sts 1 rq 5 gr -1 wait_type 4 wait_nodeid 2 seq 0
> [  187.976009]
> [  187.976010] Kernel panic - not syncing: DLM:  Record message above
> and reboot.
> [  187.976099] CPU: 9 PID: 7409 Comm: dlm_scand Kdump: loaded Tainted:
> P           OE     5.4.288-esos.prod #1
> [  187.976195] Hardware name: Quantum H2012/H12SSW-NT, BIOS
> T20201009143356 10/09/2020
> [  187.976282] Call Trace:
> [  187.976356]  dump_stack+0x50/0x63
> [  187.976429]  panic+0x10c/0x2e3
> [  187.976501]  kill_lkb+0x51/0x52
> [  187.976570]  kref_put+0x16/0x2f
> [  187.976638]  __put_lkb+0x2f/0x95
> [  187.976707]  dlm_scan_timeout+0x18b/0x19c
> [  187.976779]  ? dlm_uevent+0x19/0x19
> [  187.976848]  dlm_scand+0x94/0xd1
> [  187.976920]  kthread+0xe4/0xe9
> [  187.976988]  ? kthread_flush_worker+0x70/0x70
> [  187.977062]  ret_from_fork+0x35/0x40
> ...
> 
> I examined the commits for fs/dlm/ between 5.4.229 and 5.4.288 and
> this is the offender:
> dlm: replace usage of found with dedicated list iterator variable
> [ Upstream commit dc1acd5c94699389a9ed023e94dd860c846ea1f6 ]
> 
> Specifically, the change highlighted below in this hunk for
> dlm_scan_timeout() in fs/dlm/lock.c:
> @@ -1867,27 +1867,28 @@ void dlm_scan_timeout(struct dlm_ls *ls)
>                 do_cancel = 0;
>                 do_warn = 0;
>                 mutex_lock(&ls->ls_timeout_mutex);
> -               list_for_each_entry(lkb, &ls->ls_timeout, lkb_time_list) {
> +               list_for_each_entry(iter, &ls->ls_timeout, lkb_time_list) {
> 
>                         wait_us = ktime_to_us(ktime_sub(ktime_get(),
> -                                                       lkb->lkb_timestamp));
> +                                                       iter->lkb_timestamp));
> 
> -                       if ((lkb->lkb_exflags & DLM_LKF_TIMEOUT) &&
> -                           wait_us >= (lkb->lkb_timeout_cs * 10000))
> +                       if ((iter->lkb_exflags & DLM_LKF_TIMEOUT) &&
> +                           wait_us >= (iter->lkb_timeout_cs * 10000))
>                                 do_cancel = 1;
> 
> -                       if ((lkb->lkb_flags & DLM_IFL_WATCH_TIMEWARN) &&
> +                       if ((iter->lkb_flags & DLM_IFL_WATCH_TIMEWARN) &&
>                             wait_us >= dlm_config.ci_timewarn_cs * 10000)
>                                 do_warn = 1;
> 
>                         if (!do_cancel && !do_warn)
>                                 continue;
> -                       hold_lkb(lkb);
> +                       hold_lkb(iter);
> +                       lkb = iter;
>                         break;
>                 }
>                 mutex_unlock(&ls->ls_timeout_mutex);
> 
> -               if (!do_cancel && !do_warn)
> +               if (!lkb)
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                         break;
> 
>                 r = lkb->lkb_resource;
> 
> Reverting this single line change resolves the kernel panic:
> $ diff -Naur fs/dlm/lock.c{.orig,}
> --- fs/dlm/lock.c.orig  2024-12-19 12:05:05.000000000 -0500
> +++ fs/dlm/lock.c       2025-02-16 21:21:42.544181390 -0500
> @@ -1888,7 +1888,7 @@
>                 }
>                 mutex_unlock(&ls->ls_timeout_mutex);
> 
> -               if (!lkb)
> +               if (!do_cancel && !do_warn)
>                         break;
> 
>                 r = lkb->lkb_resource;
> 
> It appears this same "dlm: replace usage of found with dedicated list
> iterator variable" commit was pulled into other stable branches as
> well, and I don't see any fix in the latest 5.4.x patch release
> (5.4.290).

What commit needs to be backported to resolve this?

thanks,

greg k-h

