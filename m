Return-Path: <stable+bounces-220672-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAYICtU+o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220672-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:15:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C221C6BFF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96D5B308DFEC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD813F5265;
	Sat, 28 Feb 2026 17:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJQVT0d3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC3748BD5E;
	Sat, 28 Feb 2026 17:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300554; cv=none; b=VVM8REQ6mBTxqjLOA4kUDiBqaPRPTHc2Q6rPyiPjfDrCcwdw5Xj+L125C0+Z6D3wbmX2YfSB56ZecvKBOoVf7TLmT1CutDbDotqZyd4zwliS/Cm5Lpn79My0MGINSjswFqJmSjxh2ulLnvsM0U4CibOJdaey0WLjW/iRAQikOWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300554; c=relaxed/simple;
	bh=iUjxghbPGpierS2dmoHzYUTfoL1la1uEPilGAtjgPKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRrep2ueDO6MRrTU3tZ0+D1WDHSyGeXMXavbBYC4ehg/FHhZlwrMzljJQojb6HfOmqIkdnp0MO6NHf8A4cEt4/kMFsEZNUEfsHtrigxJHKO7FD6bynGsCC39R4EAeZR8Y3iVwpIn+RrEeyB+buJ+vOQAx4YTcLgwR7DOMLVhk30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJQVT0d3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFF2C116D0;
	Sat, 28 Feb 2026 17:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300554;
	bh=iUjxghbPGpierS2dmoHzYUTfoL1la1uEPilGAtjgPKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GJQVT0d3co+6DY3erl4irZJlhm3CV41I7G3WCXiU8evQ5czcJwvHc3e7mclU0QAGw
	 9D0Z1ooJOHqkFkXDN7NEJNsrlGwM1lcfCEjRemubEkwOx+6jwA/aV9ci1XqYobD8Bm
	 GBoSF/pv8MmPPsZnflCgnTndfSF/MfK4NNUxq3GL9Izrp5jTgtYqkmSv9Zr0SXMVUO
	 8HDUwRChBLSZSLw1nTCVhBj5cOyChkIxKosZeNtk1WxbhQ4KA1vvcRdWqR8LguXNvp
	 38sLDfAZg7JYqDJl59sq8cnyteJ8Rld3em1AsnLImu+0jxnYbd6oAlfZeeF3xp+59y
	 RncPrMdbpMCyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bingbu Cao <bingbu.cao@intel.com>,
	Stable@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 593/844] media: ipu6: Fix RPM reference leak in probe error paths
Date: Sat, 28 Feb 2026 12:28:26 -0500
Message-ID: <20260228173244.1509663-594-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220672-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B7C221C6BFF
X-Rspamd-Action: no action

From: Bingbu Cao <bingbu.cao@intel.com>

[ Upstream commit 6099f78e4c9223f4de4169d2fd1cded01279da1a ]

Several error paths in ipu6_pci_probe() were jumping directly to
out_ipu6_bus_del_devices without releasing the runtime PM reference.
Add pm_runtime_put_sync() before cleaning up other resources.

Cc: Stable@vger.kernel.org
Fixes: 25fedc021985 ("media: intel/ipu6: add Intel IPU6 PCI device driver")
Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/intel/ipu6/ipu6.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/pci/intel/ipu6/ipu6.c b/drivers/media/pci/intel/ipu6/ipu6.c
index 1f4f20b9c94dc..a2768f44017a5 100644
--- a/drivers/media/pci/intel/ipu6/ipu6.c
+++ b/drivers/media/pci/intel/ipu6/ipu6.c
@@ -630,21 +630,21 @@ static int ipu6_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret) {
 		dev_err_probe(&isp->pdev->dev, ret,
 			      "Failed to set MMU hardware\n");
-		goto out_ipu6_bus_del_devices;
+		goto out_ipu6_rpm_put;
 	}
 
 	ret = ipu6_buttress_map_fw_image(isp->psys, isp->cpd_fw,
 					 &isp->psys->fw_sgt);
 	if (ret) {
 		dev_err_probe(&isp->pdev->dev, ret, "failed to map fw image\n");
-		goto out_ipu6_bus_del_devices;
+		goto out_ipu6_rpm_put;
 	}
 
 	ret = ipu6_cpd_create_pkg_dir(isp->psys, isp->cpd_fw->data);
 	if (ret) {
 		dev_err_probe(&isp->pdev->dev, ret,
 			      "failed to create pkg dir\n");
-		goto out_ipu6_bus_del_devices;
+		goto out_ipu6_rpm_put;
 	}
 
 	ret = devm_request_threaded_irq(dev, pdev->irq, ipu6_buttress_isr,
@@ -652,7 +652,7 @@ static int ipu6_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 					IRQF_SHARED, IPU6_NAME, isp);
 	if (ret) {
 		dev_err_probe(dev, ret, "Requesting irq failed\n");
-		goto out_ipu6_bus_del_devices;
+		goto out_ipu6_rpm_put;
 	}
 
 	ret = ipu6_buttress_authenticate(isp);
@@ -683,6 +683,8 @@ static int ipu6_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 out_free_irq:
 	devm_free_irq(dev, pdev->irq, isp);
+out_ipu6_rpm_put:
+	pm_runtime_put_sync(&isp->psys->auxdev.dev);
 out_ipu6_bus_del_devices:
 	if (isp->psys) {
 		ipu6_cpd_free_pkg_dir(isp->psys);
-- 
2.51.0


