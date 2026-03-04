Return-Path: <stable+bounces-223154-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCduLj/GqGlaxAAAu9opvQ
	(envelope-from <stable+bounces-223154-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 00:54:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C075F209317
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 00:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CEF37303CD9D
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 23:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A2037104F;
	Wed,  4 Mar 2026 23:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0z/7OPT"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFEA3264F5
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 23:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772668474; cv=none; b=SJ6JdroC4xHAh/gnl1JMfhsV9lknSVn/3KrKfYiCdu3jnewnGs53AN9wsmtuFvR2AbqIDfAvikBOsTsAKeKOGxXizresUjr6bHauPgQids9/BwDGflOafXVIzennaWKpkcj2PVayfu5b80Rn2kLxqGS1fnRR8Jg4nq+ab6n6QqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772668474; c=relaxed/simple;
	bh=1ryANju3Ar4X9WTQ8vLKNNPSH0DRzpHGinxvGeEFaac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=idSMy6o5xdjx8EvTikr7h8+dZ0FCt8S7dzl6SO3S8FfgfiBmUW9iQfxwFFyvDcWUcfp1IlotUEnCRZcG7xCOYnmrweGznHoDK6ZBihWenCVVvM2kfGA4G9MSElRVblVkTK1mAThvXozVpTJws+9SRu5jiCftAuwXHPX6dxauURc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0z/7OPT; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2be27fa54feso3181549eec.0
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 15:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772668471; x=1773273271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpK5v0erAcEOSlwebTzYjsOHzTGHJQo4jlwH6VYDLJw=;
        b=k0z/7OPTF3OE9a5QviAT3O0lttW8MP+NJaHCt7uI0F84qPuw660VdkJKSaRcTjurJy
         6mOVMLwRcD6we6InSsCwJ2g7ZLuGI/oZ+1YxLVLQygfyEwmGBw4hG1rOwwM0agg8UE+v
         kWklKrz0JfiM8fzgG7o+humkdU+KcKbygfEowmtTN8bBKJ7/jtqooJt086CdYqRbsoYC
         x1uqb0oN33eyoVz/ZoeUbMN1YvjYWz2N3SKuszpYJYI3wR7kGzeqoPbAFPehvUqo2RA2
         nuMmufjFgXM6WtK5my9/5Q0xUtz8z9pGGdQHRRH/JSHJsAZyKQyO2IPizNiwAY8WnFDg
         L8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772668471; x=1773273271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WpK5v0erAcEOSlwebTzYjsOHzTGHJQo4jlwH6VYDLJw=;
        b=lN2vkfwdK+NqbQtVdyWOe5OA22wAMDxpPb+ks+v9DpdzmxW83TXqBkuSgLzN7v+umN
         6OP0K7FgdwAnML7lPIMkoXs6Ddr1feJWf8mZs3S2pSeJizgULMxTEUFY3AxVmUt3N/oU
         JFebVbtZwLBGgqNLxPV+jW8ChDwePkrsoVjybfRAduhANkyaZgG4SJScwJx9oUhfBO1C
         yu8VmZh+790NFZlM6bLGtTUF/KpHZHtvWRQ9Qg6CAt9E1O/7vDhA4oeDQktMyr+tvsx2
         7PwScJ8pHAI3lc7FHqG5FKjPBqtDI0MO6weKcSEhVNxE8nL0qe0Q6niNdUuGSq09AP3u
         MjYg==
X-Forwarded-Encrypted: i=1; AJvYcCU82jfVsn2eCIYhMSOgKsw6GURZKgtOWR2kW5GFHtp8ezi0ZY/rJOOO6H6OyqNEsqFbkg5VmQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX5v73t+W+ia2txzDpDIywoiSyi7igjrX1Dgz4k1wkDB495dR+
	GHIpn5IFpxDbfZ2PqCZfSKncujWKqmfNBZmki4mIjW4HX/Apy6n7kRCC
X-Gm-Gg: ATEYQzw+StJlMDdkrX7GCH86YpXMA8ir4MVpbXdKYhWRsxP+JXvQtRF25DCrQEfeejT
	gfio6TIuZv9qkFtsjXbNDwdYdKYD9FYU05qOSghqZeE4LCVXX7PbE8pwxSw2ODbKIUgLgrptBeg
	3j3x/lMAgpT4LyMO8wpMLHmt9WZazK/rJM8PHzx2JVGeuuY4uZIrT6petAl7MuETKe4nLkKAWJo
	riWEP1ie9C+NC89clddBQz10+1tZJhB7tRi6KHIRj2Z95f3uJ1KvAXax1osZbmXir5BlrdykDud
	eVvlVMjYpoc32Chef5GAdjZYA8h97aibwQvvYxUPchYER0iSg4DuY2NdnuQP4sjkvE6txtGbg91
	slGGgMHnJ5mzotd50OzpM84jQ3JWhHVpqbNbQtZziGdr3CpcpUhfGOlSB6gTR9UjCwphIg3QhkZ
	7gcIOdRfueYaYt7OePPCdmWQFoUO98fTSZeVFnPzwGmLf/HFmRl7JoifOiDj6D069gUsaurB0q1
	TFtKbA=
X-Received: by 2002:a05:7300:6423:b0:2be:1f56:ecf6 with SMTP id 5a478bee46e88-2be30fcff4bmr1485430eec.6.1772668471087;
        Wed, 04 Mar 2026 15:54:31 -0800 (PST)
Received: from localhost.localdomain (c-67-164-93-214.hsd1.ca.comcast.net. [67.164.93.214])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be12805b93sm9269888eec.15.2026.03.04.15.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:54:30 -0800 (PST)
From: Sanman Pradhan <sanman.p211993@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: psanman@juniper.net,
	andriy.shevchenko@intel.com,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] hwmon: (pmbus/q54sj108a2) fix stack overflow in debugfs read
