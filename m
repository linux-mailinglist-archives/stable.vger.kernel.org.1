Return-Path: <stable+bounces-68414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B5F95321A
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2A3A1F21FF1
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0B01A706A;
	Thu, 15 Aug 2024 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XC5EJAel"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798261A7061;
	Thu, 15 Aug 2024 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730493; cv=none; b=kBeG3S0qWrYwReJQYfZTX+fpFPccrn5k3uo4xAg5qOu8LCCvfWDmchoJUJHCBOVGjVAeThYZPtDwFI8XBfvHn0YUQmAKvt5ZiQfhN1bZH8a6tma8HMSZAxymivLI2gMtkHkLBXqJyw9S/M9r26IYosqrmZ0pZ/CSrAxHBSopdhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730493; c=relaxed/simple;
	bh=mCY/7e1ockswfPh8bNn7rLpD4hkt2TK5J3txCwDcDK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwwNYmDQAcukAr7p2pyBTJssYiOjTzG6ThaUrZPiAN+1sS1ODxMc1bNWc0QBV6ugzTtWeHsqbe+I5i3lIJ5/WVhK4j6lw3LJQtaOW51qnpBAIIeFALQrghlLhcaLufsWyWt5ZgxmeS1wmQA0MpiaxVuy23FWJTaZwTo6cIs3QME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XC5EJAel; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D886FC4AF0E;
	Thu, 15 Aug 2024 14:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723730493;
	bh=mCY/7e1ockswfPh8bNn7rLpD4hkt2TK5J3txCwDcDK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XC5EJAelBUhmW/ZbMCD1HDWADiCL5EZgV82+p565yRnnZ+Z8X2ReMjG1w/cbs5QCa
	 /BRULrYJ/6T4ZjfGwv7Bq9lToy6gQUomTz8UbqVN9DQ6kNWYKi9RSDrSw2CKy/8j5F
	 r0rF1aFRNj5TmxYHwadmHxH2VzInxnziq4VnFWQo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vamshi Gajjela <vamshigajjela@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.15 425/484] scsi: ufs: core: Fix hba->last_dme_cmd_tstamp timestamp updating logic
Date: Thu, 15 Aug 2024 15:24:43 +0200
Message-ID: <20240815131957.870454091@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
References: <20240815131941.255804951@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vamshi Gajjela <vamshigajjela@google.com>

commit ab9fd06cb8f0db0854291833fc40c789e43a361f upstream.

The ufshcd_add_delay_before_dme_cmd() always introduces a delay of
MIN_DELAY_BEFORE_DME_CMDS_US between DME commands even when it's not
required. The delay is added when the UFS host controller supplies the
quirk UFSHCD_QUIRK_DELAY_BEFORE_DME_CMDS.

Fix the logic to update hba->last_dme_cmd_tstamp to ensure subsequent DME
commands have the correct delay in the range of 0 to
MIN_DELAY_BEFORE_DME_CMDS_US.

Update the timestamp at the end of the function to ensure it captures the
latest time after any necessary delay has been applied.

Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
Link: https://lore.kernel.org/r/20240724135126.1786126-1-vamshigajjela@google.com
Fixes: cad2e03d8607 ("ufs: add support to allow non standard behaviours (quirks)")
Cc: stable@vger.kernel.org
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/ufs/ufshcd.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -3795,11 +3795,16 @@ static inline void ufshcd_add_delay_befo
 			min_sleep_time_us =
 				MIN_DELAY_BEFORE_DME_CMDS_US - delta;
 		else
-			return; /* no more delay required */
+			min_sleep_time_us = 0; /* no more delay required */
 	}
 
-	/* allow sleep for extra 50us if needed */
-	usleep_range(min_sleep_time_us, min_sleep_time_us + 50);
+	if (min_sleep_time_us > 0) {
+		/* allow sleep for extra 50us if needed */
+		usleep_range(min_sleep_time_us, min_sleep_time_us + 50);
+	}
+
+	/* update the last_dme_cmd_tstamp */
+	hba->last_dme_cmd_tstamp = ktime_get();
 }
 
 /**



