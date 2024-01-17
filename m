Return-Path: <stable+bounces-11817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D231B82FFE2
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 06:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E121B2518D
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 05:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A666747C;
	Wed, 17 Jan 2024 05:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="liv4cjmy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B957465;
	Wed, 17 Jan 2024 05:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705469940; cv=none; b=LlJt2O2jjLhQIqczzW2N04znEexafvW7VGJuc3jilvbIakVOFvP+4AayR+N8FXR6APSr7UH3X2VvJ5IaaZZuNjggPax0CdKWHt98QLdEwRIg+4WSnEa42s1QnfApN/Pj18Y1yMZG/FsKJ7LxgFYPT5YCyz8dpno7FSJLZVlRZY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705469940; c=relaxed/simple;
	bh=VmBEzt7GK0GHLsuyZ5vjXQma5EN6cK975TMTB3zN0hk=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=g4cKiNTgun1H4ICel9lXye+3TgfFlB0udm3ydFajCx3rVfsBafZh7b/llKBxG9zecahQp8U83NMJpSpG8zE+eDymxLXS+7oCrzWFuV15XZpK+7F+Ut/8svsDvWTHNmObqwsap0BXv3JGZa3CjxlulyJw+y92U9LV+WUTxwwwQ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=liv4cjmy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8DCC433F1;
	Wed, 17 Jan 2024 05:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705469940;
	bh=VmBEzt7GK0GHLsuyZ5vjXQma5EN6cK975TMTB3zN0hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=liv4cjmyUMhpl/xoLpB84lL4KdyuoiJhA2+1LXSrdYJJSYOHZtnLup+6eiC62oKxc
	 p3apNm5jCpUDsYcWpb63FB/o4TrUPNycXMyV3IqkOWuVRdreXfEfGQEPayi/AvLIX8
	 U2ZgBkg49eKyrgA44G12MgyCqAiSUYp6haFZ68vY=
Date: Wed, 17 Jan 2024 06:38:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Serge SIMON <serge.simon@gmail.com>
Cc: linux-sound@vger.kernel.org, stable@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: S/PDIF not detected anymore / regression on recent kernel 6.7 ?
Message-ID: <2024011723-freeness-caviar-774c@gregkh>
References: <CAMBK1_QFuLQBp1apHD7=FnJo=RWE532=jMwfo=nkkGFSzJaD-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMBK1_QFuLQBp1apHD7=FnJo=RWE532=jMwfo=nkkGFSzJaD-A@mail.gmail.com>

On Tue, Jan 16, 2024 at 09:49:59PM +0100, Serge SIMON wrote:
> Dear Kernel maintainers,
> 
> I think i'm encountering (for the first time in years !) a regression
> with the "6.7.arch3-1" kernel (whereas no issues with
> "6.6.10.arch1-1", on which i reverted).
> 
> I'm running a (up-to-date, and non-LTS) ARCHLINUX desktop, on a ASUS
> B560-I motherboard, with 3 monitors (attached to a 4-HDMI outputs
> card), plus an audio S/PDIF optic output at motherboard level.
> 
> With the latest kernel, the S/PIDF optic output of the motherboard is
> NOT detected anymore (and i haven't been able to see / find anything
> in the logs at quick glance, neither journalctl -xe nor dmesg).
> 
> Once reverted to 6.6.10, everything is fine again.
> 
> For example, in a working situation (6.6.10), i have :
> 
> cat /proc/asound/pcm
> 00-00: ALC1220 Analog : ALC1220 Analog : playback 1 : capture 1
> 00-01: ALC1220 Digital : ALC1220 Digital : playback 1
> 00-02: ALC1220 Alt Analog : ALC1220 Alt Analog : capture 1
> 01-03: HDMI 0 : HDMI 0 : playback 1
> 01-07: HDMI 1 : HDMI 1 : playback 1
> 01-08: HDMI 2 : HDMI 2 : playback 1
> 01-09: HDMI 3 : HDMI 3 : playback 1
> 
> Whereas while on the latest 6.7 kernel, i only had the 4 HDMI lines
> (linked to a NVIDIA T600 card, with 4 HDMI outputs) and not the three
> first ones (attached to the motherboard).
> 
> (of course i did several tests with 6.7, reboot, ... without any changes)
> 
> Any idea ?

As this is a sound issue, perhaps send this to the
linux-sound@vger.kernel.org mailing list (now added).

Any chance you can do a 'git bisect' between 6.6 and 6.7 to track down
the issue?  Or maybe the sound developers have some things to ask about
as there are loads of debugging knobs in sound...

thanks,

greg k-h