Date: Wed,  4 Mar 2026 15:51:17 -0800
Message-Id: <20260304235116.1045-1-sanman.p211993@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e7191c1c-ecd4-40f8-9e47-9357bd82984f@roeck-us.net>
References: <e7191c1c-ecd4-40f8-9e47-9357bd82984f@roeck-us.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C075F209317
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223154-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sanmanp211993@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Sanman Pradhan <psanman@juniper.net>

The q54sj108a2_debugfs_read function suffers from a stack buffer overflow
due to incorrect arguments passed to bin2hex(). The function currently
passes 'data' as the destination and 'data_char' as the source.

Because bin2hex() converts each input byte into two hex characters, a
32-byte block read results in 64 bytes of output. Since 'data' is only
34 bytes (I2C_SMBUS_BLOCK_MAX + 2), this writes 30 bytes past the end
of the buffer onto the stack.

Additionally, the arguments were swapped: it was reading from the
zero-initialized 'data_char' and writing to 'data', resulting in
all-zero output regardless of the actual I2C read.

Fix this by:
1. Expanding 'data_char' to 66 bytes to safely hold the hex output.
2. Correcting the bin2hex() argument order and using the actual read count.
3. Using a pointer to select the correct output buffer for the final
   simple_read_from_buffer call.

Fixes: d014538aa385 ("hwmon: (pmbus) Driver for Delta power supplies Q54SJ108A2")
Cc: stable@vger.kernel.org
Signed-off-by: Sanman Pradhan <psanman@juniper.net>
---

v3:
- Added in-body From: header to fix author/sender mismatch.
v2:
- Fixed email formatting/line-wrapping issues.

---
 drivers/hwmon/pmbus/q54sj108a2.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/pmbus/q54sj108a2.c b/drivers/hwmon/pmbus/q54sj108a2.c
index fc030ca34480..d5d60a9af8c5 100644
--- a/drivers/hwmon/pmbus/q54sj108a2.c
+++ b/drivers/hwmon/pmbus/q54sj108a2.c
@@ -79,7 +79,8 @@ static ssize_t q54sj108a2_debugfs_read(struct file *file, char __user *buf,
 	int idx = *idxp;
 	struct q54sj108a2_data *psu = to_psu(idxp, idx);
 	char data[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
-	char data_char[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
+	char data_char[I2C_SMBUS_BLOCK_MAX * 2 + 2] = { 0 };
+	char *out = data;
 	char *res;
 
 	switch (idx) {
@@ -150,27 +151,27 @@ static ssize_t q54sj108a2_debugfs_read(struct file *file, char __user *buf,
 		if (rc < 0)
 			return rc;
 
-		res = bin2hex(data, data_char, 32);
-		rc = res - data;
-
+		res = bin2hex(data_char, data, rc);
+		rc = res - data_char;
+		out = data_char;
 		break;
 	case Q54SJ108A2_DEBUGFS_FLASH_KEY:
 		rc = i2c_smbus_read_block_data(psu->client, PMBUS_FLASH_KEY_WRITE, data);
 		if (rc < 0)
 			return rc;
 
-		res = bin2hex(data, data_char, 4);
-		rc = res - data;
-
+		res = bin2hex(data_char, data, rc);
+		rc = res - data_char;
+		out = data_char;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	data[rc] = '\n';
+	out[rc] = '\n';
 	rc += 2;
 
-	return simple_read_from_buffer(buf, count, ppos, data, rc);
+	return simple_read_from_buffer(buf, count, ppos, out, rc);
 }
 
 static ssize_t q54sj108a2_debugfs_write(struct file *file, const char __user *buf,
-- 
2.34.1


