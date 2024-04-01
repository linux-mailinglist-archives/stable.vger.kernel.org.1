Return-Path: <stable+bounces-35112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3B2894277
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E4501C21B3A
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DC748781;
	Mon,  1 Apr 2024 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qO3UQSVg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934BD63E;
	Mon,  1 Apr 2024 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990371; cv=none; b=u1XbQvzusfXPs69MFZvupSauE+/eEQy1Lf+cguVGiFPHpC2LIgn4h7hNXg4dkKvKe/fOaUg1jvyY0i2jkEYUYbsnlxrNlLid3Ne1Rc3mgjiJVmvtpe1Ff4WtZa5OtS17Ek/QsjJzxJ7HVXyfSVstDsMJjW4O2KvHsGatRxjGcuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990371; c=relaxed/simple;
	bh=TcohJ/P/XQ0XnFjJSJAP2IbEEJdBG3SlQi4lPX3kY2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cr9ST4z+lA6xElk9o9UxbCi1/+EkiykcPakGysBJ06J37Unz1W3lf1ih+k0avaEM32eM24b8Zbw85QS4wWYAeBci9E00iyHVRiJOO92tzKcp9HUBHY3K++K9QRl+o5boLxxDIv1hGIwUql4ob1DPl3PDHa53IBjdU9YQkdPGkF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qO3UQSVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0593AC433C7;
	Mon,  1 Apr 2024 16:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711990371;
	bh=TcohJ/P/XQ0XnFjJSJAP2IbEEJdBG3SlQi4lPX3kY2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qO3UQSVgN2E90Ey08WYZoUd14SXVAOPgGH+UYlWJs4MK9qrQyT3I6EtLfnsDvXB/Q
	 IiJ9Rz2xoWpnGGY09r+dm+tvVmJYUeD/LViv0BAxStrCL4UY4cfR+eQVt0RIpxx45P
	 To/kTgoaEdbFgAwIzbFNH5SuYHMZKwb3r5IZqOdw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Romain Naour <romain.naour@skf.com>,
	Tony Lindgren <tony@atomide.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.6 331/396] mmc: sdhci-omap: re-tuning is needed after a pm transition to support emmc HS200 mode
Date: Mon,  1 Apr 2024 17:46:20 +0200
Message-ID: <20240401152557.783370067@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Romain Naour <romain.naour@skf.com>

commit f9e2a5b00a35f2c064dc679808bc8db5cc779ed6 upstream.

"PM runtime functions" was been added in sdhci-omap driver in commit
f433e8aac6b9 ("mmc: sdhci-omap: Implement PM runtime functions") along
with "card power off and enable aggressive PM" in commit 3edf588e7fe0
("mmc: sdhci-omap: Allow SDIO card power off and enable aggressive PM").

Since then, the sdhci-omap driver doesn't work using mmc-hs200 mode
due to the tuning values being lost during a pm transition.

As for the sdhci_am654 driver, request a new tuning sequence before
suspend (sdhci_omap_runtime_suspend()), otherwise the device will
trigger cache flush error:

  mmc1: cache flush error -110 (ETIMEDOUT)
  mmc1: error -110 doing aggressive suspend

followed by I/O errors produced by fdisk -l /dev/mmcblk1boot1:

  I/O error, dev mmcblk1boot0, sector 64384 op 0x0:(READ) flags 0x80700 phys_seg 1
  prio class 2
  I/O error, dev mmcblk1boot1, sector 64384 op 0x0:(READ) flags 0x80700 phys_seg 1
  prio class 2
  I/O error, dev mmcblk1boot1, sector 64384 op 0x0:(READ) flags 0x0 phys_seg 1
  prio class 2
  Buffer I/O error on dev mmcblk1boot1, logical block 8048, async page read
  I/O error, dev mmcblk1boot0, sector 64384 op 0x0:(READ) flags 0x0 phys_seg 1
  prio class 2
  Buffer I/O error on dev mmcblk1boot0, logical block 8048, async page read

Don't re-tune if auto retuning is supported in HW (when SDHCI_TUNING_MODE_3
is available).

Link: https://lore.kernel.org/all/2e5f1997-564c-44e4-b357-6343e0dae7ab@smile.fr
Fixes: f433e8aac6b9 ("mmc: sdhci-omap: Implement PM runtime functions")
Signed-off-by: Romain Naour <romain.naour@skf.com>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240315234444.816978-1-romain.naour@smile.fr
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sdhci-omap.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -1439,6 +1439,9 @@ static int __maybe_unused sdhci_omap_run
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
 
+	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
+		mmc_retune_needed(host->mmc);
+
 	if (omap_host->con != -EINVAL)
 		sdhci_runtime_suspend_host(host);
 



