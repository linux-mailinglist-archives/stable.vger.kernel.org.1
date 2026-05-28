Return-Path: <stable+bounces-255263-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMO9FsSfGGpvlggAu9opvQ
	(envelope-from <stable+bounces-255263-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:04:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D8D5F7C25
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D926A3024968
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB686409630;
	Thu, 28 May 2026 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dFE5ZAFJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B41409604;
	Thu, 28 May 2026 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998418; cv=none; b=OOP8R4lRCZSdlAg6AJj5ihO5JepeXuf5AC1HIr6JP35+/ZCd8+QMEZBIrUxna+8162CVIUfWxCdf+cDOhdRR3PERAJFMD+IaffbHdVBr/Znu63N7P38U7GVermpiW44t6/BMisIgWm5VWuGJ2mlVViuUyuTR+jOVkNEPUgBE0yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998418; c=relaxed/simple;
	bh=zJ59FAQzEe+COJT2+M8S4Ok7MoTf+P4m7SD3Gm81CWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSz5WVBtqtmAXmnz+L88+RRFIwgbjm7n7Ngqzak5QTkD+qvZObm3vyPTx39Pi5gZ+n8h5lFa9huyGEvAu/rtHbvpwnItqzfMW4faHbfUUg4eLKDbh2mfAt1/wQF7zpZed3YVw4YC8XkSJjH1kozjOw9Fc2KpqlollQFPZrYewqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dFE5ZAFJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CD21F000E9;
	Thu, 28 May 2026 20:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998417;
	bh=5STOWqEMjhotWgLmJRFoOSTPWF2M/R5eRepaxPEKPvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dFE5ZAFJgG/w6gwqiWBUXTROr8RHe+dP2feeJ1mSCNViKugAsluontlWVnJR4jSFS
	 ROezVHK+UEudL6yjBRsR+73fe0F8W+V3/9QNdF+JJdZXpPBXL1rmzhpUFx/YQD1Lr+
	 n5+WcC0pl74tXSvHp93MR6M+ElCvldwBG6PDMZIc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 7.0 167/461] hwmon: (pmbus/adm1266) include PEC byte in pmbus_block_xfer read buffer
Date: Thu, 28 May 2026 21:44:56 +0200
Message-ID: <20260528194651.889468828@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255263-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nexthop.ai:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,roeck-us.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 81D8D5F7C25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

commit 487566cb1ccdf3756fdd7bf8d875e612ff3169bb upstream.

adm1266_pmbus_block_xfer() sets up the read transaction with

	.buf = data->read_buf,
	.len = ADM1266_PMBUS_BLOCK_MAX + 2,

but read_buf in struct adm1266_data is declared as

	u8 read_buf[ADM1266_PMBUS_BLOCK_MAX + 1];

For a max-length block response (length byte = 255 + up to 1 PEC
byte), the i2c controller is told to write 257 bytes into a 256-byte
buffer, putting one byte past the end of read_buf.  The same response
also makes the subsequent PEC compare

	if (crc != msgs[1].buf[msgs[1].buf[0] + 1])

read a byte beyond the array.

Bump the read_buf declaration to ADM1266_PMBUS_BLOCK_MAX + 2 so the
buffer can hold the length byte, up to 255 payload bytes, and the PEC
byte the i2c_msg length already accounts for.

Fixes: 407dc802a9c0 ("hwmon: (pmbus/adm1266) Add Block process call")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Link: https://lore.kernel.org/r/20260515-adm1266-fixes-v1-4-1c1ea1349cfe@nexthop.ai
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/adm1266.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -61,7 +61,7 @@ struct adm1266_data {
 	u8 *dev_mem;
 	struct mutex buf_mutex;
 	u8 write_buf[ADM1266_PMBUS_BLOCK_MAX + 1] ____cacheline_aligned;
-	u8 read_buf[ADM1266_PMBUS_BLOCK_MAX + 1] ____cacheline_aligned;
+	u8 read_buf[ADM1266_PMBUS_BLOCK_MAX + 2] ____cacheline_aligned;
 };
 
 static const struct nvmem_cell_info adm1266_nvmem_cells[] = {



