Return-Path: <stable+bounces-235451-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDM/HLPX12mDTggAu9opvQ
	(envelope-from <stable+bounces-235451-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 18:45:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC2F3CDC4E
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 18:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50B59300C592
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 16:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A333E122A;
	Thu,  9 Apr 2026 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xm0ORjg9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4B11A3154;
	Thu,  9 Apr 2026 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775753132; cv=none; b=m6cgEeXnsE4RkO6kg7MA5ucuUHxT9JaViEi29DUPmUxjwtQm1uwtM/J9TgBryKvPfJJWTK3QnF6lxnY/HrrubtSnT1hjiFo2kdP7TJwggkpxg6IpS/EmhUqK4a17JuiHoDiiUomwPNVLOJs8phfpFQyUroNa9nhM5AYjtjdko1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775753132; c=relaxed/simple;
	bh=dVXr03RoqzK0gwU6bzmF456fwdFwS/5nKDD/1hodd5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIAHftoqb0ciOl9llHAvhs9AtWt/kIitrnxUGDWmViVLaqAyBgG5ueHmPuM4W5ucgp6KTyHkYgYvLm/XSDfyz2iO0eVrz6Vvx423dbFIykxMb0pLTvYj/uIo4kZksQHQDcfmrsU/z45YV59SB49wny3qr62lDzSqZ1iSe4rFfoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xm0ORjg9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66917C4CEF7;
	Thu,  9 Apr 2026 16:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775753131;
	bh=dVXr03RoqzK0gwU6bzmF456fwdFwS/5nKDD/1hodd5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xm0ORjg9v241Bg2dH6v74j+EqROwVDJfRzUr0uqjUU9Ah2QXV2ut8YowwaLC7mMTG
	 NlGvyS3iaU0oM5K84yZbfrXzkx6J6D0Y6Hl+uj104854yfsPfqTNdk/FCGsLetL9kK
	 3UhQ8NjoPno0mZHId3+pZA4mo/5o0gOxiT3r5YABoq4JKwYSJjwJktHjgL08KY65sN
	 aimgMdmn87LeBDMoZqBoYytLEMvjO2+Y/zorUnC1OO4YcG+tGU1t8/9BBu3BhC+6K9
	 JnZXVMkue4cgM4+IlMtIarb1o2C/O92gtEjb67+ZBlCfGve5IaSqxY8gmiEDtwip1l
	 Uy9M15tJtXeIA==
Date: Thu, 9 Apr 2026 17:45:27 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?TGVrw6sgSGFww6dpdQ==?= <snowwlake@icloud.com>
Cc: netdev@vger.kernel.org, linux-nfc@lists.01.org, davem@davemloft.net,
	kuba@kernel.org, krzysztof.kozlowski@linaro.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nfc: llcp: fix missing return after LLCP_CLOSED check in
 recv_hdlc and recv_disc
Message-ID: <20260409164527.GP469338@kernel.org>
References: <20260405164158.1344049-1-snowwlake@icloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260405164158.1344049-1-snowwlake@icloud.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[icloud.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-235451-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1EC2F3CDC4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 05, 2026 at 06:41:58PM +0200, Lekë Hapçiu wrote:
> From: Lekë Hapçiu <framemain@outlook.com>
> 
> nfc_llcp_recv_hdlc() and nfc_llcp_recv_disc() both call
> nfc_llcp_sock_get() (which increments the socket reference count) and
> lock_sock() before processing incoming PDUs.  When the socket is found
> to be in state LLCP_CLOSED both functions correctly call release_sock()
> and nfc_llcp_sock_put() to undo those operations, but are missing a
> return statement:
> 
>     lock_sock(sk);
>     if (sk->sk_state == LLCP_CLOSED) {
>         release_sock(sk);
>         nfc_llcp_sock_put(llcp_sock);
>         /* ← return missing */
>     }
>     /* Falls through with lock released and reference dropped */
>     ...
>     release_sock(sk);            /* double unlock */
>     nfc_llcp_sock_put(llcp_sock); /* double put → refcount underflow */
> 
> The fall-through causes three independent bugs:
> 
>   1. Use-after-free: all llcp_sock field accesses after the LLCP_CLOSED
>      block occur with the socket lock released and the reference dropped;
>      another CPU may free the socket concurrently.
> 
>   2. Double release_sock: sk_lock.owned is already 0 — LOCKDEP reports
>      "WARNING: suspicious unlock balance detected".
> 
>   3. Double nfc_llcp_sock_put: the refcount is decremented a second time
>      at the end of the function, potentially driving it below zero
>      (refcount_t underflow), corrupting the SLUB freelist and causing a
>      subsequent use-after-free or double-free.
> 
> Both functions are reachable from any NFC P2P peer within physical
> proximity (~4 cm) without hostile NFCC firmware:
>   - nfc_llcp_recv_hdlc: triggered by sending an LLCP I, RR, or RNR PDU
>     to a SAP pair whose connection has been torn down.
>   - nfc_llcp_recv_disc: triggered by sending an LLCP DISC PDU to a SAP
>     pair that is already in LLCP_CLOSED state.
> 
> Fix: add the missing return statement in both functions so that the
> LLCP_CLOSED branch exits after cleanup.
> 
> Fixes: Introduced with nfc_llcp_recv_hdlc / nfc_llcp_recv_disc
> Signed-off-by: Lekë Hapçiu <framemain@outlook.com>

Curiously this seems to duplicate this patch:

- [PATCH net] nfc: llcp: add missing return after LLCP_CLOSED checks
  https://lore.kernel.org/all/20260408081006.3723-1-qjx1298677004@gmail.com/

-- 
pw-bot: changes-requested

