Return-Path: <stable+bounces-191785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D2BC23408
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 05:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AB2D1A25345
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 04:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD2C2BDC2A;
	Fri, 31 Oct 2025 04:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MI8c0pOm"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C01221F03
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 04:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761885294; cv=none; b=IUtXXPHRg+39Q4auOgG72+zS4yfAz1LKVjrCiv/uLiT+D9P8Blnk3tH9VwUXfnJ54SKEij8YwUr7eX2aVWw2FV+1hos7zDiHnEZ/k0jz7qoOFpzUQNq6sYytkRZUHS/Rdo8zsdVUyEC950JGnN0O9YeuYuCS9IxjJ/GkjpMR70E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761885294; c=relaxed/simple;
	bh=eVnAfVRq2krsx7QKJdrfJqtPm5yDsk9NtGCxS32gXZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ghAwxf64FSleJFF7Pf6ZR6Y8rY8wv9W1jloyl0jN7oYGFrvtjdJtUt2p7k0u4dRr8eXiaocyLpAjmnuA4CFtjxwbmUZxSyo/pDWJUQPl/MsAUY7ysKAFpPdmS7pYzZn3JwwybVGIzxNav+zTGCipm7/Ms2bFWFK7xzQ9yvCySJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MI8c0pOm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761885291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HL1yyGOQ4hc+ORZk21QBPnBBz7dH47bfSZ5mCbTA1dU=;
	b=MI8c0pOm+X6EJEobhcCrbQgbFEQHgSzqCVMjnT6p7+18nMSGZnWrFJmhxNbxWpmyhZBHtB
	YR7vRFLthmr5fjA6NDsGTbfn8mbVB/W5SBGQo3wacVp4dZnOIq9ACnHp4Kv5lcEElCSb7s
	3MwLsbD5UZYpzJM0R/cSf7q1xpy5fGU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-XwdALYylPtqEA05ou3HP-Q-1; Fri,
 31 Oct 2025 00:34:48 -0400
X-MC-Unique: XwdALYylPtqEA05ou3HP-Q-1
X-Mimecast-MFC-AGG-ID: XwdALYylPtqEA05ou3HP-Q_1761885286
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9BB7F1828AF3;
	Fri, 31 Oct 2025 04:34:46 +0000 (UTC)
Received: from desnesn-thinkpadp16vgen1.rmtbr.csb (unknown [10.96.134.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4013E30001A1;
	Fri, 31 Oct 2025 04:34:43 +0000 (UTC)
From: Desnes Nunes <desnesn@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	stern@rowland.harvard.edu,
	Desnes Nunes <desnesn@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] usb: storage: Fix memory leak in USB bulk transport
Date: Fri, 31 Oct 2025 01:34:36 -0300
Message-ID: <20251031043436.55929-1-desnesn@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
Cc: stable@vger.kernel.org
Signed-off-by: Desnes Nunes <desnesn@redhat.com>
---
V2->V3: Changed memset to use sizeof(buf) and added a comment about the leak
V1->V2: Used the same code style found on usb_stor_Bulk_transport()

 drivers/usb/storage/transport.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
index 1aa1bd26c81f..9a4bf86e7b6a 100644
--- a/drivers/usb/storage/transport.c
+++ b/drivers/usb/storage/transport.c
@@ -1200,7 +1200,23 @@ int usb_stor_Bulk_transport(struct scsi_cmnd *srb, struct us_data *us)
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
-- 
2.51.0


