Return-Path: <stable+bounces-134672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32354A94258
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 10:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ED4844393C
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 08:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792541A8407;
	Sat, 19 Apr 2025 08:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ntw+WZv8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDB918FC74
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 08:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745052080; cv=none; b=JjEd3droz1lGPlSxYRk7mZvY00V1m/7Nt5G+ZivNEgXwI06eEtZOExEcPanFw9uzXBGBOfzNNA2mD0eHBxNC6ILYiwD7cjmO5pJ8mK7/EX7iICh7B4ik10eCDpU4JH+zAezXTWVhGxmYjA6N53k/yme/TrW/nWOCeNh0mzKD1ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745052080; c=relaxed/simple;
	bh=kGrAYA88LgNo3SC09UgzuchpWyqsNF7RgZXm2bDq5aE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DyZS5p2vj6magganaWa05rd2OIER8TznqNTixsW5+dWvIyCR5aT19W/mEyLgy/YOrvHimIHRfJltzzpkSOmHQtfcikAs6Se79qQrs3SE+P3cQyiaxY9ZUcveGeoZhmsYkp/yJ1rhAKR+masrYBZ/8z2G9MVvnzT6NrYAdpDJ/ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ntw+WZv8; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cf89f81c5so3243415e9.2
        for <stable@vger.kernel.org>; Sat, 19 Apr 2025 01:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745052073; x=1745656873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KYN64HtAwCE6OBtFOpO2aiXo/h2f0BtR2w3Iyw7cHbE=;
        b=Ntw+WZv8YjVuKii2KEIwn1LM2uz4nTKSO2JtNbaPK5mj5k7+488VRqmMeT5k/py48y
         9TocEqW7CvGh0+pdUI06ks7kO3T4AvAp7l7kFf2fhLR+NprZvtFmNTPffWal49dLtX3d
         EcJ0f9LaUw/KdWoMxpVWaQlrO2pvewW37sZWFBFwv02mMI6B7t0qQ8gQVBnrS19fgmQt
         lTuKBTzU5tonwMZk+PWQxFY8vmBW5jk9pMFcpfGTJ7HeQ0noMwk4TFlAiqiVUTOXFFbo
         sXbdyf1foOR6oxM0gC8OKgi/qJvcYtGYUzaSa/YIFbkoGC7B0pakpGOUHWoQjH2/IyH3
         UTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745052073; x=1745656873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYN64HtAwCE6OBtFOpO2aiXo/h2f0BtR2w3Iyw7cHbE=;
        b=aB6Ntuhk5EmN5sOZcwvnEWjUxhQAB4wyQULvKCsl25FC3I69GiRxlu67kE1OSEojfw
         5fXcgTtNEoo4qMqyxow2hOQZ55GCdXXVK3q0UWPpogMX6z8u7BgmIUELJWXjHsJRhUhL
         AG6pcV1H570tZ3d6GUbakDzOLs2ipNcNRHAqa0dSL42BmULcX7ABByo6JmdP0gAtUBp4
         Pl41fEY1Fb3S/eBbnQZP6vlV1HMnCvEWrW4DGl4vvp2gsaFwynZ3rv8HLSioM9tHgzwb
         iyhqZU+aJtnWIhD6iWpXbF6fuBZWNzD97c+dYVYqRoJTFztkkg+dr0IjluE+Z2VA38TS
         E98g==
X-Gm-Message-State: AOJu0YyNpJLnmcR0kNz+rnH7pLI5klG+Yc7u17BgSwTCETz70mE+N5kC
	rfrS04mehdodoLiBllvk/tALjrkEWvQG+QpIDAfvcx2kpEmn8JhFKJaHCch/YE4=
X-Gm-Gg: ASbGncvj0+1ctyiXdOGiGyr68WJ9ABIJ9mqbJGxCp02n4lZPobw7117yRmXMD5K5dGe
	k4ABpQrKySiIhwivbSC7B6OdkOIXcz2Yl8zkLq8tGJ1NVhVTMi3DsJcaQGGz90ESMHEG4Wb+V9k
	0uQvKYO/xQqJoyfVWiLrAYUauYkEZOsJYkKrh/x/59XYJzYndOzaM9H6rk4KnNwULeaQBnSX17c
	zqDNZfU1M3dE+rdbM4fVA7K2v9Rhtz8MoaVJK9iT6oz/SZ0FhwjamvAdsKPpT7jp9Tn3rkbikSN
	wknGYV2FT4XBWHpEQCW1l3CwosKXMhoBxDt9W/TLBrihdsc7hed0cszVDzA8aX+ijn/kEzsa1TR
	ZAcrYZ29EM2m2zKQp1Yw=
X-Google-Smtp-Source: AGHT+IHs9/4N+evWsJZt1ZBhAbZ30P4jyhMyC92OfczSHuaNgqzWIqDSAmWpXxuYOn0c4fA3MOWjGw==
X-Received: by 2002:a05:600c:4e0b:b0:439:a1ce:5669 with SMTP id 5b1f17b1804b1-4406ac00873mr19667555e9.5.1745052073163;
        Sat, 19 Apr 2025 01:41:13 -0700 (PDT)
Received: from pop-os.localdomain (156.64.191.92.dynamic.jazztel.es. [92.191.64.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa420837sm5208711f8f.10.2025.04.19.01.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 01:41:12 -0700 (PDT)
From: =?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
To: stable@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	Lizhi Xu <lizhi.xu@windriver.com>,
	syzbot+9177d065333561cd6fd0@syzkaller.appspotmail.com,
	Theodore Ts'o <tytso@mit.edu>,
	Miguel Garcia Roman <miguelgarciaroman8@gmail.com>
Subject: [PATCH 6.1.y] ext4: filesystems without casefold feature cannot be mounted with siphash
Date: Sat, 19 Apr 2025 10:40:59 +0200
Message-Id: <20250419084059.53070-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lizhi Xu <lizhi.xu@windriver.com>

commit 985b67cd86392310d9e9326de941c22fc9340eec upstream.

This patch is a backport.

When mounting the ext4 filesystem, if the default hash version is set to
DX_HASH_SIPHASH but the casefold feature is not set, exit the mounting.

Reported-by: syzbot+9177d065333561cd6fd0@syzkaller.appspotmail.com
Bug: https://syzkaller.appspot.com/bug?extid=9177d065333561cd6fd0
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
Link: https://patch.msgid.link/20240605012335.44086-1-lizhi.xu@windriver.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Miguel Garcia Roman <miguelgarciaroman8@gmail.com>
(cherry picked from commit 985b67cd86392310d9e9326de941c22fc9340eec)
---
 fs/ext4/super.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 53f1deb049ec..598712a72300 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3546,6 +3545,12 @@ int ext4_feature_set_ok(struct super_block *sb, int readonly)
 		return 0;
 	}
 #endif
+	if (EXT4_SB(sb)->s_es->s_def_hash_version == DX_HASH_SIPHASH &&
+	    !ext4_has_feature_casefold(sb)) {
+		ext4_msg(sb, KERN_ERR,
+			 "Filesystem without casefold feature cannot be mounted with siphash");
+		return 0;
+	}
 
 	if (readonly)
 		return 1;
-- 
2.34.1


