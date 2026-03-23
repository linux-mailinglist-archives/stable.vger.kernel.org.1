Return-Path: <stable+bounces-228387-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEXeAeNLwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228387-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:19:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D3F2F42B9
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36BC83125424
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4E83B27D9;
	Mon, 23 Mar 2026 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W4Wfuq1l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1B3C145;
	Mon, 23 Mar 2026 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274976; cv=none; b=EMxfMy7Mg3tN60+4x5Fv8IpsPtREhfuZadAJbvlwRMoaeOGHv48hdIq0I50BHLCQCC2z/1apA4vGTIL5p+s1D+iQ144/5NroW5J5vUOClXPiGWa/peJ3L5ZUz/w8z44Zyzkey8ic7cdtm+HRjrGulBPE4IPnIqWDyMJ6D9oqM5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274976; c=relaxed/simple;
	bh=6BcDBpZ+6je4hqORrMrey82icHS0YHRqka8KNPUo0xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mW8hGZyj83c9NT7pTtgF26Txi5vL/qStRawCJslkAYSVO1M+YqfAGZ8bCk7AQfjbydYxRzyrp7+pnd9FI04EwaryyDFsYxy0LnMtZUDHDI0vtLckHQDjgOZPuJrHGkVW2qmWymAbTFfc9YxB/M76V4B8ZZgJcgcZCSXFNS/8WzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W4Wfuq1l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF9FC4CEF7;
	Mon, 23 Mar 2026 14:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274976;
	bh=6BcDBpZ+6je4hqORrMrey82icHS0YHRqka8KNPUo0xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W4Wfuq1lLTMze+jcHavABRjNF19HZ5EJDl1nXv1Yx3CpzPxOjhYnb6QK/S0mclHBr
	 FIPMUze3sb/+5qbICgW+7HWBnVMvSmGZECiDx62n8BhZFOXyFBPOnSi4sD3t2b4lCq
	 /RDq8GyYP0zsg34EkIRaHP8szaGCo8uz3jyFpZGc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sanman Pradhan <psanman@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.18 180/212] hwmon: (pmbus/ina233) Add error check for pmbus_read_word_data() return value
Date: Mon, 23 Mar 2026 14:46:41 +0100
Message-ID: <20260323134509.441774434@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228387-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 97D3F2F42B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sanman Pradhan <psanman@juniper.net>

commit 32f59301b9898c0ab5e72908556d553e2d481945 upstream.

ina233_read_word_data() uses the return value of pmbus_read_word_data()
directly in a DIV_ROUND_CLOSEST() computation without first checking for
errors. If the underlying I2C transaction fails, a negative error code is
used in the arithmetic, producing a garbage sensor value instead of
propagating the error.

Add the missing error check before using the return value.

Fixes: b64b6cb163f16 ("hwmon: Add driver for TI INA233 Current and Power Monitor")
Cc: stable@vger.kernel.org
Signed-off-by: Sanman Pradhan <psanman@juniper.net>
Link: https://lore.kernel.org/r/20260317174553.385567-1-sanman.pradhan@hpe.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/ina233.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/pmbus/ina233.c b/drivers/hwmon/pmbus/ina233.c
index dde1e1678394..2d8b5a5347ed 100644
--- a/drivers/hwmon/pmbus/ina233.c
+++ b/drivers/hwmon/pmbus/ina233.c
@@ -67,6 +67,8 @@ static int ina233_read_word_data(struct i2c_client *client, int page,
 	switch (reg) {
 	case PMBUS_VIRT_READ_VMON:
 		ret = pmbus_read_word_data(client, 0, 0xff, MFR_READ_VSHUNT);
+		if (ret < 0)
+			return ret;
 
 		/* Adjust returned value to match VIN coefficients */
 		/* VIN: 1.25 mV VSHUNT: 2.5 uV LSB */
-- 
2.53.0




