Return-Path: <stable+bounces-109396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F89A152E2
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 16:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2B4F1881601
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 15:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB3C19882F;
	Fri, 17 Jan 2025 15:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LXD/OzzO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBB7194C61
	for <stable@vger.kernel.org>; Fri, 17 Jan 2025 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737127810; cv=none; b=YKOM63jZkm4bXtSH//1xf2Ub0pLB6SpFClEtY+UJk7R/qg4hc5pu6jcF9ULIiF2oAUoZLAB7gbbG1t+i1yY6AdINymQKkVTf4EPTusXZyfNiGR1YMKgVsNI2koTN5ZwbdxVWQ2nPpZwByWeJlu6EhMIGNbZ4SA5PJ8CHs4cUocE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737127810; c=relaxed/simple;
	bh=uuSs7NkbOPTV/6yYazPnve2zh8oXn2vhyyl6G4ErXgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGNuB3Zc7sRb0Pec18v/gBWpel/s+llHz0gAiFM0/OTcSlSRft0S2uNZeiAt/MUGMANG5mHz7wZyqUOO1WQdbW6TuJaa0PvWd1xdK4s6j37od6SjIB6pO0h1Ku74S7z6OxCI92ARu9xwSTzY93lTjqdeQdjDUa7pn/o5AlxHaCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=LXD/OzzO; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso2500545f8f.2
        for <stable@vger.kernel.org>; Fri, 17 Jan 2025 07:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1737127805; x=1737732605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PMN0xxHnTn7/r6lyp4MJCux5tDpWjt3j/fmoD58AMqk=;
        b=LXD/OzzOgBJ49Wxuo9wiLFROK+vbBTMeYP4oJrfd6Js8H4txeOyDiLV8+4tjpyTfCZ
         5vq6hCJY6yOR0aDtGRjGYtHnAXiE/VtTuTv0owJaBYLMSmulf/gxRX3JMG3ufccYaR0L
         2pyoa/yYdYQhmx6uSsiYOEkWKpYUKpYSyrhao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737127805; x=1737732605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMN0xxHnTn7/r6lyp4MJCux5tDpWjt3j/fmoD58AMqk=;
        b=CGY0sJ4G85NO36ddOWwIVErCV6ZLdM1nzewjkAW4C7cX4UnKKC74nJ09T+DXOxSbUE
         zwl9ZVj8GRyM+OCxAaB6Mfxn5lXUnoiDvNjuGJtwvMAbTYeUJHnimsNAOwtyoz4ly8yF
         3Z33LZ0/640ZNzIlAe+6EuqVN6gnAM5qRr2vyheKvCnCwc+OyJR3vJSwqfUjW/nDKBUP
         Zx5R4vjuKLWH9u+gLG+k6nKJ91wA4T3Fse9pZ7jdD41NNazntKh9jJ3QYvg73vpQ7eIx
         uFly8y33TBmb1R7OYIeifnTXwn34YboiIkVaLupV8dO6DzjzjOKApZY7Xtq8g7/5JM7t
         dtyA==
X-Gm-Message-State: AOJu0YyP5mysgzM6glMlaIBf+wOD295UNNe48jBbNPmXPQ72a8FLAr0y
	tLF2cCxO2ckMLaXBEbS3n0Ccg+nmRAjxqEw9ibvdizTzmJ6yxJXRK733h9qq3a8=
X-Gm-Gg: ASbGncu76ocRHdmwfKTOaSAUdXNaI8/VyPPrQJee8P5TPhD0vj2jax7NEccMxSM4YEs
	M9ktrVj7+P8oAKBj/CGRDv9ulblysUweqSLB3C+s1C5v12ewR8IRsGHeMEJ7fpS1P5IL+eHhDml
	CYtFfvMDYLh2dHJ/j2XFqZXKt7GdBaliUncVqvmgIaXuseRtL+YvPpi6vikBFYC+nrpdFBlcqhZ
	9puWBM0etBtGR1NucwP3K8jp5vKA/93ZEUWIzOBKwe89kPdvWp3VdhFqGiJkkliK7sO
