Return-Path: <stable+bounces-243745-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGNfLS6u+GlIxwIAu9opvQ
	(envelope-from <stable+bounces-243745-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:33:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 635D04BFAA1
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D20E3026E9F
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4473E0230;
	Mon,  4 May 2026 14:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hBTcJmhW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6733E3D9A;
	Mon,  4 May 2026 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904669; cv=none; b=D5+I7jOIXM/64DIfGfvRZlCNZpTEX8eYsFiRsgUM+e9K2a/N2B/w6lYYiEBfoiFtdeC8TSWHS7cDkuY56AX4P+luSl8vO5eU9WC5hj7WEWrB+2vSMRCU/l/8/fIe6+vz627xzyoLvftRyX6pVe2GYfRGoHrrhHpLg3Xpk1e5PGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904669; c=relaxed/simple;
	bh=8urlzIc7K1dslCUOdz2xASqLXRqdTPoS//8VDdjHd74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dORWoEOR0I39v24tfWWdtbd/9ZNgpQtwhuzBleCVN7EQUkp8nUHhHlEytkb22hXB19W1yUFxxk1s1atuqZQ8443BI204hHgklCLTBI0U3or/wLQL+r4zZhw/kvDpSxHdcBDKfGOuL+FHooK1o7ZbiVfD3caxpCrFHgiMN6kPC1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hBTcJmhW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46351C2BCF6;
	Mon,  4 May 2026 14:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904669;
	bh=8urlzIc7K1dslCUOdz2xASqLXRqdTPoS//8VDdjHd74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hBTcJmhWSTrMAqC6Q4PHxUJlylE+SNAreRu+1Xs1s1QtIFgRc6I4k9tqXS3YZUUQH
	 WGptwrXsKH7dgoBld40rVFmPOBbdthgLkewgvWUKGl3YA48I+susKodf4qz9dDQd1A
	 FCK2NyQ30eYhs5nNcrrxQkWB3w0Td6oJCEaC+5Qo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sanman Pradhan <psanman@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.12 101/215] hwmon: (pt5161l) Fix bugs in pt5161l_read_block_data()
Date: Mon,  4 May 2026 15:52:00 +0200
Message-ID: <20260504135133.843219597@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135130.169210693@linuxfoundation.org>
References: <20260504135130.169210693@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 635D04BFAA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-243745-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,roeck-us.net:email,juniper.net:email]

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sanman Pradhan <psanman@juniper.net>

commit 24c73e93d6a756e1b8626bb259d2e07c5b89b370 upstream.

Fix two bugs in pt5161l_read_block_data():

1. Buffer overrun: The local buffer rbuf is declared as u8 rbuf[24],
   but i2c_smbus_read_block_data() can return up to
   I2C_SMBUS_BLOCK_MAX (32) bytes. The i2c-core copies the data into
   the caller's buffer before the return value can be checked, so
   the post-read length validation does not prevent a stack overrun
   if a device returns more than 24 bytes. Resize the buffer to
   I2C_SMBUS_BLOCK_MAX.

2. Unexpected positive return on length mismatch: When all three
   retries are exhausted because the device returns data with an
   unexpected length, i2c_smbus_read_block_data() returns a positive
   byte count. The function returns this directly, and callers treat
   any non-negative return as success, processing stale or incomplete
   buffer contents. Return -EIO when retries are exhausted with a
   positive return value, preserving the negative error code on I2C
   failure.

Fixes: 1b2ca93cd0592 ("hwmon: Add driver for Astera Labs PT5161L retimer")
Cc: stable@vger.kernel.org
Signed-off-by: Sanman Pradhan <psanman@juniper.net>
Link: https://lore.kernel.org/r/20260410002549.424162-1-sanman.pradhan@hpe.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pt5161l.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/hwmon/pt5161l.c
+++ b/drivers/hwmon/pt5161l.c
@@ -124,7 +124,7 @@ static int pt5161l_read_block_data(struc
 	int ret, tries;
 	u8 remain_len = len;
 	u8 curr_len;
-	u8 wbuf[16], rbuf[24];
+	u8 wbuf[16], rbuf[I2C_SMBUS_BLOCK_MAX];
 	u8 cmd = 0x08; /* [7]:pec_en, [4:2]:func, [1]:start, [0]:end */
 	u8 config = 0x00; /* [6]:cfg_type, [4:1]:burst_len, [0]:address bit16 */
 
@@ -154,7 +154,7 @@ static int pt5161l_read_block_data(struc
 				break;
 		}
 		if (tries >= 3)
-			return ret;
+			return ret < 0 ? ret : -EIO;
 
 		memcpy(val, rbuf, curr_len);
 		val += curr_len;



