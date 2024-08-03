Return-Path: <stable+bounces-65325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB84946A57
	for <lists+stable@lfdr.de>; Sat,  3 Aug 2024 17:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBC8C1C20B43
	for <lists+stable@lfdr.de>; Sat,  3 Aug 2024 15:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1339F1547D8;
	Sat,  3 Aug 2024 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1rsqCak"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F318B1514CC;
	Sat,  3 Aug 2024 15:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722698451; cv=none; b=AAD98pJo4IWRuXKgDBfTjv4xqmkWmqcHHYOTgrt9vjjwehJHm9t3KhONFgOm7yfmSLyBVj8Ae0NohCPR8CjqxRzBtHBqqzEwUwslIYbA1O088vPlABZfCjOberXPlyefOSHGOWP3C99J1HSuAGtDog66a3ZCfWxEsOELHc/hjbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722698451; c=relaxed/simple;
	bh=cfAe+QqaiSl7nI4V7Xbg/zg5c8SAghz7Y5FOwVVdalo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqoLE2Ca9MA3nU4QsBWXuMGgQv8KJRZXrHS9uLqziRsW8XryPnrkNABDilJ+tXBdhKrkYQjln9wFWq/XNHjYoNqzA9n1QEKsYAkOtL8URJL57QGITVCkAHvqhX8BqXaN3rFF5VAlPWyjfoX+RWZKM2aP24/Pas5n2Bwg0U6fFGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1rsqCak; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6bb687c3cceso33719956d6.0;
        Sat, 03 Aug 2024 08:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722698449; x=1723303249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+2BGgZKBrVml391dULVEmSM9a6vBLoKxZKJVj6WJZs=;
        b=C1rsqCakk50YqvURAJbhEGRGiAzCcFcea9oQjJOLAo+1J0zluV90q+RiT4nMzZgnvR
         VtosaZ3dckHN4p/LzZB+P8Zdj18lr+4te923SqtxrtNks72j4lxTlbAa6Dk1ZDKrfNrm
         FDw0aIM8edJmW2UcbX20qlrMzKMzis+jTYoJTWwFJLGuMOHGj/XhAEQ1Om7b5jo3gAJj
         2+UjsrTgV9tzpbXDxG5aQ4MomZH5f9PL2Na5pAGo5pZ6VcbbBV/j44jG0ZHQdb5tLh1O
         81azXiaZcB1CSHiCa5f388hgBkIj1kdSJQ65xreBk7V4wu2T3VWeVYnfgN8sEvilM0Uv
         coWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722698449; x=1723303249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+2BGgZKBrVml391dULVEmSM9a6vBLoKxZKJVj6WJZs=;
        b=ajF0nmtMW0KnPHd5pmgqewV6vn4/S/T/1zJi4WTvXeU0ZOZFGm9DFYnPBycegfK1zn
         DtZjq6VO2eA7bXbhxgy7KRTCsIaCB66zP5wae/K8StB6jsK11FJcwGC44ZHE1hEKFKuL
         oP8LvseXYQEl5Ir7fk5qx+1Fpw1lSzUiPJjz+36dWatfiAoh1arP7uYnDp0Ql6eSqNBF
         nM7LUqmLOUuwOaSzTd9Y3Pb+1+B+ghivhOpn6+FgHqGmLOsvZGmF3K1vA3DipHHoTU1Q
         Q33JxeLMQNVFhPUPfBM4Up7MDlcouZKAhpmiHZWOoSprYbwK6Iw/QuBqglbHm5soY8jQ
         sfMA==
X-Forwarded-Encrypted: i=1; AJvYcCW149JXifBskSX2cmUA4hWaMerRULt+jiUQeBY3IBydrKuuHNo9DRJlfSNwyonL5Up1sRIhNYjSwvKg0W6MGm/9OAdyO35iYsjOYrLff7gAmqp1QDJj+N9zcStHkChkY/B981BE
X-Gm-Message-State: AOJu0YzNDu4HQ9xQtTs29xlxiVy2t7xXCFjeW4m9Z3+NoG9cGDJDYJ/g
	cBAvcD56L/OxWMQNgQzQ0RLTtSsNz0gNDEDEs/41txpadpFdBu9v
