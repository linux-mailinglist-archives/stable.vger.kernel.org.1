Return-Path: <stable+bounces-259776-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEjZOCupHmq3IwAAu9opvQ
	(envelope-from <stable+bounces-259776-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 11:58:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AE36B62C02C
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 11:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC107302F6BC
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 09:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8575637EFEE;
	Tue,  2 Jun 2026 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzMvyOnj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B89A3438BA;
	Tue,  2 Jun 2026 09:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393997; cv=none; b=Q4Jv80UtgoW9ZfUNcy6U2E5z9DPZcMYidvVy0f0rcWzGKihtF8TGA/xHgqKgpL53IXv2r/AVGkL8nWRCh0pTva5Tq0U996XCEA+w5ghjLeDvcRYsb9p6AHK5wznewWxnPBqhhmtqfxhPgNSCJPvx3sV+32C11QSE1HF7wjmIPng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393997; c=relaxed/simple;
	bh=rjgJopmm0hgPkYLiks8AirHuzdconywJg1WM5Jh4Rtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDDqyHxKjqpz0o9U4WLsccOH1x6k+5rJtu2Q04QG5Kq3GKTZ3qvWXcnF4PYH9ZRqMI46U76klgRG62kwdE2eDLlIpmyFVm0VWOif9xUB9p9aGX3lNkkepGQAgFDvrURzPGJ0lmgcBlJKvEaNOeIzcoGFSTJdAmLouEKUwTP73sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzMvyOnj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4061F00893;
	Tue,  2 Jun 2026 09:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780393996;
	bh=vspLZu4gt3bfKj6oLamCpaOBnCyewGN7syJy0pK9fPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KzMvyOnjDjjOxwmMfq+CEqitEIeuw7OYTe+UuDbEu54rShYPkAwNYowRvK+1azHrm
	 p37sYHLGS4nBpQc4feQzv6M27hp8A6ok8bcu2p14QMaQ+nirttlJn3lyuwakGTtXwk
	 zEqqkSwm/ekpGznNS3IrnaH3GqENfKUvCTGYpI6fPXmkcpii3VBftHvfuJydxnB+I8
	 HWs1p642RsXbjSeknw+fb7Y4QzzafSKFxQ5Ce58MU7m3acwQ1NurgXAxM09sEIX//B
	 9+dO+hDMYcjVCFb4eJhYUUIE9TSNhfflXicgVOwzLGDTmyS8aMJn92UyB6vKBr3mWg
	 fPm5THM9C5Nnw==
Date: Tue, 2 Jun 2026 10:53:11 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Aiden Bowling <aidenlbowling56@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] kernel/sys.c: fix prctl_set_auxv to use sizeof instead
 of user-supplied len
Message-ID: <ah6jS246wBcTH6gr@lucifer>
References: <20260602024001.14119-2-aidenlbowling56@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602024001.14119-2-aidenlbowling56@gmail.com>
X-Rspamd-Queue-Id: AE36B62C02C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259776-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Jun 01, 2026 at 10:40:02PM -0400, Aiden Bowling wrote:
> prctl_set_auxv() passed the user-supplied 'len' to memcpy() when copying
> into mm->saved_auxv, instead of sizeof(user_auxv). Since user_auxv is
> already sized to the full auxv buffer, using 'len' risks a partial write
> if the caller supplies a smaller value. Use sizeof(user_auxv) to always
> copy the full buffer after validation.

Hm, but would this be an issue? A user can specify only a partial write and get
what they expect, I don't think there's any security issue here.

I also guess a user could specify a length that's not a multiple of
sizeof(unsigned long) but again they'd get the results they might expect from
doing something silly like that :)

And users might rely on this only doing a partial write for whatever weird
reason so I don't think we can change this really?

>
> Signed-off-by: Aiden Bowling <aidenlbowling56@gmail.com>
> ---
>  kernel/sys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 62e842055cc9..d3f5229649e3 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2189,7 +2189,7 @@ static int prctl_set_auxv(struct mm_struct *mm, unsigned long addr,
>  	BUILD_BUG_ON(sizeof(user_auxv) != sizeof(mm->saved_auxv));
>
>  	task_lock(current);
> -	memcpy(mm->saved_auxv, user_auxv, len);
> +	memcpy(mm->saved_auxv, user_auxv, sizeof(user_auxv));
>  	task_unlock(current);
>
>  	return 0;
>
> base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
> --
> 2.54.0
>

Cheers, Lorenzo

