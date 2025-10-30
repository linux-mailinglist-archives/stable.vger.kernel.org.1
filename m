Return-Path: <stable+bounces-191770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD495C2277E
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 22:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77E564EE7CC
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 21:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06A6335558;
	Thu, 30 Oct 2025 21:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8Xp2nD+"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C839A330B1E
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 21:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761860937; cv=none; b=N3M3fZNuoripoDOJpwICU+F5qwr1X6Ql80g/z2urFsfpPQirjvrAMEgRDsxZwGl1L4E4yb6XQM0/ZvCDn3jTLf74wh6Cjbv88U/Tnn+OB2SpANPbdYaiT8yshh2p/U8ofmAqB428CifZfV3eXB7EhMD8CIwt+UmBgbRHhlimqpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761860937; c=relaxed/simple;
	bh=RjxZGrfsfCvc5Bg8rwRRAdtccZ1YoZqKvvDa+D53Uw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nc+GPHpa26Y6sRqWGRM7KWL30sKiy2we0XAdv5SnMCSH8dSqaqX4KG19bCKhTo1Q1LCfBJTeuh/irlrPt4OTrYbPAkZMXeXOHUyu1IC+ylc8SMo60Gk8ps1plOxS2ZOmIWuTmBaIruNmYjYFAdpxFTpVFLngw+8uzDYM2VIgT48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A8Xp2nD+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761860934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9LjL0vS/hX9NBhAzvP1BiBjPYdiWFiLByshADcjU7L0=;
	b=A8Xp2nD+S2Tze5uLkGp+vX9bTWYNdbZ7daGZ1aTABIO065E+snvSvNIRMLbu5IvBt4XeJg
	x0NY35JV68YgspFuzSgQvz1fw1bympS7oeUslqjm3XMhPn3xUkLu+lGrT3JMec1zkerTm+
	hoWSP0v6cGzfwd+PtdNwcoUkRtdy6qE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-44B3hZqLOIedjftmPMMjJw-1; Thu,
 30 Oct 2025 17:48:51 -0400
X-MC-Unique: 44B3hZqLOIedjftmPMMjJw-1
X-Mimecast-MFC-AGG-ID: 44B3hZqLOIedjftmPMMjJw_1761860930
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3D921955E8F;
	Thu, 30 Oct 2025 21:48:49 +0000 (UTC)
Received: from desnesn-thinkpadp16vgen1.rmtbr.csb (unknown [10.96.134.41])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C5E1019560A2;
	Thu, 30 Oct 2025 21:48:47 +0000 (UTC)
From: Desnes Nunes <desnesn@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	stern@rowland.harvard.edu,
	Desnes Nunes <desnesn@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: storage: Fix memory leak in USB bulk transport
Date: Thu, 30 Oct 2025 18:48:33 -0300
Message-ID: <20251030214833.44904-1-desnesn@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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

v2: Use the same code style found on usb_stor_Bulk_transport()

Fixes: a45b599ad808 ("scsi: sg: allocate with __GFP_ZERO in sg_build_indirect()")
Cc: stable@vger.kernel.org
Signed-off-by: Desnes Nunes <desnesn@redhat.com>
---
 drivers/usb/storage/transport.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
index 1aa1bd26c81f..ee6b89f7f9ac 100644
--- a/drivers/usb/storage/transport.c
+++ b/drivers/usb/storage/transport.c
@@ -1200,7 +1200,19 @@ int usb_stor_Bulk_transport(struct scsi_cmnd *srb, struct us_data *us)
 						US_BULK_CS_WRAP_LEN &&
 					bcs->Signature ==
 						cpu_to_le32(US_BULK_CS_SIGN)) {
+				unsigned char buf[US_BULK_CS_WRAP_LEN];
+
+				sg = NULL;
+				offset = 0;
+				memset(buf, 0, US_BULK_CS_WRAP_LEN);
 				usb_stor_dbg(us, "Device skipped data phase\n");
+
+				if (usb_stor_access_xfer_buf(buf,
+						US_BULK_CS_WRAP_LEN, srb, &sg,
+						&offset, TO_XFER_BUF) !=
+							US_BULK_CS_WRAP_LEN)
+					usb_stor_dbg(us, "Failed to clear CSW data\n");
+
 				scsi_set_resid(srb, transfer_length);
 				goto skipped_data_phase;
 			}
-- 
2.51.0


