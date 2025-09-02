Return-Path: <stable+bounces-177522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EC2B40B9C
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 19:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DCF81886646
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 17:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3F0341679;
	Tue,  2 Sep 2025 17:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c0TiIncE"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CE92EB5DA
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832773; cv=none; b=hElvl3mxRso2KU0clWYHo0ZWGS/9oeT9BRjtHUkzHNrKXq/ZXiFZaIfiyweRJAJNm+Ju1MZeBv+Y/lgpAAKpCEqqk6Z9zCi44vo0/mSHL8xH355RWcd5C6pXqOjzLXuWx2LXExtaObHJ/ozdeb0R1qvsuusdx8XlF7NPuqyHigM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832773; c=relaxed/simple;
	bh=wlZH8lhbscxC9THCQ4kinck0ZuzPLO1Tm5yhuN/XkRU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KOKelNGM7bcqFLwt5PoQ0jpejLqrCyWwHabTDlmtZRpi3LdvlxReLIuXeL6rBu3ZasKl/UZUcOsV4dEo1m48JtGNSwQ965MfDruU5wWQvMrox3TulSx0AiJ2Tqc/cxr8uXydbvjG9kpCag0lEYG/jMPwGTXSBj8drhF6op8xgkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c0TiIncE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756832770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHu4aCUA0D1nulKzC9Dqv0LHGBHTxw2XXtYWx9Xi0Pk=;
	b=c0TiIncErvEl682RpOINfXf/JQBBgld5e8rcIOHATOC30LOMWZxj8ffaNQyTd28ufJa+vz
	N8MmME3RbTGeBRTAtiafKlE27gFJxeVngS/4A+MWOkMQ2/vqgUgw3INKo7LHXDdxK8yebE
	E8pa8swoQMMJycgGn8l8VUzMaYUoOD8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-Qb_MZAmrPDCLF1dKaZwy1A-1; Tue, 02 Sep 2025 13:06:07 -0400
X-MC-Unique: Qb_MZAmrPDCLF1dKaZwy1A-1
X-Mimecast-MFC-AGG-ID: Qb_MZAmrPDCLF1dKaZwy1A_1756832767
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7fc5584a2e5so1283852185a.2
        for <stable@vger.kernel.org>; Tue, 02 Sep 2025 10:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756832767; x=1757437567;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHu4aCUA0D1nulKzC9Dqv0LHGBHTxw2XXtYWx9Xi0Pk=;
        b=NLHKqu9esIR9v5YIfwFWg/W1I9xOWX3c0RWJZoY3YaEWhz3JCHjcLf/Nt4cBGLAnvn
         nOdB3CvbziJSJ+3k+qxXXBuSKrmUTN4eE1jDZpp855nJw2VoyT33BrEnD+fNth02/+c6
         4V1zTQkf9tA09z+QOwoxIetua3HjAEzn49KsoFbcsNRKnc+KAFzeKNUbVRu6UrXUp6Wi
         E1s3swpoCck2x3jWpu8uEYV8nezOgrM2OVsoRRCV9Myz1/sdc0yHZzRKtj470SMnz0St
         7tYRelGmO/vWrWeGdbF/j6zdSmOoDFd3UY8o6iKkayGnbrC4TIVvdpg3OGbvH6h/orVc
         tlDA==
X-Forwarded-Encrypted: i=1; AJvYcCWZJ+pirvGEnKweroeBjmRmvIFLH9DHzoXmsj2LlX7sjiFPTGGj86b35xpOhGitsokNB0Mojoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbwS8RTxOJGT4DixAy7oFJ1P6NUmM2NlPq2T7aflaO7VT3X8Bs
	IbSuZolx8egJdLCL4t7ZfbX7VJZFpo+TG9pdLM3/ANMomiW82DOLd6yX+XuiucxAI02WS/ImAY6
	tHnM6PWwQLDM2A8gwNDRAZAHRGIyePqKHEysfmdnIa6/9hZvb+ZDC7TvS7Q==
X-Gm-Gg: ASbGnctyyDxNGFeU8+8vqMhjskY9J30Sh1EIRaHgI6gXxMXzDPJvHE9XOh2zNPckhWV
	UxYL5RVdRzzPUJlTAngCPr5l3IjSrLLYMJD0BsWMGhToWtt5BeTWkL1FvnUbce4uOWJE1uMdI2p
	B9HsWevCzehuSuDRYcgrvqNEHT0pcjBgcHf/nD2/3DPs4ab6bcCJY8d1FLz65IOJQxT5N8L9pWw
	gjWEz8hrpm9FImJh+sXXIZgAw5Rt6CfEpvKBNoeSss15LCdHzJpUbHvWiBC3AzaegI1oyuiPmdW
	vgR0/F0YFC5lKU7Y+1wVSVYCddmR8Xthwkmfgc0G5VdaSX7igtN8uY0wHz383RaOA4LBn/Itm9k
	JFhwS5U/hMQ==
X-Received: by 2002:a05:6214:21e8:b0:722:2301:324 with SMTP id 6a1803df08f44-722230112a1mr12129266d6.23.1756832766896;
        Tue, 02 Sep 2025 10:06:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1pydDCKXIedyuxkEgwpPTsJFeOHTh1mDJMxMHZOWHQTWsHU1k0rC0R+/XBlYtwjeZ8QWeuw==
X-Received: by 2002:a05:6214:21e8:b0:722:2301:324 with SMTP id 6a1803df08f44-722230112a1mr12128756d6.23.1756832766297;
        Tue, 02 Sep 2025 10:06:06 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ac16de30sm15073986d6.7.2025.09.02.10.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 10:06:05 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <ef0e91b7-be44-4d5d-a556-240709c80fcb@redhat.com>
Date: Tue, 2 Sep 2025 13:06:04 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuset: prevent freeing unallocated cpumask in hotplug
 handling
To: Ashay Jaiswal <quic_ashayj@quicinc.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250902-cpuset-free-on-condition-v1-1-f46ffab53eac@quicinc.com>
Content-Language: en-US
In-Reply-To: <20250902-cpuset-free-on-condition-v1-1-f46ffab53eac@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/25 12:26 AM, Ashay Jaiswal wrote:
> In cpuset hotplug handling, temporary cpumasks are allocated only when
> running under cgroup v2. The current code unconditionally frees these
> masks, which can lead to a crash on cgroup v1 case.
>
> Free the temporary cpumasks only when they were actually allocated.
>
> Fixes: 4b842da276a8 ("cpuset: Make CPU hotplug work with partition")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ashay Jaiswal <quic_ashayj@quicinc.com>
> ---
>   kernel/cgroup/cpuset.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index a78ccd11ce9b43c2e8b0e2c454a8ee845ebdc808..a4f908024f3c0a22628a32f8a5b0ae96c7dccbb9 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4019,7 +4019,8 @@ static void cpuset_handle_hotplug(void)
>   	if (force_sd_rebuild)
>   		rebuild_sched_domains_cpuslocked();
>   
> -	free_tmpmasks(ptmp);
> +	if (on_dfl && ptmp)
> +		free_tmpmasks(ptmp);
>   }
>   
>   void cpuset_update_active_cpus(void)

The patch that introduces the bug is actually commit 5806b3d05165 
("cpuset: decouple tmpmasks and cpumasks freeing in cgroup") which 
removes the NULL check. The on_dfl check is not necessary and I would 
suggest adding the NULL check in free_tmpmasks().

Cheers,
Longman



