Return-Path: <stable+bounces-98663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3FD9E49BC
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6851881A69
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9009C21C19F;
	Wed,  4 Dec 2024 23:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUuBrN2I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC9821C197;
	Wed,  4 Dec 2024 23:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733355064; cv=none; b=RKDBv9l1rXq5z9pucK8BewlF77miR+RA9QLx9OMuc4UvB7wct4AaES1qRJDL66sF4i5U3shgyPMZMsaM3HL6UhCPl09+SKIKSfDdl/JWU5j4S2kjI1l4Q7c5lfgjkrJALEkET1X0PRLRcUALgVSt6XaX0JjIO8Su6dS14CVQ82o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733355064; c=relaxed/simple;
	bh=MtmmaDHTRIfdmf82yH0QeEF5vBpIgJeydco6WJ1CTSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cs6ksVOGPAs2bsSsBufXeBSWvTRLaLaNKROfoj9i+oysQJ55ITxmwOjOyrzRsZcpal6T6NgH2UKAgbK7O3ttNoE+H9SiaAXx1qX40wMOjtLVBz1ndvrnOO+wNeduY5Oad+S9wJZG60nKSjiwFIycJU7+1gJQcWigS31uF4WSlys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUuBrN2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC691C4CED2;
	Wed,  4 Dec 2024 23:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733355063;
	bh=MtmmaDHTRIfdmf82yH0QeEF5vBpIgJeydco6WJ1CTSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GUuBrN2IYCWxmIlo1CM1zntZgRnn800xla/+0+IEL/Pa1Hz5YdJ6AlpQJtpdXdGXh
	 zRFP5PfrIZdSHnrTnZQxxChgCYWitxvrC2r5OJzosfBvx8SW9oqLojLGaDVczZecT7
	 CVQxyd8rhTSx9I6M01POeqoX3Z5zE85sYZYx10705P1BNAsTpuUXo9K06IkxyJwi4A
	 GgrqTkRHEWRlWahi2Rq7z3hytEEbmv0Xf0cWfbwqXCTZvZmVjiCjLWuSwWJQsH9sD0
	 RrW4+mNgIOF/42+bqEFll/evA9J8036JejXGgCwBY9bTc5MwUddMP2Mjg9IeTx5k5s
	 btu8Y0AEuq4bw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xu Yang <xu.yang_2@nxp.com>,
	Peter Chen <peter.chen@kernel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	peter.chen@kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 2/5] usb: chipidea: udc: handle USB Error Interrupt if IOC not set
Date: Wed,  4 Dec 2024 17:19:35 -0500
Message-ID: <20241204221942.2248973-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221942.2248973-1-sashal@kernel.org>
References: <20241204221942.2248973-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
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
index f4661f654af88..a61721459ff51 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -2172,7 +2172,7 @@ static irqreturn_t udc_irq(struct ci_hdrc *ci)
 			}
 		}
 
-		if (USBi_UI  & intr)
+		if ((USBi_UI | USBi_UEI) & intr)
 			isr_tr_complete_handler(ci);
 
 		if ((USBi_SLI & intr) && !(ci->suspended)) {
-- 
2.43.0


