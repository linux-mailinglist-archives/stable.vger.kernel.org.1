Return-Path: <stable+bounces-98667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3807E9E49BF
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD8B916A6A6
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE9021D5A5;
	Wed,  4 Dec 2024 23:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzmS7xqh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774422066E6;
	Wed,  4 Dec 2024 23:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733355076; cv=none; b=AaUOHCcIErLELZtSEzl1z8K0OxNHRkPegRC9wtVpWe2iGjF+cA4nfUuTglXsKkTVWSBcuLdm13of9uoZk/QwtAZs6wslNyGrNBuEIpBrmL1VN8z/QyrbefuZ0vv7VhiTJeBFJG2K7V92zfy5eevr4RnlXQa8CBI9wcEoTTDrb7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733355076; c=relaxed/simple;
	bh=t302rgBs40X2Ptg2m/MeLtqyKK3rpeY7xBzyacpi6Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h9YZsmx0GOeHao19/fIiIIZFVTR6ZHlmSm/MponSCizhGsFf8li1un9ja6zV4kXTlx5OEQrwsU4AbLPiFYFpc0wNutE9E3ECE443awGwiwENHz6WU1lItgXP6980X7WmUDbTSW/vdRjOSAu1Kckp28IFMDqMB8Ucnccl3V1ADiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzmS7xqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6570AC4CECD;
	Wed,  4 Dec 2024 23:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733355076;
	bh=t302rgBs40X2Ptg2m/MeLtqyKK3rpeY7xBzyacpi6Qc=;
	h=From:To:Cc:Subject:Date:From;
	b=DzmS7xqh4eoelokB0VlgfwP7IXkSVsrxVlwbNtFUmTJn2aflrztugDd/qhMXdE0vB
	 vP0byCg2R8QT1/XAAkm+sPjka/K4zPy+k9FPQZUvQKSHcEhDObctitxfZLaYOl4vO4
	 Qz5yKmOmC1aNl1VjyS/MOzcfWG8I+bXgUoFo614C8HDf7X0cS5/EarTY5/bD8Nuf6M
	 +IK5OqHtAwbDhoBQODr/zeHSqx+NmqbCdxh7PhdLhlyhooLKPcOdl00eytOi0t8JoQ
	 eeiKPOu2ZVcEksJVhCVCI3tns8JN9ohoKLw4SRuXizsl9Aj97Mnf8hdCwaXyRQgidG
	 SyshBQ59gKlZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xu Yang <xu.yang_2@nxp.com>,
	Peter Chen <peter.chen@kernel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	peter.chen@kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 1/3] usb: chipidea: udc: handle USB Error Interrupt if IOC not set
Date: Wed,  4 Dec 2024 17:19:52 -0500
Message-ID: <20241204221956.2249103-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
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
index 72d62abb6f285..a6ce6b89b271a 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1902,7 +1902,7 @@ static irqreturn_t udc_irq(struct ci_hdrc *ci)
 			}
 		}
 
-		if (USBi_UI  & intr)
+		if ((USBi_UI | USBi_UEI) & intr)
 			isr_tr_complete_handler(ci);
 
 		if ((USBi_SLI & intr) && !(ci->suspended)) {
-- 
2.43.0


