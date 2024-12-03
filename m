Return-Path: <stable+bounces-97901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BD79E2615
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC18288D2C
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B351F76BF;
	Tue,  3 Dec 2024 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jAF/xSl3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BF374BE1;
	Tue,  3 Dec 2024 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242118; cv=none; b=s/oHFMaIHN3oaV/vRCGoB2qjmfEvaitBbEJ/Zu9pE4GW8J6f3+mFNLmWJTaLCn47HNCQVETBB3q4Y7B9tN+OlIQgjDeQo8mj5a8T1BGI08zhn7pAGLslWGSgRV5p05bOLZOZegwheHgVgBtt9Ul0gZIRkrnLbsTZZw/SpPRaPsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242118; c=relaxed/simple;
	bh=Mji3Pcb3nhTGeuFnMath+UwSCeKNBvF5NEg9/+ksy78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUI98O8KaO646fcOzB6ynwl66M/j++h6iP8vuxZGAfG4t4i7QtQb9XNezidhsqBaiTYYIKgFCwNOPcdmLvMiExkLXZPi26okCPTh/XPA2zdQvlWNESqqcJmy4pW+1s2YDsgUU0YwAXY0I6S0cd6FTQV8so7xPR2+1IiuHE6SDV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jAF/xSl3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E8AC4CECF;
	Tue,  3 Dec 2024 16:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733242118;
	bh=Mji3Pcb3nhTGeuFnMath+UwSCeKNBvF5NEg9/+ksy78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jAF/xSl3QC15OTPyOx6YRp40cLKZpBgN5ga4D902CYPWdUvUZFrtLLVlmuUaLwXGK
	 jTdP/jL+qS0smT2duzHIGbUwPTQf1nP6xeRWm8awnImD/yNqtg9eksAeAv4QcUiUV7
	 U7DPZ4r+ac9xxNhria5DPn0e13mgWNdJrl92weJg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Cochran <richardcochran@gmail.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 582/826] bnxt_en: Unregister PTP during PCI shutdown and suspend
Date: Tue,  3 Dec 2024 15:45:09 +0100
Message-ID: <20241203144806.452206914@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit 3661c05c54e8db7064aa96a0774654740974dffc ]

If we go through the PCI shutdown or suspend path, we shutdown the
NIC but PTP remains registered.  If the kernel continues to run for
a little bit, the periodic PTP .do_aux_work() function may be called
and it will read the PHC from the BAR register.  Since the device
has already been disabled, it will cause a PCIe completion timeout.
Fix it by calling bnxt_ptp_clear() in the PCI shutdown/suspend
handlers.  bnxt_ptp_clear() will unregister from PTP and
.do_aux_work() will be canceled.

In bnxt_resume(), we need to re-initialize PTP.

Fixes: a521c8a01d26 ("bnxt_en: Move bnxt_ptp_init() from bnxt_open() back to bnxt_init_one()")
Cc: Richard Cochran <richardcochran@gmail.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 015ad2b0bcd1c..3d9ee91e1f8be 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15999,6 +15999,7 @@ static void bnxt_shutdown(struct pci_dev *pdev)
 	if (netif_running(dev))
 		dev_close(dev);
 
+	bnxt_ptp_clear(bp);
 	bnxt_clear_int_mode(bp);
 	pci_disable_device(pdev);
 
@@ -16026,6 +16027,7 @@ static int bnxt_suspend(struct device *device)
 		rc = bnxt_close(dev);
 	}
 	bnxt_hwrm_func_drv_unrgtr(bp);
+	bnxt_ptp_clear(bp);
 	pci_disable_device(bp->pdev);
 	bnxt_free_ctx_mem(bp);
 	rtnl_unlock();
@@ -16069,6 +16071,10 @@ static int bnxt_resume(struct device *device)
 	if (bp->fw_crash_mem)
 		bnxt_hwrm_crash_dump_mem_cfg(bp);
 
+	if (bnxt_ptp_init(bp)) {
+		kfree(bp->ptp_cfg);
+		bp->ptp_cfg = NULL;
+	}
 	bnxt_get_wol_settings(bp);
 	if (netif_running(dev)) {
 		rc = bnxt_open(dev);
-- 
2.43.0




