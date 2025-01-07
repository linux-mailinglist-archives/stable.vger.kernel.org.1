Return-Path: <stable+bounces-107788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F192A0351C
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 03:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD461647C6
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 02:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47C180BFF;
	Tue,  7 Jan 2025 02:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JlM8Ymrz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C352BD04;
	Tue,  7 Jan 2025 02:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736216881; cv=none; b=Lc6mY7jTWqEZ3K9DKdFH0o50PduV3PkxBUkf5x+f7ixPWsUeLNul3JX7CkYBu+Y0lDYDM8Wsje0CPMUVyj0s2ctsD9ytVFe0DLi9EPcu4X+rRWcetUxkJpVfsCZpWM70x3MFbwv5gOihegJ7J2WMxrN7jDSTmHonsDmPGMrMFfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736216881; c=relaxed/simple;
	bh=tsxUKdkJiGQjNXwxpYT/yyLQASeROBgDtN9X60CqQkI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XMf4COXZXOdAvHZmuirEGI6A5U7NHhqzsj88g9zA6PXLcRVDIQX04QuYa9SuiC5VgFqpy4xoULc3THv34SVT6IzICXmDMEreJIhSuw3Pduj6fWOwowf+52lkqwCjEV7esR0NlHVEljX9D2vj89/JZ0RoV9hhhfGPNKWk9nZIKKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JlM8Ymrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB2DC4CED2;
	Tue,  7 Jan 2025 02:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1736216881;
	bh=tsxUKdkJiGQjNXwxpYT/yyLQASeROBgDtN9X60CqQkI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JlM8YmrznSXyVk0icObhDsJ1SjWSh4maGY12uBw93z0v05NUpJcjeod5iPnDo3Tg5
	 VJtftk5ogQ80s9XAYE3J2Onhkthf5AicHz/4FJPOV6L+HRZhz6GGdeAHcBM9OaeXZM
	 CInBvlfYLdacyhyXQUEZ2Y8M2/pUNu8JV+vf4uNI=
Date: Mon, 6 Jan 2025 18:28:00 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Koichiro Den <koichiro.den@canonical.com>
Cc: Borislav Petkov <bp@alien8.de>, Linus Torvalds
 <torvalds@linux-foundation.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, stable@vger.kernel.org
Subject: Re: Linux 6.13-rc6
Message-Id: <20250106182800.5ed66c548b9bb5c77538f2e9@linux-foundation.org>
In-Reply-To: <g4sefofdrwu72ijhse7k57wuvrwhvn2eoqmc4jdoepkcgs7h5n@hmuhkwnye6pe>
References: <CAHk-=wgjfaLyhU2L84XbkY+Jj47hryY_f1SBxmnnZi4QOJKGaw@mail.gmail.com>
	<20250106131817.GAZ3vYGVr3-hWFFPLj@fat_crate.local>
	<g4sefofdrwu72ijhse7k57wuvrwhvn2eoqmc4jdoepkcgs7h5n@hmuhkwnye6pe>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Jan 2025 23:21:23 +0900 Koichiro Den <koichiro.den@canonical.com> wrote:

> > [    0.377680] smp: Brought up 1 node, 16 CPUs
> > [    0.378345] smpboot: Total of 16 processors activated (118393.24 BogoMIPS)
> 
> Thanks for letting me know, and apologies for the inconvenience caused.
> In the thread [1], I'm working on a follow-up fix with help from Lorenzo
> and others. Please feel free to take any necessary action (e.g. revert).

Thanks all, I have queued a revert.

