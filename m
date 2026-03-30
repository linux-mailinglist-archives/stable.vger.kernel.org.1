Return-Path: <stable+bounces-231000-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FJiD4D7yWmd3wUAu9opvQ
	(envelope-from <stable+bounces-231000-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 06:26:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DCA35545F
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 06:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 437933002310
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 04:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AAC35F615;
	Mon, 30 Mar 2026 04:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjmrFreO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D511E5724
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 04:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774844795; cv=none; b=U1+Mvrcc/FiMibZWZMUj+HwlOJxqO4um4sn5t+80PC75tbxEuMK6UBLgGnhD+DVmO12N28jpAe9NrfKrqvn3tZ0Rra/mhD8SLfhu73awQgNAOJqcQI2usif2bZcORb7RuBQ3+aDAYMQDxKGdQ8m2PdiXO6dTpq7O64nDbpi7GX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774844795; c=relaxed/simple;
	bh=Q0lXIsGDXKvyVl1kKXYekFT1SW45OJBuDcA3uYRJOSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OM14sDmdsgeO3f5sfK+rd/EuioJBMYYZQRoLoPFUVoF/nWb2PmX/EPPCZiedSaaTbljH5/qecpa1Ifn07Zvvlpl8jKByTCRklWM6qKjd78OS6wo/70yogMJy+LfjqmD4IEkvYifIE1AM1jrAsTq/XPKhaGHbg6GztRp4j6EOgqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjmrFreO; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35da9c0c007so394666a91.2
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 21:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774844793; x=1775449593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MEFziDjY8EELmDWMIHiwj21wEphahbqJkx5694Z88mI=;
        b=mjmrFreOzs/KKtXvpmv3SFAgzAueXOMYVtCbdwv1qCbBIvy0MP+kQvS5WZ7K3JzxMK
         6geErfuHk15M3KNVgf6qs8PfiPgezOBa+l2cq6p5h/08A7n6fsKcIEGkfy5PkZAj6qOZ
         fuZxhHgML35oYkYd8GTsvuw+bLS2c9r4/TCW0x5GcVFmpx/OxAABjDFZRsexjo3J0aoU
         Gkl5jqIycvh+OH3e9WlPFgCYwK22kMg2vugj8vGwSOBsYM7rwFhI1YToHLS5x5gIQoPU
         YCTX9BNdhSTxAmYtGqs5k77/R5ITUKWYkbYE0GJYjb5qtDWtnb+5H2Mi+NQvm/Qd/pTR
         nRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774844793; x=1775449593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEFziDjY8EELmDWMIHiwj21wEphahbqJkx5694Z88mI=;
        b=mqGu2ZLts27RZEY3vSDLdodN/iT055FZFo+3R5AruuirD63x3sYpb+/itNRDWwhJoU
         4FrmWaR44lg5lDJWYTCoRrGlHcoYKZkbYejn2ly+x53hf/wrzUickE9ew4/kDcmbWVgx
         LDTOnnuYxIr7vHMpILbw7WhdyRvVQeGgj4dANBDUIX4ICDY47BPz//pkxiXw2C/9eUNz
         9csHXcCMZSc5nScA/cqimzYkF8vzTVZNlhxBq87/hl56qF8V6Wi5QmG2X5ZUtQIdUbgc
         W1YW6zBDnyIPxNALaTOIAiwztKLgN8e59xIaf7aJ5uJq6HXcsTTsADSOMv4aXcPvn6sh
         LMyg==
X-Forwarded-Encrypted: i=1; AJvYcCUY16Cv12xvSbsLitqjRwDRr1T77i4ytU0k+v64EAc0d3MYPyCZ1oMxX9g+Ylrzfo2kwlDV5Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCVwWPW6C1crga4NqRpluCc34fZwgHVUvxuFfN4NtdId/OK+pT
	Zwo+3qr9fw4m7CR1FXV+/XWnwqTtMVskT8UD4FJw/myE4a1si66DH9r2
X-Gm-Gg: ATEYQzyFAHSzebq9ybFmWKidTQ7Dllxp2s1mHT7Oo2a59AM+fDVPKqq6wrTClZgBP0i
	9uGopJa/sQ9c0nNnT3ulc43B4WkQ4o90Vdeh/kIQlY+xCjh29L8RCkAVUjPjLHPH4BFNpGyUIqu
	Ng5q0sD+/eMgl930mQ12w8cGks6kkGoATYuOv0F+C10D6Hvxo0cdPRztIJTk3/EGKXXRgnegBvj
	FpEtPQFXXgpJGc1EzNcNrSrkeLT//SnrJbfp3CONns1qHpCQSs8uv+vKeNUdYI8A1YgnYOyUbX5
	C2Q2DumGThlIR7tgdC25WBz4Pzdw5BsydzuMqnCDEN6PiN3m7Ws2igPFy8m4gWi0Fs+nkEO9X0S
	KrYRlHPE64Luib3wWT4xNZLiAjOakgHUcri6wIVyu5l81XRrgY/Rjske/RoFgwkAhkHyEsiTXcW
	UlcKioXqOWcWFGw45Ent6qf9akndxMve1Q4GxIWMTjUR5E67CBpaoO8n8xUM9LdP1+iYwmfdqAE
	PDwtQMpqn7KvjjZU0TcG/U=
X-Received: by 2002:a17:90a:d410:b0:356:1db4:8fe5 with SMTP id 98e67ed59e1d1-35c30115629mr10183939a91.29.1774844793246;
        Sun, 29 Mar 2026 21:26:33 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c2eacff20sm4257584a91.3.2026.03.29.21.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 21:26:32 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Xiang Mei <xmei5@asu.edu>,
	linux-i2c@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] i2c: smbus: reject oversized block transfers in the common path
