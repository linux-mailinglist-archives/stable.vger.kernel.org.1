Return-Path: <stable+bounces-230367-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cL/XFjsbxGnlwQQAu9opvQ
	(envelope-from <stable+bounces-230367-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 18:28:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F47329CB0
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 18:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57C953133127
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 17:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348ED402BAB;
	Wed, 25 Mar 2026 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAUlWe5d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73DD401A15;
	Wed, 25 Mar 2026 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774458937; cv=none; b=Q2v1bGJ5ZN0tSBi1Wk95V2i4XEdBGVhZZbRwhBRTJXEF9XZbwTPKJVl+F9dYlmxqra2xUm8jYoKIA9mQsISz60IxRIpIzAkcZ8LPJEnSBpSavPtg0xtMR7P1TnC3+m3xtjzUrz02kqbenjxtiGbATgb/4nNtvm9SbFwQioSH49g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774458937; c=relaxed/simple;
	bh=JjNKFAL/hYFhXUBDkXju/fFb3zrUfQ3p1UorkspAkWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEKVNM4k0nkNPtHcvAsmnIUelioVC+Zh4Ulylfy7GdwAPkLcE5BnR6sG99zf+GaFWJzvdX0sWGl8yZEDGEbOvAafLCgsRYAHhZhO65XllKJSBWp29aV7UHH1RER1VcAWj9QUBbSsItImmyTdza5xzs+xHqjKoCl9oTgdqpO9TLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAUlWe5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2B3C4CEF7;
	Wed, 25 Mar 2026 17:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774458936;
	bh=JjNKFAL/hYFhXUBDkXju/fFb3zrUfQ3p1UorkspAkWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DAUlWe5dY4+PcE1lpHDVVudwEzbzPk8ClFIM/11ztYeiKlpqADnUo1ypHKvjsxvRn
	 kbeBiZHEfQ2FEie/ODA9hTpTojyXDn/r92SgVETbbA1VI4BGO/nyVfBDTG2ANlIwm7
	 4kTIGEtIiwbBmPcmbIZ7pfmYQMcoXvf00al9mrfQKaobMeC4ta4iF1BZK75Fo0g4Zw
	 sXhFj1afIBZ8s4pkfJTXuDcqQzRv9+TyckQUWXySouXtqUkGvNcMo+P8Hb4Csnjls8
	 3glgOnisKWrsAeOSLOFgJRKkacfcIWo2mTGjPp0HQwX9PJVL1hazHZeg4EYiih9Xxi
	 xMrxM2yjoQQCA==
Date: Wed, 25 Mar 2026 17:15:32 +0000
From: Simon Horman <horms@kernel.org>
To: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] xfrm: clear trailing padding in build_polexpire()
Message-ID: <20260325171532.GI111839@horms.kernel.org>
References: <20260321210421.2504711-1-yasuakitorimaru@gmail.com>
 <20260324013742.939533-1-yasuakitorimaru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324013742.939533-1-yasuakitorimaru@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-230367-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: A8F47329CB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 10:37:42AM +0900, Yasuaki Torimaru wrote:
> build_expire() clears the trailing padding bytes of struct
> xfrm_user_expire after setting the hard field via memset_after(),
> but the analogous function build_polexpire() does not do this for
> struct xfrm_user_polexpire.
> 
> The padding bytes after the __u8 hard field are left
> uninitialized from the heap allocation, and are then sent to
> userspace via netlink multicast to XFRMNLGRP_EXPIRE listeners,
> leaking kernel heap memory contents.
> 
> Add the missing memset_after() call, matching build_expire().
> 
> Fixes: e3e5fc1698ae ("xfrm_user: fix info leak in build_expire()")

I think the Fixes tag should cite the patch that introduced the bug. The
commit cited above looks like a related fix, but no the cause of the bug.

> Cc: stable@vger.kernel.org
> Signed-off-by: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
> ---
> Verified with pahole (struct xfrm_user_polexpire):
> - x86_64:       sizeof=176, padding=7
> - i386:         sizeof=168, padding=3
> - aarch64:      sizeof=176, padding=7
> - armv7l (hf):  sizeof=176, padding=7
>  net/xfrm/xfrm_user.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index 403b5ecac2c5..ee31ef482be4 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -3948,6 +3948,8 @@ static int build_polexpire(struct sk_buff *skb, struct xfrm_policy *xp,
>  		return err;
>  	}
>  	upe->hard = !!hard;
> +	/* clear the padding bytes */
> +	memset_after(upe, 0, hard);
>  
>  	nlmsg_end(skb, nlh);
>  	return 0;
> -- 
> 2.50.1
> 

