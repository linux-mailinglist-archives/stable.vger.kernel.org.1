Return-Path: <stable+bounces-241285-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIhzMLg172kD+QAAu9opvQ
	(envelope-from <stable+bounces-241285-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 12:08:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 676004709C1
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 12:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F40130F0D3C
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 10:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAA13B388A;
	Mon, 27 Apr 2026 10:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsUU2/uF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1813B2FC7
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777284059; cv=none; b=P5nzHm1k3rVMUT/yduaWvPN5/jNCiarmusb15PoxNKvJDq7QuGTo8DVfV1lG0rsAPO6ZGabPqNTqbw2+D2LrvlHGvMjT13WzoCqNIPyJoVHTfBfjSvr/GOmHiAAfgaZCao5XiSNoK82HWiYFJtA7qAXuT9vNUO/0A4XnZPF7geg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777284059; c=relaxed/simple;
	bh=ZI6ZwXlG1e5ACFzhDMQRxll59Q4E3kZhbdsX1UNQ54c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NH6wQsLFb2FbW9OQtN32N/6YHiLop0UET0x5XV0o3y9Vn+nl2dYO1coP+GU4ZP98EtZ4fT4XNPBAbot61tISwUF1lzxhI3s9xFMfGBereI7BAA3h2VodyUwvzg4aNFzxN7zgZROl0+zyYoxkXopc0Ci8sL339lNsHC5NmeO625M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsUU2/uF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b7adb38d65so37769195ad.2
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 03:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777284057; x=1777888857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0EvvvHNzTOaXmxdzFUeL0y2A0j/j9spluGpaFZP3FMU=;
        b=jsUU2/uFRkFRoLNuvuS1g6q/cHoD8Vg1diwcpBbr1fT7LDWeuZP4JiqYAJTVWPdnV6
         Touu6EEbVXqbIK85ZEJ+HVV5X+LFIXUWBQ0sZMz3bu0mqY4AFFT7ybihXQwL2wEYWBZE
         Vg0DnHvYGK7u4kA0cEgAfOw4Kx1V2l4s0twsd6vdzh/OccuvkUb7FJoeV6Ih33oqdBhQ
         X5JXXJmTJTFp/PZfz4Iaeq5Mv1iDQOx6QtDb/DLxXIP2sN7RXj8mOwckSJzWTU6XQOeW
         5yh7FNTcG295/Gg12fchFNrgRWY9T2FSTaEuTnw857S4VBku4u3PReYpRXVMRD+zxVrN
         fueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777284057; x=1777888857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EvvvHNzTOaXmxdzFUeL0y2A0j/j9spluGpaFZP3FMU=;
        b=s0g7oWP9G2cpI+3zXBS/N67LkR+2csr+gO6IQekjsGt1pDRXD6x5GnQtnnYgJ5OFB5
         gocThBAzJvcMW1m4p3bno5O2+o9eU2igic6Q7FIQQrW73MF96Oc9we1p1QiuDOR6Zpkr
         yM9hFHYGlfCjOBeTiYNTs6ePKbAODR446iBQGqujN3VRsQ183q8jZ1cJT/JY9AEDXPzY
         w/lLI5hFhRmvMh3nGSeQ+Re7vxsSBkuavZRU+WcoR0xwzwEPmpkVd1ThdDfUUX6tubeB
         yvwERNxaNmznRnAUqgK4PfmvnHvyloKnX9vuRWLH1oZXDvWAEhlP939Z3bcWwmtSGQl6
         RUHA==
X-Forwarded-Encrypted: i=1; AFNElJ9o8SAdJzrxmndsuO6euHaf2tY6T5k+Ko1G4xqy6yHp/5wU5Tmdj0lYm1RnhUNOt/frxqv+R74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws30y3S03tCrzTD17QUepz1CI/3QapZi+sYUe32Q3r5mKfQBAg
	6lqojRTu/G2g0Do3ztuJhu8BhvND4dkvY42DOxVL1gU2oupP9QQphvw=
X-Gm-Gg: AeBDieuWIBMIfjaef3olRIn0B4HfZjadrkZ5Xeuivyl4SGNpB+TC/68cjHOqvZDc9Fc
	awj5uL/zsKfnzPt0ospPagK0efIA1MIZ5dxuVZ2M3MACA5CUaCL47XCS/98Km24s0UzK3AzjoKu
	dSC2PgKX6g89vzmB9z83JpeE3eIidEuj7W51VpxDCbSxwEFFK4losUgW/5DO2gaaXYVTeBso+A6
	6rY3mSXkCXP7NqchGA5yAG369ejAoMiSPnDrPgh18ANGrKoGkvGBB3PR4pmZl5XxZ2JLX/I4adb
	SVT+YpOOotrP7fMpjJFoIxkERfpPEVEWYrihEh0hRbAn6OYG6gx00V5dhTCxnLVkUNJCK5msYlP
	pS+Nb5xMTeGhy558OwEeEvh03aZ0snUs3MEmnVfRDu5V9N/OJjoDCrWzTByBluvfW2U0JJx/fOl
	Gfht8gtLjxceqqAGIP0gq6ASo9NR6cQ+1/EfXEaQ+EgRxqQLUaPU09H9m13zmkHjlg5MV6SyIqM
	z3sfec1SMkuVFLaUlf5rMHxIjiOSBUB6Ie1OxraLNDfTIg=
X-Received: by 2002:a17:902:e54e:b0:2ae:ce35:2686 with SMTP id d9443c01a7336-2b5f9e64c77mr424633395ad.5.1777284057141;
        Mon, 27 Apr 2026 03:00:57 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff713sm304240245ad.5.2026.04.27.03.00.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Apr 2026 03:00:56 -0700 (PDT)
From: "=?UTF-8?q?=EB=B0=95=EB=AA=85=ED=9B=88?=" <mhun512@gmail.com>
X-Google-Original-From: =?UTF-8?q?=EB=B0=95=EB=AA=85=ED=9B=88?= <pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
To: Maxime Ripard <mripard@kernel.org>,
	Paul Kocialkowski <paulk@sys-base.io>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Myeonghun Pak <mhun512@gmail.com>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] media: cedrus: clean up media device on probe failure
