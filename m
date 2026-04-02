Return-Path: <stable+bounces-233061-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IgnKjWZzmkBowYAu9opvQ
	(envelope-from <stable+bounces-233061-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:28:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC1438BDA8
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 195943003EE8
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 16:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B293537FD;
	Thu,  2 Apr 2026 16:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3ENU/fA"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD04E2FFF88
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147004; cv=none; b=cQXXUh+hKdQcbefE5pwcEH5deNUW7hQK1+Xb4ZQmNdASkGbMt8KnsiPSyC+YEj+wS3/dnhZ+YIhytkdwUSvEqkMDh310B3lr6mR9RMfo5+UTpDLff1hlX3os3Pyv1mTBW7r8PQrZjhuinpA08c2bA7qrR9B91XO5v9E0fHUWm44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147004; c=relaxed/simple;
	bh=3A9KGYgeMUK2GEJvMz06J7Dl9SaVyCfHnRlIITPKZ3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODsYXuNVAntidLqKXlk7jZCVW+w+HR4YfbqaXUiKkZcqyfA9EGuySJFeDouLbXxSF7UmZjvEo/DRxswpCezbZk5BI1DZne3600zVeahNxs3FALHbAH8X6uhvdt2osU2gxGMZ52OvLLUhgwfrkafiWBCsWtMVBkIae+FPCOOD5oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3ENU/fA; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-6055dffd694so353427137.1
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 09:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775147000; x=1775751800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQdnjdTuHD1u/JHVHdnYj1E1ndYIkWP99vNZk5JKW3I=;
        b=I3ENU/fAUva9w93Mmo9L4LlCOgyK5ppccR+W7kakCDRCFbM8WuAxHRvQbL3RwmgPjX
         LNn+FRE3A9WMVrEh3//tgjzYl5qT4z1nMaDIgl8obYuoxBoIAaqLlwqxIyoLrEAvbKLz
         v3a5O/3OvNTcHivZIjeDbDG6ZspYyZHxUlpokbXqHymptpstd5l7EGmdxY0WIvxzpPZ5
         Bt85BbFUt3FHa8G4zMR+zWbBVJpWdjAEJPAin5J5hekF5hlOAW8JBb+pgrD90yzFZ746
         4tcts7oOYhfSgb2Z4jYvCNPho30WormOff1h6GWrEn94RP/FlqBG2ar2qdG277LzUDa4
         M6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775147000; x=1775751800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oQdnjdTuHD1u/JHVHdnYj1E1ndYIkWP99vNZk5JKW3I=;
        b=N24JS4sLuZJ5OB3miim41NTmrbZZN6SphaxmXfYyBAK8Ae1MVY6nRedDfVp7K+xC7Z
         +tLohRvirJCKYn1wyki2P8qYzODAqiEmejGwetft4Wlim8cLqvw75SRxnsqJsqQQMfIu
         pWMeVAgLrXk8KWxhmGoWjDfOSOhZoSa7Du2KsFhc/u080LSMumKm57RcTF7oXQTAhTK7
         MTh9kNEvJmqq6nMus12reYmDQQ6G2GeOA+ac+/kONha6W4YwKQLT2aGnbYUB0P315Lyh
         lSKoL6VA0/LwYC0fhfrWZzpq4Q9vptd8AouNEnA1qL88zi00G0w9QQr0L0zXmRWdxKAb
         fYDw==
X-Forwarded-Encrypted: i=1; AJvYcCX49hVvZI7UrvA6Vz9H6fTz9zrJERof8JEv44+5clgG2CriLehQbrYS0eFqJKrMbEiuFqxEXUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YycEPkP12frnWW7YgBhGZxVaIfxjQWgeMy1+YN4R6yjNebtHxs3
	BiTDy+XympG/Kl98xoTmN04ptraVAcmN+4X0rhPF7hW1fcnh577XtNJqf0eZmBrfWmMm9LnA
X-Gm-Gg: ATEYQzxe41QUreo9Dt8jqztLqHlt7WwpnMMjRevIpQJ8Qo+QsqlC2XKytxnAGJKceAg
	QEVqAGA/eCpQAW9HdK3zjSRLh05RUnfzo84WGix38ldfWPCJzSQ+pR4HxIcrJOW1cE/ClbCI2Bf
	zDTCHwGmU5ktJnMv4APgNMUP3YKGdxLh0LrpoAYjf0disSa1MWyVb6cl9WVpsK5FcRt0zW+HlFX
	ZRZp4QEZGei+SjHGyGOe2EkVasIuuWgO2XfwpFmOUQgXQVHHyMSDv5TIp0KsUBiJFGhjI4GOKmQ
	V/oJ8ImEjfhGTnUATVtLB2nXE9/IoqxbGo1cHjeRJOAEiln2GZDqW/JMr0fMnaJRmaGRQeefVyY
	Da53AOSaM/c179k6iwxNiwOnR6RLHxp9bQYmxyGxEm+qvN7zVlk494fiLREAqtxLceoWPbCV2HN
	B/4WDuSkkTlzmzwY7xSc5iHjRr
X-Received: by 2002:a05:6102:b14:b0:602:9b21:eee7 with SMTP id ada2fe7eead31-605682b9af3mr3456400137.35.1775147000487;
        Thu, 02 Apr 2026 09:23:20 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:6d70:aa::11:17b])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-953fba6da8bsm3648919241.10.2026.04.02.09.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:23:18 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: linux-fpga@vger.kernel.org