Date: Mon, 30 Mar 2026 12:26:22 +0800
Message-ID: <20260330042622.2608889-1-bestswngs@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[asu.edu,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-231000-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D2DCA35545F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The SMBus block transfer length data->block[0] is validated in
i2c_smbus_xfer_emulated() but that check runs too late for tracepoints
and is skipped entirely when the adapter provides a native smbus_xfer
implementation. This allows user-controlled oversized block lengths to
reach tracepoint memcpy calls and driver callbacks unchecked.

Add an early validation in __i2c_smbus_xfer() that rejects block
transfers with data->block[0] > I2C_SMBUS_BLOCK_MAX before any
tracepoint fires or driver callback runs. This is consistent with
the existing -EINVAL convention in the emulated path and protects all
downstream consumers at once: the smbus_write tracepoint, all native
smbus_xfer driver implementations, and the emulated path.

Two distinct bugs are fixed by this change:

Bug 1: smbus_write tracepoint OOB (include/trace/events/smbus.h)
  trace_smbus_write() fires before any validation and copies
  data->block[0]+1 bytes into a 34-byte event buffer. With
  block[0]=0xfe the tracepoint copies 255 bytes, overflowing by 221.

 BUG: KASAN: stack-out-of-bounds in trace_event_raw_event_smbus_write+0x27c/0x530
 Read of size 255 at addr ffff88800c8b7cd8 by task poc_smbus/86
 Call Trace:
  <TASK>
  trace_event_raw_event_smbus_write+0x27c/0x530 (include/trace/events/smbus.h:23)
  __i2c_smbus_xfer+0x43a/0xa40 (include/trace/events/smbus.h:91)
  i2c_smbus_xfer+0x19e/0x340 (include/linux/i2c.h:835)
  i2cdev_ioctl_smbus+0x38f/0x7f0 (drivers/i2c/i2c-dev.c:391)
  i2cdev_ioctl+0x35e/0x680 (drivers/i2c/i2c-dev.c:478)
  __x64_sys_ioctl+0x147/0x1e0 (fs/ioctl.c:52)
  do_syscall_64+0xcf/0x15d0 (arch/x86/entry/syscall_64.c:63)
  entry_SYSCALL_64_after_hwframe+0x76/0x7e (arch/x86/entry/entry_64.S:130)
  </TASK>

Bug 2: i2c-stub I2C_SMBUS_I2C_BLOCK_DATA OOB (drivers/i2c/i2c-stub.c)
  stub_xfer() implements .smbus_xfer directly and only clamps
  block[0] against 256-command, not I2C_SMBUS_BLOCK_MAX. With
  block[0]=0xff and command=0 the loop accesses block[1+i] for
  i up to 254, far past the 34-byte union.

 UBSAN: array-index-out-of-bounds in drivers/i2c/i2c-stub.c:223:44
 index 34 is out of range for type '__u8 [34]'
 Call Trace:
  <TASK>
  stub_xfer+0x1971/0x198f [i2c_stub] (drivers/i2c/i2c-stub.c:223)
  __i2c_smbus_xfer+0x306/0xa40 (drivers/i2c/i2c-core-smbus.c:607)
  i2c_smbus_xfer+0x19e/0x340 (include/linux/i2c.h:835)
  i2cdev_ioctl_smbus+0x38f/0x7f0 (drivers/i2c/i2c-dev.c:391)
  i2cdev_ioctl+0x35e/0x680 (drivers/i2c/i2c-dev.c:478)
  __x64_sys_ioctl+0x147/0x1e0 (fs/ioctl.c:52)
  do_syscall_64+0xcf/0x15d0 (arch/x86/entry/syscall_64.c:63)
  entry_SYSCALL_64_after_hwframe+0x76/0x7e (arch/x86/entry/entry_64.S:130)
  </TASK>

Fixes: 8a325997d95d ("i2c: Add message transfer tracepoints for SMBUS [ver #2]")
Fixes: 4710317891e4 ("i2c-stub: Implement I2C block support")
Cc: stable@vger.kernel.org
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
Changes since the initial submission:
- Moved the check from stub_xfer() into __i2c_smbus_xfer() so it
  covers all callers, not just i2c-stub. This also fixes a separate
  OOB in the smbus_write tracepoint that hits the same missing
  validation from a different angle.

 drivers/i2c/i2c-core-smbus.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index 71eb1ef56f0c..edb093687a4c 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -566,6 +566,15 @@ s32 __i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
 	if (res)
 		return res;
 
+	/* Reject invalid block lengths before they reach tracepoints
+	 * or native smbus_xfer implementations.
+	 */
+	if (data && (protocol == I2C_SMBUS_BLOCK_DATA ||
+		     protocol == I2C_SMBUS_BLOCK_PROC_CALL ||
+		     protocol == I2C_SMBUS_I2C_BLOCK_DATA) &&
+	    data->block[0] > I2C_SMBUS_BLOCK_MAX)
+		return -EINVAL;
+
 	/* If enabled, the following two tracepoints are conditional on
 	 * read_write and protocol.
 	 */
-- 
2.43.0


