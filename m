Return-Path: <stable+bounces-70996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B89961112
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E64E1F21A71
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6021C57AF;
	Tue, 27 Aug 2024 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ieW4w1GF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB61D1BC9FC;
	Tue, 27 Aug 2024 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771752; cv=none; b=KbewjQsMhcqc1flzLSGMA4rgVNtzTiyuPHJZZB2jyvGasWXRGGAWdtGNvU7wmK3ejxkeU7NdVcT/WP27xJhK1iJbbwAbrkRQe2mjkz/kS9iEpi7PxQHvIj/QcZZTndh3rYvgYkUA/qMEwoR1a83otl4DqpW8llcZkxkTDmZGvPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771752; c=relaxed/simple;
	bh=riZEExv/bli2Hi3xqU7tyOgBQnywwI+HbNvJC/6BUZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmBZU6YdF7n8fRgirHQYPKhUElx758Yo26CbDxD4UdmRKXYvSlBIsPaDJ1Qy6opKDRUc+hTUKq4MEZR9k60Gh2tE6U8B/5A1YEn4gGrPY5IYgfOqX9gwlfYlfW3EJSSx+2CWE5lf/2r2lBKVUQewC/vmzv/M3ZNUdnk5d4FLkrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ieW4w1GF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2F9C4DE10;
	Tue, 27 Aug 2024 15:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724771751;
	bh=riZEExv/bli2Hi3xqU7tyOgBQnywwI+HbNvJC/6BUZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ieW4w1GFFbZqO8BkHRQj/VUQgfUFFpl4vE6D0WjF8m0cWMRzuBz7uNwOUiVmTl5Dp
	 aEAGyaChcHKCyqsiRIfNOOtIdH84t+BxIzNSVmFP4frXBh8r7NbN55H+WlMeqq4AxM
	 vxAfMLylBRk3PIFm//C8xwR5qvYiZccVPrlBzPKw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Hoeppner <hoeppner@linux.ibm.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1 010/321] s390/dasd: fix error recovery leading to data corruption on ESE devices
Date: Tue, 27 Aug 2024 16:35:18 +0200
Message-ID: <20240827143838.592343993@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
References: <20240827143838.192435816@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Haberland <sth@linux.ibm.com>

commit 7db4042336580dfd75cb5faa82c12cd51098c90b upstream.

Extent Space Efficient (ESE) or thin provisioned volumes need to be
formatted on demand during usual IO processing.

The dasd_ese_needs_format function checks for error codes that signal
the non existence of a proper track format.

The check for incorrect length is to imprecise since other error cases
leading to transport of insufficient data also have this flag set.
This might lead to data corruption in certain error cases for example
during a storage server warmstart.

Fix by removing the check for incorrect length and replacing by
explicitly checking for invalid track format in transport mode.

Also remove the check for file protected since this is not a valid
ESE handling case.

Cc: stable@vger.kernel.org # 5.3+
Fixes: 5e2b17e712cf ("s390/dasd: Add dynamic formatting support for ESE volumes")
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Link: https://lore.kernel.org/r/20240812125733.126431-3-sth@linux.ibm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/block/dasd.c          |   36 +++++++++++++++---------
 drivers/s390/block/dasd_3990_erp.c |   10 +-----
 drivers/s390/block/dasd_eckd.c     |   55 ++++++++++++++++---------------------
 drivers/s390/block/dasd_int.h      |    2 -
 4 files changed, 50 insertions(+), 53 deletions(-)

--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1597,9 +1597,15 @@ static int dasd_ese_needs_format(struct
 	if (!sense)
 		return 0;
 
-	return !!(sense[1] & SNS1_NO_REC_FOUND) ||
-		!!(sense[1] & SNS1_FILE_PROTECTED) ||
-		scsw_cstat(&irb->scsw) == SCHN_STAT_INCORR_LEN;
+	if (sense[1] & SNS1_NO_REC_FOUND)
+		return 1;
+
+	if ((sense[1] & SNS1_INV_TRACK_FORMAT) &&
+	    scsw_is_tm(&irb->scsw) &&
+	    !(sense[2] & SNS2_ENV_DATA_PRESENT))
+		return 1;
+
+	return 0;
 }
 
 static int dasd_ese_oos_cond(u8 *sense)
