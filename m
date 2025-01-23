Return-Path: <stable+bounces-110260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0BEA1A1F9
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 11:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83AB43A596E
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 10:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5445820DD7F;
	Thu, 23 Jan 2025 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=engineer.com header.i=rajanikantha@engineer.com header.b="BjXQn/QW"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.com (mout.gmx.com [74.208.4.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF6520127F
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737628590; cv=none; b=WPOPtJX4feQ1U8+tWpJc4ev3PuDGqGxnsMjnLJ+mTmpfjGLFsxG9ztdVJoHZlVvdx+0YeA7WsympDV+TM3F4TcbNdbrZAMXX1WOX2ZG7jtAh+Tvhfr6Vryoi9ftxvLcEMwZxjNRKsCURCTYk7lvUHlQyrTulIqbBWPGgjwZVO6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737628590; c=relaxed/simple;
	bh=Abv5riCBXDQ+2hxBSuIaWJhAJzTtf+PEGR+aTkYbU40=;
	h=MIME-Version:Message-ID:From:To:Subject:Content-Type:Date; b=FARXCi6wNLdJCHaUWjNMalCCuwsEC0rqpsAnDe+ed/BoJeDZtboVaBnxaf/msbIm2T4QX0m73vJC85ekgRSxYx7eWvwSjl5Acm4BCf5TqyisxtkJ//shVVT5g3gNaNnCxBCUWNLJIzRvLr1IRH9jrbIPmluvuvyDBdubrqVwqGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=engineer.com; spf=pass smtp.mailfrom=engineer.com; dkim=pass (2048-bit key) header.d=engineer.com header.i=rajanikantha@engineer.com header.b=BjXQn/QW; arc=none smtp.client-ip=74.208.4.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=engineer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engineer.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=engineer.com;
	s=s1089575; t=1737628585; x=1738233385;
	i=rajanikantha@engineer.com;
	bh=N279YiE5B+4E7dxpmwXqqvU+/L9bQHryW+p7uBaw7nQ=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Subject:
	 Content-Type:Date:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BjXQn/QWuHoEeshYcG9uIvOivkPxFnM10PCoNhrfeqbhWaHW1PrQOTDZlFREioJJ
	 rYesX5mGM/v78lRNtdsqrq5Ca2ZHHm4UVHOv8n6ZnPpnfrZ8yeE+t3v0gAHTxpbGP
	 d6VmQS7N2N6hfZVzBHjxK6IC3R46JzYYZfTJneR4Q0mDaKGG+QaLNgLjfS915e5qS
	 a3KYvPaJOHu7zpFG1wK5mxYwqSIcG1vjMEewyCkH7gul4Tx1wxPvDabZE4NsYAGkY
	 R9sd4CQ3By5EsG0NOIAFVyJ9V0KGk85hBGEXCyHeO34E6Z5u6Md7A4Jfo0KMIvDRQ
	 qL8eYNK6AdQU/oJstg==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [60.247.85.88] ([60.247.85.88]) by web-mail.mail.com
 (3c-app-mailcom-lxa14.server.lan [10.76.45.15]) (via HTTP); Thu, 23 Jan
 2025 11:36:25 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-76d708b6-92f6-48ff-8fae-1a9f3d4cc38e-1737628584932@3c-app-mailcom-lxa14>
From: Rajani kantha <rajanikantha@engineer.com>
To: adobriyan@gmail.com, axboe@kernel.dk, stable@vger.kernel.org
Subject: [PATCH 6.6.y] block: fix integer overflow in BLKSECDISCARD
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jan 2025 11:36:25 +0100
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:I0iOMlpR+HMpbzn9HKhw6/r44TwI4hlLdY39wrRMgM+jRZKP5LWK7MNHc4QuroC0LlXJ7
 1BfARQk2UxFx8ft92t/04868WKIhvGs1zTyjBX5KssCcY5VsSA9r+LKYAgRMbX+ZgshNaZKcsFN8
 lKzTpql/px4wt3SBKfzKdpjVbTtQDkioeuyB23AOQYrr8/4Btiimkibgww27Rm9mLdciPMoDaooV
 6ksjiqE4zxTBauRdjkD4KG1GVzT21m0rRZHH9NsUTFGesHnosd4DF6LO897mHGiMjUVcqC1ghxkw
 XM=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:chVA3m40SCA=;YRgwRtHlzg2yUErzgzT9FwBWG36
 hwB7pVDboCS3TGYENCiPp0wT5Ajjq4ZwBRBOHeLrE/PtYOBtFvxxRUlgHXwg1r/G0A1V/HojR
 qfykCluvktVUwYk4TNMh+F1qEar15sM5GKB6sLxaWClVtZkFnyel8gZo1WkqTPBuIl0nLHvrq
 ir2sYldb675d+tUB8Zopd5chJsK33bpg2u0Fzu/8a2bbUq7F2oaIavTwJOlY0IAkWPKmYCLal
 FDjcB3o3Tj5/KnC4/BCt4uzQBWBfFvki/kcfp5h3QciModwEDNscmmrL2yh4BHsbbf73URiMH
 y85ByCMV/6UmXCGep1J7Bi36QfqaHdFSAhMxjBchxBZ71K5JEDkqLqvzJLI4U9qnEh/gPALsR
 SV795dnHHN4NrYnXtx/mOqykCBAMjGmnCUwl4xtwg4t3P9Kbjfwi1wWv2qyvTAPRD7V6o8E1T
 OerN/sTzHg/aHOXn1jNgPDCmmKOvWZQYBSk9Wc0HEmAmSCAH6qnfM3f78tw5QfNEh4UmFDJ+B
 jP2nD+suUGIIL2Gh7UF23x2hby/CLnd+xxD65X2xp/dN8DTLnM3r8DvcFGYeKnVoOFqG52QQi
 C6+xStVVPxtrzt1mMIieeY8B9Od8vgS4p6Jet3uZXGLasadm1wbjVFO/Y74GYfteoi27//S/E
 y3ocfiJfnLujcuRJA1ur0XrNaa0/3/GVJk/4LXy3EoVs5Drm8YeHtkIOzw+XfN85uH1FE1qbq
 u/U3foH2Gjic8VjR5gnysGh8yLqevwsRZMyOZYnODXvSDtSSsfoOvoiPonlNcGWgKLNITq7B0
 utkh7Yh9XB28vOU0wnZwY1eW0SC8C9SUa+SvUfqpVCVbzDAMmG+wu+I+KA+MpgiResFJosg+P
 UpTHfp5pDkSbDyKsREc8akLgUwjvQliCeBMfzPNSRrFR7aoD/qSDSkoC1mW3zvPm72UfLvP4I
 pF/62wzbbsQKnPFtjWYOSBpeXgTLKhXeePzzEeSNfTotNkeU7gpLe3heDasItmrVJkvCSmi99
 UnnUI5jBGJF0oLdoZBIH83NltBIZ/pV+mgf70Ze5pk1hWEnOUPPEq78Vy5X7VM7LA2Za1Rr4n
 5YRXfYtvFRg352/XHecbiHV5wcQIOVlyyre1QMet/2qlM30h7Y5cmIfbZ9jUlmIcXN1Ave3E0
 zGHhTVy/V+n0JtXOVpn8X
Content-Transfer-Encoding: quoted-printable

From: Alexey Dobriyan <adobriyan@gmail.com>

[ upstream commit 697ba0b6ec4ae04afb67d3911799b5e2043b4455 ]

I independently rediscovered

	commit 22d24a544b0d49bbcbd61c8c0eaf77d3c9297155
	block: fix overflow in blk_ioctl_discard()

but for secure erase.

Same problem:

	uint64_t r[2] =3D {512, 18446744073709551104ULL};
	ioctl(fd, BLKSECDISCARD, r);

will enter near infinite loop inside blkdev_issue_secure_erase():

	a.out: attempt to access beyond end of device
	loop0: rw=3D5, sector=3D3399043073, nr_sectors =3D 1024 limit=3D2048
	bio_check_eod: 3286214 callbacks suppressed

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Link: https://lore.kernel.org/r/9e64057f-650a-46d1-b9f7-34af391536ef@p183
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Rajani Kantha <rajanikantha@engineer.com>
=2D--
 block/ioctl.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 378603334284..231537f79a8c 100644
=2D-- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -115,7 +115,7 @@ static int blk_ioctl_discard(struct block_device *bdev=
, blk_mode_t mode,
 		return -EINVAL;

 	filemap_invalidate_lock(inode->i_mapping);
-	err =3D truncate_bdev_range(bdev, mode, start, start + len - 1);
+	err =3D truncate_bdev_range(bdev, mode, start, end - 1);
 	if (err)
 		goto fail;
 	err =3D blkdev_issue_discard(bdev, start >> 9, len >> 9, GFP_KERNEL);
@@ -127,7 +127,7 @@ static int blk_ioctl_discard(struct block_device *bdev=
, blk_mode_t mode,
 static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t m=
ode,
 		void __user *argp)
 {
-	uint64_t start, len;
+	uint64_t start, len, end;
 	uint64_t range[2];
 	int err;

@@ -142,11 +142,12 @@ static int blk_ioctl_secure_erase(struct block_devic=
e *bdev, blk_mode_t mode,
 	len =3D range[1];
 	if ((start & 511) || (len & 511))
 		return -EINVAL;
-	if (start + len > bdev_nr_bytes(bdev))
+	if (check_add_overflow(start, len, &end) ||
+	    end > bdev_nr_bytes(bdev))
 		return -EINVAL;

 	filemap_invalidate_lock(bdev->bd_inode->i_mapping);
-	err =3D truncate_bdev_range(bdev, mode, start, start + len - 1);
+	err =3D truncate_bdev_range(bdev, mode, start, end - 1);
 	if (!err)
 		err =3D blkdev_issue_secure_erase(bdev, start >> 9, len >> 9,
 						GFP_KERNEL);
=2D-
2.35.3

