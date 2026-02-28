Return-Path: <stable+bounces-221021-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPOrBR5do2nW/AQAu9opvQ
	(envelope-from <stable+bounces-221021-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:24:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A91311C9028
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 389DE334F89B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495324BCAA3;
	Sat, 28 Feb 2026 17:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+hZmSHj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF154BC03C;
	Sat, 28 Feb 2026 17:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301364; cv=none; b=TvSDyzkstSCwvNGeEW0BtMP4gKPgnSzKqmAY4FUb3QoCq1hvB+eDzJpVMeb/UEfldJCzbDXatSQauUcasnG6x8yRQ/2fUHcWy6ReVJrFT7vc1+5Dx/1P/iPCrceni1ASGJ5vNgrtrK7tiKo9/UFjtpWtO5Qhe+g11b8MBRnDiFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301364; c=relaxed/simple;
	bh=s3yDxUuIIIvd2yaG41DZabKKL38dVe+r2GKckN3hqmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=claRPxeEzR05mZyTjXAELcLDgZ5oOzXb7wxaUc++ayAFeQnT/6JdjzKGfrx6UfDvMQvLh4rWXKT7Le3MQPkm7xVQXERRfs3FALTj+JGQ6yMrlbuApbgiZRzqva86AsTX9xQR9/n2esgADtrDoEcxpGWGEkYhU+OoipS0kL3FjFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+hZmSHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C607C2BCB0;
	Sat, 28 Feb 2026 17:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301363;
	bh=s3yDxUuIIIvd2yaG41DZabKKL38dVe+r2GKckN3hqmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W+hZmSHjY21xBivhv73oRN7VuySEj6Ovz5Eg5q/NtI+AgAxjS972ceXwAN2tKb4xU
	 gxwPy2696zIXCVjE+XTO0Tz88oGVRiyvmob3VaiqZfPwvkPfq/Eb2U5Q9wmyIpTyjz
	 2NqW5JQ0IIPi0u7imI8Y90y6ROMWqk8SdiF3GuaGw45/v43gDycY4eJCPpGHDiz7Oo
	 7EIrWMUFhqT6PZeJWcEpZ43X9zGLmBRXxmtNj8rJmeBrPpE+sRyNLsnfPM46hI+RhB
	 7LEcp8vjXRKE34Dhzg2KjO8fzI5+jhG2Q5v1415jyjSwwKwIDGc6Ydgi9UQo3WTY2E
	 N8GwQ5+GxI0TA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Mehdi Djait <mehdi.djait@linux.intel.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	stable@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 552/752] media: i2c: ov01a10: Fix digital gain range
Date: Sat, 28 Feb 2026 12:44:23 -0500
Message-ID: <20260228174750.1542406-552-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221021-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,qualcomm.com:email]
X-Rspamd-Queue-Id: A91311C9028
X-Rspamd-Action: no action

From: Mehdi Djait <mehdi.djait@linux.intel.com>

[ Upstream commit 91848c99ed6a98daf77f4cb7d44cf3f13bc6998f ]

Digital gain wraps-around at the maximum of 16838 / 0x3fff.
Fix the maximum digital gain by setting it to 0x3fff.

Signed-off-by: Mehdi Djait <mehdi.djait@linux.intel.com>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Fixes: 0827b58dabff ("media: i2c: add ov01a10 image sensor driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov01a10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov01a10.c b/drivers/media/i2c/ov01a10.c
index 3ad516e4d3698..c1a7373a6311c 100644
--- a/drivers/media/i2c/ov01a10.c
+++ b/drivers/media/i2c/ov01a10.c
@@ -57,7 +57,7 @@
 #define OV01A10_REG_DIGITAL_GAIN_GR	0x3513
 #define OV01A10_REG_DIGITAL_GAIN_R	0x3516
 #define OV01A10_DGTL_GAIN_MIN		0
-#define OV01A10_DGTL_GAIN_MAX		0x3ffff
+#define OV01A10_DGTL_GAIN_MAX		0x3fff
 #define OV01A10_DGTL_GAIN_STEP		1
 #define OV01A10_DGTL_GAIN_DEFAULT	1024
 
-- 
2.51.0