@@ -1620,7 +1626,7 @@ void dasd_int_handler(struct ccw_device
 	struct dasd_device *device;
 	unsigned long now;
 	int nrf_suppressed = 0;
-	int fp_suppressed = 0;
+	int it_suppressed = 0;
 	struct request *req;
 	u8 *sense = NULL;
 	int expires;
@@ -1675,8 +1681,9 @@ void dasd_int_handler(struct ccw_device
 		 */
 		sense = dasd_get_sense(irb);
 		if (sense) {
-			fp_suppressed = (sense[1] & SNS1_FILE_PROTECTED) &&
-				test_bit(DASD_CQR_SUPPRESS_FP, &cqr->flags);
+			it_suppressed =	(sense[1] & SNS1_INV_TRACK_FORMAT) &&
+				!(sense[2] & SNS2_ENV_DATA_PRESENT) &&
+				test_bit(DASD_CQR_SUPPRESS_IT, &cqr->flags);
 			nrf_suppressed = (sense[1] & SNS1_NO_REC_FOUND) &&
 				test_bit(DASD_CQR_SUPPRESS_NRF, &cqr->flags);
 
@@ -1691,7 +1698,7 @@ void dasd_int_handler(struct ccw_device
 				return;
 			}
 		}
-		if (!(fp_suppressed || nrf_suppressed))
+		if (!(it_suppressed || nrf_suppressed))
 			device->discipline->dump_sense_dbf(device, irb, "int");
 
 		if (device->features & DASD_FEATURE_ERPLOG)
@@ -2452,14 +2459,17 @@ retry:
 	rc = 0;
 	list_for_each_entry_safe(cqr, n, ccw_queue, blocklist) {
 		/*
-		 * In some cases the 'File Protected' or 'Incorrect Length'
-		 * error might be expected and error recovery would be
-		 * unnecessary in these cases.	Check if the according suppress
-		 * bit is set.
+		 * In some cases certain errors might be expected and
+		 * error recovery would be unnecessary in these cases.
+		 * Check if the according suppress bit is set.
 		 */
 		sense = dasd_get_sense(&cqr->irb);
-		if (sense && sense[1] & SNS1_FILE_PROTECTED &&
-		    test_bit(DASD_CQR_SUPPRESS_FP, &cqr->flags))
+		if (sense && (sense[1] & SNS1_INV_TRACK_FORMAT) &&
+		    !(sense[2] & SNS2_ENV_DATA_PRESENT) &&
+		    test_bit(DASD_CQR_SUPPRESS_IT, &cqr->flags))
+			continue;
+		if (sense && (sense[1] & SNS1_NO_REC_FOUND) &&
+		    test_bit(DASD_CQR_SUPPRESS_NRF, &cqr->flags))
 			continue;
 		if (scsw_cstat(&cqr->irb.scsw) == 0x40 &&
 		    test_bit(DASD_CQR_SUPPRESS_IL, &cqr->flags))
--- a/drivers/s390/block/dasd_3990_erp.c
+++ b/drivers/s390/block/dasd_3990_erp.c
@@ -1406,14 +1406,8 @@ dasd_3990_erp_file_prot(struct dasd_ccw_
 
 	struct dasd_device *device = erp->startdev;
 
-	/*
-	 * In some cases the 'File Protected' error might be expected and
-	 * log messages shouldn't be written then.
-	 * Check if the according suppress bit is set.
-	 */
-	if (!test_bit(DASD_CQR_SUPPRESS_FP, &erp->flags))
-		dev_err(&device->cdev->dev,
-			"Accessing the DASD failed because of a hardware error\n");
+	dev_err(&device->cdev->dev,
+		"Accessing the DASD failed because of a hardware error\n");
 
 	return dasd_3990_erp_cleanup(erp, DASD_CQR_FAILED);
 
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -2288,6 +2288,7 @@ dasd_eckd_analysis_ccw(struct dasd_devic
 	cqr->status = DASD_CQR_FILLED;
 	/* Set flags to suppress output for expected errors */
 	set_bit(DASD_CQR_SUPPRESS_NRF, &cqr->flags);
+	set_bit(DASD_CQR_SUPPRESS_IT, &cqr->flags);
 
 	return cqr;
 }
@@ -2569,7 +2570,6 @@ dasd_eckd_build_check_tcw(struct dasd_de
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
 	/* Set flags to suppress output for expected errors */
-	set_bit(DASD_CQR_SUPPRESS_FP, &cqr->flags);
 	set_bit(DASD_CQR_SUPPRESS_IL, &cqr->flags);
 
 	return cqr;
@@ -4145,8 +4145,6 @@ static struct dasd_ccw_req *dasd_eckd_bu
 
 	/* Set flags to suppress output for expected errors */
 	if (dasd_eckd_is_ese(basedev)) {
-		set_bit(DASD_CQR_SUPPRESS_FP, &cqr->flags);
-		set_bit(DASD_CQR_SUPPRESS_IL, &cqr->flags);
 		set_bit(DASD_CQR_SUPPRESS_NRF, &cqr->flags);
 	}
 
@@ -4648,9 +4646,8 @@ static struct dasd_ccw_req *dasd_eckd_bu
 
 	/* Set flags to suppress output for expected errors */
 	if (dasd_eckd_is_ese(basedev)) {
-		set_bit(DASD_CQR_SUPPRESS_FP, &cqr->flags);
-		set_bit(DASD_CQR_SUPPRESS_IL, &cqr->flags);
 		set_bit(DASD_CQR_SUPPRESS_NRF, &cqr->flags);
+		set_bit(DASD_CQR_SUPPRESS_IT, &cqr->flags);
 	}
 
 	return cqr;
@@ -5821,36 +5818,32 @@ static void dasd_eckd_dump_sense(struct
 {
 	u8 *sense = dasd_get_sense(irb);
 
-	if (scsw_is_tm(&irb->scsw)) {
-		/*
-		 * In some cases the 'File Protected' or 'Incorrect Length'
-		 * error might be expected and log messages shouldn't be written
-		 * then. Check if the according suppress bit is set.
-		 */
-		if (sense && (sense[1] & SNS1_FILE_PROTECTED) &&
-		    test_bit(DASD_CQR_SUPPRESS_FP, &req->flags))
-			return;
-		if (scsw_cstat(&irb->scsw) == 0x40 &&
-		    test_bit(DASD_CQR_SUPPRESS_IL, &req->flags))
-			return;
+	/*
+	 * In some cases certain errors might be expected and
+	 * log messages shouldn't be written then.
+	 * Check if the according suppress bit is set.
+	 */
+	if (sense && (sense[1] & SNS1_INV_TRACK_FORMAT) &&
+	    !(sense[2] & SNS2_ENV_DATA_PRESENT) &&
+	    test_bit(DASD_CQR_SUPPRESS_IT, &req->flags))
+		return;
 
-		dasd_eckd_dump_sense_tcw(device, req, irb);
-	} else {
-		/*
-		 * In some cases the 'Command Reject' or 'No Record Found'
-		 * error might be expected and log messages shouldn't be
-		 * written then. Check if the according suppress bit is set.
-		 */
-		if (sense && sense[0] & SNS0_CMD_REJECT &&
-		    test_bit(DASD_CQR_SUPPRESS_CR, &req->flags))
-			return;
+	if (sense && sense[0] & SNS0_CMD_REJECT &&
+	    test_bit(DASD_CQR_SUPPRESS_CR, &req->flags))
+		return;
 
-		if (sense && sense[1] & SNS1_NO_REC_FOUND &&
-		    test_bit(DASD_CQR_SUPPRESS_NRF, &req->flags))
-			return;
+	if (sense && sense[1] & SNS1_NO_REC_FOUND &&
+	    test_bit(DASD_CQR_SUPPRESS_NRF, &req->flags))
+		return;
 
+	if (scsw_cstat(&irb->scsw) == 0x40 &&
+	    test_bit(DASD_CQR_SUPPRESS_IL, &req->flags))
+		return;
+
+	if (scsw_is_tm(&irb->scsw))
+		dasd_eckd_dump_sense_tcw(device, req, irb);
+	else
 		dasd_eckd_dump_sense_ccw(device, req, irb);
-	}
 }
 
 static int dasd_eckd_reload_device(struct dasd_device *device)
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -225,7 +225,7 @@ struct dasd_ccw_req {
  * The following flags are used to suppress output of certain errors.
  */
 #define DASD_CQR_SUPPRESS_NRF	4	/* Suppress 'No Record Found' error */
-#define DASD_CQR_SUPPRESS_FP	5	/* Suppress 'File Protected' error*/
+#define DASD_CQR_SUPPRESS_IT	5	/* Suppress 'Invalid Track' error*/
 #define DASD_CQR_SUPPRESS_IL	6	/* Suppress 'Incorrect Length' error */
 #define DASD_CQR_SUPPRESS_CR	7	/* Suppress 'Command Reject' error */
 



