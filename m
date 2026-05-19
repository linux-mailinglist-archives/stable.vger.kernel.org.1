Return-Path: <stable+bounces-249425-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AZLDtO0C2q2LAUAu9opvQ
	(envelope-from <stable+bounces-249425-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 02:54:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC65575D1C
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 02:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E8FE3068BE4
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 00:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497692F8E98;
	Tue, 19 May 2026 00:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="kWvDZK8o"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9632E2DDD
	for <stable@vger.kernel.org>; Tue, 19 May 2026 00:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151958; cv=none; b=bpfbqgPia6y0V0QiHNUesyqqaqDQDOCZHI/Vr0kqH47OqzykRFrtM1wZNBJnZulhWhGeOO6Lb5C7nlwz1hDPYz0C1457/FWHsUAIsqo/kdZxDGS/BRC+w5tT/ee8770sz+QZJQJrGEUkVU9b/7uGH2cunwh0NPL8vfyubyKVcz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151958; c=relaxed/simple;
	bh=kGAUxCtbDfmt+7K9n1CVIf/I9Exjw2mL1Khe/Uk924I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=evCxNkAiFyQqb4n4ESDpl9vlyFWJG+QYvRBRYVKaS+P5dKhACVwdFN6FbClp57qd3212kPfZFrxOWA50EHB4wovamOVlmC7D9oHKNfxIbseEXZK/6TYRqVZnolXn0h5xHWv3c+uFXgvKlsPQSDBjJA8xdERREaacRzAHjkRwktU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=kWvDZK8o; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1331e851faaso1492678c88.1
        for <stable@vger.kernel.org>; Mon, 18 May 2026 17:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1779151955; x=1779756755; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sYDly6dzMfBVk+bP7Sp71lgzYnskpjHG63z/xSSPQ2M=;
        b=kWvDZK8o10adgbx/UbTu/EBWNCyeZi/m4r/9Tomh0M1hP7u7esNQrv3MRtNUbmTXSP
         s1kv1LnfvzXxf8VbHAeFgVosX9gofJeUrYYHA4/66AThgeX7WKfaQt1AAq7Ydrq5fcQc
         +pPwJJsEZaL2VNHJthiFNuVN+zYm9tJ/QyJA4501qLOXvnGvqEKvchs9BuOrxVA51aaL
         mxqXW5K/NcQ+Pp46OzFQv8IYRN2OEbWdTKzF72odMrRZy8/9NrrHPdFPuBpNDwxbp0Cv
         ISF0Ag6Ocr5+eAJpq3ebQ0BMTLr1Lt7FgsWDwzAz+QNHL8R3Ghm83A41ry8m7nJT3pzB
         BX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151955; x=1779756755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sYDly6dzMfBVk+bP7Sp71lgzYnskpjHG63z/xSSPQ2M=;
        b=izz7xtBL992CGOjOL1vu0NFcVp9pt6yz7UUEl8tkpvOu4LvUPN0X2dULxBzN6eCyWw
         IK5M216qID/yjbSspy/rsdQFawhgQxlYBM1lFcjVZ2Wm/7cUdydVV+j2RvL48rtypMOm
         0tbLennDKCkabyZVmnkZUgStpG63ExS5Whch8BtzjKCM7Y2AOHTQmYJlY3UQL1XGp/+6
         41JsZqMNreMv3Sn5nQoGKoFvSu5ILywMMgSKMdGH39cFHKDc3Kj/bI6FfJMmzj28ov5J
         xmLf3KsMOneq2WbeWCBMsC+8GAm1Ze70RtCxWYv1yPNgUFFRI6iqHJdBciWkDspLvZtj
         uHnQ==
X-Forwarded-Encrypted: i=1; AFNElJ9kClU8wIs1GUBxGOhawEugJgEWXvBlSGvtvr7tZizqvnMsfckJrngVQLPjAWFspi37R7baVJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiJH27PUc9zlOoyEI2WQI5Y5tiyUubrVqrHutO04t7qQ++V5F3
	D+h8pxDnu8oQ1z7ckNcMHQ/Ldq6e8LghjYLZw2b0QUE5efpOrHpImo+olix6kwuI9M8=
X-Gm-Gg: Acq92OEY1kMZjmncqtfC1xNa86HybCzHlrTJDAA6Y2kPnKoi+fiK+dHVmF+xBhtlnQw
	m2ORcu8UGNQv8Qy6qYtA6h6AtXfOcRLPhFtQB03KmEv+cLsGXChxxsB2BVf5avKJq7O4vnmNYOU
	zJpl4dojfE+y7aFrLWNXg+1jV2KEv/swcI9Uj6SnqHzywbhNo3IRzpbqX49c1fYz7uNRU1dNEQq
	o8WT6GZ+dwmuqqf5Nzeek81h58WXpTi6RHrQDu8Aeqn8y1pvH3f/8YabcZgkl7h3yRpfQeiYWVc
	c63PXZWVlo8dLChkUDcxZzaqqP5qxutL1U0CrjQej/6ZhfRPtTyBdOeJ4FZ3nUWxN0oNEVavFtY
	0K6nUOEpTxW2kXmDdZkJz8XvmH7n/g9Bx4RP3DgA3tVbY+E5Upfl2hfNSWVKl3D05PfNtBdtC5T
	X9IcEWGTM/S6AGDtBG3OpllzwZdQ==
X-Received: by 2002:a05:7022:f508:b0:135:40b2:ede2 with SMTP id a92af1059eb24-13540b2ef7fmr2486006c88.3.1779151955117;
        Mon, 18 May 2026 17:52:35 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb93f3sm22546633c88.3.2026.05.18.17.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 17:52:34 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Mon, 18 May 2026 17:52:30 -0700
Subject: [PATCH v3 6/8] hwmon: (pmbus/adm1266) serialize GPIO PMBus
 accesses with pmbus_lock
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-adm1266-gpio-fixes-v3-6-e425e4f88139@nexthop.ai>
References: <20260518-adm1266-gpio-fixes-v3-0-e425e4f88139@nexthop.ai>
In-Reply-To: <20260518-adm1266-gpio-fixes-v3-0-e425e4f88139@nexthop.ai>
To: Guenter Roeck <linux@roeck-us.net>, 
 Alexandru Tachici <alexandru.tachici@analog.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779151949; l=2124;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=kGAUxCtbDfmt+7K9n1CVIf/I9Exjw2mL1Khe/Uk924I=;
 b=9vVVO+CcgVRiqRirJmI1dL8zn8m7wPIIrw7ytI1DhMCMynB3bEERLXVdkm14ZxySs9eWEYO0i
 r5IYC90CXlxDB9B4gVoLnDeylPugQhUkW+RZ3r6FrpP0bsHQg+c1XSR
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nexthop.ai,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nexthop.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[nexthop.ai:+];
	TAGGED_FROM(0.00)[bounces-249425-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abdurrahman@nexthop.ai,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nexthop.ai:email,nexthop.ai:mid,nexthop.ai:dkim,qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: ACC65575D1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

adm1266_gpio_get(), adm1266_gpio_get_multiple(), and
adm1266_gpio_dbg_show() all issue PMBus reads against the device but
none of them take pmbus_lock.  The pmbus_core framework holds
pmbus_lock around its own multi-transaction sequences (notably the
"set PAGE, then read paged register" pattern used by hwmon
attributes), so an unlocked GPIO accessor can land between a PAGE
write and the subsequent paged read in another thread and corrupt
either side's view of the device state machine.

Take pmbus_lock at the top of each of the three accessors via the
scope-based guard().  The lock is uncontended in the common case and
adds only a single mutex round-trip per call.

Fixes: d98dfad35c38 ("hwmon: (pmbus/adm1266) Add support for GPIOs")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/hwmon/pmbus/adm1266.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index 8b9fbb99a4bd..a80fb2ea73bd 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -172,6 +172,8 @@ static int adm1266_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	else
 		pmbus_cmd = ADM1266_PDIO_STATUS;
 
+	guard(pmbus_lock)(data->client);
+
 	ret = i2c_smbus_read_block_data(data->client, pmbus_cmd, read_buf);
 	if (ret < 0)
 		return ret;
@@ -194,6 +196,8 @@ static int adm1266_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask
 	unsigned int gpio_nr;
 	int ret;
 
+	guard(pmbus_lock)(data->client);
+
 	ret = i2c_smbus_read_block_data(data->client, ADM1266_GPIO_STATUS, read_buf);
 	if (ret < 0)
 		return ret;
@@ -235,6 +239,8 @@ static void adm1266_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 	int ret;
 	int i;
 
+	guard(pmbus_lock)(data->client);
+
 	for (i = 0; i < ADM1266_GPIO_NR; i++) {
 		write_cmd = adm1266_gpio_mapping[i][1];
 		ret = adm1266_pmbus_block_xfer(data, ADM1266_GPIO_CONFIG, 1, &write_cmd, read_buf);

-- 
2.53.0


