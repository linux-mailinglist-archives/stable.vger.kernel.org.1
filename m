Return-Path: <stable+bounces-203121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D671CD22D3
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 00:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1E42302514E
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 23:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F03218821;
	Fri, 19 Dec 2025 23:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kwcXV0HY"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AF92E65D;
	Fri, 19 Dec 2025 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766186248; cv=none; b=loWUMQNrj9LSM9A3hWeR4Et1i2D+/EmijgQOnfNrjudi5px9s2ja0vUzna8EOIijsYquFY/zulDTC869IWmmNRdCkQY6QRC0Lr+9+G4KqS/z9Psi5AeKYvMb8G2GWxnj+fx7ACu3tMRrBssyT8g9F6e26CVlRMdY841ZvbwcnC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766186248; c=relaxed/simple;
	bh=Jg1VJkIwcv0bS8WWwBpZiwQRdI+MvQm0uT8C/izctQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1Kohdp75sLgrL58MuS3voZljIn2URq9B6JliRT3qzGqTfXDWm9ROzzM/C3A4/p0ckSlgYlfJ6lVz52Iciz3DA4O/A3P5cfKzUsbchMMl5YJ/1mUUoFHh6FhCkhWNvLuRVGA+qV6cr88lLGv3IBfclfc5wBqNvGJhnZgMEiUDzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kwcXV0HY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E036640E0200;
	Fri, 19 Dec 2025 23:17:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SQDhptCoBjrJ; Fri, 19 Dec 2025 23:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1766186240; bh=6boN+F4A/pT4AlbOs61ix3VzmmJwzgX0zEnSa5IGRCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kwcXV0HYmY/lo4y7kDbE8NjeTDwJTUDod+wyslvgT+Y4EWnYPnCC9KEzZv30LbNZx
	 Ht2jxfnjkL53cShPwnKDYBgZoWSJ/GYJBNY0Di/tas0yP3jNwt84aAGuZENal6Ensa
	 8TEIZkJZX+zhnIMECHZESW7weKkF5LdRSppcXc7DzQg4t7kqlFVbA71tbTkVFh1siG
	 JKYOepyZsPaX/heFhkALGRizPE5YIdaqk3F9RdOsT79lkvab0ydk2OuTvrbfYsPUJz
	 8NW9LiMMGio65PtT9t4B4xza5rh6JYz2m6C11uFcWlf6fdygfEGIEL3kCmE85rSpIJ
	 /IYjn7SyRBiGZg6eDiuR8W1uCIIpPvPpoqaluBJ15fKegsDv6WSc7/8aK0RjN496Up
	 It8GkqEA0Kt0iB+hIlaLseQhwJBdDbm5PuaaVoSdOwn8fGNFqyrPl/biYY3xRYcAEw
	 yXe0un+E+w4Ubw9sQlYoWCH5mpu/zzEowfADeci/ON6R5kDkkgGwSUp0Qh4cKWLwEM
	 wcRBwv+1oYRTykj+mL7tgdm1zo8/hQxFX8ADm3Utn/48+Q5fKuyxzi0bZxX1d5xcc1
	 UBmh95cMRwkLJCmNZi5R7VAb2iD7ODGuiaTzrrJAIkm3Tm5JjwJm24NJuRi5ouY64O
	 YXrslqXWdbwbn6w6sHqNYbwg=
Received: from rn.tnic (unknown [160.86.253.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 5F17C40E00DA;
	Fri, 19 Dec 2025 23:17:01 +0000 (UTC)
Date: Sat, 20 Dec 2025 00:16:53 +0100
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Ariadne Conill <ariadne@ariadne.space>, linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com, darwi@linutronix.de,
	sandipan.das@amd.com, kai.huang@intel.com, me@mixaill.net,
	yazen.ghannam@amd.com, riel@surriel.com, peterz@infradead.org,
	hpa@zytor.com, x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, xen-devel@lists.xenproject.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] x86/CPU/AMD: avoid printing reset reasons on Xen domU
Message-ID: <20251219231653.GBaUXc5c0GoVAvICoa@renoirsky.local>
References: <20251219010131.12659-1-ariadne@ariadne.space>
 <7C6C14C2-ABF8-4A94-B110-7FFBE9D2ED79@alien8.de>
 <aUV4u0r44V5zHV5f@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aUV4u0r44V5zHV5f@google.com>

On Fri, Dec 19, 2025 at 08:09:31AM -0800, Sean Christopherson wrote:
> LOL, Ariadne, be honest, how much did Boris pay you?  :-D

Ha, now there's a thought: win the lottery and then pay people to do
specially crafted reports influencing the kernel design. Woahahahah, /me
laughs ominously.

One problem though: winning the lottery.

;-P

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

