Return-Path: <stable+bounces-136428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AAAA992EC
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 985787AD6F2
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539292BF3C5;
	Wed, 23 Apr 2025 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uaDc85SB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F956289364;
	Wed, 23 Apr 2025 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422520; cv=none; b=IC/vEHAtqG0P7QI1cYXMs/IDStdyVR6GaWFy1i68sl8mIQswHdKPPycAMOMqrFk60rSBiAdy/WKiQ8Qe4P7OQh2cmQ/PhAdAHfWDied1gYAJ6nFnngJNeeYU0qgUB9zGv0Nlg1VmO2gpzFwxmXdQe7sybb8wseru1NbKSP47xbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422520; c=relaxed/simple;
	bh=5+U61jj1cbr4l3fyLTDPUrErAf3o/Ieqhs8/5hDhAdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBpBcXZ2ssi2g+v8R5ezSFRgaHUP5zHtVvwOkAIitVTYJOywyG2bjwmdzK7VjYKd3z2/CgZbsTBolQWl3zvBvN3zmmRLyMzgMOINFBbQ3ZsBAMQ+1Xs+n6I9JZB4VU7Z9IO5u40/a0Mvh/NfJ8K4GMyPmUZ1AYhhfqwILTqEdMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uaDc85SB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318FFC4CEE2;
	Wed, 23 Apr 2025 15:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745422519;
	bh=5+U61jj1cbr4l3fyLTDPUrErAf3o/Ieqhs8/5hDhAdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uaDc85SBxwRM7dE7wH6SphIMXpUdtl2/isPbZXFaiN2hfjbA5hgFZYr1D29iAQOD7
	 NNXZOCdfi5zONEyiF3vLQrotj4B1ib1v0XgcBvjO2xepJkrD/kN8HqCejD3QKWgbBa
	 /1zFwtXcyYJdCzymbnM2I4dzD7aPdED7V14eF2tM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ping-Ke Shih <pkshih@realtek.com>,
	Zenm Chen <zenmchen@gmail.com>
Subject: [PATCH 6.6 381/393] wifi: rtw89: pci: disable PCIE wake bit when PCIE deinit
Date: Wed, 23 Apr 2025 16:44:37 +0200
Message-ID: <20250423142659.063611343@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142643.246005366@linuxfoundation.org>
References: <20250423142643.246005366@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ping-Ke Shih <pkshih@realtek.com>

commit 9c1df813e08832c3836c254bc8a2f83ff22dbc06 upstream.

The PCIE wake bit is to control PCIE wake signal to host. When PCIE is
going down, clear this bit to prevent waking up host unexpectedly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20241111063835.15454-1-pkshih@realtek.com
[ Zenm: The rtw89 driver in recent kernel versions supports both Wi-Fi 6/6E
        and Wi-Fi 7, however the rtw89 driver in kernel 6.6 supports
        Wi-Fi 6/6E only, so remove the unnecessary code for Wi-Fi 7 from
        the upstream patch to make it apply on 6.6.y. ]
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/realtek/rtw89/pci.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -2482,6 +2482,8 @@ static int rtw89_pci_ops_deinit(struct r
 {
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
 
+	rtw89_pci_power_wake(rtwdev, false);
+
 	if (rtwdev->chip->chip_id == RTL8852A) {
 		/* ltr sw trigger */
 		rtw89_write32_set(rtwdev, R_AX_LTR_CTRL_0, B_AX_APP_LTR_IDLE);



