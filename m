Return-Path: <stable+bounces-89745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D366A9BBD9A
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 20:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A16C8282FB6
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 19:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FF41C4A03;
	Mon,  4 Nov 2024 19:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwLHjLWo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880EBE552;
	Mon,  4 Nov 2024 19:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730746961; cv=none; b=RjEt4RgE6PrN6s0V9E1ViQGzhkD/o3ds1ehbxTSirVL8G/0Wr+0RX2o8RnBZUWZRnimfx36tqHdNitwnRNzqp4ShtTElYlQKEIEgj9t77IzpWnCf8Tf90WRmzFJphTcY4bJfiDyiyepDf9c0d6NasmpJHbNg5BsSzpdD2viNrSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730746961; c=relaxed/simple;
	bh=y6B0iq3IlGbxWPuuUX1NOdOXo+3wsNpEGsISvxpuj6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+kRkywWdeeNHxBZnh0DtL+UnKStYwKrEJHMEdwk5a6evsMdh8pfSlSLqb3VLPxoWcAkUcbyV3X4GOPwNXdqVBrPTudSZGkU17twKArgK2N1LTfVDM2yq/xTYzxGNI+sfazX/+qXCRWZj0Ycl0c3iWZI8KPOgApcLRUaSJZEBjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwLHjLWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68053C4CECE;
	Mon,  4 Nov 2024 19:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730746961;
	bh=y6B0iq3IlGbxWPuuUX1NOdOXo+3wsNpEGsISvxpuj6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mwLHjLWo4WwNMOAs5HED/NiNPDGI9opYahanawVZb248gHId4p9dAjUsbRJGUSn1k
	 kEA9cVdayqRXOJslu41SQYKo5jMQFSp1BjIEnyNDU/WL+8agI6ii4+7IgrfIXtB8w4
	 FEviOlA5VRNvfRfI2N4QRHRFNVlEq53Fnf0gZCdvV+YT16LG7G/Mvhs8JsdGftNE+p
	 b6q9DVKgERZfm6UGw+5X215dZX9DhuGOo0V+9AQNYHApe9pfNUm6Myd2tN85UbWEqd
	 ZPFctCYunpEYgkg87d6PW1oc7+QZIND9fbZqZmFxr+wbU0ch0cjrnu96/7LqcQJUu7
	 bchT2/XOA1jfA==
Date: Mon, 4 Nov 2024 20:02:35 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Andrei Vagin <avagin@google.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] signal: restore the override_rlimit logic
Message-ID: <ZykaS1arGZ3DMFkm@example.org>
References: <20241031200438.2951287-1-roman.gushchin@linux.dev>
 <87zfmi3f8b.fsf@email.froward.int.ebiederm.org>
 <ZyU8UNKLNfAi-U8F@google.com>
 <87o72y3c4g.fsf@email.froward.int.ebiederm.org>
 <CAEWA0a4Kz9exk04Wgx9UZ9YFfURnS-=50TWyhPHm3i-N-D_8DA@mail.gmail.com>
 <ZyZSotlacLgzWxUl@example.org>
 <20241103165048.GA11668@redhat.com>
 <ZykQnp9mINnsPTg2@google.com>
 <20241104184442.GA26235@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104184442.GA26235@redhat.com>

On Mon, Nov 04, 2024 at 07:44:43PM +0100, Oleg Nesterov wrote:
> On 11/04, Roman Gushchin wrote:
> >
> > On Sun, Nov 03, 2024 at 05:50:49PM +0100, Oleg Nesterov wrote:
> > >
> > > But it seems that the change in inc_rlimit_get_ucounts() can be
> > > a bit simpler and more readable, see below.
> >
> > Eric suggested the same approach earlier in this thread.
> 
> Ah, good, I didn't know ;)
> 
> > I personally
> > don't have a strong preference here or actually I slightly prefer my
> > own version because this comparison to LONG_MAX looks confusing to me.
> > But if you have a strong preference, I'm happy to send out v2. Please,
> > let me know.
> 
> Well, I won't insist.
> 
> To me the change proposed by Eric and me looks much more readable, but
> of course this is subjective.
> 
> But you know, you can safely ignore me. Alexey and Eric understand this
> code much better, so I leave this to you/Alexey/Eric.

Personally, I like Oleg's patch more.

-- 
Rgrds, legion


