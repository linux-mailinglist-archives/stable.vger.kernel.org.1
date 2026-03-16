Return-Path: <stable+bounces-225520-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKzBMDbct2mcWAEAu9opvQ
	(envelope-from <stable+bounces-225520-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 11:32:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E509297F36
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 11:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E15C30234C3
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 10:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFFC37CD32;
	Mon, 16 Mar 2026 10:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gIf7VFGP"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7418930CD82;
	Mon, 16 Mar 2026 10:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773657102; cv=none; b=LCYz/wKL1gm2s8y9+/329F7YFSuBwN2HJg6/BzNoVjJ20JBraXymMMF16cx6O0sdpS3pi1bV54CBzVgQsnZZNOsxyBGVJLBc7kjnQk8PsBEgmXSL+bhWP5ZEAEFCRoFuWH1Ptzd77Zt+t3w3ThDvQHW/o0oJ49yGF3fjE87hvH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773657102; c=relaxed/simple;
	bh=/xmxhsb7IkCL2bsfplUZBFiVOKD2aeH8kOQdUkRISF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRbUQhygD8g6AFPGjtNKgvB5VJ0UB4qg3PBN3F4v5S0uBni0cn8vAdoe2V36Ty2fEh146JFNDI4mAbMxpHBTpn9YlAuWvFWfLLcbT7eXsgHxiCIOl+jwEshqMb4Jp01GPgSMOwWotksuMrn9Z7bJye7TSzVTgAQiekvaKGi4W1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gIf7VFGP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 475F140E0222;
	Mon, 16 Mar 2026 10:31:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2dbQS89wNLJw; Mon, 16 Mar 2026 10:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1773657093; bh=hsy1TfFLSUHkJ92qjfAjHgV/eG5eUi5B7AVP2phcKYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gIf7VFGPLzXkSkaLD4bxNqNdFzhU/ZjVDsvUhaPYB3DB5sd6PFVohmNyqIpZTGjMI
	 DLTBk06mM/nQT782490IvJmJu5a1NzHsCdCiVPZEwi8dPCWoNszcC1aslXEAPix5oS
	 dYh0LE5EBR38fwZOnJrIqwFS3AMf74r6yQ20Slo1ietUdGrEOJx1u3ah2tipO38KsW
	 qrgaMRSbn9cCrL185pO+TsVWJ8YxG1ssQpMOhQqRpPDXMlx5ePqPmsnPdGoMprAYIN
	 A1rX+Hcd9HwwtP1pG2yQO5OhpV17zleU4sJ2s+OIJxBIHT7hAugvlBOU7KCIiXztUn
	 upN/UVsy27gjYkz0ghYJ+cDRf6aIyAsOACqsMOMaGoWdybcuNtJlyAtpZ3iB6AnuiI
	 66rNd+Lyxw+50nPGW1Vxd1+zGXRHX6Ng4HexKvYIkBeG8+Diggei2VQpeh79esf7/6
	 topOAuJEXnsE55S1iJ6RJY+M2KWC6hP5mHFskhlhvbYYM+DJfOuSjy709A4dU4kn5W
	 GIZDMYBxeEBx+0RwjQ0zBjg7oQlSrbvxJcDC6J0s5PddbFjKLJBcepUiXV48O+C8b6
	 8oHkV5baVUU9UbKdRVSkodm44zKruX6SLYCakvunP0+BqalUZ9gy7V6/5F+WuGDkLA
	 rAMl9FmgaYNeaOCRm0J2y8g4=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 96B7040E00DE;
	Mon, 16 Mar 2026 10:31:25 +0000 (UTC)
Date: Mon, 16 Mar 2026 11:31:19 +0100
From: Borislav Petkov <bp@alien8.de>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: tglx@kernel.org, mingo@redhat.com, x86@kernel.org,
	linux-kernel@vger.kernel.org, dvyukov@google.com,
	kasan-dev@googlegroups.com, stable@vger.kernel.org
Subject: Re: [PATCH] x86/kexec: Disable KCOV instrumentation after
 load_segments()
Message-ID: <20260316103119.GAabfb9xw9qum6hWvD@fat_crate.local>
References: <20260216173716.2279847-1-nogikh@google.com>
 <20260315121855.GAabajrw3ajExgb7kv@fat_crate.local>
 <CANp29Y5iLeJ=W5GOfjRVX9_d+sF9KM6=dMG=W-v7VwHrucb8ZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANp29Y5iLeJ=W5GOfjRVX9_d+sF9KM6=dMG=W-v7VwHrucb8ZQ@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225520-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[alien8.de:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fat_crate.local:mid,alien8.de:dkim]
X-Rspamd-Queue-Id: 3E509297F36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 11:07:15AM +0100, Aleksandr Nogikh wrote:
> Some more context:
> The problem I am trying to solve is enabling crash dump collection in
> syzkaller. For this, the tool loads a panic kernel before fuzzing and
> then calls makedumpfile after the panic (which fails due to the bug I
> mentioned in the patch). It requires both KEXEC and KCOV.
> 
> The most whack-a-mole solution was to disable instrumentation for
> several functions called after load_segments(); this particular patch
> is more generic, but yes, it can still be fragile. Another approach
> would be to add more checks to
> __sanitizer_cov_trace_pc()/check_kcov_mode(), but this would also be
> somewhat undesirable as it would slow KCOV down even further.

I guess...

So I'd like the *real* justification  - the context you just gave - for this
to be put somewhere over the code, I guess in both Makefiles so that it is
clear why we're doing this.

I guess those two compilation units will be excluded from KCOV fuzzing and if
someone wants to do coverage-guided fuzzing for them, then someone would have
to come up with a different solution, like, I dunno, putting only the
relevant, simple functions into a separate compilation unit which would be the
only one excluded from KCOV instrumentation or something more clever and less
whack-a-mole-y...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

