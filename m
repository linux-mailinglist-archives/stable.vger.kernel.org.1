Return-Path: <stable+bounces-230660-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PvAMTOKxmlELgUAu9opvQ
	(envelope-from <stable+bounces-230660-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 14:46:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA0A345846
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 14:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69EF0309BED0
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 13:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592B83EB809;
	Fri, 27 Mar 2026 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVvPZ1Cb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8B81DE3B5;
	Fri, 27 Mar 2026 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774618732; cv=none; b=gCEp0KZq15X/MkYMRsOBVwygYoEx/A/kkLa6J4X0mDHArCUFO/i01kFUgb4L5KmDF5cQXJUZZg9wUzVLR6vPLAIGolbmv8aPgXBOyN0m/oyx2zhSRWdxd8+xW3Jn9aE5jo1jUgDP6uKpx77q3xw9AMqoR6lR181z5tB3yMrEv4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774618732; c=relaxed/simple;
	bh=WNYm/2QaUqI20NA6qh0PjfU0eFWt+j2QfcgwdY6dQJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMUtaG73ND1qCYkJm3wuIBcAZsUsR+PzK4QFa0gLgWZb2WZOXUZoq5PQH539rn2NfTjFXu2s7wmjGd+OwuPwk9XxEDhZghjoRx12EgQRBz60D0TJmrOlhS8lJ61eJBityh7yepiWv7nvuyjPbcSDIEqskMy5Bt5z3xAcCRc+Wu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVvPZ1Cb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25475C19423;
	Fri, 27 Mar 2026 13:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774618732;
	bh=WNYm/2QaUqI20NA6qh0PjfU0eFWt+j2QfcgwdY6dQJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eVvPZ1CbMk/lfrV194gdcnVcKyufXg/WoNNraQHTtHfRE/yFmTzKmBw5KOtBhb/GP
	 B7obE2opX0q6ixieQ8qMfzoPX6mFzmFmziWdnhHo+nqU+DmIG/A789t6jgO8mS7NKu
	 5WVc1ZwwdyjemmQwWfMP0OoBQipQLVyASG6R6O7rCBZGnp0aMtvVdXTQi7Ikb38nTK
	 Am9WXQkMiRWWfTDKLPVGjrPCxueEII7+fOQHIxUd2wfirGenRlG3jhFtuuuie9NRTn
	 K4TTq0OAMuysrUJYHVmqEiFYF5+jGN7+dX8oSsNiiyFLqz9/29XFBoAOB71o4Kw9XT
	 4C2b/xGLmCJBA==
Date: Fri, 27 Mar 2026 13:38:47 +0000
From: Simon Horman <horms@kernel.org>
To: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] xfrm: clear trailing padding in build_polexpire()
Message-ID: <20260327133847.GG567789@horms.kernel.org>
References: <20260326055801.897013-1-yasuakitorimaru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326055801.897013-1-yasuakitorimaru@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-230660-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid]
X-Rspamd-Queue-Id: 2BA0A345846
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 02:58:00PM +0900, Yasuaki Torimaru wrote:
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
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
> ---
> v3:
>   - fix Fixes tag to cite the commit that introduced the bug
>     (was: e3e5fc1698ae which fixed the related build_expire() function)
> v2: https://lore.kernel.org/netdev/20260324013742.939533-1-yasuakitorimaru@gmail.com/
>   - add Fixes tag and Cc stable (requested by Steffen Klassert)
> v1: https://lore.kernel.org/netdev/20260321210421.2504711-1-yasuakitorimaru@gmail.com/

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>

