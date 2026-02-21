Return-Path: <stable+bounces-217647-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEkCE9z7mWnvXgMAu9opvQ
	(envelope-from <stable+bounces-217647-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 19:39:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBD716D8C0
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 19:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5378D3047005
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 18:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B37E3033E9;
	Sat, 21 Feb 2026 18:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaYk4LfZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA80423817E;
	Sat, 21 Feb 2026 18:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771699158; cv=none; b=CTt5NaS3IzJD/3c1wzNbo00AqakpAxoW+XY71vf9KJKLqZrEqbnMy3GgTzow9AxYid7FTPLvOTb11qbwJXqDjZEfzzaoS52XjmzQOoRChBavfx5Pa/rj6Ip+4J3bfky/iwwqtLO1amr5iXfI7dWCQDDNXaPkIzWLzvizyJM8Hg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771699158; c=relaxed/simple;
	bh=oHTqtRK/kESzEKZXKvO9UOIIAMLiorWYXqa+qfEi7UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mP9oeJHLSjXpP/QeCAnWhnupeMbSoDU8U7d2LtQQi3uwG6lHHm0F0zQjdHyAmUZ0l+TkmX1ypCzwGPGR7iVsM9EUuYY+QYm2d79NCFQO17yYpsN7iY9XYMgfnU9OTWYazhg6YE3UqxpkdSsUzhUGW8MfDZ5KfasDC4lochr4qn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaYk4LfZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9186DC4CEF7;
	Sat, 21 Feb 2026 18:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771699157;
	bh=oHTqtRK/kESzEKZXKvO9UOIIAMLiorWYXqa+qfEi7UY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CaYk4LfZYLAwCa2G4ShO28S//AZShSKjMu9Inc8/i7L59AIZQdMzuDhfcEKppvmaM
	 F07lGDF0w9gk+GQLIyJQchDxHb9pfyGdBwwlBZwoUQUNCKM4SxzYFlwcvD+93gPs6Y
	 QNvRysG+89rV34JiaLnTDNuFppQ90gb+a0BOIUQd9NvUQOL5MM+fD2wxnlpg6tw9pz
	 oE02QSoyJRN6XA1gZb7OGyiGvGHChHWDkQ8OC/yYvRMRlGlR0jzI1EHhhsAz/k44TP
	 uRKIelIhVPJlU+zNUK79QgdlKHIb2z1VPMfO+6U+146fRg2zmJasxoGLfLbEO5BOT4
	 usiGvwi2T/BEw==
Date: Sat, 21 Feb 2026 10:39:15 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Manas <ghandatmanas@gmail.com>
Cc: davem@davemloft.net, herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Rakshit Awasthi <rakshitawasthi17@gmail.com>
Subject: Re: [PATCH] Crypto : Fix Null deref in scatterwalk_pagedone
Message-ID: <20260221183915.GA2536@quark>
References: <20260221151041.65141-1-ghandatmanas@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221151041.65141-1-ghandatmanas@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217647-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,gondor.apana.org.au,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9BBD716D8C0
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 08:40:41PM +0530, Manas wrote:
> `sg_next` can return NULL which causes NULL deref in
> `scatterwalk_start`
> 
> Reported-by: Manas Ghandat <ghandatmanas@gmail.com>
> Reported-by: Rakshit Awasthi <rakshitawasthi17@gmail.com>
> Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
> Signed-off-by: Rakshit Awasthi <rakshitawasthi17@gmail.com>
> ---
>  include/crypto/scatterwalk.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/crypto/scatterwalk.h b/include/crypto/scatterwalk.h
> index 32fc4473175b..abbb67391710 100644
> --- a/include/crypto/scatterwalk.h
> +++ b/include/crypto/scatterwalk.h
> @@ -78,7 +78,8 @@ static inline void scatterwalk_pagedone(struct scatter_walk *walk, int out,
>  		page = sg_page(walk->sg) + ((walk->offset - 1) >> PAGE_SHIFT);
>  		flush_dcache_page(page);
>  	}
> -
> +	if (sg_next(walk->sg) == NULL)
> +		return;
>  	if (more && walk->offset >= walk->sg->offset + walk->sg->length)
>  		scatterwalk_start(walk, sg_next(walk->sg));

First, this patch doesn't apply to the mainline kernel.  This seems to
be a patch against an older version.

Second, 'sg_next(walk->sg)' returning NULL during the line
'scatterwalk_start(walk, sg_next(walk->sg));' means that the end of the
scatterlist has been reached, despite more data needing to be processed.
For example, this could happen if some in-kernel user asked to encrypt
200 bytes from a scatterlist containing only 100 bytes.  But that would
be a bug in the code that requested the invalid encryption operation in
the first place, not here.  It would need to be fixed there.

What is the full call stack of the crash?  That would point to what
actually needs to be fixed.

- Eric

