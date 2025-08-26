Return-Path: <stable+bounces-175367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 090E0B367DC
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACB455809AF
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C633D350D75;
	Tue, 26 Aug 2025 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H1/BLPkz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CDB3314DF;
	Tue, 26 Aug 2025 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216850; cv=none; b=nPo1WghzDK27bWcb7LRQM2wWwm60l5gF9hZHFSGVGYAAayPnYKHshKCIlWu5Fa0DuvU5+sX+T4WZPL79omKaZSFcMtFEV4mxzkCGeFTHrbkDx+HLscBEzhmXTKwjsJ5Uwn3OhtEl/Gt/yJXkXMi22UlZqLrloFU+cuevj8Mc13U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216850; c=relaxed/simple;
	bh=cX69JnvKQWbvuJ2JfwM8unpzn33zr1fpG9nQY5+l+jY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jq1/URLMjZT2Hl2Hj3fG04lAW+Jd+qmLYP9ePzSzjYqgEETbvBwnCw5EepZOCnTUgfgxZ03M258OgyEVUUh1VaiQoFTNcmlW7j00WdTQV3BHPm4K2XpauJNti0JDG4N2y06uuOettuyyMzLb9SX6eKpgTQUeEY7TPF0gwh+aw9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H1/BLPkz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12848C4CEF1;
	Tue, 26 Aug 2025 14:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216850;
	bh=cX69JnvKQWbvuJ2JfwM8unpzn33zr1fpG9nQY5+l+jY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H1/BLPkzZ9u8iw2hwzALhbIwSJCeOeJDnhp9eKr/eeXDMrGGsXRb6xMEc9KQwqCjv
	 mtaKePd5f12Z+Ls9NZUXU6DR+xxbYg+NNCHvJOLWcKczhAkRWvNaYfBrnA7n/7ffwa
	 lDZLMmoFkH9HusPBZ6gq+NxcL9mJzOUZsdhfyP7Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.15 565/644] mmc: sdhci-pci-gli: GL9763e: Rename the gli_set_gl9763e() for consistency
Date: Tue, 26 Aug 2025 13:10:56 +0200
Message-ID: <20250826111000.532963533@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Victor Shih <victor.shih@genesyslogic.com.tw>

commit 293ed0f5f34e1e9df888456af4b0a021f57b5f54 upstream.

In preparation to fix replay timer timeout, rename the
gli_set_gl9763e() to gl9763e_hw_setting() for consistency.

Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Fixes: 1ae1d2d6e555 ("mmc: sdhci-pci-gli: Add Genesys Logic GL9763E support")
Cc: stable@vger.kernel.org
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20250731065752.450231-3-victorshihgli@gmail.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sdhci-pci-gli.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -860,7 +860,7 @@ static void sdhci_gl9763e_reset(struct s
 	sdhci_reset(host, mask);
 }
 
-static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
+static void gl9763e_hw_setting(struct sdhci_pci_slot *slot)
 {
 	struct pci_dev *pdev = slot->chip->pdev;
 	u32 value;
@@ -918,7 +918,7 @@ static int gli_probe_slot_gl9763e(struct
 	gli_pcie_enable_msi(slot);
 	host->mmc_host_ops.hs400_enhanced_strobe =
 					gl9763e_hs400_enhanced_strobe;
-	gli_set_gl9763e(slot);
+	gl9763e_hw_setting(slot);
 	sdhci_enable_v4_mode(host);
 
 	return 0;



