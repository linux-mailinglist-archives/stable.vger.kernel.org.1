Return-Path: <stable+bounces-164859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3613CB12FFE
	for <lists+stable@lfdr.de>; Sun, 27 Jul 2025 17:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 612A11778B3
	for <lists+stable@lfdr.de>; Sun, 27 Jul 2025 15:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA279374D1;
	Sun, 27 Jul 2025 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZIx76ut1"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DBEEEC3
	for <stable@vger.kernel.org>; Sun, 27 Jul 2025 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753628534; cv=none; b=bQDyc24KbU+2DXdkPPQEsDj69CgJTe4C30nVFSfLBh++lnWM5QjUokb38tnnGkGICIsgiHqOyntI8pCXepnLdjNjjweSxHtXthCo9T53Jv6VWMkfzjBf9kyHZjC3yvCaDB8gcDAIzm8+gTSQkpTYmGvMRIIN70fz+Rs5u/OkRH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753628534; c=relaxed/simple;
	bh=fHu8cG823G9WrMZAGV2Dts8KojxSgr3bDP57pKiBAEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWwhVSZAckC+dmCxZ0TwOU19CkNHlRekhtWRXk+bg2S4EjqxgdPMD224cKJLERe0/AZawVKhxy8enpjy5g+lBae77v+si2kxNd8IKRBFqt6kyjynWcLjzWkCAOY/17yXFG9KlH/r6q0eVnXiMhStrXe5s0D8paWSyFEyL+FJSJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZIx76ut1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5DAFE40E01FD;
	Sun, 27 Jul 2025 15:02:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ovt123ubb0rg; Sun, 27 Jul 2025 15:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1753628518; bh=4pebc39Nb5WFsfKqvppIs0XYHXld1ct1vThlqYsI6aI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZIx76ut1SQIeB50T0MUB8qLkljeLPvpMFCKOcyqyJpv18xXJvSn0FuxLZvewY9LBE
	 CAJO9K5EQ8nfKEurJJNI8MrHn4BVOtMIs0ga2XEe1xC6p/KXLADaveekZPZ+ynFpj/
	 f08+RLScTckhZG+FV9ds8o29KKWNuCjDNewN56ohrUtYZjn8R3+9RQhQzbIS3hZLYR
	 Djo+b/MkRa55YI3TlxsVSE1FyT09q0JE9QpThQ0ju7LpZfHxbBVmAtnqoGdIRjPoe2
	 qjc90mAWB62nkuBdfTGrl81DqKziBYU2BGVeKkuOCVLHkFgUT601mFEOPS1ZE7hoxT
	 H2TlWzn2fslzw4JiWkvuUJj1992DqDxjAMQrG8gSWH5OrPbrBTuhXdQA8gI90rAry7
	 AOCcqzYuQL/F32YTA4ZxUzUK3Wk2PVp574rBwiQcl6rbxxSOjmmsR5MxLT2fCorUKU
	 klTwYkS1Pp58sFFKLy+BFT/tW2CETH6PvMFey4GLjAbzFs2jbXm/Q3CzEwsANPmiGu
	 wB5yY4AnMu5jzoVqoEdvZ5ZzPlNUGd1uEXDC/Qe3lIpRIRdnJmxG2Uylga9mE/3gcE
	 Lr+fQFM4PULj3TIVlKS5H3TffFbFBAD2kJix5Qbm/PzcAhnWs1EEC0ULZCHQZpWy01
	 DCA0lRYGoIOFYI5cQ5jyWVOQ=
Received: from rn.tnic (unknown [IPv6:2a02:3037:202:36be:eace:3b60:833e:cf8b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 744E840E00CE;
	Sun, 27 Jul 2025 15:01:53 +0000 (UTC)
Date: Sun, 27 Jul 2025 17:03:51 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Borislav Petkov <bp@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 2/5] x86/bugs: Add a Transient Scheduler Attacks
 mitigation
Message-ID: <20250727150351.GAaIY_12RMMdhOhrx9@renoirsky.local>
References: <20250715123749.4610-1-bp@kernel.org>
 <20250715123749.4610-3-bp@kernel.org>
 <dbea560d4fa64d8217aadc541d4b47b61f2c6766.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dbea560d4fa64d8217aadc541d4b47b61f2c6766.camel@decadent.org.uk>

On Sun, Jul 27, 2025 at 03:58:23PM +0200, Ben Hutchings wrote:
> p is not fully initialised, so this only works with
> CONFIG_INIT_STACK_ALL_ZERO enabled.

https://lore.kernel.org/r/20250723134528.2371704-1-mzhivich@akamai.com

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