X-Google-Smtp-Source: AGHT+IGYEZYw4gdqgJKGZR2MlDcM32l6VRx0P6QYkw3wb9FXA/U7mxZQyXnQ8448x6qB8tslyk17QA==
X-Received: by 2002:a05:6214:5883:b0:6b5:49c9:ed4d with SMTP id 6a1803df08f44-6bb983d79a1mr81607886d6.32.1722698448864;
        Sat, 03 Aug 2024 08:20:48 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c83cc30sm17299676d6.101.2024.08.03.08.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 08:20:48 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id F2191120006B;
	Sat,  3 Aug 2024 11:20:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 03 Aug 2024 11:20:48 -0400
X-ME-Sender: <xms:z0quZgLHYjBHwGRvE-M5RxxlOU2VnNpB1WfxxoAvficB2SCO7T9OVQ>
    <xme:z0quZgKkqNKriQVDCx-mbu69ug_9kxrhcAUqpVjeEnzTY2v5lzjKjcQ9ANP1Vv2yS
    uEcG2_fcwMAbzwZYw>
X-ME-Received: <xmr:z0quZgv5XxokUIJFLT-911KzCD6ZTWd0CidmmOEWF9HGNGlvF4bgW7NSBms>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkedvgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddv
    hedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthht
    oheptd
X-ME-Proxy: <xmx:z0quZtZXpNlc69TGt2XzhTuJvzCCKfgNRZj6bxqsuRV4M0m51hd19A>
    <xmx:z0quZnZubxsx3gMWi2Sc_zWaydUNsekQfeUEhE_snYxrceet3CqweQ>
    <xmx:z0quZpCoXnX17ytfSzOG9wtJsyAwaivmGRAvFbwzuFhvnfJOcSR0FQ>
    <xmx:z0quZta2HLyMKnLcz3AVqi7m5dqwUT5RANF38dv-fVBNRoSFtZRbvw>
    <xmx:z0quZvrpdg60SRxO5WkIzNrU-AFRpWSugbe7U4kRqvExA37pJAPCJedi>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Aug 2024 11:20:47 -0400 (EDT)
Date: Sat, 3 Aug 2024 08:19:53 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Carlos Llamas <cmllamas@google.com>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	John Stultz <jstultz@google.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	Zhiguo Niu <zhiguo.niu@unisoc.com>, stable@vger.kernel.org,
	Xuewen Yan <xuewen.yan@unisoc.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4][RESEND x4] lockdep: fix deadlock issue between
 lockdep and rcu
Message-ID: <Zq5KmTEnalIOHf6a@boqun-archlinux>
References: <20240514191547.3230887-1-cmllamas@google.com>
 <20240620225436.3127927-1-cmllamas@google.com>
 <b56d0b33-4224-4d54-ab90-e12857446ec8@paulmck-laptop>
 <ZnyS8rH8ZNirufcl@Boquns-Mac-mini.home>
 <20240802151619.GN39708@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802151619.GN39708@noisy.programming.kicks-ass.net>

On Fri, Aug 02, 2024 at 05:16:19PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 26, 2024 at 03:15:14PM -0700, Boqun Feng wrote:
> > On Tue, Jun 25, 2024 at 07:38:15AM -0700, Paul E. McKenney wrote:
> > > On Thu, Jun 20, 2024 at 10:54:34PM +0000, Carlos Llamas wrote:
> > > > From: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > > > 
> > > > There is a deadlock scenario between lockdep and rcu when
> > > > rcu nocb feature is enabled, just as following call stack:
> > > 
> > > I have pulled this into -rcu for further review and testing.
> > > 
> > > If someone else (for example, the lockdep folks) would like to take this:
> > > 
> > > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> > > 
> > 
> > FWIW, I add this patch and another one [1] to my tree:
> > 
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git lockdep
> > 
> > (based on today's tip/locking/core)
> > 
> > I figured I have time to handle lockdep-only patches, which shouldn't
> > be a lot. So Ingo & Peter, I'm happy to help. If you need me to pick up
> > lockdep patches and send a PR against tip/master or tip/locking/core,
> > please let me know.
> 
> Sorry, I've been hopelessly behind on everything. Yes it would be nice
> if you could help vacuum up some of the lockdep patches.
> 

Glad I can help! I will send a PR to tip tree between rc2 and rc3.

Regards,
Boqun

> 

