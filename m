Return-Path: <stable+bounces-153419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B873ADD45D
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98EF22C20AD
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA142ECEA7;
	Tue, 17 Jun 2025 15:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="136CJFWz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7900A2ECEA6;
	Tue, 17 Jun 2025 15:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175900; cv=none; b=tSuv7JvBikknoKpboF2xI3m+Okn3N8Ao0w3ZrrP72WATvhWK1FebBeFbapDv74giq8QOnXCkYbBo/fxvG9QWoBqCeVps49f9ayyyzeDiKrdkwZKeHyOFiWu69crhxJDVG6ZkQs0lWHfxe1OW+jGAoaFaxTvCF1dVo26oxwCaGoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175900; c=relaxed/simple;
	bh=cmVXHO8FeSsSncakzoNCJgwqcnJIWy0jtA/aDPtuTd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcaQ3z7zm6EwmtuEAY/jdObBOJtaq90sSuOK+gijeLEkVa0Z1q5zp2KVKz1BAMDba0TeDsbBB/Zye3JrtkD/5AS6zIFiT8n+CvzlvOZ4wvbvJr8wLPixJas4wW6gNZO9gEFvJTocBijfP47xGTsUFGxgUe3I+LjxgV6q41ApxQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=136CJFWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1B1C4CEE3;
	Tue, 17 Jun 2025 15:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750175900;
	bh=cmVXHO8FeSsSncakzoNCJgwqcnJIWy0jtA/aDPtuTd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=136CJFWznUZkOzaHa7y+fIVGFiMk0dGlX/5KZZtPP9mQJgF4Nl8bI9bzLKQGNyFzb
	 n84rmHQPI+Qb3oMaYSBvwAM94pWZvdF1g5E/0KoEnNRm9eHA8aLjQihffw3o1aqG7N
	 4fAUHGmLdqLasl/BMugQ6vQY+E5IakAjKynww2jc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans Zhang <18255117159@163.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 223/356] PCI: cadence: Fix runtime atomic count underflow
Date: Tue, 17 Jun 2025 17:25:38 +0200
Message-ID: <20250617152347.181636607@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152338.212798615@linuxfoundation.org>
References: <20250617152338.212798615@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Zhang <18255117159@163.com>

[ Upstream commit 8805f32a96d3b97cef07999fa6f52112678f7e65 ]

If the call to pci_host_probe() in cdns_pcie_host_setup() fails, PM
runtime count is decremented in the error path using pm_runtime_put_sync().
But the runtime count is not incremented by this driver, but only by the
callers (cdns_plat_pcie_probe/j721e_pcie_probe). And the callers also
decrement the runtime PM count in their error path. So this leads to the
below warning from the PM core:

	"runtime PM usage count underflow!"

So fix it by getting rid of pm_runtime_put_sync() in the error path and
directly return the errno.

Fixes: 49e427e6bdd1 ("Merge branch 'pci/host-probe-refactor'")
Signed-off-by: Hans Zhang <18255117159@163.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://patch.msgid.link/20250419133058.162048-1-18255117159@163.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/cadence/pcie-cadence-host.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 8af95e9da7cec..741e10a575ec7 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -570,14 +570,5 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	if (!bridge->ops)
 		bridge->ops = &cdns_pcie_host_ops;
 
-	ret = pci_host_probe(bridge);
-	if (ret < 0)
-		goto err_init;
-
-	return 0;
-
- err_init:
-	pm_runtime_put_sync(dev);
-
-	return ret;
+	return pci_host_probe(bridge);
 }
-- 
2.39.5




