Return-Path: <stable+bounces-36048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8A7899967
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 11:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D5491C212A4
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 09:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E11B15FCF1;
	Fri,  5 Apr 2024 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qs1iWhXX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160F615FCEA
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712309257; cv=none; b=M9of6RfjWjbYtYbYj6msjsLoZx4LCB6DwY+BDCdhpALFHgGZAzy5GMvmmuLj1H+Rj0dYtVYH/o2tlpsfSV1bjbGUYtP7DF85QCs66cMkg25EaylJdCnx0iDIwUKs+0XcZoGwInMrdJc+pi6elkVqbKqLOQSmybnQZ9aNE2cTSZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712309257; c=relaxed/simple;
	bh=bLvtVQ4vKUOiitFFYHiS8AClUAzmTFTBemqFFiQTmEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuJifdksnW71hmekBehDSBwUm3VZlTuWEj8HcxTA5e6B+hDSbe11llIrtxz6bu7yL+Hisfsl3uG7HLCO5OZjslJcUoB6lnal6PAOQsjt14k4ymVW/WdPN2GT+QM0qJ4M+UPFj1axehR1QOs0ZOgrpcYWjRCz4bvZ3EPiKgGP+dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qs1iWhXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37282C433C7;
	Fri,  5 Apr 2024 09:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712309256;
	bh=bLvtVQ4vKUOiitFFYHiS8AClUAzmTFTBemqFFiQTmEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qs1iWhXXtsbJACsfRPSo6csVSCuAYP5EpyWF3jzbaK28tTH9Xm/iG5Doy4LpOj4Bg
	 x/JMOxs8MbrWmPdlZV5JRrw3xMjXrIIeM7kEEkgFkOjPwtbLDtSAcj7lQ7Sox70I5f
	 CnXhikPCQ+VyOtUqxnda5/UhpstQ/FN9ndFUIdDg=
Date: Fri, 5 Apr 2024 11:27:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mahmoud Adam <mngyadam@amazon.com>
Cc: Amir Goldstein <amir73il@gmail.com>, stable@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Leah Rumancik <lrumancik@google.com>
Subject: Re: [PATCH 6.1 0/6] backport xfs fix patches reported by
 xfs/179/270/557/606
Message-ID: <2024040512-selected-prognosis-88a0@gregkh>
References: <20240403125949.33676-1-mngyadam@amazon.com>
 <20240403181834.GA6414@frogsfrogsfrogs>
 <CAOQ4uxjFxVXga5tmJ0YvQ-rQdRhoG89r5yzwh7NAjLQTNKDQFw@mail.gmail.com>
 <lrkyqh6ghcwuq.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <lrkyqh6ghcwuq.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>

On Thu, Apr 04, 2024 at 11:15:25AM +0200, Mahmoud Adam wrote:
> Amir Goldstein <amir73il@gmail.com> writes:
> 
> > On Wed, Apr 3, 2024 at 9:18 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >> To the group: Who's the appropriate person to handle these?
> >>
> >> Mahmoud: If the answer to the above is "???" or silence, would you be
> >> willing to take on stable testing and maintenance?
> 
> Probably there is an answer now :). But Yes, I'm okay with doing that,
> Xfstests is already part for our nightly 6.1 testing.
> 
> >
> > Mahmoud,
> >
> > I assume that you are running xfstests on LTS kernels regularly?
> > In that case, you should have an established baseline for failing/passing
> > tests on 6.1.y.
> > Did you run these backports against all tests to verify no regressions?
> > If you did - then please include this information (also which xfs configurations
> > were tested) in the posting of backport candidates to xfs list.
> 
> Yes, I did run the full xfstests to confirm no regression. we do
> regularly run the latest stable xfstests version with loopback
> setup. and we run 'xfs/quick' group over x86_64 & arm64 to catch any
> regression. I'll make sure to post to xfs list first next time :)
> 
> our setup looks similar to this:
> 
> sudo fallocate -l 5G $MOUNT_POINT/block-xfs.img
> sudo mkfs.xfs -f -m reflink=1 $MOUNT_POINT/block-xfs.img
> sudo losetup -f $MOUNT_POINT/block-xfs.img
> sudo mkdir -p $MOUNT_POINT/test
> sudo mount /dev/loop0 $MOUNT_POINT/test
> 
> sudo fallocate -l 5G $MOUNT_POINT/block-xfs-scratch.img
> sudo losetup -f $MOUNT_POINT/block-xfs-scratch.img
> 
> local.config:
>     export DISABLE_UDF_TEST=1
>     export TEST_DEV=/dev/loop0
>     export TEST_DIR=$MOUNT_POINT/test
>     export SCRATCH_MNT=$MOUNT_POINT/scratch
>     export SCRATCH_DEV=/dev/loop1

So does this mean we should take these for stable inclusion, or are they
going to need some other tests/acks for us to be able to do this?

thanks,

greg k-h

