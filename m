Return-Path: <stable+bounces-249389-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2H2fIyhoC2qnHAUAu9opvQ
	(envelope-from <stable+bounces-249389-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:27:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CE6572DEB
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DA8B3029616
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 19:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B129D38A716;
	Mon, 18 May 2026 19:27:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1668E30C15F
	for <stable@vger.kernel.org>; Mon, 18 May 2026 19:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779132447; cv=none; b=X2D1wMMtcoOV+Ng0iOJSaYlBctWsJ+N28uwaQxxfOcVmehJd6IWnjvbQtoTwwuFUayy3BZGRBTFOQ7klmzmWRk/oNSU704cBrj/bQtyNFMQEPpRn1rzZhllkTB5MsJIBs+68loqJylNc5DrIDXdzK733EHdJTSv10tA5HbeYg54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779132447; c=relaxed/simple;
	bh=YRihdkqnvxmS51AeFJSpM1nEEVHb4XlF/fcLdZbrTQA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f4bjl5/HewdFtgd+yHUqGldhpQ5LSR+vxfCY4HTkcrFZQIY8m1hTA2E4rU5Ku3LjtD+hks4pSMTpSvWV2WI7Z81DGta0owQbzmN//x2MQ9Meh9mEnUXS79EXtradLAzXlLGsQCAaqNEcUaP/Xyu3kcw7dcScOEk4Lwqs/Hga+yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (1.5.5.2.4.d.e.f.f.f.5.f.9.d.6.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a:6d9:f5ff:fed4:2551])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 6BD74342496;
	Mon, 18 May 2026 19:27:24 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: Sasha Levin <sashal@kernel.org>
Cc: gregkh@linuxfoundation.org,  brauner@kernel.org,
  patches@lists.linux.dev,  stable@vger.kernel.org,  kernel@gentoo.org,
  dist-kernel@gentoo.org
Subject: Re: [PATCH 6.18 160/188] papr-hvpipe: convert
 papr_hvpipe_dev_create_handle() to FD_PREPARE()
In-Reply-To: <20260518155236.reply-0002@kernel.org>
Organization: Gentoo
References: <87cxyuq6oa.fsf@gentoo.org> <20260518155236.reply-0002@kernel.org>
User-Agent: mu4e 1.14.1; emacs 31.0.60
Date: Mon, 18 May 2026 20:27:21 +0100
Message-ID: <87tss4bjs6.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Spamd-Result: default: False [-2.96 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gentoo.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249389-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam@gentoo.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 07CE6572DEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--=-=-=
Content-Type: text/plain

Sasha Levin <sashal@kernel.org> writes:

> On Sun, May 17, 2026, Sam James wrote:
>> FD_PREPARE doesn't exist in 6.18, it's from:
>>
>> commit 011703a9acd76edc7c85d80dbccb6e50dba53aad
>> Author:     Christian Brauner <brauner@kernel.org>
>>     file: add FD_{ADD,PREPARE}()
>
> Thanks Sam. Backporting the FD_PREPARE/fd_publish primitives to 6.18 is
> too invasive for stable, so I've reverted both papr-hvpipe commits from
> pending-6.18:
>
>   - 09c15bbbed533 ("papr-hvpipe: convert papr_hvpipe_dev_create_handle()
>     to FD_PREPARE()")
>   - 6542e180fa6e1 ("pseries/papr-hvpipe: Fix race with interrupt handler")
>
> The race fix can be reworked later without depending on FD_PREPARE if
> the maintainers want it in 6.18.

Thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEBBAEWCgCpFiEEJaa7iN2bdkxrVUHCc4QJ9SDfkZAFAmoLaBkbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25z
Lm9wZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXQyNUE2QkI4OEREOUI3NjRDNkI1NTQx
QzI3Mzg0MDlGNTIwREY5MTkwDxxzYW1AZ2VudG9vLm9yZwAKCRBzhAn1IN+RkOiU
AQCVt4yaakLOHZVqq9FFq/dZQw+qhME6JSVmSFD4e5pnKQD/Rm1gg1V670cYU22x
UpGYe2rrRpfzLuThfUtcdJy0YwQ=
=qL7m
-----END PGP SIGNATURE-----
--=-=-=--

