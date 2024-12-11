Return-Path: <stable+bounces-100794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A06D9ED648
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 20:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6422B166218
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153CB229679;
	Wed, 11 Dec 2024 19:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v4UvhPJ8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+kqHi9v2"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A2622967B;
	Wed, 11 Dec 2024 19:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733944195; cv=none; b=ePrHtaK5V/4/anBS1ArIz53R6x88EWuoou4QR7OLEwVC80zoopLoXXOcwQdADfiVkfJ2uOQzj9eOd+UXmB82SVr7bMWTn46GBT+n54c56DZxtFSZMpD1YKm6SmVjhEMySJDX3byKvhrRJvPHJED1xlVAehrVNb+6fXO2Q538kD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733944195; c=relaxed/simple;
	bh=fbKSBCXDQ28E2CfsKp+Or2O8tMFqjNl7NFPC3q3CSic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aqtKxmVmFcaOWimJoEBdzVtMqabreoJjm9kkDHlSXbUtr4Kw0h7CITo8rWxDlAdk+oKSbNBzEmtW+Gpw2q+4LXglJ7wVNAjfyFaQOQrRw8cr1PbsmQVjp5u8z1NED3P8BnkTG0Hsvy6SMn8CyA1wwHOXhbN6LA55/paEuOvk3u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v4UvhPJ8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+kqHi9v2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733944192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AJ20WA4RENjX72+w15ihHkYB1Qza68jvm2S2HSHhGyk=;
	b=v4UvhPJ8ROHeky8DGffTuHk5MLNZYpQFH4hBfRJIOREZhQsyf4eq8YKzBWueYp+pyVrJNs
	/Thxo7z4TpArWIE9nrbPyrSNhyJVcWg4KsKwVTzajYxF12ebBUSoaRxmhZGFtKAYi/yRZo
	N2q17m1XkE1dzsNFoKTjJzNkljYtRfLSRpES/9EpGDHS5lzQ/OqG3Fo5lDBJxB4Yf4j3M5
	0SfGx9sU0XCoJSkdBy6aLrrkWkEI1fUnQSyKZ9LqD4LisjPzd/Q/YDZAR812yl/rI3xRsh
	ys0RGSUYnrnhYe+ACY8uE4AfqtS6LOph594+kCkyErPd3sc3fROzZ0nGpUVFBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733944192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AJ20WA4RENjX72+w15ihHkYB1Qza68jvm2S2HSHhGyk=;
	b=+kqHi9v27SPL+JQPbOYMQ+apc9xmtEortl3tQWX2EJqzobygZVOX54BRXRPObjnWXgb7sS
	WyDf6oDRqaW1PTDw==
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 6.6.y] scsi: ufs: qcom: Only free platform MSIs when ESI is
 enabled
In-Reply-To: <20241211183908.3808070-1-sashal@kernel.org>
References: <20241211183908.3808070-1-sashal@kernel.org>
Date: Wed, 11 Dec 2024 20:09:51 +0100
Message-ID: <8734iuaveo.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


From: Manivannan Sadhasivam <mani@kernel.org>

commit 64506b3d23a337e98a74b18dcb10c8619365f2bd upstream.

Otherwise, it will result in a NULL pointer dereference as below:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
Call trace:
 mutex_lock+0xc/0x54
 platform_device_msi_free_irqs_all+0x14/0x20
 ufs_qcom_remove+0x34/0x48 [ufs_qcom]
 platform_remove+0x28/0x44
 device_remove+0x4c/0x80
 device_release_driver_internal+0xd8/0x178
 driver_detach+0x50/0x9c
 bus_remove_driver+0x6c/0xbc
 driver_unregister+0x30/0x60
 platform_driver_unregister+0x14/0x20
 ufs_qcom_pltform_exit+0x18/0xb94 [ufs_qcom]
 __arm64_sys_delete_module+0x180/0x260
 invoke_syscall+0x44/0x100
 el0_svc_common.constprop.0+0xc0/0xe0
 do_el0_svc+0x1c/0x28
 el0_svc+0x34/0xdc
 el0t_64_sync_handler+0xc0/0xc4
 el0t_64_sync+0x190/0x194

Cc: stable@vger.kernel.org # 6.3
Fixes: 519b6274a777 ("scsi: ufs: qcom: Add MCQ ESI config vendor specific ops")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20241111-ufs_bug_fix-v1-2-45ad8b62f02e@linaro.org
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/ufs/host/ufs-qcom.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1926,7 +1926,8 @@ static int ufs_qcom_remove(struct platfo
 
 	pm_runtime_get_sync(&(pdev)->dev);
 	ufshcd_remove(hba);
-	platform_msi_domain_free_irqs(hba->dev);
+	if (host->esi_enabled)
+		platform_msi_domain_free_irqs(hba->dev);
 	return 0;
 }
 

