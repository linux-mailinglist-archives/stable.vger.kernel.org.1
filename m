Return-Path: <stable+bounces-228667-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDcdOaFVwWlTSQQAu9opvQ
	(envelope-from <stable+bounces-228667-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:00:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0172F59FC
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 296B431FB0CB
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A99369204;
	Mon, 23 Mar 2026 14:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0AdSBUA8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879E8324B16;
	Mon, 23 Mar 2026 14:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275768; cv=none; b=h0fnZtWZcL0VrcEPybQ8wsztxnMjsYIPxvcrWdR5LaW4kwBAufG47yV2R/bLVUTG43GV1uyLdVmrFI7t8nm+AK1h0ibtWVPryl2Bjm8wPuzNxsUeErOCAB8FKkKiAbRJ5vw1hQoOuVJexcNo3IPhu9upDF9zf5iXLB+pGWfwAOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275768; c=relaxed/simple;
	bh=KsLFILM3KNCN/8hVYvpFIF8q/lHbSFeE6p9mJBHdEMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a58R42uSLHSmaCZDE2QvT2Nuzk6y1zg4XEaiRQCE0VP/wso8DRpgb7wOCjdquKjY23jSuzUj1jhMFUqaEM80CTZf0XL3YYj8Cr2IkDhStlAcmrEa4tFISmswpd109PEHa4k3GO21SjEqgMsGaKuEGahwdaiBVCbKG7RZ/2Ql2io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0AdSBUA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13773C4CEF7;
	Mon, 23 Mar 2026 14:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275768;
	bh=KsLFILM3KNCN/8hVYvpFIF8q/lHbSFeE6p9mJBHdEMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0AdSBUA8mGQR369TgyEkdjA5GP6q6zrwM+fGiw+blsghyuEk7lrXN+BE0RHObdmaP
	 Oz4QWNGLSynUE2YeO3dhB+oXphD9ybKg6xT8ODTIrS2gmxcfdxVfRVaIUu6jaalYxk
	 Gun/RQPidLROfuBrcy4zMYNHErE0cHD5BPbLy+n8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.12 211/460] iio: gyro: mpu3050-i2c: fix pm_runtime error handling
Date: Mon, 23 Mar 2026 14:43:27 +0100
Message-ID: <20260323134531.701328639@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228667-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7F0172F59FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoniu Miclaus <antoniu.miclaus@analog.com>

commit 91f950b4cbb1aa9ea4eb3999f1463e8044b717fb upstream.

The return value of pm_runtime_get_sync() is not checked, and the
function always returns success. This allows I2C mux operations to
proceed even when the device fails to resume.

Use pm_runtime_resume_and_get() and propagate its return value to
properly handle resume failures.

Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/gyro/mpu3050-i2c.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/iio/gyro/mpu3050-i2c.c
+++ b/drivers/iio/gyro/mpu3050-i2c.c
@@ -19,8 +19,7 @@ static int mpu3050_i2c_bypass_select(str
 	struct mpu3050 *mpu3050 = i2c_mux_priv(mux);
 
 	/* Just power up the device, that is all that is needed */
-	pm_runtime_get_sync(mpu3050->dev);
-	return 0;
+	return pm_runtime_resume_and_get(mpu3050->dev);
 }
 
 static int mpu3050_i2c_bypass_deselect(struct i2c_mux_core *mux, u32 chan_id)



