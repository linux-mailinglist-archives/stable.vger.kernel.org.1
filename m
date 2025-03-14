Return-Path: <stable+bounces-124425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E09A60D58
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 10:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F10F3B6EE4
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 09:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D9A1F17E9;
	Fri, 14 Mar 2025 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TdC6kWxo"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671841C245C
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944664; cv=none; b=dmUnszZN6uUvxJwdREShcnwf+NpKUhuU4X0sYiTYVydmKrFp4NTIDNLH9vxDbowdGK2rBZ7DTiRZqDkEpnTKO9+KAjnUnu/iMEZ3636HFnSvaCRFPYacAelqy6mu3nP6v3RaYsgDv3NcD6Rl1MLcwMjxYi7USUbusNkq6x26A1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944664; c=relaxed/simple;
	bh=e93eE40n9bUFNxE5voxoWM330uqXG0CNIr05Q7FIhps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBFSApfTmNWcRFeKcKPelXCx3+v/G8QmipuxPzsh3lhH+VRtCfXSmbXjMaQ21TLvRfxFKfWVwkkKesVtjY7ocv5ejigrYeNfaNaoti0RWvdD8JBuCqyNvr8o6dZGLerwzu5hYMyhXzUu5Z10jw3VaGl2biKKaOMdmSyYuChJPsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TdC6kWxo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741944658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R+uw1Q3X470tWmgPcYoi9tjQ2jSl9Kq26p5f4ZluhfM=;
	b=TdC6kWxoMIi3OibiYpYLtfKH5UPPMk4Q60++5HaNsKR8ht/d1hEpL4smmlhS0ckFn6q80N
	IdNKG42pm5USNYZiKGJgpwnV9p6/3N4DpgISaAa28mRC+C0+cmce8y5PdWY8itVBZyHV1A
	0V8u8G6LldgVwxGLvpu/vpkQLtl+L+0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-ShO71BzlOXi4_7jZHJzw9w-1; Fri, 14 Mar 2025 05:30:57 -0400
X-MC-Unique: ShO71BzlOXi4_7jZHJzw9w-1
X-Mimecast-MFC-AGG-ID: ShO71BzlOXi4_7jZHJzw9w_1741944656
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43947a0919aso14227235e9.0
        for <stable@vger.kernel.org>; Fri, 14 Mar 2025 02:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741944655; x=1742549455;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+uw1Q3X470tWmgPcYoi9tjQ2jSl9Kq26p5f4ZluhfM=;
        b=m8P4XlVppkdQFjCNCJa0Dim+OXV1UvIIR9wc9OgW9mG0BTJGxHp2clnthe5LzsMTxy
         UvxH/t1xmHYwRwAxLn9HikHOu9Vju4YWAviN0ela2g//e4BOWZ5zT7DFS3eBGEILW93z
         56O5d6uVcxf/7xj6gHOyImh/l0Y+o//YE1Si503I05kM3i0/K3XRGfVthfRC3UVdMuSF
         fmNiGBOzo+Qz1Jf0jLhi6WGjIg2od14KqWfLD2MnNaKNPVNw8fxVLu82RSuuny4s6pzK
         1DdkIWR9Bi+lssjdpPLjeXCJclwIs7JjKIhoJnTmqhp1RWu4GQDQ0W21eCbSByWj3Zhn
         CDzw==
X-Forwarded-Encrypted: i=1; AJvYcCUND93dc1Nl9ydH+VMLX8Jn90XT9taPx1xv/9cGjWeZCTF4ec3HNjCReOrWlhPzN8BL4LuYZFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzatdZFj5Jt/QP7dUIVO96bZP6JOC3TM+3ofpar4mDrVpiyTC7t
	cz2OUYgQa2CW27Ae9fPoUmFgTZ+td7b3FKgByiun/QjBFxkq7m3OW3v7ob1/sCtoX5y9g+kDpyB
	pzDcjy82KHVlgpYZU9HlFq0hXzcDlVunS/gJrczGjy8dbjT4/Ho+QoBL2jyCROQ==
X-Gm-Gg: ASbGnctez7zfF9LqW2pSjVOHSm9/R+8NaJLYmEYFCB1qY54xZP9QahN4K/6H63fgDiS
	n4Spid/s3DqK+LOeTurj3sRKlwYMC92YJlINaSuw9j6X4eNiI3JDnLxNtcS7Qc+SRZe8LxrEu6q
	E7oucqjLf2PjIxIyXkZUSKazxBGc0VAGV9+b34d1P8InxI0lwa0rxuKpMO5smgTeZ9ZxsKFeHdN
	kCpJLydtQYYTRCv1Nb0+I02BcRHE+sxQE6+hkd/trt289uUGaXMgAwCSi3pX7i40YikidfR3L3C
	9pZcKK/UQOI1GvDDRMKTQSSEQfgCKm2aUywNnk8qDuU=
