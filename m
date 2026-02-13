Return-Path: <stable+bounces-216007-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEMvIEd3jmlNCgEAu9opvQ
	(envelope-from <stable+bounces-216007-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 01:58:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC06E1322D0
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 01:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CDD4305DA77
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 00:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D4C214204;
	Fri, 13 Feb 2026 00:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PfrTWsNE"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C543BB48;
	Fri, 13 Feb 2026 00:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770944320; cv=none; b=fKzmAJrrYjcXS9ZvNBLpxLWAJnmDiF+Z+XdyP8Lq0j/B/Ygt3QMSALiJf8tlYD8kLOpyKW8Nz0+zk6Wp4Dl262RigCsLwIHwOfyG7LBtVtJJfsj2ZgGUFLyAe9Q4T/0M3rn4woraLlsSNPll0wdsW0TzD8oyEdgiV72rFw4o2PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770944320; c=relaxed/simple;
	bh=cHpcPyGAG03o+TR1ecG1uWELBgFcwDeP1nRIMffIaRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Do+fuekuN9eL8bCfI/7Hh4jo8Vk9JqBcuOSZLHt0SK79YWX3rfHkGoBK+7ppzOBHr5/X+StM9jcJRRydAh3/W+2USNwv23/DJvVYClTDGGUYi+rFiwf+IMlc9YTzmCm1+7536iNAOOgbkfa+Vbs+SHqE/XzNnaV5OfDeLwWL0cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PfrTWsNE; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D6D1F40E036C;
	Fri, 13 Feb 2026 00:58:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0cnwuM8wyb4g; Fri, 13 Feb 2026 00:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1770944312; bh=s15k0VtDmBXgT2loxwA/MKSEgz9TEur+XrbqGNej0pI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PfrTWsNEyLo5ZMnQHJhxBDkjowYWwMulchUa5FMtBRdYT6ULAwxrOsOtb1K2nUo5+
	 KxA2lzcEXzWg4OS40h+kLOb0zCUWYAlrFmF0c2DiV4WB4Z2dfiHXdBXNuJv+dUpXlR
	 UE059gonvA2tdL3CyX0BnD+cCTdy9YR+zdy/EPG8/Q+Ri0pND3mBKDyOw6y8x92tF3
	 9buCmRun+qXy3+qlcJS6BXLh6xjyHr+qaTnycPwaaYPxQeGv2Qack1YIasnmQzHdIf
	 KJFVWvtF8TQ5GyFgbBNxjJgVeyL0wxcl4ulPZK6O72Ijjir5QmAq6814tFyfdeLuAT
	 sn2umI18Hu/er6AaXkqwaNbMP5HBR22nThE8RIOkLZoBZgvFS6E7fSjvwj8SERJbtU
	 rGQEqXlGqhQFQxV413f3TL8FCN0qUXGtcCogyIR6kXO4MWcQ8LSDNG+gw4weIJcGI9
	 YfQf5sFdA7FZqVt/Vto0Vojq9xffT0FtvyqlvHUR7D4kLH0VemYMLW5wkVKJMS2UKX
	 t6fZ5cDFCRYSRnJj/yM8O/0BWt5xRCi17HYuqP2l8ZP++PBeZmWu85uqqDZzXAoc1a
	 nlOWmo+nPpuBVOs5iYebJT48/fKsY75W5J0rWQkw6lQWWRaJubqquuUzdGgypltpOo
	 iCu4c0l82lqE2GaGDkSzoR6Q=
Received: from zn.tnic (pd95306e3.dip0.t-ipconnect.de [217.83.6.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id DEECB40E036B;
	Fri, 13 Feb 2026 00:58:19 +0000 (UTC)
Date: Fri, 13 Feb 2026 01:58:13 +0100
From: Borislav Petkov <bp@alien8.de>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Maciej Wieczor-Retman <m.wieczorretman@pm.me>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org, pawel.chmielewski@linux.intel.com,
	Farrah Chen <farrah.chen@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] x86/cpu: Clear feature bits disabled at
 compile-time
Message-ID: <20260213005813.GGaY53JfOLNoSJNgRe@fat_crate.local>
References: <cover.1770908783.git.m.wieczorretman@pm.me>
 <32fbbfc16974cfed11e7d2651bce836ba9ceaccc.1770908783.git.m.wieczorretman@pm.me>
 <20260212155808.GDaY34kOTrEYHLdoyK@fat_crate.local>
 <aY35H-VXwoSLFXoj@wieczorr-mobl1.localdomain>
 <E9F385CE-83B8-4088-B6FC-AB113F8DF55C@zytor.com>
 <A9F52EC5-EC74-43BB-BB3F-351F684BF5CE@alien8.de>
 <19d3f1c8-01aa-4a50-81e0-6af3fb7fe9cd@intel.com>
 <20260212234722.GFaY5mimfap5YbOi30@fat_crate.local>
 <57039edb-419c-4e4a-96d0-3578e233b594@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57039edb-419c-4e4a-96d0-3578e233b594@intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216007-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[alien8.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fat_crate.local:mid]
X-Rspamd-Queue-Id: CC06E1322D0
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 04:14:07PM -0800, Sohil Mehta wrote:
> So, as of today, if one of these features shows up, a user can't be sure
> whether the kernel has enabled it or not. Right?

This is not such a critical bug - judging by how no one noticed it until
now...

> My suggestion is that:
> Instead of (or maybe along with) fixing this buggy interface, would it
> be better to put this information in something like debugfs/sysfs? So,
> at least new user software can start using that.

... to go and make big waves and "fix" everything. We'll address this
inconsistency eventually and go on with our lives.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

