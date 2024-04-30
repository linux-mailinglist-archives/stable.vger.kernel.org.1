Return-Path: <stable+bounces-41995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FD48B70D2
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 12:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10E3128816E
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57AB12B176;
	Tue, 30 Apr 2024 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="doHX7cjJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2VWCNKA5"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADC712C46B
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 10:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474217; cv=none; b=RZNJ1GLfQTYzTLxJ/Bfu4BAoZJwgukqpFFOI02wIxs5zRl9O3DXhFWpRCZmiKOzRWmNKIFROKQ8XoAPC3GKB2vGITvRpdhe6G0gMaqZLCFkctX5bjlzXQAtsmBK5hORpAollNvLhPp6xCgcoRKANrRk/9Rg/srvyuqpNLxX6P+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474217; c=relaxed/simple;
	bh=7wGs1ukNqFTp5ioS5F5kldi1JfixR8rNBIjJtj2eJ4w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e+Kd1ab8ocFkQF0RdCZ4UsZbX8zDSzN8kxW31Zb1ZEYBr6JIM7BRYVG6i1es6hFeCW+6oQBh0PWJJSHWgM1OoImJjlmBlwfnkSr3lTbuz++qCY9/gshP5lj8hU6jyF4r1SsJOEu5LmLu7m55HS/LDvZkDTvKSS/oj+7E7DNT5P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=doHX7cjJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2VWCNKA5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714474214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b1nSsl8gX9k7rDgh6y225F4fW1E1kraFns5KyShrcNs=;
	b=doHX7cjJahmUZrkNE11FZSljWFYmeYMWwn5jkAc2DLNGuccPT9Bau+fPQACq99SZmOb+sX
	EV78/HHLuxxeDT8KtYiv52E3uL1Z91MKczcwtur7EwOyJApfpYD9X7eEUfeKFQGL9g9w3N
	xapXAl2vWqjmuXkpeGI8VXlglc3BW7ImMNJ9GZTPp4XMtbTayk9fNsLa1nHEDfxCi5znEO
	PJPAxS2bBTj0u2rAUUROSgQtds8f4v3ZVewqGWteHrj8WlcNvg/lqn6Q36PYmLWHXyCGIS
	H0W59LVX7k3NNqgeKCsMzwUghPkXXi2bEUUUM6jZBXgDCzrH2IErM3NCT8r5VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714474214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b1nSsl8gX9k7rDgh6y225F4fW1E1kraFns5KyShrcNs=;
	b=2VWCNKA5uQwmhrXULpNUBNfiUtM0Sxdv313QNqxLT8m7SGm/Nhn4b4ylIac6vt1sshUWxG
	enjmZDl2d7pzTpCg==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 patches@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>, Ilpo
 =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Sasha Levin
 <sashal@kernel.org>
Subject: Re: [PATCH 4.19 53/77] serial: core: Provide port lock wrappers
In-Reply-To: <20240430103042.703277875@linuxfoundation.org>
References: <20240430103041.111219002@linuxfoundation.org>
 <20240430103042.703277875@linuxfoundation.org>
Date: Tue, 30 Apr 2024 12:56:11 +0206
Message-ID: <87y18v5dlo.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Greg,

On 2024-04-30, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 4.19-stable review patch.  If anyone has any objections, please let me know.

The port lock wrappers are only needed for the new threaded/atomic
consoles that are still being developed for mainline. I would not
recommend backporting all of that work when it is done and therefore I
see no reason to backport the port lock wrappers.

John Ogness

