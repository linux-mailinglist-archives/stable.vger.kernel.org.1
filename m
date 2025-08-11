Return-Path: <stable+bounces-167008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2BBB201DF
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 10:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3C7189EA59
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 08:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701FD2DAFA5;
	Mon, 11 Aug 2025 08:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cZNO6N2q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lqsQIrkC"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A4E2185A6;
	Mon, 11 Aug 2025 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754901102; cv=none; b=Dd1rADFGCJuTQsIz6LnsmdUb/fp7P57a/6fDy2LWEX88cZdgAb/fPxwxe6J6tiTOT/hL/pTvK9wqD3zWzjXfLWEiTNLgMxbW2s2opQARfWOfhyDOxkUecV8B60zLx12KB2iZZwZzlbrFemzgXJqDUqFgIJnFH+0Qj7R+RLZdWf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754901102; c=relaxed/simple;
	bh=S4WuqofBa7Id6+qyAJHjdL5aqwr5DwpyzeUXtsy52u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B56J2XZ+71Jx1uBpPSLWLHXIONVWpR5FwTZxOQLzaj6gMIFRu7JC3GUlS0QxAWYQgCif6OLbcsOKduMoq2HxPHYd2k44aFgtOuFnxMRp1jqvHstKoey80RJVmzmPi9rXA4VGBcOvEp4NqEVYWlg8QT1rfvlsRbu5SymgCqBVwIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cZNO6N2q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lqsQIrkC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 11 Aug 2025 10:31:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754901096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JeEYEDHr31+P2zVZyryZ2NEbaRwQuOh+nfUwKPEWE1U=;
	b=cZNO6N2qunmSklZQNVYCQo5IIj9bIBmAgbV7ljn82yCgNMKRsvql6lShJ81ecxTLm3Cea8
	s3Svi0EEJp2Z0Z1KNm6/DOaQwM74D5fo7OHtBHgOUewLhzgfVW7ElqxhU7QH2+rdFkTz0H
	5/ogT5fYhQQgIjujBsmwXkk30pSWnTcsXE0qO0BbqPkrTRVIpPrK4xSgLlrMEx23lfuwnm
	t868ImjD2MHvJmsiQgOhLztDE14D6VZVKfntxVHLvu+MvTj9MckEanpgP5OuuHzuRT2a+9
	Fk7Qo2knjuhMizdljcbbowfyNlMdH7i1H8LIZ9hMor2fYvRSgGtezMPKLvmRGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754901096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JeEYEDHr31+P2zVZyryZ2NEbaRwQuOh+nfUwKPEWE1U=;
	b=lqsQIrkCdbT/b7o7yJ8/W5Y9Megw6NnMf5v16x2yzUciE9/VpFNPrhZstXL2XVYloQ5foV
	lc3jcWA8RlDD2IAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Byungchul Park <byungchul@sk.com>, max.byungchul.park@gmail.com,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Michelle Jin <shjy180909@gmail.com>, linux-kernel@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org,
	kasan-dev@googlegroups.com, syzkaller@googlegroups.com,
	linux-usb@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Austin Kim <austindh.kim@gmail.com>
Subject: Re: [PATCH] kcov, usb: Fix invalid context sleep in softirq path on
 PREEMPT_RT
Message-ID: <20250811083135.xtl2wSQz@linutronix.de>
References: <20250725201400.1078395-2-ysk@kzalloc.com>
 <20250808163345.PPfA_T3F@linutronix.de>
 <ee26e7b2-80dd-49b1-bca2-61e460f73c2d@kzalloc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ee26e7b2-80dd-49b1-bca2-61e460f73c2d@kzalloc.com>

On 2025-08-09 02:35:48 [+0900], Yunseong Kim wrote:
> Hi Sebastian,
Hi Yunseong,

> > Could someone maybe test this?
> 
> As you requested, I have tested your patch on my setup.
> 
> I can check that your patch resolves the issue. I have been running
> the syzkaller for several hours, and the "sleeping function called
> from invalid context" bug is no longer triggered.

Thank you. I just sent this as a proper patch assuming kcov still does
what it should. I just don't understand why this triggers after moving
to workqueues and did not with the tasklet setup. Other that than
workqueue code has a bit more overhead, it is the same thing.

> I really impressed your "How to Not Break PREEMPT_RT" talk at LPC 22.

Thank you.

> 
> Tested-by: Yunseong Kim <ysk@kzalloc.com>
> 
> 
> Thanks,
> 
> Yunseong Kim

Sebastian

