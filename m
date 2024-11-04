Return-Path: <stable+bounces-89748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E999BBE30
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 20:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2177F1C21236
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 19:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A95B1CCB55;
	Mon,  4 Nov 2024 19:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ye389VDr"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793FF1CBE9E
	for <stable@vger.kernel.org>; Mon,  4 Nov 2024 19:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730749343; cv=none; b=E/YszlrfJnGo2DEGLEQz1O2wLbdYhiYKL37jvCfwZH6ni5uGIAmFJ18O9Ak4thgETpwSC3sXzwQkdvDPq5V98hldSjO9KCSZ80MMKlMDAt9YKf993leEJMVAp/DO906kNw+vmGRwSxC7c1qhSL9sq/cC2veuPDmP8Z5JY9AtOD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730749343; c=relaxed/simple;
	bh=vwEntz4/lvl+PfPmJPSfCxSEh9DupmxFHAAWG09equs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxcnpi7ZSpHy7BQn3ZhLtpHSDQzss/9u8WT1KHjoSTt3eNQDBbx4GVjYTuLjt0z786YUHofd9+5zymJeiBpgB0MFs5Cp5u+BTvWxCQ+9D1fmJzfFgCKi0i2nVsBC0QjkSQhXa4tnPOaYgfPH4LOKZDiMGX2S3TB86KRxRSGJu2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ye389VDr; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 4 Nov 2024 19:42:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730749339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9EYq7wvFbS6q3j3l1UKcFa9P60tlccxS7EyUqJu3c4o=;
	b=Ye389VDrzTm1qPIBqIv9xY4mHDS+T0+Im4Ip9sQNZG05W0bJk2h6j+7hNc8ghLbpP5tpSM
	/rJqbN2aoPu8Su8G5GGjaUdoMEc+O8iC1rjt/p/eVxTkZ7wPDxL9ESAcGkP4w+5k9WE7lO
	s6m3Uu3SJs1KGdzOzyUIWJzkzdWkRwI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Alexey Gladkov <legion@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrei Vagin <avagin@google.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] signal: restore the override_rlimit logic
Message-ID: <ZykjlaoNTndyR9dz@google.com>
References: <20241031200438.2951287-1-roman.gushchin@linux.dev>
 <87zfmi3f8b.fsf@email.froward.int.ebiederm.org>
 <ZyU8UNKLNfAi-U8F@google.com>
 <87o72y3c4g.fsf@email.froward.int.ebiederm.org>
 <CAEWA0a4Kz9exk04Wgx9UZ9YFfURnS-=50TWyhPHm3i-N-D_8DA@mail.gmail.com>
 <ZyZSotlacLgzWxUl@example.org>
 <20241103165048.GA11668@redhat.com>
 <ZykQnp9mINnsPTg2@google.com>
 <20241104184442.GA26235@redhat.com>
 <ZykaS1arGZ3DMFkm@example.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZykaS1arGZ3DMFkm@example.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Nov 04, 2024 at 08:02:35PM +0100, Alexey Gladkov wrote:
> On Mon, Nov 04, 2024 at 07:44:43PM +0100, Oleg Nesterov wrote:
> > On 11/04, Roman Gushchin wrote:
> > >
> > > On Sun, Nov 03, 2024 at 05:50:49PM +0100, Oleg Nesterov wrote:
> > > >
> > > > But it seems that the change in inc_rlimit_get_ucounts() can be
> > > > a bit simpler and more readable, see below.
> > >
> > > Eric suggested the same approach earlier in this thread.
> > 
> > Ah, good, I didn't know ;)
> > 
> > > I personally
> > > don't have a strong preference here or actually I slightly prefer my
> > > own version because this comparison to LONG_MAX looks confusing to me.
> > > But if you have a strong preference, I'm happy to send out v2. Please,
> > > let me know.
> > 
> > Well, I won't insist.
> > 
> > To me the change proposed by Eric and me looks much more readable, but
> > of course this is subjective.
> > 
> > But you know, you can safely ignore me. Alexey and Eric understand this
> > code much better, so I leave this to you/Alexey/Eric.
> 
> Personally, I like Oleg's patch more.

Ok, I'll send out a v2 shortly.

Thanks!

