Return-Path: <stable+bounces-222725-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBY4JqAFpmkzJAAAu9opvQ
	(envelope-from <stable+bounces-222725-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 22:48:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E2C1E40C2
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 22:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A94DA308E8E0
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 21:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FEB39FCBB;
	Mon,  2 Mar 2026 21:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ql/CzjLc"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679F239FCD2;
	Mon,  2 Mar 2026 21:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772485212; cv=none; b=uEhUEp79PF4j4l+O13EfZrCMOqIxn5PGmvK6a0SJmpWGFZm5A2fZBeSmjjl3BSENmBEChNoNk8NN2YeJ3xU69xLQ3J4LIJmnib1SXbVjmzBpAFNjOnNkZVJYeP8J0Hee9N402GxJgPHrIKpuFkdMtlIs6CSScR2YUHKwOz9sQug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772485212; c=relaxed/simple;
	bh=qYf3mCh42AkgLKGKagvZB4TTyEuMPqgyX0sfuJiG5Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2X3VwmqP34YViVcm3JT/JZKakSZ9at/S8Nsv0mHQOH+40Uoh6NbujjjflITKfks9zdGJ7qgAAJjnD4ngXnSQHvt74OZdm6IqZccQl5NtbyErZS2hmK/lFqUYOG0nGvFaMD6j/fS7ozZ0MHahclEcrL6HE10KNLsukccAVYJ2Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Ql/CzjLc; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 357BE40E019B;
	Mon,  2 Mar 2026 21:00:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id K1gxufPKH7Re; Mon,  2 Mar 2026 21:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1772485202; bh=YZQmjvXq4qfkIg4h5StefpMfTVbG1II8TXhkSrQ424A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ql/CzjLcJP3RMhreD1tyZYXfhTbx8yt71v1jsEznIr245hyg1VsGcuoVrFug0e6vl
	 havR7faA579jesT7HAyjZNMsZ9Mg0qgt8Wzb6xz5+SbPsS9FeafLcf83QJGiz+E9Qh
	 nbw4uFU2HZa5mT0LIAffKFKoHNpVwv01lPURWwDNevjlFhQHD4MyiTltqdG2fp/ev+
	 18hQYS6A/oudXmITyzFiI6/kiPSvvk+VCXPBdc0feauoMx1gSXiaFDPQ1erxJossW8
	 0qgCQ19VTMlB0bZumEZvJnENcp79sPZF21zXEeS/S4Op8jwSebmSIrTWK+cXL6Kbe6
	 9C6rKQbdjfdL2J3RzAhDq+oaPRmg+Qja3SDXTobMqOPBRO2iYWZGNN77I5DdId+jss
	 KVISxUaTk7LUd4pJDGZtQOV+59d/D4//AIVVXFJICRR9VGkigvI3eMQ4wOoTNycY2s
	 2f/7CSUFBJqse1oVwyuX2oT4eOfe4MjRQxPcFa5SO7gEEp3ZKpFWN5d3XQh9LjMcH4
	 V3vf+qVu3T31F1z64o1OENM8TSNLGFKg2jo4KUYkW2t1kl7wln73Wr6JnE3OEvKinQ
	 YJUndsibfWxKLxdCexoYdXq+F8I5IWZ+7medA9b/b+XWBG+u/UQqIv9JdFyvKpMJgg
	 V2mC8owgvTC+4mutYXktbYKE=
Received: from zn.tnic (pd9530d5e.dip0.t-ipconnect.de [217.83.13.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 9853D40E0198;
	Mon,  2 Mar 2026 20:59:52 +0000 (UTC)
Date: Mon, 2 Mar 2026 21:59:47 +0100
From: Borislav Petkov <bp@alien8.de>
To: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Farrah Chen <farrah.chen@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/3] x86/cpu: Clear feature bits disabled at
 compile-time
Message-ID: <20260302205947.GJaaX6Q5Qx6vJMdun0@fat_crate.local>
References: <cover.1772453012.git.m.wieczorretman@pm.me>
 <cb4c2a6a0e67320b24244658b724acc1bf9686ef.1772453012.git.m.wieczorretman@pm.me>
 <20260302193142.GBaaXlnu86gUtPyQG6@fat_crate.local>
 <aaXmP1pOU_feTVu9@wieczorr-mobl1.localdomain>
 <20260302202504.GIaaXyIAQnaHTdzN52@fat_crate.local>
 <aaXz0ENy6iq2DuxX@wieczorr-mobl1.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aaXz0ENy6iq2DuxX@wieczorr-mobl1.localdomain>
X-Rspamd-Queue-Id: 61E2C1E40C2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222725-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[alien8.de:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,fat_crate.local:mid,alien8.de:dkim]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 08:38:35PM +0000, Maciej Wieczor-Retman wrote:
> I don't think it's some big threat. But then would you agree it'd be a good idea
> to backport a change to the documentation that the cpuinfo isn't as reliable as
> the documentation entry says it is? I would imagine the documentation should be
> kept as accurate as possible.

Point me to which rule your argumentation applies, pls:

Documentation/process/stable-kernel-rules.rst

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

