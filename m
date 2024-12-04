Return-Path: <stable+bounces-98640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6809E4965
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6961D2825CE
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A4F217704;
	Wed,  4 Dec 2024 23:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBLDLIOz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C08207642;
	Wed,  4 Dec 2024 23:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354982; cv=none; b=NKdgj2VZxnSXo0U+3x+3b779qI1gOWtPYb+IA4Vd/WGqevk5Zyvk4DdNawwW7mKyy2XvSDfWpZwWl8MrATbuSnzlFEy7Ch/W0aKX9zOxIS3Pj37Ix6wSgBhEFuxzkzwPccwyxxsuZQSD2XkO/iSUWfAYWx2GaePQMvX5dREmoAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354982; c=relaxed/simple;
	bh=vJCBYZcwCfmMnJwgRtyilctCajM+/yvkF1lVPq6FGFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2fMif4XI42Mdl9pAqygUTUc0VUWc5RDNeTT02TPy1R7OrFz1XaPrn2Wt9KvAbL1RSrN9f5zBlXouR9UciNwJ9eEltGGGuz/ahAZHWsM00YKR1liQG9PW9XJEG6VbK4iEyLjpe9Y4uPUubuSlcjoo378FqZAkqBxlI5WizeOz2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBLDLIOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD20BC4CEDD;
	Wed,  4 Dec 2024 23:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354981;
	bh=vJCBYZcwCfmMnJwgRtyilctCajM+/yvkF1lVPq6FGFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YBLDLIOzOLkVHrQhfFYAoHRjl+h5RZQGDciFrJ2ha4lOaHbA5c0a+YUyfrfdYFtg1
	 rs0nuYQLtx3PpQK/bX2W0ArJDJNKq0Pb17Dqiyc+dk7D9FN2EQs/sRm8caXpG8I1r+
	 0dWNfb+ozW6wmXYUj23L5jS/XLmTextkMcN5ESGrwimvfUZmoumsEL603FoI5o8reu
	 jd+dH7ZNpH4dbMRmNsBm3XpOeM5e7udR9onkfB2fM1TewiV1WfaTSdUp8l7+EmYWaP
	 bQXIW13xxcxuRWGxFRoH4eWddrmTiE+Z9dtPkLKno5YVjZjfNCcY3DkEYT10LvCW6Q
	 YKGhVMGRGSCBA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xu Yang <xu.yang_2@nxp.com>,
	Peter Chen <peter.chen@kernel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	peter.chen@kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 02/10] usb: chipidea: udc: handle USB Error Interrupt if IOC not set
Date: Wed,  4 Dec 2024 17:18:00 -0500
Message-ID: <20241204221820.2248367-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221820.2248367-1-sashal@kernel.org>
References: <20241204221820.2248367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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
index bd409b18d01ba..969d0825583a9 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -2210,7 +2210,7 @@ static irqreturn_t udc_irq(struct ci_hdrc *ci)
 			}
 		}
 
-		if (USBi_UI  & intr)
+		if ((USBi_UI | USBi_UEI) & intr)
 			isr_tr_complete_handler(ci);
 
 		if ((USBi_SLI & intr) && !(ci->suspended)) {
-- 
2.43.0


