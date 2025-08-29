Return-Path: <stable+bounces-176700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C143CB3BA12
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 13:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC4C5647D1
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 11:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA472257AEC;
	Fri, 29 Aug 2025 11:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=simplelogin.com header.i=@simplelogin.com header.b="e5mSuqV0"
X-Original-To: stable@vger.kernel.org
Received: from mail-200165.simplelogin.co (mail-200165.simplelogin.co [176.119.200.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC682D249A
	for <stable@vger.kernel.org>; Fri, 29 Aug 2025 11:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=176.119.200.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756467762; cv=pass; b=XqWHwpwBwROTSMEJUOMqk7EJCVl2pOcA8wqDYXYc+lFnfemAG4zTk5v0AXqyYdeDTu9U8J1nsPgHXVPcS175g/KL9tvHx9Hgb47HAO/Y+W3BVWV/7xGZww24bObRWYp7txc0NJbYl7fenZhaZDzBPjCzeFgzew50ujcMr2O9RjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756467762; c=relaxed/simple;
	bh=n5DoHCNywup6l9+BRLWy4SYpfOtSuxQUT+2Jlv4Y8nY=;
	h=Date:Subject:MIME-Version:Content-Type:From:To:Cc:Message-ID; b=qJzezHpVK1Xf/Ot9zFa8ouHnT/0Hmye0uu4dsYxsOAg8GzzEbCznUDNJ7IHUgHH+rX/m4XuVWWoir3CFlMSNuYX/U3cFfdH6/L66iARP1RfYc5mlw8soegdc5HlX0BkK7Eb6gL3mJacO9unXnGSkUF121Fm+nVh7GpcVB4pZt8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=simplelogin.com; spf=pass smtp.mailfrom=simplelogin.com; dkim=pass (1024-bit key) header.d=simplelogin.com header.i=@simplelogin.com header.b=e5mSuqV0; arc=pass smtp.client-ip=176.119.200.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=simplelogin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simplelogin.com
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1756467385;
	cv=none; b=emf9Vrsaq/6+zvA43TkSvXmejcWVChwJ8b0OYFOe4bjhedCV+6VkZYYvppnUM+eJuM1gTmjlHf8uYPkQ1sCpqd3FFJ2DViq4i/dfFvqJt5vLHNSYzwxrxRAayxkwRoeX5p1wMowD5JoVREeTwr+f7VF0H06BBaXNCns57Ag/Up8+89YoiFmFNkDM5VDmcYu8vshLJbCDKr5mbObri2Gs0CJJ0WB+1julaXn3JaxDN21pZGyDws6oGwmz9Sh9NSclBe7lGWeRCr5lXCbzl7Ayvmars7Kjp0/49UWVmP2x323VyKeFzgX1qMA7PNfjBQi5CJ/szUurrFfmXYIKkSejQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1756467385; c=relaxed/simple;
	bh=n5DoHCNywup6l9+BRLWy4SYpfOtSuxQUT+2Jlv4Y8nY=;
	h=Date:Subject:From:To:Cc; b=WHcQLzWVI/uC2IeDtTLjt1mzTMHaa860wogzCbCcQN2k9VOBdVG7J5Sqwi8mYEd8mpoKsZkAPGGjLUf48zvvH9j/x4+UtlUPo3yP8HC8uI2tvqoquRGqH2df88MOM5wubmxL9uiOB5VjELfBzRR52l20KsrxAtbeR/khdBs+GHedpxYWMoRvEBsyzu+P6xJ1zBg4305/Le5zdNITIWd8uxw7ZMYFU2/CskgpjL1WSbKnH0ts6zyZ3BdoZBsiq2yvwJvq5e1pZlNPuZ2a82AfBiRfQgiAA8/VMDTqrCKWyFpieMSAN+i9uIuLrArLgb/hW7j/SXw0Tkkiauf3eAhj2w==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simplelogin.com;
	s=dkim; t=1756467385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n5DoHCNywup6l9+BRLWy4SYpfOtSuxQUT+2Jlv4Y8nY=;
	b=e5mSuqV08ySpUz1i+5D0S+8mlpchjtmJzzUpP8dnnnmlcjuOheHlLeXSmOqL7G+vfIVBqZ
	A4QLu08Y87Ke5+Qsa98WtohyVs3Fdh7Zc1dqsPx+dC+gOqg1Eel+l4bcS/wq5PTOVQ4Lvi
	g/rGe77aFOKcSkV08CfTIwje0I72ODw=
Date: Fri, 29 Aug 2025 11:36:18 +0000
Subject: Re: Bug report - Sticky keys acting not sticky sometimes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha512;
 boundary="------a3bdc29b6e5aab888bbfaee2534b07ce6e38dc4f5969853691b6d737927ae055";
 charset=utf-8
Content-Transfer-Encoding: 7bit
From: Alerymin <alerdev.ca4x6@simplelogin.com>
To: stable@vger.kernel.org
Cc: 
 regressions@lists.linux.dev,dmitry.torokhov@gmail.com,linux-input@vger.kernel.org
Message-ID: <175646738541.6.2676742517164037652.877606794@simplelogin.com>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 877606800
X-SimpleLogin-Want-Signing: yes

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------a3bdc29b6e5aab888bbfaee2534b07ce6e38dc4f5969853691b6d737927ae055
Content-Type: multipart/mixed;boundary=---------------------2a429f09b9a235ef4171a0b772069893

-----------------------2a429f09b9a235ef4171a0b772069893
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Note:
The issue looks like it's from tty directly but I don't see who is the mai=
ntainer, so I email the closest I can get

Description:
In command line, sticky keys reset only when typing ASCII and ISO-8859-1 c=
haracters.
Tested with the QWERTY Lafayette layout: https://codeberg.org/Alerymin/kbd=
-qwerty-lafayette

Observed Behaviour:
When the layout is loaded in ISO-8859-15, most characters typed don't rese=
t the sticky key, unless it's basic ASCII characters or Unicode
When the layout is loaded in ISO-8859-1, the sticky key works fine.

Expected behaviour:
Sticky key working in ISO-8859-1 and ISO-8859-15

System used:
Arch Linux, kernel 6.16.3-arch1-1
-----------------------2a429f09b9a235ef4171a0b772069893--

--------a3bdc29b6e5aab888bbfaee2534b07ce6e38dc4f5969853691b6d737927ae055
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmixkKQJkOLfGQMiQb0dRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmfTkqPJNkGeCHWxoJzCDGaTeoq+AMlCzt0LqPcI
IlruHRYhBA/2MWvcJ0ye/0b56OLfGQMiQb0dAABIgAD+NuL4jcK/RKvUdskM
n6FkZTldQiUuCyUrX4G4YHVuyfoBALiduiZYfYIiL1itze8hd9zWWXnCF7HV
3bIzIlVhQQ8C
=BCRE
-----END PGP SIGNATURE-----


--------a3bdc29b6e5aab888bbfaee2534b07ce6e38dc4f5969853691b6d737927ae055--



