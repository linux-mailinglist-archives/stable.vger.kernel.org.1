Return-Path: <stable+bounces-240337-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAaOOaDf6GmeRAIAu9opvQ
	(envelope-from <stable+bounces-240337-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 16:48:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8898C447741
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 16:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6947C307D593
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 14:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275DB3EDAB7;
	Wed, 22 Apr 2026 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6vQOg1G"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864A43ED5CA
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868955; cv=none; b=sFaUJkWQHz6zSD+hfG6/pVqYF2t8Tr14P5kLJdohZ3QVdtlg6jsgwRJ5YIp9fZc6r6Ehfy03IRjayLMTT/LU7Vs4YDpiKe8H8tL2TcD5zetuSShFn78lZQpZ4moA8DsqY12tnKT2d8oYJzztV4m+wiErox/LFRCr71PVCXJ+et0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868955; c=relaxed/simple;
	bh=6dGN6Sq4pulKWzbvWVOYJFY20pxbzEfT1MRlfUCn07E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XTEW/F9b+HGEafhhTCO8eJsTwVj6XxvIWFb/RR43FBYmv+Patw+ANph9TKbKJS/0D/+5UjzuMbhvr3ye0e/NTHlIvwtpPbMl8iVdZVmv6t2s7tlVZ61Udc14BauIMZergRenueS5HFVQRU4NQ37kyzm6zGRQ+PblqOh9n5DyFac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6vQOg1G; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso3917038a91.0
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 07:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776868953; x=1777473753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6BHaNKO4Vutd56sTBzf6LEct1U2PUWECXwrtGsxsQdI=;
        b=Q6vQOg1GD6sM9OURS7LFyoJU7tLASwZrHSIKTgqM/SNX1LqY0LFVtiLNFzIG3Q9Sbn
         Fe9nO8iZNPmjrZWvg23v1Nv3YWAOq6+47jt73IFZng0pcJM3Tp6LMRsr6NfAxOslt+Rg
         na4o/MdWZnza+XX616h7vvUGOfh3HEpsBxlIUVIPvoea6Xc5bN0wchDBScKn4RpHXoqe
         izK/Z+Fol7xq+jdLKRC/OjXecxOHozTgcF33Ey0bpozHfOf0o9+AYGq2/Jdoqu5Unz0i
         rXLLBUq8cNq14ZDFRgfSg+hUUkaeINycdKZtRmGyUl9SeUw/OTaMwiW5fHzyMBYshH7Y
         tvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776868953; x=1777473753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BHaNKO4Vutd56sTBzf6LEct1U2PUWECXwrtGsxsQdI=;
        b=TA0NJeq/B7o+d8kcDuEyIJKX74PLfYELH8N0iXVmWII6OMLNK/3nW8vUFFQJB84qLg
         BJV4fLRHTHEAxLGfBkQ06q9vFcAOzvNF4nn8oxxYDNHSrjLigXWjLldmaqzUISrUQrmd
         WcLPZjhIFDWeTfj4sI1e+iBiXut1aHMZQONEv08lucEgSuMr81VP8TmJgz6k7QKgDh/c
         EVVm/hLJqx3pOd0X+Sktbdn9tF/tSlvm1OOg0vBezu3WyYV7audLkvK3mMKOrTLXNCKg
         CY09lZ5YPwEyLJfHRNAk73snDvtCpRrOlLpWGG5SmSeaIl7ieu9G1rax/qEK8K6M9ZKy
         2pSQ==
X-Forwarded-Encrypted: i=1; AFNElJ8hSMCGsqzL0ergj8vHXDD2z7pVLm0vpbQVTdqLqh5QxrW70wonfTa3aPFsyikoP5Y+FRjnZj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqGcwZ9+M9G0hc3t1vaZKY0WUsLiYWbm8XX/46V0abNpkrlAa4
	/Bs4T7j8XaTHEwrboigbNxi/lzl9bcssRowJ5dvN4gycWvextkOg2G+R
X-Gm-Gg: AeBDieveDly0W/s/GnskpFduyEu2RK7JK2wptd0CRXjly5niVz0u2MPJQ9Guv4bvsw3
	k+mUpCrQLCe8P6C8Y1zFKFJv2Msn9A6g9NY10BwX6CluWyzreuI6/M549x+tT4OvglUCtZan+M5
	+7XRnDwCpFNQatvx+G0enI3H8XqBTeYsijHEG2fe972lRllXuyWUgqbE2HnLNhCFsoRu1QAKxov
	Y4CQNXdqVfbDFTcVQ3wr7mv7fhzJeLZe/hHxZgn9v8ca7Yowew0iWhILP9S1sNv+wAP7xc3pC65
	3ZGwpNpMwA4Hl1Or+aGf2/3zRqY3i5nfjLleEUq1at+BynLRlSNj+NEyOwAKwtuS6h/7Cu3Cy3I
	CCmqXOCXoXV2TVgyW3LTqGU2vlg37SUqJB3Hw+OHFWWjIeS3jdKVHjY8dGQPl6NRfBCO9+fpOSx
	wxIEI59IcvVRZUV/ZMcW+U8ApBPS3ZNpbpUMReTwXSBUr9c/cEuRmJOTB2bqpalFcZO5kIGm9E4
	V1R8n9Fy9W4C/H8hg==
X-Received: by 2002:a17:903:17cb:b0:2b4:6083:6c15 with SMTP id d9443c01a7336-2b5fa055a6bmr214881525ad.41.1776868952844;
        Wed, 22 Apr 2026 07:42:32 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:3191:a257:32a3:b02c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab20d33sm177878725ad.63.2026.04.22.07.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 07:42:32 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: mchehab@kernel.org
Cc: kees@kernel.org,
	peda@axentia.se,
	wsa@kernel.org,
	crope@iki.fi,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	stable@vger.kernel.org,
	syzbot+019ced393ab913002b75@syzkaller.appspotmail.com
Subject: [PATCH] media: rtl2832: fix use-after-free in rtl2832_remove()
Date: Wed, 22 Apr 2026 20:12:21 +0530
Message-ID: <20260422144221.25544-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,axentia.se,iki.fi,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240337-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,019ced393ab913002b75];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 8898C447741
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cancel_delayed_work_sync() is called before i2c_mux_del_adapters()
in rtl2832_remove(). While the cancel waits for any running instance
of i2c_gate_work to finish, it does not prevent the timer from being
rescheduled by a concurrent thread.

