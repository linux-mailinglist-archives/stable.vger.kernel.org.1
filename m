Return-Path: <stable+bounces-40362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7658AC222
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 01:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254BC1F21602
	for <lists+stable@lfdr.de>; Sun, 21 Apr 2024 23:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33EE45BEC;
	Sun, 21 Apr 2024 23:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ie9g13kS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECD51BC58
	for <stable@vger.kernel.org>; Sun, 21 Apr 2024 23:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713742706; cv=none; b=XrYYmnNSGBqbYBxeD3/23vuS6RjjbF+uC+Es8STH9tU1uZxBQXAl0QN33pbh5YcDa8xhDkAl2AKsnKbaNfe84LBnRu+RwtIZrsgU5H6zR3wMbZFMeTUkmMXdZcL3hXdVZu6g8bYYRxewsB2lZvSz4Nl4ZteJ4prrDxld62Aa6dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713742706; c=relaxed/simple;
	bh=O5arVjkLBTWahy1X3PFULL/K53JHg1o/0nZ6YqqFF30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPXXlxWimzKwDoMTKbaZg9svAT1P2HspnqGa2aKuhHo+X37B6fqe7Agfx5kiV5GeSJ4kVWPvkLhLGcLmZVnG/aGJZKwBsj+ImxulutieAprFYDrvfpi5tH2whQIT9Rhsm8Lhq7uG/xvaLgn0MTSJgYbNBado145efwNlC4ICanU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ie9g13kS; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2abf9305afcso2030900a91.1
        for <stable@vger.kernel.org>; Sun, 21 Apr 2024 16:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1713742704; x=1714347504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J9fmtOuSv2YsL7jumUc7TlcjpbLnbIPa3nVxD/2u34E=;
        b=ie9g13kSpUMKM8rp0Nl0iW99fruUeP1+xvbytSyuCOHtPsnY4g39VEPxnDNC4fA7YH
         AXCE4G+UCB6Nf7TsWLlN/b5DKWnsCKE9txnR+ZmwqFs5xQEBPstVoWmw2Skw9ySvEZDH
         dVYyi48UzbqcjX+tADaQuhRzeAJRvA2WCLiCAmB2w4Sb8G3ujLuDEZMpYoVQTEHiozEH
         WIOxrlXMQi+Rl6UVfnyn0lE2eG7FTThHs8ivDqGX8lUVdKLeXjv0Y6OhoBpiTAB2IvBh
         R9/3DmwBdMe+b8w22j/8ON/4XW7v1nqiPFX2vTmsTCvOjZtkeVet4wHMtmgZ3bss1K7j
         KXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713742704; x=1714347504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9fmtOuSv2YsL7jumUc7TlcjpbLnbIPa3nVxD/2u34E=;
        b=i59VZuCE5qAMLVJxO1Iugv+OQifooin4iDX4mzRtoQOKcacsRHPCwnAmQurBgn0551
         yca06mK/Wt/OL3K5hhuNCGslRAA7gcJK5+slFaCPzS8BiGmJcr6l9WqRjfA/A24PE/rW
         moTZThE+tAz23WL2c2K7KgIGV2usxhwrqOgwmXajmbttO3DO7+hPai2dEpECbjaTZjvk
         Aa2Hz0n8Ru98QK/NcqlQbjRUTLJgnBR4yqbmnSpPmOuU3gbwdbKVFxKh1qaBtASqCUAz
         eXJ0x2hCR11KIhbtoqHyods0GECg0aO1HNJDvLwTVT8ochBYquTyvzQpYVwcbnRib4kI
         BC3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMamLayi4Cz60StdKQyUabOeeErDU2JNsmHeNGI2YxfgQ5atcOmg4p0TWlHwy8cuiPnhrSacc48W6lD7lpisyxFU4101Fl
X-Gm-Message-State: AOJu0Yw/9cxF0ZRI5/5nbZz5pJq7A8jmvH/WjgaxEUJswYbUJiT+gviZ
	ohyyIQK7JNssSHGMOAQaJU4sNNXcLq4nivfSe2f2jZuKGxkrNDyNL6kW2F9GVL0=
X-Google-Smtp-Source: AGHT+IFflpPpAe0XoWuvIuybwyQEFPyPUopFCd2tu29tb8oEPdi8n2MKy8IIebzdcJx7wu4MDg2eiQ==
X-Received: by 2002:a17:90b:88f:b0:2ab:b2d7:860f with SMTP id bj15-20020a17090b088f00b002abb2d7860fmr6477078pjb.6.1713742704491;
        Sun, 21 Apr 2024 16:38:24 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-56-237.pa.nsw.optusnet.com.au. [49.181.56.237])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090a430600b002a2fe0998f0sm8117503pjg.19.2024.04.21.16.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 16:38:23 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1ryglJ-006Jq2-1f;
	Mon, 22 Apr 2024 09:38:21 +1000
Date: Mon, 22 Apr 2024 09:38:21 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-xfs@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] xfs: Add cond_resched to xfs_defer_finish_noroll
Message-ID: <ZiWjbWrD60W/0s/F@dread.disaster.area>
References: <cover.1713674898.git.ritesh.list@gmail.com>
 <0bfaf740a2d10cc846616ae05963491316850c52.1713674899.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bfaf740a2d10cc846616ae05963491316850c52.1713674899.git.ritesh.list@gmail.com>

On Sun, Apr 21, 2024 at 01:19:44PM +0530, Ritesh Harjani (IBM) wrote:
> An async dio write to a sparse file can generate a lot of extents
> and when we unlink this file (using rm), the kernel can be busy in umapping
> and freeing those extents as part of transaction processing.
> Add cond_resched() in xfs_defer_finish_noroll() to avoid soft lockups
> messages. Here is a call trace of such soft lockup.
> 
> watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [rm:81335]
> CPU: 1 PID: 81335 Comm: rm Kdump: loaded Tainted: G             L X    5.14.21-150500.53-default

Can you reproduce this on a current TOT kernel? 5.14 is pretty old,
and this stack trace:

> NIP [c00800001b174768] xfs_extent_busy_trim+0xc0/0x2a0 [xfs]
> LR [c00800001b1746f4] xfs_extent_busy_trim+0x4c/0x2a0 [xfs]
> Call Trace:
>  0xc0000000a8268340 (unreliable)
>  xfs_alloc_compute_aligned+0x5c/0x150 [xfs]
>  xfs_alloc_ag_vextent_size+0x1dc/0x8c0 [xfs]
>  xfs_alloc_ag_vextent+0x17c/0x1c0 [xfs]
>  xfs_alloc_fix_freelist+0x274/0x4b0 [xfs]
>  xfs_free_extent_fix_freelist+0x84/0xe0 [xfs]
>  __xfs_free_extent+0xa0/0x240 [xfs]
>  xfs_trans_free_extent+0x6c/0x140 [xfs]
>  xfs_defer_finish_noroll+0x2b0/0x650 [xfs]
>  xfs_inactive_truncate+0xe8/0x140 [xfs]
>  xfs_fs_destroy_inode+0xdc/0x320 [xfs]
>  destroy_inode+0x6c/0xc0

.... doesn't exist anymore.

xfs_inactive_truncate() is now done from a
background inodegc thread, not directly in destroy_inode().

I also suspect that any sort of cond_resched() should be in the top
layer loop in xfs_bunmapi_range(), not hidden deep in the defer
code. The problem is the number of extents being processed without
yielding, not the time spent processing each individual deferred
work chain to free the extent. Hence the explicit rescheduling
should be at the top level loop where it can be easily explained and
understand, not hidden deep inside the defer chain mechanism....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

