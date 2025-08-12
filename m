Return-Path: <stable+bounces-167395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7927DB22FE3
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732B7566524
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980972FDC24;
	Tue, 12 Aug 2025 17:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sn3IxHQN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5519C2FDC2B;
	Tue, 12 Aug 2025 17:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020673; cv=none; b=FsgYWokx62D5NWYrMNvXmb8gBV4g5pTo9JKn95TBViKoiD+jvmuSiTExRiQSp2w4ykcypH/izxLwJx3MnWXQyMR88yRG6smerNnxgkqZMiW8MokAXjt01e4wOsq/zuYnjcb2vMuHxYjhu3VxbLw7yRg7DTJ0AGRcp5Dhwj5/hPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020673; c=relaxed/simple;
	bh=Pj8HLD354kpG+m5GpE3aut9MZFjV2Z8yWT2a4u8wZO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8HJSylikV+zXaiGQY8S47syjCRW1qCKJtxHiV/eg/4/0E83klyFcBugXVqK6K1UeRvwupPTAWuUsbKlkhLlDVaZXTR/eEL4+to3kR6JaKDRwxBGqPkZgPejnzfELNdSUt6OoWc9+Cbpu1Hgh0CeMa4RvIpTIQc/CD/FnyEMMiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sn3IxHQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9216C4CEF0;
	Tue, 12 Aug 2025 17:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755020673;
	bh=Pj8HLD354kpG+m5GpE3aut9MZFjV2Z8yWT2a4u8wZO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sn3IxHQNVF7lhn/xRq4Ht4UO6HSD+8918bOGYa7KZB1ncTtn360q1bjdxYQbUZSxk
	 4CN8Waf5BhImqxvyWk+e3S0P0BH5mesw6iGL7mNaAvn6ILkWTSzQ2fhVGo6hv8AADw
	 dhl2N6L3tv8T+/mHevgoIPj22knSvOMMdx03eeik=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jerome Brunet <jbrunet@baylibre.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 149/253] PCI: endpoint: pci-epf-vntb: Return -ENOENT if pci_epc_get_next_free_bar() fails
Date: Tue, 12 Aug 2025 19:28:57 +0200
Message-ID: <20250812172955.051298143@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172948.675299901@linuxfoundation.org>
References: <20250812172948.675299901@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 7ea488cce73263231662e426639dd3e836537068 ]

According the function documentation of epf_ntb_init_epc_bar(), the
function should return an error code on error. However, it returns -1 when
no BAR is available i.e., when pci_epc_get_next_free_bar() fails.

Return -ENOENT instead.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
[mani: changed err code to -ENOENT]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20250603-pci-vntb-bar-mapping-v2-1-fc685a22ad28@baylibre.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 6708d2e789cb..4ed0859e2397 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -714,7 +714,7 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
 		barno = pci_epc_get_next_free_bar(epc_features, barno);
 		if (barno < 0) {
 			dev_err(dev, "Fail to get NTB function BAR\n");
-			return barno;
+			return -ENOENT;
 		}
 		ntb->epf_ntb_bar[bar] = barno;
 	}
-- 
2.39.5




