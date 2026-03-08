Return-Path: <stable+bounces-223442-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNdnGqMVrWlgyAEAu9opvQ
	(envelope-from <stable+bounces-223442-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 07:22:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C023622EACC
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 07:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CF3F3024948
	for <lists+stable@lfdr.de>; Sun,  8 Mar 2026 06:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C720731283E;
	Sun,  8 Mar 2026 06:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zav1hpQh"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499A127B343
	for <stable@vger.kernel.org>; Sun,  8 Mar 2026 06:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772950915; cv=none; b=cdasGv6VDTvYRf2g8BTxCGeF0UZ4Cf+QJ9QhGBF39y6qynmCHFavkVvdiDTxZ1/GUEepaepk+l1NDsDhkdsx4NJqUQoZgWmyJG0uD9Ns2da9p/CLKzf0qgt5fQSIVBLXjnn37vdqpBEnVadJisUr2khimKGCsXFQGpKgek4PET4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772950915; c=relaxed/simple;
	bh=aDfY1//oaZiGxwXobUZnkGalUh5IkzKrDN2WK4Aqvh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sKfkW/FAHXiIOgLDI/ak2obJcHxJ2fZJA58LyEh1R4i39r/2WBP1jfkCwOOECqxg4gJaITErp7ZvVARxIcg4cEk6M28whHrxgM7sT11Pzf70cPRttYKF33kFaSFdXw61W6kbNSWFB8WB37VyRxQz+iCyNdVXeHMKpmX7qiQktIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zav1hpQh; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-798527f822cso104953967b3.3
        for <stable@vger.kernel.org>; Sat, 07 Mar 2026 22:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772950912; x=1773555712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AVNaLXkn+wpKe98IsLDOvHFrwY+Zchd/o/Oq0a38lCQ=;
        b=Zav1hpQhTrL/0ouAZGxd4GYU6FrGQG5KqqOfYntbTlgHRnHUDu08mR/5G2mSN02Fvj
         g9Hp6OecFv2UUNXFyCjTetyWjEor6BnQXdO97ewpHznqKeXenPkHOveYFJKs3Wk6ri2Z
         MASswnqrOs402yguyi8I4cEutB8w5yWsk0S2O1EH5bGl7mcIOJybtuHE4q6trfXgheK8
         1Z4ga0FbWMvBpImNeP5JUS7M79rKYCIo41MO8szLoKCOtu+7mMu7U5f83ppYKCBEl9H3
         /Dy6qxoBac+o2nv4AqmTB8jRr8oGrARMx2GBGfNo+O29aH3NG5KleZdNEDrkVrGlouAn
         uOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772950912; x=1773555712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVNaLXkn+wpKe98IsLDOvHFrwY+Zchd/o/Oq0a38lCQ=;
        b=ICPga/5jzVkYkNUpbg5FGvnbPUOj94+xpIxNs7Hyl88DORstUz4AAVBR7pAKvQPMl6
         j4s4SOJEY30D9AYwwYs7rtTkT9Q54c7DRjrsCsd5mc2KO5ZWzQaAkulMjATKu6a7uTkq
         TtMcMCaQ/K4PfwMrZ+e6CzjTcFqPsEbzjbT3GYz83HaG4Q32ZuRd0cJBN0uVW/t7to7q
         5uLBKY61gjdl9N9TP8LDpZy99p+4MpeIklvDLiyypN7onrcBpPx+GDpm8sYduhI0Hp7q
         np4/N6UtHXu6VUBflYn7/eR/6VWCxkVObivPyxBz2W3tdCbgYD+zkAyJ/ahs4K6Tr1j5
         JTAw==
X-Forwarded-Encrypted: i=1; AJvYcCWJhhRwxX9yrh+BSGt2GOvWD/6zB7b3qjbNItfaDeiVFJ/ZqvQ3Et3IuTCOePRFmSKBb+rgcno=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY3dBSiHFOZs49opvxOyNuklM5i8IjkUHsWT56zAWHAuHWkhTv
	O1bPR5h4irw0vG4zpFo4D0eFzTVavSe6H8WiQcHq1BxUN/fCYOkLOgkK
X-Gm-Gg: ATEYQzwUUOoajIH9czVBVNEyoYWZsMJg6CmWwzkZpqw1QE8ZSiFPtEhinfG9w/tVx/6
	wUGTarA9cKgYGIwlVOnJV3sq7dXH7byQICWoHWfjXVhwUa1ZPRRdhc4tt/sL0p7gCforfBAcUrD
	yPOj2JHTA2QTCX4RiclyPxnzCC0ZnUUmmRo7Fs4IGLYZDhKgJtj7S9xD/vOuRsJ+ifSO8yqhFBQ
	580DsKzRO4CCCZTMLhlWvxiuDT5uNRm2Shj2Hr+NzdsLBeJ8d2iGRSW9TSGN8IBF1eqZPiMuvUM
	nHkPtvON+xTUgC0FZwwvKzFzAPVDJI2HgZUPYtb6SsS6JhYYL83cMv+VjaGxi8rnNalCtoWUQh8
	gMxGK6riq4sGo4WqY9vwz516lw7oIYYmNZV86fsKwUAdhl+HHAMXJ6xH+QV1E1n/TPD1on4dK/J
	69Us2ekrHVTbFy1/Rz3b2yth6Ck4Ejao4fPzTZhjWBWQm5cHAEof9c5AJBZpBvcA35IPk//pPbY
	YuK
X-Received: by 2002:a05:690c:c52c:b0:798:65ed:bb9b with SMTP id 00721157ae682-798dd688c7fmr67064417b3.27.1772950912232;
        Sat, 07 Mar 2026 22:21:52 -0800 (PST)
Received: from CS-396-Lab-Machine.. (c-24-12-10-127.hsd1.il.comcast.net. [24.12.10.127])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-798dee4a70bsm28803647b3.32.2026.03.07.22.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 22:21:51 -0800 (PST)
From: Tyllis Xu <livelycarpet87@gmail.com>
X-Google-Original-From: Tyllis Xu <LivelyCarpet87@gmail.com>
To: gregkh@linuxfoundation.org
Cc: arnd@arndb.de,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	ychen@northwestern.edu,
	danisjiang@gmail.com,
	Tyllis Xu <LivelyCarpet87@gmail.com>
Subject: [PATCH] misc: ibmasm: fix OOB MMIO read in ibmasm_handle_mouse_interrupt()
Date: Sun,  8 Mar 2026 00:21:08 -0600
Message-ID: <20260308062108.258940-1-LivelyCarpet87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C023622EACC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[arndb.de,vger.kernel.org,northwestern.edu,gmail.com];
	TAGGED_FROM(0.00)[bounces-223442-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[livelycarpet87@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.984];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,northwestern.edu:email]
X-Rspamd-Action: no action

ibmasm_handle_mouse_interrupt() performs an out-of-bounds MMIO read
when the queue reader or writer index from hardware exceeds
REMOTE_QUEUE_SIZE (60).

A compromised service processor can trigger this by writing an
out-of-range value to the reader or writer MMIO register before
asserting an interrupt. Since writer is re-read from hardware on
every loop iteration, it can also be set to an out-of-range value
after the loop has already started.

The root cause is that get_queue_reader() and get_queue_writer() return
raw readl() values that are passed directly into get_queue_entry(),
which computes:

  queue_begin + reader * sizeof(struct remote_input)

with no bounds check. This unchecked MMIO address is then passed to
memcpy_fromio(), reading 8 bytes from unintended device registers.
For sufficiently large values the address falls outside the PCI BAR
mapping entirely, triggering a machine check exception.

Fix by checking both indices against REMOTE_QUEUE_SIZE at the top of
the loop body, before any call to get_queue_entry(). On an out-of-range
value, reset the reader register to 0 via set_queue_reader() before
breaking, so that normal queue operation can resume if the corrupted
hardware state is transient.

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Fixes: 278d72ae8803 ("[PATCH] ibmasm driver: redesign handling of remote control events")
Cc: stable@vger.kernel.org
Cc: ychen@northwestern.edu
Signed-off-by: Tyllis Xu <LivelyCarpet87@gmail.com>
---
 drivers/misc/ibmasm/remote.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/ibmasm/remote.c b/drivers/misc/ibmasm/remote.c
index ec816d3b38cb..521531738c9a 100644
--- a/drivers/misc/ibmasm/remote.c
+++ b/drivers/misc/ibmasm/remote.c
@@ -177,6 +177,11 @@ void ibmasm_handle_mouse_interrupt(struct service_processor *sp)
 	writer = get_queue_writer(sp);
 
 	while (reader != writer) {
+		if (reader >= REMOTE_QUEUE_SIZE || writer >= REMOTE_QUEUE_SIZE) {
+			set_queue_reader(sp, 0);
+			break;
+		}
+
 		memcpy_fromio(&input, get_queue_entry(sp, reader),
 				sizeof(struct remote_input));
 
-- 
2.43.0


