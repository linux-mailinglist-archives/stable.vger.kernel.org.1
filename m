Return-Path: <stable+bounces-100163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0479C9E939F
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 13:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C89118860A2
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 12:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895A4228CB5;
	Mon,  9 Dec 2024 12:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x/ARDYKE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DaQGy2fw"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAF2228CBC;
	Mon,  9 Dec 2024 12:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733746337; cv=none; b=h1OJwAxGXPJRY3QsceJmzlMFDcnJt8EW1SR0alBO5sxQr+0LhKaTxwWagnx3jckeKXIqH06GQazRaXu6O/4FUHsi4OKf/zX8skK2F2Ek0nMC8buRzEuklVAEoCGr/Tp+6vVMp1pYF02F2H7zUfCS6Gicqqha1cN4E9XWs9qquAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733746337; c=relaxed/simple;
	bh=qYciZ4Fps8pi/DQxHMk1RMOKZf+JTjIOxXnMY6T5clk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nV4Quuy8oWuGBHE3MT4idyn/i9qeyGszMiCF/Jb0EZWobihr8pFG0AqwYu6XsOFL/YNVRwjSunIOYGm+F8NMwcVXD8jtjh7GA/wZWnMx3MK3q19BeCnbJyzpaMh2StSmuRzXVJLSazQy3Urt3praeQ98VskvmrSimTaX101wrJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x/ARDYKE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DaQGy2fw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733746334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1+NL2DlF0pMEbZZIfUeFBgF+QXQBNuONuCIn26qTRnM=;
	b=x/ARDYKEOnOJ9uw5yUekfNXQ+aYGgh23UYQUevaCAurUK9Fp4nAwPKSrixoRWRLnBzLlDI
	FcnV9Z3W2knUdN/mP+oyJQxb2L4Do0sYvFtNO0RMzM/KJp4hkPxrUlwuPgezcvvJBgVrAD
	p71+hVOfL1qvClJQY1JlTZae3sJ6p7awWZU51j0ORnnnxp7900J8OmodZ4AI+SJrC/oI+6
	a2cZMTLRkKUybFR2cTa8JD7kd8SouJn3z+ROSpFfW1bhAj+3/UhHcHnfat8Xqj3K7t7pEx
	2/m8ZGxJANuGN0PBavPHeXxB2ejB+poGw+3xeHomgAqIAn0JtUvldIms0eYW2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733746334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1+NL2DlF0pMEbZZIfUeFBgF+QXQBNuONuCIn26qTRnM=;
	b=DaQGy2fwwnquGTSdIElkkq6MWaKXfW8CzekTkF1E6Z8lsGdWXZcU0LkXsgehbQyeWR5yAf
	6gDF6QRnWRuICjBA==
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>
Subject: Re: Patch "ntp: Introduce struct ntp_data" has been added to the
 6.1-stable tree
In-Reply-To: <20241209113201.3171845-1-sashal@kernel.org>
References: <20241209113201.3171845-1-sashal@kernel.org>
Date: Mon, 09 Dec 2024 13:12:13 +0100
Message-ID: <87ttbdoy1u.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Dec 09 2024 at 06:32, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> commit 57103d282a874ed716f489b7b336b8d833ba43b2
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Wed Sep 11 15:17:43 2024 +0200
>
>     ntp: Introduce struct ntp_data
>     
>     [ Upstream commit 68f66f97c5689825012877f58df65964056d4b5d ]
>     
>     All NTP data is held in static variables. That prevents the NTP code from
>     being reuasble for non-system time timekeepers, e.g. per PTP clock
>     timekeeping.
>     
>     Introduce struct ntp_data and move tick_usec into it for a start.
>     
>     No functional change.
>     
>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>     Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>     Acked-by: John Stultz <jstultz@google.com>
>     Link: https://lore.kernel.org/all/20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-7-2d52f4e13476@linutronix.de
>     Stable-dep-of: f5807b0606da ("ntp: Remove invalid cast in time offset math")

I sent a backport of this change, which is a one liner:

  https://lore.kernel.org/stable/878qssr16f.ffs@tglx/

There is no point to backport the whole data struct change series for
that.

Thanks,

        tglx

