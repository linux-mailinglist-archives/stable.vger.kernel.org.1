Return-Path: <stable+bounces-142115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09730AAE810
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 19:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FB4A521D0B
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 17:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE5428C5D2;
	Wed,  7 May 2025 17:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="qQWfHwxB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9F71B87D5
	for <stable@vger.kernel.org>; Wed,  7 May 2025 17:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746639790; cv=none; b=tmbonBollLbzL63+AhqLMXYPzdHArcI4/Gio58fBZmkQX6DH++HKpgD5io9jmEYso+Vcdrs2RSvvbEnwHk5+pFLyiqTMycrFMX+OR1eqkJB4gEF7yO9B4o7tZWpfSNOP8s9XJhhK5DnZHxVJHakD7wiJMXFKbBvWWQQPsGBtT7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746639790; c=relaxed/simple;
	bh=DOQ3fPkTGtVwPh7S8hPxEgsaEuP90mc8DIEtOpcrtOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7gQCQ+M6qVyBkaiQf46aGuHEySGe0QPvNeD7QIrkHX6I23Sk3i3D/3ks9b38Xk0jYb+NyzOr+MUGD0P2CuIEnxgd8AwiJYQk1Xutr72AConFQOSY4ERYKKKEm5zf+jze5vJ0VmY5H3xdPmlJFTm+qIhvNwFtjUJrwIMYLYY2ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=qQWfHwxB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22de5af5e14so204615ad.1
        for <stable@vger.kernel.org>; Wed, 07 May 2025 10:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1746639788; x=1747244588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rl0H2iR/SnugHTVu/jGXkIv241LQtPIB5UJqW+ObFoA=;
        b=qQWfHwxB8/T/+V9gyXdcj3ifdB7pHJh2qhBNiw3p/4QQ4fZHLpkHhmpBpBQnxegPDl
         hdtUkWCux+J/n5wsE+bvP8y9dwFD/U/2rfvJCN/dO1gbCe7rtgqJjc14Vw5CoC4TbRYc
         PEyTOQ6Olt5/7qrwvlekMIlaM74xOeWEuH1nsT40cgQ+BNDocobClAmI1C66AmjmLk9a
         vg2VcJOtvwkkFEpwIekN/q4E++IuJPd4A5Sa9r7oG8Nga065K3F+gFJNLvUhjcnJqZzA
         0LO9X9M8CcizTFN+42SYsggaoUEO/Qss1WCtS83xSKHQjPZo+GvT0n5GTe4Z1fvCBpgw
         WKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746639788; x=1747244588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rl0H2iR/SnugHTVu/jGXkIv241LQtPIB5UJqW+ObFoA=;
        b=SoyDxxHAW9am6tkrV8X2mqldDzeaoBkgBUsYwlFzohc6AZSZ3r1mOzXVyVdFD0tgew
         94pCbwfD6hoNLocYoiaRyEGUL6kEDW/DZJGvTLD8k1LIXCRoJro+GHUEiTQ5XdX1rf2a
         NqF566pnEIH0T0lw2eIE3woj2HOVhroR4cfyDXXVJtGPonNhLBbyeJFRE3rF5sz2ArIS
         /KSiYYeU8OYniMosRtjACyFV3ixyWPm0hX7fDjDfPtY5G0p/ukJW0OIh2r6lpj6zDsj7
         hFK2SRTGXqrehxjQFhNtaxhHfA6Aar8yRZ/RMzSwrIsYms8iCifnrBhts4PSn+deh1j6
         k/5w==
X-Gm-Message-State: AOJu0YzKWlq0EStWDn2Blf08ZI6fADywhcrZHrOGTKu3D3fb8R2p+keK
	F7Bu6E2FAf+j+oBMu2xd0d146louirkH7Ez+2pbfvxiV9pNep4Y+BcxrlVnjBDqGWYgzqNdwIvB
	h
X-Gm-Gg: ASbGncu1SVC75SGWK+aoVU8Plr4IAU86wGke+mKOZhtfguDoSMt3WtDNm7thpsplZVd
	RVHJmjX6jgaP3t/hC51Lqc7rAK4X8Y4kGZns/wM6eCDdIJTvwNLKq+oIypYpB/uAR3Gvo4nEfY8
	KU8xTNmmOruBHWPAK0G4YZD7PRSsTblpxRgF3lLjvCcM0AQu6pAZZiO+Xk0cgv99kQVeKxwPZtM
	8lojNqKRjsiN5BbGI4po0fkxHkU9BRzHCH3cpipIaEjuLACqOUNjcfy1M9IbAp2JtkWVS8iUTh7
	H/XY3tvnU7d+sKF4/jGNJUY=