Date: Mon, 27 Apr 2026 19:00:10 +0900
Message-ID: <20260427100049.29034-1-pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 676004709C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241285-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FREEMAIL_TO(0.00)[kernel.org,sys-base.io,linuxfoundation.org,gmail.com,sholland.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bagmyeonghun-ui-MacBookPro.local:mid]

From: Myeonghun Pak <mhun512@gmail.com>

cedrus_probe() initializes the media device before registering the video
device, the media controller, and the media device. If any of those later
steps fails, probe returns without calling media_device_cleanup(), so the
media device internals initialized by media_device_init() are left behind.

Add a media-device cleanup label to the probe unwind path and route video
registration failures through it as well.

Fixes: 50e761516f2b8c ("media: platform: Add Cedrus VPU decoder driver")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index 6600245dff..2c25654640 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -507,7 +507,7 @@ static int cedrus_probe(struct platform_device *pdev)
 	ret = video_register_device(vfd, VFL_TYPE_VIDEO, 0);
 	if (ret) {
 		v4l2_err(&dev->v4l2_dev, "Failed to register video device\n");
-		goto err_m2m;
+		goto err_media_cleanup;
 	}
 
 	v4l2_info(&dev->v4l2_dev,
@@ -533,6 +533,8 @@ static int cedrus_probe(struct platform_device *pdev)
 	v4l2_m2m_unregister_media_controller(dev->m2m_dev);
 err_video:
 	video_unregister_device(&dev->vfd);
+err_media_cleanup:
+	media_device_cleanup(&dev->mdev);
 err_m2m:
 	v4l2_m2m_release(dev->m2m_dev);
 err_v4l2:
-- 
2.50.1

