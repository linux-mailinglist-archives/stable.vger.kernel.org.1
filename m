Return-Path: <stable+bounces-6038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EC980D870
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAA02B2106A
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0129551038;
	Mon, 11 Dec 2023 18:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="orcCoWU1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FA14437B;
	Mon, 11 Dec 2023 18:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37259C433C8;
	Mon, 11 Dec 2023 18:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320344;
	bh=8vGvTaDUWnfE6x0pIASNp0keCX79Zdc3OlY5xzQEkZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=orcCoWU11PpTBmYF9rBe8ozzzlEqY6ytBIAWF6Dv4Gts1702vP+jFiCshocFNmFwd
	 Yj4U1rpfnwbYXDKmnTbV81xmIRuCMdId0fwWITGO2sktuiqO+rI8Ik79dNmE05QEE/
	 FIupegbgqUGaKGiPbfaOHMR28WsOuQm7kZeDjDSA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Grant Grundler <grundler@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Hayes Wang <hayeswang@realtek.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 027/194] r8152: Add RTL8152_INACCESSIBLE to r8153_pre_firmware_1()
Date: Mon, 11 Dec 2023 19:20:17 +0100
Message-ID: <20231211182037.782905485@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182036.606660304@linuxfoundation.org>
References: <20231211182036.606660304@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 8c53a7bd706535a9cf4e2ec3a4e8d61d46353ca0 ]

Delay loops in r8152 should break out if RTL8152_INACCESSIBLE is set
so that they don't delay too long if the device becomes
inaccessible. Add the break to the loop in r8153_pre_firmware_1().

Fixes: 9370f2d05a2a ("r8152: support request_firmware for RTL8153")
Reviewed-by: Grant Grundler <grundler@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Hayes Wang <hayeswang@realtek.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 8b463a9c5e44c..b8ad038dd36bf 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -5527,6 +5527,8 @@ static int r8153_pre_firmware_1(struct r8152 *tp)
 	for (i = 0; i < 104; i++) {
 		u32 ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_WDT1_CTRL);
 
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+			return -ENODEV;
 		if (!(ocp_data & WTD1_EN))
 			break;
 		usleep_range(1000, 2000);
-- 
2.42.0




