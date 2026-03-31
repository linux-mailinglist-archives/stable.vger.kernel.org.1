Return-Path: <stable+bounces-232467-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLoCAesAzGk8NQYAu9opvQ
	(envelope-from <stable+bounces-232467-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:14:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8CC36E42C
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7267530513F7
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC063016EE;
	Tue, 31 Mar 2026 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KpWwsF/E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419C02E1C7C;
	Tue, 31 Mar 2026 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976823; cv=none; b=naiaPtd7uQ3oCJzQ0LgGac6Gvgxt7iG0z5lQYCYdFi5VRw019poqVVBDNnAzzUIDO4s3HVAXpgSgvQofWNSFUGhKjsaWoX7VPCQrzedQbE0RDwshkhG69blhaFMKYzykGQoWCpzvFTAOc6whfae0JQGwB3Eyck53kQ7cvL4uTEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976823; c=relaxed/simple;
	bh=LJiS5zKGhd2mEiK3+Vam+nr9v/oGTuN9alrOIlM1n7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AeBa7Xmqcl7BFfWacxzsvONeHbU/u7GLv8moIVtq0SojdZaQdEFBCurfV78iHing5guEL2zvA289gpsOz0BEfe8vlhYhA+V0uaZ/RJSuGr9Yi3AhbC3oLvh2oymCJp4CfW47SdpWwVBEJrBm3Zh0jPmQqR1SbQVVAeSaMMcE8v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KpWwsF/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA963C19423;
	Tue, 31 Mar 2026 17:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976823;
	bh=LJiS5zKGhd2mEiK3+Vam+nr9v/oGTuN9alrOIlM1n7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KpWwsF/E6/USuksewql4qIec0qDjkJ07DuW8zBO95HZkImGG3V8EhGW0I5xH+rwNz
	 o9qkqgBOY+ODHl3FXVJ1G8pmIT5bkQzpOuB9q53t72IQzk+KlBJq/q5WZbJ+FbvTv1
	 eh23zbS3cFRRy9zP6I89P/jIhotwe/7FAKDuTX+M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sanman Pradhan <psanman@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.18 199/309] hwmon: (pmbus/ina233) Fix error handling and sign extension in shunt voltage read
Date: Tue, 31 Mar 2026 18:21:42 +0200
Message-ID: <20260331161800.778741739@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232467-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,juniper.net:email,roeck-us.net:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA8CC36E42C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sanman Pradhan <psanman@juniper.net>

commit f7e775c4694782844c66da5316fed82881835cf8 upstream.

ina233_read_word_data() reads MFR_READ_VSHUNT via pmbus_read_word_data()
but has two issues:

1. The return value is not checked for errors before being used in
   arithmetic. A negative error code from a failed I2C transaction is
   passed directly to DIV_ROUND_CLOSEST(), producing garbage data.

2. MFR_READ_VSHUNT is a 16-bit two's complement value. Negative shunt
   voltages (values with bit 15 set) are treated as large positive
   values since pmbus_read_word_data() returns them zero-extended in an
   int. This leads to incorrect scaling in the VIN coefficient
   conversion.

Fix both issues by adding an error check, casting to s16 for proper
sign extension, and clamping the result to a valid non-negative range.
The clamp is necessary because read_word_data callbacks must return
non-negative values on success (negative values indicate errors to the
pmbus core).

Fixes: b64b6cb163f16 ("hwmon: Add driver for TI INA233 Current and Power Monitor")
Cc: stable@vger.kernel.org
Signed-off-by: Sanman Pradhan <psanman@juniper.net>
Link: https://lore.kernel.org/r/20260319173055.125271-2-sanman.pradhan@hpe.com
[groeck: Fixed clamp to avoid losing the sign bit]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/ina233.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/ina233.c b/drivers/hwmon/pmbus/ina233.c
index 2d8b5a5347ed..7aebd854763a 100644
--- a/drivers/hwmon/pmbus/ina233.c
+++ b/drivers/hwmon/pmbus/ina233.c
@@ -72,7 +72,8 @@ static int ina233_read_word_data(struct i2c_client *client, int page,
 
 		/* Adjust returned value to match VIN coefficients */
 		/* VIN: 1.25 mV VSHUNT: 2.5 uV LSB */
-		ret = DIV_ROUND_CLOSEST(ret * 25, 12500);
+		ret = clamp_val(DIV_ROUND_CLOSEST((s16)ret * 25, 12500),
+				S16_MIN, S16_MAX) & 0xffff;
 		break;
 	default:
 		ret = -ENODATA;
-- 
2.53.0




