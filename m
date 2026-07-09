Return-Path: <stable+bounces-272947-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2Ew5KHixT2p0mwIAu9opvQ
	(envelope-from <stable+bounces-272947-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 16:34:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC7A7324DC
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 16:34:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=VBQ9t4F5;
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272947-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272947-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 817A330041E1
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 14:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC8B331EDB;
	Thu,  9 Jul 2026 14:27:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F541AA780;
	Thu,  9 Jul 2026 14:27:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607258; cv=none; b=Wvn315z10cWYCxvQ4APGyNe4KzXoTml1qEQ8g+BEmh3/7vfP/kfBcvwfKLvfJG/nvQ6WZz9UEms6v87LcvJdqS4e/h0Ci1VOwG7cJId+J+4Fb0o6nbDA8XSFBfbnacXE686ilU9iyo0kSZA6VArH7XWrCrk/I/NaRvQ4DeINuwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607258; c=relaxed/simple;
	bh=XgcPfTh9E+25t08NFhk2qKYKRxiIW0zesYLtJEAOtbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oegZJXKmee4QrL7s+Y0VRVBVEVFdx4lJLxGJh1rGzejxsd7JeQNXat6T8P8jYYTTpJjbc5wBmwRbRWL7QGx4LMoZJpEGC23xJ9iCKvkp52616aB5J4QThyY9DwvL1HEBFSCdNHeFg/mXYW8tb0mkfik99hQN+/tvLFY26IfA30w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VBQ9t4F5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771231F000E9;
	Thu,  9 Jul 2026 14:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783607256;
	bh=XgcPfTh9E+25t08NFhk2qKYKRxiIW0zesYLtJEAOtbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VBQ9t4F5pEbEKNt60Qv669QNKzVt19DHjVXQ2NGngjPPwbXT+MvCi4SzoQQRNIL0z
	 fBRxw5nAIF6blJ1hLGvRL+VbpPPa2rN9bew0Mywug3kLzU3rkjbp4uqSIQNBEfTWAA
	 GrSMu7LrrjxkYYoaNI85a7OQLIRM5Ce52TDnwpSo=
Date: Thu, 9 Jul 2026 16:27:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Goetz Goerisch <ggoerisch@gmail.com>
Cc: herbert@gondor.apana.org.au, herve.codina@bootlin.com,
	linux-crypto@vger.kernel.org, miquel.raynal@bootlin.com,
	paul.louvel@bootlin.com, sashal@kernel.org, stable@vger.kernel.org,
	thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 1/5] Revert "crypto: talitos - rename first/last to
 first_desc/last_desc"
Message-ID: <2026070912-pluck-bagful-2a71@gregkh>
References: <2026052212-aged-amply-7bd8@gregkh>
 <20260523151048.14914-1-ggoerisch@gmail.com>
 <20260523151048.14914-2-ggoerisch@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523151048.14914-2-ggoerisch@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ggoerisch@gmail.com,m:herbert@gondor.apana.org.au,m:herve.codina@bootlin.com,m:linux-crypto@vger.kernel.org,m:miquel.raynal@bootlin.com,m:paul.louvel@bootlin.com,m:sashal@kernel.org,m:stable@vger.kernel.org,m:thomas.petazzoni@bootlin.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-272947-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8AC7A7324DC

On Sat, May 23, 2026 at 05:10:44PM +0200, Goetz Goerisch wrote:
> This reverts commit a866e2b1c65edaee2e1bb1024ee2c761ced335f8.
> ---

We need a reason for a revert, AND a signed off-by line :(

Please fix that up for the other revert in this series and resend.

thanks,

greg k-h

