Return-Path: <stable+bounces-198673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69426CA17D7
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 20:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 546B530690D4
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 19:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B4D33A6F3;
	Wed,  3 Dec 2025 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yr2da4pX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30483303A35;
	Wed,  3 Dec 2025 15:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777313; cv=none; b=kkgk6nmMD/plmMqdofR7a49aRiSPZSa0jT2y0dCJt/Uj/NhCoY5zCJo7fCLoRnaB7o00eH5HPjScCnSPlb++FrZ4fJaPKofAs9s2Qeyux8Bs2/cZjLwRv+rnoruACjpsulJlY+Rrzskeczw3VSuHos7pfb2TCbi8j6nXErnkZuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777313; c=relaxed/simple;
	bh=1wsTpKpUelKvUIyuGtskxe6ryCyGoLz7ael0bfVAFbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFN5dKbpNrY3qREWHDHKPIH4rPJFvCOWeijnk5USHVp7nXGlb3HQ2J8xwIsuk1JgvrBOeU3/gD7l6lM7yiNDV0hGf+sSdP926Re/dHpU3/A9MNiM1DwRiUY5ibmFJHR7pgi06PC/jCo6t2FC/7V9QhWwUwm4XEbwjFUuvGXMvCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yr2da4pX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BB9C4CEF5;
	Wed,  3 Dec 2025 15:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764777312;
	bh=1wsTpKpUelKvUIyuGtskxe6ryCyGoLz7ael0bfVAFbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yr2da4pXnXmvYrpMwi1U9HFfvJen5jhd6/axaO3sgN/dpPmkgPZi4nTgmatqn+3mZ
	 9o33Ho1JSeB2G9BEOflbl9l/ZWDXfYf/O6sYiOEZ0AcCBgkTlIuc+u4RDpPZNW2Bl3
	 cgcViOldMSlqwlgahCgIhpR6DsptYCi56295mhSY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Desnes Nunes <desnesn@redhat.com>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 6.17 113/146] usb: storage: Fix memory leak in USB bulk transport
Date: Wed,  3 Dec 2025 16:28:11 +0100
Message-ID: <20251203152350.600636800@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152346.456176474@linuxfoundation.org>
References: <20251203152346.456176474@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Desnes Nunes <desnesn@redhat.com>

commit 41e99fe2005182139b1058db71f0d241f8f0078c upstream.

A kernel memory leak was identified by the 'ioctl_sg01' test from Linux
Test Project (LTP). The following bytes were mainly observed: 0x53425355.

When USB storage devices incorrectly skip the data phase with status data,
the code extracts/validates the CSW from the sg buffer, but fails to clear
it afterwards. This leaves status protocol data in srb's transfer buffer,
such as the US_BULK_CS_SIGN 'USBS' signature observed here. Thus, this can
lead to USB protocols leaks to user space through SCSI generic (/dev/sg*)
interfaces, such as the one seen here when the LTP test requested 512 KiB.

Fix the leak by zeroing the CSW data in srb's transfer buffer immediately
after the validation of devices that skip data phase.

Note: Differently from CVE-2018-1000204, which fixed a big leak by zero-
ing pages at allocation time, this leak occurs after allocation, when USB
protocol data is written to already-allocated sg pages.

Fixes: a45b599ad808 ("scsi: sg: allocate with __GFP_ZERO in sg_build_indirect()")
Cc: stable <stable@kernel.org>
Signed-off-by: Desnes Nunes <desnesn@redhat.com>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://patch.msgid.link/20251031043436.55929-1-desnesn@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/storage/transport.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/drivers/usb/storage/transport.c
+++ b/drivers/usb/storage/transport.c
@@ -1200,7 +1200,23 @@ int usb_stor_Bulk_transport(struct scsi_
 						US_BULK_CS_WRAP_LEN &&
 					bcs->Signature ==
 						cpu_to_le32(US_BULK_CS_SIGN)) {
+				unsigned char buf[US_BULK_CS_WRAP_LEN];
+
 				usb_stor_dbg(us, "Device skipped data phase\n");
+
+				/*
+				 * Devices skipping data phase might leave CSW data in srb's
+				 * transfer buffer. Zero it to prevent USB protocol leakage.
+				 */
+				sg = NULL;
+				offset = 0;
+				memset(buf, 0, sizeof(buf));
+				if (usb_stor_access_xfer_buf(buf,
+						US_BULK_CS_WRAP_LEN, srb, &sg,
+						&offset, TO_XFER_BUF) !=
+							US_BULK_CS_WRAP_LEN)
+					usb_stor_dbg(us, "Failed to clear CSW data\n");
+
 				scsi_set_resid(srb, transfer_length);
 				goto skipped_data_phase;
 			}



