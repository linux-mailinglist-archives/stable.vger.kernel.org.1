Return-Path: <stable+bounces-176975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA30AB3FC54
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 12:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24CDB4E2E49
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 10:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1773D2EDD6B;
	Tue,  2 Sep 2025 10:25:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A156A28466A;
	Tue,  2 Sep 2025 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.210.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808730; cv=none; b=Focl+LprVnhkLeprMh9xi3I1uG6QSyfujmZUARGUQatVZu5reJblyTGD0khz4+NNt/LxWRsUHIEyA5MzFkJu4Ui1vdSjJcL4ZadOgccjupe5NLGu93r+8KZlIbvh4q1YCHCtd0u1wTg1m89NcSlVHOkWtiLQqDvm5o4zYBi9hJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808730; c=relaxed/simple;
	bh=eJajwDH01kh3IPvaIJQpbt4glqzV/FP5xQlNld2ZALo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMW9aoB4mhtLkzjD4oMz43eMkFd5XXi3udJ1KOq/X2QbBh/9dDrmTie5QWXwKnjy3jXmLp9cxLmytnHKkbZTXY8PZgTstiE0RoGqB9WIg7LWSbx8saMkiz+EY7XqntcVBJcjTOmcqFJcT35Xr8tqL6RNcg7evxJDGppwIvo+y88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.210.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
Date: Tue, 2 Sep 2025 12:25:16 +0200
From: Brett Sheffield <bacs@librecast.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Oscar Maes <oscmaes92@gmail.com>, netdev@vger.kernel.org,
	kuba@kernel.org, davem@davemloft.net, dsahern@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v4] selftests: net: add test for destination in
 broadcast packets
Message-ID: <aLbGDJ7Qk7YEq60q@karahi.gladserv.com>
References: <20250828114242.6433-1-oscmaes92@gmail.com>
 <03991134-4007-422b-b25a-003a85c1edb0@redhat.com>
 <aLa54kZLIV3zbi2v@karahi.gladserv.com>
 <a46cca6e-5350-4ca4-ba17-bf0f89d812cf@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a46cca6e-5350-4ca4-ba17-bf0f89d812cf@redhat.com>

On 2025-09-02 11:57, Paolo Abeni wrote:
> 
> 
> On 9/2/25 11:33 AM, Brett Sheffield wrote:
> > On 2025-09-02 10:49, Paolo Abeni wrote:
> >> On 8/28/25 1:42 PM, Oscar Maes wrote:
> >>> Add test to check the broadcast ethernet destination field is set
> >>> correctly.
> >>>
> >>> This test sends a broadcast ping, captures it using tcpdump and
> >>> ensures that all bits of the 6 octet ethernet destination address
> >>> are correctly set by examining the output capture file.
> >>>
> >>> Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
> >>> Co-authored-by: Brett A C Sheffield <bacs@librecast.net>
> >>
> >> I'm sorry for nit-picking, but the sob/tag-chain is wrong, please have a
> >> look at:
> >>
> >> https://elixir.bootlin.com/linux/v6.16.4/source/Documentation/process/submitting-patches.rst#L516
> > 
> > Thanks Paolo. So, something like:
> > 
> > Co-developed-by: Brett A C Sheffield <bacs@librecast.net>
> > Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
> > Co-developed-by: Oscar Maes <oscmaes92@gmail.com>
> > Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
> > 
> > with the last sign-off by Oscar because he is submitting?
> 
> Actually my understanding is:
> 
> Co-developed-by: Brett A C Sheffield <bacs@librecast.net>
> Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
> Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
> 
> (if the patch is submitted by Oscar.) Basically the first examples in
> the doc, with the only differences that such examples lists 3 co-developers.

Ah yes, you are correct. I missed the "in addition to the author attributed by
the From: tag" bit.

Thanks again.


Brett

