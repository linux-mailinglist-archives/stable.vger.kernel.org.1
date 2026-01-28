Return-Path: <stable+bounces-212652-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPdUCLJPemnk5AEAu9opvQ
	(envelope-from <stable+bounces-212652-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 19:04:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AB8A7701
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 19:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20E82302E93F
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 18:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA3F330641;
	Wed, 28 Jan 2026 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/De4wHw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805032BEC2E
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623366; cv=none; b=UthBZRR+M3gJgkDHkpdKjEh20drzXs2qWhtXUYT7bnShkVblkU92JUBcLucz/xw98OfEgG7+8rWX5cM+WvrSC8R/3ZksLTUlP7trFm2vQ56wYq7+riCddcZanz+owTF9gy9BmqjGdeLIKoRBPIVORjsK3D6ndA6cROn17gvJUbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623366; c=relaxed/simple;
	bh=PXic9HXGeSBpVBeak2yVLuDq51h4p9iIdeA2d6IV3Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTF9Uwt+2rDr4+Ejw82gQxmsS7tMq85skifPptB2jlH7zPZljKWdRy8ae//DyEvdSiXEUz8dmhKVCi+FORdsJCKNDGSFD1msfw0rJjqEjhkxVLKXtTTosN3x06M4RvbEv4/+p1gdf9HCe07XDgfQib7AS+g7JXnqSc+3oJ6My3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/De4wHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF983C4CEF7;
	Wed, 28 Jan 2026 18:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769623366;
	bh=PXic9HXGeSBpVBeak2yVLuDq51h4p9iIdeA2d6IV3Ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b/De4wHwZP7MsQR3XkEe1+Z7q2Zf/wreEL2dddDMRklS3exn7Xkm4ceuXOAXLrz7J
	 4OwbbHW7aCUVpRz68y04g48rW0SEuvdLpHwUPdKtu2XQA2UpVQn2I5ojfKmhKzQlkY
	 7Y5d4PbFfx7oblcwxPmOt6xD5bTjG/it2haepWaPqfm68O44eq0M/FhSMxzLDW2d5S
	 4iKzAw2Fl1nvGy1QXxgelTpSNbK414Z0BAhyFWT92rkEJnVIFpOHkyitrRzDAWja/v
	 QVHuJnvnqdYOgT8zmiDhzBVb1MqYk/cCAE/fCwVJlnrotngM7v0Ji7Z3YN46qohkbn
	 AxVNTnKoyM4dw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] w1: therm: Fix off-by-one buffer overflow in alarms_store
Date: Wed, 28 Jan 2026 13:02:43 -0500
Message-ID: <20260128180243.2612857-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128180243.2612857-1-sashal@kernel.org>
References: <2026012736-shaping-sixfold-2889@gregkh>
 <20260128180243.2612857-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212652-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linux.dev:email]
X-Rspamd-Queue-Id: 80AB8A7701
X-Rspamd-Action: no action

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit 761fcf46a1bd797bd32d23f3ea0141ffd437668a ]

The sysfs buffer passed to alarms_store() is allocated with 'size + 1'
bytes and a NUL terminator is appended. However, the 'size' argument
does not account for this extra byte. The original code then allocated
'size' bytes and used strcpy() to copy 'buf', which always writes one
byte past the allocated buffer since strcpy() copies until the NUL
terminator at index 'size'.

Fix this by parsing the 'buf' parameter directly using simple_strtoll()
without allocating any intermediate memory or string copying. This
removes the overflow while simplifying the code.

Cc: stable@vger.kernel.org
Fixes: e2c94d6f5720 ("w1_therm: adding alarm sysfs entry")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Link: https://patch.msgid.link/20251216145007.44328-2-thorsten.blum@linux.dev
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/w1/slaves/w1_therm.c | 62 ++++++++++++------------------------
 1 file changed, 20 insertions(+), 42 deletions(-)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index b745070e8c4ae..7ebf8db6e1d75 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -1780,53 +1780,35 @@ static ssize_t alarms_store(struct device *device,
 	struct w1_slave *sl = dev_to_w1_slave(device);
 	struct therm_info info;
 	u8 new_config_register[3];	/* array of data to be written */
-	int temp, ret;
-	char *token = NULL;
+	long long temp;
+	int ret = 0;
 	s8 tl, th;	/* 1 byte per value + temp ring order */
-	char *p_args, *orig;
-
-	p_args = orig = kmalloc(size, GFP_KERNEL);
-	/* Safe string copys as buf is const */
-	if (!p_args) {
-		dev_warn(device,
-			"%s: error unable to allocate memory %d\n",
-			__func__, -ENOMEM);
-		return size;
-	}
-	strcpy(p_args, buf);
-
-	/* Split string using space char */
-	token = strsep(&p_args, " ");
-
-	if (!token)	{
-		dev_info(device,
-			"%s: error parsing args %d\n", __func__, -EINVAL);
-		goto free_m;
-	}
-
-	/* Convert 1st entry to int */
-	ret = kstrtoint (token, 10, &temp);
+	const char *p = buf;
+	char *endp;
+
+	temp = simple_strtoll(p, &endp, 10);
+	if (p == endp || *endp != ' ')
+		ret = -EINVAL;
+	else if (temp < INT_MIN || temp > INT_MAX)
+		ret = -ERANGE;
 	if (ret) {
 		dev_info(device,
 			"%s: error parsing args %d\n", __func__, ret);
-		goto free_m;
+		return size;
 	}
 
 	tl = int_to_short(temp);
 
-	/* Split string using space char */
-	token = strsep(&p_args, " ");
-	if (!token)	{
-		dev_info(device,
-			"%s: error parsing args %d\n", __func__, -EINVAL);
-		goto free_m;
-	}
-	/* Convert 2nd entry to int */
-	ret = kstrtoint (token, 10, &temp);
+	p = endp + 1;
+	temp = simple_strtoll(p, &endp, 10);
+	if (p == endp)
+		ret = -EINVAL;
+	else if (temp < INT_MIN || temp > INT_MAX)
+		ret = -ERANGE;
 	if (ret) {
 		dev_info(device,
 			"%s: error parsing args %d\n", __func__, ret);
-		goto free_m;
+		return size;
 	}
 
 	/* Prepare to cast to short by eliminating out of range values */
@@ -1849,7 +1831,7 @@ static ssize_t alarms_store(struct device *device,
 		dev_info(device,
 			"%s: error reading from the slave device %d\n",
 			__func__, ret);
-		goto free_m;
+		return size;
 	}
 
 	/* Write data in the device RAM */
@@ -1857,7 +1839,7 @@ static ssize_t alarms_store(struct device *device,
 		dev_info(device,
 			"%s: Device not supported by the driver %d\n",
 			__func__, -ENODEV);
-		goto free_m;
+		return size;
 	}
 
 	ret = SLAVE_SPECIFIC_FUNC(sl)->write_data(sl, new_config_register);
@@ -1866,10 +1848,6 @@ static ssize_t alarms_store(struct device *device,
 			"%s: error writing to the slave device %d\n",
 			__func__, ret);
 
-free_m:
-	/* free allocated memory */
-	kfree(orig);
-
 	return size;
 }
 
-- 
2.51.0


