Return-Path: <stable+bounces-158672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C16AE9992
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 11:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1BA17172C
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 09:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434D8295533;
	Thu, 26 Jun 2025 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="J+tIHJZK"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F461DF99C;
	Thu, 26 Jun 2025 09:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750928706; cv=none; b=Vd2fiumt9xIDxMGiWvT1tTcIB6HQGxKik8Xu5qjFylmMWp+lQPPC0gvgYvhBs8coaJb2D+L0nox4DJJlTjMits18AGvEAZKSDyUcvQu4S7MSmCR6idacOwJaH6hkAeTR7cG8VsN0mt7fFg/WqhB/URUuPQiRueflaWfgIdslkd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750928706; c=relaxed/simple;
	bh=JnFsgXspVjKa1rNS5RtYOsRh0fSxuour6+9sS+lpfco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0kZBKnXm4IV5rdRuwi6t7m3GBJ9qoZb2B16jW+Q1BTnc5XqIHUtSjVbPgL7Wh2RqSp61WQct5QWigLs43PV4QXtM0TFv10DAgsGlf+x7ayLP96hK6hdddBE45JH6hb1E7j2XIAJIhW3PMrLDgzMb1a2j9tcLHYFsJsYN/nb7vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=J+tIHJZK; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1DBD940E00DC;
	Thu, 26 Jun 2025 09:05:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id y14xr2C5g0xI; Thu, 26 Jun 2025 09:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1750928695; bh=1VkhzI0/iZpiDzjB4lyKYYG4z33A7c2AtxjeF5dgRJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+tIHJZKqjgT4woD1+qxtEX+lcbtmqTlw9YEnn+bwYeaJ3YI/t6F4xnYiPrmnNTCn
	 60p0ZcYFncvoEpc3qjUkRR75GQryN5G52EGImdN5oFOfZWgPVvuqmje+QuJBoj89vT
	 nWdlNKeNTJeSVNZy9SijD8UspU8frF1LuZesET5JpdtVRJgOed/nnlf/imlw4PnHRq
	 Ufqbs5CLHIA/Y88mj3P+I0ukMGEMlHZ0SWGFZ/eY4EUD64h5kAD/o+Sn6hlIPU0did
	 BLSXp8aCpCt4snw7h4WvXpTh2/Xf/RWO14QVSKmi/1+Zh27ACoK8HbzFQ6OHttXb6M
	 38OdxeGkxE1944D7fan/chrp0XHZNxUgimAeHCcPNECWDRm27CoHHkQ1aLMzzn9tmQ
	 cPW74gwEe3FnEG7NtFXO5kf/fZ5rN8tGVIZjtIfQ5Xc90A5MTWUfkk+t4YOqW6JoL8
	 sYGWnwLEmEvSczSuZHGw2Kw21LIrwPF1ruUxb2tUM+dyUreixxk9uILfgtcBCbZx2N
	 9LRM+niwkmb18cFWN51fwmVGkMmJfDKBr0dbPfTlqpP6wJHSkxKm37EJAe1X+eDhq/
	 58IZIKTnG8K/VOnU4wG9GXL5o2zcBiEGXQ+Kat1XV38acugxsQR47raLvGORKRQIR7
	 kpXpPHijerfJnPKD7WMtURBY=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B006C40E00DE;
	Thu, 26 Jun 2025 09:04:45 +0000 (UTC)
Date: Thu, 26 Jun 2025 11:04:39 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin (Intel)" <hpa@zytor.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>, stable@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/traps: Initialize DR7 by writing its
 architectural reset value
Message-ID: <20250626090439.GBaF0NJ34n065_4vb-@fat_crate.local>
References: <175079732220.406.9335430223954818839.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <175079732220.406.9335430223954818839.tip-bot2@tip-bot2>

On Tue, Jun 24, 2025 at 08:35:22PM -0000, tip-bot2 for Xin Li (Intel) wrote:
> The following commit has been merged into the x86/urgent branch of tip:
> 
> Commit-ID:     fa7d0f83c5c4223a01598876352473cb3d3bd4d7
> Gitweb:        https://git.kernel.org/tip/fa7d0f83c5c4223a01598876352473cb3d3bd4d7
> Author:        Xin Li (Intel) <xin@zytor.com>
> AuthorDate:    Fri, 20 Jun 2025 16:15:04 -07:00
> Committer:     Dave Hansen <dave.hansen@linux.intel.com>
> CommitterDate: Tue, 24 Jun 2025 13:15:52 -07:00
> 
> x86/traps: Initialize DR7 by writing its architectural reset value
> 
> Initialize DR7 by writing its architectural reset value to always set
> bit 10, which is reserved to '1', when "clearing" DR7 so as not to
> trigger unanticipated behavior if said bit is ever unreserved, e.g. as
> a feature enabling flag with inverted polarity.

OMG, who wrote that "text"? 

I asked AI to simplify it:

"Set DR7 to its standard reset value and always make sure bit 10 is set to 1.
This prevents unexpected issues if bit 10 later becomes a feature flag that is
active when cleared."

It sure does read better and I can understand what you're trying to say.

So can we *please* use simple, declarative sentences in our commit messages
and not perpetuate the SDM?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

