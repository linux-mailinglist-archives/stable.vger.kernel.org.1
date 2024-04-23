Return-Path: <stable+bounces-41138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 877D68AFA76
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4871F295CD
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B64149DEC;
	Tue, 23 Apr 2024 21:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r3YBLKIa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5979A1420BE;
	Tue, 23 Apr 2024 21:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908703; cv=none; b=R3DXZuVWbHRt079T99e3BGgJZPD/PgU5y1jVAp0Gu5tgnUWezY9vnobdRLzwoc4fGnJHEldGJv9zZvWRlsz4Typ1pZWGewSoC5dLEwyuPMNAOJ9qHWvzHit301V5DKTdKamLot48/NCp/QoRY6pScG7iJByIXh19felrv0VdFXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908703; c=relaxed/simple;
	bh=j4ltxH9hS632REIZ9fYID9Y7WCaurUzOErmE5aolq10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oOwzAWmjxwu19BPrCONVE+hnxj7AF0u8LGCIFa1aNmDKOTFNAIBelhghzoNUzvu3hVv7C6qCH4AG5npsacnd849UQFo1lyGs9+2G2+l2wvS70YR1QL/DNlVLT/8P1+FkDnhg9yjQhxF2t1PcrwIBa4k6gIZF35EntJpOCOpGuwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r3YBLKIa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25209C116B1;
	Tue, 23 Apr 2024 21:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908703;
	bh=j4ltxH9hS632REIZ9fYID9Y7WCaurUzOErmE5aolq10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r3YBLKIatghesDtMXPVvd2OswD1XNv4b3kYv4nVebiIkFZdrxOFFtHXxtRZ6JOefv
	 8Qjjgvlps8ikra9+hNaCUNtmuiPHJ7p7GfoS2L2KY0gVtFIImjTxDoNKYS0VArCViq
	 XdwFQfxOOmHpmz8Njs/dh961FE1FyMeKMRET0XPE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 057/141] PCI: Avoid FLR for SolidRun SNET DPU rev 1
Date: Tue, 23 Apr 2024 14:38:45 -0700
Message-ID: <20240423213855.100233583@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213853.356988651@linuxfoundation.org>
References: <20240423213853.356988651@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alvaro Karsz <alvaro.karsz@solid-run.com>

[ Upstream commit d089d69cc1f824936eeaa4fa172f8fa1a0949eaa ]

This patch fixes a FLR bug on the SNET DPU rev 1 by setting the
PCI_DEV_FLAGS_NO_FLR_RESET flag.

As there is a quirk to avoid FLR (quirk_no_flr), I added a new quirk
to check the rev ID before calling to quirk_no_flr.

Without this patch, a SNET DPU rev 1 may hang when FLR is applied.

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Message-Id: <20230110165638.123745-3-alvaro.karsz@solid-run.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 289ba6902e41b..d8d3f817e95cb 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5403,6 +5403,14 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x7901, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
 
+/* FLR may cause the SolidRun SNET DPU (rev 0x1) to hang */
+static void quirk_no_flr_snet(struct pci_dev *dev)
+{
+	if (dev->revision == 0x1)
+		quirk_no_flr(dev);
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SOLIDRUN, 0x1000, quirk_no_flr_snet);
+
 static void quirk_no_ext_tags(struct pci_dev *pdev)
 {
 	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
-- 
2.43.0




