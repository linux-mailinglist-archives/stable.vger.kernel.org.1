Return-Path: <stable+bounces-255135-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIqeLnWdGGr+lQgAu9opvQ
	(envelope-from <stable+bounces-255135-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:54:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F1C5F7683
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 268A730078E7
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812253254A8;
	Thu, 28 May 2026 19:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qPucL//U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7FF318EE1;
	Thu, 28 May 2026 19:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998064; cv=none; b=eJw6l9eZvclTUJorPx1Iux8kR6AoGALXhiyTOZHaAVPAPKNaNTry9DLR/tRdbwPiNV26Ybct3ya2pvxUvh1qy5z+6CtdblFcAJjo2gW4PHd+58C+2P5HZXrQMhAbch4boEyZdk13pbupxCsWYc75l5ugVoVrBF7GzTbqGG+K9bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998064; c=relaxed/simple;
	bh=ls28b/BLIhKrZ9jAK9krZ4Fs1lhkoiPhfbKXAn5MBGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpuPMMZgzb3x/QOKyfxYsWDDwMHUzy2FkwKMibzWOvoGbX726emAGIJW5gfGkrc5x3RhzubVjD2BkO3eDP9DwXPoPJlHeQCQW5Mk7z/RAiHYEUDNP8y+WSi7Fgn/vD5dZxDVARKywMXbHQgn8Sj2rJmiCIBiqWuNuee59ImPeX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qPucL//U; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5842E1F000E9;
	Thu, 28 May 2026 19:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998062;
	bh=byfg8NisFehQQdzNsY6mDs66qrnRIFUfpas/MakQ1yU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qPucL//USowoq2coXrMG22++i3AO45tbhKvb2/9c8Lt2TQZ+LDXDT6xaKMfSdLiJQ
	 W7l0BwfAZXWRv0KxOBpp1n5sf25TAxKkP1+k6UhiCymsFOliD+bbblRX/HWn815yLk
	 JG+lHkm6zMiDPIF6KMEao8agLxbl4dFPKQWHZHx0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tommy Kelly <linux@tkel.ly>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 7.0 007/461] ata: libata-scsi: do not use the deferred QC feature on PMPs with CBS
Date: Thu, 28 May 2026 21:42:16 +0200
Message-ID: <20260528194647.052568474@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255135-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tkel.ly:email]
X-Rspamd-Queue-Id: 37F1C5F7683
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Cassel <cassel@kernel.org>

commit f233124fb36cd57ef09f96d517a38ab4b902e15e upstream.

When using Port Multipliers (PMPs) with Command-Based Switching (CBS), you
can only issue commands to one link at a time. For PMPs with CBS, there is
already code to handle commands being sent to different links in
sata_pmp_qc_defer_cmd_switch() using ap->excl_link. sata_sil24 also makes
use of ap->excl_link.

