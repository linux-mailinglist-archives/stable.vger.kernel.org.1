Return-Path: <stable+bounces-203322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4434BCDA22C
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 18:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2162C309F26A
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 17:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598DE34844F;
	Tue, 23 Dec 2025 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfDzuOu3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D9629E0E1
	for <stable@vger.kernel.org>; Tue, 23 Dec 2025 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766511227; cv=none; b=VfSiUIPQMYNXmF+pzKZKxbMzxtfSDqAFFP1hcHeVs+oVGleaRIiZWcldfyM+YSUuFgCXz7U4iw2OSqcTIWFhrEZ5C9hap18SyQ0ONKpDfCO8FguT4I0IkFCX36skoO0TL/XFCwKDFAU+o0GScWsmiidwhWM+i4ee7DbbsgOU+8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766511227; c=relaxed/simple;
	bh=r8MAaM+ASLz4mlwktAF4sLTfotJ56JVmJ1THLtDhhoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjaR7IrUeXuu9AkyKlpC2CSQXjWUQ9QK1gHfzor1V0bwLF7WTSTG50N53NsHhz1GkbT15L85PwfLYjpqSnYcMk6glDfrAZLF2wDNp0PD9mMBXNn9OKgzK/BB6cPy27Kc8N5AmbZCmu331eZhP4bPeMlhhKa/gNMdoVz0Mh+cyXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfDzuOu3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C38EC19422;
	Tue, 23 Dec 2025 17:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766511226;
	bh=r8MAaM+ASLz4mlwktAF4sLTfotJ56JVmJ1THLtDhhoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SfDzuOu3IU48jjGzmBuLWCu6oWxwuSu0iS5+/XV9ljkzAez13E2L+EwSxor3ZmsUx
	 ULmtFcSGBL4umW1O3NiDzWaHEws/+r/Grk2gtr2UtAHtAE9fu5nh8xyYkx98QAKhxv
	 MoGMMPD+2PtErqzVUQ7cfrO4vfb4IsVsk9XQNk0afpyKOo5vr0ySx+Gi+k5EmnnUIE
	 iXBmNIyxzlCvfUptEplKc1Yj3Jv+wSW7b9w5IOaoNbTiVlJeMKQb6ozlUhl28u+fes
	 l4rtQ1wvy2fPIx0bNSwyxFZXpeK09hvtioiZ56REd0e2cHFzl2mfMaHGkpBY/N+pXm
	 NGUJ+3hG0dSHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] can: gs_usb: gs_can_open(): fix error handling
Date: Tue, 23 Dec 2025 12:33:44 -0500
Message-ID: <20251223173344.2929930-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122306-hurry-upstream-964e@gregkh>
References: <2025122306-hurry-upstream-964e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Kleine-Budde <mkl@pengutronix.de>

[ Upstream commit 3e54d3b4a8437b6783d4145c86962a2aa51022f3 ]

Commit 2603be9e8167 ("can: gs_usb: gs_can_open(): improve error handling")
added missing error handling to the gs_can_open() function.

The driver uses 2 USB anchors to track the allocated URBs: the TX URBs in
struct gs_can::tx_submitted for each netdev and the RX URBs in struct
gs_usb::rx_submitted for the USB device. gs_can_open() allocates the RX
URBs, while TX URBs are allocated during gs_can_start_xmit().

The cleanup in gs_can_open() kills all anchored dev->tx_submitted
URBs (which is not necessary since the netdev is not yet registered), but
misses the parent->rx_submitted URBs.

Fix the problem by killing the rx_submitted instead of the tx_submitted.

Fixes: 2603be9e8167 ("can: gs_usb: gs_can_open(): improve error handling")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251210-gs_usb-fix-error-handling-v1-1-d6a5a03f10bb@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
[ adapted error handling for simpler code structure without timestamp stop functionality ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/usb/gs_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 5d0cee57ab97..bf9e13bd21de 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -985,7 +985,7 @@ static int gs_can_open(struct net_device *netdev)
 	usb_free_urb(urb);
 out_usb_kill_anchored_urbs:
 	if (!parent->active_channels)
-		usb_kill_anchored_urbs(&dev->tx_submitted);
+		usb_kill_anchored_urbs(&parent->rx_submitted);
 
 	close_candev(netdev);
 
-- 
2.51.0


