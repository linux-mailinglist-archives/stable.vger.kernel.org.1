Return-Path: <stable+bounces-233043-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBJFK7GOzmkbogYAu9opvQ
	(envelope-from <stable+bounces-233043-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 17:43:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B8C38B627
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 17:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4CE64302FF9F
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 15:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957BB38AC91;
	Thu,  2 Apr 2026 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMiyVePK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C0333A007
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144295; cv=none; b=mPbZe1bF+bkuTIgMgWwMHigY3g1P6WmDIKynhUROzz8P9Fk7Pa4bbF2MVy/1MOTMbi6zPeSqTHuMZdeYJ8/gfmJWyD5XXBDgCjlEac5I5ZtPU9cojh7MLGvwR47cnw4RXMfoV/vX2Cq2pL6lzfaCQKKdCT6Rf287kwFY1x7WgbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144295; c=relaxed/simple;
	bh=AUcfU7ozLC1fJxQaa8e9OfGKpGskpsFLA2RJUD+6vuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ti8u1RZ3QPJUISKFfGgrQ4ujHf0fq0GaA9pu5bpAANwvYEgmQrsGFzlEL4DEuYvwqGTU8Ux8QITsfHN6Y9YdsYqWc0vBBs0NW3IcgLWayEnvkkKRhnsWpFS6YRhavaqIFQs6ntFGKP2mXndBMe9zT0ZSumnvJ0gP9i9ZAH3lnpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pMiyVePK; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-953aacb9d78so309199241.2
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 08:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775144292; x=1775749092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwEOZMEaU0+lFHsy/ODF1F7HIytWIXRTEWV+IDHWPtY=;
        b=pMiyVePKlHzqWtBzxIZbOEbTL5/8ew2aubm/vS52ZhvHAhvR+1Y8dc71j45jtstHOl
         0RiF+wvkqDHI/ItGlBmqlUp+8Z+42TlpFW90fIRLX8BLhdkZfybsLzmSQ0QlAYIWcebO
         8VAybTUy1aZDsaR3D5TLinC4uf+JdJVwXj0Ew4v368HJjnC9toqScG/UI7F5Ukvmh5Eo
         j7P/TrQR7J3aSnWZI4FiMQde15gvG+VEQ9JZynnH22hQXcx50KkIW2D06FSu9DtcAAFm
         m+R7Ez9SWdAyva4Od/vg0ro8vqpJSghSukf5tRsBmtSIIIB5/8aiY/Xzkv78lqeiDmWY
         emsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775144292; x=1775749092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vwEOZMEaU0+lFHsy/ODF1F7HIytWIXRTEWV+IDHWPtY=;
        b=sC1coWxe/WLePSZITc5wrdA/rci6fvVit12F0gxRMqKrrK91nNMDUFwav8Db7dklbB
         mkZ0iolJEHuCRFY7/zKLi+/Z6I3u9fwYwEYCi8/Ecnm4AFQXN+uXHk/FFYZ3ktShe12d
         OFsdXoxs8jEtz26ZXOTc1pBDiQ/YFk2sfWjG0ZMs9mEPHlf4i0igR0z5zXWmrfEOA31g
         JHbuZVCZNSXTzf/IaCDuGb7DQgeS5HFFckUUy26HgP8UP6Cs4gvwwDB3LG75D1fIdOdS
         eTzHyQN+u7nnlYf4Ikj01+THEa/qa7kNoIRLtLkfSLfPXNGZihbusraGDcg9X0cRwq30
         UH3A==
X-Forwarded-Encrypted: i=1; AJvYcCU2iseA27e2sJ6AlaSB7CGxDfgEHL1L0JKYWEgBGFC5z0ICromyLqf0lJv1dIbUF3C+S+3aINI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg9PymGT56H4U1OrGUAv5SLb5dbBX25llKrzaPAiAjh0L9QOzY
	YkFaOA8mHzRcpCW9LJDOFQXlLU7lf+7d3zGmD109fdRNNQeQYmpvt1oN
X-Gm-Gg: ATEYQzwdz9AEAHrAK7iHhMmXeB3YA0cr4FKVZZqqL0xLtE6bSqFf47BG6kdfnL3wzL8
	5mT/JihctZIpKKaOU+JoHGg/QnnKPdJfUdYjEoWq1QN9rAx2TMbp3BriHHzNo0ZsPrjJoxBfEZ+
	y9gujtLaWo427Dm7NUttUqkmNzlZvj9CQJ51ln9fL06HNj8eP2k+8l4Dmlm0Efq8xCWWlppCfJ7
	cHdTthOn1gQgwnDAA8XLn7UUX86r0GCyU1MKUmVzgNkj207yd/GMs2MmeLAdltSqV5I80+PTKsj
	S3fNJzUnPb3Uc7FfiT3aoKgoMfQ7GD3qfrmREyTjMgX1TwQf1FyMG6WdIwswM1wjblt6sOqKpNb
	u31xpsGJ7MITZ83u/gSypQ9474HfcClLHvZdBA2rrJRY5jXyJXopmINYImy3reEIXsFNE60DK5G
	5eG+GyZAGBsMV+8OKnRtZxZJN9
X-Received: by 2002:a05:6102:4492:b0:5ff:f366:dbe1 with SMTP id ada2fe7eead31-60567e7ef70mr3209136137.15.1775144291611;
        Thu, 02 Apr 2026 08:38:11 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:6d72:aa::11:17b])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-60582e1d1edsm4103633137.1.2026.04.02.08.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 08:38:10 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: linux-fpga@vger.kernel.org
