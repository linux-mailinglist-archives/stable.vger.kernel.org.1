Return-Path: <stable+bounces-80605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDD398E487
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 23:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FD441C235A4
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 21:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467531D1756;
	Wed,  2 Oct 2024 21:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="avqZJN+p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2027745F4;
	Wed,  2 Oct 2024 21:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727902889; cv=none; b=cBu90f2HlwTWRP7b8UHem5HHmjR3Qo8jBtHVpxcDx07MFhwTwihFk8Ep/32E8dS9/QwhtxlvuVuwfNVUNJQ6euK60DOx6dqK8Q5mNwe6I3TXc+IPnXJoexloeJjU6n/aVl4P5VBMQVG28AZzyCccSZRSWATj3UKbpNwnzwSVeJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727902889; c=relaxed/simple;
	bh=trnJ0WFXx1ZZxIm39VZd7TZ0LQp5r0PG8+GM6+k0C+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPqKF1RYy8/TkTb/cJpGZfvx6OBxB5ubjDFhh+XXKBjE7y7d4UwqaASZvrvqK/zmBhoVRfK1lybzYFsbckYRxFcbR3+RtcTH9qhMpHJzt/czFo+27fVw+PihBKkAQiyEiBdFgtfdAFgxgHcDFxuRUwpvfAOYkekdWcQTnOPcZfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=avqZJN+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5954CC4CEC2;
	Wed,  2 Oct 2024 21:01:27 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="avqZJN+p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1727902885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E8l8Bf1zxd4P4KLwrfQid3+fVNuVZfaH/EFN27Wk0dE=;
	b=avqZJN+pDPy1cUuWq1daACEqUQK+buEgRPJeWfbowQH7dNb7dsKVFpMiLKuFedpIEBrKGm
	Hqkz5mUtVoOgZfg6hSwumvmcI3pF4DSGGHBypUd6+F4HUBJtSRle8gemXICC1Cm7wbjPnJ
	W3ZL41QYSd+upr0SGaGaUT5OUJijHj8=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 93c531ca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 21:01:24 +0000 (UTC)
Date: Wed, 2 Oct 2024 23:01:22 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Greg KH <greg@kroah.com>, stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>, stable-commits@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>
Subject: Re: Patch "selftests: vDSO: skip getrandom test if architecture is
 unsupported" has been added to the 6.11-stable tree
Message-ID: <Zv20olVBlnxL9UnS@zx2c4.com>
References: <CAHmME9rFjE7nt4j5ZWwh=CrpPmtuZ_UdS5O4bQOgH8cVwEjr0Q@mail.gmail.com>
 <433ff0ca-92d1-475e-ad8b-d4416601d4ba@linuxfoundation.org>
 <ZvwLAib3296hIwI_@zx2c4.com>
 <279d123d-9a8d-446f-ac72-524979db6f7d@linuxfoundation.org>
 <ZvwPTngjm_OEPZjt@zx2c4.com>
 <2db8ba9e-853c-4733-be39-4b4207da2367@linuxfoundation.org>
 <ZvzIeenvKYaG_B1y@zx2c4.com>
 <2024100227-zesty-procreate-1d48@gregkh>
 <Zv18ICE_3-ASLGp_@zx2c4.com>
 <7657fb39-da01-4db9-b4b2-5801c38733e4@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7657fb39-da01-4db9-b4b2-5801c38733e4@linuxfoundation.org>

On Wed, Oct 02, 2024 at 01:45:57PM -0600, Shuah Khan wrote:
> This is not different from other kernel APIs and enhancements and
> correspo0nding updates to the existing selftests.
> 
> The
> vdso_test_getrandom test a user-space program exists in 6.11.
> 
> Use should be able to run vdso_test_getrandom compiled on 6.12
> repo on a 6.11 kernel.
> vdso_test_getrandom test a user-space program exists in 6.11.
> Users should be able to run vdso_test_getrandom compiled on 6.12
> repo on a 6.11 kernel. This is what several CIs do.

The x86 test from 6.12 works just fine on 6.11.

I really don't follow you at all or what you're getting at. I think if
you actually look at the code, you'll be mostly okay with it. And if
there's something that looks awry to you, send a patch or describe to me
clearly what looks wrong and I'll send a patch.

