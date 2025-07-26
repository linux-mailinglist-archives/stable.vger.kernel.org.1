Return-Path: <stable+bounces-164822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A065B12891
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 04:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8F403BB8D8
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 02:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BF21D5151;
	Sat, 26 Jul 2025 02:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4OZJfvZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C5642AB0
	for <stable@vger.kernel.org>; Sat, 26 Jul 2025 02:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753496835; cv=none; b=huKmJ1EhhnPp9ACMXUmsngO28yPnhUb7nR8gMxV+L4W0+vEqWbvzQiHrnhwGfDxL0SB+ZfxjUbJU48b1tYElTKx4sh10wUxUYO6jev7i26SyUYOxO065/qPbhTZ8BSOt2RY8p0F9rduukornJAXak700fsm/peAjIUYT4yMBJbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753496835; c=relaxed/simple;
	bh=EfxyL63iSTj7ky8olEayJrnmaJyfZz++pCBrQGh6Q70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ug6f6f6bKvFwHi8vNf8gMwI07SuzMLtb/A2139OKJlywVAaRRY+sCRlnebBR3B1dCgOiUT3fHoz3VqQMymDkCMPgv7Ncg6ZV0gTBTXsZt1YvAeuk0e1hGzUd1wn0qTSV9K3V1Spbimb0ew3BDGFvyBEFWjL4IdLlhMyvW62p9xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4OZJfvZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C876C4CEE7;
	Sat, 26 Jul 2025 02:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753496835;
	bh=EfxyL63iSTj7ky8olEayJrnmaJyfZz++pCBrQGh6Q70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e4OZJfvZvdmFeWR1ztPpH0S5d+GvZFRs3MRMDNd+59JZYHLlGFH7Qyp0UNuXG9rcT
	 FkZ4KnIAYUFWPbVvM6WsXdo7Cc/VZIR4C5EMs1ZmjdPlCXBXmrtJbqA9hwGZFnMPWE
	 nS8Jj2Mc8kbtOTihx/xEdi9YpLxPduhLwiD6/bMBD3WDWyrJMrUYa7aJfpI/+ooss4
	 hmmtzdqFO5SORn1fpFe+PsTGdgFATYzvPnE2Om+zmWyiTE3WOE/xbXGIQGQc8rY/0i
	 s5R27PYcnTXz3Xpy1MKYSXtEv6sh4K6WpI3id6v8bsG20Dra9+2JXDZn2/GIg+4U1O
	 kgc6oPJbRj13A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Ahsan Atta <ahsan.atta@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] crypto: qat - add shutdown handler to qat_dh895xcc
Date: Fri, 25 Jul 2025 22:27:05 -0400
Message-Id: <20250726022705.2024714-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025062004-setting-ruined-8212@gregkh>
References: <2025062004-setting-ruined-8212@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

[ Upstream commit 2c4e8b228733bfbcaf49408fdf94d220f6eb78fc ]

During a warm reset via kexec, the system bypasses the driver removal
sequence, meaning that the remove() callback is not invoked.
If a QAT device is not shutdown properly, the device driver will fail to
load in a newly rebooted kernel.

This might result in output like the following after the kexec reboot:

    QAT: AE0 is inactive!!
    QAT: failed to get device out of reset
    dh895xcc 0000:3f:00.0: qat_hal_clr_reset error
    dh895xcc 0000:3f:00.0: Failed to init the AEs
    dh895xcc 0000:3f:00.0: Failed to initialise Acceleration Engine
    dh895xcc 0000:3f:00.0: Resetting device qat_dev0
    dh895xcc 0000:3f:00.0: probe with driver dh895xcc failed with error -14

Implement the shutdown() handler that hooks into the reboot notifier
list. This brings down the QAT device and ensures it is shut down
properly.

Cc: <stable@vger.kernel.org>
Fixes: 7afa232e76ce ("crypto: qat - Intel(R) QAT DH895xcc accelerator")
Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
[ added false parameter to adf_dev_down() call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/intel/qat/qat_dh895xcc/adf_drv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/crypto/intel/qat/qat_dh895xcc/adf_drv.c b/drivers/crypto/intel/qat/qat_dh895xcc/adf_drv.c
index 1e748e8ce12d5..b68903212b640 100644
--- a/drivers/crypto/intel/qat/qat_dh895xcc/adf_drv.c
+++ b/drivers/crypto/intel/qat/qat_dh895xcc/adf_drv.c
@@ -27,12 +27,14 @@ MODULE_DEVICE_TABLE(pci, adf_pci_tbl);
 
 static int adf_probe(struct pci_dev *dev, const struct pci_device_id *ent);
 static void adf_remove(struct pci_dev *dev);
+static void adf_shutdown(struct pci_dev *dev);
 
 static struct pci_driver adf_driver = {
 	.id_table = adf_pci_tbl,
 	.name = ADF_DH895XCC_DEVICE_NAME,
 	.probe = adf_probe,
 	.remove = adf_remove,
+	.shutdown = adf_shutdown,
 	.sriov_configure = adf_sriov_configure,
 	.err_handler = &adf_err_handler,
 };
@@ -227,6 +229,13 @@ static void adf_remove(struct pci_dev *pdev)
 	kfree(accel_dev);
 }
 
+static void adf_shutdown(struct pci_dev *pdev)
+{
+	struct adf_accel_dev *accel_dev = adf_devmgr_pci_to_accel_dev(pdev);
+
+	adf_dev_down(accel_dev, false);
+}
+
 static int __init adfdrv_init(void)
 {
 	request_module("intel_qat");
-- 
2.39.5


