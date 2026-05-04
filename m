Return-Path: <stable+bounces-243482-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKKANzCq+GnHxgIAu9opvQ
	(envelope-from <stable+bounces-243482-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:16:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7791E4BEF04
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08DC830309AF
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104873A7F4C;
	Mon,  4 May 2026 14:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mn28rO+Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60683BE630;
	Mon,  4 May 2026 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903997; cv=none; b=gu6kLuZiiDUPWtq3AkLnReQJpqGcb34Z4JIYC7rkldbX9Sr6YGFUQzO/7MCZ3U/9nBj1EV+CQncIXiw86cZoFdVSG1+V1B2Pw/2P5UfNpRKiO4yYQCDAKXQNfX3Ddwo5Fx8kImU1rVXTeb/BForaDd2AoYK+L07d263daoN8Tl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903997; c=relaxed/simple;
	bh=bi6vVC1aZCIIvm5aZdYszP0nEMFMRXiwSfuv7gjjdtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TsFIgXgkJ1liOMC8vuBB8tv6NPD4sCvybiAA8R8CL+SMIgRvr0Vvwnec7yUeZSOQy3vsUaIvR4MMLxBl87RcMCPFJaPHK7qsJkeocsOWVnels6DuCAeLGOLa4Fv4dXOapmIDdDRu//NBUWIFkFKoafz+Mo3tOa808fmxLvCwqm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mn28rO+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A96FC2BCFA;
	Mon,  4 May 2026 14:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903997;
	bh=bi6vVC1aZCIIvm5aZdYszP0nEMFMRXiwSfuv7gjjdtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mn28rO+Qx/bjjEml09Xs5scKXJnxQ5yc6lH/ol6erzWcVDnGM4j4adJb3G3h3fiB5
	 J/3k5ryFgLnE3pNRFgPK/QZVjY2qzwtnnCdoxe29lmtVqY4plwS7fQdYoDy8Jzpgng
	 fxq4CsC7bW/MYWq6P8WujVO7dw/AtnLq0SgItS8M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sanman Pradhan <psanman@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.18 143/275] hwmon: (pt5161l) Fix bugs in pt5161l_read_block_data()
Date: Mon,  4 May 2026 15:51:23 +0200
Message-ID: <20260504135148.213015111@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 7791E4BEF04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243482-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,juniper.net:email,roeck-us.net:email]

6.18-stable review patch.  If anyone has any objections, please let me know.

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



