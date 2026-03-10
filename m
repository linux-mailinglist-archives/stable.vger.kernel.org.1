Return-Path: <stable+bounces-224385-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sP72CZEDsGkWegIAu9opvQ
	(envelope-from <stable+bounces-224385-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:42:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA8324B5AD
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2982A30C2865
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB4538A71A;
	Tue, 10 Mar 2026 11:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ac9Uoo3/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F98138B7C9;
	Tue, 10 Mar 2026 11:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142118; cv=none; b=J9BUdd8IB0zbegARBP9mvU62GYbC3+/M6lIvK7A16ugSU9x/ZVTIqPOV9LNT6cbU1WuFV329livkbAQMEv79l1Vxxqvb0Yf3T5THQs6hFp4kFj2R7eOwRBXutH983YeHjkBM2KpcnL+AmiSPu8eXelZzaoyGFbML7qXrCy7PePw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142118; c=relaxed/simple;
	bh=QfbJ623dNPxdYtPllSDMNGt6GKXflJADgtF3klxRFFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcsK4PxtkGjjCi8Cm7GbGFtmlBMusLu+mAy2BLLXA768qhsGDffYMOCMu2lcN3yG8SGMnBQVPyJ5dluTjl/jRlvgQtMamm9ZUfuBH2Xg3fYHLXLil2WGtO9c52B1zv7Vfhu9Qd4eqQiGagJyOtCVGVqhOgCK8B+QhYacNsw0aCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ac9Uoo3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC1EC2BC9E;
	Tue, 10 Mar 2026 11:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142118;
	bh=QfbJ623dNPxdYtPllSDMNGt6GKXflJADgtF3klxRFFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ac9Uoo3/6OfKv5BTS8qWFnp4l5xVIdGSfyF8LlQiO7lnkYvTtS0WzvP0vBN05GYe1
	 81jqsonnrWNz/q/vS1OFRv+eJCR7LxYm3AssI21JCQwQFjfVG7yjU+mOyrtBdE882c
	 C93fEYvl8GxT7QGAgx7jGPUSbIalZcMwx1DXPd0E5RA9e2oCXl2zlpAC4+10IrKwmp
	 sZtq4ue16eVsAgoaW82vntFalZGbHjDlV/zexo9t3sTdD7qS2Ea4xqiKPvVEMw5HBy
	 SHDR9bfqoZt0cliJb45ZjlV0H0eV6r51oIEyKQDVoBiQMRuGvL7k+BW4y5YeDzFQfe
	 CzLboiIDCf3PA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Akhilesh Patil <akhilesh@ee.iitb.ac.in>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 206/314] hwmon: (aht10) Add support for dht20
Date: Tue, 10 Mar 2026 07:17:45 -0400
Message-ID: <1a24b368736cfe98f47443291af0757766b10e75.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1FA8324B5AD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224385-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,aosong.com:url,digikey.co.nz:url]
X-Rspamd-Action: no action

From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>

[ Upstream commit 3eaf1b631506e8de2cb37c278d5bc042521e82c1 ]

Add support for dht20 temperature and humidity sensor from Aosong.
Modify aht10 driver to handle different init command for dht20 sensor by
adding init_cmd entry in the driver data. dht20 sensor is compatible with
aht10 hwmon driver with this change.

Tested on TI am62x SK board with dht20 sensor connected at i2c-2 port.

Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Link: https://lore.kernel.org/r/2025112-94320-906858@bhairav-test.ee.iitb.ac.in
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Stable-dep-of: b7497b5a99f5 ("hwmon: (aht10) Fix initialization commands for AHT20")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/hwmon/aht10.rst | 10 +++++++++-
 drivers/hwmon/Kconfig         |  6 +++---
 drivers/hwmon/aht10.c         | 19 ++++++++++++++++---
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/Documentation/hwmon/aht10.rst b/Documentation/hwmon/aht10.rst
index 213644b4ecba6..7903b6434326d 100644
--- a/Documentation/hwmon/aht10.rst
+++ b/Documentation/hwmon/aht10.rst
@@ -20,6 +20,14 @@ Supported chips:
 
       English: http://www.aosong.com/userfiles/files/media/Data%20Sheet%20AHT20.pdf
 
