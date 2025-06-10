Return-Path: <stable+bounces-152297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71247AD3A28
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 16:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8A63A7FFE
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 14:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2469429B790;
	Tue, 10 Jun 2025 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1MFM+BOm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ClCTpYWW"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C69028D8D5;
	Tue, 10 Jun 2025 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749564113; cv=none; b=qxRqLdWSHjuoN0+RliZaKJozukA364UucGbOYRpe2BvB7gtPZHuZu417vYbs6Pbb77Te7BAKzcZ3oQBhH0U1oUXjM60ldN1GeEcG3LDSt0KfKqpNVq/WXlhyrGZ2GRLoHSh/ho8Lk6GkjGk+xlLtgwp2mYb9XwsO1cmQbgNUSac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749564113; c=relaxed/simple;
	bh=vBTYJTVXGVe80enUVVMZHQ5D5nonMPeMDLY2McUzn9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g69S4D90b7ej5jzcQ06pjs2KrY4Ww3e4eGomuU/6VX3CVmvcSNFiXWHGMt3olaXk6dalqo/DHpHcnS1wCY2Zh7Bfe8VZGhreuTK+MhpnFoCxdS6Q0se2v+3NDor0EdNe6iS7k/2RiM36KvN1WLuee9qV6H2bBTVG0DngTMtM2cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1MFM+BOm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ClCTpYWW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Jun 2025 16:01:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749564109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vBTYJTVXGVe80enUVVMZHQ5D5nonMPeMDLY2McUzn9A=;
	b=1MFM+BOmR6zsDwiwCfjlgPNsoKkRtx2Ye4IW2EN/lOQDc6gwO1PC1TbKugophXdfY1W22I
	PC4l78mEl1JRNlUXiWU9xI2Z26HJUrUJXiswVL/rl1Hs4+h/mfIAnIFmyU+YZtWbYMAzNU
	V0OqyqMHBDsWQgBWnPMFbpYA4MFrn4OgfTUlmJuwjbKWbCtbEk7MPIkGfn0vSJL/fQpk1b
	1EHJTsb2XzVy7T9uPbWFduNjRJCnL3j0OBiWbfkd2lQW7uA7CcOSxmXlMajN3gSJRpAotU
	5RM+dlsQzYjq8f5vX1AkXPtR7UJcVsQmYd0hr12UZF9ojCWKB7GuBM5eTvpkig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749564109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vBTYJTVXGVe80enUVVMZHQ5D5nonMPeMDLY2McUzn9A=;
	b=ClCTpYWWSypVNcaIijVGXdwGUXkH6MhpQPvGsXpZDTDmuKLqF0PkjnUFvIANup/6qKOi0e
	x+tKnQC6Z8YU4uDg==
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
Message-ID: <20250610140147.Pu9gdE9C@linutronix.de>
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

A gentle ping.

Sebastian

