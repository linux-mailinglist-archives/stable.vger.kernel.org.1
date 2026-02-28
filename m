Return-Path: <stable+bounces-220423-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PjGCnU2o2lG+gQAu9opvQ
	(envelope-from <stable+bounces-220423-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:39:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2C51C6152
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D2BD32C3E8D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B66E3B234F;
	Sat, 28 Feb 2026 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDeAcyhG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16143B2347;
	Sat, 28 Feb 2026 17:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300313; cv=none; b=Q8AH8QBnDit0QFx2hjA3D5yv/KlqZvYgUysoP9taNYrC7EQqyeylGl0S5HZboBjQgOpIMWBxVW6b0TwoLRTFHvrFVSL5q1NdIcQMm0M6I72NLp8B3LR2N5V/6+sZ8Kv4Ho7Llery6BvpRkvvBX4YNVp5Ht1eLDjQc/XCdwyD4G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300313; c=relaxed/simple;
	bh=40egpjyRHcRVLO2dddaJco3VVBOopW7krOiKVMOarSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAg78JTHnZXj2TzwjDPg7R31IIfV/XhM+KcxH+1zPSptbQHA94MhyqAYj1ZlLQ5CxxCHpMptlZz52BuQP7BqzQkgTN1Wzs/e7Aa2siN8zQv/JhncaPbY0F7f1+0VScz7o9+bckyPLCUUIFHYepedM+MCfT/WMTOXmtLW55QUQu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDeAcyhG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB788C19424;
	Sat, 28 Feb 2026 17:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300313;
	bh=40egpjyRHcRVLO2dddaJco3VVBOopW7krOiKVMOarSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cDeAcyhG0qvkfTXrCWa3uv/dvZZPXy37VYne41n2DvFM7meEIhHDa8zotWrg2fIt9
	 VQDLRt6BXjajDIWPbe6ytArk5jj/PhA+VfwPEv1UKibR7sRcSvHGhlboW8uV7jadhG
	 h3hLliJWXAsUz2oD9dxlxxn5gNcWUKMs0eHLBeyBx0od7LQspqmALoy3w5x0VyzvOQ
	 KLUGAIkdavCp02lTRh5WU+n0oXrwi1JeBVf3UtCC2IxGjWTfQaf60q5Vgs22yeXKIe
	 piL6WuuzP9ptZiEcFsCqTBCgFX6r+xfsAUdYwxmB/4LqwHQc2QZjoSQhTJFMRfT2pf
	 TybVvXNkq4+Pw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Henry Tseng <henrytseng@qnap.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 344/844] ata: libata: avoid long timeouts on hot-unplugged SATA DAS
Date: Sat, 28 Feb 2026 12:24:17 -0500
Message-ID: <20260228173244.1509663-345-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220423-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6E2C51C6152
X-Rspamd-Action: no action

From: Henry Tseng <henrytseng@qnap.com>

[ Upstream commit 151cabd140322205e27dae5c4bbf261ede0056e3 ]

When a SATA DAS enclosure is connected behind a Thunderbolt PCIe
switch, hot-unplugging the whole enclosure causes pciehp to tear down
the PCI hierarchy before the SCSI layer issues SYNCHRONIZE CACHE and
START STOP UNIT for the disks.

libata still queues these commands and the AHCI driver tries to access
the HBA registers even though the PCI channel is already offline. This
results in a series of timeouts and error recovery attempts, e.g.:

  [  824.778346] pcieport 0000:00:07.0: pciehp: Slot(14): Link Down
  [  891.612720] ata8.00: qc timeout after 5000 msecs (cmd 0xec)
  [  902.876501] ata8.00: qc timeout after 10000 msecs (cmd 0xec)
  [  934.107998] ata8.00: qc timeout after 30000 msecs (cmd 0xec)
  [  936.206431] sd 7:0:0:0: [sda] Synchronize Cache(10) failed:
      Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
  ...
  [ 1006.298356] ata1.00: qc timeout after 5000 msecs (cmd 0xec)
  [ 1017.561926] ata1.00: qc timeout after 10000 msecs (cmd 0xec)
  [ 1048.791790] ata1.00: qc timeout after 30000 msecs (cmd 0xec)
  [ 1050.890035] sd 0:0:0:0: [sdb] Synchronize Cache(10) failed:
      Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK

With this patch applied, the same hot-unplug looks like:

  [   59.965496] pcieport 0000:00:07.0: pciehp: Slot(14): Link Down
  [   60.002502] sd 7:0:0:0: [sda] Synchronize Cache(10) failed:
      Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
  ...
  [   60.103050] sd 0:0:0:0: [sdb] Synchronize Cache(10) failed:
      Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK

