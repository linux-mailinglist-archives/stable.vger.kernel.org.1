Return-Path: <stable+bounces-220463-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Kp7Ir5Ko2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220463-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:06:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A95531C7E63
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E434309492B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087713BE31A;
	Sat, 28 Feb 2026 17:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aITxAjSr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4023BE30C;
	Sat, 28 Feb 2026 17:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300350; cv=none; b=RG8WK6WjIk89G6uReBtyzx8uTMVv1zT7p/Ab6daBgbpKBkg7RlcbqdKlv9vHOilSkm1ZYs8/MZSNTUWCDM9kIMxB+WmdmwbYHqqoTN3DMvuy9ouYTRD39tYuSo5h0NY0R+kkJfLO6jJmdKYTuefZ5fL6xytyo5ZhBn/t06EHhCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300350; c=relaxed/simple;
	bh=TZJLHA1ruZzfEsUVx0wbMMbI14TZoKcsi1pdmpeNt4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9djr5YmMCU79rEaN/M2W5gqyRDMbyLRdFXKf06ezV8X54OJqwYq2qeRTms88b/d4KdPgZribtZ2eudZyal+NTSqd6jQEkV1YOdb9AQWI5Ge46kE1SfuLbJn+tzJd8AWZ5cLAfhI16YV0VoJ9myrFbJ0d9w/mutZBB4lF8mtoJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aITxAjSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2394C116D0;
	Sat, 28 Feb 2026 17:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300350;
	bh=TZJLHA1ruZzfEsUVx0wbMMbI14TZoKcsi1pdmpeNt4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aITxAjSr8IgQ9MbwGrUf24ScxIoQEIrnNyk2Qp8BV6odMZa7sIZ3JFqpeaSxXVVzM
	 k5niqIMArSV87Hk+vhHdKphEO8f84LII9eplxP+FdvJZ3M1KZqEgFih2wsERCCPHj/
	 VXobQDZJZZYXrtOVip4iuV+l0QqoAMyH+vcga5UCAuchyx+JuWyKWuYC09887t6bDa
	 EjvqgAVYHOfcCVXUbTfWVXdKBf5ulX6Dqn/4fQ8AV+84pvZq7srdaejIMlLRLGsKlG
	 eVTIQ5FNdzXe1SQpAGT8mBYFsucyhxww8+Hd7pnLttrZjgIfaX6Xep4YFWGxvIZCIt
	 hXO/PGTlqb/0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Derek J. Clark" <derekjohn.clark@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 384/844] iio: bmi270_i2c: Add MODULE_DEVICE_TABLE for BMI260/270
Date: Sat, 28 Feb 2026 12:24:57 -0500
Message-ID: <20260228173244.1509663-385-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,huawei.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-220463-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,huawei.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A95531C7E63
X-Rspamd-Action: no action

From: "Derek J. Clark" <derekjohn.clark@gmail.com>

[ Upstream commit f69b5ac682dbc61e6aca806c22ce2ae74d598e45 ]

Currently BMI260 & BMI270 devices do not automatically load this
driver. To fix this, add missing MODULE_DEVICE_TABLE for the i2c,
acpi, and of device tables so the driver will load when the hardware
is detected.

Tested on my OneXPlayer F1 Pro.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/imu/bmi270/bmi270_i2c.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
index b909a421ad017..b92da4e0776fa 100644
--- a/drivers/iio/imu/bmi270/bmi270_i2c.c
+++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
@@ -37,6 +37,7 @@ static const struct i2c_device_id bmi270_i2c_id[] = {
 	{ "bmi270", (kernel_ulong_t)&bmi270_chip_info },
 	{ }
 };
+MODULE_DEVICE_TABLE(i2c, bmi270_i2c_id);
 
 static const struct acpi_device_id bmi270_acpi_match[] = {
 	/* GPD Win Mini, Aya Neo AIR Pro, OXP Mini Pro, etc. */
@@ -45,12 +46,14 @@ static const struct acpi_device_id bmi270_acpi_match[] = {
 	{ "BMI0260",  (kernel_ulong_t)&bmi260_chip_info },
 	{ }
 };
+MODULE_DEVICE_TABLE(acpi, bmi270_acpi_match);
 
 static const struct of_device_id bmi270_of_match[] = {
 	{ .compatible = "bosch,bmi260", .data = &bmi260_chip_info },
 	{ .compatible = "bosch,bmi270", .data = &bmi270_chip_info },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, bmi270_of_match);
 
 static struct i2c_driver bmi270_i2c_driver = {
 	.driver = {
-- 
2.51.0