During probe, the r820t_attach() call attempts I2C transfers through
the mux adapter. These transfers go through i2c_mux_master_xfer(),
which calls rtl2832_deselect() after the transfer completes,
rescheduling i2c_gate_work via schedule_delayed_work(). If this
transfer is still in flight when rtl2832_remove() runs,
rtl2832_deselect() can reschedule i2c_gate_work after it has been
cancelled, causing a use-after-free when kfree(dev) is called.

Fix this by calling i2c_mux_del_adapters() before
cancel_delayed_work_sync(). Once the mux adapter is unregistered, no
new I2C transfers can go through it, so rtl2832_deselect() can no
longer reschedule i2c_gate_work. The subsequent
cancel_delayed_work_sync() is then guaranteed to be final.

Fixes: cddcc40b1b15 ("[media] rtl2832: convert to use an explicit i2c mux core")
Cc: stable@vger.kernel.org
Reported-by: syzbot+019ced393ab913002b75@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=019ced393ab913002b75
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
v2:
  - Fix Signed-off-by email address (lowercase k)
  - Add Cc: stable@vger.kernel.org for stable backport
---
 drivers/media/dvb-frontends/rtl2832.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/rtl2832.c b/drivers/media/dvb-frontends/rtl2832.c
index d8e1546aea5e..9898f729304a 100644
--- a/drivers/media/dvb-frontends/rtl2832.c
+++ b/drivers/media/dvb-frontends/rtl2832.c
@@ -1115,10 +1115,10 @@ static void rtl2832_remove(struct i2c_client *client)
 
 	dev_dbg(&client->dev, "\n");
 
-	cancel_delayed_work_sync(&dev->i2c_gate_work);
-
 	i2c_mux_del_adapters(dev->muxc);
 
+	cancel_delayed_work_sync(&dev->i2c_gate_work);
+
 	regmap_exit(dev->regmap);
 
 	kfree(dev);
-- 
2.43.0


