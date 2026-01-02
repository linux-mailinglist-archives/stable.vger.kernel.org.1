Return-Path: <stable+bounces-204516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B0CCEF66F
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 23:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B4383038687
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 22:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B2B2D876A;
	Fri,  2 Jan 2026 22:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Iy9v9Hq4"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3C22882AF;
	Fri,  2 Jan 2026 22:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767391392; cv=none; b=Kacvs74kD2Irt0wIUuGqeh4TnFt23eLqPwh0TxByKxFe/da9kpOPUJ/smywJE8UUa7gaeVyvTXPS9AaNMJO8xSjW4R+zuGqrl26kkB/NJwZn6IQ8buzIS0vtIAYmL16hbuMAqV4GyXVdOfh0CObCkPFBWHhVeXN6uCZ0bLoUaWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767391392; c=relaxed/simple;
	bh=JuO1ZynaO2BBF1wfF7nO/buaGvl9DLsg6Gd55hvq7io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqVAN8d8J3UtXVMcX0m1LCd8eDMiCHMBBg8/YEsVEHUsHNhcGQNJSq6IMJ8afvFvjstbz0Dwu1UNbXN5NFl7hVGL4dh01ohKOE+9PHwPtzJK9b/dHsJoYreqsvn8eY4mdcaYJ3qNXn5BVa9xfG3Q00x9g7VdUA9cY+N99MbY594=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Iy9v9Hq4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YbSUuZNunQGW5DP0yW6H2zamWsE+O1PJd6nM6xlwcm0=; b=Iy9v9Hq4WrRioNK+3BWhrtZcck
	K6li7BFlUXX1G3WCkq2TTumfTc30g3h+eO7EJEFWwQ2O5g3LcC4FJkMMw25HwlWYZ/jrfdygN6Tps
	Jc5uzPJoNeyBnLSbtD03se+3S1z/GYDw7cAQoCOXf9EjDgKXVisINqg4LPO4bvU6a00g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vbnET-001DoV-De; Fri, 02 Jan 2026 23:02:53 +0100
Date: Fri, 2 Jan 2026 23:02:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Petko Manolov <petko.manolov@konsulko.com>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
	netdev@vger.kernel.org, kuba@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: usb: pegasus: fix memory leak on usb_submit_urb()
 failure
Message-ID: <38d73c63-7521-41ad-8d4d-03d5ba2288df@lunn.ch>
References: <20251216184113.197439-1-petko.manolov@konsulko.com>
 <b3d2a2fa-35cb-48ad-ad2e-de997e9b2395@redhat.com>
 <20260102121011.GA25015@carbon.k.g>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102121011.GA25015@carbon.k.g>

> Sure, will do.  However, my v2 patch makes use of __free() cleanup
> functionality, which in turn only applies back to v6.6 stable kernels.

I would suggest not using the magical __free() cleanup.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

    Low level cleanup constructs (such as __free()) can be used when
    building APIs and helpers, especially scoped iterators. However,
    direct use of __free() within networking core and drivers is
    discouraged. Similar guidance applies to declaring variables
    mid-function.

    Andrew

