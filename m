Return-Path: <stable+bounces-254974-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NiWKqI9GGo1hggAu9opvQ
	(envelope-from <stable+bounces-254974-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 15:05:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 258E25F270A
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 15:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FF6031326D7
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A083E7BDD;
	Thu, 28 May 2026 12:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="jmgykTg6"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597452857EA
	for <stable@vger.kernel.org>; Thu, 28 May 2026 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973187; cv=none; b=igw5kWbgAnTvGmH2l+FsGvqSIj1lE/GKLg1wN5Jwu56RBhujf24nVJrSP2fqIFR9yUrlMr1sQL69v85MKduu+QQnCRUz9n48xZyCAN0s9iBpG0LsWwQo8/0M21BfThtIDkATrtOmfw8MfMcUZCqD98LdSNdJhlkgAUcZdEeNS2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973187; c=relaxed/simple;
	bh=5tdUIO4bVN/aO7ozR90gMsk/HwpfxnussoyDmXuN6rY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GdksK/GQPEceUvtN9Fwc9MKSDOXTbUjyLJbHq+CWYuywvWfXhCKsCCWEPUa1QarIOQYYGpKNQcg8CWdrRF6W+oaCJkMZfUzpUrYLsdNSzRS5NWvNyLYKLhbMSOVHwL+Zu9b/ci+rjTyjI/psYvgNBwcJCz5Qq9YX3n4hUw0kBCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=jmgykTg6; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=GZL9A56e3VhIXJ8F1KVYwrDN9js+/h7TtY7qbazyAEc=; b=jmgykTg6P1nDPoB9ZzHTW6OpuA
	5YKqxD84N65Hja4HuFAcoAjCvPZw7Ou9bXEOhan/EY3pWhUuKR3CXlHIDBEP2NRJsPjACFQXlALDI
	ycsvSuHlaLIhKPSG9P6hAHXIVoElF0eykcJpd8eqpZA08z4meEfCSD9zGDf6Ng/XSLKOZnNCaOGm2
	UgyzSYHus2g2mQpUXnLP0tyZ+5Tyt9c67TcGuhP4vbRuyVlsXudsSnu2fDuFWrueA3xWirI2DpkIU
	+aA2R7yY0XyFd/53kqYZo4opNTuXxzwNccZsTr9prdZZjaHz3GczHGHTtv8fubgJ7V59EFsJ+M3ER
	EMetdrlg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wSaKr-0043W9-2M;
	Thu, 28 May 2026 12:59:41 +0000
Date: Thu, 28 May 2026 14:59:37 +0200
From: Ben Hutchings <benh@debian.org>
To: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Fourier <fourier.thomas@gmail.com>, Helge Deller <deller@gmx.de>,
	stable@vger.kernel.org
Subject: [PATCH 5.10-6.1] fbdev: vt8500lcdfb: Fix dma_free_coherent()
 cpu_addr parameter
Message-ID: <ahg8Ocvb3UFV6Vdl@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Pe+gqi40JelH7Xcg"
Content-Disposition: inline
X-Debian-User: benh
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254974-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,gmx.de,vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benh@debian.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 258E25F270A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--Pe+gqi40JelH7Xcg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Before commit 63a11adaceb8 "fbdev/vt8500lcdfb: Initialize fb_ops with
fbdev macros", the virtual address of the screen buffer was stored in
the fb_info::screen_base field and not fb_info::screen_buffer.  The
backport of commit 88b3b9924337 ("fbdev: vt8500lcdfb: fix missing
dma_free_coherent()") did not take that into account.

Change the cpu_addr parameter to dma_free_coherent() accordingly.

Fixes: 778f31be5b8c ("fbdev: vt8500lcdfb: fix missing dma_free_coherent()")
Fixes: 9a9bc60ed372 ("fbdev: vt8500lcdfb: fix missing dma_free_coherent()")
Fixes: 778f31be5b8c ("fbdev: vt8500lcdfb: fix missing dma_free_coherent()")
Signed-off-by: Ben Hutchings <benh@debian.org>
---
 drivers/video/fbdev/vt8500lcdfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/vt8500lcdfb.c b/drivers/video/fbdev/vt8500lcdfb.c
index ccd316aac467..1608d21a51ae 100644
--- a/drivers/video/fbdev/vt8500lcdfb.c
+++ b/drivers/video/fbdev/vt8500lcdfb.c
@@ -434,7 +434,7 @@ static int vt8500lcd_probe(struct platform_device *pdev)
 			  fbi->palette_cpu, fbi->palette_phys);
 failed_free_mem_virt:
 	dma_free_coherent(&pdev->dev, fbi->fb.fix.smem_len,
-			  fbi->fb.screen_buffer, fbi->fb.fix.smem_start);
+			  fbi->fb.screen_base, fbi->fb.fix.smem_start);
 failed_free_io:
 	iounmap(fbi->regbase);
 failed_free_res:

--Pe+gqi40JelH7Xcg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoYPC4ACgkQ57/I7JWG
EQml8g//SVDUBPOqhjdCrxihTFziydLcobTh5Uo8do8wwBx4+h52rTCCS9PgswCH
rpjp60vdesqFbETCLmCxkxuPuBqjLGTK+YRN24IpMMirZBJcLNsn7XRBcP5olq89
Z/uff5WAAlBTnJyroDVqwIK9wNORmAF3g8wNqS8ZZhcmyW6MS2mwo975zWLHO4E9
PJAPZXMtvBqfz9ilwJLLHbf2siZcaNBeGZId4Iqsrbhh1KMSZYAnZ/9l7/6SbxLr
ibjgiLRStlf4P2PvO54WiMSjAeUxAsGJHGLm32LkRF7ZkRnR5EblbDX6hdXzEZtQ
76e5t1do+eyK79Y5OGXTM7uNbB4K9NZrcIyF9nZW8LK+w05eARHAOBPV8ERdieDD
GsefwXrQ+WfK6ein07n42mVUHyprIQbcMl9ElXaJJ9M+Tf+9AL6D4PKZbWpZxgEo
hHtU+9zYutwbwJcF8JuJvNS92bqLT3/gnaJz13W0fXbMY9cpkTIRV35JPmWq3Esu
XABiwETML7YgIMZWDg66a4t6uXaUKgoGZPJCYj8QOWRotMXwOmERufRo6pAwYRjH
LT7EcHTbRytlKc8aR5BuB+tt/DKcOMzd9B2qrR36sJVTSI3k/sfjSyOK8dE2Ap7b
wqaVztf+0rgvPNjCDDYzmvfU2lx+CaKnANSxUHyZEHIgGeNBUyQ=
=QTVe
-----END PGP SIGNATURE-----

--Pe+gqi40JelH7Xcg--

