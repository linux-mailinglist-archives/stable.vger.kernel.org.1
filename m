Return-Path: <stable+bounces-23468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D66386124D
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 14:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CEB7B23405
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 13:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844757CF2E;
	Fri, 23 Feb 2024 13:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vf1Qjglw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437A17C6D4
	for <stable@vger.kernel.org>; Fri, 23 Feb 2024 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693872; cv=none; b=pGdDIlpOI/ogFHfFlacr8PMzigaBGvHjAYKK7K8F4S4SHP+GBjkgmxsbO2MGxka/tM/GikIcz+Gp2ftv+p1Jh7jD2FHEe4XqHmTXWuX7IWkhVr3EkBBIiXIyJHlps2Gf4fef9vR2m1JE5shII6G/OwTEIQxEc1D86q5L+90Pl8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693872; c=relaxed/simple;
	bh=ZJvY371YffSf2xsBlsR6B6fXB+N0MacHdviZrdIDwjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEnrbPN7CHCJAl4dI8SdgaoZBuYNDrOGni222ldbJDIT9UVyGkLl2OdYIqP1M84k0ysp9DY1pWSfmyAmSjiCqiThyspnStYPXe+9ErwXnydoV2iju40WpECY5MfMavr02FNvC625EtEZDI/zd7jwlehndVjll3h82ebHpjvnqf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vf1Qjglw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C12C433C7;
	Fri, 23 Feb 2024 13:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708693871;
	bh=ZJvY371YffSf2xsBlsR6B6fXB+N0MacHdviZrdIDwjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vf1QjglwTOBAxrhe870nAbw7KTS8vLs3aPyUJQqkiT9kCGN34AMFjQRPJktJ+Scz8
	 WYgdXJXrKgLEQGFA19ti4A57pbqfI6M5E57A0dl3S8YoeZowgcx61zPYybCyhcD5vu
	 l5dXJ7LvabYmGDqGZ8c70aKya4aA0vFWQ7BX6qPk=
Date: Fri, 23 Feb 2024 14:11:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mahmoud Adam <mngyadam@amazon.com>
Cc: stable@vger.kernel.org
Subject: Re: backport sched_rt_period_us and sysctl_sched_rr_timeslice
 invalid values fixes
Message-ID: <2024022302-flaxseed-tag-5279@gregkh>
References: <lrkyqo7chg8kh.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lrkyqo7chg8kh.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>

On Thu, Feb 15, 2024 at 02:29:02PM +0100, Mahmoud Adam wrote:
> 
> Hi,
> 
> The commit `c1fc6484e1fb sched/rt: sysctl_sched_rr_timeslice show
> default timeslice after reset` is a clean cherry-pick for v5.4+ kernels
> 
> and the commit `079be8fc6309 sched/rt: sysctl_sched_rr_timeslice show
> default timeslice after reset` cleanly applicable for v6.1
> 
> These are trivial fixes which fix the parsing the negative values when
> read from the userspace, but will also make LTP test `proc_sched_rt01.c`
> happy instead of ignoring it.

All now queued up, thanks.

greg k-h

