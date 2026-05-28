Return-Path: <stable+bounces-255077-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPPLIJmCGGp8kggAu9opvQ
	(envelope-from <stable+bounces-255077-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:59:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6A75F5FE5
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6405D3004611
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 17:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA683BCD00;
	Thu, 28 May 2026 17:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S26t1rmC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B0E363C7C
	for <stable@vger.kernel.org>; Thu, 28 May 2026 17:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779991190; cv=none; b=IfflzaHuidDNoox/X4a5RQY/Ty/5dnnJSU4KPJTWVRs4JO5E69z+P80r3qhVevL1uReAKsz7y03Al9WlgJ507wjyFbFPBDZ9HxiEWUxNIBcq3PWx4vgFwwbBWs+3LXLovh6oEc8y6HBpuTqijNJvPjP66/axDMrj5adaRizQOS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779991190; c=relaxed/simple;
	bh=E+sRLd242DfXEDi3/pzBi9WJhlW9gBpf472M530JMo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDZMCN5W0cbUtWfDDGE0RAqi13wUmbw/JRQPhr0jm7l5tpW9iZhVNvQ3bW7PrpQKc3QR5ASIPMdCLTXP99aE5i4Y0Ej8kjcdsJ0ILzG/bCCUiiKn4oHFBhjxPl9sC3mY/er1487n17VtcVgVX2VgBdCX5QA6d11Kq7A0yvIaHMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S26t1rmC; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8354461da74so6154545b3a.1
        for <stable@vger.kernel.org>; Thu, 28 May 2026 10:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779991189; x=1780595989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3y0id5zqfx0L7OPAbGhsWl9L4QCfBZVh0Z4XwrQwPI=;
        b=S26t1rmCaVm3xEGkv5pz1p5pw6gJvyMB2nVLfjWh5lt1wZo5NXg7ydvi7fJp+crxmF
         wGuuS+e1X6zrqln0L5z+3RMxEnfhFCJiSoE56702pw5KopmBRmGAtOfQO+D4Ox3grOVh
         R8VpT+FLEqMZwjjPvbvsuHZqk1p0wI0qs/ljJ2ZRWxlj2mgjk3/nmtAw/nOu6n3XSFJM
         T34fql0AoFMMbDnx1dUnePkQozb4k0pnDh5TmYaH/FyH+5Ye5Gh5R1N+r2/AY+75bsEI
         43seTGA6iHp9iQvnelxS6dQsmqs8q2gL8NmCn+elpDMC5KCs6ts9bucFidoFnuYD21IH
         vdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779991189; x=1780595989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u3y0id5zqfx0L7OPAbGhsWl9L4QCfBZVh0Z4XwrQwPI=;
        b=PS7L4DM3KqcXlKeS7Py7mnIG1PvallQInka3V3HVP1e5loi8uTJFKT+Cn9dotdHdJe
         4WO4nrYQNpxVp3hyUgHiOlDolNMcqdlwOJdA58V3az+n3NCWEGGtl2S84FWcd5lcaRsG
         jN0/srYlEuYffxJvmcUGQa6fEQVr/T2RXYK6qYXvkkcwoRnnr9KtKU6XCU/AK9bWfwaK
         N4LhMoVdAkSj/6fx2sEzDwoaRLXa7ARGHvaRpR9gEgnMEypPN6oTAi7qkRvNt0a7sOLw
         EQw0vaSuR7yd61nubiL7qJHEcQ/5BTRh9AnXVoW3kUV7cmntLsZ2SNih/1zODFkOuGii
         QLjw==
X-Forwarded-Encrypted: i=1; AFNElJ+HBf1qlUou+DEeC0DEuwyrXbCobqSy7i3i3gLJAulLBCh/Y52QkAY4/qk2z2vG0yK+oAdjYBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwjTHrh+JEOpGF4lt9Dc1TEvQmjb4zvU6ne4v2d6dJ8e/a9aJz
	HG7vwhjgTMuK3OFErYtFvZx4r18J2oejD5nxAkM9yf2xqUGyd0ALSg8O
X-Gm-Gg: Acq92OHfdz/2GDAm1CwRV8yNTrOIBv72YZMTrFaGwiFTWyF2dmWTELnXs2Bb8TMPPWA
	4TFNI0wKf7VbwC3aMKN5mQbZu+k3sGW1x0sm6QJ4LcMQFu5nLsNAF6hoLBf3vmfHdxJaGs8ic33
	hTZxnpOKvYhKFc8s132Yo4OHcVij7FQ6DcRblEymOVcJhhKXIxFRg2QuFMhLlH4oSGjmNA7aSIW
	UQFliXg3TL3VqjTIvoEMW9K6ioVutsuP6GJWw+VyTC4CH5X8ILaoCeeJv5C2U3OZw46ixDKPk2n
	hDZ7XCOEAPrT6VH88iohOaeeFnL2pe/EJ2EBsKTmwESo/EcQC8nNgp/cDEc/UpyRF59rTbfDJA/
	OBkJdcVKvfz49UzLkRJOJjAduuEiYpeT5mIfMhH9hVo1ErvABG+XXkWwgCt7e8P32OxP0yNTCyt
	D4fsi54yLkeJIM4U93vs3zNeYg+ZVNekxs1I+/5ug6FzPcCYPWBRVqzNHlln0=
X-Received: by 2002:a05:6a00:1812:b0:839:e27c:6cce with SMTP id d2e1a72fcca58-8420c1f58d8mr58757b3a.37.1779991189085;
        Thu, 28 May 2026 10:59:49 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d6eac68esm5749843b3a.15.2026.05.28.10.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 10:59:48 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com
Cc: jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>
Subject: [PATCH v2] HID: wacom: fix slab-out-of-bounds write in wacom_wac_queue_insert
Date: Fri, 29 May 2026 02:59:45 +0900
Message-ID: <20260528175945.2987781-1-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260524135203.1996265-1-jinmo44.yang@gmail.com>
References: <20260524135203.1996265-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255077-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jinmo44yang@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2B6A75F5FE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

wacom_wac_queue_insert() calls kfifo_skip() in a loop when the kfifo
doesn't have enough space for the incoming report. If the kfifo is
empty, kfifo_skip() reads stale data left in the kmalloc'd buffer
via __kfifo_peek_n() and interprets it as a record length, advancing
fifo->out by that garbage value. This corrupts the internal kfifo
state, causing kfifo_unused() to return a value much larger than the
actual buffer size, which bypasses __kfifo_in_r()'s guard:

  if (len + recsize > kfifo_unused(fifo))
      return 0;

kfifo_copy_in() then performs an out-of-bounds memcpy, writing up to
3842 bytes past the 256-byte buffer.

Add a !kfifo_is_empty() condition to the while loop so kfifo_skip()
is never called on an empty fifo, and check the return value of
kfifo_in() to reject reports that are too large for the fifo.

Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Fixes: 5e013ad20689 ("HID: wacom: Remove static WACOM_PKGLEN_MAX limit")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
Changes in v2:
- Instead of a size check at the top, add !kfifo_is_empty() to the
  while loop condition to prevent kfifo_skip() on an empty fifo
  (Suggested by Dmitry Torokhov)
- Check kfifo_in() return value to reject oversized reports instead
  of a separate guard

 drivers/hid/wacom_sys.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index a32320b35..489ca68f1 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -54,7 +54,7 @@ static void wacom_wac_queue_insert(struct hid_device *hdev,
 {
 	bool warned = false;
 
-	while (kfifo_avail(fifo) < size) {
+	while (kfifo_avail(fifo) < size && !kfifo_is_empty(fifo)) {
 		if (!warned)
 			hid_warn(hdev, "%s: kfifo has filled, starting to drop events\n", __func__);
 		warned = true;
@@ -62,7 +62,9 @@ static void wacom_wac_queue_insert(struct hid_device *hdev,
 		kfifo_skip(fifo);
 	}
 
-	kfifo_in(fifo, raw_data, size);
+	if (!kfifo_in(fifo, raw_data, size))
+		hid_warn_ratelimited(hdev, "%s: report is too large (%d)\n",
+				     __func__, size);
 }
 
 static void wacom_wac_queue_flush(struct hid_device *hdev,
-- 
2.53.0


