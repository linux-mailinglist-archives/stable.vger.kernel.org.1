Return-Path: <stable+bounces-166830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD7EB1E6D2
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 12:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89935659F0
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 10:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2068523AB81;
	Fri,  8 Aug 2025 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k9JNZ+U7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dlIXmByd"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593C222A4D6;
	Fri,  8 Aug 2025 10:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754650343; cv=none; b=sOwnzdf3R8xKg4ah6YM3KfYDDEQWtmJ+noxTnJ1ohmC3GzfjEM3TMzAnIaIP4Z8P63wBDLP73kuSUbxnAYzfeX+iomUTf38R2OGNbrRjRCpMwB9TXTSSRsMu7yUCs+z86ot6hAZ++hkE/vOklQXP+r5s4eKybw06gzLNgvshDlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754650343; c=relaxed/simple;
	bh=4n05sXx4K1OdWyUMcQfUZ9L1Yws0sYnpm310JJ/TY2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8NOfn3SsBvg61cdeZ+Hlct0uadg8DZN6vapcIgIitxTIE6IWd99M0B07Ng9ynQ9huH8T6ZWv3rP8yCHQYB1i7U76vuVcRrXx31EkzvonWlIltMCo7o/EvgDqqYk5T0GOZM16zCKAjztahlijGaBzrFukvcoAqRscOZ3SoAXmQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k9JNZ+U7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dlIXmByd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 8 Aug 2025 12:52:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754650340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=COfbD9hYHRNc1ZECAMNz5MgkoyPH6n5P0rlnn/iyVhs=;
	b=k9JNZ+U7Wnkn3KKZSdlbetyX2PXBGc3C/lWIDIWzrk+gzWj+Y74VqLCoTB8WPgb6F5QZYG
	73k33bnEgUsPw+aJ3Dy8xA5FnFNb46KLluiVLpeGIgv6Vc7Jl5F+bm+HVIPhkvZEq9VGwz
	RAywIjPCVmapo4SbTw/i5PQKlc66PzXAAkQt0z4cuorKs6bui/96LjkBSEK+FXYprjpHdn
	GH1ez3KjPiYmu/Wnpw0iQrdUCvl/T4AuOrVNPm/bIo4lHYxtwoiWSyanDaOZDU4fPLSBd0
	S483RtBn7GcBLv25hiEQ7n/Y42dNajx/x7nwuYwloNw7Lc3wCdfBmjynrcwPpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754650340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=COfbD9hYHRNc1ZECAMNz5MgkoyPH6n5P0rlnn/iyVhs=;
	b=dlIXmBydf59eqNlHAe6nIS78Arg8QSNSAruYAMXkIg+JOm22qif4Ahjb/rwB3jH8Tf4jwz
	KZbJkVQnQZPDtRAg==
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
Message-ID: <20250808105218.WmVk--eM@linutronix.de>
References: <CGME20250807014905epcas5p13f7d4ae515619e1e4d7a998ab2096c32@epcas5p1.samsung.com>
 <20250807014639.1596-1-selvarasu.g@samsung.com>
 <20250808090104.RL_xTSvh@linutronix.de>
 <20c46529-b531-494a-9746-2084a968639e@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20c46529-b531-494a-9746-2084a968639e@samsung.com>

On 2025-08-08 16:07:25 [+0530], Selvarasu Ganesan wrote:
> Thank you for pointing out the discrepancy. We will ensure that the 
> patch submission accurately reflects the authorship.
> 
> Since I, "Selvarasu Ganesan" am the author, I will reorder the sign-offs 
> to reflect the correct authorship.
> 
> Here is the corrected patch submission:
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
> Signed-off-by: Akash M <akash.m5@samsung.com>
> 
> Regarding the next steps, I will post a new patchset with the reordered 
> sign-offs.

Your sign-off (as the poster) should come last.
What is Akash' role in this?

> Thanks,
> Selva

Sebastian

