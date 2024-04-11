Return-Path: <stable+bounces-38442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD6D8A0E9B
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F21AB21722
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7FA145B28;
	Thu, 11 Apr 2024 10:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RulKqysJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F11713F452;
	Thu, 11 Apr 2024 10:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830584; cv=none; b=WQYWntZzgyU3+RDcg/FFO1M6BFoPcx8CxnBTGboIcydw5rvdKjmUmrqEgDjwE2M055BMhkEKuf2RJ1G+t7KZrtNYG7xD6vchF3zUNuE8sXvQa5KixOyD9itcsU+ikXNk6yzOGcvN89ZiLlInRTjmM1qhuscn4U+HHPGGink38Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830584; c=relaxed/simple;
	bh=XqimEGl2SR7j19ktFTjW7+mb38QGvzf+xCcl2PGMMPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xxk/Xjac1OvbHw3Q/dUx17M04oddM8I+Sj1M109QmNBiM6SFLc7VzjEN3uXlgRpKVG7hM/KaenvQO09Fh/K+/uyesZdjGjIM5R0IVybtFyfObCL2KFnMuI0WRQqyp4bB+oUOz6uMP7/lCSrD34IZMey4p4zaT/BG3YQcFOd9gDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RulKqysJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7991C433C7;
	Thu, 11 Apr 2024 10:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712830584;
	bh=XqimEGl2SR7j19ktFTjW7+mb38QGvzf+xCcl2PGMMPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RulKqysJAh5sNXLJ33J6c+PdK5qQfg+EKWarv5lXDGR+6lKHbOhIX6uYQEw7tAMdM
	 IWOXHGE5JZjdoRjagFDxhdOnzfm1xWEEcnahZ1LvD3c6D+PyncNO3upGiG0Rwrqlhg
	 hB3hxvS25hfkuJ18Pi8F/UbaSUBSeT0mpCkicRfI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 049/215] PCI: Drop pci_device_remove() test of pci_dev->driver
Date: Thu, 11 Apr 2024 11:54:18 +0200
Message-ID: <20240411095426.369334276@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095424.875421572@linuxfoundation.org>
References: <20240411095424.875421572@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 097d9d414433315122f759ee6c2d8a7417a8ff0f ]

When the driver core calls pci_device_remove(), there is a driver bound
to the device, so pci_dev->driver is never NULL.

Remove the unnecessary test of pci_dev->driver.

Link: https://lore.kernel.org/r/20211004125935.2300113-2-u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Stable-dep-of: 9d5286d4e7f6 ("PCI/PM: Drain runtime-idle callbacks before driver removal")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci-driver.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 70c8584b3ffcc..7644a282bfdb8 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -439,16 +439,14 @@ static int pci_device_remove(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *drv = pci_dev->driver;
 
-	if (drv) {
-		if (drv->remove) {
-			pm_runtime_get_sync(dev);
-			drv->remove(pci_dev);
-			pm_runtime_put_noidle(dev);
-		}
-		pcibios_free_irq(pci_dev);
-		pci_dev->driver = NULL;
-		pci_iov_remove(pci_dev);
+	if (drv->remove) {
+		pm_runtime_get_sync(dev);
+		drv->remove(pci_dev);
+		pm_runtime_put_noidle(dev);
 	}
+	pcibios_free_irq(pci_dev);
+	pci_dev->driver = NULL;
+	pci_iov_remove(pci_dev);
 
 	/* Undo the runtime PM settings in local_pci_probe() */
 	pm_runtime_put_sync(dev);
-- 
2.43.0




