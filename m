Return-Path: <stable+bounces-110261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D27DBA1A1FB
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 11:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5BFE188DABF
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 10:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962EA20CCF2;
	Thu, 23 Jan 2025 10:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=engineer.com header.i=rajanikantha@engineer.com header.b="HICDZkPE"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.com (mout.gmx.com [74.208.4.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DF9186A
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 10:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737628704; cv=none; b=FmBsifD9ixKXopkLPd51p9oQxNcTLSRKA/4EbGUU0v3Tk7vBi7juQcHMpZbL0YRKMCWiyB+sqOXfPrc8+YpnVAl2gILFkarnFf/TA3LXEbnKJLAwykXxABoOj/7pPCMIgtl+li227SAfym3DIMkflP27b27i7saXakxe7++kgmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737628704; c=relaxed/simple;
	bh=3ipf2I6+q7vVkh4kdZLqO3xZG/fhKPe6+yDxxWQIbd8=;
	h=MIME-Version:Message-ID:From:To:Subject:Content-Type:Date; b=Y1F4g/Ca4rt5wyRw2BGG7AkABoIpdkrh/UVUa/b8gTeWTNr0QQKSASdZ9/IPus1jSaI6v6WWXwcvabZHJF3aNT0Utsiz12964JBn6EEFrQHAPDlL0ga4W3x2lzF9ZBSWsv9PajqrlE8iRfURbXoCzuUyNpS56Df/ChMZa+PWBog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=engineer.com; spf=pass smtp.mailfrom=engineer.com; dkim=pass (2048-bit key) header.d=engineer.com header.i=rajanikantha@engineer.com header.b=HICDZkPE; arc=none smtp.client-ip=74.208.4.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=engineer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engineer.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=engineer.com;
	s=s1089575; t=1737628700; x=1738233500;
	i=rajanikantha@engineer.com;
	bh=O3dZCfQwazlTbeivtbtm7DdyIYigUYkbozczPay4laI=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Subject:
	 Content-Type:Date:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HICDZkPEF3A1qVcAQfkjL6mQUI1EBdf54y8nb8M/yC0Zlqknsho6FjB2mxUwVNeV
	 RNI4Edr1uRsTSW/VnZsF9ImE1ln22q28n6hB6KdUv+TMwmSmJZ751Mah0j6ebe7kK
	 LeUqATxCtcT6wy9Mf3sDyfCq1+Fr5U5/4sbkrE3LHEuGISVcnua1HFZLlDej66IX1
	 +nCA0o0LF3QUVtk9sGoWMwrVkzFsxforBhPQExWFtl5oXT1RVT0rNKqFDehkxK9Pk
	 fXGm3GpEbbR8A6hyrAFZm8pcl9K+8wA4qkZNn8VPF47pa+mNO1i9VHfn+xUz559ow
	 RmlRuqXlskqyhdXkmA==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [60.247.85.88] ([60.247.85.88]) by web-mail.mail.com
 (3c-app-mailcom-lxa14.server.lan [10.76.45.15]) (via HTTP); Thu, 23 Jan
 2025 11:38:20 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-37824966-97c2-4650-948d-30bef36f6b04-1737628700210@3c-app-mailcom-lxa14>
From: Rajani kantha <rajanikantha@engineer.com>
To: adobriyan@gmail.com, axboe@kernel.dk, stable@vger.kernel.org
Subject: [PATCH 6.1.y] block: fix integer overflow in BLKSECDISCARD
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jan 2025 11:38:20 +0100
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:xXaiBphRsDS8Dv65/qxwLBMw9dGiUm5gf4hNWu8/1UUb98h38UxT9HosxGSygRhNdGRaL
 P2h9CbEgRtAu1ba9uNNUN9yfkaQ4M/GvLzix+ytm94khMmRKDNgNSgKOXHzi25eMDTnBO8MvYztK
 0Qy0UgrOf/zwDVnjRd+5DPUcMqYJY2+Or+aNXg+i8Hiz8w2RvT5tnDOzUTHNW92inaFxylHRuAUc
 2SxTCiwPOVolWd909tXkWfQZrKiKc2RQGi3bIfAKmBjjDqM2pWLz1DaWkLtJCvK3iTwLBU+YNfHy
 vY=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MYKB/EGyyrI=;6uq95ZQrty/gLLsO+CeNfv78CV0
 +FeNdblAFuGzkbP++N0U4/+rA1RZfn7lOBTDKiYh+v4Dx4QB2SGaGob1hVL/mXsugiJH4rdZH
 AThFz2IPNnUYNcNQ/Hpr8dRSZwCGL+vcWYioITMuOTOUbzjxinTwOy13Pjskl7bKPwhSHbr91
 H7LhLqksfrssS3aEfvGQqekQSwqgJgYLESgJcuRm3Tgub30DXO7TjM8a6aNzR/FtUk4E4d7NR
 8XrWwB2Vsbse2aHvVtN/cMwo8JVeb9as+84qUiz7ERKes+6RJYcSRnGkFgDPAYre7rdQYpgo/
 6as2MOP5fGaHR4YmoyU56paE37E3qIGW5h14gj+0RBJi7jFpYAMZx+xJ5DOp0GPIoZKw63s/Q
 g+wQdioW1xnCVmQHIoG0E06rRsc8WG7JyOc5DKsmwdeTDWecdyBAU17OXdOjsRax+pDL5dNJm
 HXVzRwolvKY3WTnuaJcZmXWWzVuz5s1NXCGNcBd9lafJfFf66t6O9FUamjy0ZNokmS6VqH2PI
 kzDu1bczDgTv8TGFlNoV43BntDSvmF7kyk/iN10tfycU6NLFu69qAbclgybLfwsRS3gxyBokw
 3WkNXCfxRbckA5xjSkQ51lUE/wTibAMgU2LXsELkX92NFQeEF0qgh0aM4ytstxPPXUFrMH8UV
 y6EywOcdPUokN52lUPglZCmC+G8Kk9CCjksEpOPO+WSh9VO6qGNFKgSDK+TDTO4D5ZSuo9ylp
 0zD5tk8kxg720pgcs+sWsZb1E19jS9HShkjnK/nxmphsniwaFL4lR22G0InXo0X2+722XBH6H
 jVaHn0xQ3vzZNmSQ28Gy7PvdW99J2ETSMgeQbXc5WtO9LCjEWQIZ/SIN8YRq2G9ZLR6TMcmVz
 6WGHF8bzbdQxbIJQ6N0wvrFW6u4XPRdzd4wZS8b/qpLZdr++sSAhfx1nG29BNZ5wKvK1Vs21J
 GuJ3/UTylfI27uvjcDcCNuooSlPjrwwtVNjx36DJ4U95JhwyMZX24tPsrtgYOpJqslFcn9jbe
 l3RuYC4h2V5jr8txRM=
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
index c7390d8c9fc7..552da0ccbec0 100644
=2D-- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -115,7 +115,7 @@ static int blk_ioctl_discard(struct block_device *bdev=
, fmode_t mode,
 		return -EINVAL;

 	filemap_invalidate_lock(inode->i_mapping);
-	err =3D truncate_bdev_range(bdev, mode, start, start + len - 1);
+	err =3D truncate_bdev_range(bdev, mode, start, end - 1);
 	if (err)
 		goto fail;
 	err =3D blkdev_issue_discard(bdev, start >> 9, len >> 9, GFP_KERNEL);
@@ -127,7 +127,7 @@ static int blk_ioctl_discard(struct block_device *bdev=
, fmode_t mode,
 static int blk_ioctl_secure_erase(struct block_device *bdev, fmode_t mode=
,
 		void __user *argp)
 {
-	uint64_t start, len;
+	uint64_t start, len, end;
 	uint64_t range[2];
 	int err;

@@ -142,11 +142,12 @@ static int blk_ioctl_secure_erase(struct block_devic=
e *bdev, fmode_t mode,
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