X-Google-Smtp-Source: AGHT+IERWF8sIS1dMqT5AGGWertem30EsWZljTh6nQHb58gskcBklmaUmoaA8cvAXYwGl9KdHnRWXA==
X-Received: by 2002:a05:6000:1f8d:b0:385:d7f9:f157 with SMTP id ffacd0b85a97d-38bf57a749dmr3470574f8f.36.1737127805618;
        Fri, 17 Jan 2025 07:30:05 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3221b7fsm2764368f8f.27.2025.01.17.07.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 07:30:05 -0800 (PST)
Date: Fri, 17 Jan 2025 16:30:03 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>,
	"oushixiong@kylinos.cn" <oushixiong@kylinos.cn>,
	"Koenig, Christian" <Christian.Koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: Patch "drm/radeon: Delay Connector detecting when HPD singals is
 unstable" has been added to the 6.6-stable tree
Message-ID: <Z4p3e44qS7uP2Y_Q@phenom.ffwll.local>
References: <20250103004210.471570-1-sashal@kernel.org>
 <BL1PR12MB5144226AD0D6697DBF25ED56F7122@BL1PR12MB5144.namprd12.prod.outlook.com>
 <Z4pzIzRg2xpYv2mJ@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4pzIzRg2xpYv2mJ@phenom.ffwll.local>
X-Operating-System: Linux phenom 6.12.3-amd64 

On Fri, Jan 17, 2025 at 04:11:31PM +0100, Simona Vetter wrote:
> On Wed, Jan 08, 2025 at 12:02:03AM +0000, Deucher, Alexander wrote:
> > [Public]
> > 
> > > -----Original Message-----
> > > From: Sasha Levin <sashal@kernel.org>
> > > Sent: Thursday, January 2, 2025 7:42 PM
> > > To: stable-commits@vger.kernel.org; oushixiong@kylinos.cn
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > > <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David Airlie
> > > <airlied@gmail.com>; Simona Vetter <simona@ffwll.ch>
> > > Subject: Patch "drm/radeon: Delay Connector detecting when HPD singals is
> > > unstable" has been added to the 6.6-stable tree
> > >
> > > This is a note to let you know that I've just added the patch titled
> > >
> > >     drm/radeon: Delay Connector detecting when HPD singals is unstable
> > >
> > > to the 6.6-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > >
> > > The filename of the patch is:
> > >      drm-radeon-delay-connector-detecting-when-hpd-singal.patch
> > > and it can be found in the queue-6.6 subdirectory.
> > >
> > > If you, or anyone else, feels it should not be added to the stable tree, please let
> > > <stable@vger.kernel.org> know about it.
> > >
> > >
> > >
> > > commit 20430c3e75a06c4736598de02404f768653d953a
> > > Author: Shixiong Ou <oushixiong@kylinos.cn>
> > > Date:   Thu May 9 16:57:58 2024 +0800
> > >
> > >     drm/radeon: Delay Connector detecting when HPD singals is unstable
> > >
> > >     [ Upstream commit 949658cb9b69ab9d22a42a662b2fdc7085689ed8 ]
> > >
> > >     In some causes, HPD signals will jitter when plugging in
> > >     or unplugging HDMI.
> > >
> > >     Rescheduling the hotplug work for a second when EDID may still be
> > >     readable but HDP is disconnected, and fixes this issue.
> > >
> > >     Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> > >     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > >     Stable-dep-of: 979bfe291b5b ("Revert "drm/radeon: Delay Connector detecting
> > > when HPD singals is unstable"")
> > 
> > 
> > Please drop both of these patches.  There is no need to pull back a
> > patch just so that you can apply the revert.
> 
> Since we've just been discussing stable backports at length, how did this
> one happen?
> 
> 949658cb9b69ab9d22a42a662b2fdc7085689ed8 is in v6.11 and 979bfe291b5b in
> v6.13-rc1, so there's definitely a need to backport the latter to v6.11.y
> and v6.12.y. And maybe there was a cherry-pick of 949658cb9b69ab9d22a42a66
> to older stable releases already, but that doesn't seem to be the case. So
> what happened here?

Some other examples people brought up:

https://lore.kernel.org/stable/a31d3d49-1861-19a2-2bb4-8793c8eabee9@mailbox.org/

https://lore.kernel.org/stable/a31d3d49-1861-19a2-2bb4-8793c8eabee9@mailbox.org/

-Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

