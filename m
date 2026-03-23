Return-Path: <stable+bounces-229244-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJVDCeFdwWlZSgQAu9opvQ
	(envelope-from <stable+bounces-229244-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:36:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 902A82F68A7
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E81763435931
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA8B2877DA;
	Mon, 23 Mar 2026 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0R8wSl0U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C553B0AD1;
	Mon, 23 Mar 2026 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278512; cv=none; b=VAii7QQ3JBftQXwFEb9tS9wiJ0Rvg74jKO0YWKGNmfZuE3qD2GNQqHjDV6hstcYiRrU7D+izLxve4IMx7x3x5GYNHQ0w/sZyyyAEAVSongugs2nBc2XAPHK7i9cKondxO2DG5lTx7Q7JBtLcxAAfDwzGGaEqzvqC8jo0jyIL+Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278512; c=relaxed/simple;
	bh=g/DH+GmLrmgEEhmhYqJtS8TmXDJ48TaCUAZGH2LGyls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ofgb0Kx2B4qjpkYcF5BaWyfrIk+dEsEdx+t86f8mRS8b7CGK6h+2Ztx2DMz7Unp0iN3Er5QOZdcqgPn5/R8jQoA7GtK2hV4bAMqj8kNArSHLPfZK/dtYBBfnSJSrpmMUaS33kQtYBYdVTYBl0HDsxqQ50KYtsDFU1n38DaEaA68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0R8wSl0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BA2C4CEF7;
	Mon, 23 Mar 2026 15:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278512;
	bh=g/DH+GmLrmgEEhmhYqJtS8TmXDJ48TaCUAZGH2LGyls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0R8wSl0Uk+/J4sRSuEmRrEykWwfgcmpmdHo7++kTszSFqpWu4S2R5/NF5NqDEbLbO
	 E2TIO7Z3zLzXnmbkAT3mJMxdgm+eOHb2mU0TybRH7HCHyknPH/bVJxjjwsnF+Fn58W
	 jlTPdtcGYk72tyy9NIex4YpfK9P0gGr0wXGhan64=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sanman Pradhan <psanman@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.6 324/567] hwmon: (pmbus/q54sj108a2) fix stack overflow in debugfs read
Date: Mon, 23 Mar 2026 14:44:04 +0100
Message-ID: <20260323134541.849641659@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229244-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 902A82F68A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sanman Pradhan <psanman@juniper.net>

commit 25dd70a03b1f5f3aa71e1a5091ecd9cd2a13ee43 upstream.

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
Link: https://lore.kernel.org/r/20260304235116.1045-1-sanman.p211993@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/q54sj108a2.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

--- a/drivers/hwmon/pmbus/q54sj108a2.c
+++ b/drivers/hwmon/pmbus/q54sj108a2.c
@@ -78,7 +78,8 @@ static ssize_t q54sj108a2_debugfs_read(s
 	int idx = *idxp;
 	struct q54sj108a2_data *psu = to_psu(idxp, idx);
 	char data[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
-	char data_char[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
+	char data_char[I2C_SMBUS_BLOCK_MAX * 2 + 2] = { 0 };
+	char *out = data;
 	char *res;
 
 	switch (idx) {
@@ -149,27 +150,27 @@ static ssize_t q54sj108a2_debugfs_read(s
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



