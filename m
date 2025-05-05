Return-Path: <stable+bounces-141260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2FCAAB686
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D84F3A9F9D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3834441DA05;
	Tue,  6 May 2025 00:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIyuUDhS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCD827FD61;
	Mon,  5 May 2025 22:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485637; cv=none; b=a3vegrlQwhXg0qREf/u1Dx0uesSY5wP7YXD6qHPYy4gEz9IjSzSyHAzt3WWPguEtxmAffyFnsu26Yws1q1Y+VPGtsLgSs8XYUG/f91FabdsC6rCvWVkUrRLKp7HuEBTtLHngIRmUE+qkrsh/HgO908iNwdIQlLDOtyoJXAo0GVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485637; c=relaxed/simple;
	bh=efAAsusLpliVA+wnEyoY/khXhi125dU5XM0uCV+wq7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lsLkCvrBK5XhQkJG/d6m28bYPiFbZjWp1SbTU6iT58l/oO3cha2DRupu1N6opw1wSYWv2V8AUSc3QVdCgH/MQHUNgLyl76YpIQtT9j+9l3FDt7GVJ/hkefDbZyz8CsrpYhvCNvu+swLmjbiUfKUvKNh7nE1oVnF54YP110p/az0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIyuUDhS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC29C4CEED;
	Mon,  5 May 2025 22:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485637;
	bh=efAAsusLpliVA+wnEyoY/khXhi125dU5XM0uCV+wq7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oIyuUDhSj3em4n23ZvH7MiYj3rTXPHe6c4X4qpDE+1NLFknN8EvXipl1WQ7x8ZBSn
	 s+aXLmlj2h/wUJPV/PKrVAWzqJfb3hJVXKadjUkZm+PhMECChZcAWIy1R8jil8LVCV
	 1/Rlao2H/83aELRWRX/U5Zzc7igbhdeoS3dWq1RqAsZYzosClqn6UmKaP1XDZbkMP1
	 QzRW7k1Nc/Krwp3ENcR1fqh/cOLBNa4+L6aXZS9A00OOSXVE0bpGBvAoemU0G4QdxW
	 JOYmFHWy+Xmda9LDl+BLKUXv0oa5hnmliA+wcNzehDsIgIc8Ol9youiF+FR9FIL4zj
	 Cc4xboespLC3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	gregkh@linuxfoundation.org,
	hayeswang@realtek.com,
	horms@kernel.org,
	dianders@chromium.org,
	phahn-oss@avm.de,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 398/486] r8152: add vendor/device ID pair for Dell Alienware AW1022z
Date: Mon,  5 May 2025 18:37:54 -0400
Message-Id: <20250505223922.2682012-398-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Aleksander Jan Bajkowski <olek2@wp.pl>

[ Upstream commit 848b09d53d923b4caee5491f57a5c5b22d81febc ]

The Dell AW1022z is an RTL8156B based 2.5G Ethernet controller.

Add the vendor and product ID values to the driver. This makes Ethernet
work with the adapter.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
Link: https://patch.msgid.link/20250206224033.980115-1-olek2@wp.pl
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c   | 1 +
 include/linux/usb/r8152.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 96fa3857d8e25..2cab046749a92 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -10085,6 +10085,7 @@ static const struct usb_device_id rtl8152_table[] = {
 	{ USB_DEVICE(VENDOR_ID_NVIDIA,  0x09ff) },
 	{ USB_DEVICE(VENDOR_ID_TPLINK,  0x0601) },
 	{ USB_DEVICE(VENDOR_ID_DLINK,   0xb301) },
+	{ USB_DEVICE(VENDOR_ID_DELL,    0xb097) },
 	{ USB_DEVICE(VENDOR_ID_ASUS,    0x1976) },
 	{}
 };
diff --git a/include/linux/usb/r8152.h b/include/linux/usb/r8152.h
index 33a4c146dc19c..2ca60828f28bb 100644
--- a/include/linux/usb/r8152.h
+++ b/include/linux/usb/r8152.h
@@ -30,6 +30,7 @@
 #define VENDOR_ID_NVIDIA		0x0955
 #define VENDOR_ID_TPLINK		0x2357
 #define VENDOR_ID_DLINK			0x2001
+#define VENDOR_ID_DELL			0x413c
 #define VENDOR_ID_ASUS			0x0b05
 
 #if IS_REACHABLE(CONFIG_USB_RTL8152)
-- 
2.39.5


