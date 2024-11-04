Return-Path: <stable+bounces-89741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7728A9BBD38
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 19:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D558AB21E99
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 18:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA621C9ED5;
	Mon,  4 Nov 2024 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JTPx3l1d"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CC51C729B
	for <stable@vger.kernel.org>; Mon,  4 Nov 2024 18:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730744486; cv=none; b=JqFFCJONdMSQ8HATaDIpEJBEDEMeWVU7naswmLx3ba7UIKVK3TIsgrU+egpPuK5mgV+h5haLh4TfgaQfa9dx4CzqOIMsGwilHcMrlWU1jYvegFl3q6hG4TSBrHq6cTNJpOlUYoU8ySw1Bh/2ysyYJdJF5SO0ssPRSzIZm2tqrZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730744486; c=relaxed/simple;
	bh=psda6WZ1bBDxqXSARndeShzdtueMUbDrCIxmrU6wCE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHXy8Kak98Q55EVIrfot8eDWbUle93rFPzKX4zJRihgt4kj9tejBhq0Q9gZMosrlo5tLLyQin6VW8PMOmFxL0bG4bOm5/IDhgMHcBdgIu10fcsU0ujwSoyxMw+gwobLFLPcXtevOpZeWZjZEEqhjaQsiuP6/vquIZG8bYannQ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JTPx3l1d; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 4 Nov 2024 18:21:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730744482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fRQZ1b4+YzN47zBQE0OhZW60GzonoSgG9kJ9tuC58Z0=;
	b=JTPx3l1d7ph/0YpLYRHb25UqZvpCwpxyzKx8JW6t5Jcpn2hrGkRinjAZkObAsDENFP/XqG
	SJiZ4OTf9raPwg1llQeWxlb7AArJ+obj4/o/ba7F2pTnRArw0p+oybu/CIIX0VFGqfxzfk
	Zg38nTaWMmO88Fi0j7emw8wM1U1zsjg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexey Gladkov <legion@kernel.org>, Andrei Vagin <avagin@google.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] signal: restore the override_rlimit logic
Message-ID: <ZykQnp9mINnsPTg2@google.com>
References: <20241031200438.2951287-1-roman.gushchin@linux.dev>
 <87zfmi3f8b.fsf@email.froward.int.ebiederm.org>
 <ZyU8UNKLNfAi-U8F@google.com>
 <87o72y3c4g.fsf@email.froward.int.ebiederm.org>
 <CAEWA0a4Kz9exk04Wgx9UZ9YFfURnS-=50TWyhPHm3i-N-D_8DA@mail.gmail.com>
 <ZyZSotlacLgzWxUl@example.org>
 <20241103165048.GA11668@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241103165048.GA11668@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Nov 03, 2024 at 05:50:49PM +0100, Oleg Nesterov wrote:
> On 11/02, Alexey Gladkov wrote:
> >
> > +Cc Oleg Nesterov.
> 
> Well, I tend to agree with Roman and his patch looks good to me.

Thanks, Oleg!

> 
> But it seems that the change in inc_rlimit_get_ucounts() can be
> a bit simpler and more readable, see below.

Eric suggested the same approach earlier in this thread. I personally
don't have a strong preference here or actually I slightly prefer my
own version because this comparison to LONG_MAX looks confusing to me.
But if you have a strong preference, I'm happy to send out v2. Please,
let me know.

Thanks!

