Return-Path: <stable+bounces-177712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1F0B43763
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 11:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165DC1C22870
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 09:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E112F83A2;
	Thu,  4 Sep 2025 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aKqkOLQM"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B96B2F746E
	for <stable@vger.kernel.org>; Thu,  4 Sep 2025 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978978; cv=none; b=H9frahI6lnobbYW9odu0E8oEIJmvwSPka8RXqQSwCSZWARBESUHFksThJKVu9uLSHLKHtshuY02fL+z7txcXFvMsOfCnn1K0dzlhbcfh4vS2PPuEMTEFcMbUNhUgx59JLROMUwf7TOucMaohPuxRjkbwfrOodwA3LnWU4eHuDg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978978; c=relaxed/simple;
	bh=dKCx85s/6PwtEqwRZtinMLXnxG+yVQJWnrxtNuzd434=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NBF+7DpXHXYLYG5/CvbCgy1l5Ge9UrjHQDJc/s02G1qqYzrfnU07HIAfdkKAf7xMPHpR6HnVrT/QXUyBnSCTn2x/D8XKzUrmQyMS4OUWddArLIcLv4cKQZtFzj5RLuy207NIjCbK4mBnmq++wsCdWJ7eqNdbUVxSQ0H4OPSX0Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aKqkOLQM; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756978963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lHA5A5Q3mB9GbMIkMKtbrVhd8m+plyRqseHgs1TRbeY=;
	b=aKqkOLQMgbO4+7frBfBUbcoiWzeR8dN6X7akim7VfBkIUKSOttKqvsiL/dCdtKM0mZ5h4U
	YCgZgqlhDrmgXiIYADVfwsaiACYxWwmQphtlTlFe3gPMvMnXg83tNwlSc04KaGwiSeguzR
	c/pYA2Rllbm4v2bUeu9mUZQ5vGhm5yY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Don Brace <don.brace@microchip.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Alex Chiang <achiang@hp.com>,
	James Bottomley <James.Bottomley@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Stephen M. Cameron" <scameron@beardog.cce.hp.com>,
	Mike Miller <mikem@beardog.cce.hp.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	storagedev@microchip.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: hpsa: Fix potential memory leak in hpsa_big_passthru_ioctl()
Date: Thu,  4 Sep 2025 11:41:31 +0200
Message-ID: <20250904094130.276350-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kmalloc() followed by copy_from_user() with memdup_user() to fix
a memory leak that occurs when copy_from_user(buff[sg_used],,) fails and
the 'cleanup1:' path does not free the memory for 'buff[sg_used]'. Using
memdup_user() avoids this by freeing the memory internally.

Since memdup_user() already allocates memory, use kzalloc() in the else
branch instead of manually zeroing 'buff[sg_used]' using memset(0).

Cc: stable@vger.kernel.org
Fixes: edd163687ea5 ("[SCSI] hpsa: add driver for HP Smart Array controllers.")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/scsi/hpsa.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index c73a71ac3c29..1c6161d0b85c 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -6522,18 +6522,21 @@ static int hpsa_big_passthru_ioctl(struct ctlr_info *h,
 	while (left) {
 		sz = (left > ioc->malloc_size) ? ioc->malloc_size : left;
 		buff_size[sg_used] = sz;
-		buff[sg_used] = kmalloc(sz, GFP_KERNEL);
-		if (buff[sg_used] == NULL) {
-			status = -ENOMEM;
-			goto cleanup1;
-		}
+
 		if (ioc->Request.Type.Direction & XFER_WRITE) {
-			if (copy_from_user(buff[sg_used], data_ptr, sz)) {
-				status = -EFAULT;
+			buff[sg_used] = memdup_user(data_ptr, sz);
+			if (IS_ERR(buff[sg_used])) {
+				status = PTR_ERR(buff[sg_used]);
 				goto cleanup1;
 			}
-		} else
-			memset(buff[sg_used], 0, sz);
+		} else {
+			buff[sg_used] = kzalloc(sz, GFP_KERNEL);
+			if (!buff[sg_used]) {
+				status = -ENOMEM;
+				goto cleanup1;
+			}
+		}
+
 		left -= sz;
 		data_ptr += sz;
 		sg_used++;
-- 
2.51.0