Cc: yilun.xu@linux.intel.com,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Josue Alba Vives <sebasjosue84@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] fpga: microchip-spi: add bounds checks in mpf_ops_parse_header()
Date: Thu,  2 Apr 2026 10:23:01 -0600
Message-ID: <20260402162302.3804617-1-sebasjosue84@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,microchip.com,kernel.org,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233061-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebasjosue84@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0EC1438BDA8
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
   Return -EAGAIN with updated header_size so the retry mechanism
   can request a larger buffer.

4. components_num is read from MPF_DATA_SIZE_OFFSET without checking
   that the offset is within bounds. Add a bounds check.

5. components_size_start (from file) and component_size_byte_num
   (derived from components_num, u16 from file) are used as offsets
   into buf without validation. On 32-bit architectures, their sum
   could overflow, bypassing the bounds check. Add an overflow check
   before the bounds comparison.

Add bounds checks for all five cases.

Fixes: 5f8d4a9008307 ("fpga: microchip-spi: add Microchip MPF FPGA manager")
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
Changes in v3:
  - Add overflow check for 32-bit architectures in component size loop
  - Add bounds check for MPF_DATA_SIZE_OFFSET read
  - Update info->header_size before returning -EAGAIN in block loop
    so the retry mechanism can request a larger buffer

Changes in v2:
  - Return -EINVAL instead of -EAGAIN for header_size == 0
  - Return -EAGAIN instead of -EINVAL in block lookup loop
  - Add count check before reading at MPF_HEADER_SIZE_OFFSET
 drivers/fpga/microchip-spi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
index 6134cea..10be986 100644
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
@@ -139,6 +145,12 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
 	bitstream_start = 0;
 
 	while (blocks_num--) {
+		if (block_id_offset >= count ||
+		    block_start_offset + sizeof(u32) > count) {
+			info->header_size = block_start_offset + sizeof(u32);
+			return -EAGAIN;
+		}
+
 		block_id = *(buf + block_id_offset);
 		block_start = get_unaligned_le32(buf + block_start_offset);
 
@@ -175,6 +187,9 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
 	 * to each other. Image header should be extended by now up to where
 	 * actual bitstream starts, so no need for overflow check anymore.
 	 */
+	if (MPF_DATA_SIZE_OFFSET + sizeof(u16) > count)
+		return -EINVAL;
+
 	components_num = get_unaligned_le16(buf + MPF_DATA_SIZE_OFFSET);
 
 	for (i = 0; i < components_num; i++) {
@@ -183,6 +198,11 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
 		component_size_byte_off =
 			(i * MPF_BITS_PER_COMPONENT_SIZE) % BITS_PER_BYTE;
 
+		if (components_size_start + component_size_byte_num < components_size_start ||
+		    components_size_start + component_size_byte_num +
+		    sizeof(u32) > count)
+			return -EINVAL;
+
 		component_size = get_unaligned_le32(buf +
 						    components_size_start +
 						    component_size_byte_num);
-- 
2.43.0


