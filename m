Return-Path: <stable+bounces-98670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7678A9E49C8
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A34316B10C
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFC5221477;
	Wed,  4 Dec 2024 23:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnFh/9Ix"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3555C202C54;
	Wed,  4 Dec 2024 23:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733355086; cv=none; b=orFiiPAGMPh7Ev758l2IMeHd2+MdxYCyHiQbVLplJZ1P13zDZ1V0P+xhhVokWFDuOBACvxbVLAIvOmuTkGecvPEO9VUbyyRQJd092kKJNDmq5GZ13wZlUfIU4XHZQae3oiWQVIAXlXzTFyf0+ohL59/pWuk9wMJFhl8bCmOIedk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733355086; c=relaxed/simple;
	bh=usj7+BpAioBWq1ukTSyPWCfNmAGcJKm5+IZrw+TQa8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZR2kstRirJ2vo05BjxQ1jHegIPQUcqW6m89pjk53aA8LoQEpRBfgCd1EgG/T/IcDwGXFJ6+xp628VYbCP6cc2ho0llJcsFn+jPYOrSB2siJz5vDSOBBAE6Fj0nmb95xlJXfklUBQv+VGnV0u4lJQFVCglfThrAT0iL50c6apOwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnFh/9Ix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C962C4CED2;
	Wed,  4 Dec 2024 23:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733355086;
	bh=usj7+BpAioBWq1ukTSyPWCfNmAGcJKm5+IZrw+TQa8E=;
	h=From:To:Cc:Subject:Date:From;
	b=UnFh/9IxfTu4ggowMaNwVD0AdW9guM7LlWn3cIttM+cbE2QdPD0FPUzoQ6opLk0gk
	 RR1mg2dybITIy+57w+ohBuqPHskbqJJJ9U1ECDixzgXiJ4cef4KRH5iz2UyN4MKM7/
	 EJJ8X7Qw8WwV9JuPil1v2j8KURJ7+fBq+MhL+JKnOLoLW4YnQG7quS6LREHHVKu1PO
	 rrrTnjDnsDlX8DQPfuU+66OMS14t4soE3w18U65ihOmefKfJRAs1dt1P16TQ+bye7K
	 rMjghpWi4vAdKrIGHISHZJ6n3alSHbHl9AIznzlIOQPqDMaOl2mqVUJ+uSpFdEuY81
	 wS7SXJKNAzUjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xu Yang <xu.yang_2@nxp.com>,
	Peter Chen <peter.chen@kernel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	peter.chen@kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 1/3] usb: chipidea: udc: handle USB Error Interrupt if IOC not set
Date: Wed,  4 Dec 2024 17:20:01 -0500
Message-ID: <20241204222006.2249186-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.324
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
index 6a626f41cded1..27be93d12b59c 100644
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


