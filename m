Return-Path: <stable+bounces-243876-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJNPLq/L+Gma0wIAu9opvQ
	(envelope-from <stable+bounces-243876-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 18:39:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A1E4C1830
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 18:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 444F2302F583
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 16:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6793E3C4F;
	Mon,  4 May 2026 16:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=innora.ai header.i=@innora.ai header.b="pzXF727b"
X-Original-To: stable@vger.kernel.org
Received: from mail-244118.protonmail.ch (mail-244118.protonmail.ch [109.224.244.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A48E3D9040;
	Mon,  4 May 2026 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777912727; cv=none; b=tSN3l/8vjY6jp0R6PNTbGBuLPTL37qboX9KsQWDBZRfApkuMYEGaCXK2ERaoQtD8VPdylIvwqIJRG0VNV95QGjsyEhZhWHqH1iaxDcCgMY8ZA2Vm8t0kL1b+3XK6KGeYOvTdEIJJI9r0VPrSkvyolAGNa5kxQsmhKyr0a4Prk28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777912727; c=relaxed/simple;
	bh=UJQtwdxYy+rByq9K+VAHmNOBeVflC5kLexSB2YR569c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KtHXVB88O+LAdMyjsLB1h8VcN8oPl62forKjl2tEOgJzG6P+6UYK0glS3/5srtMbYNiBjj0M45hhGO8iHmLSs6JXVEUG2MDtuwlNuMuZi9Yyk5rzNpvl4fmoUDMoRqmLyTkRVsR5J9rVRjwKmR/kWKksty4oo3NUgWnmTggn+7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innora.ai; spf=pass smtp.mailfrom=innora.ai; dkim=pass (2048-bit key) header.d=innora.ai header.i=@innora.ai header.b=pzXF727b; arc=none smtp.client-ip=109.224.244.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innora.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=innora.ai
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innora.ai;
	s=protonmail2; t=1777912721; x=1778171921;
	bh=oPte7l8uEb7xnk/RLS5OPzuq6rHnHMCvn4HKjFxNQPg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=pzXF727bQRtzVE4FErsUj6hhJLEzsCjjoVcxFIa9fWYxhGAaoz5Nj3Ux8pfxWHRdz
	 WS72sE9ZlDrG7MPMxDxdNbIAGoHqId+HcIvp3yHQu55Q0xDrEzDorl4bFGDw0FoPug
	 ZkKwmyVNaGf6z5nJpr2C3KtUQIb10VZHgp/jNqX4vzjwX60SFoCHPXEfPVwR3P/jVW
	 pJ8GgIPlMKwzbrXWqcyBahtsdzl4fwuAZPXrfopDA0HgEBNodHL8RklTO1p3I9GKNJ
	 zp89alhSRhNZvnaGg0/dKZEGdQQqNy7mt/fsps2zn6ZcxByueGh3bs+eKBdqbYKxlK
	 RkYtpsoGlTANQ==
Date: Mon, 04 May 2026 16:38:35 +0000
To: gregkh@linuxfoundation.org
From: Feng Ning <feng@innora.ai>
Cc: linux-staging@lists.linux.dev, Luka Gejak <luka.gejak@linux.dev>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6] staging: rtl8723bs: fix heap buffer overflow in cfg80211_rtw_add_key()
Message-ID: <20260504163828.90294-1-feng@innora.ai>
In-Reply-To: <2026050458-numbness-haven-1ae4@gregkh>
References: <20260413113224.5201-1-feng@innora.ai> <2026042626-tabloid-suitor-33c5@gregkh> <20260427111738.33069-1-feng@innora.ai> <2026050417-monkhood-backless-4c3e@gregkh> <20260504154823.52057-1-feng@innora.ai> <2026050458-numbness-haven-1ae4@gregkh>
Feedback-ID: 140578448:user:proton
X-Pm-Message-ID: 651521782a266a3bfa15d81423969c6cf5b12709
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D8A1E4C1830
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[innora.ai,reject];
	R_DKIM_ALLOW(-0.20)[innora.ai:s=protonmail2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243876-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[feng@innora.ai,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[innora.ai:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,innora.ai:dkim,innora.ai:mid]

On Mon, May 04, 2026 at 06:03:02PM +0200, Greg KH wrote:
> Let's fix this in a way that the code can be moved out of staging
> someday please.
>
> > That said, I can see the argument for -EINVAL: it makes the contract
> > explicit and avoids installing a key with a truncated sequence counter
> > that could produce unexpected crypto behaviour.
>
> Yes, that is better.
>
> > Regarding hardware testing: I do not currently have a physical
> > rtl8723bs device.
>
> Ideally someone can test this on the real hardware.  I'm loath to take
> real patches for this driver without that happening.

Hi Greg,

Thank you.  I will change the silent truncation to an explicit -EINVAL
when seq_len > sizeof(param->u.crypt.seq) for the next iteration.

Regarding testing: I do not have access to RTL8723BS/BU hardware to
verify this, and I will not resubmit as a regular PATCH without a
Tested-by from real hardware.

Would you prefer I send the -EINVAL revision as an RFC on
linux-staging and linux-wireless to ask for a community tester, or
should I drop the patch until someone with the hardware picks up the
thread?

I'm fine with either path -- whichever you prefer.

thanks,
Feng Ning


