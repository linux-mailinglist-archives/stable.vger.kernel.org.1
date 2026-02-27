Return-Path: <stable+bounces-219970-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GIMDx6uoWk3vgQAu9opvQ
	(envelope-from <stable+bounces-219970-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 15:45:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AACDD1B92BA
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 15:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10261304604A
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 14:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E6B41C319;
	Fri, 27 Feb 2026 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b="vaw4sYdb";
	dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b="FQTUeIUB"
X-Original-To: stable@vger.kernel.org
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33EE3D6661;
	Fri, 27 Feb 2026 14:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=72.84.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772203488; cv=fail; b=bJHKYTbRHZELfVZTdgyaVj6aodc/ivZ9t9Q5te46v5LcvaS4APDmNIaJFMH7KCvW8nvBJEqSHepeQfSZCvRP2KMFLemiLWCNjsrxf+hF3qW/mSZNK5FMffch+rlOpCxcu5eWfFM5BzqtKwbKqAIQ0pDV5D6kBv3c/0FW+U1FHo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772203488; c=relaxed/simple;
	bh=o0fJaKyRxHRma1FyAU9wqpEMKaRiVeWDImTXycSrK/k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UdGytRBCza1uXtUHFaviVEJZV57rQN44kwj8Pkg7O0B0sKMo9AynpqfFNj4DploLIUvvlHyqQkVe2j2CYILRZXNYxdH9cuomod1x7XwTEVUcsW6U8s3GCysP9fAsZdP/1AHEOpOletBVbaVDr4qGNnEs7Z99A7Q48OBUu7NpADM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com; spf=pass smtp.mailfrom=sapience.com; dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b=vaw4sYdb; dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b=FQTUeIUB; arc=fail smtp.client-ip=72.84.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sapience.com
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from smtp.sapience.com (srv8.prv.sapience.com [10.164.28.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by s1.sapience.com (Postfix) with ESMTPS id 971CC480AF2;
	Fri, 27 Feb 2026 09:44:45 -0500 (EST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1772203485;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=RXQbX6XpDIE83VkupJOOYx1SKRIR0PucOqvjxBZxePA=;
 b=vaw4sYdbks0InqHFI7CBfpeSZdclJWSAepbNFg1LE4SPtTIXVtyOVuIRRArU2GhnGWAlc
 t1vOHl/opQIHWfyBw==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1772203485;
	cv=none; b=q3nCr9o7XPugMwzYBqfaFnA1xBXJW0CW4OKaOc1QM9gxKYeXPfLbPahXNEWd+iZ24HJsaV30dqdOixmTfXeEe3zYHmffqsgXvUR211RIXRbT9g98e18wNfyQ85yLIcl7rdoaUtizfq/9L/QC71q1TTWEbxDBUmvgJcbxYK5H4pA8jlX5ucj6ryVtYNSiHIphJB47hm7cM6rHUSEXqZGrxRpSwZzQ4WXVfZBBao3kcx00mliw67TAR4ZcTNcju9i9eaZU+KuIb/q/Jy1JJ+l3omYDr9YPaLNwTu0E4uPW2NRHCIgohSUaT8vt5k7Jsh11eh3vzW76xmSeU4eAXXkkAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
	t=1772203485; c=relaxed/simple;
	bh=o0fJaKyRxHRma1FyAU9wqpEMKaRiVeWDImTXycSrK/k=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:User-Agent:
	 MIME-Version; b=WllU93rn/HR1hMe3UJAqzqgA4Jw4S7aPvyefieVY97a6kk/b5W3iOWbtDWTID26IY6nMs746GQpExdZC8QOiIYuy2voQDjxGoSfJmzp0y+RmkNfKdb0SxKbhQU3FPR8BmrWJyfb/z+T2IalpGlZmadCV50Lkdw33/NthektcSpaRoRGtbQtF2axfs4sPgqdPDAItJgFx8glwfsbs/sQOh/1KBnpRcr8U2gxAN3yDFbz8GBJK4KIw2rerdH0qo8SvF3GTMMGSmJcoWNkF77wN5MKKgKOOgIn9F9lr+y6Alk6IhsDWeD6cc4qjJ8EFFi1HRyjyML4x+gryG9oO+cIAIA==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1772203485;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=RXQbX6XpDIE83VkupJOOYx1SKRIR0PucOqvjxBZxePA=;
 b=FQTUeIUBMnzBPv/XR87PHoysFDYB/UEbAqv86ooImMkWPhbHY7Vkc/tHgYk3bJcM0ujiM
 qAgBmRzgxPkU3x3N3PNqjSiafVD1QI0NLoGeV36mtRqLtvwGSV/vfkER1VOnFprbwOUmCD5
 9zDpoHPaW5DDLqEFueJdAU5y67tZNvKTvgGvCV3raURIP6UoE8kVOaxbbBm879nh8ah1n6Z
 9GGvCmRHHtGMRxQ2vv2+QsPoYFVYWUaIzDALc6OYjEVrvogEUKY2sFKeiyEdUatOOefSvuW
 3zjgKFXnHT4UG9u7FGYiNQUT6zddv2dWEN0GjVPB4bgG/v1le//0goxSMQ2g==
Received: by smtp.sapience.com (Postfix) id 512A2280010;
	Fri, 27 Feb 2026 09:44:45 -0500 (EST)
Message-ID: <afe24af8ae3913f8988dc551629e8f598313a29d.camel@sapience.com>
Subject: Re: Linux 6.19.4 - Oops, regression
From: Genes Lists <lists@sapience.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>, 
	akpm@linux-foundation.org, jslaby@suse.cz, linux-kernel@vger.kernel.org, 
	lwn@lwn.net, stable@vger.kernel.org, torvalds@linux-foundation.org
Date: Fri, 27 Feb 2026 09:44:45 -0500
In-Reply-To: <95fea1bd0ded180bb79285ec8416053c614150f8.camel@sapience.com>
References: <2026022657-clambake-mountable-8175@gregkh>
		 <eb2d1da9-0b4b-4887-83a4-0e2a65e703aa@moonlit-rail.com>
		 <2026022612-buckskin-surfacing-d854@gregkh>
		 <bb9ab61c-3bed-4c3d-baf0-0bce4e142292@moonlit-rail.com>
		 <67d9f732a55a31f3073675164e8d7ada46da3dbe.camel@sapience.com>
		 <0a77c13e74493b786c5fe4e1ebdf55b14e5ff496.camel@sapience.com>
		 <2026022750-everyone-huff-8fd0@gregkh>
	 <95fea1bd0ded180bb79285ec8416053c614150f8.camel@sapience.com>
Autocrypt: addr=lists@sapience.com; prefer-encrypt=mutual;
 keydata=mDMEXSY9GRYJKwYBBAHaRw8BAQdAwzFfmp+m0ldl2vgmbtPC/XN7/k5vscpADq3BmRy5R
 7y0LU1haWwgTGlzdHMgKEwwIDIwMTkwNzEwKSA8bGlzdHNAc2FwaWVuY2UuY29tPoiWBBMWCAA+Ah
 sBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEE5YMoUxcbEgQOvOMKc+dlCv6PxQAFAmPJfooFCRl
 vRHEACgkQc+dlCv6PxQAc/wEA/Dbmg91DOGXll0OW1GKaZQGQDl7fHibMOKRGC6X/emoA+wQR5FIz
 BnV/PrXbao8LS/h0tSkeXgPsYxrzvfZInIAC
Content-Type: multipart/signed; micalg="pgp-sha384";
	protocol="application/pgp-signature"; boundary="=-4zevJptcHPvR1jBhIBQG"
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[sapience.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[sapience.com:s=dk-ed25519-220413,sapience.com:s=dk-rsa-220413];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219970-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[sapience.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lists@sapience.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sapience.com:mid,sapience.com:dkim]
X-Rspamd-Queue-Id: AACDD1B92BA
X-Rspamd-Action: no action


--=-4zevJptcHPvR1jBhIBQG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-02-27 at 08:59 -0500, Genes Lists wrote:
> On Fri, 2026-02-27 at 08:32 -0500, Greg KH wrote:
> > On Fri, Feb 27, 2026 at 08:18:52AM -0500, Genes Lists wrote:
> > > On Fri, 2026-02-27 at 07:09 -0500, Genes Lists wrote:
> > > > On Fri, 2026-02-27 at 01:26 -0500, Kris Karas (Bug Reporting)
> > > > w...
...
>=20
>=20
> Sorry if was not clear. =C2=A0Only 6.19.4 has kernel crash.=C2=A0
> The summary is:
> ...
> - 6.19.4 - crashes whenever nftables is invoked.
> =C2=A0 Does not matter which userspace nftables is used, older or newer
...
>=20
> I will report back soon as have finished testing 6.19.4 with commit
> f175b46d9134

I confirm that=C2=A0

   6.19.4 plus git cherry-pick=C2=A0f175b46d9134f708358b5404730c6dfa200fbf3=
c

works fine and resolves the crash in nf_tables_abort_release seen in
6.19.4.

gene






--=-4zevJptcHPvR1jBhIBQG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYJAB0WIQRByXNdQO2KDRJ2iXo5BdB0L6Ze2wUCaaGt3QAKCRA5BdB0L6Ze
2xOZAQCCfX2to4thgkot+NF+v6gnNOgl3p1GOeUDaCEouQAoPwD/Yi9DqUvu70o5
nKztYdRVuYCYwJTVieYPfrYhTwl8qAU=
=nb5T
-----END PGP SIGNATURE-----

--=-4zevJptcHPvR1jBhIBQG--

