Return-Path: <stable+bounces-242044-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNIZO/0G82lHwwEAu9opvQ
	(envelope-from <stable+bounces-242044-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 09:38:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E78D449EBB2
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 09:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C25653004DA9
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 07:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A57F3DA5AC;
	Thu, 30 Apr 2026 07:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="lIRYhsmR"
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14C93D9033;
	Thu, 30 Apr 2026 07:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777534707; cv=none; b=iTmxNfxrUHrf+FnH3IFoZunZjt1dG1gn6JcTfxPY/r2lMVL/au33croMQLW44E3UVEqVquQ21HnPjAKUzvGm+Wr1Lxxvq9p6aqo5IphtVt70khr9awrfj36WXtmNd6uuORhnFVkTFYJ6qbLSqSlyM+VaSr2bZAU91aRPl++ZONw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777534707; c=relaxed/simple;
	bh=eksxvsbDdZZrboXO7N34nKTHzByTtlomhkQCFHWIglU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8FHoSTlDKmQCj6hHf3dt381wBJKcIBs0wxPT3Fxm9gfmRRWd803PbZt9bJsB4o0U3ZVgvQsnLkMTHAeUfLzDwCBDVKBNtq5Lb/9l+nsfGQt6E3J8JdZ342op061u7GPNOcit01n8WFk/XrfQPpsiy6oOF7aCJf3NRq6hR0N+JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=lIRYhsmR; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id 8D1E21FF8D;
	Thu, 30 Apr 2026 07:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777534689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lrWkfmosicCb3bXJFi7fcRxV+xZwfl91sGSlkgUQsYQ=;
	b=lIRYhsmRno4XToAYKY2FN2Yf2DHcu3M89tJ61RllITajpDHavnbrB9y/rvnvS4DO552Wd4
	uenZSsUW14sY/31l0lDlw+Qil/Gyx3SXQ31nHgZ1Abu7UiInN0kpvkOJ2X12xvEhugmWjy
	GQ5lU0m7EOMjfYFqSj9+poDsf0nd+tg=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org, Haoze Xie <royenheart@gmail.com>,
 Robert Garcia <rob_garcia@163.com>
Cc: Simon Wunderlich <sw@simonwunderlich.de>,
 Robert Garcia <rob_garcia@163.com>, Yifan Wu <yifanwucs@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Yuan Tan <yuantan098@gmail.com>,
 Xin Liu <bird@lzu.edu.cn>, Ao Zhou <n05ec@lzu.edu.cn>,
 Marek Lindner <mareklindner@neomailbox.ch>,
 Antonio Quartulli <a@unstable.cc>, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject:
 Re: [PATCH 5.15.y] batman-adv: hold claim backbone gateways by reference
Date: Thu, 30 Apr 2026 09:38:05 +0200
Message-ID: <1857579.VLH7GnMWUR@ripper>
In-Reply-To: <20260430071645.3030702-1-rob_garcia@163.com>
References: <20260430071645.3030702-1-rob_garcia@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8717455.NyiUUSuA9g";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Rspamd-Queue-Id: E78D449EBB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,163.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-242044-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[narfation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[simonwunderlich.de,163.com,gmail.com,lzu.edu.cn,neomailbox.ch,unstable.cc,davemloft.net,kernel.org,lunn.ch,lists.open-mesh.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[simonwunderlich.de:email,narfation.org:dkim,narfation.org:email,lzu.edu.cn:email]

--nextPart8717455.NyiUUSuA9g
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 30 Apr 2026 09:38:05 +0200
Message-ID: <1857579.VLH7GnMWUR@ripper>
In-Reply-To: <20260430071645.3030702-1-rob_garcia@163.com>
References: <20260430071645.3030702-1-rob_garcia@163.com>
MIME-Version: 1.0

On Thursday, 30 April 2026 09:16:45 CEST Robert Garcia wrote:
> From: Haoze Xie <royenheart@gmail.com>
> 
> [ Upstream commit 82d8701b2c930d0e96b0dbc9115a218d791cb0d2 ]
> 
> batadv_bla_add_claim() can replace claim->backbone_gw and drop the old
> gateway's last reference while readers still follow the pointer.
> 
> The netlink claim dump path dereferences claim->backbone_gw->orig and
> takes claim->backbone_gw->crc_lock without pinning the underlying
> backbone gateway. batadv_bla_check_claim() still has the same naked
> pointer access pattern.
> 
> Reuse batadv_bla_claim_get_backbone_gw() in both readers so they operate
> on a stable gateway reference until the read-side work is complete.
> This keeps the dump and claim-check paths aligned with the lifetime
> rules introduced for the other BLA claim readers.
> 
> Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
> Fixes: 04f3f5bf1883 ("batman-adv: add B.A.T.M.A.N. Dump BLA claims via netlink")
> Cc: stable@vger.kernel.org
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Haoze Xie <royenheart@gmail.com>
> Signed-off-by: Ao Zhou <n05ec@lzu.edu.cn>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> Signed-off-by: Robert Garcia <rob_garcia@163.com>

See https://lore.kernel.org/r/20260413125407.85603-1-sven@narfation.org for 
the original backport. Can you explain further why you send a new version?

Sasha Levin <sashal@kernel.org> picked it up for 5.15.y (on Sun, 19 Apr 2026 
21:13:58 -0400, MsgId 20260419195610.batman-adv-5.15@kernel.org). 
Yes, it was not yet published or 5.15 - so maybe fell through the cracks.

Regards,
	Sven
--nextPart8717455.NyiUUSuA9g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCafMG3QAKCRBND3cr0xT1
y41NAQDcrtNDGgWALEYpUXSE0WJzqoMrzlHp9SPLAwNG0wQnAgD+KXx7wBA9AmQ5
m9xfCxUXBRwKccOO0RwYSOtd4QP3igY=
=5+3O
-----END PGP SIGNATURE-----

--nextPart8717455.NyiUUSuA9g--




