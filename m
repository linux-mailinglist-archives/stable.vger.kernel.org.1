Return-Path: <stable+bounces-191671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BACF6C1CFBB
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 20:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9AC84051FD
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 19:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE8E3596E6;
	Wed, 29 Oct 2025 19:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DaKp2SN4"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A362F12BB
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 19:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761765341; cv=none; b=BZBFe1f2MXY0ZTTQoeEfuceoFzRUClAfqjBSfWJBewzle2kMfi4zNDVtYwZSjy2+tM2w6tcV2zHymi+Lk+APUd7xcOV08AKboIx8DFCZsRbGEtwHpqRbLcj5z4GnEovlMvq1VKkM1VzURIGMUnR8fJsZXAo8DHBEmzRgsgq3Fg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761765341; c=relaxed/simple;
	bh=W31WFCUm45PEMh9IQGksIpRZSuVLACUH24nusPmltPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TL7ztvBGCI30WMt0Jsg5s6WE8jpaoNum8Zo+iz3WAjU6uq7Rw5vxOigkxlJ1a5Fw0BEM6klF95rU0dMibd92dQr2xZZYJCgxCEHGBMjnz0XgR29TZhVZ2zZnBjngnsR2iaO9aYUCA/NiVXKQ23WC6ovMdJKzfwwJJL6ogRPFbRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DaKp2SN4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761765337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CD9l1/tOtFnGfm02mvhYsGXz7YDlKTtUi2I3rLktGGc=;
	b=DaKp2SN4eHYMZe35BlnT8ct+i/yomBoXTsjjvJb5ju4VXRivsE9ohCDPLb/Nhorsey/qa3
	Jd2wKbsKk0VU7Nd07Cas32pD3x3uCVAsPy5tKdN1N8hALGGrWoyNdSuhSaH4LCJyO2gmws
	DPQWub4AApGeBjiq7IgzbnequxAHs4s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-j0hjFY2ZOaCz_shmAqNbOg-1; Wed,
 29 Oct 2025 15:15:34 -0400
X-MC-Unique: j0hjFY2ZOaCz_shmAqNbOg-1
X-Mimecast-MFC-AGG-ID: j0hjFY2ZOaCz_shmAqNbOg_1761765333
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B539A180899F;
	Wed, 29 Oct 2025 19:15:32 +0000 (UTC)
Received: from desnesn-thinkpadp16vgen1.rmtbr.csb (unknown [10.96.134.139])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 821451955F1B;
	Wed, 29 Oct 2025 19:15:30 +0000 (UTC)
From: Desnes Nunes <desnesn@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	stern@rowland.harvard.edu,
	Desnes Nunes <desnesn@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] usb: storage: Fix memory leak in USB bulk transport
Date: Wed, 29 Oct 2025 16:14:13 -0300
Message-ID: <20251029191414.410442-2-desnesn@redhat.com>
In-Reply-To: <20251029191414.410442-1-desnesn@redhat.com>
References: <20251029191414.410442-1-desnesn@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

A kernel memory leak was identified by the 'ioctl_sg01' test from Linux
Test Project (LTP). The following bytes were maily observed: 0x53425355.

When USB storage devices incorrectly skip the data phase with status data,
the code extracts/validates the CSW from the sg buffer, but fails to clear
it afterwards. This leaves status protocol data in srb's transfer buffer,
such as the US_BULK_CS_SIGN 'USBS' signature observed here. Thus, this
leads to USB protocols leaks to user space through SCSI generic (/dev/sg*)
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
 drivers/usb/storage/transport.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
index 1aa1bd26c81f..8e9f6459e197 100644
--- a/drivers/usb/storage/transport.c
+++ b/drivers/usb/storage/transport.c
@@ -1200,7 +1200,17 @@ int usb_stor_Bulk_transport(struct scsi_cmnd *srb, struct us_data *us)
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
+				if (usb_stor_access_xfer_buf(buf, US_BULK_CS_WRAP_LEN, srb,
+						&sg, &offset, TO_XFER_BUF) != US_BULK_CS_WRAP_LEN)
+					usb_stor_dbg(us, "Failed to clear CSW data\n");
+
 				scsi_set_resid(srb, transfer_length);
 				goto skipped_data_phase;
 			}
-- 
2.51.0


