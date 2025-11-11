Return-Path: <stable+bounces-194183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC48C4AE86
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE72D18977B7
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB2526A1B6;
	Tue, 11 Nov 2025 01:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ifz5YxG+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5C32DC78C;
	Tue, 11 Nov 2025 01:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762825000; cv=none; b=KSQH5Y+Eg4XEy/cNSiBMe9WIbbsWY8zADhnWo7mk7m1JE+BZGqT0G50BGZJFfhYjt+AdD2TSM1rJGM5hRx5Nn9aC1Hz500jen0Tn/rXaEO+gxchfyitoGmIC+fgAXTl4ZVgvHcHOHZMN85K8QYFFFf+qoXwzxtAua4qC3UjT5tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762825000; c=relaxed/simple;
	bh=mcVIhgioLLECD1u/wcX/J0dRFlDx+9bRq48FC2QSWZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDw9XZJxJPnUKHr5T2w3WEa2Daril5BruhRixZMYIuDS1SmT2areKvOQcbk2+1gJyYri6DJtstf4j/CbzHajeuy242EHREa2/6hZkIAVMQW8EKVFObiCUjy7KFPXWEKAvg7iytynQnA3MmbHNayC10qvIkSy/NwooqIUDekxrCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ifz5YxG+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5998DC2BC86;
	Tue, 11 Nov 2025 01:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762825000;
	bh=mcVIhgioLLECD1u/wcX/J0dRFlDx+9bRq48FC2QSWZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ifz5YxG+faBxI2cXw6eEHLpSLYsel+yIDdgI9Iz5aNxUiUoBmKEgRE/gJ5TCM7Jvm
	 wEwejWlQ5PlvC5pCNeT7n3MGSRHMaoUkl+BrMh3JjJfm5aIilV8Zlz2fc8XKjdw+U7
	 XjCr0qewmVNu/CtPA71cbm/zYxqGHVkidDOV2Xlg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lukas Wunner <lukas@wunner.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 613/849] PCI/PM: Skip resuming to D0 if device is disconnected
Date: Tue, 11 Nov 2025 09:43:03 +0900
Message-ID: <20251111004551.244516915@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 299fad4133677b845ce962f78c9cf75bded63f61 ]

When a device is surprise-removed (e.g., due to a dock unplug), the PCI
core unconfigures all downstream devices and sets their error state to
pci_channel_io_perm_failure. This marks them as disconnected via
pci_dev_is_disconnected().

During device removal, the runtime PM framework may attempt to resume the
device to D0 via pm_runtime_get_sync(), which calls into pci_power_up().
Since the device is already disconnected, this resume attempt is
unnecessary and results in a predictable errors like this, typically when
undocking from a TBT3 or USB4 dock with PCIe tunneling:

  pci 0000:01:00.0: Unable to change power state from D3cold to D0, device inaccessible

Avoid powering up disconnected devices by checking their status early in
pci_power_up() and returning -EIO.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
[bhelgaas: add typical message]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Link: https://patch.msgid.link/20250909031916.4143121-1-superm1@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 005b92e6585e9..372de7961d2a6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1374,6 +1374,11 @@ int pci_power_up(struct pci_dev *dev)
 		return -EIO;
 	}
 
+	if (pci_dev_is_disconnected(dev)) {
+		dev->current_state = PCI_D3cold;
+		return -EIO;
+	}
+
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 	if (PCI_POSSIBLE_ERROR(pmcsr)) {
 		pci_err(dev, "Unable to change power state from %s to D0, device inaccessible\n",
-- 
2.51.0




