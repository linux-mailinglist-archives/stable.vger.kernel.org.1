Return-Path: <stable+bounces-243890-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KC4GJfc+Gk22gIAu9opvQ
	(envelope-from <stable+bounces-243890-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 19:51:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AAADF4C2303
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 19:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42335302003D
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 17:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067BA3E4C94;
	Mon,  4 May 2026 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAyW4P3k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB94F3E3DAA;
	Mon,  4 May 2026 17:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777916933; cv=none; b=Mqzu7eBeoB0PErT29CCyCDWlCV0aak0maRgbq7EEu7OG1a0XKbfUbtEQActGXc3S75GKRxvYeO+ouK2VxGxKsFxLiJvBhYtKxz8C6SC2Dw1w8dzrIvM3RKb5/1NfFWyfezhWktLyrgw4pl4mT5QlUeCrRkbZM8m1EGjcPcwb+wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777916933; c=relaxed/simple;
	bh=HBm2VfYhCqoM+ORUtihoa//7kAyARXAwfAerXmia3lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNP3Lghwhy+h8ErO4C7opUsarRwywVRMn/ICXPFi1mogXeSuGC9om9v+0gJd6VYYM3CkvsCEcVXyFCHNFwmbXSqxa6HgD1E3R3UOb0taG/t+3Ci7hZVHfQkiZHUcrcxnHBc8q5tp1e9FpotlfOqfcbrUoUFHxVcmIChjgX3T3Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAyW4P3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EE6C2BCB8;
	Mon,  4 May 2026 17:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777916933;
	bh=HBm2VfYhCqoM+ORUtihoa//7kAyARXAwfAerXmia3lE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PAyW4P3kOztDaDUVLckYcoAzPXGAP33jHS5um0+VVvDfHhFwpcjezAacfX6/8z7Ul
	 7PkAZ+Dvc793T9B/Mi9KcHxvJng40THWFKe2OvBrti9s6XuY9yOF8Z1AdU3tI74FJ5
	 CeILmQ+0D+InEzyneWGOiJtdGjR7x7HmQx0oGHbxBM2+vvuMZ7eQH2OInoeOY+8kA6
	 dYNDgXrOIG85CmIFbSPhVVrjTokDBCcp2HIYuJiYVoRWvjfx8KGOuwxe/AWkKb2a22
	 jNQbhZ4jlu+DlObq3eLWWa4dqm2G4xxVo0KN6c4c1YRu3gMwO6YLdI8oaom0k3K4JD
	 wW66v0zrwA7+w==
Date: Mon, 4 May 2026 10:47:33 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: =?utf-8?B?4pK2bMOvIFDimK5sYXRlbA==?= <alip@chesswob.org>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Taeyang Lee <0wn@theori.io>, Brian Pak <bpak@theori.io>,
	Juno Im <juno@theori.io>, Jungwon Lim <setuid0@theori.io>,
	Tim Becker <tjbecker@theori.io>,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Feng Ning <feng@innora.ai>, stable@vger.kernel.org
Subject: Re: [PATCH] crypto: af_alg - Remove zero-copy support from AF_ALG
Message-ID: <20260504174733.GB2291@sol>
References: <20260504061532.172013-1-ebiggers@kernel.org>
 <mCm5pwZUNYtOVDph2baJg3eAzArddjvFpx3Wwh2qiZfZXYtv-aUjlISuRg5HjuIMzGo51hxCazaH47gp9B_q7I4R4LVePKGkvhO9D0P4nCY=@chesswob.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mCm5pwZUNYtOVDph2baJg3eAzArddjvFpx3Wwh2qiZfZXYtv-aUjlISuRg5HjuIMzGo51hxCazaH47gp9B_q7I4R4LVePKGkvhO9D0P4nCY=@chesswob.org>
X-Rspamd-Queue-Id: AAADF4C2303
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243890-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gondor.apana.org.au,theori.io,gmail.com,innora.ai];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, May 04, 2026 at 04:07:45PM +0000, Ⓐlï P☮latel wrote:
> Syd sandbox uses AF_ALG zero-copy for its Force Sandboxing[1] and Crypt Sandboxing[1].
> Zero-copy means Syd does not have to copy sandbox process data into its own address
> space providing safety and security. Switching to read/write rather than pipes and
> splice breaks a fundamental safety guarantee for the sandbox. Please do not break
> userspace.
> 
> Will sendfile(2) continue to work? 
> 
> [1]: https://man.exherbo.org/syd.7.html#Force_Sandboxing
> [2]: https://man.exherbo.org/syd.7.html#Crypt_Sandboxing

It's very unclear what that feature (which I don't think anyone knew
even existed) is trying to accomplish.  Regardless, this patch doesn't
break the splice or sendfile syscalls.  It just makes them run a bit
more slowly since the kernel will copy the data internally.  So I think
your concern isn't justified.

> How can i test? Please help me.

If this is a feature you care about, perhaps you know how to test it?

- Eric

