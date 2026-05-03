Return-Path: <stable+bounces-242650-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJSZDqom92nfcwIAu9opvQ
	(envelope-from <stable+bounces-242650-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 12:42:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6FC4B5255
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 12:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 139413006F0A
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 10:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5139322FE0E;
	Sun,  3 May 2026 10:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kyb41lV4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150AB39FD4
	for <stable@vger.kernel.org>; Sun,  3 May 2026 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777804967; cv=none; b=ejLGaJO1Ztie8IGiRYYdH9/ri/7T158b+gFyFsIffw9c0h0jTLL+cFTc9sbJxdNwLR8CsW7Z6htE4FDyZw4t/MTui1nw/n4MoqVOuXNDsSNh+usunoCZNp+GI/sPWxz7Z5aAbS3OpkzGXONOfiiAA1wjgRlSmnQ5wxRJWJx+Muw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777804967; c=relaxed/simple;
	bh=2UoZJXAv/JH4kdpPqz1xJEgRz5xTTq9osGYSA2+ESs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNEGPCdun2SqatDhqMoMJ/plpTBI0YZ/7yCBS4dAKEUTw5F2tVsKVG9+YSo41b/VzAkBNj/vfKK7aCCThVPSJ3wut1Uk2gn/zESwloIiH4Hl6WS9FhHEZhuRbUPcG/sBSgFoXmc7k/WEOUdvcVVrlaOey6LcjhCmTBG3jWeYyak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kyb41lV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49297C2BCB4;
	Sun,  3 May 2026 10:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777804966;
	bh=2UoZJXAv/JH4kdpPqz1xJEgRz5xTTq9osGYSA2+ESs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kyb41lV4hBNfr6EmeIQCzE1O7srIFCQ1TT0lXyjMMiv4mbaweZMqfvlkEmzRQXwFL
	 jhERtpeZ0xTAJ6ryV0Gfrmyrg2ikZkUJlxHVs14Hol8DO290DkoNE1d5A1lIv3ChL6
	 25nbav+2BZYIldIKu6XYOdtGOa2KDJa9BPibPtAI=
Date: Sun, 3 May 2026 12:42:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: 0nsec <0nsec@proton.me>
Cc: security@kernel.org, herbert@gondor.apana.org.au,
	stable@vger.kernel.org
Subject: Re: [PATCH] crypto: af_alg - convert inflight to atomic_t to fix
 data race
Message-ID: <2026050335-spiny-lullaby-2559@gregkh>
References: <rM7uJ0oBopViOraMoC0Ya0_hMtNwV4CLor-vdwN4vIH7BOKqCuuC0OWUOQoOS-0XOcJmSIT5vhR4UmZlIJxD7mllIkq1UVqEop3T0e4bjis=@proton.me>
 <2026050304-greeting-prankster-910b@gregkh>
 <QACE4BCfRIeL8Dm_ETPxjem791yvR3Lj6Iw3ArtLWxEU5FwAmjTCS6DZA_hdQfyhi2MYJTIu-p36nDpUwQbhWwxc1X2LgZSCMikbNFdOGCE=@proton.me>
 <2026050328-civic-monoxide-0a54@gregkh>
 <20260503095345.375711-1-0nsec@proton.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503095345.375711-1-0nsec@proton.me>
X-Rspamd-Queue-Id: 7E6FC4B5255
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242650-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[proton.me:email,linuxfoundation.org:dkim]

On Sun, May 03, 2026 at 09:54:27AM +0000, 0nsec wrote:
> The inflight field in struct af_alg_ctx guards the invariant that only
> one AIO crypto request may be in flight at a time.  It is declared as a
> plain unsigned int but accessed from two unsynchronized contexts:
> process context under lock_sock() and the async crypto completion
> callback which runs without any socket lock.
> 
> Data race under the C11 memory model.  On weakly-ordered architectures
> the store in the completion path could be observed out of order relative
> to the preceding areq free, widening the window for state confusion
> between a completing first request and a newly allocated second one.
> 
> Convert inflight to atomic_t.  Use atomic_xchg() for the check-and-set
> in af_alg_alloc_areq() so check and set are one atomic operation,
> eliminating the TOCTOU that separate atomic_read + atomic_set would
> leave.  The ENOMEM rollback path must also clear inflight since
> atomic_xchg() sets it before the allocation attempt; without this a
> failed allocation permanently blocks further AIO on that socket.
> 
> Follows the precedent of af955bf15d2c ("crypto: af_alg - Fix race
> around ctx->rcvused by making it atomic_t").  The inflight field
> introduced in 67b164a871af repeated the same locking gap.
> 
> CVE-2025-71113 fixed uninitialized garbage in inflight via memset.
> That is a distinct bug.  This race exists independently.
> 
> Fixes: 67b164a871af ("crypto: af_alg - Disallow multiple in-flight AIO requests")
> Cc: stable@vger.kernel.org
> Signed-off-by: 0nsec <0nsec@proton.me>

We need a real name for the author and signed off by line.

thanks,

greg k-h

