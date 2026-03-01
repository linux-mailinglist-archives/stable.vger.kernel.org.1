Return-Path: <stable+bounces-221923-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KP0/Jxaqo2nfJQUAu9opvQ
	(envelope-from <stable+bounces-221923-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:53:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E81A1CE055
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60AC83304E44
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F812EA481;
	Sun,  1 Mar 2026 01:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQvF9rki"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEDE2D9798;
	Sun,  1 Mar 2026 01:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329469; cv=none; b=jqq68q5lVJBZIakC5GYPaFRmsbTJiHUZQ5OUfD1cJpxUEiuD+zIo1FJbhSm8YPpj/roYdSb3B3Ks+afo/N//Rx1ydpvwIdy2hDeAPZOd2PFeRMuck9mJk8iM554tDQCgTtr1qL5AjKdSoyoIKlVuaEbjkmYiGWxAUnpC7FsYD3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329469; c=relaxed/simple;
	bh=dIeusuMYh49EWKfCFrAnRTaIsryPK6OKr623xCdXGnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XSeBkNSa7+VpdNvHtEn32JtmqnofnMrKJ00i8D2qdyUYvQFg92E/PGLg54rcR79eHT8TtZ5Gu58mJjJN8VU5TS3SwoCWE74h7YBKi27FGwGDtMUOdsOqoB8yXb0kHI1YTphFtDFX3QwygVSLC+3hQ0VMuimTbe7KpHemawTl4Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQvF9rki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D315DC19421;
	Sun,  1 Mar 2026 01:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329469;
	bh=dIeusuMYh49EWKfCFrAnRTaIsryPK6OKr623xCdXGnM=;
	h=From:To:Cc:Subject:Date:From;
	b=BQvF9rkiGlVvlLcXvGLaQnF8KwYoPnwR7Clscj4pD6FraQdxw3r+LtbGgjCzGrgZ9
	 IbRFX3BNDUv3FgY7MAxN5BOaq5t/uRcrOfdku9gqz+ppo3vv4o/2PWAMryjeEhX9OL
	 adlgDc36fUTSV5HDTF/xG4JLBKVNv/aJlg3W4VzpbstSB8cDiCjr0HlcC/zuqsNvxF
	 KAO7N6neh64ArNwJvhWNVIGtMOMaABXmZLaMLmDJmrxZWfgS+BNmXBtE7+tIjsijIk
	 MVbG9r7OHeLHDH0aok1eLu/XQLfw8fkNmjFNoBI6IU3d4xlVrBPCEVsMJ/N06ukQJT
	 vLU5fA4e8xlWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	antoniu.miclaus@analog.com
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org
Subject: FAILED: Patch "iio: gyro: itg3200: Fix unchecked return value in read_raw" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:44:27 -0500
Message-ID: <20260301014427.1706725-1-sashal@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-221923-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2E81A1CE055
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
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





