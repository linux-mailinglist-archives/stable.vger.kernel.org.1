Return-Path: <stable+bounces-270285-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RwkwGhqzRWp9EAsAu9opvQ
	(envelope-from <stable+bounces-270285-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 02:38:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 138C06F2A4B
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 02:38:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="oVeR8/iA";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270285-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-270285-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A7E71302C1E7
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 00:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFBE269CE7;
	Thu,  2 Jul 2026 00:38:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EBB25393E;
	Thu,  2 Jul 2026 00:38:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782952724; cv=none; b=ScLDx/d2vBNmYaUP/qolOj7vUTP3iN8fwhOEhu4udTJ0qJlAwORco0FRYs+jbpXJ1tNUe6QZivQj/tUNyRqszOuWHDIHwZxMhXywNjPppTKXj0g5TxJLIQoDg0fASKsI+8aiBiD7Pg0o0cYm7EsPNcSsM5p/hbPAjcim2xUcmas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782952724; c=relaxed/simple;
	bh=jmMbfSqO4cLFbCH/DZL8gp+p4l4LgF7rKkYkTDjefOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrhnpOU2eCsrUL9pZ1D4WGf3PsOBCxKGwQAsAU+vfhWoVVAeMHOdN+l0foseNUvIXDIHf2wqwW6pW2tGw2C60XtPwr5SwmT/YNpQjiyQ75Y404a+kI+JXcPBdLqk/a/wxPXzIXKHwNw9NUdxwu7tdYm0oyry3ApPKQ4JmFR0zFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVeR8/iA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413EB1F000E9;
	Thu,  2 Jul 2026 00:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782952723;
	bh=5Z0A4+GySrF2D2B8jkIYsS1QFz1i0QipJD8gmvXAfWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oVeR8/iAnLLveyabREcOJXgbTsERoG/eCYE63tmRBBIIfGnzNXaRbYWkrA6yfVam1
	 1gLg1E9+eXZPMFOePDlfnciajvqyXqR829yQmTHz44P35+bBB0t9a+sLUACtFG0Pei
	 xKoVUHs4Lix0IoHlkEx1+NBehgpOo3x7Cun3HCK7sYcy5W0kzBXmIaTlPdRMjDZMsf
	 +usyT/gWSl/0WTc+RNZUyzuHha5MvIhVuZP3QyG82Fw8R6bPPi5zip81PtvOLxPfoP
	 L589StVxHCGflaVu7mSMvOFHwg4g5XSeye7FRiweNmaFp6VSZXR0LCf8pBHItXLgjZ
	 LBFD6uaAFOkjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Muhammad Alifa Ramdhan <ramdhan@starlabs.sg>,
	Bing-Jhong Billy Jheng <billy@starlabs.sg>
Subject: Re: [PATCH 5.10/5.15] crypto: af_alg - Set merge to zero early in af_alg_sendmsg
Date: Wed,  1 Jul 2026 20:38:27 -0400
Message-ID: <stable-reply-af-alg-merge-20260701193800@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701160121.100720-1-mdmitrichenko@astralinux.ru>
References: <20260701160121.100720-1-mdmitrichenko@astralinux.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270285-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:mdmitrichenko@astralinux.ru,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,m:ramdhan@starlabs.sg,m:billy@starlabs.sg,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 138C06F2A4B

> If an error causes af_alg_sendmsg to abort, ctx->merge may contain
> a garbage value from the previous loop.  This may then trigger a
> crash on the next entry into af_alg_sendmsg when it attempts to do
> a merge that can't be done.
>
> Fix this by setting ctx->merge to zero near the start of the loop.

Queued for 5.15.y and 5.10.y, thanks.

-- 
Thanks,
Sasha

