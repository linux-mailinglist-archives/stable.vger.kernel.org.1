Return-Path: <stable+bounces-163861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 758C7B0DC05
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 15:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6711717D6
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 13:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588052EA15A;
	Tue, 22 Jul 2025 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BZIZMtC5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B172DC32B;
	Tue, 22 Jul 2025 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192455; cv=none; b=k5+sV5ParhUMjtcP3iAulyAhn3c1qJKeRVOuSpxbMUpQYNSPA6ctM9HMgtzbHQZNweKqvkgAJxnhYLC173U1VZ0qTGMWy9aRvz6b45DZbSI3q5D6Pn7dyGz0dIhSVLoO1l/gtdPCNtU0LvJEN9cdQgrmSgOvu1oXeG4vqUr3mII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192455; c=relaxed/simple;
	bh=txQW336XZkINV/2mnFk8SMSBwjrDsGetJjJVyBIK5tU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PazBtPAidZj979hIjYYQnYOwVl2c1Okv2rOT39sbb/gYtwokL1ZB5MYhAtRHU2WAFRZ9/F2g5+U+eDWmHxAImbXfqlhGXhlGFaDkbfUpwFXjoqjTrCekdzT9QPaKvlqHl1JYUtvItip4XA44ujs+NsnAF6+L0MlCitIjPG2yIeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BZIZMtC5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754AFC4CEEB;
	Tue, 22 Jul 2025 13:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753192455;
	bh=txQW336XZkINV/2mnFk8SMSBwjrDsGetJjJVyBIK5tU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BZIZMtC57CZqIz2li9JgGaddRWtXPY8aEmlmmQIJOkH19vmZMJLNAW33D2TITXfRb
	 7wSSDPwxWxVEjUzQjHm+EwNxgb/kxfLEfKYtwIVtcv52DxRGibXGixtNzucb7kstiH
	 neHB081pymTJg0wYM7zijc6gYE7sOXQTzwxpaEi8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Edson Juliano Drosdeck <edson.drosdeck@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.6 037/111] mmc: sdhci-pci: Quirk for broken command queuing on Intel GLK-based Positivo models
Date: Tue, 22 Jul 2025 15:44:12 +0200
Message-ID: <20250722134334.784719552@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134333.375479548@linuxfoundation.org>
References: <20250722134333.375479548@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>

commit 50c78f398e92fafa1cbba3469c95fe04b2e4206d upstream.

Disable command queuing on Intel GLK-based Positivo models.

Without this quirk, CQE (Command Queuing Engine) causes instability
or I/O errors during operation. Disabling it ensures stable
operation on affected devices.

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
Fixes: bedf9fc01ff1 ("mmc: sdhci: Workaround broken command queuing on Intel GLK")
Cc: stable@vger.kernel.org
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20250626112442.9791-1-edson.drosdeck@gmail.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sdhci-pci-core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -911,7 +911,8 @@ static bool glk_broken_cqhci(struct sdhc
 {
 	return slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_GLK_EMMC &&
 	       (dmi_match(DMI_BIOS_VENDOR, "LENOVO") ||
-		dmi_match(DMI_SYS_VENDOR, "IRBIS"));
+		dmi_match(DMI_SYS_VENDOR, "IRBIS") ||
+		dmi_match(DMI_SYS_VENDOR, "Positivo Tecnologia SA"));
 }
 
 static bool jsl_broken_hs400es(struct sdhci_pci_slot *slot)



