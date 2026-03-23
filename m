Return-Path: <stable+bounces-229274-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GO6/ER1fwWmaSgQAu9opvQ
	(envelope-from <stable+bounces-229274-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:41:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EB92F6B53
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4F713001AC0
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016C23B47EF;
	Mon, 23 Mar 2026 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tWk/2V4y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66B73B3BFF;
	Mon, 23 Mar 2026 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278603; cv=none; b=YSKkPFkcazkzY/U0N5Ac4i+d/466QmIDjcvwTBcRktKhlfKcaOKTf2WzHv3VTjDGkhRmVj0lTnoZktYczCcIBK0uNRKn051lzkDsKxVRj9YzjqJBSfbyLqhNGsYI/DLxojXyZPoCrL5LLuTqZdRUfgkw6maR575WUZeW8AgBNgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278603; c=relaxed/simple;
	bh=DlPoxmDjbJtICjOJpO2tRCrzd5F6N6MKQCFSbBT/xIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpDr/0Q71apF1R0J3Q2Fhx2lyb2rXHLT7M8r6fZiXr7q3oAdqsiLBBnmXV1RsSMcZHlmdIRs3amNCONJNzNL23I8BVvne1KkHIv4I+sDs5kxv7SDAjGZZA06qSdJRIDqNJaPyRf3RFsya2Bkg7Tvv7dYjXuQV/eWt+/bHWFEFlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tWk/2V4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC21C4CEF7;
	Mon, 23 Mar 2026 15:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278603;
	bh=DlPoxmDjbJtICjOJpO2tRCrzd5F6N6MKQCFSbBT/xIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tWk/2V4y2DH0fGSpf4ol9Js3Abhv5dl7WMNTkhMV+RoTsLTlHZT3Zcd5wmLWdc4ff
	 /D6iRWKWfVl4LrtJ3IbtsmBTHIOr5966RzFkCBHxuZZg8o7FbjbrocQujMQYz7pLaL
	 5lioVB/5Q3T2UJ/QDJoF+6PpEm1c0CBkef5/296I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Linus Walleij <linusw@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.6 359/567] iio: gyro: mpu3050-core: fix pm_runtime error handling
Date: Mon, 23 Mar 2026 14:44:39 +0100
Message-ID: <20260323134542.713127118@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229274-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B8EB92F6B53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoniu Miclaus <antoniu.miclaus@analog.com>

commit acc3949aab3e8094641a9c7c2768de1958c88378 upstream.

The return value of pm_runtime_get_sync() is not checked, allowing
the driver to access hardware that may fail to resume. The device
usage count is also unconditionally incremented. Use
pm_runtime_resume_and_get() which propagates errors and avoids
incrementing the usage count on failure.

In preenable, add pm_runtime_put_autosuspend() on set_8khz_samplerate()
failure since postdisable does not run when preenable fails.

Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/gyro/mpu3050-core.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -322,7 +322,9 @@ static int mpu3050_read_raw(struct iio_d
 		}
 	case IIO_CHAN_INFO_RAW:
 		/* Resume device */
-		pm_runtime_get_sync(mpu3050->dev);
+		ret = pm_runtime_resume_and_get(mpu3050->dev);
+		if (ret)
+			return ret;
 		mutex_lock(&mpu3050->lock);
 
 		ret = mpu3050_set_8khz_samplerate(mpu3050);
@@ -651,14 +653,20 @@ out_trigger_unlock:
 static int mpu3050_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct mpu3050 *mpu3050 = iio_priv(indio_dev);
+	int ret;
 
-	pm_runtime_get_sync(mpu3050->dev);
+	ret = pm_runtime_resume_and_get(mpu3050->dev);
+	if (ret)
+		return ret;
 
 	/* Unless we have OUR trigger active, run at full speed */
-	if (!mpu3050->hw_irq_trigger)
-		return mpu3050_set_8khz_samplerate(mpu3050);
+	if (!mpu3050->hw_irq_trigger) {
+		ret = mpu3050_set_8khz_samplerate(mpu3050);
+		if (ret)
+			pm_runtime_put_autosuspend(mpu3050->dev);
+	}
 
-	return 0;
+	return ret;
 }
 
 static int mpu3050_buffer_postdisable(struct iio_dev *indio_dev)



