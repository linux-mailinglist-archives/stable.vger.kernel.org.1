Return-Path: <stable+bounces-103150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D609EF552
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36D3D2912A0
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5885C22332E;
	Thu, 12 Dec 2024 17:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2VAQ1OAw"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B174222D58
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023696; cv=none; b=Lwcsu/vtQUjV5jtCuaBsYmSvuz0BW1bil7z9mUDVOmOJVI7vxcfS7pdo0vYmvUbrPz+3138fnHUbH78jDRCQabEyrqAPGTEyOaS5jMlVSoKehz4svabY3t4DCaa+VTxrx5CSPygrAuIkUiybHZ3ruYbG3LXfpFKCt140CkTjNn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023696; c=relaxed/simple;
	bh=3VhHoxhtsIYlY9delcNaANiN7hnym9vuOfGY5s9r26Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZpU95KAm3b4DKmBn6N4VExhXgrqKHdBpXehgWxugpZ2+dJ3KzndZc43eWBOX99rQeMNmjwQbBeW6w+nVNQj/wNwgUGv9tJkD0DOK3RgZ0lWYpwPveaFGgZgpZ337GtR72JCxkb9+TSYC4MrdZXbhxDWO9Vhdv66FEvQV+siqZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2VAQ1OAw; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4678c9310afso299751cf.1
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 09:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734023692; x=1734628492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wUN1FGW9s6aYaX1rahb83q8l6+aJSntI9ZnzO5TRvUw=;
        b=2VAQ1OAw1bc3MBS17U0f/2tZvXsavPeWgpMiube6+fGHeX1/hPeuttKMvmZ2Tmk5tC
         KBCVUWzIPEQFZzZVBjOtrx51baDoAUHwzLf1dSVWMQKhFftQFdLYcHm5COIz9obkdQbB
         xaaUweIYtTtO+BgVJqxu8T9JuYmEP9mAdfmlN87IQP6FI8Wtjba/MUjGJ1ddMLRcQX3J
         nNOKHbdv5AS5RQfy6nKJoyidtJQ4KvKv3n7S747jMUFgXYykpPN77B8Ky7sIsium2ZFe
         XhqO1Al/PlnOoVCnTUx2s0d5dyNGxWyCTjERDFbSxeRQvjeDXLbV+ywNbzkiylwI5lLg
         SFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734023692; x=1734628492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUN1FGW9s6aYaX1rahb83q8l6+aJSntI9ZnzO5TRvUw=;
        b=nON874AlivluzHS36sjTas9nEWlNB2sTm11tpVc11WmNSjvpVFyZe0tv+ydmnQYegV
         +k08VtUq2nTJ/RmV/iRtUT8sp5Ng8rPZdPu35Usm7frdIF+8sCINIf5juAxhE2/E+mRt
         dQLWKJF9sJ56wh8PT3bTncn8YpRp1J+40DqefEmB1E7IY8sak4TLZ2xhBgVp/jOPsCa9
         5sLBKUT0gwKa9SQGu4oi0UutYtkuV9zd3dbmbMgWHC7IdF0kOsF/HkVSQylzeU5S9xgT
         OX2vDkAdzHGtcPKY6hhecRCrQvhpPB36vw4dkQamXm6gHG8jCqJucvJtuXjhiasPh5ua
         YjOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDEdv2CFawOjhbKv0TkOgyzxBMxHutkOGmik7UA5uwlnv50B/dffwU0tAX+wTQ0n+09dSlms4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaxeMcFt7lYh2rK5to+eeBwVrLKIhlWdLGGUA9JA4vyhyR0X/M
	zW22mfys/9kruvWI9TcLhc6t50wX6OpjeVohFNIpSOCfcZ0HjPzs9GlT34vHHw==
X-Gm-Gg: ASbGncu38xjQR06ra6tXNdTCgSnFtc8jdR8l5UxyYlFTf6cK3oSePO5LrGVdWtUOnV4
	7xshPGBefNDA9S5angU3MPb4YVXgRk2PxW3iQ35yANX4wUh50XZjiXIKTiXUX+YyM17QRSvbZIv
	SCENIg21lhJggOU3BHtT9SpWLSiO+jyi+GCHglqPTtBNbAJm9aIPtg591RBEwjuxpmLjMFJAEW+
	BNNEGw42II7BUfJGCQDSsJr0DY53SzDkeuFqhULFdl2hIIsJadfHZw2+7cCiZUgJQHjgmZ51Yn5
	R2am2QW/Q6OXyEtVjw==
