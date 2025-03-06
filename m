Return-Path: <stable+bounces-121279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2213BA551CD
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 17:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD63176580
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 16:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0E625B66B;
	Thu,  6 Mar 2025 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjwWDMYf"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE2625A65F
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 16:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279741; cv=none; b=cALnXEG+YvpI6L1LU7ffgaApvWrULG/ahui5HY6Tbybu5kwEhKx3DXNALsM+0TRh4YHiZCAYg3NX7d2ZMHOHj+NKswDoczk4H8zjmxEvoI1jAGjB7vVbUq5jePzdCPs+0EelMlAyA/xO4kg6UF0pjmHUJn0Zcpf0DMxJ+RIGm4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279741; c=relaxed/simple;
	bh=Y++u8rWHcpmVczkgOVDovidF76ottDHpCHaf9LbRsj8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XpszijfI7IgQSKBTW7Q0IrTp3yGf1ECdDIgQf4fc0GZuotE1HRN2YjYOHT59lXth7hG9MoayISZsLhzAwXxSnHnadHbkDOSBa7mq5+tER1b5qt3vOux0EP+xl8SJf1jNHjVe1Odfo668y3OZTOpQt2GhNP2vxlQ9lGiSscz4St4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WjwWDMYf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741279738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DnZMB0kgHOAUXEFLOXzghVoRuV4+jMQKukckas1LShg=;
	b=WjwWDMYfz2Fw+Bhu9A4yn0ct/IY8zDncHEqK1MwSNAPZbeNvZ6ad8eGBLEu5aa7lxV5VmR
	Bk1RWxgM3HbZ5yM9nmi8KmZD3L7frUeoVURRpWi0vu+j/mUERSZJGb7FllAKKIf2XRsibG
	Ncoax98j5hBd01aHrhZ4J8g3xAytiLA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-02ESmH7QMcaxmGCMO7Z7Ew-1; Thu, 06 Mar 2025 11:48:42 -0500
X-MC-Unique: 02ESmH7QMcaxmGCMO7Z7Ew-1
X-Mimecast-MFC-AGG-ID: 02ESmH7QMcaxmGCMO7Z7Ew_1741279721
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-390eefb2913so643896f8f.0
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 08:48:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741279721; x=1741884521;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DnZMB0kgHOAUXEFLOXzghVoRuV4+jMQKukckas1LShg=;
        b=MQh+cagc/e4dSfTc+fGdueGzSmVDPmyQhIlYZHnoJ9YO7SKbyE13o7cSIxqH4xMkts
         H2SseIluEMWt0TfgBNkwJuzKhLTNRpuDzkvPiWIq9/Y+B1ZvrL1EwHMaYWLu1S0VUR4+
         iF6G8AsA8OgDRY9fyale4kF1Jb4i/P7FOh6XVnnnd5Xp8GTQP0q/jdb6Fjd/UveKYXoP
         LunHRdj7Rz89T8Ciq/bYWOzxwXeDs6vsD4mfo2zW/lIzHoQuEJCqwN8RFRMhKuGSOGVT
         cYFPOKnpz3M6quRTm8RTQqlszlgWK+HHNyJKTvfzbCE0C+ndbT4t8A3qOpLYbMMj5iDj
         h7cA==
X-Gm-Message-State: AOJu0YztVwUW6AjWrkWnZl4r/THRJH3OPNKoOkYl47bthoFwdRTG0MF4
	SDYWU9d+raH/yfQa8q30RBFvADiFC6RND00OL3guqvD2ChPbUFhGAQg1PI+BYf9aozZZepI5DNF
	PJLiszPWddS55myUb1r53Gb9U9PXkHhtzmxvLwn53GiXbwaHmPJ22Rg==
X-Gm-Gg: ASbGncs2Gene5/aR+YwfZfl7DYjDPz+lWk6Qlh45tsaSRPjxQr4t9JttI2JxFJs6RyP
	HZzhnqLVKSVOvrfO0RdSOCQTcuLIFMH8+0CIE69lCf1taiQ7kR0MairS1uWb6eyOqjsVmamFnIO
	WEU2EN8ysaqGH04HsmDtYvbsGjbp0DpVLIa781GleDQ99UXqBQCFlC3ArJqvIFrrZ3yE40MZVx2
	gZUVhSy821o9QC22ERs54PNnaKHPozZLCwhK66qPNDKxpxL0ENyKqvWxn+w5Up5NCEZLrPWLbyu
	nuO4+l2Q50iuxZVDWZ7EkG1AoeQ7WNyniJFCTg9OII9wmyXplCHZofNAlWNNMBpiwvD7/Ljkke8
	i
X-Received: by 2002:a5d:6d04:0:b0:391:2e31:c7e1 with SMTP id ffacd0b85a97d-3912e31cbdamr1733790f8f.4.1741279721435;
        Thu, 06 Mar 2025 08:48:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOpgKBtQoNqG0A8vm9wg1dVElBwbL0nvoKqU52pzsHajpANvmpL/kEWNNxDa1hdG90eyLpOA==
X-Received: by 2002:a5d:6d04:0:b0:391:2e31:c7e1 with SMTP id ffacd0b85a97d-3912e31cbdamr1733766f8f.4.1741279721060;
        Thu, 06 Mar 2025 08:48:41 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e4065sm2611195f8f.62.2025.03.06.08.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:48:40 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Naman Jain <namjain@linux.microsoft.com>, Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org, Steve Wahl
 <steve.wahl@hpe.com>, Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
 srivatsa@csail.mit.edu, K Prateek Nayak <kprateek.nayak@amd.com>, Michael
 Kelley <mhklinux@outlook.com>, Naman Jain <namjain@linux.microsoft.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [PATCH v4] sched/topology: Enable topology_span_sane check only
 for debug builds
In-Reply-To: <20250306055354.52915-1-namjain@linux.microsoft.com>
References: <20250306055354.52915-1-namjain@linux.microsoft.com>
Date: Thu, 06 Mar 2025 17:48:39 +0100
Message-ID: <xhsmhwmd2ds0o.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 06/03/25 11:23, Naman Jain wrote:
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index c49aea8c1025..666f0a18cc6c 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2359,6 +2359,13 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
>  {
>       int i = cpu + 1;
>
> +	/* Skip the topology sanity check for non-debug, as it is a time-consuming operation */
> +	if (!sched_debug()) {
> +		pr_info_once("%s: Skipping topology span sanity check. Use `sched_verbose` boot parameter to enable it.\n",
> +			     __func__);

FWIW I'm not against this change, however if you want to add messaging
about sched_verbose I'd put that in e.g. sched_domain_debug() (as a print
once like you've done here) with something along the lines of:

  "Scheduler topology debugging disabled, add 'sched_verbose' to the cmdline to enable it"

> +		return true;
> +	}
> +
>       /* NUMA levels are allowed to overlap */
>       if (tl->flags & SDTL_OVERLAP)
>               return true;
> --
> 2.34.1


