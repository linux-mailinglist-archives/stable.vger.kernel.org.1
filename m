Return-Path: <stable+bounces-119752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7073AA46C7F
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 21:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5347E3AE514
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 20:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B78226D01;
	Wed, 26 Feb 2025 20:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pizpSgxd"
X-Original-To: stable@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FD94438B
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 20:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740601954; cv=none; b=s8nv9Kf28pKwb4xYpALfJWC90kSMvQaaF22xNwu+LYEWZzmMx6DWxWRn+eSKCX9dFZPW3/t9sCHhGdZNMFIz5cFkvDVlC5+GDXbSMki1UoQRd5wmELwqW0ha5AwT8/gbsf5XKGd1FJV55Ypi9Sw0ivUhrPppJh9l7Jt/O8yzj18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740601954; c=relaxed/simple;
	bh=dJmtlXj6WfvY6I3NJoeb6ZT+VL6nQiUOWiXKDXFSg9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEalHzVjoI6Cfwn/foog5WqaedZfbgroNOK/Tst9eHCSb2RsXdtKSNtRlDawXB8roixJ8cp8s2oX63z+UIDk5fG674KAosAh099vHjKygpg6KvmFNgZGtaQfUgrX8FlNHp7naPtkgIR8JOOs1lOdw6P/bSLk81kNXuH8b2HTp/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pizpSgxd; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 26 Feb 2025 20:32:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740601949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YwKQQagVy4d7sPBKa/BO0IpJPH7lXzoPFfwUhxzxnZE=;
	b=pizpSgxdCb0Mj6HEOWUuTJ1W8pbQ7bCrYI18B58ul1/EvUVVxfUCQX6c0w/se9Jq/6XLMe
	ULVoKZB2bQEEENYOdwkXknnhu5X6QR35mSZcsFswdHTsltbulwuT0RLHzFKyJIAgyxmURH
	PC0bPCNoqGnxk7pEjgH90quatMZ4m7c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>, linux-mm@kvack.org,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+1a517ccfcbc6a7ab0f82@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm: zswap: fix crypto_free_acomp() deadlock in
 zswap_cpu_comp_dead()
Message-ID: <Z796VjPjno2PLTut@google.com>
References: <20250226185625.2672936-1-yosry.ahmed@linux.dev>
 <20250226200016.GB3949421@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226200016.GB3949421@google.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 26, 2025 at 08:00:16PM +0000, Eric Biggers wrote:
> On Wed, Feb 26, 2025 at 06:56:25PM +0000, Yosry Ahmed wrote:
> > Currently, zswap_cpu_comp_dead() calls crypto_free_acomp() while holding
> > the per-CPU acomp_ctx mutex. crypto_free_acomp() then holds scomp_lock
> > (through crypto_exit_scomp_ops_async()).
> > 
> > On the other hand, crypto_alloc_acomp_node() holds the scomp_lock
> > (through crypto_scomp_init_tfm()), and then allocates memory.
> > If the allocation results in reclaim, we may attempt to hold the per-CPU
> > acomp_ctx mutex.
> 
> The bug is in acomp.  crypto_free_acomp() should never have to wait for a memory
> allocation.  That is what needs to be fixed.

crypto_free_acomp() does not explicitly wait for an allocation, but it
waits for scomp_lock (in crypto_exit_scomp_ops_async()), which may be
held while allocating memory from crypto_scomp_init_tfm().

Are you suggesting that crypto_exit_scomp_ops_async() should not be
holding scomp_lock?

> 
> But really the bounce buffering in acomp (which is what is causing this problem)
> should not exist at all.  There is really no practical use case for it; it's
> just there because of the Crypto API's insistence on shoehorning everything into
> scatterlists for no reason...

I am assuming this about scomp_scratch logic, which is what we need to
hold the scomp_lock for, resulting in this problem.

If this is something that can be done right away I am fine with dropping
this patch for an alternative fix, although it may be nice to reduce the
lock critical section in zswap_cpu_comp_dead() to the bare minimum
anyway.

