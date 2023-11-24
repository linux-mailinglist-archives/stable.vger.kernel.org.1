Return-Path: <stable+bounces-306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E91E7F789A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 17:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 613581C20963
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 16:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC85031757;
	Fri, 24 Nov 2023 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p84uPcT4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F94E3309A
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 16:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6733C433C7;
	Fri, 24 Nov 2023 16:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700842210;
	bh=vAd5Ipnhj5G6QGbC7nChe4O94O/O553hFTi5aidy5x8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p84uPcT4GuaqJXij289HKnywZ63iaUrK9FgZxyi+fnJ5K9V1rEq0v7wFr+N66flHt
	 qcDbgxSQ+6Xb7WWfGyr+kwMFUUMe+gixrYfeLzeT4cCYsEfwQMbnO3pH3lSCFq/WtL
	 N5t7Ez33quQOpqVgqPiXj5i3sRJgRcVhcDw/bzaM=
Date: Fri, 24 Nov 2023 16:10:07 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Ronald Monthero <debug.penguin32@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: Backport submission - rcu: Avoid tracing a few functions
 executed in stop machine
Message-ID: <2023112431-matching-imperfect-1b76@gregkh>
References: <CALk6Uxo5ymxu_P_7=LnLZwTgjYbrdE7gzwyeQVxeR431SPuxyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALk6Uxo5ymxu_P_7=LnLZwTgjYbrdE7gzwyeQVxeR431SPuxyw@mail.gmail.com>

On Tue, Nov 21, 2023 at 12:09:38AM +1000, Ronald Monthero wrote:
> Dear stable maintainers,
> I like to indicate the oops encountered and request the below patch to
> be backported to v 5.15. The fix is important to avoid recurring oops
> in context of rcu detected stalls.
> 
> subject: rcu: Avoid tracing a few functions executed in stop machine
> commit  48f8070f5dd8
> Target kernel version   v 5.15
> Reason for Application: To avoid oops due to rcu_prempt detect stalls
> on cpus/tasks
> 
> Environment and oops context: Issue was observed in my environment on
> 5.15.193 kernel (arm platform). The patch is helpful to avoid the
> below oops indicated in [1] and [2]

As the patch does not apply cleanly, we need a working and tested
backport so we know to apply the correct version.

Can you please provide that as you've obviously already done this?

thanks,

greg k-h

