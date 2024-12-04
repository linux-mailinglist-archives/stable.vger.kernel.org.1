Return-Path: <stable+bounces-98658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 389239E49A4
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BFAA1657E9
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEA5219A94;
	Wed,  4 Dec 2024 23:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjNNN4WS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94B3219A8B;
	Wed,  4 Dec 2024 23:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733355047; cv=none; b=jkNcAgZgauc3vsBRV9fgcE5a1f1fl9GwOvmg/Qw3wXnCUlTJeV3F9/J6gzhJEw4HUC9eSriqObxs7OgueZYptZZ9LwiU51lSZOME2Pir9/UneemQURrlpCf4JBWbeGtWf6oakq5egLEd7cxDUnXwdNXRSwNXhbv32bo3Icq9/Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733355047; c=relaxed/simple;
	bh=6BjXURGXi9To75QLY5xacjT2JuOXY4YUDAI/cCbYFLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Va+4pgWyCVxnUKHLuGksck5BGKOFREZcbReQ0yeRb7RcJjBQL/nOmfje5vOukda4eKCucXv+eng9z3+YH0tWCuaG5fWGq5heiiZ2BbkZGN8cjA4vWKF3VUj6TJf25LJlSh9GUNW7lq9uiXLFu7ZgtMBd1K7vb3JOfK6Y7D9gzPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjNNN4WS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6C0C4CED2;
	Wed,  4 Dec 2024 23:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733355047;
	bh=6BjXURGXi9To75QLY5xacjT2JuOXY4YUDAI/cCbYFLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OjNNN4WScOvBS7BN2WV+u6ZS1PvDONnG1dQU1zn3RwEJZ+rAPCQoVg97DaJZB1siE
	 R/cjHdrAI1/r6WI2mvRbd111dn/rnfv2c/82MKFFgFSjBfCa091mCJ/TTy+TFJTqu4
	 a3Mucu8MNRAJMhm2SAgicNiT8TSBFWBlp4w3qYCuNM2Aa8UY7g7GIX2G8huJF8hkYZ
	 IQebnqXq+UMAdJFnzolkYrV595hm44qxelyCy+/nC7nAzwgk7scxn6F6+sedem3Emu
	 kHanEk+gNwWT+Y8uV72AbEo461zHHSIUQdSimmySqJO+wTSRIiTY8/EPrS9biMyhX0
	 N9AN1SLjHCK0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xu Yang <xu.yang_2@nxp.com>,
	Peter Chen <peter.chen@kernel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	peter.chen@kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 2/5] usb: chipidea: udc: handle USB Error Interrupt if IOC not set
Date: Wed,  4 Dec 2024 17:19:18 -0500
Message-ID: <20241204221925.2248843-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221925.2248843-1-sashal@kernel.org>
References: <20241204221925.2248843-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
Content-Transfer-Encoding: 8bit

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit 548f48b66c0c5d4b9795a55f304b7298cde2a025 ]

As per USBSTS register description about UEI:

  When completion of a USB transaction results in an error condition, this
  bit is set by the Host/Device Controller. This bit is set along with the
  USBINT bit, if the TD on which the error interrupt occurred also had its
  interrupt on complete (IOC) bit set.

UI is set only when IOC set. Add checking UEI to fix miss call
isr_tr_complete_handler() when IOC have not set and transfer error happen.

Acked-by: Peter Chen <peter.chen@kernel.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Link: https://lore.kernel.org/r/20240926022906.473319-1-xu.yang_2@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/chipidea/udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index d3be658768a9a..3e4aabbe00aae 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -2178,7 +2178,7 @@ static irqreturn_t udc_irq(struct ci_hdrc *ci)
 			}
 		}
 
-		if (USBi_UI  & intr)
+		if ((USBi_UI | USBi_UEI) & intr)
 			isr_tr_complete_handler(ci);
 
 		if ((USBi_SLI & intr) && !(ci->suspended)) {
-- 
2.43.0


