Return-Path: <stable+bounces-98612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC889E4926
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD6916AC44
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4C2207E10;
	Wed,  4 Dec 2024 23:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxLvUZmw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D78207E08;
	Wed,  4 Dec 2024 23:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354872; cv=none; b=n4xPcBJAv0jf/O2aMM3zLsJR6CWV7pCM/G31nZ0LJMc1W+ecxg/5x/AL3MLU2cmSWlaOyrgLPzG2xuB4vUU3uACTj9ZqMohLIXU9AzRerM5+zJNlTHq4a6bORgpDhMRLSu88gmlhrRk2pP2LV7QlW2436r6d1QIekjmwvzV5DHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354872; c=relaxed/simple;
	bh=aMyVwZKE/J+HTyLBtwcw66qT0e9TcG3WljKc+1MM2Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ttyoWBbfbH+G9KHUsCSRS/4teu6VdVRhPuSAVa2FIZRG+I7p8T5qSNgfw0IbrC3AwIkCqCSV5uKQbFCULR0pAwAXYKE485Lvm9LzLJCqtH2tb7x4GZzliHqDRkVhj8pKni/EnaH+K4FsaeW/Qi/gGgP0Tf2HHMon7MNIiIj3NE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxLvUZmw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2798BC4CECD;
	Wed,  4 Dec 2024 23:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354872;
	bh=aMyVwZKE/J+HTyLBtwcw66qT0e9TcG3WljKc+1MM2Ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sxLvUZmww+c4FY2M/cG/2Cqto6JVn+ObYV9ejWz4iYHEpvH39mWOtWPzALFlS8rtV
	 21D9pfmxGUUpWir1eh6fuy5M5Jc5q7W1Dt98LMQ9czWHk40vZkGfRfp+Ul888f89ua
	 wTW4YvdztKuK+yaKOwo3WGH1Iew+wp2uk5q6ecwNwSrP+NGnAoRppv1LiznGYGEbJi
	 i/FqZjA/CdWPaYsjfpS1bPzw7D8OY9GcFQPClBK5snQ/ZpQOOoNQvm5v56B/7u2DxU
	 fyPt3jmBKU0XGD9VOPKnYr6oGwwMQVvfsa7oMUzUMLAVaYmIRMbMe8ertLZFFd62PV
	 0V+t/fhWYhzXg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xu Yang <xu.yang_2@nxp.com>,
	Peter Chen <peter.chen@kernel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	peter.chen@kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 04/15] usb: chipidea: udc: handle USB Error Interrupt if IOC not set
Date: Wed,  4 Dec 2024 17:15:58 -0500
Message-ID: <20241204221627.2247598-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221627.2247598-1-sashal@kernel.org>
References: <20241204221627.2247598-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index f0fcaf2b1f334..fd6032874bf33 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -2217,7 +2217,7 @@ static irqreturn_t udc_irq(struct ci_hdrc *ci)
 			}
 		}
 
-		if (USBi_UI  & intr)
+		if ((USBi_UI | USBi_UEI) & intr)
 			isr_tr_complete_handler(ci);
 
 		if ((USBi_SLI & intr) && !(ci->suspended)) {
-- 
2.43.0