X-Google-Smtp-Source: AGHT+IGgjH6GqV4jXXmphoAA+pxi/+QUQrcufFJsbeUtuxETjKPMe94758G2fCviij2ZNFYfuwddKA==
X-Received: by 2002:a05:622a:5197:b0:466:8356:8b71 with SMTP id d75a77b69052e-467a10186aemr1322081cf.19.1734023691781;
        Thu, 12 Dec 2024 09:14:51 -0800 (PST)
Received: from google.com (129.177.85.34.bc.googleusercontent.com. [34.85.177.129])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d90299bccesm55849206d6.60.2024.12.12.09.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 09:14:51 -0800 (PST)
Date: Thu, 12 Dec 2024 12:14:44 -0500
From: Brian Geffon <bgeffon@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, jack@suse.cz,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	cmllamas@google.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
	jing.xia@unisoc.com, xuewen.yan94@gmail.com,
	viro@zeniv.linux.org.uk, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	stable@vger.kernel.org, lizeb@google.com
Subject: Re: [RFC PATCH] epoll: Add synchronous wakeup support for
 ep_poll_callback
Message-ID: <Z1saBPCh_oVzbPQy@google.com>
References: <20240426080548.8203-1-xuewen.yan@unisoc.com>
 <20241016-kurieren-intellektuell-50bd02f377e4@brauner>
 <ZxAOgj9RWm4NTl9d@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxAOgj9RWm4NTl9d@google.com>

On Wed, Oct 16, 2024 at 03:05:38PM -0400, Brian Geffon wrote:
> On Wed, Oct 16, 2024 at 03:10:34PM +0200, Christian Brauner wrote:
> > On Fri, 26 Apr 2024 16:05:48 +0800, Xuewen Yan wrote:
> > > Now, the epoll only use wake_up() interface to wake up task.
> > > However, sometimes, there are epoll users which want to use
> > > the synchronous wakeup flag to hint the scheduler, such as
> > > Android binder driver.
> > > So add a wake_up_sync() define, and use the wake_up_sync()
> > > when the sync is true in ep_poll_callback().
> > > 
> > > [...]
> > 
> > Applied to the vfs.misc branch of the vfs/vfs.git tree.
> > Patches in the vfs.misc branch should appear in linux-next soon.
> > 
> > Please report any outstanding bugs that were missed during review in a
> > new review to the original patch series allowing us to drop it.
> > 
> > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > patch has now been applied. If possible patch trailers will be updated.
> > 
> > Note that commit hashes shown below are subject to change due to rebase,
> > trailer updates or similar. If in doubt, please check the listed branch.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > branch: vfs.misc
> 
> This is a bug that's been present for all of time, so I think we should:
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2") 
> Cc: stable@vger.kernel.org

This is in as 900bbaae ("epoll: Add synchronous wakeup support for
ep_poll_callback"). How do maintainers feel about:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org

> 
> I sent a patch which adds a benchmark for nonblocking pipes using epoll:
> https://lore.kernel.org/lkml/20241016190009.866615-1-bgeffon@google.com/
> 
> Using this new benchmark I get the following results without this fix
> and with this fix:
> 
> $ tools/perf/perf bench sched pipe -n
> # Running 'sched/pipe' benchmark:
> # Executed 1000000 pipe operations between two processes
> 
>      Total time: 12.194 [sec]
> 
>       12.194376 usecs/op
>           82005 ops/sec
> 
> 
> $ tools/perf/perf bench sched pipe -n
> # Running 'sched/pipe' benchmark:
> # Executed 1000000 pipe operations between two processes
> 
>      Total time: 9.229 [sec]
> 
>        9.229738 usecs/op
>          108345 ops/sec
> 
> > 
> > [1/1] epoll: Add synchronous wakeup support for ep_poll_callback
> >       https://git.kernel.org/vfs/vfs/c/2ce0e17660a7

Thanks,
Brian


