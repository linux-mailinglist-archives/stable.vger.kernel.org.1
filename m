Return-Path: <stable+bounces-150685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 408C6ACC3D8
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 12:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096AC163217
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 10:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47331DE4EC;
	Tue,  3 Jun 2025 10:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KK3isRhW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TR1aRSm3"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55457190498;
	Tue,  3 Jun 2025 10:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748944813; cv=none; b=SqqNMwdyX2pbJAIqOoKmGtadeJiKZqoXnhk/MOfe0JqeELfYHZ+FJwBWdfVqWFtZSrlw+rrFxZC3jLIc9p8K6xInnUszjrmG9AWPtrNDLx5quEhVE5M8CRp/tFlo/TO03NL+Qe8r3YSMLvsK27M6jdFx+N+0LxQtgiuLua6mBZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748944813; c=relaxed/simple;
	bh=bre+vZWi3NBRjZ5Zb5rig9nGlYLZ3oSJaPXvSMDafZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+b7quyOvk/C5FoHofbLaIqPSbolXUqDq3bvv8CKvDrA+7mbqIJGUSI9CAX5PzQwmY1gW9CIfTWox8EzAnuouU/DgizKagn7GapRrmZ52Wpd7eGXjowxqRJH9kSRHPAi1qDurpivSmtWKBsQPiE5FLXQ5HscX8LRScLaUwCDzaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KK3isRhW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TR1aRSm3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 3 Jun 2025 12:00:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748944809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bre+vZWi3NBRjZ5Zb5rig9nGlYLZ3oSJaPXvSMDafZ8=;
	b=KK3isRhWE1dNqSHVjwqOAE6sB49zV3ETuC1xEaZl8+pBgc4T8DHeHLfUQk+u+9d0gh6VlL
	QccSWEiANmzPqjawNT14MC5M5bf+CMLLOoXUR8vKxcGwWWG593OuiHFJnCZjlDg+tSvm/n
	5JfEbFfEw14ccSMaUjzF5JVGnuoGCjH4NgWqfuyRYcbWK9IPoukCdrUi6RSTKGNI8kqK4K
	R+EggifpSPQGjrYdEDjTRa5kk/mV0drbP79OF0u9eG2G91MRbOjc8BJ4z/4gEv+gYnXV5e
	dNdq/KIx8xuFVUF8rJAtorCr0HRdyQCFmy5CMF/pzDzFhjjfWuVmudc4MGvP/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748944809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bre+vZWi3NBRjZ5Zb5rig9nGlYLZ3oSJaPXvSMDafZ8=;
	b=TR1aRSm35cFboZrviEovEd2BlvReE5upy18cvWEk2z4j2d0ggknDpAY7WEGj860oYxehrq
	Ud7MoHpKZyiS63Ag==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] sched: Fix preemption string of preempt_dynamic_none
Message-ID: <20250603100007.jGi2zEWS@linutronix.de>
References: <20250603-preempt-str-none-v1-1-f0e9916dcf44@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250603-preempt-str-none-v1-1-f0e9916dcf44@linutronix.de>

On 2025-06-03 11:52:13 [+0200], Thomas Wei=C3=9Fschuh wrote:
> Zero is a valid value for "preempt_dynamic_mode", namely
> "preempt_dynamic_none".
>=20
> Fix the off-by-one in preempt_model_str(), so that "preempty_dynamic_none"
> is correctly formatted as PREEMPT(none) instead of PREEMPT(undef).
>=20
> Fixes: 8bdc5daaa01e ("sched: Add a generic function to return the preempt=
ion string")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

