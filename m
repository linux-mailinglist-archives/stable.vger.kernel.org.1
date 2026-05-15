Return-Path: <stable+bounces-248936-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPV3EFGbB2oD+wIAu9opvQ
	(envelope-from <stable+bounces-248936-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 00:16:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBE7558B2A
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 00:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 896D2304971C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 22:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECEC3F5BFE;
	Fri, 15 May 2026 22:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="N3nqLF9q"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5663F44FC
	for <stable@vger.kernel.org>; Fri, 15 May 2026 22:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778883131; cv=none; b=pljZkywNS3+4ZoGjqJbDh7DQG97vedSt5js2rg57hynShz8uYxE9KVFw73En97xfEafISdzh7qP+SdB5O9/OLGLPIK1be3duvTgD0HNvnvYJ21CFMp695MR8ilqNwBST62EwTShKGd3uH8MGRuOdcDHXB+ol701Pw+afw/XE0+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778883131; c=relaxed/simple;
	bh=zhxWqJ52Q6qTGKwBiQNGvijQCBuYkpUO7Y7g9BcLdgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NF+ELEUFj3ITTkgq0QZq1o6LtESjNndhv2wjsbkD1n9JZsWlHz+nohi4xvH2dxsiAvDGo7gPxCJX9FwWUwT9m/ccxme/8DJOuIcLSJxeJneVVKVh+zIDCrxTDjPJ0k7wHmZOGTvsEBrJL7KpUYWDlO7dq4IT75cBDDtNR3kGn30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=N3nqLF9q; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so1588560eec.0
        for <stable@vger.kernel.org>; Fri, 15 May 2026 15:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1778883128; x=1779487928; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/JhuDfTWcij+46AVt9XxVF2c8YtBvHsSklz5Uok9QCw=;
        b=N3nqLF9qNrSnolynR+RLfz2vD1FZliEtVHUW0qaZEMCkg1rtqcBR0VmZ1fqbZWhUzK
         hOOyHEVyX5akc8aL7AYXWMrOGGBVmH+/0dHyo0vxQs5pilbFWOJ+FOhZ1zV9OCOrCfq8
         s2CmOHzyU84KFQ0QW0tNcFVEGqq7HL/c0HTCOxaiLbqTo97FRHqcRBoyyPL01qLUNxCO
         Q+ROv2gd5oCr6WMVuHZLxSP6zCfajRmLs6RzmFxpWLAdFQvC5AQriLx215IonzmTAZX8
         5DHo0dhYa35srx09ADCQ3E2QipcW7DdNaOzhxuckIiYtk4Vxp2HD1xO+woV9jWuCYcAH
         sn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778883128; x=1779487928;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/JhuDfTWcij+46AVt9XxVF2c8YtBvHsSklz5Uok9QCw=;
        b=hgZ43W/qE0ZvvsIBvObADo60muTk9zouPCZDmTzdDTnxLg8Il7v8/iQoDeJW7AUgWh
         t0/sVTM3Ed0Pcc606f6qrApoULoXsQjJzT3RpiFvkOWxz6rFg3/kboK8ngR5IywBiTOy
         2qRM4Cv082Yurr3jB9sa2BDKKdetM3CN8wO1fr0LtqKoXvqQ+AKIBNbHkvc4VEYb9aDF
         Mb6KCO5Dqjhu+zqqPbCgLwjAEAdg5+VDoWD/TR/IUr0J5l3zmM5uXSqcWcSTfHjq4tjg
         jmd7EBpQ2Kcx0805xSD0cpmRTfKGl6TswhKjCCnfM9wHHvsh/rXO+XqrRtLpyyqhJUqS
         WsLg==
X-Forwarded-Encrypted: i=1; AFNElJ+0qZS1kc+DzYCboLPmXUDuF+Jw/AcqPySivdfTHvbVor1tRzc5unizO64gt/sGfYPSu62NNHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJsnZ9n8FwQdw4Up4dd+hD8431HVIINoKUDOuZMzwPGdB+m6tg
	3dWqQ+4E2nw7hNxV+e+SRe+ky+uUxMFpB5six23YUxqvESea6/g2dF9o49g/7F6Kj+Y=
X-Gm-Gg: Acq92OEe+PTKhdUF8e/amlvW6iOaKvC5nKGgZ6G3D2RAPzyZMJxSm8eum3Ut/U6YpuM
	Y6etGmDs7UerxFwrqjQv6ORve1I3gQueT9E7+NhtUbO6TwwHgQxxhX9+SrtU0LWvhMs11HUJlMj
	zibpusd/6scRxhGx3AMiU3ayjrGEkxMzDxkyBWHbwDQc18uG/ZCkByajYmTd9zHEQ4iaBbpVjkY
	dDbNz/36beFjSRMgD7rAp4w76DvtEGIGt/jsla9I/RJhcMcog6riJPtk1Onj7u1WhokbAovBnMB
	Z1INuJNR+REi0RT3Zt52rB+kdyvnSr5IaxQMr694tm4NczxNSltS7reCLuQ+UjD2HskACUW28QU
	Kot1dkOjChRQuDYV0gbPgvQPW08T7bMi9G/17AeCkRmrvt6VJQPpb5DTCjnvsOoGRWpvVa7h3hy
	kCU6Jm+3l3lbKPkmQjcOCy21Xabb8WfutKUfDC
X-Received: by 2002:a05:7300:a907:b0:2f0:c8b5:3dc7 with SMTP id 5a478bee46e88-30398680c36mr2939435eec.22.1778883127883;
        Fri, 15 May 2026 15:12:07 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2e686sm9626315eec.5.2026.05.15.15.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 15:12:07 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Fri, 15 May 2026 15:11:51 -0700
Subject: [PATCH 5/5] hwmon: (pmbus/adm1266) bounce blackbox records through
 a protocol-sized buffer
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-adm1266-fixes-v1-5-1c1ea1349cfe@nexthop.ai>
References: <20260515-adm1266-fixes-v1-0-1c1ea1349cfe@nexthop.ai>
In-Reply-To: <20260515-adm1266-fixes-v1-0-1c1ea1349cfe@nexthop.ai>
To: Guenter Roeck <linux@roeck-us.net>, 
 Alexandru Tachici <alexandru.tachici@analog.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778883122; l=2365;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=zhxWqJ52Q6qTGKwBiQNGvijQCBuYkpUO7Y7g9BcLdgc=;
 b=e1uT0b11Dc+0JWe2IgewP/RzSkfCoMezb1XvRg+F7LvPJul78o2w22ZbaNVCLYoaSlvq4aNte
 Y3T+uz3DvJhAt3FHAuGdhFzdqnXaTNrnB9eKQgSSDRuPhqoUqLA56Ze
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=
X-Rspamd-Queue-Id: 9FBE7558B2A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nexthop.ai,none];
	R_DKIM_ALLOW(-0.20)[nexthop.ai:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[nexthop.ai:+];
	TAGGED_FROM(0.00)[bounces-248936-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abdurrahman@nexthop.ai,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nexthop.ai:email,nexthop.ai:mid,nexthop.ai:dkim]
X-Rspamd-Action: no action

adm1266_pmbus_block_xfer() copies the device-supplied block payload
into the caller-provided buffer using the device-supplied length:

	memcpy(data_r, &msgs[1].buf[1], msgs[1].buf[0]);

The helper does not know how large data_r is and trusts the device to
return at most one record's worth of bytes.  adm1266_nvmem_read_blackbox()
violates that contract: it advances read_buff inside data->dev_mem in
ADM1266_BLACKBOX_SIZE (64-byte) strides while the helper is willing to
write up to ADM1266_PMBUS_BLOCK_MAX (255) bytes.  A device that returns
more than 64 bytes on the trailing record (read_buff offset 1984 in
the 2048-byte dev_mem allocation) overflows dev_mem by up to 191 bytes
before the post-call

	if (ret != ADM1266_BLACKBOX_SIZE)
		return -EIO;

can reject the response.

Contain the fix in the caller without changing the helper signature:
read each record into a 255-byte local bounce buffer that matches the
helper's maximum output, validate the returned length, and only then
copy exactly ADM1266_BLACKBOX_SIZE bytes into the dev_mem slot.

Fixes: 407dc802a9c0 ("hwmon: (pmbus/adm1266) Add Block process call")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/hwmon/pmbus/adm1266.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index 5c68e3177f64..ea1edb89d2a0 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -348,6 +348,7 @@ static void adm1266_init_debugfs(struct adm1266_data *data)
 
 static int adm1266_nvmem_read_blackbox(struct adm1266_data *data, u8 *read_buff)
 {
+	u8 record[ADM1266_PMBUS_BLOCK_MAX];
 	int record_count;
 	char index;
 	u8 buf[I2C_SMBUS_BLOCK_MAX];
@@ -365,13 +366,14 @@ static int adm1266_nvmem_read_blackbox(struct adm1266_data *data, u8 *read_buff)
 		return -EIO;
 
 	for (index = 0; index < record_count; index++) {
-		ret = adm1266_pmbus_block_xfer(data, ADM1266_READ_BLACKBOX, 1, &index, read_buff);
+		ret = adm1266_pmbus_block_xfer(data, ADM1266_READ_BLACKBOX, 1, &index, record);
 		if (ret < 0)
 			return ret;
 
 		if (ret != ADM1266_BLACKBOX_SIZE)
 			return -EIO;
 
+		memcpy(read_buff, record, ADM1266_BLACKBOX_SIZE);
 		read_buff += ADM1266_BLACKBOX_SIZE;
 	}
 

-- 
2.53.0


