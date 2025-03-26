Return-Path: <stable+bounces-126789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4985AA71E73
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 19:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41CE5188CCC7
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 18:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B7F2417D7;
	Wed, 26 Mar 2025 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtnTEznW"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC541F5845;
	Wed, 26 Mar 2025 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743013884; cv=none; b=IiQaOzXuB+RdqErDUMVV8WiH2L4iAH6d/UUJPUrMyBktT/sBeDEuY54vI/iDs+UJ6dkYUXpMe4VkS77WX6AV9vtxv0fAhkvyQQ4NhKgtWHOipcuWfYWRdEaJGYbMN/LuW9aI3ZDfF7t67I+jM5HXUZwKYQ4XMewEZIX62azVdO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743013884; c=relaxed/simple;
	bh=T4wHVOK5R7UQy1wI3mKQO0Y6lleQvRvRgljVHogNlUo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=py+iK6kaZV+dRnS5EwWiVE86zpHSSHC2kGwK4HKOKhySFLO+3RFXoSLVJhYFSntCFCsQR20QHeHKDT9t3tBwjLuTAu8WLcSShDT3C7mY1fLXL6ntMFmELxG2XxjQqaEEFrbL+7citFAZo2Knz3vyTkXWc53SX1lfpU5mx/Hck18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtnTEznW; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-476ae781d21so1626581cf.3;
        Wed, 26 Mar 2025 11:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743013882; x=1743618682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpz4ONISxxv+QzX5wK7HdLtU8Os1bYKPHsJjcx+dIZo=;
        b=EtnTEznWmXyO+hIaipGviGr6te/IWjfktZ6GdI/6bg5mFPnTvQ0uWXIekimNIMqGLa
         LOyeBZh5EHvo5Zs4Tqa4jmkcKEd+Wp2MF7BY3f2Ggrj9AWUhwsjwrkUOeqIOVGZdx/SX
         CEDVyI4MOMzeIdA589O2lNlXJfQlbZMxpEu2pX/Tzc2tGm8fmJBCMfz0AqRXp7SMNkbV
         lt5eLWN+gMpk7MbxGjJeQIJdmWrNyoR0rxBBqH4QA0twenbTe/S3pdoLm7MjKyP5e+NQ
         Dd9Q4JSEwHi4X+BGf6D64BPjT29DKDaDbfFTz6fQS9jCclVh2pjGCLs188V6D5BlKqxN
         nQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743013882; x=1743618682;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpz4ONISxxv+QzX5wK7HdLtU8Os1bYKPHsJjcx+dIZo=;
        b=iAKSYV3dauGgqWCM+z0TVLWTMEUOqSuPA9wIeakdgE3tFWxi+f0dwtS1k80+XIqoSI
         R+tj10Ai9AgkmF0pmX1Ih86OyFNF2MerZPDZuVh700chEOis5/9sSyTifOu1iRbPcBzr
         oN5hiJJQ4rVku7y1gpn//4qOFyTyJlHVgpEIfcCn6J/J08ZgerMOZ0N3MTwuffdFefUv
         J2OWzlqZGvI0Rh37dKECjZMnKZMEpME0MofwDi2TYHt5vaJTpfU9mAxTCRVHCvsYwAuS
         4ZxrADIUQCfx6IyJ8Ek8McLUgVdi/x2QUuGEXNDv/bIsYzavnsAaPqATfAIGHpX9fgcu
         rB5A==
X-Forwarded-Encrypted: i=1; AJvYcCW7hNFABXka8W/mmo2reyro8/AKIukEqr2CEZVN2Eqq3P2A5XwynPg6aT9nOSoVn9d7lY6Ligpie03/IGg=@vger.kernel.org, AJvYcCWFJcBSB6o3XAiJA/HA6P6cFXCws9B/L8gDWDE+RhwaygFYvGZcjQjvSAAJLj+pCHf7wmH43+l5@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu70FpUbqYrMW7QxZzL3/t0l4TeMn+H3EZjpHmpGY+wr+x7hvm
	g0Opa/iAomhg39h/Glitxbv0oy7DBc7z4bjALoccfYXSimVbplwH
X-Gm-Gg: ASbGncsldOga8ptsE4URV/A3wZDazc9ylwsD9kw/CSv6la2Re5rfAwyKAQWE9Vrh3Q/
	h4rUGmhBKNvIns81tDaBEWvFQnBmj5K4fT/VXMJXOBAdA/Q8Q0i3l8jQOJt8My5VfG8+CwHSFR1
	NsoE510PGY8NAaQGlJ0zHHQnD566MCdeTJR/C7LnX1YhOjSls/dRSOl9dTFdW8XWZKcBcj+/lzI
	hif2rhczwXNklq9xOoajNhoxyjocEvL97qwwxfQ9/djUvmMQ+V5fJ/8TJQTEF2RqLLNwwKfItI8
	xPObTvSGlUyOLO2LJctW68rflb+UvAoQolW9KgDrCxXxO4TlJbs7COYfG33cW117poba5KzEQkq
	5T4wH2gBh/eOq938kfgE20oPfeSlPWn4LMpI=
