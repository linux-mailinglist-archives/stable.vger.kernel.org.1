Return-Path: <stable+bounces-166825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8679FB1E531
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 11:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8991895677
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 09:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB59D26E14D;
	Fri,  8 Aug 2025 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LMqhJwF5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Js8s+5Gp"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4576526CE20;
	Fri,  8 Aug 2025 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643675; cv=none; b=ZCBBC4OoJOcXijxHdR6u+KzVy+6TPS5BQw9rdEaXeTMFYM1KkSgY2bcJHuS3KGdG4sBr7k4x3G2c6UoYnlr0QZqwOVeuqybpdA4jBB3P3q9NipuzXv9w3BuRbZu7v0XUBGrrvxYQLSgGm23k+lgeNmmwixxSeeMnXTLHcPF6ezQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643675; c=relaxed/simple;
	bh=S1dlGXXQXNDKTd3TFp9iNfMGH0WKPuGNNHF2SYbHeNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJkrIg5Ccyc0FObpp+hy3ynK6hFUxCbpcvYAX1dgipsOFoe1RJR4/qn6ekafYapjoYZ0Mc5IJYx7Y4VhYEgm2HHb33ZtgYWFWERk1d7koo2aBARW2Bz8kv+AoMHNHWbxdBnUEb4/kO9vPSIlVvobGyccObNqaHxsbVRy5QNzXbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LMqhJwF5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Js8s+5Gp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 8 Aug 2025 11:01:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754643665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S1dlGXXQXNDKTd3TFp9iNfMGH0WKPuGNNHF2SYbHeNI=;
	b=LMqhJwF5x+r/SsnOkWMRU3quCxIZxo34TFRZxs9bD7e1ZBR8/A6MwnwjvbkhaCXwsO1Nge
	5vigA6BU9W2OXQFK9nM18rb6iqwCbSgySslSxtNFnvAknLj2hfSNY0tZBEE2aGjAlTgLFy
	ciJovgKpSOJkVGo0DU2izv3qruZl9vOIsdnAuUmEOqJRrJ2Jk6fZPy5B7AGhMUPwkaOOWw
	GwwU6AJIU/CFpBi/l/UXOX6/6Fh4+ha6i+Sv8HQw5a8tFEs6IhdybwdN0E8rXvlcp3Pql2
	/iNvWS2gaeNkREg8kk0V2Ay5IX98HtGkaVB4gPlBzNtA6i3fI5Phxcm3TMJruQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754643665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S1dlGXXQXNDKTd3TFp9iNfMGH0WKPuGNNHF2SYbHeNI=;
	b=Js8s+5GpPy0huknbZjNZUVwG/qU42bJBtlyhHjEloM+v4z3mhpLns0EJYerzxqXJcW15pp
	OVNIzsSI/lQpeUAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
Cc: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
	m.grzeschik@pengutronix.de, balbi@ti.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jh0801.jung@samsung.com,
	dh10.jung@samsung.com, akash.m5@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com,
	shijie.cai@samsung.com, alim.akhtar@samsung.com,
	muhammed.ali@samsung.com, thiagu.r@samsung.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: dwc3: Remove WARN_ON for device endpoint command
 timeouts
Message-ID: <20250808090104.RL_xTSvh@linutronix.de>
References: <CGME20250807014905epcas5p13f7d4ae515619e1e4d7a998ab2096c32@epcas5p1.samsung.com>
 <20250807014639.1596-1-selvarasu.g@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250807014639.1596-1-selvarasu.g@samsung.com>

On 2025-08-07 07:16:31 [+0530], Selvarasu Ganesan wrote:
> This commit addresses a rarely observed endpoint command timeout
=E2=80=A6
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Akash M <akash.m5@samsung.com>
> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>

The Author is Selvarasu Ganesan <selvarasu.g@samsung.com> while the
first sign-off is Akash M <akash.m5@samsung.com>. If Akash is the Author
and you are sending it then the patch body has to start with From: line
to credit this.

Please see
https://origin.kernel.org/doc/html/latest/process/submitting-patches.html#w=
hen-to-use-acked-by-cc-and-co-developed-by
and https://origin.kernel.org/doc/html/latest/process/submitting-patches.ht=
ml#from-line

Sebastian

