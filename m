Return-Path: <stable+bounces-221102-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAVKM7xJo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-221102-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:02:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1FB1C7C9F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8589E31228B5
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDFD371442;
	Sat, 28 Feb 2026 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3wJ6UCW"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6B2301F0C;
	Sat, 28 Feb 2026 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301451; cv=none; b=k5BM4zQytjjHAhgbzirlTBazxprej8pIjmkyuyM5DjgPSU3Zkaw7K0ceqebeccEXF7dFXdpJUjVJBWIri+dOpgJSnHn1uhaT4XVogpG5IEygy+ZhRx6x+HaFBpo9ObrA75eekG76TjI+bI5wjPMkMl3e2brtRaXoTRoDka6sMJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301451; c=relaxed/simple;
	bh=NxGOfkvRJjHXt727XexuhxLaF0DzYjTi8pPM5h4Zgzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXO7iHc8wslLKiHQskLAjeI5fUbQb61cazojl3FyUd1oLZ5EE+ezSxz6sAIyu5htuKxZQ0Q13rRlDbbOp11wYsc5ZTeFZbVaRL9yDOzR/rpNQRkJ3y+ImDjZQO6rAOLCjEFf4dyDMhEgZfG/9hPoWD62BEyUpPikDuqLMaEdthQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3wJ6UCW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48845C19424;
	Sat, 28 Feb 2026 17:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301450;
	bh=NxGOfkvRJjHXt727XexuhxLaF0DzYjTi8pPM5h4Zgzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3wJ6UCWEunzjqewAH3Dvu8Q/Fc5PEpSMVS47f1OrFZyp96+srRKA0ZMVpI4eDs24
	 fAX5JhKuUlsMDbVREOVjJtUfj1SzSHdEVgD3M/+p33LNQH/GOH768hpMTYboRVXKw9
	 qOO3ca3dJCBeJs9a/Vg3FEIjezcBYBp8CLNqVBco3mx84oD9rZrk3OrqXgueo/HRNm
	 ylpKIDQ6FtILuzGvBUJBTuVr80Ybag2PgYMFLNIWBJhiTK96jn+RtN8y4daWiOtoXg
	 1cqVEkjezCuhEC38fs7XN29lEUgBXMXRq/zccqIAKq2Pd+TJoqMRBNcchvLXztq+GW
	 zuiiKUTp6Z5Ag==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 637/752] iio: gyro: itg3200: Fix unchecked return value in read_raw
Date: Sat, 28 Feb 2026 12:45:48 -0500
Message-ID: <20260228174750.1542406-637-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
	TAGGED_FROM(0.00)[bounces-221102-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,analog.com:email,huawei.com:email]
X-Rspamd-Queue-Id: 0E1FB1C7C9F
X-Rspamd-Action: no action

From: Antoniu Miclaus <antoniu.miclaus@analog.com>

[ Upstream commit b79b24f578cdb2d657db23e5fafe82c7e6a36b72 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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


