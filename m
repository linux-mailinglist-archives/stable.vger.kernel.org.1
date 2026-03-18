Return-Path: <stable+bounces-227175-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JgvNvEgu2lofQIAu9opvQ
	(envelope-from <stable+bounces-227175-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 23:02:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FDC2C33AE
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 23:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60C5630649CB
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 22:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835ED262FC0;
	Wed, 18 Mar 2026 22:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ClmoXIDI"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DE935AC31;
	Wed, 18 Mar 2026 22:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773871305; cv=none; b=hHvEjxjajC45ZToJcA9s7uDim/Qhvkyp3vEP29da7UlWJeJDxCODR7jRjjYS9KTVQklLRxKxszXGXAtQs0DTYzoJ+JLu7KqzGjnoUUFeao6GhfiIdrY/9y+orxRyryzpBU8DvSOUBLsQNYs6bbm+pIFYjYekgHMZM7IS+ue/qFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773871305; c=relaxed/simple;
	bh=6iVXAVapAD8viXgl6n1yNGcUHiZiYxYjemDwVlycq1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ucx1bJf6aiH9ekLPb5OFzZpCR5A/34rE+hHbxvoScJNEJtewB6pMUjhwDgaPTAblkPj4yKhkjbNnObGHOEFuIZXKF372dV14By7iI2B5ZyCkhpzCOlNldBvYUrwvzdTxfyqLtCZfPdHCWW/pWiq7/Rknw+PmM3AmI3Avb+yl9t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ClmoXIDI; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ADB8740E0221;
	Wed, 18 Mar 2026 22:01:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3MkVyyr1XLIh; Wed, 18 Mar 2026 22:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1773871295; bh=5nwZv9kTQ+zSjmnoH1/7aJUTQJflr/2oVa9g7+Zc4h0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ClmoXIDImuoOY+k5ZB5NoYJPT8ewXt2bFRZ0nXcB5inKVmuWBI3eJQL6rTIWo9nFA
	 AaCgp3Lf44ImcgKp3TLZHxHys9pc2+4Y8czteMa1lLcJpnLUgV+u6TurkGXRQMOROv
	 KouA/OCu1e05OFY1CIsO3tAuaxKKDPBhdePJ3RuFi/9TgPowjP0exbdhleRMsMBSQc
	 dTQ88g3sBo00BANx/rVROZ0IdR6nJjMkybdb1v6eJm5dMGsfHLMNTl9ewWiUk3V/Xr
	 z1XcGuGu2yuOUBsLuC3a0P2KKx5CgHKacBh11ECcXBKW/doGNf+S+z2PFwjKWxUS45
	 8e5ypvdEbi8hP1Ti148nCPcROJwa/pvSHgojPH8zHfrBEKzfkKIRGxOEZAB+QZqGL5
	 2FtU1iJyxYwZr4H1Ogx7mUzK6LFrfiPdc7ENHSg4p46En9M5Ao9x4sIWxioIZYuqHc
	 sS1j7zXnRwwKovZn1anJaUOxIMJCAxfzrdmKJh8xv4cYpRZ8giUXTH0Rnl6/YkRea7
	 Vd8kufgUaRQd4EVhrzaqabvBx+d5BWffxe5Q9fFqcR5R0D9BrPuqTJGoxuuU9xktCZ
	 hAXVMvJf17XV6s5hFxbahJwb7dqW9wCgMb/Cv5J6gVPGgPgEJfY/q4rllAXjZA5Uaa
	 uUriGfIskQHkqnKo6sGLCBUs=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 5669F40E0194;
	Wed, 18 Mar 2026 22:01:25 +0000 (UTC)
Date: Wed, 18 Mar 2026 23:01:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Nikunj A Dadhania <nikunj@amd.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>, stable@vger.kernel.org,
	#@tip-bot2.tec.linutronix.de, 6.9+@tip-bot2.tec.linutronix.de,
	x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/cpu: Disable CR pinning during CPU bringup
Message-ID: <20260318220118.GFabsgrjXdX9PnwCoO@fat_crate.local>
References: <20260318075654.1792916-3-nikunj@amd.com>
 <177385987098.1647592.3381141860481415647.tip-bot2@tip-bot2>
 <20260318204722.GD3738786@noisy.programming.kicks-ass.net>
 <20260318210813.GEabsUPblg3mkGxMqk@fat_crate.local>
 <20260318213029.GP3738010@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260318213029.GP3738010@noisy.programming.kicks-ass.net>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227175-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[alien8.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fat_crate.local:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alien8.de:dkim]
X-Rspamd-Queue-Id: 40FDC2C33AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 10:30:29PM +0100, Peter Zijlstra wrote:
> This isn't temporary, this is marked for infinite backports :/ And it is
> really really bad.

Ok, zapping all three. I'll redo the whole thing tomorrow on a clear head and
then we can talk.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

