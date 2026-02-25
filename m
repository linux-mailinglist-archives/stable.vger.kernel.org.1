Return-Path: <stable+bounces-219301-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMK9Em2dnmkZWgQAu9opvQ
	(envelope-from <stable+bounces-219301-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:57:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D36001929B1
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AEC33052709
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9332FF669;
	Wed, 25 Feb 2026 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vnHF8c0S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100A42D8DCF;
	Wed, 25 Feb 2026 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002626; cv=none; b=Z4rp4Y0l3LXBWRtB6ruwGsduQwOaakqf59tIF795GgKZDkbXTmtv2WIzJZhyGqpUkr9TQHvoguPY+56BivclbpDSjTwGCwV5y1yp9EuycXczGT2HvaLq/xFfpNgGl3Sz0qdbbOUnDM3uV7fo6ok6dTdwGkNGW9o2+nzAQjMq4Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002626; c=relaxed/simple;
	bh=XU95D6OmSiSXTvsKTFIup/uk6DbtD2lvpy4Xh09gvbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oj/Dhbc3ettJlLtxoQ1851Nq6VC2v1awmpEV7jWZKQDvRfcOOzozNcQhEskOQqvsOguTBDaRBVGwYi3858DKYOrAkAeXzFU1VLR37/+Yg9iF8Kq1OsiHzipmvS+J2YUj1gx+FJFNLfcQNGdkPHwxUjtIsUbgmh2uScEyV/78Od0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vnHF8c0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58DFC19422;
	Wed, 25 Feb 2026 06:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002625;
	bh=XU95D6OmSiSXTvsKTFIup/uk6DbtD2lvpy4Xh09gvbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vnHF8c0SU5q9pDQxjaYD2MSP5QqDQf4SO/mTLoOrW5iENeVFaZAt6HhOkZIMGBZi5
	 q6Huq3zfQrgJUREfkZPhVWlaz527O/4Ao338YNEUgFVhmhs2xfqBypdduHkjERWDEP
	 u/m289nEiob1epRmNFillh99rPC/eimC3wm7Gcc0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Weili Qian <qianweili@huawei.com>,
	Alex Williamson <alex@shazbot.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 386/641] hisi_acc_vfio_pci: fix VF reset timeout issue
Date: Tue, 24 Feb 2026 17:21:52 -0800
Message-ID: <20260225012357.937839425@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-219301-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,huawei.com:email,shazbot.org:email]
X-Rspamd-Queue-Id: D36001929B1
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Weili Qian <qianweili@huawei.com>

[ Upstream commit a22099ed7936f8e8dabbdbadd97d56047797116b ]

If device error occurs during live migration, qemu will
reset the VF. At this time, VF reset and device reset are performed
simultaneously. The VF reset will timeout. Therefore, the QM_RESETTING
flag is used to ensure that VF reset and device reset are performed
serially.

Fixes: b0eed085903e ("hisi_acc_vfio_pci: Add support for VFIO live migration")
Signed-off-by: Weili Qian <qianweili@huawei.com>
Link: https://lore.kernel.org/r/20260122020205.2884497-2-liulongfang@huawei.com
Signed-off-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 24 +++++++++++++++++++
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index d07093d7cc3f5..ed2ae035deb16 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -1169,9 +1169,32 @@ hisi_acc_vfio_pci_get_device_state(struct vfio_device *vdev,
 	return 0;
 }
 
+static void hisi_acc_vf_pci_reset_prepare(struct pci_dev *pdev)
+{
+	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
+	struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
+	struct device *dev = &qm->pdev->dev;
+	u32 delay = 0;
+
+	/* All reset requests need to be queued for processing */
+	while (test_and_set_bit(QM_RESETTING, &qm->misc_ctl)) {
+		msleep(1);
+		if (++delay > QM_RESET_WAIT_TIMEOUT) {
+			dev_err(dev, "reset prepare failed\n");
+			return;
+		}
+	}
+
+	hisi_acc_vdev->set_reset_flag = true;
+}
+
 static void hisi_acc_vf_pci_aer_reset_done(struct pci_dev *pdev)
 {
 	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
+	struct hisi_qm *qm = hisi_acc_vdev->pf_qm;
+
+	if (hisi_acc_vdev->set_reset_flag)
+		clear_bit(QM_RESETTING, &qm->misc_ctl);
 
 	if (hisi_acc_vdev->core_device.vdev.migration_flags !=
 				VFIO_MIGRATION_STOP_COPY)
@@ -1690,6 +1713,7 @@ static const struct pci_device_id hisi_acc_vfio_pci_table[] = {
 MODULE_DEVICE_TABLE(pci, hisi_acc_vfio_pci_table);
 
 static const struct pci_error_handlers hisi_acc_vf_err_handlers = {
+	.reset_prepare = hisi_acc_vf_pci_reset_prepare,
 	.reset_done = hisi_acc_vf_pci_aer_reset_done,
 	.error_detected = vfio_pci_core_aer_err_detected,
 };
diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
index 91002ceeebc18..6253fa074003e 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
@@ -27,6 +27,7 @@
 
 #define ERROR_CHECK_TIMEOUT		100
 #define CHECK_DELAY_TIME		100
+#define QM_RESET_WAIT_TIMEOUT  60000
 
 #define QM_SQC_VFT_BASE_SHIFT_V2	28
 #define QM_SQC_VFT_BASE_MASK_V2		GENMASK(15, 0)
@@ -110,6 +111,7 @@ struct hisi_acc_vf_migration_file {
 struct hisi_acc_vf_core_device {
 	struct vfio_pci_core_device core_device;
 	u8 match_done;
+	bool set_reset_flag;
 	/*
 	 * io_base is only valid when dev_opened is true,
 	 * which is protected by open_mutex.
-- 
2.51.0




