Return-Path: <stable+bounces-249102-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WUskBeDWCWoDsQQAu9opvQ
	(envelope-from <stable+bounces-249102-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 16:55:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F43A561C10
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 16:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7F953008E0B
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 14:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACA132B99E;
	Sun, 17 May 2026 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6cISo2p"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D12328267
	for <stable@vger.kernel.org>; Sun, 17 May 2026 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779029721; cv=none; b=PK4jzO3aSdXKNE0TM5/r3UBtJLChMjSHop378DsoVR0NX0RS+D3gsDEhEOtylS6XT3pwsrUxbHAwWyDerJXGiwOHRlg3MzTY24eHMpV7FCTDz3N5xTQwauMbpE8pZGqhzW4nSMAOkyeDckj2J2JXYwuu/ziyJqfv0xIVlIpYAzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779029721; c=relaxed/simple;
	bh=i5BLItaK7oOYPrFOtKeP2AkbysLIvxhDNelq+76nRF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pn+0O3uoXES3wrS0G2LJuXPYCni+8lcgUP0JHeSQaFZq7wZ+3e3n45/F240/+qjYjsWh2dIbYJn9IFAYd2ahCwz9E9An0em9rqtE39nIa/Wu6yITQeuf0C6FuWOTcnpJtIYRslteVnUOgANNCry/Dmdgf4P/a4KTBlACrZi3Vj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6cISo2p; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48e82c23840so8830815e9.3
        for <stable@vger.kernel.org>; Sun, 17 May 2026 07:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779029719; x=1779634519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/l4dCK28Qtpju1OTSn9skmQqRPcoauwVCiaFA7ILGc=;
        b=X6cISo2pQ4YeGP/UrHyE5bt0efVaZfNSN0nAoEtFWPv/hqIzCkqfQKwTX2h6541PLF
         T4d9PuDBo0Ke55yFxVcF0o3K2Dd7NCRnGZP5h2KyRSLHPsTDmxrnpArjWT6s3aQ+fQwR
         uZEW283QuK6In4qDPAThr3SKwz2y1JW2m3ZJ9FhJTGvRRIAzUK3mkwxDyJ+b+Wohnre8
         v7J+3KT38uAzXJEiXCDqVodT0V1VxsMPQhO41/CD0QRkw5ViOfaYCDkIBPgWsGhegl7N
         +zdC7r0BxaLXcR7uXWcm5dQLEJHikmBYysKth98vLbcei0Niob32kuG3ASxrV1uA2G3o
         j9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779029719; x=1779634519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/l4dCK28Qtpju1OTSn9skmQqRPcoauwVCiaFA7ILGc=;
        b=PyqDTVPwpNAHwizd7oWO1kk7Lw2Ox9QrOnk6sBnCs1xnzyH2eQUlgeQwkDfeIK8Gfr
         7OEb+MTse4Ch5P3iZ1+z9lQs3xkiY2y65URpD/tQjwWpnSny+ixD5mgRSGaNPZPtyP/Z
         qBgFGzdB8NKZYISRVWqR1n6ledPdeB9MfTV36Vi4HfgZfIIK6okZ68Xgt5tzDc0NauEw
         fPVSBImb0vonF9x2m5uO5Lf/EZnqmnckGynWMPd6i0ZRjtmHXYic7lmCWLfEEFHbmbcE
         H5sti8HofhNDqSYvTkrUQF0U/GhsBi7LxKNw0iXvLutZbJf+6Fd6CQZsPJwo52VrlQID
         TmbA==
X-Forwarded-Encrypted: i=1; AFNElJ/AVBckF8f5sQNmSrAQZo6BBLFH0T5LnyCcLXZWboys6iIz3ewcZLkW+xVwEiQbVCMxXn5Q5MA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3pz9RgyLi2xWynGKWk9XRZetQ/rFGtZSA4EFpP6xvB/Ek+LMU
	7bjtK1NXggA30SC/b6SaDcjjEI2GAHniMVMHiAv7gFq885agJjXHi2EM
X-Gm-Gg: Acq92OE3e6oLBcXZLXP7XXe3gq58O4kXH1fW/cPEw0UWAc2DTA682dpFTmEiPUQEpOR
	wVA5/p2uRNeDrVkcppzgCQybgnFmkQQ38tVCIu6epN32xMA8mvVL7656ziPijE0d7U+cAaFXE8i
	RXc08BHo+JnLbH7LmsHDL9i6tlKySKwwhj1QNqhrXZ7yT7UJ0bBqn6DHiLG7ZAoNxsfvjpere39
	X7g0g4bB+GRfNjPW127+LCvYN7s4rz953pIEHPKd0lV/jxdXaVrB0HjhSqzKN54X2dDSTBPf79e
	DxhYDM7MP1p5yDzOAQ4S9NNmNkQRZrGjANY+XmQUgkSW/3QSMBfQqZuBx/BlsKOx2WpupftHVVz
	hRnXA1cAyCZZTxpgf4WKCmUfLvajrow7i/rc7EAgsKweUxUKBO9XNtglOesvv8HOaibdSZ5OZ+B
	bvZ5roKy/305qmIUDtdFEgxmdo3VW0TGZ13ej07aZmNMjAk90XhM8gCNBQqr75RqusOZqnlCUNF
	A==
X-Received: by 2002:a05:600c:8901:b0:487:1108:48b8 with SMTP id 5b1f17b1804b1-48fe60e367fmr150620875e9.2.1779029718624;
        Sun, 17 May 2026 07:55:18 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fead1c364sm62260885e9.8.2026.05.17.07.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 07:55:18 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	johan.hedberg@gmail.com,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] Bluetooth: SMP: add missing skb len check in smp_cmd_keypress_notify
Date: Sun, 17 May 2026 10:54:17 -0400
Message-ID: <20260517145417.31910-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5F43A561C10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-249102-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

smp_cmd_keypress_notify() accesses the received payload as
struct smp_cmd_keypress_notify without verifying that skb->len
contains enough data.

smp_sig_channel() removes the opcode byte before dispatching to
command handlers, so a SMP_CMD_KEYPRESS_NOTIFY packet without a
payload leaves skb->len equal to zero on entry to the handler,
causing a 1-byte out-of-bounds read from the heap.

Add a length check before accessing the payload and return
SMP_INVALID_PARAMS when the packet is too short, matching the
pattern used by other SMP command handlers.

Fixes: 1408bb6efb04 ("Bluetooth: Add dummy handler for LE SC keypress notification")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/bluetooth/smp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 98f1da4f5..4c98e2a3a 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2932,6 +2932,9 @@ static int smp_cmd_keypress_notify(struct l2cap_conn *conn,
 {
 	struct smp_cmd_keypress_notify *kp = (void *) skb->data;
 
+	if (skb->len < sizeof(*kp))
+		return SMP_INVALID_PARAMS;
+
 	bt_dev_dbg(conn->hcon->hdev, "value 0x%02x", kp->value);
 
 	return 0;
-- 
2.54.0


