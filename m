Return-Path: <stable+bounces-158694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9BAAE9F8E
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 15:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 503D21C41DB1
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 13:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D572E7654;
	Thu, 26 Jun 2025 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="b4NjwwA1"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5092E7632;
	Thu, 26 Jun 2025 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750946227; cv=none; b=HieXMCMNRWgZ2RMyMRpk2t8XC9IcO3he/qiXtdhfPxuk8Jm16DLicDD4+VEnW+f2upHrqIY0C3o8GaUOnbV3tOU7hup6nCRKJqgDBKD/amyzgRkvY+R1f/zcD0US257XQ/tISJfJoady1kYbpzd8ILb5Nx+krh0TB/CWl6WXIzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750946227; c=relaxed/simple;
	bh=S8qkMDWf8XhnEuG8CI1lX1TmUB0fH3xGQjIcCTUqoWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCMLp3B1X+PBz7S2raOMwtSdBbOnlmw8cogpivtu4jL5fchTCKt9vThGs0hLXBvlIXg4I8vKJ7QKCVfs2fA/1OOtNeZSZDvqHFJS8mpc8QirNBgdYDbWawRJ73tHHFLmrmUPx991sHLxaqEfIvUbKDQOXap88/T9gK8vcb6N3ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=b4NjwwA1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 036EC40E019C;
	Thu, 26 Jun 2025 13:56:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3yU87XUnB353; Thu, 26 Jun 2025 13:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1750946213; bh=F7jl1uTokjpfImmsQnj4q6/RXs1lbQYqOaIqCAoJDAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b4NjwwA1jiEmzg4Rrv7/MjOczP4J2hVdIBP+UBAaGfuC08ltKnJw97ZfZCl8jLdyN
	 6n2dh7WBAm8fMBwD2LMcGoZ8OW0A3YXKTAW9C/FSbi4akFec2kfq6r+TEvUZCh039K
	 dYo0rSvlepZ7E4KGWdetZfc+/ndzc28pSP5Lm8TazumrQjAgV3tcZ3OK6RRzF4/3XK
	 5wcziZm7TNTVUFH1urKxmqXfY8s2Tei9w5wNKO+4e59Z5pR7hcTigcj7sS6oFnyfDQ
	 3XXNWaecqa+QWu8p2cFCLOI2RAvbctq3x3vEer5H33CIrP5xXH3oWajTXUQSIhR8/M
	 v/mfj/4P4IBk62OAda2IRHaviwC7VVqbi98saHllQXyK0Wj25Z5HLQuqLH0+Oy3IJ3
	 AEH4OIfvSnuo/3S7FWqeQL0oaCwN5eld610pN3xvMdeQru+DSjZlqIBVavFMZQXpWt
	 RtUVR/Oa9sv8gxIYqfvJrJ506/9wYSK0IaLvvRoNV3H12dL5/4cHBq6f/jvfZitz4n
	 EiXXjjxpPg6xnBzulq+syMwIzEEpAoa+SoNyansRlRuvjO1edlH6lBBBUAP/+O5GSd
	 Lc++a56XT2BWnkC6ZJeGDmkyp5+4wG476RMlpBh8j3PWO5Co4Cg5TxXdHe/WqfiFrL
	 lvn8XHtaQlc13Kn7PViqfx7Q=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B5B1240E015E;
	Thu, 26 Jun 2025 13:56:43 +0000 (UTC)
Date: Thu, 26 Jun 2025 15:56:37 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin (Intel)" <hpa@zytor.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	stable@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/traps: Initialize DR7 by writing its
 architectural reset value
Message-ID: <20250626135637.GCaF1RlR8n5-Tc-oky@fat_crate.local>
References: <175079732220.406.9335430223954818839.tip-bot2@tip-bot2>
 <20250626090439.GBaF0NJ34n065_4vb-@fat_crate.local>
 <aF1L0fbNL6xE0C8d@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aF1L0fbNL6xE0C8d@google.com>

On Thu, Jun 26, 2025 at 06:32:01AM -0700, Sean Christopherson wrote:
> I'm pretty sure I can take credit for the latter half.  You're welcome :-)

Oh myy... :-)

You sure managed to get my small brain in a knot.

:-P

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

