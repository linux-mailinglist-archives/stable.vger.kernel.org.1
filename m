Return-Path: <stable+bounces-270347-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZbfRDssIRmpsIAsAu9opvQ
	(envelope-from <stable+bounces-270347-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 08:44:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9436F3E0C
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 08:44:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SGK3+0O3;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270347-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-270347-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 434F9301BBB0
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 06:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26CF385503;
	Thu,  2 Jul 2026 06:44:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFD73168E6
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 06:44:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782974664; cv=none; b=qoRF30YofV6JD2T3HtkczZe3piBdbWY6EB3Y8QMttBMfNEcLGMnMHq+jbTuwX3fYuvix4xm5doeN8EZe+VMBWJJbomfUze6u8+xQMyFzcFJ9c5yIigPjGn2uilad7j3DNMIY8Pm5+EzKNs2e7oL3cFnlqWms3dDXfIVNaEAkveo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782974664; c=relaxed/simple;
	bh=mwsmqT/AXBfpTe26vQoiTiZAbFqjYNZcCxpXpSYlf3w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=CiaabikCjYXiNsbb/Bbcb4lP4b88BUIdA4leZE/zmkLlEHWgXgNQcaDaVpJKMhhyAWiCGgv0OJzZfkYnu32dhOhN5PyhR/AbxsHZU3l4nriHnxwZyTYr8+zxQW8IZV2VSbX/T92wsC0BoIxq90wmcdjPsd1456xVeMSXZshP3DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGK3+0O3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 284BC1F000E9;
	Thu,  2 Jul 2026 06:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782974663;
	bh=mwsmqT/AXBfpTe26vQoiTiZAbFqjYNZcCxpXpSYlf3w=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To;
	b=SGK3+0O32kZ9ZCbjfcsdg//0d8zmtKCISwu9Ycav+VS92nWSKfxIY68cwLNReXtjY
	 VmyyIkOzAwAWxxVv4aGnfltNm9j8p9eQ32AoznjWl6dBZL+snrs3mcY+TY2OF33mpg
	 f1tL1KcllNDkxXdQCihyCvKkcxBgjuT+ismE3g+2f1l0w8edzVBrlr8Iwkn513RZV8
	 tglYNo4YvHQfQDr6rvUulYp/CPQGEuq+LeLuAqpvgpsPidK2gpXdQOMG/6hs4Jc83k
	 lxpQ+FEFhBpFqsHXdWhMRR4I4MwJrrwOl+0gY8Wlpco6Wh5XmrllNub4VetZMSfb+a
	 7xzcT1Sz7Nwww==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=33f04db25c885812dee295812b696d3d5602097a9471dc1e72bcb39acfac;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 02 Jul 2026 08:44:19 +0200
Message-Id: <DJNVRMSG4C6K.34EGBE463IOCZ@kernel.org>
Subject: Re: [PATCH 6.6.y] mtd: spi-nor: macronix: Add post_sfdp fixups for
 Quad Input Page Program
Cc: <stable@vger.kernel.org>, <tudor.ambarus@linaro.org>,
 <pratyush@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
 <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
 <alvinzhou@mxic.com.tw>, "Cheng Ming Lin" <chengminglin@mxic.com.tw>
From: "Michael Walle" <mwalle@kernel.org>
To: "Cheng Ming Lin" <linchengming884@gmail.com>, "Sasha Levin"
 <sashal@kernel.org>
X-Mailer: aerc 0.20.0
References: <20260701023619.2730136-1-linchengming884@gmail.com>
 <stable-reply-mtd-macronix-66-20260701193800@kernel.org>
 <CAAyq3SY48RRSO1nN-uRH7HVnXbnvQ1_K823Lc_hRsCyVuf9L3g@mail.gmail.com>
In-Reply-To: <CAAyq3SY48RRSO1nN-uRH7HVnXbnvQ1_K823Lc_hRsCyVuf9L3g@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270347-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:tudor.ambarus@linaro.org,m:pratyush@kernel.org,m:miquel.raynal@bootlin.com,m:richard@nod.at,m:vigneshr@ti.com,m:linux-mtd@lists.infradead.org,m:alvinzhou@mxic.com.tw,m:chengminglin@mxic.com.tw,m:linchengming884@gmail.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mwalle@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mwalle@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB9436F3E0C

--33f04db25c885812dee295812b696d3d5602097a9471dc1e72bcb39acfac
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Jul 2, 2026 at 4:13 AM CEST, Cheng Ming Lin wrote:
> Hi Sasha,
>
> Sasha Levin <sashal@kernel.org> =E6=96=BC 2026=E5=B9=B47=E6=9C=882=E6=97=
=A5=E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=888:38=E5=AF=AB=E9=81=93=EF=BC=9A
>>
>> I can't take this series for 6.6.y: patch 2 adds flash_info entries
>> with a NULL .name, and 6.6's spi_nor_match_name() has no NULL guard
>> (only added upstream in ac5bfa968b60), so the legacy probe-by-name
>> path can oops at boot.
>
> Thank you for pointing this out and catching the potential issue.
>
> I have verified this, and you are absolutely right. The issue stems from
> the strcmp(name, manufacturers[i]->parts[j].name) evaluation within the
> legacy probe path. Since 6.6.y lacks the null guard, passing a NULL .name
> will result in a null pointer dereference in strcmp() and cause a kernel
> oops during boot.
>
> I will add the .name to the new flash entries and submit a v2 series.

No, please backport the needed patches. The reason is that the name
shouldn't become something an application relies on (it is also
exposed via sysfs).

For all people not too involved: we are dropping the name for new
flash additions, because it is almost always wrong, due to flash id
reuse among almost all flash vendors.

-michael

>
>>
>> Please send a v2 that either names the new entries or backports
>> ac5bfa968b60 first.
>>
>> The 6.12.y series is queued, thanks.
>>
>> --
>> Thanks,
>> Sasha
>
> Thanks,
> Cheng Ming Lin


--33f04db25c885812dee295812b696d3d5602097a9471dc1e72bcb39acfac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCakYIwxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gYTwGAqnInxCnEvyOPze83NecTmhd2K5gukKMt
P2Rqcev3TLZuX23WqfTXkSAtEmMXedFWAX9IKEqmtjTceQZNqFZaLiYAEzyM7zTQ
bgg9J2omXxaFR8jg0wt9/QfDdiUhVII4gUM=
=15ZK
-----END PGP SIGNATURE-----

--33f04db25c885812dee295812b696d3d5602097a9471dc1e72bcb39acfac--

