Return-Path: <stable+bounces-111977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C75C4A24FE0
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 21:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723FA3A4B67
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 20:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C77D1FAC48;
	Sun,  2 Feb 2025 20:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kT6lqjRl"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25441D5CC7;
	Sun,  2 Feb 2025 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738526721; cv=none; b=I5g1T75VR17MaZLYwjQ0k6rvwCYnDiJNp/WRCthJzRAntZ2La3M5Cf21R7z3JLY8XCqfnJeKArxaNEDOXzaS8mXyq449nP5w4sPUoHa/8eiGymRQumef3BAOdRPkD2815Z/WaJKCJ6WOjle3Khgp/yVzJinJ+XHM+nXtpXsVEDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738526721; c=relaxed/simple;
	bh=Kz4P9bcELSNfrbBeQNUDNzTAesztJwA4wKJufJxM4q4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KOJxnmKrfDDlrQe0QtMpQuOFjji2TEEjJv4iS9yCjyTTNsBDftOMOT8v7EiDADakNMi6Tu/VhQI0WWP7NDWJ0saVTfcccrKvUAQ70j81+GhMn5b8zrnPHSivJkQrj9jfYC1HAKyDUpjsAlWdSn2GAbzdrjKUxnuAMt3/Kys+GdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kT6lqjRl; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4679eacf25cso24632331cf.3;
        Sun, 02 Feb 2025 12:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738526718; x=1739131518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+10CD82lxWzunsGoUMRKvd8+UQ83WZ0ZHPFgD8iXDBU=;
        b=kT6lqjRly7OSGW9UuCb63jNWh33r4xY3qSMA3JQ/ZnjMVNj/7zwxkPx7JnbfAFD9Nw
         44if0UZltcpfdfa8gXUru1tP30PcripG7HRLoDNneXNgoDh03z5H7BHGQi29pRAKbv4Q
         VKKOzHR6Q+xI9X/505gs/1aix0MnoRS7Zr/c+OvE+XeGbdmzeS6fu0mOXSaOcnwJ81BT
         DBhvFcIgf6P7DdBpsyT9XjY+HXe64pzBwHiXS1h/QbzsPyYxsnXAk12/8Rd3CGptKOe5
         qVfyO99DIErK5n+EGcULwAlfdOy9sbsFeceD1gJ4d3oh1lrBNcQQ69JFStlKkOCPXQoh
         5+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738526718; x=1739131518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+10CD82lxWzunsGoUMRKvd8+UQ83WZ0ZHPFgD8iXDBU=;
        b=GdJOhJn5VW6pTwTOT4jMEbs93B6wlVxwsz2Q5Z1v6nlidALky4wxiCugFZXkuVdR2Q
         gS8AbjBNuJfDaqBKnqYQgbKE8aAers1VSatMqobYPL5l56mLzPDkUY7Kpl/qJwOYYByt
         Xe3lIyffylYIc2eV9inOQvT/mtRec3WuvsLAj1LtwCOOf9V6URWFVc6XiyTu5OsqqJbA
         6dOrNzSBUmMAB6INZhc/BGiVs/Txvi/gds2OjqWi+KyVnPkZ4k9iKu4M9djpTjPmmwrc
         9QsqDxkEkBt2x77hezWzypve6jz4/noGu2YWBQby2X5X9YINnTTmAlcOCPS+tUGm6AUl
         Q8eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo/IrZfG00KHyW9WwC35os3EJjWvqKzi8mc6QnUrW+QuluWpEdqa2gtSJXz50cyhBYkeoiQto=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZGin+r1NBocjqUjocX72hOzf+yyrR9e3iKUh0RG3IXVLJNu4N
	f/LfggBF4Xs+cDHecvpU6EAlofURU7pGNJMTsevl4vWxtUeNDdsQ
X-Gm-Gg: ASbGncu2UZNV9Q+oObX0cE3PyJDr945ybcV1Yn85EueHmzmFVqSN1wnjNR2t1yLx+l+
	cuM7+SBaVfBboFql9lAk3TPwwujE1b9wWT6z0bTKhG+eyu/y6FFaU89h1lxaySt1FHiGM0+sKgH
	pJ0Ig6/8uK9DYAKMgDPzvMr+uGv86EhTPKqoxYqy1Tt0cgl5frELcjUjFygPHKmuCUqoBCAEIh4
	UvhU2Z+gL++NiEWg2h5Ltx5BGkMFFtdsryEGOOar5vK1hRZENBeRGk2aCPNSBIlPK2XQSjFWajy
	SzxJMGI8cbiPm/gB3W039inJeq9Ps/aA8yhVmA==
X-Google-Smtp-Source: AGHT+IE1tSnv3JRhHS44+18cqNsa7mhNjsQ3k95O/VU43tiehcgoNfBXuNZWB2tmD3DDekK+CvFioQ==
X-Received: by 2002:a05:622a:1a0d:b0:46e:548f:ab8d with SMTP id d75a77b69052e-46fd0b68d36mr263530411cf.37.1738526718323;
        Sun, 02 Feb 2025 12:05:18 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fdf0c90d2sm40708951cf.28.2025.02.02.12.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 12:05:18 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: broonie@kernel.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	mazziesaccount@gmail.com
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH] regmap-irq: Add missing kfree()
Date: Sun,  2 Feb 2025 20:05:12 +0000
Message-Id: <20250202200512.24490-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kfree() for "d->main_status_buf" in the error-handling path to prevent
a memory leak.

Fixes: a2d21848d921 ("regmap: regmap-irq: Add main status register support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 0bcd81389a29..b73ab3cda781 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -906,6 +906,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	kfree(d->wake_buf);
 	kfree(d->mask_buf_def);
 	kfree(d->mask_buf);
+	kfree(d->main_status_buf);
 	kfree(d->status_buf);
 	kfree(d->status_reg_buf);
 	if (d->config_buf) {
-- 
2.25.1


