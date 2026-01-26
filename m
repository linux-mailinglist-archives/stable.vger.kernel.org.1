Return-Path: <stable+bounces-211563-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJDcBa9kd2lefAEAu9opvQ
	(envelope-from <stable+bounces-211563-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 13:57:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6662888862
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 13:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AC2D3019B97
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 12:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30E0336ECB;
	Mon, 26 Jan 2026 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ei8hYOWz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F9730EF63
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769432235; cv=none; b=j6rn7VaZ1yefi0CteFcVcJHAm57a1NiZ8o1JrrnSBPMpCDiOEsspyj4OZBNuinEWZw94duCtfDY+dv8fWtYcuc/LY4hmlWHbL7bof0nR1GHwcHbzfj6ASBGwT6yQ7lhWWNueL3+iPDsINn8LGQTtMc4aeTnJ1SUcFZIPpkOgFdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769432235; c=relaxed/simple;
	bh=QaXo9FXcRNX2WAKYTB+8CInENmzYhzFqwtksJ9vNuT4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aU0Gyu8zKRiEAQV6yF9mwwlIByCRGDtJXOS+HyAv3/8OA8t2Keh6iQnBBdovYP2jWsJtL5Y7OLaGn8IDcs58O7er5JTHimzHVqali9aqa1vDQPFdHeU/Wf8fweUNaHXdR60Qm200cdQ7S+WUmmWi1wvrfZ9rIa4Y9KSX6KmEX7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ei8hYOWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E43C19425;
	Mon, 26 Jan 2026 12:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769432235;
	bh=QaXo9FXcRNX2WAKYTB+8CInENmzYhzFqwtksJ9vNuT4=;
	h=Subject:To:Cc:From:Date:From;
	b=Ei8hYOWzV4P0j0vCqid/eppvTAB5pSrX0cYGBywN5bv2G5cuidXQe+ai3A/R4IoiV
	 UqdxxoWm1Q2fhHo6FjPliiBWHEHLDOTVrhAGl6R6xRKkf2lqguXcughllsi6oFo9V3
	 OhtfItL3ON8e0prIztEhX3bkQY5i3u7prcVcWTyw=
Subject: FAILED: patch "[PATCH] w1: therm: Fix off-by-one buffer overflow in alarms_store" failed to apply to 5.10-stable tree
To: thorsten.blum@linux.dev,krzk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Jan 2026 13:57:03 +0100
Message-ID: <2026012603-washday-underfoot-7004@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211563-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linux.dev:email,gregkh:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 6662888862
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 761fcf46a1bd797bd32d23f3ea0141ffd437668a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012603-washday-underfoot-7004@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 761fcf46a1bd797bd32d23f3ea0141ffd437668a Mon Sep 17 00:00:00 2001
From: Thorsten Blum <thorsten.blum@linux.dev>
Date: Tue, 16 Dec 2025 15:50:03 +0100
Subject: [PATCH] w1: therm: Fix off-by-one buffer overflow in alarms_store

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

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 9ccedb3264fb..832e3da94b20 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -1836,53 +1836,35 @@ static ssize_t alarms_store(struct device *device,
 	struct w1_slave *sl = dev_to_w1_slave(device);
 	struct therm_info info;
 	u8 new_config_register[3];	/* array of data to be written */
-	int temp, ret;
-	char *token = NULL;
+	long long temp;
+	int ret = 0;
 	s8 tl, th;	/* 1 byte per value + temp ring order */
-	char *p_args, *orig;
+	const char *p = buf;
+	char *endp;
 
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
@@ -1905,7 +1887,7 @@ static ssize_t alarms_store(struct device *device,
 		dev_info(device,
 			"%s: error reading from the slave device %d\n",
 			__func__, ret);
-		goto free_m;
+		return size;
 	}
 
 	/* Write data in the device RAM */
@@ -1913,7 +1895,7 @@ static ssize_t alarms_store(struct device *device,
 		dev_info(device,
 			"%s: Device not supported by the driver %d\n",
 			__func__, -ENODEV);
-		goto free_m;
+		return size;
 	}
 
 	ret = SLAVE_SPECIFIC_FUNC(sl)->write_data(sl, new_config_register);
@@ -1922,10 +1904,6 @@ static ssize_t alarms_store(struct device *device,
 			"%s: error writing to the slave device %d\n",
 			__func__, ret);
 
-free_m:
-	/* free allocated memory */
-	kfree(orig);
-
 	return size;
 }
 


