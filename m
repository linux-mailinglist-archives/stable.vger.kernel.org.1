Return-Path: <stable+bounces-237938-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oArqKUF53mkHEwAAu9opvQ
	(envelope-from <stable+bounces-237938-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:28:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 081BB3FD147
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A2E7301588F
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C0E3F0750;
	Tue, 14 Apr 2026 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8NhSbf9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33D83B19BC;
	Tue, 14 Apr 2026 17:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776187699; cv=none; b=O5dmNmu98HtJeOQgaR9DR80Fx2w4QNaeMCX7xwtLK2o2boXY07DeTJJNeHOG8UsMRbImhpAY+NZLryQwJh/q+Q5s+8+hWirVhExptl9UncLmeHo89JSOrvF/TyIjafc7ZU60i/AfDnjP2MrpytxnZQXXkIJG3lY9u2MKposl3fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776187699; c=relaxed/simple;
	bh=Fm2RpPPb3k/NGlUwkwGP81Hv+Q2wA6E3OUwKftyL88s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P49q8bcEj6Z+kywyuw/wg90N69qvLgSerZpr8vx6f2Er7J4sQ6CSwvxpW73oDkK1zLfFMOFxKxap8T+Gd7+D/8z2HIJnI2TkWa1IO1yAtzjmngwrBcOy8rwIZyuka7V9alZe6IdJuKnw8cdiyMF5duVSXkfQAd7nvI/HxgfW+8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8NhSbf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24FFC19425;
	Tue, 14 Apr 2026 17:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776187698;
	bh=Fm2RpPPb3k/NGlUwkwGP81Hv+Q2wA6E3OUwKftyL88s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I8NhSbf96lyEWYGKb+tjQG0VhaMcnvDG9+VsNImYJwrimGFnOTaC08eEpX/H3Ez6S
	 bO861KIKYE6sSYEwwRKW0ldvy3JrKAD0RlZ8W8BkFqRa7kqwOH4bncPjyr1F8ltQyQ
	 VOS4kB4AH14Y4MeF7C3XT7X9wNSDQcff9HStsC8q8WK2QpxaSkSux8qk+EjZxGq4Ht
	 /SUIEBrqKI26YnmXR5hhzNst1bTufsIKgEMuNfyFfJ8FP28CjPSO754H+eRwhrrkBN
	 9OmO0xprZkJ7WiMxrlGtW4s20OkFgg3ucQ7M3aBUXB/mbgD3xpyWvuGmvDh1r7Na0N
	 YJ9e+b6UeL0PQ==
Date: Tue, 14 Apr 2026 13:28:17 -0400
From: Sasha Levin <sashal@kernel.org>
To: Wolfgang Walter <linux@stwm.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: Re: 6.18.22: a question to commit "crypto: algif_aead - Revert to
 operating out-of-place"
Message-ID: <ad55MXSYo_eZhQX1@laps>
References: <2026041152-boaster-patrol-1918@gregkh>
 <b397c5b34ed7484aad6e0acf7e1319c6@stwm.de>
 <fe119b5dc5716d1cf4ed53e6420cdf2c@stwm.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <fe119b5dc5716d1cf4ed53e6420cdf2c@stwm.de>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237938-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,theori.io:email,apana.org.au:email]
X-Rspamd-Queue-Id: 081BB3FD147
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 07:04:11PM +0200, Wolfgang Walter wrote:
>Hello
>
>another maybe stupid question to
>
>commit fafe0fa2995a0f7073c1c358d7d3145bcc9aedd8
>Author: Herbert Xu <herbert@gondor.apana.org.au>
>Date:   Thu Mar 26 15:30:20 2026 +0900
>
>    crypto: algif_aead - Revert to operating out-of-place
>
>    [ Upstream commit a664bf3d603dc3bdcf9ae47cc21e0daec706d7a5 ]
>
>    This mostly reverts commit 72548b093ee3 except for the copying of
>    the associated data.
>
>    There is no benefit in operating in-place in algif_aead since the
>    source and destination come from different mappings.  Get rid of
>    all the complexity added for in-place operation and just copy the
>    AD directly.
>
>    Fixes: 72548b093ee3 ("crypto: algif_aead - copy AAD from src to 
>dst")
>    Reported-by: Taeyang Lee <0wn@theori.io>
>    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>    Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>
>This commit makes
>
>crypto/algif_aead.c
>
>almost like the version in v7.0, but there is a difference:
>
>$ git diff v6.18.22..v7.0 crypto/algif_aead.c
>diff --git a/crypto/algif_aead.c b/crypto/algif_aead.c
>index dda15bb05e89..f8bd45f7dc83 100644
>--- a/crypto/algif_aead.c
>+++ b/crypto/algif_aead.c
>@@ -144,7 +144,7 @@ static int _aead_recvmsg(struct socket *sock, 
>struct msghdr *msg,
>        if (usedpages < outlen) {
>                size_t less = outlen - usedpages;
>
>-               if (used < less) {
>+               if (used < less + (ctx->enc ? 0 : as)) {
>                        err = -EINVAL;
>                        goto free;
>                }
>
>
>Is this intentional? Or is der missing a fix from v7.0 in 6.18.22

This is in 7c1d57841aa0 ("crypto: algif_aead - Fix minimum RX size check for
decryption"). It should make it into the next-next release.

-- 
Thanks,
Sasha

