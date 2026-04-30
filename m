Return-Path: <stable+bounces-242045-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6E1dJksI82lswwEAu9opvQ
	(envelope-from <stable+bounces-242045-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 09:44:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E45449EC75
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 09:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2ECAC306016B
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 07:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4489E3E5EC7;
	Thu, 30 Apr 2026 07:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="R0rS2QeC"
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2405E3D75DB;
	Thu, 30 Apr 2026 07:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777534843; cv=none; b=g36izSmFp/vLgWrtSz533mpcX8YQZ6M4cYKSxCr/phD36mHTkO16pR8MX2em4bDaViw4K/F2UOFNCt+L6/t/93sjgDwHdPBeHVRJ5I4abUvC+TJUitu4xHdRmPB5oRLL4OFNLFdjsor9L/wwCDqKOMk0lZBKEmLyRn5FNShRba4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777534843; c=relaxed/simple;
	bh=DbpqhBgikFhqeanDTgbXWWTBesPdRJl4WMBazV9sP/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ecBtzcyeHq6s28mtSHZedrMHCWDg4fwhCHvGM+PrvcdG/l0eww2c7xkxanIV4hRa1VpYRYLAMlmzpIyS0hQGA5B2KEgnHpauC+5qmiMLf8LJBljJjzM98vPm10q4cfQybIMgLup+BTpzt7f3dx31NdAiCsgtMiRuwwrKG9zTXRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=R0rS2QeC; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id 10CBB1FF65;
	Thu, 30 Apr 2026 07:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777534838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b5T6Tm8mn1JHMRFC8Mtn+CMd8n0ePg2A3I4KI2l1PNA=;
	b=R0rS2QeCbZsX3riHy7LG7YuYAQ5vd7gYDMFY/W+HjoTIOOeNKyBh443kjjMRPmsJHpQvsO
	bxR5mog0StlF0o+J/ijdo4EmDu4rYIuxR3bAILL45VX37Y6AoiSG8AJ0R5aRkWd5XN6y86
	pqCP2QpjyJoSD8H9jgi4QHnqIyZZPMs=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org, Haoze Xie <royenheart@gmail.com>,
 Robert Garcia <rob_garcia@163.com>, b.a.t.m.a.n@lists.open-mesh.org
Cc: Simon Wunderlich <sw@simonwunderlich.de>,
 Robert Garcia <rob_garcia@163.com>, Yifan Wu <yifanwucs@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Yuan Tan <yuantan098@gmail.com>,
 Xin Liu <bird@lzu.edu.cn>, Ao Zhou <n05ec@lzu.edu.cn>,
 Marek Lindner <mareklindner@neomailbox.ch>,
 Antonio Quartulli <a@unstable.cc>, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
 Sven Eckelmann <sven@narfation.org>
Subject:
 Re: [PATCH 5.15.y] batman-adv: hold claim backbone gateways by reference
Date: Thu, 30 Apr 2026 09:40:34 +0200
Message-ID: <3609597.QJadu78ljV@ripper>
In-Reply-To: <1857579.VLH7GnMWUR@ripper>
References:
 <20260430071645.3030702-1-rob_garcia@163.com> <1857579.VLH7GnMWUR@ripper>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1959533.CQOukoFCf9";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Rspamd-Queue-Id: 0E45449EC75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,163.com,lists.open-mesh.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242045-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[narfation.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[simonwunderlich.de,163.com,gmail.com,lzu.edu.cn,neomailbox.ch,unstable.cc,davemloft.net,kernel.org,lunn.ch,lists.open-mesh.org,vger.kernel.org,narfation.org];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[narfation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

--nextPart1959533.CQOukoFCf9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 30 Apr 2026 09:40:34 +0200
Message-ID: <3609597.QJadu78ljV@ripper>
In-Reply-To: <1857579.VLH7GnMWUR@ripper>
MIME-Version: 1.0

On Thursday, 30 April 2026 09:38:05 CEST Sven Eckelmann wrote:
> Sasha Levin <sashal@kernel.org> picked it up for 5.15.y (on Sun, 19 Apr 2026 
> 21:13:58 -0400, MsgId 20260419195610.batman-adv-5.15@kernel.org). 
> Yes, it was not yet published or 5.15 - so maybe fell through the cracks.

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=queue/5.15&id=6fd37208adf6771125b59e1ae0452561024be4e2

Regards,
	Sven
--nextPart1959533.CQOukoFCf9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCafMHcgAKCRBND3cr0xT1
y7V/AP9BMH0S8bDU+veLaqdqd/7YjiL5klqj+wG7K6SUqPoNAQD/ZFycWLIHLcz3
YaivZtqG9mnJJkSDo399V/GNymYUZAk=
=lQ4+
-----END PGP SIGNATURE-----

--nextPart1959533.CQOukoFCf9--




