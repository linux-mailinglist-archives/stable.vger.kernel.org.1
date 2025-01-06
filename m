Return-Path: <stable+bounces-106790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF2FA021A4
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 10:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C85F16394D
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 09:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C4F1D63F7;
	Mon,  6 Jan 2025 09:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I1r3ojNa"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622EBEEB2;
	Mon,  6 Jan 2025 09:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736155305; cv=none; b=IzlsrYgO0fOZtrYOHDCmv+3n/4eHGUE6iMwpJ3YJNCTTj8RHi371CHoJHnukz0eGWA78Ab5cGWJablj7TOOAfNLLTpK6/npv8lqwQqlxI9TFm5sPEBo9vjZCKvsckYQLeO12U/xboLFynqOAAmIy2tViKDdx8qLAchWBSS0ZENg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736155305; c=relaxed/simple;
	bh=Hx6r/s7Nr9y/gsll0Xbm9eDSzld6P7l4v18O2+wC5jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IT/iW4Wnih0/VHFc8Mp+aICuSvD8ICigzuIGt2XQgfHwUzZk2mBK7Z2B3kfSpdHW/1BVxQjBa0U1XrteU134Ekh69a+aNiUE96ciipVp4NQqBQHt5Ku50FnWHFdKcTSqWCWXeDJlv44uI84016d6yQgz3j8MIT2H0PhdO59cXa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I1r3ojNa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Hx6r/s7Nr9y/gsll0Xbm9eDSzld6P7l4v18O2+wC5jI=; b=I1r3ojNaTdlTQw6qcbSSkMZcd5
	flBZwy9C5u3JqQiVlI5MYyohuHrxloC3U12hsZAcyFqzip/VRRDOzwgHNDUt0eM8wEbysEC0gRou+
	sJ7vVbXKAIk6ek9LmXKaCdBYq3ZsPhCmin9C8OQdJkxLwZL4NwHu30ocZ5NIEAmE+Eby27McNvZl6
	yNktvhQ6Sd5u890qw2BlH2WoiWHSBH2FQR1l2IB/W9tYLnLxhgVTp654xc4r4RrlOxzZ44eCONYww
	s+AuEDoqDTFIAGTsm5uaDo7KjeDxJbifj5WkmL800AnlEZByDY218ZM0Ydf83yZoe1taMhTYOBOT2
	bCImrh9A==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tUjIl-000000056In-21Ib;
	Mon, 06 Jan 2025 09:21:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DBBBE3005D6; Mon,  6 Jan 2025 10:21:34 +0100 (CET)
Date: Mon, 6 Jan 2025 10:21:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: wujing <realwujing@qq.com>
Cc: gregkh@linuxfoundation.org, sasha.levin@linux.microsoft.com,
	mingo@redhat.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, QiLiang Yuan <yuanql9@chinatelecom.cn>
Subject: Re: [PATCH] sched/fair: Fix ksmd and kthreadd running on isolated
 CPU0 on arm64 systems
Message-ID: <20250106092134.GA20870@noisy.programming.kicks-ass.net>
References: <tencent_44452B098A632CA84FCB293DA658E7BD4306@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_44452B098A632CA84FCB293DA658E7BD4306@qq.com>


Your subject explicitly mentions arm64, however there is absolutely
nothing arm64 specific to this patch, as such the subject is just plain
wrong.

On Mon, Jan 06, 2025 at 05:04:03PM +0800, wujing wrote:
> This bug can be reproduced on Kunpeng arm64 and Phytium arm physical machines,
> as well as in virtual machine environments, based on the linux-4.19.y stable

Development does not happen on stable branches.

