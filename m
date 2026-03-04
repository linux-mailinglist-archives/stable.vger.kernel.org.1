Return-Path: <stable+bounces-222992-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCwCB33ap2kRkQAAu9opvQ
	(envelope-from <stable+bounces-222992-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:08:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E091FB613
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8996C301DE3C
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 07:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C0C363080;
	Wed,  4 Mar 2026 07:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1tyj4T8"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7BA29B8D9
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 07:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608120; cv=none; b=ZCOYKBVa0HX+eBwnvt3QoYqfZoL3+R87ncahKJhi29OYUAVVQvB6TUDkecgTNyxdRHLMnMZpvGJ3NoVpqjEEYStgXNA4JiPwo+hWuZjff2gXsr68zwLi0lQq7gmWmXiSxclbVbsvAttf7ZfkxhpXCSZ+wsaPt2RX13LAULGLFyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608120; c=relaxed/simple;
	bh=2D7OmnZNznfr12HRuVWR6Mw7dZPUCmEaw/CtC/IUQUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a6eFVu38uj8ofhWBHK056P969VKrFuQU6tr/Y/VcoiRmm8oQIsN4u+H0LKJBo5eE6E6wY27i+4gznR2O1WdfAiNvkrfnMKHo9nL0w176rcrsZXz+E58cAFAKyOONLn0rbFq0J7S0/83FxVkhdQE33h7IdpMRLPKL6JB5q0FJPVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1tyj4T8; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ba895adfeaso5742801eec.0
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 23:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772608119; x=1773212919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8nGnzPrNPl6mGWCEnP6l5wCtiMPY7eXNdUImo32HCY=;
        b=T1tyj4T8hQn2u90OpmQNEH/2pW5Qvgqzu1vIOrB0hNqT5B7No/M19Ma+oL8YaIaFf/
         23OWDOg+zfu8GOXnoK3V9tFX/wRhy6GYCOQbBykdjgi3mbjxMm/yHzYe08x4Fh7I+hLT
         wl3x+rrffbBOch7rMFE/ZXW9mMMVrcCI7OJu7yeqCtBksmA8++EKVIBQr3hujZoJnttV
         1Bb1ViodrdPobZmM0c1tFT9cJjOOHvj+WcqW9Yu8ZigztqOMXTJsflQYQ+h8G68tshjX
         a8HDoIanw/Kwuct06EPRdwkBcoDyVYPSrwpt7GTnXZ0BP2ghQUrrPSJmdB7ZLhLDvVCY
         rfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772608119; x=1773212919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s8nGnzPrNPl6mGWCEnP6l5wCtiMPY7eXNdUImo32HCY=;
        b=M5PzmD5hUCRrMxkt5zMhTq95tki1UJ62F4WF1pKOduFFeADLO0mUb9PttpfGvjOmJ9
         WdMmG9KJ2asEfhClM0ApybmbUjrdhAMCjWwEAwejPQqPjxEHvItnv3rEs8LDJYvxC6rY
         +hKZtrJO8+C+eKCmmXbKSIYYs14HKJa4y50TWNWOxhIjJsnVrenu+upz8h/h0d8JT+Ru
         WNLYNCOg3E/7XK6vCS8aRPDc8j7rpKvGCqD3sXx0jhwyhr37rn1IU2OLTdAZteD5IlCk
         Fbjju0kJ3x8LLaFwUJMmFca0a/4X2QPkzH8Diyxrk8ntfUoi4P2oh9SpOnQHQyBOca4N
         vqyg==
X-Forwarded-Encrypted: i=1; AJvYcCVFsebcu0HO8VBvRLaDXB03d1Jr/U88NzMukrs4H8EoKUCpBhtOL6dn9KzjSt4l5iJGmU+VQMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YylOrfIJKTVqVJa2uQIUBy8zZM9hCb2fUNhikEYSIulk81JL+O0
	Z+N5+ISiuf7cN51PNpBkRhG/G3Cl12dL61rpe2L4cA9mrLeTBXUmCzCw
X-Gm-Gg: ATEYQzxt1is+n9v0x8kF7AePue5QgePVNVUcoplfccY3qknsd5oKirg3OVHb9u2NJ+H
	wHYsx6li8+wofZqxpf4Mfm6oNOHu1ieoBXqoRO6dNtwJtby9gG9FHxO5wST7G34kfhxcP6MRzyJ
	h8Fx4Spc0KbQTt9paaQZwjlh/awmkE7iC85DNeZMUATncYLOfj6dPUe4BtZFYxs8ESmVmIRNM3i
	FDRxJwQ2ebBWOe1uJMqFnHGvvMWaWuxOP7euXRe7Z1ATN5TuVr+0VizhVvgZ9bSCg5m4IFo84WS
	FmkHVtXXbGRGmTIFjz9O/vjpA+WuBRsv/qa7jHeVOA9KSV0ghrq1eXggPhRGXrNKdxg39cq6vFg
	Bo1LpeleH2RoZTn1BGcRW+3snt63BupGClBqVqaqO00PJRQH6S1+TPbvje/ccEsvWHRGEtNVCV7
	f2s00mMiNQ7fxNbyBM1l1fBZ/h9TgLlXvp1GBHth9rbkaJC4a+hwqyusKGBQbZ9Ucouw8+FOFkZ
	p6dzjy+sMw=
X-Received: by 2002:a05:7301:2f88:b0:2be:778:49aa with SMTP id 5a478bee46e88-2be3108f8d4mr323361eec.27.1772608118477;
        Tue, 03 Mar 2026 23:08:38 -0800 (PST)
Received: from localhost.localdomain (c-67-164-93-214.hsd1.ca.comcast.net. [67.164.93.214])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be2f5f1f4dsm831673eec.25.2026.03.03.23.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 23:08:37 -0800 (PST)
From: Sanman Pradhan <sanman.p211993@gmail.com>
X-Google-Original-From: Sanman Pradhan <psanman@juniper.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	andriy.shevchenko@intel.com,
	Sanman Pradhan <psanman@juniper.net>
Subject: [PATCH v2] hwmon: (pmbus/q54sj108a2) fix stack overflow in debugfs read
Date: Tue,  3 Mar 2026 23:06:08 -0800
Message-Id: <20260304070607.1942-1-psanman@juniper.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SA1PR05MB8708FB8CDA1A57DE77D158A7BA7CA@SA1PR05MB8708.namprd05.prod.outlook.com>
References: <SA1PR05MB8708FB8CDA1A57DE77D158A7BA7CA@SA1PR05MB8708.namprd05.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 86E091FB613
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-222992-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanmanp211993@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

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

v2:
- Fixed email formatting/line-wrapping issues

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


