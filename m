Return-Path: <stable+bounces-222311-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEMwDrafo2noIgUAu9opvQ
	(envelope-from <stable+bounces-222311-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:08:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C44A71CD153
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A26F305F496
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 02:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9924B2F39C2;
	Sun,  1 Mar 2026 02:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSnLxNbK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6F513D53C;
	Sun,  1 Mar 2026 02:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330565; cv=none; b=k58fKxoYmDdMkV5jjjM5AlzFVB6MLvogh5aUUH/Wm34dw43KSS9JmSRdQJ+uX5HS4e04muUT2P8ljyyYm18BrFro94HbcFJ0nFbWVlJatovsS/JconGTPcsJAODSqaeazfgdo3VA+r5TrHBy2yewqnbjgLgzm0FHWG/29caZbHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330565; c=relaxed/simple;
	bh=fyJ8EcfbImP1C+JAIfMOaDKx1ONMEjhPy5+tZDKOTEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nWPF7qxAsYGOv3pwDIzL0QfrPco3x8ZP5llLNLb+CqT8JLOfeaxjrpARd03GsJ8e6mPLiN2TmM2OHlsyjROhhv3ggEi2fGyld8u54Y6VQazOtZ/xkPuRdCr8Us7pAGW8pvo0W+xmlQqe4XCwGVObqFcJ5X0DBDvQTb5yGX6eht8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSnLxNbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A35C19421;
	Sun,  1 Mar 2026 02:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330565;
	bh=fyJ8EcfbImP1C+JAIfMOaDKx1ONMEjhPy5+tZDKOTEQ=;
	h=From:To:Cc:Subject:Date:From;
	b=lSnLxNbKPUZi0qlJgF5TfJ3Z4CPp0CNB1LjvRXVBqtrxTrfSJM4NPM/LKrx+F1Tn0
	 SUTSFZagE0Jpk+1Bp1s+HdKShI+paIUP6/Bkkl5GF79K1KHmQYJOFO2jr3+BiQ3rHV
	 6ZStnCro116C9JuT48YK1XE9vTVIKoaC8hlIBFdXth/D0cG62DmxcM4l6llu/ZY8Kr
	 f5HoRBfRr4mBf0Yk/Lwl5NiJEmZmPQ4cQ/leZ69ncTU0KapQ1/IrrgfiDZuMBU4CGB
	 /zO0qsFe/STHI9uAvud5VBRxd/a88UH9s98AiBEEMZrOPGHVSYmqLkmEk5IchKAjrD
	 nI2oJgXbOuq3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	antoniu.miclaus@analog.com
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org
Subject: FAILED: Patch "iio: gyro: itg3200: Fix unchecked return value in read_raw" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 21:02:43 -0500
Message-ID: <20260301020243.1730626-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222311-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,intel.com:email,analog.com:email]
X-Rspamd-Queue-Id: C44A71CD153
X-Rspamd-Action: no action

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b79b24f578cdb2d657db23e5fafe82c7e6a36b72 Mon Sep 17 00:00:00 2001
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
Date: Thu, 29 Jan 2026 17:01:45 +0200
Subject: [PATCH] iio: gyro: itg3200: Fix unchecked return value in read_raw

The return value from itg3200_read_reg_s16() is stored in ret but
never checked. The function unconditionally returns IIO_VAL_INT,
ignoring potential I2C read failures. This causes garbage data to
be returned to userspace when the read fails, with no error reported.

Add proper error checking to propagate the failure to callers.

Fixes: 9dbf091da080 ("iio: gyro: Add itg3200")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/gyro/itg3200_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200_core.c
index cd8a2dae56cd9..bfe95ec1abda9 100644
--- a/drivers/iio/gyro/itg3200_core.c
+++ b/drivers/iio/gyro/itg3200_core.c
@@ -93,6 +93,8 @@ static int itg3200_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		reg = (u8)chan->address;
 		ret = itg3200_read_reg_s16(indio_dev, reg, val);
+		if (ret)
+			return ret;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
-- 
2.51.0





