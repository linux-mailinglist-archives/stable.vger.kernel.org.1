Return-Path: <stable+bounces-254026-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFSTESj3Emr25gYAu9opvQ
	(envelope-from <stable+bounces-254026-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 15:03:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFA75C270C
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 15:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D97D23007C8A
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 13:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E7E21638D;
	Sun, 24 May 2026 13:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDPejNea"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D9A6FBF
	for <stable@vger.kernel.org>; Sun, 24 May 2026 13:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779627811; cv=none; b=NSrgZc4zPeld+ROM8lfUMa4IuH/+jXh/fGwVPlgH9SGoLa720+mvDCOuBByicnPGKemCEmAzSySu0jxd8eaQI7A85UjLoTWqNTIjvRw2nhAkcZ+5Rf1pX9q8J1xm3XjSrRKsO5xmLlHyvhNYovxkEGRHiBmqmIbVcV9K1UkVg0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779627811; c=relaxed/simple;
	bh=xSoWpgG+OctKW/Xwxy2T4BFr3tC4A+2ZzOcslwz9mRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rtq32Y6FgFfR5/hcR6u6PPwPtV1/89T+8bumLyQdOKZAU6x5xXNiePleC9U3j2cI5ZKKffILVSpY9bIhHK96N4EYAMBP7vS3YFLP8WsU1vryvJqKxBd5cb9HpMNy4zXFztKPN9YY8WaryL4hucPC2QKF5+U8ae/HVRRNNKGClZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDPejNea; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so3998645a12.0
        for <stable@vger.kernel.org>; Sun, 24 May 2026 06:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779627809; x=1780232609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kj4rwdcY67VyrdGlOu4L8pJ9Vyfha/VtjkF5I+0OLKM=;
        b=TDPejNeaY+e3mCHT63RFVCv2YtQQqMc9u8qQwv8+sxAxvXfZ+z+sw7dzwQjjP0lmg6
         brzmJrMVvSqDiXp2SXqvIsXUImH8jbU/A37FjWLcaMbaOdUAiYaH1VVfAO5vHPKTEYb/
         mT8D7+O3T9+BV+PROykvFQz9/uhRWV9hyICfWP7uqxURbZlUnBxuh9s8Hg5R6zM5HwLG
         mqlkYl0t+gMvNYnQmbCaoBJKmJCoccQI7DNGJVh1xuc1DrKC6G0rmNri6TBbe3tMfUKs
         I8lCaWjtIORqF5ZnU0YoqoEdQdJFFcQi29MgrZTQW8ehPX2SSI5wZT3vlspIKMUu6mhC
         8AOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779627809; x=1780232609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kj4rwdcY67VyrdGlOu4L8pJ9Vyfha/VtjkF5I+0OLKM=;
        b=NLKroMo3hhxEVgbA8aSnwt6kMuEP1n14n+nUvQBTkY6LU8Aroqn2xF0H0s68DfjmC5
         6NVj4UAoaazwK7IHM4GJHhRSIL2aOCLE3ndsmIKa5RKDGdjQynW11QUcWvoP1W129YVO
         v2mlDo8DYZbSUsaibNGVT2irDgGvS66bQ57J9Y87Zov7YWS4AaPJw/Y0t2kKxmjfJdo5
         cLjD+SpOVxOXaelexsLKHvCjd2QMQr0bgm0q4z79z8qYr4gXbZMPNPCsnisA+itecoE+
         AVT8COvfx0yYKZF4WQdkbZ0kKv41eD7Kv27zVn354GVdn00EtfsVtn87eHPY6II0nrs7
         uc/w==
X-Forwarded-Encrypted: i=1; AFNElJ+JEibIKUnza6epAGx8h9P0+REIY18mRWMo8wvV/JyISPQoscIy8xKMUkMa/YqiU1mVvE6kZ4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLojvtroR+Vuac82bxZh3Sp2poR65Fi8OpSj9O3/D6TME51l56
	Ro9Onv725hrZTqsyEACuZeozj51W4pZyMSwjVWRfX/wvIykfYkZUAP+G
X-Gm-Gg: Acq92OFnDCDWO0hncVUfruIbV6i1+fkm/aMV5O+KCYgU4nSC3vf7yKAsWC/fLQQvau2
	7mDu73RiPz3ra0CxSvxQUq3ch7M/jtW5XWh3xo2my9ngPNDkfmR0Fx1bbjDH6DtUTr2ZGkGRgJs
	cxbfU5z4HCK33zt5XPqF5uthDhl0cKaTd5++bMdAMrtmSKCwP0CY+M4Wt1BG/UV+CIeIV8+IN1S
	edKajEQM2gE7hMBWtsoInhqum8g0OM/SzHz/2Q7C0g5kJR0wit8xC2MgrgpDOMzxNSiQsMOasHq
	Uouo0t4vjQoS0l7sdYosA07MSjEuSz7jPV9QqxMtCiQwDQ6utY99rv96xCadsPV8M3oxaGzvomS
	TcMJwe8pg5QzT+YgsABQTmWbGBRGxJcwItJjwfQcD3tm40AWC2SDpfCD9rZzYNIY8JnBbOsSn4H
	0/kX7CX0g3OtIyMp5JJ1DnfMlqEN2a8aUsq+cmORNrFiuR+5z6Th3636i4Vwc/+brIieizyGWj9
	omVApSf0jL/4RDl7lM4eigvQZQ00gf2PGYgl5QcCekYBMCM/Fo5sh0xt+Lql9+Xv9qNItbpidxJ
	fFiG/i4hrFE=
X-Received: by 2002:a05:6a21:4d8d:b0:3b3:241f:66c6 with SMTP id adf61e73a8af0-3b328e504b4mr10852348637.26.1779627809312;
        Sun, 24 May 2026 06:03:29 -0700 (PDT)
Received: from codespaces-78f0a7.mimvmn1ww3huhhjmzljqefhnig.rx.internal.cloudapp.net ([4.240.39.193])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8520560ff8sm5759610a12.24.2026.05.24.06.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 06:03:28 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: robh@kernel.org
Cc: tomeu@tomeuvizoso.net,
	ogabbay@kernel.org,
	tzimmermann@suse.de,
	Frank.Li@nxp.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] accel/ethosu: reject DMA commands with uninitialized length