In this test setup with two disks, the hot-unplug sequence shrinks from
about 226 seconds (~3.8 minutes) between the Link Down event and the
last SYNCHRONIZE CACHE failure to under a second. Without this patch the
total delay grows roughly with the number of disks, because each disk
gets its own SYNCHRONIZE CACHE and qc timeout series.

If the underlying PCI device is already gone, these commands cannot
succeed anyway. Avoid issuing them by introducing
ata_adapter_is_online(), which checks pci_channel_offline() for
PCI-based hosts. It is used from ata_scsi_find_dev() to return NULL,
causing the SCSI layer to fail new commands with DID_BAD_TARGET
immediately, and from ata_qc_issue() to bail out before touching the
HBA registers.

Since such failures would otherwise trigger libata error handling,
ata_adapter_is_online() is also consulted from ata_scsi_port_error_handler().
When the adapter is offline, libata skips ap->ops->error_handler(ap) and
completes error handling using the existing path, rather than running
a full EH sequence against a dead adapter.

With this change, SYNCHRONIZE CACHE and START STOP UNIT commands
issued during hot-unplug fail quickly once the PCI channel is offline,
without qc timeout spam or long libata EH delays.

Suggested-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Henry Tseng <henrytseng@qnap.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-core.c | 24 ++++++++++++++++++++++++
 drivers/ata/libata-eh.c   |  3 ++-
 drivers/ata/libata-scsi.c |  3 +++
 drivers/ata/libata.h      |  1 +
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 50dfce8d8bba0..db74417db75d9 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2359,6 +2359,24 @@ static bool ata_dev_check_adapter(struct ata_device *dev,
 	return false;
 }
 
+bool ata_adapter_is_online(struct ata_port *ap)
+{
+	struct device *dev;
+
+	if (!ap || !ap->host)
+		return false;
+
+	dev = ap->host->dev;
+	if (!dev)
+		return false;
+
+	if (dev_is_pci(dev) &&
+	    pci_channel_offline(to_pci_dev(dev)))
+		return false;
+
+	return true;
+}
+
 static int ata_dev_config_ncq(struct ata_device *dev,
 			       char *desc, size_t desc_sz)
 {
@@ -5135,6 +5153,12 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 	qc->flags |= ATA_QCFLAG_ACTIVE;
 	ap->qc_active |= 1ULL << qc->tag;
 
+	/* Make sure the device is still accessible. */
+	if (!ata_adapter_is_online(ap)) {
+		qc->err_mask |= AC_ERR_HOST_BUS;
+		goto sys_err;
+	}
+
 	/*
 	 * We guarantee to LLDs that they will have at least one
 	 * non-zero sg if the command is a data command.
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 258e657f3527c..b373cceb95d23 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -752,7 +752,8 @@ void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap)
 	spin_unlock_irqrestore(ap->lock, flags);
 
 	/* invoke EH, skip if unloading or suspended */
-	if (!(ap->pflags & (ATA_PFLAG_UNLOADING | ATA_PFLAG_SUSPENDED)))
+	if (!(ap->pflags & (ATA_PFLAG_UNLOADING | ATA_PFLAG_SUSPENDED)) &&
+	    ata_adapter_is_online(ap))
 		ap->ops->error_handler(ap);
 	else {
 		/* if unloading, commence suicide */
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 5f9abeb7b2a88..6b954efa9adb1 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3094,6 +3094,9 @@ ata_scsi_find_dev(struct ata_port *ap, const struct scsi_device *scsidev)
 {
 	struct ata_device *dev = __ata_scsi_find_dev(ap, scsidev);
 
+	if (!ata_adapter_is_online(ap))
+		return NULL;
+
 	if (unlikely(!dev || !ata_dev_enabled(dev)))
 		return NULL;
 
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 60a675df61dc7..9b4e578ad07ec 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -94,6 +94,7 @@ extern int atapi_check_dma(struct ata_queued_cmd *qc);
 extern void swap_buf_le16(u16 *buf, unsigned int buf_words);
 extern bool ata_phys_link_online(struct ata_link *link);
 extern bool ata_phys_link_offline(struct ata_link *link);
+bool ata_adapter_is_online(struct ata_port *ap);
 extern void ata_dev_init(struct ata_device *dev);
 extern void ata_link_init(struct ata_port *ap, struct ata_link *link, int pmp);
 extern int sata_link_init_spd(struct ata_link *link);
-- 
2.51.0


