Return-Path: <stable+bounces-220477-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kM7ROBA8o2nO+gQAu9opvQ
	(envelope-from <stable+bounces-220477-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:03:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C061C68D0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9EF2C30A12FC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8FA3C4C20;
	Sat, 28 Feb 2026 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qa11s6dt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F023C0BFF;
	Sat, 28 Feb 2026 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300364; cv=none; b=EZflwc5XnxII4PBd/hK82rbsp2/6i/uF0IRZwAJkdOC5be+m1DWBMLklie/kAS1AJeh/PJmhjZ7glvXO7dXlUfG19tIE0gtPktMP7IMVjKJ2DE+1iR8NPbUcOQn563doqWzz93G4Rp19GKvWyVv/i9HEWYNssjlHj/kSwhyt52g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300364; c=relaxed/simple;
	bh=0UMkOyGjMxIoCr9XoxNfWkc7FQFB4U5HlxQCUve25mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IsTpY/YN2UzNvQEAQthx0cyXqt54gGS1kSL7X0wymQu8GBOWExhJ3aDSyIEK7pxGLYY1rCpWhgsyX6GjoRDSzBdkxJgTN69mhNqIgFEeI4it3slqYYE861hwn4Tj9Hjc/WsxSeKmqS5essQH7g664u1ZY2wJnoYW0H8oXwFWr7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qa11s6dt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC756C19424;
	Sat, 28 Feb 2026 17:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300363;
	bh=0UMkOyGjMxIoCr9XoxNfWkc7FQFB4U5HlxQCUve25mU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qa11s6dtvGNCmaBPmuMNbv76UngHPTvHbhb1kGe77lks81ro/7CjZIR/qMSR+MSLu
	 tSo49fbISz7nVzl/FUyLpePObowUxQrJir+T98wNt6cVsuPolpVlx5xsAQb5zOjp5E
	 J5NeRyV6UP07WaumlqJN8McruvAdxCWZ/LIKxgVXi17WjArtQePxn+8aK4SYnr+5je
	 qbupNMCm+J+4kShunOhNdfg3fTtC9wUHIAj5/YyX4VmALOKCqI+fpB2Q0G+ed/qDLG
	 cBXeqn526JoZFyWH8ai5GxwaHlIR3lGEUi7GMZzzlvpzcKLiyFELZx5USqtQ414f88
	 Oi8TpPyX9e1UA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 398/844] mfd: intel-lpss: Add Intel Nova Lake-S PCI IDs
Date: Sat, 28 Feb 2026 12:25:11 -0500
Message-ID: <20260228173244.1509663-399-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220477-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13C061C68D0
X-Rspamd-Action: no action

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit cefd793fa17de708d043adab50e7f96f414b0f1d ]

Add Intel Nova Lake-S LPSS PCI IDs.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/20260113172151.48062-1-ilpo.jarvinen@linux.intel.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/intel-lpss-pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 8d92c895d3aef..713a5bfb1a3c2 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -437,6 +437,19 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x5ac4), (kernel_ulong_t)&bxt_spi_info },
 	{ PCI_VDEVICE(INTEL, 0x5ac6), (kernel_ulong_t)&bxt_spi_info },
 	{ PCI_VDEVICE(INTEL, 0x5aee), (kernel_ulong_t)&bxt_uart_info },
+	/* NVL-S */
+	{ PCI_VDEVICE(INTEL, 0x6e28), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x6e29), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x6e2a), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x6e2b), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x6e4c), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x6e4d), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x6e4e), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x6e4f), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x6e5c), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x6e5e), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x6e7a), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x6e7b), (kernel_ulong_t)&ehl_i2c_info },
 	/* ARL-H */
 	{ PCI_VDEVICE(INTEL, 0x7725), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x7726), (kernel_ulong_t)&bxt_uart_info },
-- 
2.51.0