Date: Sun, 24 May 2026 13:03:19 +0000
Message-ID: <20260524130319.12747-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[tomeuvizoso.net,kernel.org,suse.de,nxp.com,lists.freedesktop.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-254026-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9CFA75C270C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cmd_state_init() initializes the command state with memset(0xff),
leaving dma->len at U64_MAX to signal missing setup. The only setter
is NPU_SET_DMA0_LEN; if userspace omits this command and issues
NPU_OP_DMA_START, dma->len remains U64_MAX.

In dma_length(), a positive stride added to U64_MAX wraps to a small
value. With size0 == 1, check_mul_overflow() does not trigger and
dma_length() returns 0 instead of U64_MAX. The caller's U64_MAX check
then passes, region_size[] stays 0, and the bounds check in
ethosu_job.c is bypassed, allowing hardware to execute DMA with stale
physical addresses.

Fix by checking for U64_MAX at the start of dma_length() before any
arithmetic, consistent with the sentinel value used throughout the
driver to detect uninitialized fields.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/accel/ethosu/ethosu_gem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 8e95539da98f..3401883e207f 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -164,6 +164,9 @@ static u64 dma_length(struct ethosu_validated_cmdstream_info *info,
 	s8 mode = dma_st->mode;
 	u64 len = dma->len;
 
+	if (len == U64_MAX)
+		return U64_MAX;
+
 	if (mode >= 1) {
 		if (dma->stride[0] < 0 && (u64)(-dma->stride[0]) > len)
 			return U64_MAX;
-- 
2.53.0


