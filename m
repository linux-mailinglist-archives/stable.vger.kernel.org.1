Return-Path: <stable+bounces-118784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 543DBA41BCB
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86F6B1896153
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E3D257AF9;
	Mon, 24 Feb 2025 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivpjDvnW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3188257AD8
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 10:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740394650; cv=none; b=gLIbRof8Xac8XyJ0y6uOebDvCyMEb0cENym1GsJ4XoBj9yWAszSV+LkFjJDQzMEoXUSXDnjzH2jfCpRjd9aSPse1QXRMMuAEBToNSIVpU/v4Z49m7MfRDFYxPHchrhXEKuqCUq+NL1zhkJtRTQgogYBZeMoMjBE9sJQSQo+3xLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740394650; c=relaxed/simple;
	bh=mWPuIEmxzffwImrnUPFeCYarmrlFWpGcHY9nECaPOKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCT6I3V4XJaCnxgUcjSNNYsez7lFOykbKVR8xE9wVKM3rBn7vzTsHTcrWTgyt8AOwhFGCas4sFyx1fnp0kLuzmKU1eJYtnyVtUpQWbI730NxZmvS2N5sylXuIMAMfsVER4RKXxI6oQ3ZmZfErpBYHhh+tL5Sm99lo5ZMXhejYHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivpjDvnW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22185cddbffso84811005ad.1
        for <stable@vger.kernel.org>; Mon, 24 Feb 2025 02:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740394648; x=1740999448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qHwrz4K9MCVNdQFc/BfOO79uUOXHPSMf/MZekqYlX8=;
        b=ivpjDvnWlsmJthpyTMkgtJg8ccsIIlmMzBhUwa72xOs2VZQi4ghfaqAQCqk8Fu6EHM
         dPam5JfZRE7aJ9BF0XSBHm8qByQcqts0p7Cqxw8ZG0bkqr96/Qy6zv03zefSKZBGw/py
         q1dBMQMHgcwNQ+l4oTzpo9MIFw0z360CMWX392paTpaTyM6NivIGl5EthhFc75OzcHaF
         Sn9SAyieGeqFPA4GBaoCv9oNrIq7ygzKZJ2lk8q4rnOyE4UR8i9VxjsdyanU/Q3xsRvG
         QxqXKnNXEFRgZ7KeBctUg+xHJix4MZTogzVJpy7euN8YyQ6dIhnAfBkP0OGvyh12kCZT
         x/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740394648; x=1740999448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qHwrz4K9MCVNdQFc/BfOO79uUOXHPSMf/MZekqYlX8=;
        b=IwjhSRKmTe1Yt9Wbh/27NdmKnZbLRh5LQ2fVqdAIfLXZQgOt0huzXy5bAdcc4TvN4W
         aOhwSOOKlL7P/huL3K/hHzBaI8fl6MZ0oB51y++1w+xP109EFgOrVinGfR7f5Tn6BiZD
         Bc0+m67caXcYrBFdJXVtMjfvpcfKEnd2FHhO/6xb8wyWig73Ks5lfxOydsl/l5y4Pdzu
         dL8m8RFjaQUw5Gqj23w2fgpOaXn5TIUEb3N1BEpaK6vFte1iNPYGPZiQvx3A9EuQfA3q
         M1q2W+A4SdYGEodMRM6yaKUsCrA3ze8s20jAYBvb0e5GuuVws1U54Mx/yIsH3x9NfsQg
         l4iQ==
X-Gm-Message-State: AOJu0YyCMhdX0m9dWkdxbvhfRrUwoPV9xHi4b3yoaNDOyxDvuCYdjDvA
	EMv5uXzNednpZ6HR82MydoHVBFS0M4RkFiSN03S8QC6DxY8Pqs3M0n6wm4UQaR33Tw==
X-Gm-Gg: ASbGncspNe2pHut65qMbhS+hP2BYUP01aloisw8EGRQgN130oWC1xdbY55ccMKHzZnm
	tAlxTdSVla7y32jdHUc/5brGDexWu8bg7daqcGYSkW2i5kAGWpsIDsUkN709NfknC0P/msWtHCr
	qIsWKFu61Y/4ShgncL89WVGe/gXIcTkm0hjr/RkCQQ5/dlz3vj2wUon5Wye8DBie29KG7JkF+Ev
	UnaZxw6TyJmoIMsn6LHWuAX5DtG3dq7PmmLyl0pzyRbzXOJnhq6HYoc7/V1wLk78ndLOab8wl6g
	7chtwbCxJnvB/0wApYs4Fit2dp3D
X-Google-Smtp-Source: AGHT+IE+mdO6OcNKDSeT0ef/opWimOaWcQG0iIR9U/QMFZODpkUYkG3e1e4Pess3hj/epqX21y46AQ==
X-Received: by 2002:a05:6a00:6f0e:b0:734:26c6:26d3 with SMTP id d2e1a72fcca58-73426c62969mr21101163b3a.5.1740394646970;
        Mon, 24 Feb 2025 02:57:26 -0800 (PST)
Received: from CNSZTL-DEB.lan ([2408:8262:245d:5146:bc4b:53ff:fead:2725])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732707863cbsm15477146b3a.128.2025.02.24.02.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 02:57:26 -0800 (PST)
From: Tianling Shen <cnsztl@gmail.com>
To: stable@vger.kernel.org
Cc: Tianling Shen <cnsztl@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 6.6.y] arm64: dts: rockchip: change eth phy mode to rgmii-id for orangepi r1 plus lts
Date: Mon, 24 Feb 2025 18:57:21 +0800
Message-ID: <20250224105721.840964-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025022432-attentive-browbeat-000d@gregkh>
References: <2025022432-attentive-browbeat-000d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In general the delay should be added by the PHY instead of the MAC,
and this improves network stability on some boards which seem to
need different delay.

Fixes: 387b3bbac5ea ("arm64: dts: rockchip: Add Xunlong OrangePi R1 Plus LTS")
Cc: stable@vger.kernel.org # 6.6+
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
Link: https://lore.kernel.org/r/20250119091154.1110762-1-cnsztl@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
(cherry picked from commit a6a7cba17c544fb95d5a29ab9d9ed4503029cb29)
[Fix conflicts due to missing dtsi conversion]
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 .../arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
index 4237f2ee8fee..f57d4acd9807 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
@@ -15,9 +15,11 @@ / {
 };
 
 &gmac2io {
+	/delete-property/ tx_delay;
+	/delete-property/ rx_delay;
+
 	phy-handle = <&yt8531c>;
-	tx_delay = <0x19>;
-	rx_delay = <0x05>;
+	phy-mode = "rgmii-id";
 
 	mdio {
 		/delete-node/ ethernet-phy@1;
-- 
2.48.1