X-Google-Smtp-Source: AGHT+IHDcA13sYud1sFE12r7hhvcLkcNy7wOw5DLuu3tFyhbFzNV/TQQr2X7/CafiIAJJLixDd0vhg==
X-Received: by 2002:a05:622a:480f:b0:476:a823:50d5 with SMTP id d75a77b69052e-4776e1e6516mr11702671cf.39.1743013881514;
        Wed, 26 Mar 2025 11:31:21 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d191ea6sm76493561cf.45.2025.03.26.11.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 11:31:21 -0700 (PDT)
Message-ID: <67e447f9.c80a0220.d7401.34ce@mx.google.com>
X-Google-Original-Message-ID: <Z-RH9zCblvyes_D_@winterfell.>
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id DE86B1200043;
	Wed, 26 Mar 2025 14:31:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 26 Mar 2025 14:31:20 -0400
X-ME-Sender: <xms:-EfkZ_EAoPeDVjH_bYB7Yz96-uqEs6qIJCqBsaIrpQykgjKBxaGe1g>
    <xme:-EfkZ8UIG1Qttdii_3zyIYnWoDrcDgvSfCmr4QFaA6Zl5xSP2OIFYEPJ5jz-Dq0vI
    5K8Bz1D-vA5KUrohg>
X-ME-Received: <xmr:-EfkZxISYPwJETmHCpr5xrLNb16laAkmFsbUWI4DLj5CZBVo9QkQj5VUEqM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeivdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfel
    leeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepkedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhlohhnghesrhgvughhrghtrdgtohhmpd
    hrtghpthhtohepmhhinhhgoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgv
    rhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopegsohhq
    uhhnsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:-EfkZ9FJn06tSzOmPbObyvFwPtNBQNOoqab2ar7nROVZScto0QWdow>
    <xmx:-EfkZ1X4Ex2L8ZbxfWBf62QX5gebmwf5ta9V6QeD0odyxy6FFDiVQA>
    <xmx:-EfkZ4O233dmHHbXa327Ccgw0tC6Z2Bxxc2RpghGTjGOAsc0JCk0mw>
    <xmx:-EfkZ035m1WHw7taNwRTeOziWu3MfKRECt6idt6MrBL1y1vJ4U4Ifg>
    <xmx:-EfkZ6UgETfqWMmW-_EWCYcKJRAZJrvy75G75ZAULzNqOFmz0mdku8vd>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Mar 2025 14:31:20 -0400 (EDT)
Date: Wed, 26 Mar 2025 11:31:19 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Waiman Long <llong@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] locking: lockdep: Decrease nr_unused_locks if lock
 unused in zap_class()
References: <20250326180831.510348-1-boqun.feng@gmail.com>
 <5f02cf04-74bf-46e5-8104-a62d4aca2bfd@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f02cf04-74bf-46e5-8104-a62d4aca2bfd@redhat.com>

On Wed, Mar 26, 2025 at 02:26:53PM -0400, Waiman Long wrote:
> 
> On 3/26/25 2:08 PM, Boqun Feng wrote:
> > Currently, when a lock class is allocated, nr_unused_locks will be
> > increased by 1, until it gets used: nr_unused_locks will be decreased by
> > 1 in mark_lock(). However, one scenario is missed: a lock class may be
> > zapped without even being used once. This could result into a situation
> > that nr_unused_locks != 0 but no unused lock class is active in the
> > system, and when `cat /proc/lockdep_stats`, a WARN_ON() will
> > be triggered in a CONFIG_DEBUG_LOCKDEP=y kernel:
> > 
> > [...] DEBUG_LOCKS_WARN_ON(debug_atomic_read(nr_unused_locks) != nr_unused)
> > [...] WARNING: CPU: 41 PID: 1121 at kernel/locking/lockdep_proc.c:283 lockdep_stats_show+0xba9/0xbd0
> > 
> > And as a result, lockdep will be disabled after this.
> > 
> > Therefore, nr_unused_locks needs to be accounted correctly at
> > zap_class() time.
> > 
> > Cc: stable@vger.kernel.org
> > Signee-off-by: Boqun Feng <boqun.feng@gmail.com>
> 
> Typo: "Signee-off-by"?
> 

Oops, yeah.

> Other than that, LGTM
> 
> Reviewed-by: Waiman Long <longman@redhat.com>
> 

Thanks!

Regards,
Boqun

> > ---
> >   kernel/locking/lockdep.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index b15757e63626..686546d52337 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -6264,6 +6264,9 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
> >   		hlist_del_rcu(&class->hash_entry);
> >   		WRITE_ONCE(class->key, NULL);
> >   		WRITE_ONCE(class->name, NULL);
> > +		/* class allocated but not used, -1 in nr_unused_locks */
> > +		if (class->usage_mask == 0)
> > +			debug_atomic_dec(nr_unused_locks);
> >   		nr_lock_classes--;
> >   		__clear_bit(class - lock_classes, lock_classes_in_use);
> >   		if (class - lock_classes == max_lock_class_idx)
> 

