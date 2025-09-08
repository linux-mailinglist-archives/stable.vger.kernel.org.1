Return-Path: <stable+bounces-178835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2057AB4828D
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 04:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F207F1899C08
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 02:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C786A1E32B9;
	Mon,  8 Sep 2025 02:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzeZWNle"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CE91B87C0;
	Mon,  8 Sep 2025 02:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757298086; cv=none; b=Oh4b033ZJJq7ZQRKjkRRfRk3tFAMH9ZvkKRiq4k+8y6bi1tinXBK03UY/E+4VGBxXezFyZhmdRWpRXhHn7mEFTIijkeQGI6bicBAMvU+Rx/AcQMLlp118JcuzV4EVYLpVMMWeNiBhEFtonOQ6q47LfHBs64PJMfvOE3n9f+1dRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757298086; c=relaxed/simple;
	bh=a6aDfQv5FvaRhUAb0OYJMBK9zIDGlQ4Y7qdw+lTknrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwsNcjlof+F7/W49FfUTP4aB+Bz9jSxCttdccZ6xHHsOrf2maB1FUVD41QNWd76vRrRQiz07GPiEyMcYzEmbbDGQDHLoLy1u7PTMYqZWVIYTU5ZQjRvPZjHSHgdFyXEBHAxRgKq0z3a/1XjrAu/OjC5MKVzGPwx3WpakQFIzfwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzeZWNle; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-726ee1a6af3so44947036d6.1;
        Sun, 07 Sep 2025 19:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757298083; x=1757902883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQvcsK9AmIWuwBEfBGVFuDmRu55e5gkgeGEkjyZNnRk=;
        b=NzeZWNlew9vBcxb3GlJhilMatOkRiHqtyZEc/O6amHrQJ8uphCqMjWJGm8WQxrb9wt
         Er8TPs6isVO0owrJDJjHgCZX8GO6EroWziluI+fi5tBzD2eEpnTffS5I/rlrIWF7ALeu
         9H+wxfmWJGjxmJv0E1sO792Hjvelu9NlQA6W9quZgDxzcnE0bSrEksdZEZgop2ou7KXs
         lv0LJrGMeSQQFagOfoBF+cJ8c0a530a4cejITQ5kUSThDSXphl+epBnquic/m4pw9DiO
         nrmHjmIpmNiuKLH/WTIezEdclTqwP0KzJhAi2YEU43SBUbEzkliBK85jW++vGxtydWpV
         6qyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757298083; x=1757902883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQvcsK9AmIWuwBEfBGVFuDmRu55e5gkgeGEkjyZNnRk=;
        b=woa+yQS8+wF51agUyVaAYu4Cce9JR66eOIV8lGfFNEiTBSCEGIlsqSxHgpI0+eaE2L
         Q14HBTufznUvI69WuzV86cWDuSxpg2afzc3+qWscIZnRl7eBI2cUafU6hXU+Z+6XasIP
         D0CE17FLBmWfWdFzrVxa5w0f/UlVNNJvxZQRq7MpgIpaNhRrGXTp5sgYbDm3r74C19NG
         2OTrIVWJVYUqAx/kJKlm/qPPhYV6rki2jBaX/ZYWKJKphoVLXWrXiVZvHL9+lOGuDx/x
         cEggfoR4OjK5QA4wuMnJWwWvCFY4Qt5iQof7tVMsfl2t8IaaQ41vcxP15Kbd0UELfMjV
         Gusg==
X-Forwarded-Encrypted: i=1; AJvYcCU5H09hdpuiowXx8ZcRP3+8MOFMMA95oPVJfwh4A9ouvK37zhy7kSDCptw0GPdTjfUTs3qFkEnPQPk0j5c=@vger.kernel.org, AJvYcCWE/oXBJgTQ7SEQijcdSzVQ1jnWOKiE0Fou8r2ZBJjbTArFa5P7iXnVQSwrKSkXZJbPnLEyjTGM@vger.kernel.org
X-Gm-Message-State: AOJu0YxBKxF6w2PI5TtgYWGnF1xwBInShAecZ2OEMaDmyZZ8f0vbXrVY
	KLUbCLNx9HeB8qmcBvDWI9tIE09ZrrSkExLJf0WlSjtVBmetuSXLq/rj
