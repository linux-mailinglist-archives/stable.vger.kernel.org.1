Return-Path: <stable+bounces-144116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54184AB4C6C
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 09:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06C88681F2
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 07:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70001E885A;
	Tue, 13 May 2025 07:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="erKXp9qA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EDx555ES"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166981E9B1D
	for <stable@vger.kernel.org>; Tue, 13 May 2025 07:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747119853; cv=none; b=ePA3yWcEi63Pt1/STlkM0zlmhiCPuIT3q990FsAilA+Ln0Ju90ERo+07VDkpG9kx89dq1zJF03chVXMVon273QYGqIN06LPw+fTvZ2fvApAgM9n7Gm0t09IPGFqJ6nuMozrKo0LInP973gOLn1IayVpWD1qyC8I5OLpMIMR9euk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747119853; c=relaxed/simple;
	bh=rpKouIfQlLALpe7Nmvo4+7jjgVyBrlyNwr3Ge0IYFRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkzZYB3CicQbCrWHTIgtlW71dadmssH1lAaCVWfRHqId7m5bKAAg5sScupB3vsMUuVgg8an8aEKqWau3slOPdtoEB8kRBjO72rsWtLazmaKMYMacssZyzIXXZdzs2+XkWglBNmayHD7w74y+itBUPnE4Jt7tgw/Dpu5RC+q5Mo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=erKXp9qA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EDx555ES; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 May 2025 09:04:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747119849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CUYAUDr187U2Rs/PmwqrZYW1hjM0fL6t0x1gPBkDyms=;
	b=erKXp9qA6EfaPi8tZIvSawhaUh0tCsntzknJMQu8rYc6bMRcs3MDbO4iD/0V9sOYd3KKFY
	2aO7gGCa6KQ8j0XjApzxexWmNnGj0WAB1jTLqTAFRk/36pRUb3QlJelOMDj8uWOsIwK6na
	zKKcNveF3qB9wG7I9DqI5HCbuizZZczibdgl+xYYHSvq/a9n6lGr28vQAQEKcLL0DJ+Kiu
	Wd/PtHR82qm66dTwmcoD3cXFwnn5ULCWnBIFQFJAu63/zbgKAen1cynfRh8Cj3qjSmUWtK
	L+o0CU1VwIwmKwqJt2xKKZVdJxRzgls0Y5Lc1/++GDB6abxhGLBhozc7f9WQZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747119849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CUYAUDr187U2Rs/PmwqrZYW1hjM0fL6t0x1gPBkDyms=;
	b=EDx555ESrlN9V85MWe8YaZktoqQ5QnvjRgNHQs/0TjCww92t2C13/Q8FM6HQqaV4URp9po
	g76yQ57oVcpdMVCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: tglx@linutronix.de, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] clocksource/i8253: Use
 raw_spinlock_irqsave() in" failed to apply to 6.1-stable tree
Message-ID: <20250513070408.R_nrGwgI@linutronix.de>
References: <2025051256-encrust-scribe-9996@gregkh>
 <20250513065326.frlx-qtR@linutronix.de>
 <2025051336-applied-ambiguous-08e7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025051336-applied-ambiguous-08e7@gregkh>

On 2025-05-13 08:55:13 [+0200], Greg KH wrote:
> > I performed these steps and the patch applied. The diff is the same so
> > git did not attempt to resolve a conflict on its own. HEAD was at
> > v6.1.138 at the time.
> 
> Did you build the result?  Many times FAILED reports are due to that.

Yes. I just sent a fixed version for v5.10 which failed to compile due
to missing guard notation.

> thanks,
> 
> greg k-h

Sebastian

