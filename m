Return-Path: <stable+bounces-220089-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ey2FoQno2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220089-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:36:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8714F1C4F2E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4958D3069821
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9BA34A76A;
	Sat, 28 Feb 2026 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6+R+viP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E5B3491C9;
	Sat, 28 Feb 2026 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772299983; cv=none; b=G5pcbYocEzq1wjfuB8kZ83N+nj8B/uwevxl0xUl0T1QehKcltcH/oeB4F2/LzNEjMslie+XXC7Z5f3RoBTApwCx8f7usmjwDWYSYYZ13LaVa+wtuvtfQWIQyAWBqmhr8M9ditB7VpuaMU3KdwYT27cCSRe6HLx1+hXz7GO2n5Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772299983; c=relaxed/simple;
	bh=bZJ3rfOPjv7sv5q4HAz0z1txbRUKRRKW+yJTZKrRPXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kNNcq+GXI62Omgmcw8FzWLni8KB8k3hiOxhKShEXnTCB27OiCBNFpoA9y6pJc+gGVcWEESH3fmxkEO2efHh0TGJQ5WrkffyMRs/9ktLQVhPEvQ0w+ZKHJAljcTtT5ogDQmHox0Iuafk6rqgdEKT3U52juV86O9GBasVxnwy0c2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6+R+viP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FC2C19423;
	Sat, 28 Feb 2026 17:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772299982;
	bh=bZJ3rfOPjv7sv5q4HAz0z1txbRUKRRKW+yJTZKrRPXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f6+R+viP5JhwNlc163QeYArBv4asWcMpS0ykcjthlzC88gqrxZ2kRtQbkqcnLtMRX
	 1y0dHosNKS+ETRjX6arUmyaN3CqUWuV9P5BlFT2O+9nsP+v12ZIv/yvzJE1w6d9nRJ
	 Slymm6APiJIdAEHptZVq+QcFTAu3Lj/8Ik51W1HFyVc1hsgSKCSIRnbT7QepjPvYGT
	 1yhGN+lAsIt69YDuqXUPaxouCFZbjZZg4qJ1Ig45D7fW8wHPrY+mSiDX4DC02KZ/pM
	 jejSUeQOLsfVTvM7ByylM/M/yHO06GN34PqHUcdq6yHwb/32nrgIEGLHd+zAtsWZQU
	 /cMHT4RqyV/sg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 011/844] rtc: max31335: use correct CONFIG symbol in IS_REACHABLE()
Date: Sat, 28 Feb 2026 12:18:44 -0500
Message-ID: <20260228173244.1509663-12-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220089-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:email,msgid.link:url,bootlin.com:email]
X-Rspamd-Queue-Id: 8714F1C4F2E
X-Rspamd-Action: no action

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit d5aca9a17f6de884febc56018f92d743b8ea1298 ]

IS_REACHABLE() is meant to be used with full symbol names from a kernel
.config file, not the shortened symbols used in Kconfig files, so
change HWMON to CONFIG_HWMON in 3 places.

Fixes: dedaf03b99d6 ("rtc: max31335: add driver support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Nuno Sá <nuno.sa@analog.com>
Link: https://patch.msgid.link/20260108045432.2705691-1-rdunlap@infradead.org
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-max31335.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-max31335.c b/drivers/rtc/rtc-max31335.c
index 23b7bf16b4cd5..952b455071d68 100644
--- a/drivers/rtc/rtc-max31335.c
+++ b/drivers/rtc/rtc-max31335.c
@@ -591,7 +591,7 @@ static struct nvmem_config max31335_nvmem_cfg = {
 	.size = MAX31335_RAM_SIZE,
 };
 
-#if IS_REACHABLE(HWMON)
+#if IS_REACHABLE(CONFIG_HWMON)
 static int max31335_read_temp(struct device *dev, enum hwmon_sensor_types type,
 			      u32 attr, int channel, long *val)
 {
@@ -672,7 +672,7 @@ static int max31335_clkout_register(struct device *dev)
 static int max31335_probe(struct i2c_client *client)
 {
 	struct max31335_data *max31335;
-#if IS_REACHABLE(HWMON)
+#if IS_REACHABLE(CONFIG_HWMON)
 	struct device *hwmon;
 #endif
 	const struct chip_desc *match;
@@ -727,7 +727,7 @@ static int max31335_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, ret,
 				     "cannot register rtc nvmem\n");
 
-#if IS_REACHABLE(HWMON)
+#if IS_REACHABLE(CONFIG_HWMON)
 	if (max31335->chip->temp_reg) {
 		hwmon = devm_hwmon_device_register_with_info(&client->dev, client->name, max31335,
 							     &max31335_chip_info, NULL);
-- 
2.51.0


