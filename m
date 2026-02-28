Return-Path: <stable+bounces-220834-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKXZGTpGo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220834-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:47:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AAE1C75BC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C2A2308413D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BF44170A9;
	Sat, 28 Feb 2026 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUAX8a4U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C1141651E;
	Sat, 28 Feb 2026 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300719; cv=none; b=h3hvx/tIljJWCEa42NKce1L/9FgQnklGO+D+m+G/+ePc1sGK/9xT4tfx0M7kmczRClVFrslzxIazFsTyEOEGcJL6o1K0EJSthhV2+Hlz0EjCoMykj11vIj5U8q/WKvgALZRo689yUqkbPQ11sQY0DdUTmiCsd/wKGpSTycdInS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300719; c=relaxed/simple;
	bh=aQv/3XJYR3hAjB/rejfaQpmXH4pIvSVZf7Ui6GlV/XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jwtpvHIeAA1HEFns96z+IlBvZ+q2E243qK/JO5XwBMLYrNJYVcpVcJ6IA6+0fwXVxefV57Utgud2AvB1b/qHpq1Qv3hBsviFgvgLbMW+L9Vl8v6FFmRT0FupNYRE7ms7WzAUb99eqlvffQTCwc7C62uaMNtCFVqflBxZny+kuiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUAX8a4U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61E9C4AF09;
	Sat, 28 Feb 2026 17:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300719;
	bh=aQv/3XJYR3hAjB/rejfaQpmXH4pIvSVZf7Ui6GlV/XY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UUAX8a4UM8vDVSRs4UV8xU4t+x6/K7JUww/9iY18z1ccuSkAzALWQzXvcRdxCq3Fw
	 wlYtoNe1UvlrpUDTbk+iagKN+k71wUccuAkERT+LcgxyUUwKr53HmIEYcudLxTocoB
	 BB+AcNO4V89pE+ow8WLu6qKZDLLWLiQN131Ta54yLHsW4bxIEh3TVFfYXM4/pJqgPa
	 CYiPaYaaTmhvCju+37MFj/zQrAm1n5H+sEP56WRwwhf8B8DdsHfYn3cHCVDQCbRAkk
	 GcyAIoMyNnuPCS7ZHvJMlEKd8ZIZXVj74i08dXsUyFlg1N8hAXvnnQzxLN2jKsaHIO
	 CzmExp0p3YrWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sizhe Liu <liusizhe5@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 755/844] PCI: Don't claim disabled bridge windows
Date: Sat, 28 Feb 2026 12:31:08 -0500
Message-ID: <20260228173244.1509663-756-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220834-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,intel.com:email,msgid.link:url]
X-Rspamd-Queue-Id: A4AAE1C75BC
X-Rspamd-Action: no action

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 2ecc1bf14e2fdaff78bd1b8e7ed3dba336a3fad5 ]

The commit 8278c6914306 ("PCI: Preserve bridge window resource type flags")
changed bridge window resource behavior such that flags are no longer zero
if the bridge window is not valid or is disabled (mainly to preserve the
type flags for later use). If a bridge window has its limit smaller than
base address, pci_read_bridge_*() sets both IORESOURCE_UNSET and
IORESOURCE_DISABLED to indicate the bridge window exists but is not valid
with the current base and limit configuration.

The code in pci_claim_bridge_resources() still depends on the old behavior
of checking validity of the bridge window solely based on !r->flags,
whereas after 8278c6914306, also IORESOURCE_DISABLED may indicate bridge
window addresses are not valid.

While pci_claim_resource() does check IORESOURCE_UNSET,
pci_claim_bridge_resource() attempts to clip the resource if
pci_claim_resource() fails, which is not correct for bridge window
resources that are not valid. As pci_bus_clip_resource() performs clipping
regardless of flags and then clears IORESOURCE_UNSET, it should not be
called unless the resource is valid.

The problem is visible in this log:

  pci 0000:20:00.0: PCI bridge to [bus 21]
  pci 0000:20:00.0: bridge window [io  size 0x0000 disabled]: can't claim; no address assigned
  pci 0000:20:00.0: [io  0x0000-0xffffffffffffffff disabled] clipped to [io 0x0000-0xffff disabled]

Add IORESOURCE_DISABLED check in pci_claim_bridge_resources() to only
claim bridge windows that appear to have a valid configuration.

Fixes: 8278c6914306 ("PCI: Preserve bridge window resource type flags")
Reported-by: Sizhe Liu <liusizhe5@huawei.com>
Link: https://lore.kernel.org/all/20260203023545.2753811-1-liusizhe5@huawei.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/4d9228d6-a230-6ddf-e300-fbf42d523863@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/setup-bus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ee8fe6e0de5fd..8311b06fadcc6 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1685,6 +1685,8 @@ static void pci_claim_bridge_resources(struct pci_dev *dev)
 
 		if (!r->flags || r->parent)
 			continue;
+		if (r->flags & IORESOURCE_DISABLED)
+			continue;
 
 		pci_claim_bridge_resource(dev, i);
 	}
-- 
2.51.0


