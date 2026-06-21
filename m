Return-Path: <stable+bounces-267554-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8rbeHxz9N2qQWwcAu9opvQ
	(envelope-from <stable+bounces-267554-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 17:02:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE366AB24C
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 17:02:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267554-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267554-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB1E530162B0
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 15:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBED36C5B3;
	Sun, 21 Jun 2026 15:02:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DBF1A681B;
	Sun, 21 Jun 2026 15:02:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782054167; cv=none; b=VLTiT9IQq2HTN8aBrGzIdUeA5KpvwIyt6YaLz9Vs9XDPg1FoOQPtQy9AmFO3adA/5DYG0LMr0KL6Op8eqfiEFhSa3jOdUM93ObZGOF3u3z4yHPBF7jDVc7BplQbSfciRxlZCBn99mrGkw/AXkY4CRCebNvm+4x6U1j5ROks3CrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782054167; c=relaxed/simple;
	bh=8N2LjD8Zi0JzSsimy/PTOMo66xc0ZQPjFDjo6+IiGi8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uo1uU/FKtncKnm26ajSUye7fzhm2X+2qWCs95yH11HARNYISY31JIX7xyFuxbEcUXQmOenGVUiqSIqf5Th0FY3ebJ9YVZ0wX+fwwRJhC2EGXVBP4QymvZWuCrxtsCucouoMSxkFS1wIjGbzBgCSAk7ZW3PCgQ9utVpMuRPhVVmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1wbJgy-003aIM-0V;
	Sun, 21 Jun 2026 15:02:36 +0000
Received: from ben by deadeye with local (Exim 4.99.3)
	(envelope-from <ben@decadent.org.uk>)
	id 1wbJgw-00000007GXD-2yyJ;
	Sun, 21 Jun 2026 17:02:34 +0200
Message-ID: <b0d5836032ce3135bfc473f6bff791306d086925.camel@decadent.org.uk>
Subject: Re: [PATCH 6.1 337/522] arm64/mm: Enable batched TLB flush in
 unmap_hotplug_range()
From: Ben Hutchings <ben@decadent.org.uk>
To: Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas
	 <catalin.marinas@arm.com>, "David Hildenbrand (Arm)" <david@kernel.org>, 
 Ryan Roberts <ryan.roberts@arm.com>
Cc: patches@lists.linux.dev, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sasha
 Levin	 <sashal@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, stable	 <stable@vger.kernel.org>
Date: Sun, 21 Jun 2026 17:02:27 +0200
In-Reply-To: <20260616145141.584613180@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
	 <20260616145141.584613180@linuxfoundation.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-y3J05c+vgPYhtoDB2K3t"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267554-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anshuman.khandual@arm.com,m:catalin.marinas@arm.com,m:david@kernel.org,m:ryan.roberts@arm.com,m:patches@lists.linux.dev,m:will@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:sashal@kernel.org,m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DMARC_NA(0.00)[decadent.org.uk];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,decadent.org.uk:mid,decadent.org.uk:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DDE366AB24C


--=-y3J05c+vgPYhtoDB2K3t
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-06-16 at 20:28 +0530, Greg Kroah-Hartman wrote:
> 6.1-stable review patch.  If anyone has any objections, please let me kno=
w.
>=20
> ------------------
>=20
> From: Anshuman Khandual <anshuman.khandual@arm.com>
>=20
> [ Upstream commit 48478b9f791376b4b89018d7afdfd06865498f65 ]
[...]
> @@ -949,15 +953,14 @@ static void unmap_hotplug_pmd_range(pud_
>  		WARN_ON(!pmd_present(pmd));
>  		if (pmd_sect(pmd)) {
>  			pmd_clear(pmdp);
> -
> -			/*
> -			 * One TLBI should be sufficient here as the PMD_SIZE
> -			 * range is mapped with a single block entry.
> -			 */
> -			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> -			if (free_mapped)
> +			if (free_mapped) {
> +				/* CONT blocks are not supported in the vmemmap */
> +				WARN_ON(pmd_cont(pmd));
> +				flush_tlb_kernel_range(addr, addr + PMD_SIZE);

It wasn't clear to me from the commit message why this now adds PMD_SIZE
rather than PAGE_SIZE.  It seems like this change is fine for Linux
6.13+ with a CPU that supports TLB range flushing, but otherwise results
in unnecessarily executing multiple TLB invalidations at intervals of
the base page size.

>  				free_hotplug_page_range(pmd_page(pmd),
>  							PMD_SIZE, altmap);
> +			}
> +			/* unmap_hotplug_range() flushes TLB for !free_mapped */
>  			continue;
>  		}
>  		WARN_ON(!pmd_table(pmd));
> @@ -982,15 +985,12 @@ static void unmap_hotplug_pud_range(p4d_
>  		WARN_ON(!pud_present(pud));
>  		if (pud_sect(pud)) {
>  			pud_clear(pudp);
> -
> -			/*
> -			 * One TLBI should be sufficient here as the PUD_SIZE
> -			 * range is mapped with a single block entry.
> -			 */
> -			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> -			if (free_mapped)
> +			if (free_mapped) {
> +				flush_tlb_kernel_range(addr, addr + PUD_SIZE);
[...]

Similarly here, but this is effectively flush_tlb_all() instead.

Ben.

--=20
Ben Hutchings
No political challenge can be met by shopping. - George Monbiot

--=-y3J05c+vgPYhtoDB2K3t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmo3/QMACgkQ57/I7JWG
EQnOORAAwi0dEpNPAe2/DhmuUrnEJymCCPR62cFYxp4C5G1M4TDy1TVbrr9sJXTB
VJKQ3SW44b1t7f36h3pnCqcA3ceDfjFkPr6Mca9OabfxerxX0LGe7SCAFlMCAhqC
nkM1iRJ6x2jzkCExZe2A+V3fIElM/QNzQaviy0g4t479/RLbRWtZCSGD1+1L+G//
BC9HvehneiyHmf/FbxmCyvceniexwRUnXRXWf7HVxn6JNCWgS0Y4qTVT1mYgqXej
GUuFtZPei0MuiOz/hJEVsJ/P8mFwsb6XWaVr5B1NyFLDdIMDpKuZWBgxaohCOMrt
xcj8GVCBCtvwA7wpz9yeI+0aCTkQuSwbvdgOm40lP/hwuA742FiIarsKBrCNbIfN
U+yFWOM8qmz/qPbaLslTENXUVMIt+2NBGugrLm0aeyNHvmMlyukO5RJagU7NIYyK
Iz8UVpNAxB7CbcBV9VHWl1MC1aHf3innDFmkDL6y+VPJ03SfE1cFONF1nL0IEwSg
UT+6TWIW+863nkHc2eTQ4KEhjFFmcbM2RkgdFP/A8LeYhxMqSFhyjESymGIsS+ox
LoR/xhRfXddxOiPVIQtFBBEH7C58OrDU5dWJl5zmYHf3khc342CcolzS4/21Ua/J
mWvMGYveWNU4fe/MPeU289MyTsroe0c2P+ysyEcKtB+3yIjPWQQ=
=lNMR
-----END PGP SIGNATURE-----

--=-y3J05c+vgPYhtoDB2K3t--

