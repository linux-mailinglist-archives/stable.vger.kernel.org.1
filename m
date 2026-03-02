Return-Path: <stable+bounces-222699-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sECZAm7zpWkeIQAAu9opvQ
	(envelope-from <stable+bounces-222699-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 21:30:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA641DF870
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 21:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FF56313844F
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 20:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655EC480DC0;
	Mon,  2 Mar 2026 20:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ip5wgw7h"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783F6480960;
	Mon,  2 Mar 2026 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483129; cv=none; b=EUmqaXGp4pRUSFsjOOBCUlig3vD9BWjVEmsF2UxrhBYU7DFImumkxoi4q0gm2XCcoOlEbnlYA0yMell1OSZNPDW5XtgJVf6cGmI46BUb7nKdzHHxcj8SyCUU6BEMWPOTyKOQcv3HvtjkQmnwD4afGhzPWsM1kjEztAye8GzvzcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483129; c=relaxed/simple;
	bh=im5GfjX4mbYyLdAU3soqV83/293wpGDj3ZkCB+2nsT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myBN2mAAbzP1SM3QyoeN6Zqo+PlAgvjIM7eWSVc43ub16YehB5DNHCXrRpFtTIm8HChG2uhQsUqd2kiisLK5aKmVp7iQqufhcg1/VUYIKOgZ6tZMpWOKJEkyOY4Bt8cnGAjmwyImbACC5iKXYrTphcg+2vUb+BabqHjypn1T1Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Ip5wgw7h; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6E68540E019B;
	Mon,  2 Mar 2026 20:25:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NIjkTDhUQtzd; Mon,  2 Mar 2026 20:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1772483121; bh=AIPOW80mQcJYFbYX+IUnUxg007779oqU2yvKto5tve8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ip5wgw7hQLSkZgAIbjRC5DknQVzjcbgDZqJGjTPN3VNwVRJuPCanXDPCXAfESQGp1
	 /xcHKTNfKN5jS8M3kLwRHtEC9Eqq/IxixvLmyyakQYSNOvc3c46ejUOgYQOwMvgWV0
	 MTdwjZNQeLgcavBnQ7lq1kfLSdMsE7wY9Pm3leUmyF9fow09Qu6+3/EaH14khtYvtk
	 lTtDR7+9qOp11D3tc/z86EASrVn1JYtOUamTG9QzQM4RP29Klh4c3znRWpR+i+zYip
	 VgxZCsUOi5/uNTqUi0igncWknxrOygonse3+yqgxBXUFQV4v+lc4cX99tQ/HPjxPHe
	 kOnqkdt2A6v/jHgeF9nVbitTzRKHfqVzxlTfOh3+mkwdiJEYFz9WeWy6Q4MJnK0yJL
	 Be5nQocOWnP+SaAMPRXwBIfQme5rlzWwtC+0QwZmfYkOesRsRR4azjFyVSs7IFS157
	 W4IE86HCVt41yPP8oF3EC6U8RFJgbtimgK/egQ2Ljb/V/1ZqYoDOMEFF0XVNbTTj0s
	 9N0/bQoCtH8IhYh0CCgywnltuAu1I5bLIRfmIfRWsWvgJ0E2HVIqGLCa1r2tk6ml/O
	 GOKnncqMXsc66FJOpMoDupI5TIryYXC5t97tr1uI3QyOcC4Pb5cU4MsoO84DAfey+X
	 zcGtOmAIRqNXByxSXQc5d3hg=
Received: from zn.tnic (pd9530d5e.dip0.t-ipconnect.de [217.83.13.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 8285840E016C;
	Mon,  2 Mar 2026 20:25:11 +0000 (UTC)
Date: Mon, 2 Mar 2026 21:25:04 +0100
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
Message-ID: <20260302202504.GIaaXyIAQnaHTdzN52@fat_crate.local>
References: <cover.1772453012.git.m.wieczorretman@pm.me>
 <cb4c2a6a0e67320b24244658b724acc1bf9686ef.1772453012.git.m.wieczorretman@pm.me>
 <20260302193142.GBaaXlnu86gUtPyQG6@fat_crate.local>
 <aaXmP1pOU_feTVu9@wieczorr-mobl1.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aaXmP1pOU_feTVu9@wieczorr-mobl1.localdomain>
X-Rspamd-Queue-Id: 6FA641DF870
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222699-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[alien8.de:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,alien8.de:dkim,fat_crate.local:mid]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 07:48:41PM +0000, Maciej Wieczor-Retman wrote:
> The documentation from at least 5.10 onwards promises to have flags in cpuinfo
> only if they're truly compiled and enabled. So I thought that incosistency can
> be corrected from that point on. For the 6.18 stable kernel this particular
> patch applies cleanly because it already started using the awk script. For the
> older ones I took Greg's advice and prepared separate patch that worked before
> the awk script was introduced.

I don't think you got my question, lemme try again: 

How serious is this bug so that you want to backport it to stable?

So what if some flags appear in /proc/cpuinfo even if they're not compiled in?

Is the cat going to catch fire or no one cares...?

IOW, does it really need to go to stable and if so, what's the grave bug it is
fixing?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

