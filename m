Return-Path: <stable+bounces-269483-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7ohzIfKkQGq1gwkAu9opvQ
	(envelope-from <stable+bounces-269483-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 06:37:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2716D329A
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 06:37:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=narfation.org header.s=20121 header.b=TZwE37pO;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269483-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-269483-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=narfation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2E8530128EE
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 04:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE3424A07C;
	Sun, 28 Jun 2026 04:37:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D312C40D569
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 04:37:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782621424; cv=none; b=gJu7zd7OoDJxCV4GkhNDnlo0PcRR5I1b/r4v4hCyDtCi0D1Hs7L5MCl+HYdhVkiDEskGnQtZG58VjHdUrWqOYV6QH5i1/tOuea9aLeSkAoEWno9qeQVf3S+5EGMIu8a6ehp+dgOr61FzoUUEpIuvVy5yzwONRxLc7ke22E9Ygsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782621424; c=relaxed/simple;
	bh=osiFwRs5hcozOwGIwTB9Ue6kC2NoziHe8ozeoRvPrm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VwrR0XDrRlDeXBKF8vkZ84FF8jdu4WA+MWFrS/Ts2cAL0qEONTxhSUQASpZuc8zo049EQVs5CO26oLtCYtJnZLsUOZa+xMkeqP+RU0ZhcFbHgOmHC6ceDlkVyHt8rTnqutRygI72PI43fuw4c885hq7x5jQsEjL0OPPtx06G8gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=TZwE37pO; arc=none smtp.client-ip=213.160.73.56
Received: by dvalin.narfation.org (Postfix) id 664F41FEF7;
	Sun, 28 Jun 2026 04:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782621414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UO1X4md2YCOfX2DvdPc01Q2k2MNAJvagKZJHgX02ViU=;
	b=TZwE37pOfKZN0vW1pWgf25EOHiLAy/78FcGCr6LEa2udanaPsVsIV+zDYuj32C+QsVJODt
	OBnZLS43OH460qVpg3Nt7ih+9uUfLeE1pACEnVkwhAR9/BhChKFl4wDxF4zqRCB3Zp08Z8
	8g5vfExgDUUP2Ipw4Q8aK2Gf9mFQVXY=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 7.1 00/26] batman-adv: 7.2 merge window fixes backports
Date: Sun, 28 Jun 2026 06:36:44 +0200
Message-ID: <2075326.PYKUYFuaPT@sven-l14>
In-Reply-To: <20260628032401.0002-1-sashal@kernel.org>
References:
 <20260626161241.124988-1-sven@narfation.org>
 <20260628032401.0002-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart23186641.EfDdHjke4D";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269483-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sven@narfation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[narfation.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC2716D329A

--nextPart23186641.EfDdHjke4D
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>
Date: Sun, 28 Jun 2026 06:36:44 +0200
Message-ID: <2075326.PYKUYFuaPT@sven-l14>
In-Reply-To: <20260628032401.0002-1-sashal@kernel.org>
MIME-Version: 1.0

On Sunday, 28 June 2026 05:33:32 CEST Sasha Levin wrote:
> I just fixed up the backport on patch 10 (and for all other trees).
> 

You are awesome. Thank you.

Regards,
	Sven
--nextPart23186641.EfDdHjke4D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCakCk3AAKCRBND3cr0xT1
y96wAQDAEjrN9ENEElWqq47N6Z71hpaE6XObBcvviW4Nl8bKKgD/ZSJrJEtZkeio
HJzgJ+mo6tdcco2VzGIT/+0/A8r5Rwc=
=olgh
-----END PGP SIGNATURE-----

--nextPart23186641.EfDdHjke4D--




