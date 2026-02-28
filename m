Return-Path: <stable+bounces-220596-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HtpMwJQo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220596-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:28:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4637B1C8619
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 486AC33250C9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BED3E1537;
	Sat, 28 Feb 2026 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4x9H+Hl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DEA3E1530;
	Sat, 28 Feb 2026 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300479; cv=none; b=GCxOgGtjQa7YNgWiPpQHScfNYRUAk/ilbTuPtoHTYZFQHkuViWCigZ22/ALRh6Qt7aUewj6uYJ3eDYahxKyIX5ZgZ/1zNlc/2ko9FzPVsdg/IY7sB8kMiSb4C1CqehewwOJuyo5bv9WLMELFuBr4zL5czOmkjP56tpNoHxQGe6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300479; c=relaxed/simple;
	bh=tamOyq6IAL5SDbOHCmqS4c8s5kRsFwFTV/XBNSIvxJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iIrsfkhwl9IoTgq2L8hM22pod8RzEidkjfsLPl3LAdAR8zmQt4dOQy/X9qBJeHJ78vv8tuzyosgw+X7QBDLbPnTD1YD/iHLSqEZ/KV59ayQBHRg110/YKwfK9bG8EHD+FUZA1LR4JOs1OcVIu9VHBvKEFCYbtWbSmCFVCgx28iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4x9H+Hl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8285C116D0;
	Sat, 28 Feb 2026 17:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300479;
	bh=tamOyq6IAL5SDbOHCmqS4c8s5kRsFwFTV/XBNSIvxJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y4x9H+Hlp4a36FQlrjYkvNSDIxJw5D05NOI70NKXHfv9aM/F08Y25847CXQ8H4AhQ
	 cKqK6ozLYQdIK8ocYzO5lviygupPa8hoxkJAn6TuY/fbuIfgVljluAatOxO6ZBGpe+
	 CsnrX9yM66kBCUztvUVrO90WxxNoC02WIahdTp9LAvyEldsGwDmqysFgoagY9VopMl
	 /SJGhCsR3opNRC7QVtBJZ+WvVY334Fhr6JxukCicxitTp78ctRRp1gshFZOPxYNt3i
	 6hGj+CZh/IZmuT1RBAMb6Fgda/EkcNuzk7KdlmD8rC4eojDcecBU/fnv9/ynlHfxJF
	 2PCz+4syFSyQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	kernel test robot <lkp@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 517/844] PCI: j721e: Add config guards for Cadence Host and Endpoint library APIs
Date: Sat, 28 Feb 2026 12:27:10 -0500
Message-ID: <20260228173244.1509663-518-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220596-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,msgid.link:url,intel.com:email,arndb.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4637B1C8619
X-Rspamd-Action: no action

From: Siddharth Vadapalli <s-vadapalli@ti.com>

[ Upstream commit 4b361b1e92be255ff923453fe8db74086cc7cf66 ]

Commit under Fixes enabled loadable module support for the driver under
the assumption that it shall be the sole user of the Cadence Host and
Endpoint library APIs. This assumption guarantees that we won't end up
in a case where the driver is built-in and the library support is built
as a loadable module.

With the introduction of [1], this assumption is no longer valid. The
SG2042 driver could be built as a loadable module, implying that the
Cadence Host library is also selected as a loadable module. However, the
pci-j721e.c driver could be built-in as indicated by CONFIG_PCI_J721E=y
due to which the Cadence Endpoint library is built-in. Despite the
library drivers being built as specified by their respective consumers,
since the 'pci-j721e.c' driver has references to the Cadence Host
library APIs as well, we run into a build error as reported at [0].

Fix this by adding config guards as a temporary workaround. The proper
fix is to split the 'pci-j721e.c' driver into independent Host and
Endpoint drivers as aligned at [2].

[0]: https://lore.kernel.org/r/202511111705.MZ7ls8Hm-lkp@intel.com/
[1]: commit 1c72774df028 ("PCI: sg2042: Add Sophgo SG2042 PCIe driver")
[2]: https://lore.kernel.org/r/37f6f8ce-12b2-44ee-a94c-f21b29c98821@app.fastmail.com/

Fixes: a2790bf81f0f ("PCI: j721e: Add support to build as a loadable module")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511111705.MZ7ls8Hm-lkp@intel.com/
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251117113246.1460644-1-s-vadapalli@ti.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/cadence/pci-j721e.c | 41 +++++++++++++---------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index ecd1b03124006..6f2501479c701 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -620,9 +620,11 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 			gpiod_set_value_cansleep(pcie->reset_gpio, 1);
 		}
 
-		ret = cdns_pcie_host_setup(rc);
-		if (ret < 0)
-			goto err_pcie_setup;
+		if (IS_ENABLED(CONFIG_PCI_J721E_HOST)) {
+			ret = cdns_pcie_host_setup(rc);
+			if (ret < 0)
+				goto err_pcie_setup;
+		}
 
 		break;
 	case PCI_MODE_EP:
@@ -632,9 +634,11 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 			goto err_get_sync;
 		}
 
-		ret = cdns_pcie_ep_setup(ep);
-		if (ret < 0)
-			goto err_pcie_setup;
+		if (IS_ENABLED(CONFIG_PCI_J721E_EP)) {
+			ret = cdns_pcie_ep_setup(ep);
+			if (ret < 0)
+				goto err_pcie_setup;
+		}
 
 		break;
 	}
@@ -659,10 +663,11 @@ static void j721e_pcie_remove(struct platform_device *pdev)
 	struct cdns_pcie_ep *ep;
 	struct cdns_pcie_rc *rc;
 
-	if (pcie->mode == PCI_MODE_RC) {
+	if (IS_ENABLED(CONFIG_PCI_J721E_HOST) &&
+	    pcie->mode == PCI_MODE_RC) {
 		rc = container_of(cdns_pcie, struct cdns_pcie_rc, pcie);
 		cdns_pcie_host_disable(rc);
-	} else {
+	} else if (IS_ENABLED(CONFIG_PCI_J721E_EP)) {
 		ep = container_of(cdns_pcie, struct cdns_pcie_ep, pcie);
 		cdns_pcie_ep_disable(ep);
 	}
@@ -728,10 +733,12 @@ static int j721e_pcie_resume_noirq(struct device *dev)
 			gpiod_set_value_cansleep(pcie->reset_gpio, 1);
 		}
 
-		ret = cdns_pcie_host_link_setup(rc);
-		if (ret < 0) {
-			clk_disable_unprepare(pcie->refclk);
-			return ret;
+		if (IS_ENABLED(CONFIG_PCI_J721E_HOST)) {
+			ret = cdns_pcie_host_link_setup(rc);
+			if (ret < 0) {
+				clk_disable_unprepare(pcie->refclk);
+				return ret;
+			}
 		}
 
 		/*
@@ -741,10 +748,12 @@ static int j721e_pcie_resume_noirq(struct device *dev)
 		for (enum cdns_pcie_rp_bar bar = RP_BAR0; bar <= RP_NO_BAR; bar++)
 			rc->avail_ib_bar[bar] = true;
 
-		ret = cdns_pcie_host_init(rc);
-		if (ret) {
-			clk_disable_unprepare(pcie->refclk);
-			return ret;
+		if (IS_ENABLED(CONFIG_PCI_J721E_HOST)) {
+			ret = cdns_pcie_host_init(rc);
+			if (ret) {
+				clk_disable_unprepare(pcie->refclk);
+				return ret;
+			}
 		}
 	}
 
-- 
2.51.0


