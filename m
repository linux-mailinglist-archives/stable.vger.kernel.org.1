Return-Path: <stable+bounces-241912-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEw3CSQm8mm/oQEAu9opvQ
	(envelope-from <stable+bounces-241912-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 17:39:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE85C497178
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 17:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6701B3045A9E
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E5F344D80;
	Wed, 29 Apr 2026 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laFnhgY3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47228346A0D
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476909; cv=none; b=A41l4gi84UJa7I5tXwx3ZmhX6SyVPTfLl1VHzatvGbwHG/mBHDYZ15noU7uSlcJcanwcA0kD+S2WWaCe442WNhG37phSYGtrzhDSdDZ1+ag95+xyBe3CKDrp5yR7zavC9rWk+X2YTnD5HuGWtdXIAsedESRkZXKsfSIDv8pidr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476909; c=relaxed/simple;
	bh=MPtseMcPFil/hMFJneNT69ahx4akFZE9eLGxGiLszb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtzMNb44Ku1cs+0hjj3KBcuP4xT9jyAhhDhaLe99ZYTrAIPwE6/ROWn+yL6QOg9bVJ7lz1Z9u/iLm7ZV7txgrU6aTzTQ2jLBGnQyUQA/FrFmtZfugzkrXyx1reiCD++xK6bEbKiZ2WsYYilhNdMoruk4c5s5rqVUjPvXXyZpOqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laFnhgY3; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso2302335e9.0
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 08:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777476907; x=1778081707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DGcwHPSiFxHxYPNUUq+KvwIWZ9lWOTC64lUxpO8JLXk=;
        b=laFnhgY3dEyqcmP1T+nqa7CQNxDjtpkOHtFReQtEHfdCon3XTCMJsO4D6Uo2bzPsSq
         l74nClAxSQzx8C++a1PXm2sQYfi9bscmiyvIBkDveiFpFwMWIF5gXVT+XbleYA4i+Pbq
         zhMGMqSTEpw22lYyuIylGZ4n+k8WDVSFOXpnn8TRyvNB9coXShvrQf+GZV+gwh8NG8nG
         4L+GETBsp2ZBW3rEGpY5bOIFj+lqbGpJWdL5d3yOXk0V8ILmql5HnA9F0S5zUiltAFrl
         EN4S8hqvzJLcbNqPigbYezEfCqFQGaBm+IwkSyCp4rgvTzHFmWe3rvzumKFPp9CLDlpO
         fb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777476907; x=1778081707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGcwHPSiFxHxYPNUUq+KvwIWZ9lWOTC64lUxpO8JLXk=;
        b=rBNtzLjk1n813fRRa4g5wwjIHPbH9RRk75tBRJjuZycVfACsWW69dmE2jobxd51fBT
         YF3P7nZyPf9aC9VDmy3iF747aSPtlXKDiMwqo+iHxBUsMw1HC/IcKup6yxcW4CqwzlYU
         opAslRdfxPVrQNOoNjNGwJrBUm5424HRHYk5PylNfe0ep2gWavKe0IU262dyfkFFDlr8
         5KTrw4zJMxOYGPEuj8ubt2L4avtjd5nQj4othL7ugQvFqDcOrqObr00TU9JMOXPUi1M1
         HS/pyXbhwWezmcobvunUlS+QJQb3zfFel48SesgLxk9MRbdL8iUkd1LL/r34af6U6mRB
         yqjw==
X-Forwarded-Encrypted: i=1; AFNElJ8RUgeJU9OxLnLKTTzDcx1WQAZ/cag9jHeumtLavcqXqzOYlv5APXRl7m7al3JooPFM6kbzc7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3mh9fklA5fOUBlR0QpdSxob2pD5c+Co6qVh8P6JNxMlHWSzvt
	m4t9SstrQBSuF3YFKlsHhVhpfsEMGLHSS01eEYN8stndNRngd1gCO0OE
X-Gm-Gg: AeBDieuiZu/F8JTI877I4CJ1D2FlW8DD+ZInUNfdZuOrBi/MBTmXdyZxtMSb1hYpw+j
	mwlXQboFvD9IeXcwYUKQWlxIpGakKmRm11qLAmSmZp0PcjH0jAkBM3bhpgJhCOKZW53Yu4O1W4s
	5xbBlPGUcqhk686YK1AAIkvB/aDULq5kaPse323530WRDYOl8CaBNBLvuE4SqnHq8K/wCnk6L/H
	83vQtk8D/QEsQjFafRnv7T53FFLjXFxUIuY1Z/xYHTw2xzize+M+Oe7sJRDqhV/J10q7aaHFgSn
	6Cg/S8MjyrHoHW+B4EiaSG4aAUQmT87OepI89K59bcb8cL+04vhUqc48QFQ5TKt05IYNX+wBnl1
	vRGpeNy+MNz1vBqxVPKr9dHtypHFMgt8rnlDrXKbG9y7CJyS5B1UryG2y6hjIwONvvLjHWt0FHi
	xBP4UTt9bZ9PebFYG2u4/ajQiKJpCHswJDmsJ4RbR2MwUKztghWIZTI3bf5eCui39t68afyKNoQ
	cpagaIfFQ==
X-Received: by 2002:a05:600c:a41:b0:488:8840:e5ae with SMTP id 5b1f17b1804b1-48a7b543f0bmr72325055e9.24.1777476906362;
        Wed, 29 Apr 2026 08:35:06 -0700 (PDT)
Received: from f (cst-prg-93-232.cust.vodafone.cz. [46.135.93.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7bc810e1sm62983695e9.14.2026.04.29.08.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:35:05 -0700 (PDT)
Date: Wed, 29 Apr 2026 17:34:40 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Christian Brauner <brauner@kernel.org>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Khazhismel Kumykov <khazhy@google.com>, 
	Willem de Bruijn <willemb@google.com>, Eric Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
Message-ID: <xbotidrmois5ygxtqtwqzczkt76wcc7uw5cz5lptda53coaavj@pzvxcpe534cu>
References: <cover.1752824628.git.namcao@linutronix.de>
 <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
 <CACSApvZT5F4F36jLWEc5v_AbqZVQpmH1W7UK21tB9nPu=OtmBA@mail.gmail.com>
 <20250718085948.3xXGcxeQ@linutronix.de>
 <20260429-november-speisen-3084d769d316@brauner>
 <87340exm2o.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87340exm2o.fsf@yellow.woof>
X-Rspamd-Queue-Id: AE85C497178
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241912-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjguzik@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]

On Wed, Apr 29, 2026 at 09:27:59AM +0200, Nam Cao wrote:
> Christian Brauner <brauner@kernel.org> writes:
> > The selftests rely on this behavior that timeout=0 sees events from a
> > concurrently running producer. They would fail at a very higher rate
> > after this change - believe me I had a similar patch that changed
> > something in this area.
> 
> Huh, that's interesting. Do you still remember which selftest cases rely
> on this behavior? I would like to study them further.
> 
> > I would explore the seqcount that Mateusz suggested tbh.
> 
> I will investigate that.
> 

In the meantime I grew fond of another approach: have the write side
re-calc the conditon the unlocked side checks for.

While the seqc thing solves the scalabilty problem, it still requires
fences which are not free on arm.

the goal would be to make it so that this:
static inline int ep_events_available(struct eventpoll *ep)
{  
        return !list_empty_careful(&ep->rdllist) ||
                READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR;    
}

can be converted into:
static inline int ep_events_available(struct eventpoll *ep)
{  
	return ep->has_events;
}

Which in turn means that any codepath which messes with either rdllist
or ovflist will need to recalc before it ends up unlocking.

Strictly speaking more error prone than the seq approach, but should be
faster on weaker-ordered archs thanks to avoided fences.

I'm definitely not going to protest the seqc route.

