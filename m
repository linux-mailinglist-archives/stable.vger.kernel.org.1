Return-Path: <stable+bounces-47523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C728D1168
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 03:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D07D4B20D66
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 01:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC959525E;
	Tue, 28 May 2024 01:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOch9BbZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85704BE40;
	Tue, 28 May 2024 01:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716859444; cv=none; b=PvP1H62Kds9X2nG+wi+eqATqHRfrYUIk0Y76W85fCwF00LL+HOnWQDa7X+kP7Y1we648E+WD5Iaa9pfnieZPeR4P6nJOHkNnhi5fzgxtisIniS4/RSz9B2dtDl9QhIk7sEmPnq+Pi6PdF12m1ajsVCXKMKOC4ejBTvwkMp18N0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716859444; c=relaxed/simple;
	bh=bh1toJKYzRYSq5Vs19qY+4H7xmdzT5pppXUEGALRUSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ryd3LOy8edKcTrATdNPAuw5yo5Ipuim0e6rGpIhAF7UIVRApOa0i3ovo8pJKqd5pTiKY4SGzX+UL2qi8hfhP3uLLC88sGYAo+bqxvaLkGtTlE6YaESkzXdTIwUke1C84LKgGWB5m5CrarRJXyjU4xJMzT6BSE26y6edbvUbrZhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uOch9BbZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2608C2BBFC;
	Tue, 28 May 2024 01:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716859444;
	bh=bh1toJKYzRYSq5Vs19qY+4H7xmdzT5pppXUEGALRUSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uOch9BbZrmeVYGsEszzs5M73zW/+hDlQeVbQjZKRvlfpxzKQ6ztq194HldtKHxGRg
	 FbaGMuESfWhJaTbGRpeS3WEDXfu56EBmaN0NlLYPk3VccwgKeT6F16Afrryee4xJaj
	 NsH6+2hdKVTHIWHwfwvYmPZ885tBH2GepMrQKECL/Q5Kx3ExLoSR54nbR4SMaWkZvc
	 UTQ9xIoU6vZAVi6nzetAlYldc5JBGRarp26qN0/y774TIOcoYb5/glehGnvMha1RIA
	 YlD3rGqtQsBfIXPC0EqsW6khZmhBNsM7gMj2xN21I2beJXoWvbSFQP20owlQTLL9Mx
	 jJDyXtBJADzMQ==
Date: Tue, 28 May 2024 01:24:02 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Gustavo Brondani Schenkel <gustavo.schenkel@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: Issue with f2fs on kernel 6.9.x
Message-ID: <ZlUyMr0FwaT69vgO@google.com>
References: <2024052527-panama-playgroup-899a@gregkh>
 <bf02d65d-876f-4a90-84b5-595707659fb0@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf02d65d-876f-4a90-84b5-595707659fb0@gmail.com>

Hi,

We're aware of this issue, and the potential fix [1] was merged in 6.9.3-rc1 in
https://lore.kernel.org/stable/ZlT506xwTYWg72Jj@duo.ucw.cz/T/#t

Could you please check that patch addresses your problem?

[1] https://lore.kernel.org/stable/ZlT506xwTYWg72Jj@duo.ucw.cz/T/#mfd878849ed6dd660ca22aec9ca1a8eb31bc11f0c

Thanks,

On 05/27, Gustavo Brondani Schenkel wrote:
> Hi,
> since upgrade to Kernel 6.9 I am getting Issues when booting using f2fs.
> If I am correct, I am receiving `fs error: invalid_blkaddr` in two distinct
> drives, one nvme, and other sata.
> Each reboot the fsck runs to correct this suppose error.
> If I downgrade to Kernel 6.6.29, on the first boot, fsck runs just once,
> than after reboot is normal.
> I used 6.9.0, but in 6.9.1 it took my attention because I don't reboot
> often. One 6.9.2 the Issue persist.
> Since I didn't find nothing about issues on kernel messages I am trying
> reach you.
> 
> I use Slackware Linux 15.0-current, and debug flags are disabled by default,
> but if you needed,
> I can rebuilt the kernel with the flags you say are needed, to find what are
> happening.
> 
> PS: I didn't find any better way to report this issue, said that, sorry if
> this is the wrong way to do so.
> 
> -- 
> Gustavo B. Schenkel
> System Analyst
> B.Sc(IT), MBA(Banking)
> 

