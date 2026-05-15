Return-Path: <stable+bounces-247651-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAEFAKb6BmoKqQIAu9opvQ
	(envelope-from <stable+bounces-247651-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:51:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F380254DB84
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E78583066B51
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243E33D0BF9;
	Fri, 15 May 2026 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gS/aLJdf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44023C3422;
	Fri, 15 May 2026 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840937; cv=none; b=Z1z/CS213QJzqp5py1oDKDnXzzo3cEuOBZrsdDO1X68llnLWomGy8isV4sad4fK8amX4U9WZqjDwBnXivAmPPfgPVyyM+y9via3cYmT3hzp6sXaZP2JYacFDydXaYsIDuID5cgvJnmai3PU5+UOtX7wwUquxZVp6MrRdXSCgfN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840937; c=relaxed/simple;
	bh=y2KsAyUCMOwgJGzqhlQw13mkwi83vxy6o+v19R/wxaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mB1ns5e+YcJfSmhS19XiJdHJuYDOFXlmhPLH2vYa/B54zjrbSd5UOqpD/NPVUhU7m/6+BTHb6OLcs0sCDwiNxbr+4q21czXLdUDZDY4PCTQZPx/i7DaRG7E7oI+8K30vjH+Y4Lecc/imeoQ1nxi2ZbwVK3YnDB3T2X6DuIra1hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gS/aLJdf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A914C2BCB0;
	Fri, 15 May 2026 10:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778840937;
	bh=y2KsAyUCMOwgJGzqhlQw13mkwi83vxy6o+v19R/wxaY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=gS/aLJdfXJ9Ef1Ag85wiXok+2pEsfwv2c4tM8G0d07KrSSbyRkFEGC5/7OVJMoaTR
	 WvNhLK4/N0yTfRGG4Fv2S8tdoYcwbUKjiQFirJFOERrTtVzDjazuDMomAov4yZebuN
	 5P86aUqIoIzVfMub3R/3CLxhl9CO9NDazYxFa74g/BIHAHE0EaHEV1sNm42peUdgl6
	 rNheoqtnQCBnUdiOwBX9Q9NgdUthLdbzOxkRFo1h98bGAfuLIxRIK0lPE3dpOFrP3g
	 KkJHmLWtx14Wx7TA3lN0FIwN5rid8AjknNJG+Zo2F2im8kpECspIFjO+qCmja0OLRB
	 WL54IRc1vs+Zw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BB6CD4F25;
	Fri, 15 May 2026 10:28:57 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Fri, 15 May 2026 12:28:23 +0200
Subject: [PATCH v2] iio: magnetometer: ak8975: fix potential kernel stack
 memory leak
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-magnetometer-kernel-mem-leak-v2-1-320e1ad4843d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEb1BmoC/43NQQ6CMBCF4auYWTuGViDFlfcwLEY6wATampYQD
 eHuVk7g8nuL/22QOAonuJ02iLxKkuAz9PkE3Uh+YBSbDbrQdVGpEh0NnpfgeOGIE0fPMzp2ODN
 NaI0hU1ltqC4gJ16Re3kf+UebPUpaQvwcb6v6rX+GV4UKr9WzNLZump76++BI5ksXHLT7vn8BC
 3Pz5MgAAAA=
X-Change-ID: 20260514-magnetometer-kernel-mem-leak-d88a85d28a60
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Gregor Boirie <gregor.boirie@parrot.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778840936; l=2859;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=DGUZ8ICq5s3dP8tVuyORKa78JXv6M2/K7bYZ13VS8lM=;
 b=WIr5H10DW5ZEdrIL5D81+NvLroUVPHffahavXKKec3pqdz7IrlycqW8IFlmV2j3w92IeXyTtW
 p2SU1eYxSOnD73S1Qwzt9d5kOmNpdg+UNzB/8ADA9aqgGJo302QQfn2
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com
X-Rspamd-Queue-Id: F380254DB84
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247651-lists,stable=lfdr.de,joshua.crofts1.gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,baylibre.com,analog.com,parrot.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[joshua.crofts1@gmail.com]
X-Rspamd-Action: no action

From: Joshua Crofts <joshua.crofts1@gmail.com>

Currently in the AK8975 driver there are four instances where potential
uninitialized kernel stack memory leaks can occur. If
i2c_smbus_read_i2c_block_data_or_emulated() returns a value less than
the size of the buffer, uninitialized bytes are retained in the buffer
and later the buffer is passed on to IIO buffers, potentially leaking
memory to userspace.

Fix this by adding checks whether the return value of the function is
equal to the size of the buffer and subsequently if the value is
lesser than zero to distinguish from a returned error code.

Fixes: bc11ca4a0b84 ("iio:magnetometer:ak8975: triggered buffer support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260513-ak8975-fix-v1-1-104ea605dd54%40gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Changes in v2:
- Added 2 additional checks
- Removed nested if statements
- Link to v1: https://lore.kernel.org/r/20260514-magnetometer-kernel-mem-leak-v1-1-35b48d699faf@gmail.com
---
 drivers/iio/magnetometer/ak8975.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index b648b0afa5733fd7a54bdf2b8f92f00e924c074b..e085c5a6583dfe40c653abf4936594a5acd08f51 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -495,6 +495,10 @@ static int ak8975_who_i_am(struct i2c_client *client,
 		dev_err(&client->dev, "Error reading WIA\n");
 		return ret;
 	}
+	if (ret != sizeof(wia_val)) {
+		dev_err(&client->dev, "Error reading WIA\n");
+		return -EIO;
+	}
 
 	if (wia_val[0] != AK8975_DEVICE_ID)
 		return -ENODEV;
@@ -619,6 +623,10 @@ static int ak8975_setup(struct i2c_client *client)
 		dev_err(&client->dev, "Not able to read asa data\n");
 		return ret;
 	}
+	if (ret != sizeof(data->asa)) {
+		dev_err(&client->dev, "Error reading asa data\n");
+		return -EIO;
+	}
 
 	/* After reading fuse ROM data set power-down mode */
 	ret = ak8975_set_mode(data, POWER_DOWN);
@@ -758,6 +766,10 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 			sizeof(rval), (u8*)&rval);
 	if (ret < 0)
 		goto exit;
+	if (ret != sizeof(rval)) {
+		ret = -EIO;
+		goto exit;
+	}
 
 	/* Read out ST2 for release lock on measurement data. */
 	ret = i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST2]);
@@ -873,6 +885,8 @@ static void ak8975_fill_buffer(struct iio_dev *indio_dev)
 							(u8 *)fval);
 	if (ret < 0)
 		goto unlock;
+	if (ret != sizeof(fval))
+		goto unlock;
 
 	mutex_unlock(&data->lock);
 

---
base-commit: 86138b484d6367a57312f69af4ec958806c2673c
change-id: 20260514-magnetometer-kernel-mem-leak-d88a85d28a60

Best regards,
-- 
Joshua Crofts <joshua.crofts1@gmail.com>