X-Google-Smtp-Source: AGHT+IG6AxXo+9sgAJAUeVFr6UfrJVjrGlAFg7c/bKd9M9Iu1T876QFThEe/3tYLHzn264Vso+4UNw==
X-Received: by 2002:a17:903:28f:b0:224:1005:7281 with SMTP id d9443c01a7336-22e5ea7b7d6mr20810065ad.7.1746639787581;
        Wed, 07 May 2025 10:43:07 -0700 (PDT)
Received: from telecaster ([2620:10d:c090:400::5:2b0b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e5b7e2238sm23520375ad.48.2025.05.07.10.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 10:43:07 -0700 (PDT)
Date: Wed, 7 May 2025 10:43:05 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Omar Sandoval <osandov@fb.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14 102/311] sched/eevdf: Fix se->slice being set to
 U64_MAX and resulting crash
Message-ID: <aBubqcsiWmEK0NRg@telecaster>
References: <20250429161121.011111832@linuxfoundation.org>
 <20250429161125.215831187@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429161125.215831187@linuxfoundation.org>

On Tue, Apr 29, 2025 at 06:38:59PM +0200, Greg Kroah-Hartman wrote:
> 6.14-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Omar Sandoval <osandov@fb.com>
> 
> [ Upstream commit bbce3de72be56e4b5f68924b7da9630cc89aa1a8 ]
> 
> There is a code path in dequeue_entities() that can set the slice of a
> sched_entity to U64_MAX, which sometimes results in a crash.
> 
> The offending case is when dequeue_entities() is called to dequeue a
> delayed group entity, and then the entity's parent's dequeue is delayed.
> In that case:
> 
> 1. In the if (entity_is_task(se)) else block at the beginning of
>    dequeue_entities(), slice is set to
>    cfs_rq_min_slice(group_cfs_rq(se)). If the entity was delayed, then
>    it has no queued tasks, so cfs_rq_min_slice() returns U64_MAX.
> 2. The first for_each_sched_entity() loop dequeues the entity.
> 3. If the entity was its parent's only child, then the next iteration
>    tries to dequeue the parent.
> 4. If the parent's dequeue needs to be delayed, then it breaks from the
>    first for_each_sched_entity() loop _without updating slice_.
> 5. The second for_each_sched_entity() loop sets the parent's ->slice to
>    the saved slice, which is still U64_MAX.
> 
> This throws off subsequent calculations with potentially catastrophic
> results. A manifestation we saw in production was:
> 
> 6. In update_entity_lag(), se->slice is used to calculate limit, which
>    ends up as a huge negative number.
> 7. limit is used in se->vlag = clamp(vlag, -limit, limit). Because limit
>    is negative, vlag > limit, so se->vlag is set to the same huge
>    negative number.
> 8. In place_entity(), se->vlag is scaled, which overflows and results in
>    another huge (positive or negative) number.
> 9. The adjusted lag is subtracted from se->vruntime, which increases or
>    decreases se->vruntime by a huge number.
> 10. pick_eevdf() calls entity_eligible()/vruntime_eligible(), which
>     incorrectly returns false because the vruntime is so far from the
>     other vruntimes on the queue, causing the
>     (vruntime - cfs_rq->min_vruntime) * load calulation to overflow.
> 11. Nothing appears to be eligible, so pick_eevdf() returns NULL.
> 12. pick_next_entity() tries to dereference the return value of
>     pick_eevdf() and crashes.
> 
> Dumping the cfs_rq states from the core dumps with drgn showed tell-tale
> huge vruntime ranges and bogus vlag values, and I also traced se->slice
> being set to U64_MAX on live systems (which was usually "benign" since
> the rest of the runqueue needed to be in a particular state to crash).
> 
> Fix it in dequeue_entities() by always setting slice from the first
> non-empty cfs_rq.
> 
> Fixes: aef6987d8954 ("sched/eevdf: Propagate min_slice up the cgroup hierarchy")
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Link: https://lkml.kernel.org/r/f0c2d1072be229e1bdddc73c0703919a8b00c652.1745570998.git.osandov@fb.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  kernel/sched/fair.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Hi,

I believe this fix should go in 6.12, too.

Thanks,
Omar

