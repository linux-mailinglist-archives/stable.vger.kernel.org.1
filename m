Return-Path: <stable+bounces-232985-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNpRNsFTzmmEmwYAu9opvQ
	(envelope-from <stable+bounces-232985-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 13:32:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCF0388587
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 13:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0F3D305A89B
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 11:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBF83D6CAA;
	Thu,  2 Apr 2026 11:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vm/IuFjw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617B83C1976;
	Thu,  2 Apr 2026 11:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775129245; cv=none; b=Y7s1VQl8wHJ0Hkru9M6fwy7tNx5FkN1jkqqf4mHzgpAB5h35Q8nISzFUJMoG9KKlsJnt4z8kkNBG+J3kXeoTdYIS17145aVvcNf6telwNzKDAqZGbse0SB1Tn0J2f5c9C31P2z3Zl/DeH2++OA4CWOu0oIM23bbILl3PFzmoKTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775129245; c=relaxed/simple;
	bh=AgwzG/pGDJ0yMVb12xr9ZaSAqL/AmjI8cr4rpIQoqN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gaSfXFwGAkzAzNxHK37TzsPv1xbofju2JDcMB1EZEyUucf6fKraXwtGy2p5PMW+KU/DNHnMYmEM8CnlLz7fUtTYJUw2Tbu/vE49Ic7GvwJ3VR/f1xUeWLl4dzo7Cv9qBa3Bdg2vcS0w+KOn29HTHVeztGK5sPNIGU6kKgHnfQNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vm/IuFjw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C52EC2BCB2;
	Thu,  2 Apr 2026 11:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775129244;
	bh=AgwzG/pGDJ0yMVb12xr9ZaSAqL/AmjI8cr4rpIQoqN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vm/IuFjwqSeYwQkdkUbSTYJlDhv48JsNVz5p4VIkJkXzg3JFRnabU3J+HAkvRSCor
	 S5SOgQdDGRGzGST9D6wCXHkT0BdkoPo85bM3dMHdROzggOvEl2bBmhVFeLlbUYKOqP
	 bLSHDRhj7HgDDGC3X7ZY/+84yu1+TvTl1vU+vYHGE2ko3HYQ/01mMp2uRNhLdQhsZa
	 3SNSCOjaV+BwPGQL9A6u6pxhrVFbxJaIjMVLY3Nwdxcx3yhEkxRJ9uL0k/r9G9WnLd
	 hFrmlJEcaYPt68sHRWEKxD05jkTOpb6a3kdQupDKw45c5naLjjaWWHCjcqfS8ofKNm
	 F0fknaU0qygNA==
From: Miguel Ojeda <ojeda@kernel.org>
To: gregkh@linuxfoundation.org
Cc: achill@achill.org,
	akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	hargar@microsoft.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@nabladev.com,
	rwarsow@gmx.de,
	shuah@kernel.org,
	sr@sladewatkins.com,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Benno Lossin <lossin@kernel.org>,
	Gary Guo <gary@garyguo.net>
Subject: Re: [PATCH 6.6 000/175] 6.6.131-rc1 review
Date: Thu,  2 Apr 2026 13:27:12 +0200
Message-ID: <20260402112712.110869-1-ojeda@kernel.org>
In-Reply-To: <20260331161729.779738837@linuxfoundation.org>
References: <20260331161729.779738837@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,garyguo.net];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-232985-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojeda@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 3CCF0388587
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 31 Mar 2026 18:19:44 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.131 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Apr 2026 16:16:56 +0000.
> Anything received after that time might be too late.

The pin-init change does not build:

    error[E0425]: cannot find value `__refcount_guard` in this scope
        --> rust/kernel/init/macros.rs:1320:25
         |
    1320 |                   @guards([< __ $field _guard >], $($guards,)*),
         |                           ^^^^^^^^^^^^^^^^^^^^^^ not found in this scope
         |
        ::: rust/kernel/sync/arc.rs:529:49
         |
    529  |           let inner = Box::try_init::<AllocError>(try_init!(ArcInner {
         |  _________________________________________________-
    530  | |             // SAFETY: There are no safety requirements for this FFI call.
    531  | |             refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
    532  | |             data <- init::uninit::<T, AllocError>(),
    533  | |         }? AllocError))?;
         | |______________________- in this macro invocation
         |
         = note: this error originates in the macro `$crate::__init_internal` which comes from the expansion of the macro `try_init` (in Nightly builds, run with -Z macro-backtrace for more info)

(among other errors)

I would suggest dropping these for now:

    0565326613fa ("rust: pin-init: internal: init: document load-bearing fact of field accessors")
    66655aacfa42 ("rust: pin-init: add references to previously initialized fields")

Cc: Benno Lossin <lossin@kernel.org>
Cc: Gary Guo <gary@garyguo.net>

Thanks!

Cheers,
Miguel

