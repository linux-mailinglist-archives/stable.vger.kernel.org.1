Return-Path: <stable+bounces-242133-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EALjMuRm82ky2QEAu9opvQ
	(envelope-from <stable+bounces-242133-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 16:27:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DC34A40F9
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 16:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68A563053741
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 14:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A645942B750;
	Thu, 30 Apr 2026 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bacCelzH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204B442668E
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777559142; cv=none; b=hSMVZ+zsbNEI5uCwZgpFsOqaSthoRaqICiSgDQloneSLJPSq3ycmu6stuSzT6yYyfRHpaV/2kro42+KUpBg2llJITH/we8qVnwgVWpnkUhQAchKusElnuLbefQIlkhppKNAOt3750MKAlQPHpPrKtvmtWqp/co95BHDoa5+Os6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777559142; c=relaxed/simple;
	bh=SsB3fVBmTDjC/TDn0evKIsstRQxjanBDMF1KqALO2L0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cYLz6B68HeVOa9goEofKHDN15Kd25PZ38BjfxUwocQjfj+d6dqpd84zyEbX3p0f1HS532tqE3lEGcer6Sk1v+NlDtrQ6Ix9FNU8+yJFUuafRzSFb5D7NGhw/YMC+OLYl5KEixqhCmkfnJNzfter619KubOIYFmtNzjYrS8chsNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bacCelzH; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ad21f437eeso6744755ad.0
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 07:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777559140; x=1778163940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SxQQAfFaaiRvrhNuhc/nEMGhJjTGCuoSHZosD17X3GQ=;
        b=bacCelzHujp7TYD0YyDqoh4B5auHMTsnUD76RoUlLK6i43+l83TToeiOinIct2vB94
         3Enlx/7oWxKl+m9SwpHea5999DziUUmjDbXRdm8r6I50WFxei1sZGSydhe4Lmaqzouws
         tvgx+qJRoWRW5x6qYMCSS+Q2BSLXi9yDNOjMxvx5ZaF5xHx6eD7biqyuDP4BMYrW76DF
         loV1H7Q8Gb23A+V7ywZRnKtrXwRRnuRAODCjQEOqXGErbvhh4fcSBq1J4z1YpnfBXkcw
         tCVnZ2G9CtWQBEgpaDFk6hM2QG7FBbqq1jYU7vVEMPQLirVjwnZ4GtizU3yqFSTSyY4p
         QUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777559140; x=1778163940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxQQAfFaaiRvrhNuhc/nEMGhJjTGCuoSHZosD17X3GQ=;
        b=nkS/rB+AQM3veCtgv9TboqPNavNk7sVdA4VG9LwFl8+IZy5pf/BEr2bay/J2IUYUtZ
         m1OkKnINHuG9AL9JiX/FdkL9T5BShbqBE+/qg64O2BgaxLIT0M6K8y3gPOnKwfASD2z6
         ZQNCgyz+zGvIPXwjkUtCTZj6ZlEhytFgEuKmFBhr/C1vDiR2WM6Cv3mjvyk1jeI2lPmc
         TBXJg8GRpJ8NInUSFUlusr+z4Nzo6Cy9aIMJrje63xQhuVBacNlFLUs0fHCbT97jsEZN
         My5ekYyqaOa+X4T1B5Q0AC+7U+aZFzDpvRc5DKFaeKjEMmYX2x1hqD4I2kkcjzJUV7oj
         cBuQ==
X-Forwarded-Encrypted: i=1; AFNElJ9rtk36uks0gzkbhYHRdNPnNDT+g7gKtsxwDm2EZnhaEsIGlkOx6SC7SlcWVioKRPO+HncUdnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzshV1sMfENpHEL48vPrSCctkNZxoO26FV8Rs+ewVOfjD0LvS5b
	KxAjC419kx0f7OgjJVK3rfeAQlyX+Bly6fHcP59F1NBBEknWGFD1oO8=
X-Gm-Gg: AeBDiev0WHttwFP3nU9k+jUb0JlDdGRx7HzGTw0Hhk1ADqbd0b+iP4X44pxZc3+RnAQ
	WUlvpVyGsYfDApsyLQ9DDjUhBcLhuhwSnC/xW/8bFM4aA+xvEXXR2nmMbas9HHORszWf9KC3lUQ
	Q80aXqhjdRWK96Ho7ruvmLudXV21BDQMjs2yn2h7ysD3nm4757u8sqCgHqHbZw75yvN0Ei6/+vB
	oT6aUnV2yhzw7zPl2QQOeIOt81KBQD6luk2encYfTwQ36Y4q/jKJrgWVg2aiymbTqJSRhJ69f9Y
	4cunoBJawLKtuTJWCWp0Z783Wt0MfufqMV9HxhtZNIqcUGq4o7f8ScZRAIdRRZdIo5YRGfgnKXC
	Tsta4qX0otY4YFE8F/7ZeOn4PUPRUx21NVxBe5cxqrSjXnYtLAqrplJbkSkxbRiCuqG9q/EIv1f
	5xgJ7D94JFh1OXxzaLXOrXzxzmV6IG3p5bWCGK936xMYFcBDChNhOvlbI1+KzNkPY5mZ6zTdiF/
	8aBGavI6hg+ClavHEp+h5fxQlP8bLA9uO1il44wkFapFW2hj1v5IzugSzDnJU4=
X-Received: by 2002:a17:903:3b86:b0:2b2:ec33:cf15 with SMTP id d9443c01a7336-2b9a42dc3b8mr23951415ad.7.1777559140212;
        Thu, 30 Apr 2026 07:25:40 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98897edefsm54194885ad.74.2026.04.30.07.25.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Apr 2026 07:25:39 -0700 (PDT)
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
Subject: [PATCH v2] media: cedrus: clean up media device on probe failure
Date: Thu, 30 Apr 2026 23:25:29 +0900
Message-ID: <20260430142534.12928-1-pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 37DC34A40F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242133-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
Changes in v2:
- Drop the now-unused err_m2m label.

 drivers/staging/media/sunxi/cedrus/cedrus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

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
@@ -533,6 +533,7 @@ static int cedrus_probe(struct platform_device *pdev)
 	v4l2_m2m_unregister_media_controller(dev->m2m_dev);
 err_video:
 	video_unregister_device(&dev->vfd);
-err_m2m:
+err_media_cleanup:
+	media_device_cleanup(&dev->mdev);
 	v4l2_m2m_release(dev->m2m_dev);
 err_v4l2:
-- 
2.50.1

