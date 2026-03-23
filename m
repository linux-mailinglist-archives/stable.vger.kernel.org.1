Return-Path: <stable+bounces-228618-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wK53HoZPwWmhSAQAu9opvQ
	(envelope-from <stable+bounces-228618-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:34:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AC82F4C6A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B33E3065CD5
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0293AB295;
	Mon, 23 Mar 2026 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XfvCAIjj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F73B38F630;
	Mon, 23 Mar 2026 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275619; cv=none; b=s35GehzqjZZFByrRfofNP8M0ONsCIbFnFxOfY4u1Lu7AMbP0iRobH3MnZQ276xdoxrwgL1ONAnW6AbPWt862zQBNhifFSk77XV5f9Xnvj3AgsGNUxNimYRFxIzO5W0hbHuJf9C6kU51Hki0jI8ei2QrQ7LI+mCmkWoRuArVO1d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275619; c=relaxed/simple;
	bh=/BpJzHyKYPyXcZuzC5aIRtoXdDpRzyNYyuvbpNcq7u0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aeqi7bOKgt10I/P+TcWRlDhOWVNjMUoRCjX9GMuXKArJOz9nWYQnsmLGAm4xln+/SAoSJk1tVxWSqkjVKGkNkdHu1fBgyOMGqCSimKGOTQonAr+3sfRJ/XiMnTa6BKb6HxgzgZp61DpdPYE1Q6CQ60JY+5v0Vpw+qbw6TdhIwdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XfvCAIjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FE5C4CEF7;
	Mon, 23 Mar 2026 14:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275619;
	bh=/BpJzHyKYPyXcZuzC5aIRtoXdDpRzyNYyuvbpNcq7u0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XfvCAIjjwvmvmMtJxNsuOQCWT8XtrMYCA5DnbHD+Qu6O9QjuMEt0SIe/BfzSafQSK
	 +QANnzxTF8zqhXDH1uKnMD0ur/frBGNMHekb91J5N/fb8Ptu4pVYDCbpQ9G9D/wqlw
	 kj52fPuGwUeTdAROoYSp8jWahFqL8LiAD48pyY30=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sanman Pradhan <psanman@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.12 163/460] hwmon: (pmbus/q54sj108a2) fix stack overflow in debugfs read
Date: Mon, 23 Mar 2026 14:42:39 +0100
Message-ID: <20260323134530.559856634@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228618-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 46AC82F4C6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

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



