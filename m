Return-Path: <stable+bounces-213384-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO1EJKNSg2mJlQMAu9opvQ
	(envelope-from <stable+bounces-213384-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:07:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA654E6DB4
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0B293096745
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31ACC21D585;
	Wed,  4 Feb 2026 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f+QaMgya"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA823156C6A
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770213624; cv=none; b=SdpQUwl8doTC2eP3TIH5Gus6qBhKZ1d/rmk1/T0ZHcFw8ib2ntCgbYBjN9lTa25OKhPVV1Il4rb7fVmlbByq7Y/Q5VUohFynItGXugJvKepToza3nmPm7hZCvhUnf2lM0E3s7PatXxYqg2Ro4oi54Vni0tIjuoNkXYBzsHY6oqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770213624; c=relaxed/simple;
	bh=am62wEj++vOByY8XcoJycq54M2Iu4/IQzNPuO3BxOlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LW8AXhPUh4bUycVgKMjIhYN+yevf68GVPkdgIKmJAWPvhQ2IT903Qlzzz1bM8cwewvIcZ1xQM7sit+PGI+dz956nX+jPI9CKVlnwdxjiBfXL6kpdsWwlfLifSmTPo75bAH8r3EYp1LbroEzyQYAVL7Z6jM7TPeEBvkAzd8yZVgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f+QaMgya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57FBC4CEF7;
	Wed,  4 Feb 2026 14:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770213623;
	bh=am62wEj++vOByY8XcoJycq54M2Iu4/IQzNPuO3BxOlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f+QaMgyaeG+gMZDMSopP70O1k5rTqFXJ761Tjouv6dUTPzylD0FKCh8ZNN+EuVNcN
	 1TLKpKQ9g0nkKTD0mRFr0OCCJmyNokeFkuB8UjYDBt1k5KwyQuhRSqB4pVr3vqv7EW
	 q+x8Q8gle+4kpm5zkcUg7/6bgBpheEYEMol3ULrE=
Date: Wed, 4 Feb 2026 15:00:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: alvalan9@foxmail.com
Cc: stable@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 5.10.y] ipv6: sr: Fix MAC comparison to be constant-time
Message-ID: <2026020455-exorcism-puzzle-75a5@gregkh>
References: <tencent_A280B5140E218C468311AD76CDEBC78B2406@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_A280B5140E218C468311AD76CDEBC78B2406@qq.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[foxmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213384-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,uniroma2.it:email,foxmail.com:email]
X-Rspamd-Queue-Id: EA654E6DB4
X-Rspamd-Action: no action

On Sun, Feb 01, 2026 at 07:13:37AM +0000, alvalan9@foxmail.com wrote:
> From: Eric Biggers <ebiggers@kernel.org>
> 
> [ Upstream commit a458b2902115b26a25d67393b12ddd57d1216aaa ]
> 
> To prevent timing attacks, MACs need to be compared in constant time.
> Use the appropriate helper function for this.
> 
> Fixes: bf355b8d2c30 ("ipv6: sr: add core files for SR HMAC support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> Reviewed-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> Link: https://patch.msgid.link/20250818202724.15713-1-ebiggers@kernel.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [ Include crypto/algapi.h instead of crypto/utils.h in v5.10.y. ]
> Signed-off-by: Alva Lan <alvalan9@foxmail.com>
> ---
>  net/ipv6/seg6_hmac.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
> index 4a3f7bb027ed..d334458cbc9e 100644
> --- a/net/ipv6/seg6_hmac.c
> +++ b/net/ipv6/seg6_hmac.c
> @@ -36,6 +36,7 @@
>  
>  #include <crypto/hash.h>
>  #include <crypto/sha.h>
> +#include <crypto/algapi.h> // For crypto_memneq

Why did you add this comment?  It's not in the upstream commit, nor is
it needed :(

I'll go delete it...

thanks,

greg k-h

