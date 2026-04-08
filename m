Return-Path: <stable+bounces-235096-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMQ7OBCl1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-235096-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:57:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0C93C20D5
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD59E3002924
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806AA348453;
	Wed,  8 Apr 2026 18:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kEAcDFjn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4413D25A321;
	Wed,  8 Apr 2026 18:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674559; cv=none; b=pc/1hXSqR9EUKFilfylGtNL/9iZwir/LNUYzcWyugN4AXRxbxjZ01SO8b0/K13MzLJGACY9c/P9jbMc9SqgBXackDJbWnsabGoaDJs1oc95Pbgxi5KF5OSA/LAVp9RPfa36lz3DB5kE3wVd28ccuMLp0LStgnA0sjJ0JG78AfAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674559; c=relaxed/simple;
	bh=LUqhajeCNxMlisMAChXRBSVixPR0mmKAc6S0oDUD//c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nV4pSrv9M3hq3XQuS8PSh6kGJ7l8hnHN9ukzAJThugNVuUzRObw2G2bt/l6G8vQ8K+8CxqeGVxir1cdpVBcmxhQ7yd2YwlpM3LGN9AH5EqibAq+unB/51RzC+VTFdVFup01fBp2qYNloxwExU+arhRhlrw06FopLEdc/ZCMssbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kEAcDFjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE70FC19421;
	Wed,  8 Apr 2026 18:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674559;
	bh=LUqhajeCNxMlisMAChXRBSVixPR0mmKAc6S0oDUD//c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kEAcDFjnoaAv0HSsjfUaGeqKej/NzSx77aS2WTJ8RuPaTgXSO0kOfblOWNNE3mdqA
	 jk4uZLOhCQCr1pk93y+D/QcH5phf52ngV/OnBH2vQW/T1UZxasVFD7io/02S4msfrw
	 vIZ4vaVkaSvvlPefX6TXWAoBzL0NShFbG/uNeAX8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sanman Pradhan <psanman@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 137/311] hwmon: (tps53679) Fix array access with zero-length block read
Date: Wed,  8 Apr 2026 20:02:17 +0200
Message-ID: <20260408175944.529613368@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235096-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,roeck-us.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,juniper.net:email]
X-Rspamd-Queue-Id: 2F0C93C20D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sanman Pradhan <psanman@juniper.net>

[ Upstream commit 0e211f6aaa6a00fd0ee0c1eea5498f168c6725e6 ]

i2c_smbus_read_block_data() can return 0, indicating a zero-length
read. When this happens, tps53679_identify_chip() accesses buf[ret - 1]
which is buf[-1], reading one byte before the buffer on the stack.

Fix by changing the check from "ret < 0" to "ret <= 0", treating a
zero-length read as an error (-EIO), which prevents the out-of-bounds
array access.

Also fix a typo in the adjacent comment: "if present" instead of
duplicate "if".

Fixes: 75ca1e5875fe ("hwmon: (pmbus/tps53679) Add support for TPS53685")
Signed-off-by: Sanman Pradhan <psanman@juniper.net>
Link: https://lore.kernel.org/r/20260329170925.34581-2-sanman.pradhan@hpe.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pmbus/tps53679.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/pmbus/tps53679.c b/drivers/hwmon/pmbus/tps53679.c
index ca2bfa25eb04c..3bca543817a60 100644
--- a/drivers/hwmon/pmbus/tps53679.c
+++ b/drivers/hwmon/pmbus/tps53679.c
@@ -103,10 +103,10 @@ static int tps53679_identify_chip(struct i2c_client *client,
 	}
 
 	ret = i2c_smbus_read_block_data(client, PMBUS_IC_DEVICE_ID, buf);
-	if (ret < 0)
-		return ret;
+	if (ret <= 0)
+		return ret < 0 ? ret : -EIO;
 
-	/* Adjust length if null terminator if present */
+	/* Adjust length if null terminator is present */
 	buf_len = (buf[ret - 1] != '\x00' ? ret : ret - 1);
 
 	id_len = strlen(id);
-- 
2.53.0




