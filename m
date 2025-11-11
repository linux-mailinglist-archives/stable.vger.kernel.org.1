Return-Path: <stable+bounces-193479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 293F2C4A629
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D99188F4E0
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037A0302143;
	Tue, 11 Nov 2025 01:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LvPSPWo0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A00248F6A;
	Tue, 11 Nov 2025 01:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823280; cv=none; b=FOVcZOHguqWawbiTgLIZxD9OTr87hfY/0cwRThRNkKQHkqS2DipU6opwPghmuFswY9Sgw7PmlpAstjGAN4XFSdFpeB8VqavrxIGNPL1LMJZQ3vPn+xFS8nUKeqQ+p/EMQXtQ+ramUWLJX5/5OhOdhENewpcpD4YLvQeuB7TNS44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823280; c=relaxed/simple;
	bh=AN4a+tzo1SKrgoYbO6d+famVGGWn9UrHIhDfD7aNHpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNWuN0fQEiSGf367wxEd5MMcm0hLV61/tWOJhqCDq+R4omK36Q4cOzylwo+1z2cmaJffkhZeP/l8PwCb8YfVwTXXW+WXhxRFNrgZ7c1V66XsMeDVYmDvoYMTfo0jum2pHGEUmHqQ0NVGXoprtMhFOQ/M7FdR2Rc4izaIJHxA4YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LvPSPWo0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269FCC4CEFB;
	Tue, 11 Nov 2025 01:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762823280;
	bh=AN4a+tzo1SKrgoYbO6d+famVGGWn9UrHIhDfD7aNHpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LvPSPWo0IlUWJvW7QihSxmZLo54sONSeY1yptrf8048Tlh1rsomwMFzwvBo//k4Pi
	 yPr8Vbl43bS2/BB7iwXN7ZcYK9D6/tyJ3/5jdlkNT+2xpbRZIBJNYKNnhYem8FrYjn
	 zG0Tv1hQMJa6EVVN9eYSTwA1bzrCjlzS2coeeL84=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lukas Wunner <lukas@wunner.de>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 211/565] powerpc/eeh: Use result of error_detected() in uevent
Date: Tue, 11 Nov 2025 09:41:07 +0900
Message-ID: <20251111004531.672729632@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004526.816196597@linuxfoundation.org>
References: <20251111004526.816196597@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Niklas Schnelle <schnelle@linux.ibm.com>

[ Upstream commit 704e5dd1c02371dfc7d22e1520102b197a3b628b ]

Ever since uevent support was added for AER and EEH with commit
856e1eb9bdd4 ("PCI/AER: Add uevents in AER and EEH error/resume"), it
reported PCI_ERS_RESULT_NONE as uevent when recovery begins.

Commit 7b42d97e99d3 ("PCI/ERR: Always report current recovery status for
udev") subsequently amended AER to report the actual return value of
error_detected().

Make the same change to EEH to align it with AER and s390.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Link: https://lore.kernel.org/linux-pci/aIp6LiKJor9KLVpv@wunner.de/
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Link: https://patch.msgid.link/20250807-add_err_uevents-v5-3-adf85b0620b0@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/eeh_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index dd50de91c4383..c73e4225e84a5 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -334,7 +334,7 @@ static enum pci_ers_result eeh_report_error(struct eeh_dev *edev,
 	rc = driver->err_handler->error_detected(pdev, pci_channel_io_frozen);
 
 	edev->in_error = true;
-	pci_uevent_ers(pdev, PCI_ERS_RESULT_NONE);
+	pci_uevent_ers(pdev, rc);
 	return rc;
 }
 
-- 
2.51.0




