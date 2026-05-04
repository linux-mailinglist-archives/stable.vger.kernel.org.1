Return-Path: <stable+bounces-243228-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBmlKgmp+GmdxgIAu9opvQ
	(envelope-from <stable+bounces-243228-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:11:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAE74BEB74
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AAC33022F9F
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD963DE42E;
	Mon,  4 May 2026 14:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yqgOtWvs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120A03DE42C;
	Mon,  4 May 2026 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903347; cv=none; b=hlFKpGje3NU+EKkxxsLnC/sxZ/IRVcwTQUhmqA8TT3xq6hL6Qe15aVBCy02FYFjIUK9TdjlRqKJLi4uGMcVb5B+UHXez5t7xOlnWEDKNOx2zmwGPKA1DDKT8WhJx7Kpr0Y2KQtPLqk2m2b4WwIEhzoVaQ3hlYAFGipEJF6upvNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903347; c=relaxed/simple;
	bh=BABEowZs8OErAz7yrdvL3UGaKoysSlVuxlXLvbjXGsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewNTMnXp1cYvACYzA6vdpyab2DbEXjyNcRvkbXzXjlxgb7MadcAdPCszGbJQ6Gi8rf7mTvWNXlLc/ZifLMZp65GNWwA2F2s353cEKx0Wc9rxpdUoYo71ojy4XOq69h+w6mwJ0hnfdJkoTXPsjAi7RneL6Ie3XrDJIdZj8/2vbrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yqgOtWvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A9BC2BCB8;
	Mon,  4 May 2026 14:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903346;
	bh=BABEowZs8OErAz7yrdvL3UGaKoysSlVuxlXLvbjXGsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yqgOtWvs09SVl05CY07ERIih0yORJr5cICicHVuS38eqLjB8oPF1TGmHN/r7QIHfP
	 EkeQIJ3dmqCBiJgePOJzZtnK7s/mJf2ebZ8rdot3n/P8nxneqQG4YOvdpGtgtEhx7H
	 /As+QVPLwY+kwBxZ8xONFUATwMY0d25WcxPoHh2g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sanman Pradhan <psanman@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 7.0 171/307] hwmon: (pt5161l) Fix bugs in pt5161l_read_block_data()
Date: Mon,  4 May 2026 15:50:56 +0200
Message-ID: <20260504135149.298127249@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 2CAE74BEB74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243228-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,juniper.net:email,roeck-us.net:email]

7.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -121,7 +121,7 @@ static int pt5161l_read_block_data(struc
 	int ret, tries;
 	u8 remain_len = len;
 	u8 curr_len;
-	u8 wbuf[16], rbuf[24];
+	u8 wbuf[16], rbuf[I2C_SMBUS_BLOCK_MAX];
 	u8 cmd = 0x08; /* [7]:pec_en, [4:2]:func, [1]:start, [0]:end */
 	u8 config = 0x00; /* [6]:cfg_type, [4:1]:burst_len, [0]:address bit16 */
 
@@ -151,7 +151,7 @@ static int pt5161l_read_block_data(struc
 				break;
 		}
 		if (tries >= 3)
-			return ret;
+			return ret < 0 ? ret : -EIO;
 
 		memcpy(val, rbuf, curr_len);
 		val += curr_len;



