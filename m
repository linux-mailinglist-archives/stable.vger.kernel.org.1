Return-Path: <stable+bounces-172633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD456B329C7
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 17:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F7449E70C2
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 15:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4358A78F4B;
	Sat, 23 Aug 2025 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5r/KggS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022D7170A11
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755963927; cv=none; b=NRxGg/+lfP7wGKCsb5jUuJwVhM0MaCYuzcH58mjjfGgc1Qw8X34DDht4Xw3gI4qRhgZepTCoo0aWzlcu1TTSpAJ0V2wQCwJI8tpTfmtBEDFyIrLmm2ijh7OuIIbLJ+sniyTI8ZZIsq9Atd5qMw6/BWKSDySW4uKhCkapIrbVWrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755963927; c=relaxed/simple;
	bh=UEP5VKhIEuvtPaM3JpV81MOpOS5jCl8ANuN/hEoAByE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpgaBQr9rlEh16YbrUoYsXF8fip57WhQ7cfXdOmP27CTccH8W+t+jUUj0vg6vMZigyvr+DqXNBfpghh/E3/Um+EVuQc8VSRRgcbK0oicQPDOPS/7aoZOztcQb5qFXXKVMOeh5KDY4PjVhJPMAeMtiijc5ai5AwBVyKSLciCDJ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5r/KggS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DF5C116B1;
	Sat, 23 Aug 2025 15:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755963926;
	bh=UEP5VKhIEuvtPaM3JpV81MOpOS5jCl8ANuN/hEoAByE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X5r/KggSbekwbG9LsUiWZLGAbx6EVdYB0HeamZkfk2r3FmzYcnFYJ9lLzzx4hkbTz
	 vQE7L250Fh7306UKsl3J5JeqWL5A9mKrSNZngk61YfQasv6ZzChKZvwfVyDawHfkge
	 Gchioj7H8JTPftgfzIxXb/m1EBLxAADVWsmL2PPXKAGdN8Kf6z519M2ezvYV31f1r0
	 MEP3+MwzWq0b75nAxv8tolmGjQ/DF0apawWBGyvi9n0JktlVxY5mHD5+f/R/er+iUL
	 xxatKcmtDo0GZhVRmb9KTUaqe303ZiPx7HQOYFmKJAmA7pS1NMz08jAkLdjYhd+vXt
	 2wbwAXemNg43w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Victor Shih <victor.shih@genesyslogic.com.tw>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] mmc: sdhci-pci-gli: GL9763e: Mask the replay timer timeout of AER
Date: Sat, 23 Aug 2025 11:45:22 -0400
Message-ID: <20250823154522.2285870-3-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823154522.2285870-1-sashal@kernel.org>
References: <2025082238-bullring-fantasy-07b7@gregkh>
 <20250823154522.2285870-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

[ Upstream commit 340be332e420ed37d15d4169a1b4174e912ad6cb ]

Due to a flaw in the hardware design, the GL9763e replay timer frequently
times out when ASPM is enabled. As a result, the warning messages will
often appear in the system log when the system accesses the GL9763e
PCI config. Therefore, the replay timer timeout must be masked.

Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Fixes: 1ae1d2d6e555 ("mmc: sdhci-pci-gli: Add Genesys Logic GL9763E support")
Cc: stable@vger.kernel.org
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20250731065752.450231-4-victorshihgli@gmail.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-pci-gli.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 02cde1b87a44..13e02ed5a114 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -1376,6 +1376,9 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
 	value |= FIELD_PREP(GLI_9763E_HS400_RXDLY, GLI_9763E_HS400_RXDLY_5);
 	pci_write_config_dword(pdev, PCIE_GLI_9763E_CLKRXDLY, value);
 
+	/* mask the replay timer timeout of AER */
+	sdhci_gli_mask_replay_timer_timeout(pdev);
+
 	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
 	value &= ~GLI_9763E_VHS_REV;
 	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
-- 
2.50.1


