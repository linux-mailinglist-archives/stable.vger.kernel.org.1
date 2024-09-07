Return-Path: <stable+bounces-73833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A12970348
	for <lists+stable@lfdr.de>; Sat,  7 Sep 2024 19:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BED75B21851
	for <lists+stable@lfdr.de>; Sat,  7 Sep 2024 17:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B521F15F40B;
	Sat,  7 Sep 2024 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RfHmMwa/"
X-Original-To: stable@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D7128371
	for <stable@vger.kernel.org>; Sat,  7 Sep 2024 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725728698; cv=none; b=T8zZa/6sL26RTkO9JQTvaqJHYimDFpnFzVtPacxwzJxd11mSggsUITgCE0eIFQEXE2xkplENpBmtyaOgDJAVK4rIyuC9mP2gFHhDmi9pcoNJdw1q1aX1GS5E2bpLYwv0m3V6YEzNGWGwxuNoikoSzIFlEfn/TAqpv+wpZfn0A68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725728698; c=relaxed/simple;
	bh=ORKqNRQEJbh3hYA6p46yVoiiV3Civhz86GC8gnQlZEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAR4LWrvIdQl4jW8lS3SOWGruSn75ZZQwW4d3C3p3xZrUf/rcuXTHdkHM6s2OinmAr2X1Quz4vX0+DCfODJympxdZKGBsSF1AUuqVb72u6k5u8gVqnYWUygJcECj0Gk+lXa90fLG3WqdOtVHjOfvQaHePPKdBwnLWRsJgh1sPAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RfHmMwa/; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 7 Sep 2024 13:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725728694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ofjB7t1Kdp6/mJ2/+OPdnvQvYH/QmfkD8+jlSOcEQnw=;
	b=RfHmMwa/myMuODAxcjjJbZqlT7e/QhGFfMdkmpI1wdf64pM7QF2DEjhdwfhZxs2WBMEqvi
	frdi6QKVNlbTNWK7ovJwuvjZZnyFsRqWw2y4UCmX4zPCw14UxpoWnItuUwi5d0sZ6zJznv
	Agw7RF4ug8AvbgghMT75aNs7QaTwP7Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Alyssa Ross <hi@alyssa.is>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Erin Shepherd <erin.shepherd@e43.eu>, 
	Ryan Lahfa <ryan@lahfa.xyz>
Subject: Re: [PATCH] bcachefs: Fix negative timespecs
Message-ID: <n7mhniclwckv7jxu6zwbk5xs5ig7w3eka3j54ioxi4uaha2k2q@tammak7sbrgk>
References: <20240907160024.605850-3-hi@alyssa.is>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240907160024.605850-3-hi@alyssa.is>
X-Migadu-Flow: FLOW_OUT

On Sat, Sep 07, 2024 at 06:00:26PM GMT, Alyssa Ross wrote:
> This fixes two problems in the handling of negative times:
> 
>  • rem is signed, but the rem * c->sb.nsec_per_time_unit operation
>    produced a bogus unsigned result, because s32 * u32 = u32.
> 
>  • The timespec was not normalized (it could contain more than a
>    billion nanoseconds).
> 
> For example, { .tv_sec = -14245441, .tv_nsec = 750000000 }, after
> being round tripped through timespec_to_bch2_time and then
> bch2_time_to_timespec would come back as
> { .tv_sec = -14245440, .tv_nsec = 4044967296 } (more than 4 billion
> nanoseconds).
> 
> Cc: stable@vger.kernel.org
> Fixes: 595c1e9bab7f ("bcachefs: Fix time handling")
> Closes: https://github.com/koverstreet/bcachefs/issues/743
> Co-developed-by: Erin Shepherd <erin.shepherd@e43.eu>
> Signed-off-by: Erin Shepherd <erin.shepherd@e43.eu>
> Co-developed-by: Ryan Lahfa <ryan@lahfa.xyz>
> Signed-off-by: Ryan Lahfa <ryan@lahfa.xyz>
> Signed-off-by: Alyssa Ross <hi@alyssa.is>

Thanks! Applied