X-Gm-Gg: ASbGncsRgiGNFrWKSGpSlRpbS5jKn/kS31L+4RE5iuC6Ucc9EptCnoEaP9Ztl++Tjk6
	t90/L0DUyJMQ8MqfdNKsT06cqEVFEZzJCdGPxNQU9SVoqzTOdqU99UDBygWaoOf4DUZXkaPmUD8
	ODz45ldAeffRZMMydamJhus3ThZSLL3OKUFLIJFR2/Xgu8V9qk0MxWM/Uyp/yJ2AMjKgTEq8kBS
	qpSF9VJoYDY3T8QBDfdS4GXGPYJ/wbrQ8LWBwd9mfy+Twf83HzeWn4fDHQllKLTl1xjX+9baRZl
	PhEQPhrBbkuJnf50yfwIpvo7ZkRE3GSwFbQjiRfDL39R+dSvQlB4OBQ61l2BMNXyAVJUaqojGj/
	bWNU3Bn/saWB8AgDCPr2MedOVIEVlgAMlnkztqeMtKyEHJhy9dfyxVHggousDVy60NYTLdfqZgO
	GtkxJ7Dxwh9XCJDCzc4inK0z4=
X-Google-Smtp-Source: AGHT+IG8I2PGOdS/XAOAGqC2wIB7ZxqvqZATHztC1T6u482bnf8PjsXTF7RjY9Ld1wMw4JdkMbrrDg==
X-Received: by 2002:a05:6214:5085:b0:71b:dd1c:5b10 with SMTP id 6a1803df08f44-7393f986199mr66923706d6.47.1757298082849;
        Sun, 07 Sep 2025 19:21:22 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7220f78b9bfsm105268276d6.64.2025.09.07.19.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 19:21:22 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1C73BF40066;
	Sun,  7 Sep 2025 22:21:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 07 Sep 2025 22:21:22 -0400
X-ME-Sender: <xms:oj2-aMnIj4ZEcFoH-rkdJGBH7LCO_rUOKTJlZ2HLgmpICVZtfDDgiA>
    <xme:oj2-aEdXN9jIUMKi-7NgfyL5X_kgZeZNfPier47ns1ZsKmUZZVBNB1eLJnyNHTfqP
    3A9ayUDQAI2R3ZroA>
X-ME-Received: <xmr:oj2-aCHGUsbVq_cVi3pa4Bs-vl_vP86Bu9JC002qXMWm_bHjhhN0ZoF06Rv9PF489U6cSqhX01PEX4_-_TQxnx6zRHL17R97>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrg
    hnuggvrhdrshhvvghrughlihhnsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohepvghl
    vhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgr
    uggvrggurdhorhhgpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtg
    hpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhnghhmrghn
    sehrvgguhhgrthdrtghomhdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:oj2-aCgdd-MT8f1K_ycCQT_lV9STQlzpufu3HKigWWjk9n2cJGTSlQ>
    <xmx:oj2-aO3E-ivoKL2hLeEMb5n1iuXaelkt7f7fJQo3nvr4ucQ0LzPDvw>
    <xmx:oj2-aFcAgN9-NvgemsI1TJMZjquRa7UA2sf-kjmJY8YdXd4FPWWtSg>
    <xmx:oj2-aEyMsB4589_e4tXilr9mrvtNkQduqQyonlIzu0CEJa-agSpddA>
    <xmx:oj2-aNya0jOCemKvlL3WQkFYyXEs2tM9n4x2nJ5U-j5dWSHIcoJsF8aj>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Sep 2025 22:21:21 -0400 (EDT)