+  * Aosong DHT20
+
+    Prefix: 'dht20'
+
+    Addresses scanned: None
+
+    Datasheet: https://www.digikey.co.nz/en/htmldatasheets/production/9184855/0/0/1/101020932
+
 Author: Johannes Cornelis Draaijer <jcdra1@gmail.com>
 
 
@@ -33,7 +41,7 @@ The address of this i2c device may only be 0x38
 Special Features
 ----------------
 
-AHT20 has additional CRC8 support which is sent as the last byte of the sensor
+AHT20, DHT20 has additional CRC8 support which is sent as the last byte of the sensor
 values.
 
 Usage Notes
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 2760feb9f83b5..2a71b6e834b08 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -245,12 +245,12 @@ config SENSORS_ADT7475
 	  will be called adt7475.
 
 config SENSORS_AHT10
-	tristate "Aosong AHT10, AHT20"
+	tristate "Aosong AHT10, AHT20, DHT20"
 	depends on I2C
 	select CRC8
 	help
-	  If you say yes here, you get support for the Aosong AHT10 and AHT20
-	  temperature and humidity sensors
+	  If you say yes here, you get support for the Aosong AHT10, AHT20 and
+	  DHT20 temperature and humidity sensors
 
 	  This driver can also be built as a module. If so, the module
 	  will be called aht10.
diff --git a/drivers/hwmon/aht10.c b/drivers/hwmon/aht10.c
index d1c55e2eb4799..a153282eef6a2 100644
--- a/drivers/hwmon/aht10.c
+++ b/drivers/hwmon/aht10.c
@@ -37,6 +37,8 @@
 #define AHT10_CMD_MEAS	0b10101100
 #define AHT10_CMD_RST	0b10111010
 
+#define DHT20_CMD_INIT	0x71
+
 /*
  * Flags in the answer byte/command
  */
@@ -48,11 +50,12 @@
 
 #define AHT10_MAX_POLL_INTERVAL_LEN	30
 
-enum aht10_variant { aht10, aht20 };
+enum aht10_variant { aht10, aht20, dht20};
 
 static const struct i2c_device_id aht10_id[] = {
 	{ "aht10", aht10 },
 	{ "aht20", aht20 },
+	{ "dht20", dht20 },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, aht10_id);
@@ -77,6 +80,7 @@ MODULE_DEVICE_TABLE(i2c, aht10_id);
  *              AHT10/AHT20
  *   @crc8: crc8 support flag
  *   @meas_size: measurements data size
+ *   @init_cmd: Initialization command
  */
 
 struct aht10_data {
@@ -92,6 +96,7 @@ struct aht10_data {
 	int humidity;
 	bool crc8;
 	unsigned int meas_size;
+	u8 init_cmd;
 };
 
 /*
@@ -101,13 +106,13 @@ struct aht10_data {
  */
 static int aht10_init(struct aht10_data *data)
 {
-	const u8 cmd_init[] = {AHT10_CMD_INIT, AHT10_CAL_ENABLED | AHT10_MODE_CYC,
+	const u8 cmd_init[] = {data->init_cmd, AHT10_CAL_ENABLED | AHT10_MODE_CYC,
 			       0x00};
 	int res;
 	u8 status;
 	struct i2c_client *client = data->client;
 
-	res = i2c_master_send(client, cmd_init, 3);
+	res = i2c_master_send(client, cmd_init, sizeof(cmd_init));
 	if (res < 0)
 		return res;
 
@@ -352,9 +357,17 @@ static int aht10_probe(struct i2c_client *client)
 		data->meas_size = AHT20_MEAS_SIZE;
 		data->crc8 = true;
 		crc8_populate_msb(crc8_table, AHT20_CRC8_POLY);
+		data->init_cmd = AHT10_CMD_INIT;
+		break;
+	case dht20:
+		data->meas_size = AHT20_MEAS_SIZE;
+		data->crc8 = true;
+		crc8_populate_msb(crc8_table, AHT20_CRC8_POLY);
+		data->init_cmd = DHT20_CMD_INIT;
 		break;
 	default:
 		data->meas_size = AHT10_MEAS_SIZE;
+		data->init_cmd = AHT10_CMD_INIT;
 		break;
 	}
 
-- 
2.51.0


