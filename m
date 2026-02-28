Return-Path: <stable+bounces-220415-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAmhJgU2o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220415-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:37:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 278341C60AE
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A66F3188373
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC79A3B0965;
	Sat, 28 Feb 2026 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjHo1oEm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD493B095E;
	Sat, 28 Feb 2026 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300306; cv=none; b=b6c6SjeexcbV/GFehd7NzyaFLhwL2ZkKkWb/Hc5QsGNhk/ZYly0Wy2eHnGs1+c9ZnP9gT4dd0Ni+btV3SS1CjZIIGV3/62G8Om+g5hnVooGQyO1qpJThdFd/AV/p5cKxMLeiAArrg6JYHniwKn/PoGKkv9O3248y0MazVVUFOPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300306; c=relaxed/simple;
	bh=9fThhOT5K0o6OtqQqTxa5xfDf7abhccpMQ0273q90AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9m1K37k4z6KgQITPMzqaHXtoivDVKxJ5iiRe3ba5m+lPUj7MKO1QEmRy2lif12PsrY8DuARANFOGmot8uLcXLU/8wixZ9wfgHChVU5mZziH0W6Dehhpbd8aNWloByW8JQb+Bft+TX15lNZm5LoaWmIkDPrYHQxqYWwYT0hDzcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjHo1oEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68D5C116D0;
	Sat, 28 Feb 2026 17:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300306;
	bh=9fThhOT5K0o6OtqQqTxa5xfDf7abhccpMQ0273q90AQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fjHo1oEmOb9Iezjpe9Yfb46oAEm2LxyJiQpqyIUbxlTjlD/r9y88kozDn3fb6lebX
	 b6a/liOxrdQE42awwl3z41SzMITHZMaYklOrghOuXZGvD0Rk29rwcjYLe7OfqlQE82
	 FNnyuipHHlG8iXpmzlODn4AiuZmplKXkpBNEMm8ThtHXUttQL2l+b1pQJP/uEHV8IT
	 dORks61G0DF3tJJmH4RpfuXAQ7LHE1FWJa58wCFHr1PM/9Ys6AhG0QlZM9My4vjjpB
	 O8z8jtw8ZsnTpX14/NBcXKTkDx+53+G+DsdVBHIqkIkUBmNi12aEm6yHTMRsn/a9Gh
	 Y097Koirle2wA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johnny-CC Chang <Johnny-CC.Chang@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 336/844] PCI: Mark Nvidia GB10 to avoid bus reset
Date: Sat, 28 Feb 2026 12:24:09 -0500
Message-ID: <20260228173244.1509663-337-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220415-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 278341C60AE
X-Rspamd-Action: no action

From: Johnny-CC Chang <Johnny-CC.Chang@mediatek.com>

[ Upstream commit c81a2ce6b6a844d1a57d2a69833a9d0f00403f00 ]

After asserting Secondary Bus Reset to downstream devices via a GB10 Root
Port, the link may not retrain correctly, e.g., the link may retrain with a
lower lane count or config accesses to downstream devices may fail.

Prevent use of Secondary Bus Reset for devices below GB10.

Signed-off-by: Johnny-CC Chang <Johnny-CC.Chang@mediatek.com>
[bhelgaas: drop pci_ids.h update (only used once), update commit log]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://patch.msgid.link/20251113084441.2124737-1-Johnny-CC.Chang@mediatek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4463a2da0441f..90676cb2fd10b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3748,6 +3748,14 @@ static void quirk_no_bus_reset(struct pci_dev *dev)
 	dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET;
 }
 
+/*
+ * After asserting Secondary Bus Reset to downstream devices via a GB10
+ * Root Port, the link may not retrain correctly.
+ * https://lore.kernel.org/r/20251113084441.2124737-1-Johnny-CC.Chang@mediatek.com
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, 0x22CE, quirk_no_bus_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, 0x22D0, quirk_no_bus_reset);
+
 /*
  * Some NVIDIA GPU devices do not work with bus reset, SBR needs to be
  * prevented for those affected devices.
-- 
2.51.0