X-Received: by 2002:a5d:64c9:0:b0:391:2c67:7999 with SMTP id ffacd0b85a97d-39720779405mr2492401f8f.48.1741944654779;
        Fri, 14 Mar 2025 02:30:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVyKsCgKPTZlOlR372qt56ZtOxfikpuBkcvr2h0zJSg+sZGyxVB7bK/X4XNDrN1LVrxoUbwA==
X-Received: by 2002:a5d:64c9:0:b0:391:2c67:7999 with SMTP id ffacd0b85a97d-39720779405mr2492368f8f.48.1741944654341;
        Fri, 14 Mar 2025 02:30:54 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b69eesm5049255f8f.34.2025.03.14.02.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 02:30:53 -0700 (PDT)
Date: Fri, 14 Mar 2025 10:30:51 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Harshit Agarwal <harshit@nutanix.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] sched/deadline: Fix race in push_dl_task
Message-ID: <Z9P3S_GjAQPSedbI@jlelli-thinkpadt14gen4.remote.csb>
References: <20250307204255.60640-1-harshit@nutanix.com>
 <Z9FXC7NMaGxJ6ai6@jlelli-thinkpadt14gen4.remote.csb>
 <8B627F86-EF5F-4EA2-96F4-E47B0B3CAD38@nutanix.com>
 <Z9Lb496DoMcu9hk_@jlelli-thinkpadt14gen4.remote.csb>
 <59E10428-6359-4E0A-BBB2-C98DF01F79BA@nutanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59E10428-6359-4E0A-BBB2-C98DF01F79BA@nutanix.com>

On 13/03/25 19:38, Harshit Agarwal wrote:
> 
> 
> >>> 
> >>> Maybe to discern between find_lock_later_rq() callers we can use
> >>> dl_throttled flag in dl_se and still implement the fix in find_lock_
> >>> later_rq()? I.e., fix similar to the rt.c patch in case the task is not
> >>> throttled (so caller is push_dl_task()) and not rely on pick_next_
> >>> pushable_dl_task() if the task is throttled.
> >>> 
> >> 
> >> Sure I can do this as well but like I mentioned above I don’t think
> >> it will be any different than this patch unless we want to
> >> handle the race for offline migration case or if you prefer
> >> this in find_lock_later_rq just to keep it more inline with the rt
> >> patch. I just found the current approach to be less risky :)
> > 
> > What you mean with "handle the race for offline migration case"?
> 
> By offline migration I meant dl_task_offline_migration path which
> calls find_lock_later_rq. So unless we think the same race that this
> fix is trying to address for push_dl_task can happen for
> dl_task_offline_migration, there is one less reason to encapsulate
> this in find_lock_later_rq.
> 
> > 
> > And I am honestly conflicted. I think I like the encapsulation better if
> > we can find a solution inside find_lock_later_rq(), as it also aligns
> > better with rt.c, but you fear it's more fragile?
> > 
> 
> Yes I agree that encapsulation in find_lock_later_rq will be ideal
> but by keeping it limited to push_dl_task I wanted to keep the change
> more targeted to avoid any possible side effect on
> dl_task_offline_migration call path.
> 
> Let’s say if we go ahead with making the change in find_lock_later_rq
> itself then we will have to fallback to current checks for throttled case
> and for remaining we will use the task != pick_next_pushable_dl_task(rq)
> check. Below is the diff of how it will be:
> 
>                 /* Retry if something changed. */
>                 if (double_lock_balance(rq, later_rq)) {
> -                       if (unlikely(task_rq(task) != rq ||
> +                       if (unlikely(is_migration_disabled(task) ||
>                                      !cpumask_test_cpu(later_rq->cpu, &task->cpus_mask) ||
> -                                    task_on_cpu(rq, task) ||
> -                                    !dl_task(task) ||
> -                                    is_migration_disabled(task) ||
> -                                    !task_on_rq_queued(task))) {
> +                                    (task->dl.dl_throttled &&
> +                                      (task_rq(task) != rq ||
> +                                       task_on_cpu(rq, task) ||
> +                                       !dl_task(task)
> +                                       !task_on_rq_queued(task))) ||
> +                                    (!task->dl.dl_throttled &&
> +                                      task != pick_next_pushable_dl_task(rq)))) {
>                                 double_unlock_balance(rq, later_rq);
>                                 later_rq = NULL;
>                                 break;
>  
> Let me know your thoughts and I can send v2 patch accordingly.

So, it looks definitely more complicated (and fragile?), but I think I
still like it better. Maybe you could add a comment in the code
documenting the two different paths and the associated checks, so that we
don't forget. :)

What do others think?

Thanks!
Juri


