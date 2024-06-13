Return-Path: <stable+bounces-51934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C71B907249
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D91281A45
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62AA1428EF;
	Thu, 13 Jun 2024 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l6RRgQ/W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DA3384;
	Thu, 13 Jun 2024 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282746; cv=none; b=JNWJglZTujdk4tRZAejuI9C8IGv4jNcqOReaKFIUgrgJvxvIoYjXxdXzQQv9pT6lgxom4vC5QLl3FWJ4GrIkXKdnfyURbfFCKdCRbNTtYV+XdovkVvb8xtlaKnAa+4exy9G33Vz7xiOTvI7EZtLD6VvzWYGKm9KynC3VVLjh5jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282746; c=relaxed/simple;
	bh=1mOFNcrKMK0BG7QvmyLhzY27h7f3vqwwULP8jjM6Zjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6HwVp7iAz6Ou7WjcoEmgrE35rZdZPAA2cZ2iNmDyRsofPwTPrgaiUrQcc+KbqeVyIk7yJjpTTcy3Mmb8xYdCbUk/rl8FIymnhTkOPbpB4V1dkP+x2EFPemcejBLKoqUe95lmIwX6XLioZP2vOSkoi4vJzUSUISdjMBtZbitPj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l6RRgQ/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEBBC2BBFC;
	Thu, 13 Jun 2024 12:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718282746;
	bh=1mOFNcrKMK0BG7QvmyLhzY27h7f3vqwwULP8jjM6Zjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l6RRgQ/WBsw0ctEILttK91JMAKurpUdHMRfOyq86W60LHnie652CiPlqdQpqJeMWV
	 a91FxPrm/qMDwn7CCGh9T6/xMvWlgRX7nmW1eq0W0COo29r4i6oSznttEg/Xr2RB9u
	 PR/e1LPxcQ3PXZRj0ZjJ5pQNhO/kaEmrrVCmzEU0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH 5.15 380/402] crypto: qat - Fix ADF_DEV_RESET_SYNC memory leak
Date: Thu, 13 Jun 2024 13:35:37 +0200
Message-ID: <20240613113316.964111907@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
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

From: Herbert Xu <herbert@gondor.apana.org.au>

commit d3b17c6d9dddc2db3670bc9be628b122416a3d26 upstream.

Using completion_done to determine whether the caller has gone
away only works after a complete call.  Furthermore it's still
possible that the caller has not yet called wait_for_completion,
resulting in another potential UAF.

Fix this by making the caller use cancel_work_sync and then freeing
the memory safely.

Fixes: 7d42e097607c ("crypto: qat - resolve race condition during AER recovery")
Cc: <stable@vger.kernel.org> #6.8+
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/qat/qat_common/adf_aer.c |   19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

--- a/drivers/crypto/qat/qat_common/adf_aer.c
+++ b/drivers/crypto/qat/qat_common/adf_aer.c
@@ -95,8 +95,7 @@ static void adf_device_reset_worker(stru
 	if (adf_dev_init(accel_dev) || adf_dev_start(accel_dev)) {
 		/* The device hanged and we can't restart it so stop here */
 		dev_err(&GET_DEV(accel_dev), "Restart device failed\n");
-		if (reset_data->mode == ADF_DEV_RESET_ASYNC ||
-		    completion_done(&reset_data->compl))
+		if (reset_data->mode == ADF_DEV_RESET_ASYNC)
 			kfree(reset_data);
 		WARN(1, "QAT: device restart failed. Device is unusable\n");
 		return;
@@ -104,16 +103,8 @@ static void adf_device_reset_worker(stru
 	adf_dev_restarted_notify(accel_dev);
 	clear_bit(ADF_STATUS_RESTARTING, &accel_dev->status);
 
-	/*
-	 * The dev is back alive. Notify the caller if in sync mode
-	 *
-	 * If device restart will take a more time than expected,
-	 * the schedule_reset() function can timeout and exit. This can be
-	 * detected by calling the completion_done() function. In this case
-	 * the reset_data structure needs to be freed here.
-	 */
-	if (reset_data->mode == ADF_DEV_RESET_ASYNC ||
-	    completion_done(&reset_data->compl))
+	/* The dev is back alive. Notify the caller if in sync mode */
+	if (reset_data->mode == ADF_DEV_RESET_ASYNC)
 		kfree(reset_data);
 	else
 		complete(&reset_data->compl);
@@ -148,10 +139,10 @@ static int adf_dev_aer_schedule_reset(st
 		if (!timeout) {
 			dev_err(&GET_DEV(accel_dev),
 				"Reset device timeout expired\n");
+			cancel_work_sync(&reset_data->reset_work);
 			ret = -EFAULT;
-		} else {
-			kfree(reset_data);
 		}
+		kfree(reset_data);
 		return ret;
 	}
 	return 0;