Date: Sun, 7 Sep 2025 19:21:20 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "A. Sverdlin" <alexander.sverdlin@siemens.com>,
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, stable@vger.kernel.org,
	Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: Re: [PATCH RESEND] locking/spinlock/debug: Fix data-race in
 do_raw_write_lock
Message-ID: <aL49oKS9v_sxYSee@tardis-2.local>
References: <20250826102731.52507-1-alexander.sverdlin@siemens.com>
 <7325588b-189c-4825-a87f-5494b1230d7a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7325588b-189c-4825-a87f-5494b1230d7a@paulmck-laptop>

On Tue, Aug 26, 2025 at 04:44:30AM -0700, Paul E. McKenney wrote:
> On Tue, Aug 26, 2025 at 12:27:27PM +0200, A. Sverdlin wrote:
> > From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> > 
> > KCSAN reports:
> > 
> > BUG: KCSAN: data-race in do_raw_write_lock / do_raw_write_lock
> > 
> > write (marked) to 0xffff800009cf504c of 4 bytes by task 1102 on cpu 1:
> >  do_raw_write_lock+0x120/0x204
> >  _raw_write_lock_irq
> >  do_exit
> >  call_usermodehelper_exec_async
> >  ret_from_fork
> > 
> > read to 0xffff800009cf504c of 4 bytes by task 1103 on cpu 0:
> >  do_raw_write_lock+0x88/0x204
> >  _raw_write_lock_irq
> >  do_exit
> >  call_usermodehelper_exec_async
> >  ret_from_fork
> > 
> > value changed: 0xffffffff -> 0x00000001
> > 
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 0 PID: 1103 Comm: kworker/u4:1 6.1.111
> > 
> > Commit 1a365e822372 ("locking/spinlock/debug: Fix various data races") has
> > adressed most of these races, but seems to be not consistent/not complete.
> > 
> > >From do_raw_write_lock() only debug_write_lock_after() part has been
> > converted to WRITE_ONCE(), but not debug_write_lock_before() part.
> > Do it now.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 1a365e822372 ("locking/spinlock/debug: Fix various data races")
> > Reported-by: Adrian Freihofer <adrian.freihofer@siemens.com>
> > Acked-by: Waiman Long <longman@redhat.com>
> > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> 

Thank you, I will queue this for future testing ans reviews.

Alexander, is there any link to a kcsan splat that we can use? Thanks!

Regards,
Boqun

> > ---
> > There are still some inconsistencies remaining IMO:
> > - lock->magic is sometimes accessed with READ_ONCE() even though it's only
> > being plain-written;
> > - debug_spin_unlock() and debug_write_unlock() both do WRITE_ONCE() on
> > lock->owner and lock->owner_cpu, but examine them with plain read accesses.
> > 
> >  kernel/locking/spinlock_debug.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/locking/spinlock_debug.c b/kernel/locking/spinlock_debug.c
> > index 87b03d2e41dbb..2338b3adfb55f 100644
> > --- a/kernel/locking/spinlock_debug.c
> > +++ b/kernel/locking/spinlock_debug.c
> > @@ -184,8 +184,8 @@ void do_raw_read_unlock(rwlock_t *lock)
> >  static inline void debug_write_lock_before(rwlock_t *lock)
> >  {
> >  	RWLOCK_BUG_ON(lock->magic != RWLOCK_MAGIC, lock, "bad magic");
> > -	RWLOCK_BUG_ON(lock->owner == current, lock, "recursion");
> > -	RWLOCK_BUG_ON(lock->owner_cpu == raw_smp_processor_id(),
> > +	RWLOCK_BUG_ON(READ_ONCE(lock->owner) == current, lock, "recursion");
> > +	RWLOCK_BUG_ON(READ_ONCE(lock->owner_cpu) == raw_smp_processor_id(),
> >  							lock, "cpu recursion");
> >  }
> >  
> > -- 
> > 2.47.1
> > 

