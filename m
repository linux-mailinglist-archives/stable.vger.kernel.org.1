Return-Path: <stable+bounces-248935-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Je0KEKbB2oD+wIAu9opvQ
	(envelope-from <stable+bounces-248935-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 00:16:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D93A558B1B
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 00:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D50553047057
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 22:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F9D3F5BE1;
	Fri, 15 May 2026 22:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="EFTofA3/"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96573F076E
	for <stable@vger.kernel.org>; Fri, 15 May 2026 22:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778883129; cv=none; b=J/pHbWjJkZ6QZmCNcSv+vDZuCWiTN5z3zWkqzs1WxtyAzVUb6EQeztjNZagxtcJTH9JfJEVf7xk479+2BBSf+cl3ieTyVudNwaOwnhIkDJ6xXI3xPOBy4CKXfpBsdjBRJdqEnfCxHTg1BzRrg6UQODcEu1yWCRrQLf0gGnujmdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778883129; c=relaxed/simple;
	bh=rP04PKwq1R/PP8JxrqExEG/Wa23i/3eww37NNCWqAhQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BGAsfBwcfaRMiL6TIIeLrV1azsMwL80qcG+nuLbQdgWBH4cYBGTuuMngtmc7tt0emuexg8aAqakm5Jz9zYbMDYM4+m1aTD8tnrGWXo+whzsxk2svHjSjGPsnf5RDFbIhF4L1HbyGuhfMDmBeZCov88MGoaVWWgW4FNbS29tQco0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=EFTofA3/; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30246cfd41aso1811407eec.1
        for <stable@vger.kernel.org>; Fri, 15 May 2026 15:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1778883127; x=1779487927; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7X1kg6LzQMAP+o8E3PxdhGDCIvH3ZXQrhfmA4xsA6sM=;
        b=EFTofA3/8HbrcNDNLfDf9H4iqTlnrAZ9z8NBXS83a28ScmhFadv6/YmPDiQE0eBT1h
         VgOd6bY0ved+4dVTd287jcmIk3wDODO/Q4gSr4XhvdRglb3TS6AOa8e7sa0IkvGR5Eka
         F8xGy1uvu9cDjCNssGa7IfEAIL+VvU+uqPNQOjgE/EjwHulLZQXVW9YyLCVNWyShZ0VT
         IxBuoo/jtMVyfjtOWah18s9BLL1BXkT5iYFRvbmxCMTFIR+Vz8/KBTIVfVP4xVz1jOQb
         K48abYssYY/7+/SdLfLQR+w60PBF1X2fwIPx/8Fd8/i0DwRFFiFcZMXpVKvnu22eXp7i
         Ywng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778883127; x=1779487927;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7X1kg6LzQMAP+o8E3PxdhGDCIvH3ZXQrhfmA4xsA6sM=;
        b=f9iLQQqkVTYrvPaGhqC4h0juBINe9+/m84GWy3bZfD15A624npEz2P2gtM+1qiThPI
         UhuTjKTs2DB5notTk89fwumGvIX71zh7T5UZrmf1bauQZOYnJLS31svcLW/7kQpWHVod
         bsanRlE4SQ98i1+y6F2fhRGI7oTuHAmtZ7NaewgxyRGyebNbP4JcCxXrLu1ZA7UEt9JZ
         K1Rxl6OiOjs7ThmzNjrCwq3KEUHYNIqYwhsu4+sKRVTXOleMXl6U3FJZfCoVNwUu9WCG
         kcwTERIj80RCFcZ4NpeEcDXBde7pBQHqDNAL4dswCwsA8kJpSFx8HCB5/Ms57Y3/Qkmw
         o3VA==
X-Forwarded-Encrypted: i=1; AFNElJ8cZ300S8AalPfR0EL4WevhUdh5Sc3F6S4Qr0epkgaEnRHAs88QLYYMODJ0CtvNpdCZJNrkvU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww3JlGkZWZJPasztI+t7wBq4rVDGs31jpD+cMk/yG4TYCXcFLn
	uo2r7V05dYq0PuZHYWd0YjGlRh1Jf5sUJ/Oo8rbnFp0tt9JWFWeiTsWb1UgmlWtb2DQ=
X-Gm-Gg: Acq92OEZKYiWt3axaibAE5WnD6n1LW7n56ZOAuKQTUuhq4hxllamVHiSdE0NTf+VTwH
	RaTlx18IOH55G/uf8UR+rkBKtp9PKOAUZ1y2/HCFcOWabHtuRkrzSlyi7jQEZZ9oeiNSd9RMKId
	yzzTEZ1++V77racwjDbTP35olPN3AqXORhOAfvt99TnWHcweEBitoF3kTD+7Et/kgjZCz9j2etM
	uJeVwt2mV2D1uDIhOYNKYwRNwncJvd+IiPRXr9RXvi8cmNY/J9WnwFcJyvnSMCiTkTxY8ik7LQB
	ULaB2hYqMmNjzKbuQbdcesclHqmKa3FalGriDjzRiSjWlMmNtTDbFzaLwlN0CcsQxm5UNH01VTK
	EpZolwXytv6BFL1niY3ylUPu/isY75yI/jq14qVIVNcN9kzArxGbcFSOuw/3oNIkQeDrq1pqwy/
	sJ5iwToq3FoIf0dWJj0lyi4TfIGw==
X-Received: by 2002:a05:7022:fa1:b0:133:54fb:f563 with SMTP id a92af1059eb24-1350473aa89mr2644596c88.23.1778883126994;
        Fri, 15 May 2026 15:12:06 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2e686sm9626315eec.5.2026.05.15.15.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 15:12:06 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Fri, 15 May 2026 15:11:50 -0700
Subject: [PATCH 4/5] hwmon: (pmbus/adm1266) include PEC byte in
 pmbus_block_xfer read buffer
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-adm1266-fixes-v1-4-1c1ea1349cfe@nexthop.ai>
References: <20260515-adm1266-fixes-v1-0-1c1ea1349cfe@nexthop.ai>
In-Reply-To: <20260515-adm1266-fixes-v1-0-1c1ea1349cfe@nexthop.ai>
To: Guenter Roeck <linux@roeck-us.net>, 
 Alexandru Tachici <alexandru.tachici@analog.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778883122; l=1565;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=rP04PKwq1R/PP8JxrqExEG/Wa23i/3eww37NNCWqAhQ=;
 b=2PNAO62DaJBNERe0/MaLo76D8o3WxNJxlnvyAB4KhOkACv+TmFuzh+cmzBM2k7B5wA4y02Xqo
 cC+jqrpbA3zCAvG9GXTyQMbl1cO2ngh7hRPx241ZkZxnr9Dc3zaszXX
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=
X-Rspamd-Queue-Id: 0D93A558B1B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nexthop.ai,none];
	R_DKIM_ALLOW(-0.20)[nexthop.ai:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[nexthop.ai:+];
	TAGGED_FROM(0.00)[bounces-248935-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abdurrahman@nexthop.ai,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nexthop.ai:email,nexthop.ai:mid,nexthop.ai:dkim]
X-Rspamd-Action: no action

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
---
 drivers/hwmon/pmbus/adm1266.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index 43d9e7407795..5c68e3177f64 100644
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

-- 
2.53.0


