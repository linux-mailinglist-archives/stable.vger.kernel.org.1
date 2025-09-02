Return-Path: <stable+bounces-177528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D25B40BC3
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 19:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95CF1A84256
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 17:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C06342C99;
	Tue,  2 Sep 2025 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dOMDWc+H"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D8131B102
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756833279; cv=none; b=dImjRYNMTgHcStqxYlxI+XsezZoulh5U/Q7heWxbL+edsx6ZXYvwV2POfyYIhFO3XJppKwGMWxqRYiKDSqRKoM9/ItmEjmHgB+CYCZ2x/aBh6m9+TJ8mk2uH10UNhHJ+zO52v4s4iPQD6kQqgKqSDm3NQ51QtGdpF6gdrBuK1m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756833279; c=relaxed/simple;
	bh=KP+TLtwyL8ipGtoqM7ghjMPqXCRkOL7mmitCpt9EMnE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RyQT6u8ZnlYZ/9UnOiZwI52sEhbnt83uWmIEKilLtjeuz2ytKRhmSqkV2EGYB0IR4KcuEGuW2wSpKJxpe9YzgyFc7DJL59OzS5zgZSBJK03u30uWUoJhX7rw2bkLT/M9jfYdZZynITCQMxu+UQOkqZLIZDiY5GBGMGguWlwaUFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dOMDWc+H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756833276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJTbTLLAJp5d1X+RLfkvvY6hV6oBzi1je5oF3smiZug=;
	b=dOMDWc+H9lwRpfUWjXKW4Ny9lFd1W2cdnMwTcebuiO/n/cm48AXmD69nJxIRtab/qxFkM/
	VQK2WRUz26ELXliS7g6LyOqCVbpREmDEOyFzrIqogIuPd++xsqYym/zOUQgREi+xUfAo2o
	vgSAB6LY99QgHTp0l0S3ST2yDHOX6Gk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-oUkqXZg1MvigYU_94KllNg-1; Tue, 02 Sep 2025 13:14:34 -0400
X-MC-Unique: oUkqXZg1MvigYU_94KllNg-1
X-Mimecast-MFC-AGG-ID: oUkqXZg1MvigYU_94KllNg_1756833274
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b311db2c76so42655911cf.2
        for <stable@vger.kernel.org>; Tue, 02 Sep 2025 10:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756833274; x=1757438074;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yJTbTLLAJp5d1X+RLfkvvY6hV6oBzi1je5oF3smiZug=;
        b=iiLutcLyUWylDIoXLVdvy/UJzjQpM9+5Mg+16HZuIyGm39tNK/GW2Fp7EXFgZZhXMX
         Mg0kVi8UAGA4Co/CmvNU6W36Q9QFu1hmbCrl1HIWbIBMh4fthN6G1+YUx/lFt3QAIshn
         /P+NiEMF+7nBeHpfmRcs9q27J3O3gsTG36ldyZr3dxoeh+ECvspoGfkMP4t+coPtpjbN
         qSVqmFnXWdRzAmkyYfuVoGcI8/K4Ob6FS3m2OovPwSW8ohLMKtvTB9vbLaRewy2cVClA
         b1TrfxYFSgJuy/D/THG9PxE6gZX02kNh6eV9wiSYwi83cq832e3VeKT4jcNEObrupN2n
         LQaA==
X-Forwarded-Encrypted: i=1; AJvYcCVixfpcu7N5w8lTUP+2BR8PUutznNhrPuIC+P2NX09zeGt4Ux3+DWK5jq0owEox8iBEnbjUa4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyl/Yl3hlkGsq96jM3eeuBK0/OBH7m0FaqeV+Y+VxX1+AMP74c
	UqamM/ClDLPhHvLRvruf5lY7m/mRCTL8wclYWBa9HHk2i20Fy/AV+V61PeA7QTDkkDrsKAFXed1
	LViBvm6tkT5brmyLbfklyNvO+mGFN3K5hWhwTo56WNadN8Zkf4BQUmNob4Q==
X-Gm-Gg: ASbGncvqs07nRn/73ZaUPqoH1nlDwSmYpJ+ykyOcR1c5+X+8BpTn3FmEnNsO0e8Hsx/
	ToXkDR0Qg2MWW6yrikjYXfuZRe/PyxYgZf8cdkJaD7Kz0KAIs8qLjWsD9zogXa7wT0q5QyMoYfT
	5L0AZSbbIXbb3YsiO4G7OMhy/wOnc8PL7bMv9ty60o6DMH1aR8f9wq78SU8xEZmIKJj8B5r+ykW
	wLlDv1aY9t3m58qmb+44PlUK330TBVwITXcLC7tuTGFK0va5U6nHJ0YW8qpXjun/MhmOm/Ve+AB
	hlqbJL54HHXbRElnLWl92E4MR8apv/LS9Qy6NOnUbDF68mQlI85G1D3Bl5g595iA2A0vbquvPJ/
	C4WgHo0/tAw==
X-Received: by 2002:a05:622a:2a12:b0:4b3:4d20:302 with SMTP id d75a77b69052e-4b34d2015ccmr30038451cf.81.1756833273762;
        Tue, 02 Sep 2025 10:14:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd9q75h/QyzT7q7qh5UVGeZkAkp/BGinsKuVNoDttOlVyk/VfACSIA8Q3J9whLbhq6hXufmg==
X-Received: by 2002:a05:622a:2a12:b0:4b3:4d20:302 with SMTP id d75a77b69052e-4b34d2015ccmr30037991cf.81.1756833273364;
        Tue, 02 Sep 2025 10:14:33 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b3462ede0bsm15181361cf.36.2025.09.02.10.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 10:14:32 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <533633c5-90cc-4a35-9ec3-9df2720a6e9e@redhat.com>
Date: Tue, 2 Sep 2025 13:14:31 -0400
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


