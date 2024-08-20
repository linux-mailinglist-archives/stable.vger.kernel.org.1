Return-Path: <stable+bounces-69742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372ED958C86
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 18:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21E92838DA
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 16:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD42C1B8EA7;
	Tue, 20 Aug 2024 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UvM+K3dV"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDD418F2C1
	for <stable@vger.kernel.org>; Tue, 20 Aug 2024 16:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724172191; cv=none; b=kgnqd87JUtw0yG/Xk3fLuUdUp6eJXOkgT08Dx2di1i5DqLTQ3Xyr48ZoqwmgBMJQiwZQ1vnYWRDL32ED0ILSNpElgPlCNCXY5jCDzPyxP/VlvULbjOS63WgBY6C1D7d691YuTqzYfpfY2ZteobtNVpb8TUoqEXgHX764isufPsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724172191; c=relaxed/simple;
	bh=G9iVXUrP1plEOqNYFNeP/xq4IqrLWdLx9V7qQFPks8k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kBHzkd9xenZOB8IxS2vOgj7lDDunTvaGzaardQxujm2XggVrBTQE0OtwR7AOr9xj6oeK3uTzuSmWxkm/iAtDNibgt8H4SIbIU984c7ZqUc5qzL23yZ9F8tmM4ZLv08L8SFrfApR1un3lXzq4Yy7rTDHoNfoKlkq0y7GXtIJDxuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UvM+K3dV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724172188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pgy7TmShVNG2p9gTAoq5FNsNe4QpXaI0vELIMEnnvfU=;
	b=UvM+K3dV/KCUGkevkcRzHoXkyf+FH3wpisaOb0oQ9kyNX6ptRsYzcM78zaaVmC8RFg85ec
	6hsc3TplWR0WoBqCc6bIj0rwa/ff62zpvRfT65JpX9RYO8Q/OqAuoIPBWsfeN1iIF77Gc3
	E/bbJ7KuL3L9wBDrLEZrZo+O5tfTqlk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-I3ho7BjCNUSMZa9rBjyUng-1; Tue, 20 Aug 2024 12:43:07 -0400
X-MC-Unique: I3ho7BjCNUSMZa9rBjyUng-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6bf6bdb14baso65412676d6.3
        for <stable@vger.kernel.org>; Tue, 20 Aug 2024 09:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724172187; x=1724776987;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pgy7TmShVNG2p9gTAoq5FNsNe4QpXaI0vELIMEnnvfU=;
        b=YwzHzfzHv1WSxBPFLFS2w02yl3Pv6kTpqM1cdn40uKkakjxfVI5Mrp53eVgGNwku22
         pmf4Jw9J5ju7YjkgvUacMvGu61+s+jcI/9nn75+WsI1atMpVBktKISoJRmTb++ebNPRD
         i94JNUa5GKYQedB/fdoIdI9m0fWMB+j3r3aD09EH4vSdzE1ODHqcONYWdiSGoOcJ+Btm
         2R23OzTxlZLKOk8GMBLVigugdKQf3O0w5ToiUVsCySmOli1/WfEFBN4v9pXYTfmjIniD
         ObKEB3ngJLcLe8xoXflXyZmSFHZrTXH6mzrHGtnbOZ+G4TbKjdxK3LA60/zXkTFSPhVp
         cBzw==
X-Forwarded-Encrypted: i=1; AJvYcCU9XOKBshjUL//kvVI11tApqNvUBM06UiWna9UdZHRHjrY6CbOXYlt6TtmZ7mZyJCErs3WoAtssAmM4AlaVWet6mcojU7+6
X-Gm-Message-State: AOJu0YzUzIIRbY25L2GlP3Dgyh6orpodY5jqZm0UC/LpY/NbpP1AP3YK
	KiiwF3UKTQXGQJ9U3Y1AoU9VAAmwgqfleXsNGGBEweSw7ZWvqyOShXrZCXAIwqZmmDNEelBn8wH
	NcOG/koeQpHGpAV6hCCXog52j0MSREJWYQfbJ1tAOc1ow0qqKph+yCg==
X-Received: by 2002:a05:6214:524a:b0:6bf:7799:bf1d with SMTP id 6a1803df08f44-6bf7ce5a68emr190083146d6.35.1724172186760;
        Tue, 20 Aug 2024 09:43:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC8gkFucZtS7Tu9TSq2EJ/6SaChCv2HyXG/oZQokDevLw/4hHdMaEs3MLK1sqfCIi5djGBzw==
X-Received: by 2002:a05:6214:524a:b0:6bf:7799:bf1d with SMTP id 6a1803df08f44-6bf7ce5a68emr190082836d6.35.1724172186270;
        Tue, 20 Aug 2024 09:43:06 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fec5cd0sm53753156d6.90.2024.08.20.09.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:43:05 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Daniel Vacek <neelx@redhat.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Cc: Daniel Vacek <neelx@redhat.com>, stable@vger.kernel.org, Bill Peters
 <wpeters@atpco.net>, Ingo Molnar <mingo@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/core: handle affine_move_task failure case
 gracefully
In-Reply-To: <20240814153119.27681-1-neelx@redhat.com>
References: <20240814153119.27681-1-neelx@redhat.com>
Date: Tue, 20 Aug 2024 18:43:02 +0200
Message-ID: <xhsmh5xrvcfhl.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 14/08/24 17:31, Daniel Vacek wrote:
> CPU hangs were reported while offlining/onlining CPUs on s390.
>
> Analyzing the vmcore data shows `stop_one_cpu_nowait()` in `affine_move_task()`
> can fail when racing with off-/on-lining resulting in a deadlock waiting for
> the pending migration stop work completion which is never done.
>
> Fix this by gracefully handling such condition.
>
> Fixes: 9e81889c7648 ("sched: Fix affine_move_task() self-concurrency")
> Cc: stable@vger.kernel.org
> Reported-by: Bill Peters <wpeters@atpco.net>
> Tested-by: Bill Peters <wpeters@atpco.net>
> Signed-off-by: Daniel Vacek <neelx@redhat.com>
> ---
>  kernel/sched/core.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f3951e4a55e5b..40a3c9ff74077 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2871,8 +2871,25 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
>               preempt_disable();
>               task_rq_unlock(rq, p, rf);
>               if (!stop_pending) {
> -			stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
> -					    &pending->arg, &pending->stop_work);
> +			stop_pending =
> +				stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
> +						    &pending->arg, &pending->stop_work);
> +			/*
> +			 * The state resulting in this failure is not expected
> +			 * at this point. At least report a WARNING to be able
> +			 * to panic and further debug if reproduced.
> +			 */
> +			if (WARN_ON(!stop_pending)) {

I don't think it can happen when @p's CPU is being hot-unplugged, because
takedown_cpu()->take_cpu_down() is done via stop_machine_cpuslocked(), so
that task waking/running on that CPU implies the stopper is enabled.

I'm thinking there may be a window somewhere during hotplug, something like
so?

CPU0                       CPU1                       CPU2
----                       ----                       ----
                           secondary_start_kernel()
                             set_cpu_online(true)
wake_up_process(p)
  WRITE_ONCE(p->__state, TASK_WAKING);
  set_task_cpu(p, CPU1) // CPU1 is prev CPU
  ttwu_queue_wakelist();
                                                     affine_move_task(p)
                                                       stop_one_cpu_nowait() // FAILS

                             cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
                               cpuhp_online_idle()
                                 stop_machine_unpark(); // <-- too late


