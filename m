Return-Path: <stable+bounces-233302-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLKdAYyX0Wl4LgcAu9opvQ
	(envelope-from <stable+bounces-233302-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 00:58:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DCF39CCBF
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 00:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC9063004D13
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 22:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECBE36B06D;
	Sat,  4 Apr 2026 22:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZvERzFc"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34193612F6
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 22:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775343497; cv=none; b=UJnawXe/LItRw68DBbJSS5yhT8R7KAIE4A6TsXHjtCxP2ltGS4SJq3VWDGJ+QZ005sAPPjV1nnOFjeZ0io3SVh6uVIEk1w8GGrU+PaGzgTwsnXECp7xBz1QPoUkEXoXpqhnGREiuYLfjD1HdMc58cbLOKJbDbA/nCQUCTyw18Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775343497; c=relaxed/simple;
	bh=jGjQZBs0WdJOuCBt0m7HdHT/tOJU/5J/G4uFScR5Owg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dwQe4l1e0YoN1vj1jWdbT2S4XQyNzeNq3S6aY33cfaLxBc+YyrAEPhwrgXxebZ3fOx5DSzKMWLrNMIYOIeoG0izBfxq1NBIqoWHYjCKf4rdCAjNxt7syBdWicEBpyW4862RWqlKeWuYcpoX34fXZGt+Zlvm5ZsWWGDSZyFr3vQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZvERzFc; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56a9076813bso1177802e0c.3
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 15:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775343495; x=1775948295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tCgSx5WdM/i+Hg88DXCQUL/vgC4TdcSzM3NNt+8nb8Q=;
        b=aZvERzFcrGce73LP/QLLetPV4KsDnULCqrt/0U0h5t2A+RdpZ826rxLAcWukkOb88n
         BhXeH9/SUFAQRc0vsEP20geW2e8jj9JXcys6BXTZSMuQiP04hl4Jo0DIhk7Pz6hSfXvH
         GfPzdtxv/lSG49wRGX7snbUq/vi23R95sfztrNsmJP+xgyuKcKqu5iLL9wAhayQFuJXN
         OWJ9zqTfWmRHZXAM6E6P/KpBRz3W+yoRRJJ0qKeHETTtR5efJa0ghLDsOfUGdqUQzCIC
         ZheD72CH7drqaA08qMi8NHQJ/Rrf2bUeLFbBSfawkmyGhDqIsyoZgOBdh0SbFBITvUXf
         0PBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775343495; x=1775948295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCgSx5WdM/i+Hg88DXCQUL/vgC4TdcSzM3NNt+8nb8Q=;
        b=LnVPDybmwMWJvK/L577WnjtAJ10jUJwC1xMMVKPzHlMfcIPG5mXaSDedYbro6PtQJo
         QM1W23q2H9a1kpQZ/F2w9MIKBz55KNQzC0EF82eRDM+i9xRcJJ/USrqHWkrmOo7OY8TI
         t/BRE6au2856w97bChQSSrJ69FHFwkY48guPwMpwOdmtqr8jT1nmrjXFf7rAomgLdQrJ
         dDTPdLVkdXWmYYrclhif4aPNhfSzBx2bXzNypLI7AIzdZCTW1NYxzUwIIwpHRzgzAuVd
         utDq+Fd4V6UmOsDI2xNmzv4eH9EI29kEW1LDO0xZyslJVr6ILIvcMMcOmiDb5+OyQZXn
         hiLw==
X-Forwarded-Encrypted: i=1; AJvYcCWa/QfhPH82t1vR1MSjLEDQ2PAYh1DCLhdnkE20c73PIwdDQCwc7WMlv1CspAi6UJtP8mvPSQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrHlPhKo1Q4vxZ5dIZgogLAgZ0wcvbp2evgUR/dWhrT/oovk+k
	5ctKxV66vAoAw9sV7NV8yfCH+iTDqLkVwqLr8uZtKVH0We4keHrwtum7
X-Gm-Gg: AeBDies20kAsyK3AFqgmVrDxgVngWGsxLLBj64u0dyRVeObx3Cde5afORxOQUlXwHAs
	dXvKzP/Ji/vxJrDfm1MmTczrSlydkZBv7daxTz63KtGKXKpa9ySk3aoYj5ScS6C8PJ/yio3pTUL
	t6q9FmFBMwRsO2ftMKEieIYo0e4YCPV2NR6jbJvVbzDDGU7WYLBqEF5kBqZ7cXbv71LV7pgnXKn
	p2tCOsHpMTG/rqBEaIKdSnPQLGDtm3AU4fkvIGVdtvjnJi85dMNek87ad+EZSll+ubIATndhpvI
	P0D+Ma32LUCoN24HeCCrIReoAO9o1JGxb1iHm0fxhrnDyRHHPwgEwkAI8paMNb6pHu3o7q4+Yws
	izcAIfW9bNzKkCN2mdY0uVLoJJJ0DXPy3oN1/NZHJi3hZe85O9XG9OtmtCbk4Clnzx9d2Xr/ZnA
	NCHmQUFE87fXVB3splkuhnKJLu14wb8pHSb+aCizTG
X-Received: by 2002:a05:6102:5093:b0:605:4ff8:fc21 with SMTP id ada2fe7eead31-605a4e92bc8mr2314437137.8.1775343494660;
        Sat, 04 Apr 2026 15:58:14 -0700 (PDT)
Received: from localhost.localdomain ([102.244.98.15])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-60582e1d1edsm11692040137.1.2026.04.04.15.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 15:58:14 -0700 (PDT)
From: Delene Tchio Romuald <delenetchior1@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Delene Tchio Romuald <delenetchior1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: fix integer underflow in TKIP MIC verification
Date: Sat,  4 Apr 2026 23:57:52 +0100
Message-ID: <20260404225752.61297-1-delenetchior1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-233302-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[delenetchior1@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 96DCF39CCBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In recvframe_chkmic(), datalen is computed as:

  datalen = len - hdrlen - iv_len - icv_len - 8;

All operands are unsigned, so if the frame is shorter than the sum of
header, IV, ICV, and MIC lengths, the subtraction wraps to a very
large value. This corrupted datalen is then passed to
rtw_seccalctkipmic() and used as a pointer offset, leading to
out-of-bounds reads on kernel heap memory.

Add a minimum frame length check before the subtraction to prevent
the unsigned integer underflow.

Cc: stable@vger.kernel.org
Signed-off-by: Delene Tchio Romuald <delenetchior1@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 337671b12..8d3c6761a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -390,6 +390,13 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 				mickey = &stainfo->dot11tkiprxmickey.skey[0];
 			}
 
+			/* Ensure the frame is large enough for TKIP MIC verification */
+			if (precvframe->u.hdr.len <= prxattrib->hdrlen +
+			    prxattrib->iv_len + prxattrib->icv_len + 8) {
+				res = _FAIL;
+				goto exit;
+			}
+
 			datalen = precvframe->u.hdr.len-prxattrib->hdrlen-prxattrib->iv_len-prxattrib->icv_len-8;/* icv_len included the mic code */
 			pframe = precvframe->u.hdr.rx_data;
 			payload = pframe+prxattrib->hdrlen+prxattrib->iv_len;
-- 
2.43.0


