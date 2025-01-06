Return-Path: <stable+bounces-107533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCF5A02C60
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D07F01670BF
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9804E39FCE;
	Mon,  6 Jan 2025 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UOZ83aKN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529C213AD20;
	Mon,  6 Jan 2025 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178759; cv=none; b=F6tpHs88d8/ogD/JlI9QkN3GKpe7AWbii/NwMa3vPTdWxUAbrmjWvTBOzw17vkLEk+8n0HHpoLLPqZo9ifWXlGrUUS7gSzeMxFhXPOv0QidL2IrY6JSRPBSffrQkXM0RQIqfe6CwRv6A3SyrByx36quNIyluSW0I6ANgJZCHiWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178759; c=relaxed/simple;
	bh=aJZyl3JRfehfEo25KXRD1hgUqTH5x5tQDdJd4ydN1JU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yvw8j9/WlZPc6nHmBt8BHGCPhpvTPlDOvXmVEc+wgc124CJhMxiWPmolBmCUiHZx6w41VPBNzWXUMd+8a5MBNUaO9HYnVH1JDnwUv1Xo+nI890EVLk6l7IJggBMnieYnRAQD9DuJrEr0exKq1CwuIVJrV4qQ73AJZx1MuoGDoOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UOZ83aKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D6DC4CED2;
	Mon,  6 Jan 2025 15:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736178758;
	bh=aJZyl3JRfehfEo25KXRD1hgUqTH5x5tQDdJd4ydN1JU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UOZ83aKNevEb4CV9hD1vU6C6GZBaB3cWTvkgWrw2EATNCpehcEfCKdWnfV3Usp+Wb
	 SDUg8zUK5mNGXsS/XuGmh6vqnmMeH0q2mMHg/rXNEIG+lTWU8kxzD7tniGEWNNUram
	 qO2ZB79UHNxKU+RRmai6tz8Mq4BxDLjudhxZEN8g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Kelley <mhklinux@outlook.com>,
	Cathy Avery <cavery@redhat.com>,
	"Ewan D. Milne" <emilne@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 083/168] scsi: storvsc: Do not flag MAINTENANCE_IN return of SRB_STATUS_DATA_OVERRUN as an error
Date: Mon,  6 Jan 2025 16:16:31 +0100
Message-ID: <20250106151141.598069673@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151138.451846855@linuxfoundation.org>
References: <20250106151138.451846855@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cathy Avery <cavery@redhat.com>

[ Upstream commit b1aee7f034615b6824d2c70ddb37ef9fc23493b7 ]

This partially reverts commit 812fe6420a6e ("scsi: storvsc: Handle
additional SRB status values").

HyperV does not support MAINTENANCE_IN resulting in FC passthrough
returning the SRB_STATUS_DATA_OVERRUN value. Now that
SRB_STATUS_DATA_OVERRUN is treated as an error, multipath ALUA paths go
into a faulty state as multipath ALUA submits RTPG commands via
MAINTENANCE_IN.

[    3.215560] hv_storvsc 1d69d403-9692-4460-89f9-a8cbcc0f94f3:
tag#230 cmd 0xa3 status: scsi 0x0 srb 0x12 hv 0xc0000001
[    3.215572] scsi 1:0:0:32: alua: rtpg failed, result 458752

Make MAINTENANCE_IN return success to avoid the error path as is
currently done with INQUIRY and MODE_SENSE.

Suggested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Cathy Avery <cavery@redhat.com>
Link: https://lore.kernel.org/r/20241127181324.3318443-1-cavery@redhat.com
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/storvsc_drv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 4ea119afd9db..ff1735e3127d 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -155,6 +155,8 @@ static int sense_buffer_size = PRE_WIN8_STORVSC_SENSE_BUFFER_SIZE;
 */
 static int vmstor_proto_version;
 
+static bool hv_dev_is_fc(struct hv_device *hv_dev);
+
 #define STORVSC_LOGGING_NONE	0
 #define STORVSC_LOGGING_ERROR	1
 #define STORVSC_LOGGING_WARN	2
@@ -1192,6 +1194,7 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
 	 * not correctly handle:
 	 * INQUIRY command with page code parameter set to 0x80
 	 * MODE_SENSE command with cmd[2] == 0x1c
+	 * MAINTENANCE_IN is not supported by HyperV FC passthrough
 	 *
 	 * Setup srb and scsi status so this won't be fatal.
 	 * We do this so we can distinguish truly fatal failues
@@ -1199,7 +1202,9 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
 	 */
 
 	if ((stor_pkt->vm_srb.cdb[0] == INQUIRY) ||
-	   (stor_pkt->vm_srb.cdb[0] == MODE_SENSE)) {
+	   (stor_pkt->vm_srb.cdb[0] == MODE_SENSE) ||
+	   (stor_pkt->vm_srb.cdb[0] == MAINTENANCE_IN &&
+	   hv_dev_is_fc(device))) {
 		vstor_packet->vm_srb.scsi_status = 0;
 		vstor_packet->vm_srb.srb_status = SRB_STATUS_SUCCESS;
 	}
-- 
2.39.5




