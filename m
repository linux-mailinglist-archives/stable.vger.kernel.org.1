Return-Path: <stable+bounces-214839-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zbPFNjqth2nebgQAu9opvQ
	(envelope-from <stable+bounces-214839-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 22:23:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6CB10725B
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 22:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0123301179C
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 21:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D032857C7;
	Sat,  7 Feb 2026 21:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4sh1Dr+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B18450276;
	Sat,  7 Feb 2026 21:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770499383; cv=none; b=TplnvZm4QuOec6CLBjUGqOrrFxAiSaGSSQrIs8oLiu6DB/qWaCGwF3mixhxni148jouYfCBXSS3m2/jLcdUaCJwvncqVUo+aUqXPPTgD4Gp3GMytQwmHOPQWHgx3/HZjIgPqkF4iURsOYYZ7R8qVNLQtyuYNqJhkWgph5G9rDXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770499383; c=relaxed/simple;
	bh=WbQjMhOPtfr910QnshnlTPVJ9QLKcXL9+3iN1npfDkY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GGQSwZ5ZwmVJQI76/ypI8ZuI97gwGCUxaj2WgzecFL+PBvrrH62TT5gaWWNViuXWjxx54ncgP/G+/JU9zzZK1KLo+BFx0WbMm7JibGNL7U0fG39PEN33h79nl2rArspqa7q3qp0iwtpkuxP2ESnNzIzHL+aaZHFNhBnR0DzZ7S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4sh1Dr+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C30C116D0;
	Sat,  7 Feb 2026 21:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770499383;
	bh=WbQjMhOPtfr910QnshnlTPVJ9QLKcXL9+3iN1npfDkY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=U4sh1Dr+33+z2Az4uQQxZlCV185e+HSGN69pUjK+oAu6xX5lSpfOqk2Uk1JbEYue6
	 xoRKzNQ49/AilbKlwUrgxnogdzN+HHNwgGIW1x+nNdCKGCapzLXO/Vb8gWZY4YEpaL
	 sBiVXDZxRTJ1GNZwaxvwWAbHe4j6sdl+YE6uxqYmE+gN5y5FamH5cklisvr3PGkgVq
	 GtB0ILwj09xwIn4nZEXm+3X2z3HjwX2KbAoIYbWb6EvmedV1t7uaX/A3Np3bUUVDPA
	 oBhylSMw7KGelu550GrblwHyOP+nyPcvMFFMnYnn+8Y1zNogvRzVL1w/LUIXTJl6tF
	 8f6NcP1140CzQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Robin Murphy <robin.murphy@arm.com>, stable@vger.kernel.org
Subject: Re: [PATCH] irqchip/gic-v3-its: Limit number of per-device MSIs to
 the range the ITS supports
In-Reply-To: <20260206154816.3582887-1-maz@kernel.org>
References: <20260206154816.3582887-1-maz@kernel.org>
Date: Sat, 07 Feb 2026 22:22:56 +0100
Message-ID: <87h5rsb64v.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214839-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A6CB10725B
X-Rspamd-Action: no action

On Fri, Feb 06 2026 at 15:48, Marc Zyngier wrote:

> The ITS driver blindly assumes that EventIDs are in abundant supply,
> to the point where it never checks how many the HW actually supports.
>
> It turns out that some pretty esoteric integrations make it so that
> only a few bits are available, all the way down to a. single. bit.
>
> Enforce the advertised limitation at the point of allocating the
> device structure, and hope that the endpoint driver can deal with
> such limitation.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org

Can you please provide a Fixes tag?

Thanks,

        tglx

