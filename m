Return-Path: <stable+bounces-72064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC07967904
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83A9DB219A3
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF89617E8EA;
	Sun,  1 Sep 2024 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p0fu3dNQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD75E1C68C;
	Sun,  1 Sep 2024 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208722; cv=none; b=L2hWKg0aHbAkTxKvcAbWVDCcyAEV2Z01HrkgkrAWp0tKirwp2xYnLzMuoWy0dAz810jyXaIqHFHAT8/4iF8cpKLZlVh8E4LoJvZJ3RxQebR+K0ghF4tlwD/8v/1Srso4Alm3IwL8EKxmuRJWunS27jdImqBd0xagheimW1iVDVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208722; c=relaxed/simple;
	bh=7nMTklS8jK0Iaokq/vnZsynSlzsM7VvJQ5tExxDReVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EM241JfeImp5VzcoeyW+8HydzejVGmebW7gYUgpGx7SWgTFlmLdEGYIHyXYm2bFfgb37K+GOvlWehXBxI6opH57zkTupfWBxCBDJyvQWbry9+F87YjR91cEbbhUb4yyflU87WiZv+4C8FnJ2kYqTaSggBp6syR182uybrZZOxRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p0fu3dNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E18C4CEC3;
	Sun,  1 Sep 2024 16:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725208722;
	bh=7nMTklS8jK0Iaokq/vnZsynSlzsM7VvJQ5tExxDReVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p0fu3dNQaouJ1uQRLJOeAxVth/2zlHRx4Cz4ptizN7VSq70fSdevYlpLW6n6ajJCO
	 qGZtqBV3aw5O1nrAzSrJkHguUq8UhMpdm0UKevVIDL1/JMkLlK7ANKirxKbZ1ImQgS
	 hQ/vfVGBj7l0yXp23omMTIZmdvc93pdcQRfRYq6s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Hoeppner <hoeppner@linux.ibm.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.4 004/134] s390/dasd: fix error recovery leading to data corruption on ESE devices
Date: Sun,  1 Sep 2024 18:15:50 +0200
Message-ID: <20240901160809.922984206@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160809.752718937@linuxfoundation.org>
References: <20240901160809.752718937@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1665,9 +1665,15 @@ static int dasd_ese_needs_format(struct
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
@@ -1688,7 +1694,7 @@ void dasd_int_handler(struct ccw_device
 	struct dasd_device *device;
 	unsigned long now;
 	int nrf_suppressed = 0;
-	int fp_suppressed = 0;
+	int it_suppressed = 0;
 	struct request *req;
 	u8 *sense = NULL;
 	int expires;
@@ -1743,8 +1749,9 @@ void dasd_int_handler(struct ccw_device
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
 
@@ -1759,7 +1766,7 @@ void dasd_int_handler(struct ccw_device
 				return;
 			}
 		}
-		if (!(fp_suppressed || nrf_suppressed))
+		if (!(it_suppressed || nrf_suppressed))
 			device->discipline->dump_sense_dbf(device, irb, "int");
 
 		if (device->features & DASD_FEATURE_ERPLOG)
@@ -2513,14 +2520,17 @@ retry:
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
@@ -1401,14 +1401,8 @@ dasd_3990_erp_file_prot(struct dasd_ccw_
 
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
@@ -2201,6 +2201,7 @@ dasd_eckd_analysis_ccw(struct dasd_devic
 	cqr->status = DASD_CQR_FILLED;
 	/* Set flags to suppress output for expected errors */
 	set_bit(DASD_CQR_SUPPRESS_NRF, &cqr->flags);
+	set_bit(DASD_CQR_SUPPRESS_IT, &cqr->flags);
 
 	return cqr;
 }
@@ -2482,7 +2483,6 @@ dasd_eckd_build_check_tcw(struct dasd_de
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
 	/* Set flags to suppress output for expected errors */
-	set_bit(DASD_CQR_SUPPRESS_FP, &cqr->flags);
 	set_bit(DASD_CQR_SUPPRESS_IL, &cqr->flags);
 
 	return cqr;
@@ -4031,8 +4031,6 @@ static struct dasd_ccw_req *dasd_eckd_bu
 
 	/* Set flags to suppress output for expected errors */
 	if (dasd_eckd_is_ese(basedev)) {
-		set_bit(DASD_CQR_SUPPRESS_FP, &cqr->flags);
-		set_bit(DASD_CQR_SUPPRESS_IL, &cqr->flags);
 		set_bit(DASD_CQR_SUPPRESS_NRF, &cqr->flags);
 	}
 
@@ -4534,9 +4532,8 @@ static struct dasd_ccw_req *dasd_eckd_bu
 
 	/* Set flags to suppress output for expected errors */
 	if (dasd_eckd_is_ese(basedev)) {
-		set_bit(DASD_CQR_SUPPRESS_FP, &cqr->flags);
-		set_bit(DASD_CQR_SUPPRESS_IL, &cqr->flags);
 		set_bit(DASD_CQR_SUPPRESS_NRF, &cqr->flags);
+		set_bit(DASD_CQR_SUPPRESS_IT, &cqr->flags);
 	}
 
 	return cqr;
@@ -5706,36 +5703,32 @@ static void dasd_eckd_dump_sense(struct
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
 
 static int dasd_eckd_pm_freeze(struct dasd_device *device)
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -226,7 +226,7 @@ struct dasd_ccw_req {
  * The following flags are used to suppress output of certain errors.
  */
 #define DASD_CQR_SUPPRESS_NRF	4	/* Suppress 'No Record Found' error */
-#define DASD_CQR_SUPPRESS_FP	5	/* Suppress 'File Protected' error*/
+#define DASD_CQR_SUPPRESS_IT	5	/* Suppress 'Invalid Track' error*/
 #define DASD_CQR_SUPPRESS_IL	6	/* Suppress 'Incorrect Length' error */
 #define DASD_CQR_SUPPRESS_CR	7	/* Suppress 'Command Reject' error */
 



