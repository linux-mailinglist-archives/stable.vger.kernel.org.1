Return-Path: <stable+bounces-166835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24302B1E891
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 14:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1ADF6245CF
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 12:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1CA27990A;
	Fri,  8 Aug 2025 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R/cY0/gx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eMzECyh+"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5F12797AC;
	Fri,  8 Aug 2025 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754657032; cv=none; b=AuCZdUvw4I4DTF8mVAkgAge01U6qELXWecf+IioLCkeH9NUeuOa1RoPxqlgnMVpOpjccdFcvYYt5frwgtjlAKEtAZt4H6k2hg/lQ7cy4cKKog7E0pTTlrtvmbuerpuDpQfz0eyzR0u19I3Jp5hGKYZRwRSmI4T6nCVbElAXaY0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754657032; c=relaxed/simple;
	bh=/z2YjLOciPl+9umgiRRA8s3FvvuMbwucT1pgvC4lh6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqerkzZCfjIGrkriydSxWAjXodNROp2SCLIOGWy9etfjt+lB52z0VjcKkOu626wNzWuzYxU8TCAiy+uy8T28T9uGIkuYtRxESZH0MYGXzsGwj8hs6dH7CEP+IrfjTNta5VNUb3jKRbW9nN2HdlwjMWVjd6UQ+yume8ElXHzB3KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R/cY0/gx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eMzECyh+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 8 Aug 2025 14:43:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754657028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=upHZ6ikXZvk61fIczNyLhwKfdfn3DW4J/lUTfCMvi2U=;
	b=R/cY0/gxvGxcP6o7RDpxgxYPKeymBdnlcHxMZfbQW5SaSUJexuHzgWtc/UPPEfl9LAABhq
	meRz4yKQq8qnv3XJ4TqedNTjiZWX3ZkX+d3YMpxlgjlN2Vayjpm/+Sg1GdzVxsr0ju8t5w
	s57fbSDhlI2XvhgXrfYx03IXYh+Eo3szVcN8SPlusGOWziLCf4AJN3zSAdDdzddoP4ucCf
	v9YgLlvCmiqdaGH1xeHI6F0hcNCkF6r/g568Ty2UZzZ6AGgi0+BB9XHyJvySyqTR4Z03oL
	NiWOdXqL4yorpekvVYj9hVx9PAj+AImxLaxdhnWP6x346om4Rt/QScvx0+labw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754657028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=upHZ6ikXZvk61fIczNyLhwKfdfn3DW4J/lUTfCMvi2U=;
	b=eMzECyh+ef/W1yY2krbzpEudY+Ag9cCPeGw4fcadileBXR3oRK8b9+xLSRhPB0d7OypWzs
	zWhKeUTjPW/PrLAw==
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
Message-ID: <20250808124346.ynoPIlpX@linutronix.de>
References: <CGME20250807014905epcas5p13f7d4ae515619e1e4d7a998ab2096c32@epcas5p1.samsung.com>
 <20250807014639.1596-1-selvarasu.g@samsung.com>
 <20250808090104.RL_xTSvh@linutronix.de>
 <20c46529-b531-494a-9746-2084a968639e@samsung.com>
 <20250808105218.WmVk--eM@linutronix.de>
 <03f1ab21-3fa7-41b1-a59e-91f1d9dca2f1@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <03f1ab21-3fa7-41b1-a59e-91f1d9dca2f1@samsung.com>

On 2025-08-08 16:59:08 [+0530], Selvarasu Ganesan wrote:
> >> Here is the corrected patch submission:
> >>
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
> >> Signed-off-by: Akash M <akash.m5@samsung.com>
> >>
> >> Regarding the next steps, I will post a new patchset with the reordered
> >> sign-offs.
> > Your sign-off (as the poster) should come last.
> > What is Akash' role in this?
> 
> 
> Akash M's role in the patch as a co-contributor.
> Shall i add tag as Co-developed-by: Akash M <akash.m5@samsung.com>?
> 
> Cc: stable@vger.kernel.org
> Co-developed-by: Akash M <akash.m5@samsung.com>
> Signed-off-by: Akash M <akash.m5@samsung.com>
> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>

Yes. This looks good now.

> >> Thanks,
> >> Selva

Sebastian

