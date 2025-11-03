Return-Path: <stable+bounces-192192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7757C2B91D
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 13:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8634E3A8845
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 12:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE753090E5;
	Mon,  3 Nov 2025 12:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UZnu7/Pm"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505BA308F39
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 12:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762171562; cv=none; b=ub0aOkJGMSJ9V3Wfxn+Xo03Li63MeJR/7q7TvE/T+MsPYvrUYdtqB/8qxBRV68GbW5KJbTvi6ov6qs/NTo7uoMalbJbkLaBeoliEN4I08CbSNkYmwjRA7xO0C/CK53To/gKWJSXtEn9m0J46MTP1fRqbfLUKp21YWgzldd8isZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762171562; c=relaxed/simple;
	bh=fy5cdW/wqnsRkpTeNFB4h0upl2/jMUvfA1vlAyK19/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5dSTlOMmHb0a42etUW5prr7qaEH8GJuXrDkIkMmYFWe7WGsT+MTsdOMbsHJh+Z6RVEOc9e6hhmqo6eCbxHM+EhXsYJWvua/h144E5t5Nretu+YCft31oNXO7BOBrEHJqhLCKydEdN3XOflbDQBILtF2q96elFRY3wElPOR3IBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UZnu7/Pm; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 263C540E00DA;
	Mon,  3 Nov 2025 12:05:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rlrIuZekgFNR; Mon,  3 Nov 2025 12:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762171555; bh=x487KIXG3cTMndWg0QgQbgBnKtcJL2NrZKrBY/wZ1TQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UZnu7/PmCDUy74+mgV6z8bSXQfp4ScQVuwp1X0jtfiGcD/BKJYUZURzMSySnrUMGl
	 GzFCm1N3pH0ASnZsherIQKRDsaU3oc1cw00LasfaZE60Z7XEQTWnaNZWw0R6gaHat9
	 bMbl21fxe4ISqazexfuWLKPY1kvCfVyDz7Ol3u40YvnOkKK3Kwid+DUHKxx2UVnLYC
	 vzm/UIuO+EhStldteJBbPxrDyNL8GVpdnIp33NYFaH8uNSSuaAgP8GQWIK5OJfOAMF
	 1yoxediomonqxFYhgwgRVBGJ/fDJUO+N+Nfg1BodPJMhd54s0VmmGS2kFXbyz2VJhU
	 XWe/Z8zehs42Vp+GVxvWHRGPLXi8Me6BwFoSYZuakmmtIOK5BdpKSHqhoJmSExeJUd
	 5GBkezXXBtGcUq+I0I5G/5nuCQg8h2BAYckuNlpt8fL/RtpUIa7zCXu7E8l2rN0OZL
	 qnAlqLaiwO4q7cE1CY2oqVtcA+JrVls8loug6zfk5UDF+wN48BT3Ri6+XGN5+c47bO
	 6x5HxGZjCmK0t/9/OkQyNum7mPyLNJkh+0ASiQSUptkkAx0LSrYQNfXRS9ZA9CWchZ
	 a6L2aW6tTB5/0jbEgrAo0byHJILc9ElRd6u0GIxPs1Jjw4d/fP23GcvTsxFDgxalDC
	 +2spraidEYKGALzBAidbZiDo=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id DE23E40E01A5;
	Mon,  3 Nov 2025 12:05:51 +0000 (UTC)
Date: Mon, 3 Nov 2025 13:05:50 +0100
From: Borislav Petkov <bp@alien8.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: gourry@gourry.net, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] x86/CPU/AMD: Add RDSEED fix for Zen5"
 failed to apply to 6.12-stable tree
Message-ID: <20251103120550.GBaQianhX2N2SEKwzz@fat_crate.local>
References: <2025110202-attendant-curtain-cd04@gregkh>
 <20251102173101.GBaQeVVeAvolV0UMAv@fat_crate.local>
 <2025110330-algorithm-sixfold-607b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025110330-algorithm-sixfold-607b@gregkh>

On Mon, Nov 03, 2025 at 09:21:54AM +0900, Greg KH wrote:
> No worries.  Don't know if you want this for any other stable kernels
> older than that, but it didn't apply there either :)

Yeah, something even older running Zen5...? Meh, I'll say "no need" and
I betcha someone would promptly crawl out of the woodwork, hand'a'raisin'...

:-P

Let's see what actually happens.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