Cc: yilun.xu@linux.intel.com,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Josue Alba Vives <sebasjosue84@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] fpga: microchip-spi: add bounds checks in mpf_ops_parse_header()
Date: Thu,  2 Apr 2026 09:37:52 -0600
Message-ID: <20260402153752.3793055-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402125446.3776153-3-sebasjosue84@gmail.com>
References: <20260402125446.3776153-3-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,microchip.com,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-233043-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebasjosue84@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 04B8C38B627
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>

mpf_ops_parse_header() reads several fields from the bitstream file
and uses them as offsets and sizes without validating them against the
buffer size, leading to multiple out-of-bounds read vulnerabilities:

1. There is no check that count is large enough to read header_size
   at MPF_HEADER_SIZE_OFFSET (24). Add a minimum count check.

2. When header_size (u8 from file) is 0, the expression
   *(buf + header_size - 1) reads one byte before the buffer.
   Return -EINVAL since retrying with a larger buffer cannot fix
   a zero header_size.

3. In the block lookup loop, block_id_offset and block_start_offset
   advance by MPF_LOOKUP_TABLE_RECORD_SIZE (9) each iteration with
   blocks_num (u8) controlling the count. With a small buffer, these
   offsets exceed count, causing OOB reads via get_unaligned_le32().
   Return -EAGAIN since a larger buffer may resolve the issue.

4. components_size_start (from file) and component_size_byte_num
   (derived from components_num, u16 from file) are used as offsets
   into buf without validation, allowing arbitrary OOB reads.

Add bounds checks for all four cases.

Fixes: 5f8d4a9008307 ("fpga: microchip-spi: add Microchip MPF FPGA manager")
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
 drivers/fpga/microchip-spi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
index 6134cea..00fa2d6 100644
--- a/drivers/fpga/microchip-spi.c
+++ b/drivers/fpga/microchip-spi.c
@@ -115,7 +115,13 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
 		return -EINVAL;
 	}
 
+	if (count < MPF_HEADER_SIZE_OFFSET + 1)
+		return -EINVAL;
+
 	header_size = *(buf + MPF_HEADER_SIZE_OFFSET);
+	if (!header_size)
+		return -EINVAL;
+
 	if (header_size > count) {
 		info->header_size = header_size;
 		return -EAGAIN;
@@ -139,6 +145,10 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
 	bitstream_start = 0;
 
 	while (blocks_num--) {
+		if (block_id_offset >= count ||
+		    block_start_offset + sizeof(u32) > count)
+			return -EAGAIN;
+
 		block_id = *(buf + block_id_offset);
 		block_start = get_unaligned_le32(buf + block_start_offset);
 
@@ -183,6 +193,10 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
 		component_size_byte_off =
 			(i * MPF_BITS_PER_COMPONENT_SIZE) % BITS_PER_BYTE;
 
+		if (components_size_start + component_size_byte_num +
+		    sizeof(u32) > count)
+			return -EINVAL;
+
 		component_size = get_unaligned_le32(buf +
 						    components_size_start +
 						    component_size_byte_num);
-- 
2.43.0


