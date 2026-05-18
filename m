Return-Path: <stable+bounces-249346-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPq1LiVFC2qsFAUAu9opvQ
	(envelope-from <stable+bounces-249346-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:58:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE01571539
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35A7530B854A
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 16:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AA64963B7;
	Mon, 18 May 2026 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nig/8IGO"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8613F88A8
	for <stable@vger.kernel.org>; Mon, 18 May 2026 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123222; cv=none; b=uVtVVOest88FRLazKdnop1MiINTdWmKEaLlxMn9eoQ3LjRkhUWpFk/vD2U4wCnC9wDGRj51LWy0xZhGVPC/p+I9Wj9WdSGdPza1LwXn1QJdkPHcuokyFJ89/mU2znI5uw7DuBcAvLpeB4EftteNHivpQVzmoGhx1bDX743o3/SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123222; c=relaxed/simple;
	bh=x6fSzNzW8Htmx7JzIRVC3kL/nANgg4e8FJZlKdc/5Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRcaywSYHt8Z4+pj5fizH0FxS5iBiGwvgvsbkk0yYKO183dFQd8lG5Fymg8WTT+Dne+i81QOSi0me6l05jz6BMnS5cPQYaY13IT9vt1PY3c6USDF0z6YF7UkvxDldDyZkml9xYgjLCrKe4r9GxWm/Iz9vrfI1+XfWE/0a+y0f1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nig/8IGO; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-65c7efdb7d8so2680500d50.3
        for <stable@vger.kernel.org>; Mon, 18 May 2026 09:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779123216; x=1779728016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPQzlCozb0IWzuM5HxK9k54cI0UTN22+Y8fkzM1tXUE=;
        b=nig/8IGO7fNS4r6cyttyXqDDPnz0GjoUOxDXmCRPmCv/zCxNen/AcirH2lbJPekMLR
         iqWgcwtocFosAh55PdSXYlcj4b0KCLb6z9UYPpAhRmL1CAnu1BEG698iRkq15VLj6xrh
         HWsWNtNLbNzctVUX43gVY6bZHNTQuUiLf1c7n2A5FSmw3FgDR2scteXUaSMytvQ79QaV
         q591vdEonLRaV+1Kd/wQIzju8BycVILPPEgPSdVCsKVcih6q8ERKwdO4jmuU2yEZPEHw
         XLCgg6Mp++ospBAMpfPBdSQJFU7MVwrWve1HID4MGq1b+gbzhgyUB5pRuIbscyNC/81n
         AUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779123216; x=1779728016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bPQzlCozb0IWzuM5HxK9k54cI0UTN22+Y8fkzM1tXUE=;
        b=CqeJywWrc5HH1Xw1AG921kPo3EiVDqsd7LE062uUedp3r3gOv5NFbVYQljuYghrAhl
         WAZQqfjulz2A0sDYpI5g0EeQKbYh3ERbO5wvTxhPJ8qCUdFXFAhZ5Ck2GU/olYSWI+rt
         t3VQIz09VOYss6nmdlEUzA3qu3WOJBfCzlU/fN2qHbu2o8QioEwgNXTxIk6c8aElMJh6
         TzO8uZm7VRatl1VYbVVZhhImpMH0tX3sCfQ4KvlEZ0WR77F2qNuTNkCpi5amQGl9i6Y/
         RmC0Cr2LBVreTekJ9ROgk9UXgpkEzzpz9gFFS7xUqD0wfCf1mCPVNbTuqDouYItgrF0X
         B09w==
X-Forwarded-Encrypted: i=1; AFNElJ97+tTL32a/6hYcdipcRdqPN4ea+nCsntwwo2+4p/E5Yx9JvVhBAIqLn8EWnMejWC2k1KTg4ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjV3t64FHAYUBJHRqnrdTcy4r+DU87G0hIBGelw4AwvbDBabAh
	FIsvHOqHJsk+fTSEQ9z3B1Yd3aop4jEZA3QNJo8Wj9Ka7KH9/04WW8xx
X-Gm-Gg: Acq92OHX1UYpmqZND59TWkAHNWwgwrBjJ3xjY1ydJFdwl3mauVB/e0a/FAwXu2cLDJS
	NgkV7dj+Ll3im35uZgU9wG+SrfAO/5gF4sH58Ap3GpMdAqSQl6btgDr0wOpHcRXKb9WAFLfIDFn
	jC5n+fQ2HWgLuCD1nM8E9veI6mWDYst3/8AhRNdSlNMEH3QuGA3BocsKdM/E2ie8BSfvd5mdSls
	FrIOKgG7LSNYJFFuovB+czoUJ64OW29s8v0RxaPCM0plA6q7qdFgdxfLA3DTWm69oaYMROStXAZ
	IodA17XZqu3IUtJOtbsSPTGX4L+GGC8C37TZ80bb1WghtoWqxwQCmKyRcvDRmFa/vJb/qNOCBvL
	RRzLtf1UO9PaDgGS24rd2KlsJzHZ0Iz7yrUS1uTwVyNpFYyfdlu2Md2vaq7gSasdApL9ni8Pfoe
	CbC3sD4O+Ao4pCKa1Weebc3jCZbDMiDyf9eDg+KCPPFjLCLqOyFvmxWzXfZoF3uEktL0ArOlOa6
	S7XZjl8LfgOyOCY
X-Received: by 2002:a05:690c:6811:b0:7b3:c611:7ef5 with SMTP id 00721157ae682-7c958ecab11mr178753267b3.6.1779123216105;
        Mon, 18 May 2026 09:53:36 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc965ab98dsm24232957b3.0.2026.05.18.09.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:53:35 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v7 3/3] fpga: microchip-spi: fix zero header_size OOB read in mpf_ops_parse_header()
Date: Mon, 18 May 2026 10:52:18 -0600
Message-ID: <20260518165218.35388-4-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518165218.35388-1-sebasjosue84@gmail.com>
References: <20260518165218.35388-1-sebasjosue84@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,microchip.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-249346-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebasjosue84@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1CE01571539
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mpf_ops_parse_header() reads header_size from the bitstream at
MPF_HEADER_SIZE_OFFSET (24). When header_size is zero, the expression
*(buf + header_size - 1) reads one byte before the buffer start.

Since initial_header_size is set to 71 in mpf_ops, the fpga-mgr core
guarantees the buffer is large enough to reach MPF_HEADER_SIZE_OFFSET.
The only real gap is the zero header_size case, which cannot be
resolved by providing a larger buffer, so return -EINVAL.

Fixes: 5f8d4a900830 ("fpga: microchip-spi: add Microchip MPF FPGA manager")
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
Changes in v7:
  - Correct the Fixes: tag commit hash and wrap commit message
    at 75 columns (checkpatch).
Changes in v6:
  - Rebase onto linux-next. Add cover letter.
    Suggested by Xu Yilun.
Changes in v5:
  - Drop redundant count check since initial_header_size = 71 already
    guarantees the buffer covers MPF_HEADER_SIZE_OFFSET.
    Suggested by Xu Yilun.
---
 drivers/fpga/microchip-spi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
index 6134cea86..cc8f6d7bb 100644
--- a/drivers/fpga/microchip-spi.c
+++ b/drivers/fpga/microchip-spi.c
@@ -116,6 +116,9 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
 	}
 
 	header_size = *(buf + MPF_HEADER_SIZE_OFFSET);
+	if (!header_size)
+		return -EINVAL;
+
 	if (header_size > count) {
 		info->header_size = header_size;
 		return -EAGAIN;
-- 
2.43.0