A user on the list reported that commit 0ea84089dbf6 ("ata: libata-scsi:
avoid Non-NCQ command starvation") broke PMPs with CBS. The commit
introduced code that stores a deferred qc in ap->deferred_qc, to later be
issued via a workqueue. It turns out that this change is incompatible with
the existing ap->excl_link handling used by PMPs with CBS.

Thus, modify sata_pmp_qc_defer_cmd_switch() and sil24_qc_defer() to return
ATA_DEFER_LINK_EXCL, and make sure that the deferred QC handling via
workqueue is not used for this return value.

This way, PMPs with CBS will work once again. Note that the starvation
referenced in commit 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ
command starvation") can only happen on libsas ports, and libsas does not
support Port Multipliers, thus there is no harm of reverting back to the
previous way of deferring commands for PMPs with CBS.

Non-libsas ports connected to anything but a PMP with CBS (e.g. a normal
drive or a PMP with FBS) will continue using the deferred workqueue, since
it does result in lower completion latencies for non-NCQ commands, even
though the workqueue is not strictly needed to avoid starvation for
non-libsas ports.

If we want to modify the scope of the workqueue issuing to also handle
PMPs with CBS, then we should ensure that we can save both NCQ and non-NCQ
commands in ap->deferred_qc, while also removing the existing PMP CBS
handling using ap->excl_link, such that we don't duplicate features.

While at it, also add a comment explaining how the ap->excl_link mechanism
works.

Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
Tested-by: Tommy Kelly <linux@tkel.ly>
Reported-by: Tommy Kelly <linux@tkel.ly>
Closes: https://lore.kernel.org/linux-ide/ce09cc21-a8e9-4845-b205-35411e22fba9@tkel.ly/
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/libata-pmp.c  |   13 ++++++++++++-
 drivers/ata/libata-scsi.c |    8 ++++++++
 drivers/ata/sata_sil24.c  |    6 +++++-
 include/linux/libata.h    |    1 +
 4 files changed, 26 insertions(+), 2 deletions(-)

--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -110,13 +110,24 @@ int sata_pmp_qc_defer_cmd_switch(struct
 {
 	struct ata_link *link = qc->dev->link;
 	struct ata_port *ap = link->ap;
+	int ret;
 
 	if (ap->excl_link == NULL || ap->excl_link == link) {
 		if (ap->nr_active_links == 0 || ata_link_active(link)) {
 			qc->flags |= ATA_QCFLAG_CLEAR_EXCL;
-			return ata_std_qc_defer(qc);
+			ret = ata_std_qc_defer(qc);
+			if (ret == ATA_DEFER_LINK)
+				return ATA_DEFER_LINK_EXCL;
+			return ret;
 		}
 
+		/*
+		 * Note: ap->excl_link contains the link that is next in line,
+		 * i.e. implicit round robin. If there is only one link
+		 * dispatching, ap->excl_link will be left unclaimed, allowing
+		 * other links to set ap->excl_link, ensuring that the currently
+		 * active link cannot queue any more.
+		 */
 		ap->excl_link = link;
 	}
 
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1788,6 +1788,14 @@ static int ata_scsi_qc_issue(struct ata_
 	case ATA_DEFER_LINK:
 		ret = SCSI_MLQUEUE_DEVICE_BUSY;
 		goto defer_qc;
+	case ATA_DEFER_LINK_EXCL:
+		/*
+		 * Drivers making use of ap->excl_link cannot store the QC in
+		 * ap->deferred_qc, because the ap->excl_link handling is
+		 * incompatible with the ap->deferred_qc workqueue handling.
+		 */
+		ret = SCSI_MLQUEUE_DEVICE_BUSY;
+		goto free_qc;
 	case ATA_DEFER_PORT:
 		ret = SCSI_MLQUEUE_HOST_BUSY;
 		goto free_qc;
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -789,6 +789,7 @@ static int sil24_qc_defer(struct ata_que
 	struct ata_link *link = qc->dev->link;
 	struct ata_port *ap = link->ap;
 	u8 prot = qc->tf.protocol;
+	int ret;
 
 	/*
 	 * There is a bug in the chip:
@@ -826,7 +827,10 @@ static int sil24_qc_defer(struct ata_que
 		qc->flags |= ATA_QCFLAG_CLEAR_EXCL;
 	}
 
-	return ata_std_qc_defer(qc);
+	ret = ata_std_qc_defer(qc);
+	if (ret == ATA_DEFER_LINK)
+		return ATA_DEFER_LINK_EXCL;
+	return ret;
 }
 
 static enum ata_completion_errors sil24_qc_prep(struct ata_queued_cmd *qc)
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -371,6 +371,7 @@ enum {
 	/* return values for ->qc_defer */
 	ATA_DEFER_LINK		= 1,
 	ATA_DEFER_PORT		= 2,
+	ATA_DEFER_LINK_EXCL	= 3,
 
 	/* desc_len for ata_eh_info and context */
 	ATA_EH_DESC_LEN		= 80,



