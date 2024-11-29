Return-Path: <stable+bounces-95818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3788D9DE7A1
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 14:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B472817F8
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 13:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342A619CC3F;
	Fri, 29 Nov 2024 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="REapzx3k"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED3D19CC27;
	Fri, 29 Nov 2024 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732887227; cv=none; b=JgXdG5nDeL1TTQHqLuD3pN3CQRPwZXclG5DtKTmDssLEQh2rwNDGe3342q9mmuOuMg4Ps6EP8H1+B9N8hEnqoKo3/MbeaEhusnbSnJq6bNv0iOduL3sfw5GjU8Ux9Zlp4dzFhTUUzedCn+cJoqWRm3K1OFZvwbYGPF62ALWLP30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732887227; c=relaxed/simple;
	bh=BmJTPdvEhlmfXBpMW2CMFUKl1EkoNSvSSbAlpkOXlgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUAYAUS6wdLXsu+PVre0VuF/DpCWpKwfVXv1CNpssKKhwyWeA/8HfCLI+tb/Fe2+CAajnxi9ZYORtwAydbyxeuI27DVMeAFolj8brZvjDVUaI8P9/zFYcykaUDiELHcPSdUB0Ld+Yd+ANna/Ry5gavXM5LiV+KHffS6+ZH3F8hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=REapzx3k; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3B8CE40E0200;
	Fri, 29 Nov 2024 13:33:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ibWBUJTRIbXr; Fri, 29 Nov 2024 13:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1732887218; bh=3xsdZxP4aUmPelDn7N/O2boX4B91vWO7usueAP7op5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=REapzx3k0ScaDOYCa9l++RtyDtMdsn4lhRS33Bt9Gymw4Z3MrjxCdE9/QPdN4/7zr
	 jAc3DcPTq8rvs2fDeUD+upB1OPj/KeAd6AjK32FHPBZKZb9b9A9J/Xo1pGvr9+DoX/
	 DjOfLIz2fyvfY28+Xg3z546gg2gW1cv/HuptpIXxwqwK7cG5yk8v4bJ65JOdd1tXWj
	 MHzS27NaVO3jMhGhU8uMZVdCPUuouvqvg3+gVixVkNVx919Cu8V6BVOmKt0SOqMTpa
	 M3I2a7si2BbJZsno2PM5VrMzWFbUMCDorbyS7KLhCree7nkSFenJp86iaTxSPKlttK
	 CVjzZUC5L4c+y1whhfEvfPlGGXFxrf8jtOTFm6Iz5QE9sPm2LTCWeio9nke8h8SaHn
	 mTJHU3COUAJn1aMdT17zuYGzVYCb05rYbJGQHlV6vWjqXvZNvxwu2UXLvkNQNEbBFm
	 Kg7DI+uvBdOpcUkqf/oUcUf6N46Z50XeJCeB0fK4xiTYfYr6jC+zMP7GEBu5Gmo59u
	 xYfkbxbs490cZ/TwZXI0pQeSB0JcrCR1TGnht1NkIqL0bnD5pXqoUMLPowCHltw8ts
	 E7zFmnMdVqe1JGxgOM2W9teX/uSKaFnnOZRK6PaH9Wp73/zD4hD0GL2zjJTd9zyYc7
	 vyPw1LNB8WJER5fIk0es3POk=
Received: from zn.tnic (p200300ea9736a103329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9736:a103:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 32C8140E0269;
	Fri, 29 Nov 2024 13:33:13 +0000 (UTC)
Date: Fri, 29 Nov 2024 14:33:10 +0100
From: Borislav Petkov <bp@alien8.de>
To: Erwan Velu <erwanaliasr1@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, puwen@hygon.cn,
	seanjc@google.com, kim.phillips@amd.com, jmattson@google.com,
	babu.moger@amd.com, peterz@infradead.org,
	rick.p.edgecombe@intel.com, brgerst@gmail.com, ashok.raj@intel.com,
	mjguzik@gmail.com, jpoimboe@kernel.org, nik.borisov@suse.com,
	aik@amd.com, vegard.nossum@oracle.com,
	daniel.sneddon@linux.intel.com, acdunlap@google.com, pavel@denx.de
Subject: Re: [PATCH AUTOSEL 5.15 11/12] x86/barrier: Do not serialize MSR
 accesses on AMD
Message-ID: <20241129133310.GDZ0nClg7mDbFaqxft@fat_crate.local>
References: <20240115232718.209642-1-sashal@kernel.org>
 <20240115232718.209642-11-sashal@kernel.org>
 <20241128115924.GAZ0hbHKsbtCixVqAe@fat_crate.local>
 <Z0iRzPpGvpeYzA4H@sashalap>
 <20241128164310.GCZ0idnhjpAV6wFWm6@fat_crate.local>
 <Z0kJHvesUl6xJkS7@sashalap>
 <CAL2Jzuxygf+kp0b9y5c+SY7xQEp7j24zNuKqaTAOUGHZrmWROw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL2Jzuxygf+kp0b9y5c+SY7xQEp7j24zNuKqaTAOUGHZrmWROw@mail.gmail.com>

On Fri, Nov 29, 2024 at 10:30:11AM +0100, Erwan Velu wrote:
> We all know how difficult it is to maintain kernels and support the hard
> work you do on this.  It's also up to us, the users & industry, to give
> feedback and testing around this type of story.  It could probably be
> interesting to have a presentation around this at KernelRecipes ;)

Yes, absolutely.

And you should reserve a whole slot of 1h after it for discussion. Because all
the folks using stable kernels or doing backports will definitely have
experience and thoughts to share... who knows, might improve the proces in the
end.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

