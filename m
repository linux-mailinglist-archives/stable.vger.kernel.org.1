Return-Path: <stable+bounces-222400-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCugJjevo2kOKAUAu9opvQ
	(envelope-from <stable+bounces-222400-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:15:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9820D1CE5AD
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D3A6F3009817
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 03:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F81630BF70;
	Sun,  1 Mar 2026 03:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5LPLrPF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C6C3093D3;
	Sun,  1 Mar 2026 03:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772334893; cv=none; b=DUqiBgyWyXglejntTPOhed4a4VpBRnZ2xL0ZHYw/fWscwcgCpGmuaWZLMvobrW2PQ3a2TLS1Ttjuy0FBwMRH7qbqnSJ7Ak0X2tGHUIVg1KVeIURUNlfZOgbtF2NdoU8kHikQ8aMUnuLf2BdfbkHlDTyrpIhqbN83etL9h+lfIUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772334893; c=relaxed/simple;
	bh=cztyXyeNUtJ2suFuxPdzJBanyjZeXjZQOti7SdfAox8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfgUAwSZwI2h0Vfx2NsR0P6BT6Ym7J6MBK0IH+QzJqEGW0bOBCh1U2tyeTRmlSRhClpK+jZzDw/dQERbezS5cOju7GPSqSQ+gEjEzksVAKZ01O6Q8460NzvjU6amilvSLAKRjek7jwpeTd7LsuvHJSkf8RP+sfhiWSpExtE0a2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5LPLrPF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EB0C19425;
	Sun,  1 Mar 2026 03:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772334892;
	bh=cztyXyeNUtJ2suFuxPdzJBanyjZeXjZQOti7SdfAox8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e5LPLrPFO0XYtOvyoaJ8UZ6IuA2cX9A8f/+qAYQgz2OJ4a255Z6ZMsC7n79xxGEoW
	 Z+PBv2SuvNhdWzW8RDa0bXQbMiD3JGcgxX/rRQy2aeMu7H9l3YzwMlQO5Lwmi6jpeK
	 xjCMsXILdBMZIR1XJe7CKk8yFal+m9UhEVo25KXxaHZy3IPYM+dIBEtbL+pVbvTrgT
	 zwlQ5uRjzxabJps7y02wZ9e8eXZOos2cDJq/CPk3PBTLXZzhBI5S5dPhpclz8CEviZ
	 Kiv0L6m+Z68eUaSmJ15w+503WoMy8yiEAURS7QOQ/eB1sGsy50RBM286NAbX/+MsTI
	 TBaSm/36UugHg==
Date: Sat, 28 Feb 2026 19:13:59 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <raemoar63@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] lib/crypto: tests: Depend on library options rather than
 selecting them
Message-ID: <20260301031359.GA2271@sol>
References: <20260226191749.39397-1-ebiggers@kernel.org>
 <CAMuHMdXH94DvcDKN1zTzTBOrcn_zAfZZZJCyGbxjfs8DBya5_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXH94DvcDKN1zTzTBOrcn_zAfZZZJCyGbxjfs8DBya5_Q@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222400-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,zx2c4.com,gondor.apana.org.au,googlegroups.com,linux.dev,google.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9820D1CE5AD
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 09:32:50AM +0100, Geert Uytterhoeven wrote:
> You can make those library symbols visible if KUNIT_ALL_TESTS, like
> I suggested (after I sent my earlier reports to you) in [1], and like
> Vladimir already did in [2].

Sure, but that would help only when KUNIT_ALL_TESTS is enabled.

I think for now I'll just add a .kunitconfig file that enables
everything needed to enable all the crypto libraries with KUnit tests.

- Eric

