Return-Path: <stable+bounces-204573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A03EECF12D2
	for <lists+stable@lfdr.de>; Sun, 04 Jan 2026 19:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E6DA3011ED1
	for <lists+stable@lfdr.de>; Sun,  4 Jan 2026 18:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0032D6E53;
	Sun,  4 Jan 2026 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LpJQM6ho"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5712D63F6;
	Sun,  4 Jan 2026 18:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767549752; cv=none; b=rIcNN7fRuhgQkqPFVqo6tatB0+DvJ1gv2pFZdMlEUWuw06dNPXP6snV+mJL9dFdn1sQQ3L+/o1tnB+Qq2Mkv6/0gF8jWs3HHsS58fSA6uL6Ze4QWPfaV1goao7A4BVoXtaut/1LA91zbOhuE/YUg93WtJ4rqzhGLSkpjHX98wFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767549752; c=relaxed/simple;
	bh=CTZbCp3RpyYugdgjDwKUDAhn3JkVf+OgS6iO/KiU6cs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GmvuQt5RzrFVMG9sLuIcJq7Kf1yZsFZiIBGB4yZ4Qiano7ry8t7mi7JO+wUs6YLeP7wOyBgkGe9d6xqYTKKOzAB/xvAU3LVjBDZQ0/FuR/qne8y8NdgB543dRSgTfYl2eN5D71Ab8hG+2xqUhhUuIapndBc9X/Do2X2opQpdXDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LpJQM6ho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EADC19423;
	Sun,  4 Jan 2026 18:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1767549751;
	bh=CTZbCp3RpyYugdgjDwKUDAhn3JkVf+OgS6iO/KiU6cs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LpJQM6hoUi+Q1YVYh08n8HeejbFS9R3NXWrFc0lipnhub04SnG50puKjpQV51KYiR
	 HAI2oInhTrkk62gEqsOEchHIehRWy+QiJ8nwL11yPm4BIU1RJf6Ypr/XNICDJsI5E2
	 +IuuUVccAB3441KNKabMLqFiklxzjd7b/v8xlCHk=
Date: Sun, 4 Jan 2026 10:02:30 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] mm: kmsan: Fix poisoning of high-order non-compound
 pages
Message-Id: <20260104100230.09abd1beaca2123d174022b2@linux-foundation.org>
In-Reply-To: <20260104134348.3544298-1-ryan.roberts@arm.com>
References: <20260104134348.3544298-1-ryan.roberts@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  4 Jan 2026 13:43:47 +0000 Ryan Roberts <ryan.roberts@arm.com> wrote:

> kmsan_free_page() is called by the page allocator's free_pages_prepare()
> during page freeing. It's job is to poison all the memory covered by the
> page. It can be called with an order-0 page, a compound high-order page
> or a non-compound high-order page. But page_size() only works for
> order-0 and compound pages. For a non-compound high-order page it will
> incorrectly return PAGE_SIZE.
> 
> The implication is that the tail pages of a high-order non-compound page
> do not get poisoned at free, so any invalid access while they are free
> could go unnoticed. It looks like the pages will be poisoned again at
> allocaiton time, so that would bookend the window.
> 
> Fix this by using the order parameter to calculate the size.
> 
> Fixes: b073d7f8aee4 ("mm: kmsan: maintain KMSAN metadata for page operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
> 
> Hi,
> 
> I noticed this during code review, so perhaps I've just misunderstood the intent
> of the code.
>
> I don't have the means to compile and run on x86 with KMSAN enabled though, so
> punting this out hoping someone might be able to validate/test. I guess there is
> a small chance this could lead to KMSAN finding some new issues?

We'll see, I'll park this in mm-new to get it a little testing, see if
anything is shaken out.  If all looks good and if the KMSAN maintainers
are OK with it I'll later move the patch into mm-hotfixes for more
expedited upstreaming.


