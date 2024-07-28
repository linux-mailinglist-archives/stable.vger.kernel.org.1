Return-Path: <stable+bounces-62331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755BE93E88D
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFBB281200
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F3C191F82;
	Sun, 28 Jul 2024 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/94ZdHx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9FA7F48A;
	Sun, 28 Jul 2024 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722183059; cv=none; b=V+dDDqgG2/ulVOvE5I/GTVx4k57ZtI5JF2+rhovZ1XTAZv6vgHAXzUWw0u6BUCITx+kthVO6Y305ftn80u36AARTFMDAiPnvtTDyGo7LUdCNQHCE6nU/jrEq0fFHB0Nso15CS3Vg8YLl/OJNMWaFEb93D1U1XaHqETWdvZziLz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722183059; c=relaxed/simple;
	bh=X6s4I4eC7Wnz1I6pC3l7IG/ytFfYQlSgaxQq0s4xUyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCfmi3IjOC8DrK/EIzjpa85w7EquIfgCQXXZOYgt0YNeNnTKTQxM6O7pK4aG3CJD3pZchSFIo81w/7dNhZUZzbKbX68dRbwZhKV8BCCNHa0pDciaD7QdokopBqztHsOG4j+YsqPeo6udgHWHTGRozbqsa86FZVD9KTMhAY0Ym48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/94ZdHx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F50DC32782;
	Sun, 28 Jul 2024 16:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722183059;
	bh=X6s4I4eC7Wnz1I6pC3l7IG/ytFfYQlSgaxQq0s4xUyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S/94ZdHx0EPrzI+MJST8/39WYrcsZy0hyto6G0UxuOEnKNrIo99G8OPul7ysrS7oV
	 ToEguQb3B698FrlDyU1i2p9ru8ejNyhrdFd9XymA2HG7AV41d1kczVo51IBh2BcbxK
	 HpciGu/D27RP5GmpmlXHBauX8xf68tPmwJmVakyPjJTLjP4bW6j91BJx/nwaqHaqDz
	 kDl/6KUrIgtkbjdw7uRJjfLqu21BSGWSUvpUzp5VuS0guX0NUGJ6WiBSe6hC17Zbh3
	 hd4IxuuPfJh9BiBdfxyuXEvfLcQb36PKmy7My1bxHNlmr94TK2ZuJpOrmtXAHdLA/L
	 bHW/FMA+Hhoig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	mahesh@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 2/4] PCI/AER: Disable AER service on suspend
Date: Sun, 28 Jul 2024 12:10:51 -0400
Message-ID: <20240728161055.2054513-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728161055.2054513-1-sashal@kernel.org>
References: <20240728161055.2054513-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.319
Content-Transfer-Encoding: 8bit

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 5afc2f763edc5daae4722ee46fea4e627d01fa90 ]

If the link is powered off during suspend, electrical noise may cause
errors that are logged via AER.  If the AER interrupt is enabled and shares
an IRQ with PME, that causes a spurious wakeup during suspend.

Disable the AER interrupt during suspend to prevent this.  Clear error
status before re-enabling IRQ interrupts during resume so we don't get an
interrupt for errors that occurred during the suspend/resume process.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=209149
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216295
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218090
Link: https://lore.kernel.org/r/20240416043225.1462548-2-kai.heng.feng@canonical.com
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
[bhelgaas: drop pci_ancestor_pr3_present() etc, commit log]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/aer.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 1563e22600eca..49680f83d8c37 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1509,6 +1509,22 @@ static int aer_probe(struct pcie_device *dev)
 	return 0;
 }
 
+static int aer_suspend(struct pcie_device *dev)
+{
+	struct aer_rpc *rpc = get_service_data(dev);
+
+	aer_disable_rootport(rpc);
+	return 0;
+}
+
+static int aer_resume(struct pcie_device *dev)
+{
+	struct aer_rpc *rpc = get_service_data(dev);
+
+	aer_enable_rootport(rpc);
+	return 0;
+}
+
 /**
  * aer_root_reset - reset link on Root Port
  * @dev: pointer to Root Port's pci_dev data structure
@@ -1561,6 +1577,8 @@ static struct pcie_port_service_driver aerdriver = {
 	.service	= PCIE_PORT_SERVICE_AER,
 
 	.probe		= aer_probe,
+	.suspend	= aer_suspend,
+	.resume		= aer_resume,
 	.remove		= aer_remove,
 	.error_resume	= aer_error_resume,
 	.reset_link	= aer_root_reset,
-- 
2.43.0


