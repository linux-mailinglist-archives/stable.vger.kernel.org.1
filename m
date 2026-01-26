Return-Path: <stable+bounces-211640-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEcRA26Nd2m9hgEAu9opvQ
	(envelope-from <stable+bounces-211640-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 16:51:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B63A98A52D
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 16:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0804B3017BEE
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 15:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CA5340A49;
	Mon, 26 Jan 2026 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ft0o7BFE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E9233F394
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769442661; cv=none; b=RiyOKxsdY6NxVpL+krasr6SiSp3coguk21sCM+dhswb9a7a3Fl+SPN6f4QrqyVUKaoWt3c/3QSvTUiJTlEM3tqNhDd0HkxKuU5fJT1R4HEnCMUUBWWvPNKK7Z8XJzKAxFLq0QACMy30j8+LBYqhdWX2KaV0eys6nooR+FiVAc+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769442661; c=relaxed/simple;
	bh=PXic9HXGeSBpVBeak2yVLuDq51h4p9iIdeA2d6IV3Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMBeqOhgsRGsTvJu0ifPgkvrAsm1/GRXj3YHUa+9WdqW2IoKN4h+PxZW/4c7OCLHMUkg0sq3fI+EqhwZ0wn6X2LVINT/SoRGxucL9RzTBHz3tFSovrrit8iCN0xoz6OL1C2UYyFnjRX7UvODL47XCh2wbOXKfCas9mVPIe8mMuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ft0o7BFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586D0C19425;
	Mon, 26 Jan 2026 15:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769442660;
	bh=PXic9HXGeSBpVBeak2yVLuDq51h4p9iIdeA2d6IV3Ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ft0o7BFEkG6UvMGbUalKC7Dak3/DovThr18LI/t+IU2qN55sO9+dwNB36bDB22cwl
	 QpHDYTe+qki64w/LfffgiBj/0X+zTjkmrpJpPkC8ul9EEnPaRDa4Y8kdEsrGMhUPGg
	 9W0FwWrC0oKrf371oFwdOtU7pXehADGTBLU26yxYGnxSUBUV5TYSN3oBoCHL1j4Nc9
	 r23Z/5U5ea1AuJoRR+0YJiroaH8KAwXCq0slBIBP3bZ9xO+Y0j8RTT8feWQH1MtQnL
	 JQ7TYiJ+0wLem9TYDtTuNHcqFGzGwvS/eeZ9z63z9WSdPGm9jqhR/V0GKzGTygprA5
	 McVwO1fBZptyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] w1: therm: Fix off-by-one buffer overflow in alarms_store
Date: Mon, 26 Jan 2026 10:50:57 -0500
Message-ID: <20260126155057.3322542-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126155057.3322542-1-sashal@kernel.org>
References: <2026012603-wasting-popcorn-9abe@gregkh>
 <20260126155057.3322542-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211640-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[msgid.link:query timed out];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: B63A98A52D
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


