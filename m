Return-Path: <stable+bounces-211645-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFmYA2qPd2m9hgEAu9opvQ
	(envelope-from <stable+bounces-211645-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 16:59:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC958A6EA
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 16:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22BCD301779F
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 15:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C536E341061;
	Mon, 26 Jan 2026 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJH+tbi3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A1826E6F4
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769443172; cv=none; b=WdFUTR70rSISHbepU7fmzW9Em9U0z4xHqaD+rJc2vRMt+KatottKdshF2udewWTIUW+Mq1gQfRNR97WTNoB8loTUgTg10PrCWmN9XxYU9jEHy5yxNI1Qs7pE8871H6XM5sG+WsxihSnmrNy067VbvSkoLWK1UuHMOjpgqNTeaEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769443172; c=relaxed/simple;
	bh=+1Y90Rj300NgAvzinOZyxDTjHQWWRQCXI+caTvlvyFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LkPBOaug8dfJrqUOzGwh/8A9rQLN66CTYkI//wX9u7miLcwgs85A9e9hwIalXuo7/s/RoMyj7uKGDUuvxJVTiTfOGkughpbS+VBXNajlA71OB6O+sCh6ClLztxxUVu6u0K+1YHooW1YtUwewkyh/UY0Gbe61acyM3DyjBFGMras=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJH+tbi3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC644C2BC86;
	Mon, 26 Jan 2026 15:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769443172;
	bh=+1Y90Rj300NgAvzinOZyxDTjHQWWRQCXI+caTvlvyFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vJH+tbi34XkFuXgHoLxuob1VBz7hXAcByIVu9cWvA/d9Bj76494Iglyo0Y/V959Pj
	 fLeJ26NMHF/MRjLvD2qIOwqApNrvsnVIC7mFDBiL22IenynhtZs3lA/ae4sThadBES
	 cAMqMYzG/3+wZKAFMN8RVmUiK8rChMtBeOA6C8rd9CrpXp614UFwjl2dEyl9hskNjk
	 fKycgJV3zRzUGxouiYWJeH2lorVqHf2VJnCkaRfRvoSVTQ3Ny24R2hUalxJgIS9bdR
	 CpC4/XXFE3d5D3BaYjv0H8KTq5bFZyoWqs3T/2cmHVSdYjqLC8CvduPMf32PARhPvj
	 nRQKxHjozvxYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] w1: therm: Fix off-by-one buffer overflow in alarms_store
Date: Mon, 26 Jan 2026 10:59:29 -0500
Message-ID: <20260126155929.3332297-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126155929.3332297-1-sashal@kernel.org>
References: <2026012603-washday-underfoot-7004@gregkh>
 <20260126155929.3332297-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211645-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 5CC958A6EA
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
index ad8276cc82f5b..8c97706cfc28c 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -1781,53 +1781,35 @@ static ssize_t alarms_store(struct device *device,
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
@@ -1850,7 +1832,7 @@ static ssize_t alarms_store(struct device *device,
 		dev_info(device,
 			"%s: error reading from the slave device %d\n",
 			__func__, ret);
-		goto free_m;
+		return size;
 	}
 
 	/* Write data in the device RAM */
@@ -1858,7 +1840,7 @@ static ssize_t alarms_store(struct device *device,
 		dev_info(device,
 			"%s: Device not supported by the driver %d\n",
 			__func__, -ENODEV);
-		goto free_m;
+		return size;
 	}
 
 	ret = SLAVE_SPECIFIC_FUNC(sl)->write_data(sl, new_config_register);
@@ -1867,10 +1849,6 @@ static ssize_t alarms_store(struct device *device,
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


