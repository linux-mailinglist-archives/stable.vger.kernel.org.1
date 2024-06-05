Return-Path: <stable+bounces-48040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4668FCB89
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07041C2356A
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31241199381;
	Wed,  5 Jun 2024 11:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZB8sRPHq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF88121C164;
	Wed,  5 Jun 2024 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588312; cv=none; b=S+0ISKlF4C7VYsyvkRQFlEvVsQV4rvHAMEPDBrHhLsRDKTceLJ2uvQaT4Po9pMeMANUiwcchGUfvb0HBFxPdBd3VsOSvAET25jqd9U5JF3Kd7juFDcv2mquThoaBgIjrMteoXiMPNsOSvbqDFFBwzNx0jpRo944qDHQqoSlkJ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588312; c=relaxed/simple;
	bh=569H3vxlvOKw0NdF8FLilubAxQEg7X96j20HsGVCBFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgfS2bAPM68o6uPebye5xwXCmI4X7mZ9C1LkAHpQ6ooxtXklrCbp+lxB4giCEg40AIq2EAj1ZyJYpbZ7nMTJnRbHRWjHXcD2q2V4fqgE8hGm2N0AE/r+/7bsIsTpoLz7gHxPq3klAm98SjV3TrcSmsd725/4LoTa5teXGNkr7dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZB8sRPHq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8125C3277B;
	Wed,  5 Jun 2024 11:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588311;
	bh=569H3vxlvOKw0NdF8FLilubAxQEg7X96j20HsGVCBFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZB8sRPHqC9gse9rEryKNTQQRcW7cQ8B8+GxCs04tlP+6Z8TVGU0plOSIi37Tl8TgS
	 +oNSttSZ4cotPfirKRgGNdtiikdARe0omUlcYqrGV/bvhbP1yc/ECCvhCqSsjMnGTv
	 NU2RjpCeqcoWocMVZNLS0tWQ4ITg8XC2U6T0SFfhVvCmhssD+3m3zjcBR+wx/TmQtv
	 wBbXVlGebuyJ2SxuRj1ppaQkPV5WGl65GiwbhxBBMtcJpiJMX3Dz1DM+lB23SbPgGG
	 xxcRa80O4mk/bSEFw/AaaTjxnAzOzCUgpi5hGJgDF/WbSNq+/BifhJZEUhM+tvUsUj
	 mr8YzeKW4SbVA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	rrichter@amd.com,
	terry.bowman@amd.com,
	ming4.li@intel.com,
	linux-cxl@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 19/24] cxl: Add post-reset warning if reset results in loss of previously committed HDM decoders
Date: Wed,  5 Jun 2024 07:50:29 -0400
Message-ID: <20240605115101.2962372-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115101.2962372-1-sashal@kernel.org>
References: <20240605115101.2962372-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.12
Content-Transfer-Encoding: 8bit

From: Dave Jiang <dave.jiang@intel.com>

[ Upstream commit 934edcd436dca0447e0d3691a908394ba16d06c3 ]

Secondary Bus Reset (SBR) is equivalent to a device being hot removed and
inserted again. Doing a SBR on a CXL type 3 device is problematic if the
exported device memory is part of system memory that cannot be offlined.
The event is equivalent to violently ripping out that range of memory from
the kernel. While the hardware requires the "Unmask SBR" bit set in the
Port Control Extensions register and the kernel currently does not unmask
it, user can unmask this bit via setpci or similar tool.

The driver does not have a way to detect whether a reset coming from the
PCI subsystem is a Function Level Reset (FLR) or SBR. The only way to
detect is to note if a decoder is marked as enabled in software but the
decoder control register indicates it's not committed.

Add a helper function to find discrepancy between the decoder software
state versus the hardware register state.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Link: https://lore.kernel.org/r/20240502165851.1948523-6-dave.jiang@intel.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/pci.c | 29 +++++++++++++++++++++++++++++
 drivers/cxl/cxl.h      |  2 ++
 drivers/cxl/pci.c      | 22 ++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index e9e6c81ce034a..e71cfd490d829 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1034,3 +1034,32 @@ long cxl_pci_get_latency(struct pci_dev *pdev)
 
 	return cxl_flit_size(pdev) * MEGA / bw;
 }
+
+static int __cxl_endpoint_decoder_reset_detected(struct device *dev, void *data)
+{
+	struct cxl_port *port = data;
+	struct cxl_decoder *cxld;
+	struct cxl_hdm *cxlhdm;
+	void __iomem *hdm;
+	u32 ctrl;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxld = to_cxl_decoder(dev);
+	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
+		return 0;
+
+	cxlhdm = dev_get_drvdata(&port->dev);
+	hdm = cxlhdm->regs.hdm_decoder;
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
+
+	return !FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);
+}
+
+bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
+{
+	return device_for_each_child(&port->dev, port,
+				     __cxl_endpoint_decoder_reset_detected);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index de477eb7f5d54..2624c775c5c93 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -888,6 +888,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 			     struct access_coordinate *c1,
 			     struct access_coordinate *c2);
 
+bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 2ff361e756d66..659f9d46b154c 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -957,11 +957,33 @@ static void cxl_error_resume(struct pci_dev *pdev)
 		 dev->driver ? "successful" : "failed");
 }
 
+static void cxl_reset_done(struct pci_dev *pdev)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	struct device *dev = &pdev->dev;
+
+	/*
+	 * FLR does not expect to touch the HDM decoders and related
+	 * registers.  SBR, however, will wipe all device configurations.
+	 * Issue a warning if there was an active decoder before the reset
+	 * that no longer exists.
+	 */
+	guard(device)(&cxlmd->dev);
+	if (cxlmd->endpoint &&
+	    cxl_endpoint_decoder_reset_detected(cxlmd->endpoint)) {
+		dev_crit(dev, "SBR happened without memory regions removal.\n");
+		dev_crit(dev, "System may be unstable if regions hosted system memory.\n");
+		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
+	}
+}
+
 static const struct pci_error_handlers cxl_error_handlers = {
 	.error_detected	= cxl_error_detected,
 	.slot_reset	= cxl_slot_reset,
 	.resume		= cxl_error_resume,
 	.cor_error_detected	= cxl_cor_error_detected,
+	.reset_done	= cxl_reset_done,
 };
 
 static struct pci_driver cxl_pci_driver = {
-- 
2.43.0


