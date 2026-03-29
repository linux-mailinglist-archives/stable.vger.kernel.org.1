Return-Path: <stable+bounces-230966-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHqqA1RXyWkuxgUAu9opvQ
	(envelope-from <stable+bounces-230966-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 18:46:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BF23531F0
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 18:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAF46301413D
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 16:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DC53806D7;
	Sun, 29 Mar 2026 16:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4RciwCj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4263806A3
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 16:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774802535; cv=none; b=pQ8z48l3x1alri0Lx8kuIOlZ+LsVAqpEgdI09Pf53yI3ViD3cBCbBG7Fked98ObjCb5t/nopx0Vb0S6BTCn0lpg7PcqVL7UtcXxHuuczm/53UxvDv1TpRjFLxRs6B1v/3H0vehke3HCHdTtEIk6xrVFYsmrjND1f47+qqEqcU8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774802535; c=relaxed/simple;
	bh=2dXv0nAmkiJYZS9eDr+LvkacZkKKtj06sR29apGbOlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GXcZiCLeDdAxF88LZUtzlEkuQm5MgoAV9U4B/UVzV95y35T5hTQl9xTaJpkssMnYUWQ0VMlDoVxIEoFr54w297LjQNtklSNe1mElchI01wX+lAlmHH+t1gO0Ahu/2UUzs15PEByOh6NCb4uYO6FX1kMIowVJ80kpxi8baVpfhkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4RciwCj; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c766cf593daso2674534a12.3
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 09:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774802533; x=1775407333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/VkDaEIdx6Ux33QpjDJoUSEWWsuae4zX/E6ZQCjaiTQ=;
        b=F4RciwCjvn/pHxGD62ig0g0o86nHs95fXMGst5NFVwggi4MpTufD5MoqeaWirlzDPn
         IpzfjxMQn7BL+6ZfrzUE/69g4E/7YMGmlr/GBFbU3CGKAAWWVFfstPAj+a/efgkbwzMR
         shzSK2/bDDF/x1yPG+fv9Ntw35y9DiCapUHtiQG3Sy3m1uHGtDKquwjP+G0sjmr4PxEu
         viWfvwaWud+3FwT4FdlYGw4hjprjrZ+t3+j9px9DahIwzEspzlypY7vyS036cUYyFaEn
         VjH40wuTHuC4O4kC5kBetHd9HrLcpfrNCd/gL0IozAGd5j5VKSRKfZDfGOQSZi68iRGa
         KLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774802533; x=1775407333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VkDaEIdx6Ux33QpjDJoUSEWWsuae4zX/E6ZQCjaiTQ=;
        b=mJhyoocWltNOiKLfNazyxNW0YHQQZ/6CUSr/Ffgy3jTfH436xXRw/AkUQpLmNG7KAd
         uoGZSyCXFkj0Z1yaY5yBAIet4DrHIuhY53J9TRKOxpvvHVVeAQs8prJKeftcOV4RIOYc
         fSIJ+2ziyHlHjqnQKVFcIdT4uD+L8x+OtQeMpxD/KOsLuT+jQr8k8oNg2p/ZH22JKFrU
         zA863DPQkvIFXnwle9ppRDt1s3kYIQ1d5pr0CP8iDVJts2t6Fi+3DoTZ97p9WtRBn6/M
         8JtelWjO0U+5Eg/qlxFzHcAf6Cb3dtDn3XsqMUoOGaOkG4J8xXlVeww+WBedWFbummAm
         +SYg==
X-Forwarded-Encrypted: i=1; AJvYcCW+mHTRv0Qa+195v6TnofLzstU7IDJ5ipLp2p3yVHAQETZ87DpdTS6ZtfLDns9MGV5gZl24hws=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUr5ijA7sht+CFDJz6oW8kXM/7jhCMZe94OyRRkSBBhl7l6DYS
	qdXXltqBJWadR84Sp/qs4eXD4jgYD053fcG3uuz9MRd0+bfPaH61RHBp
X-Gm-Gg: ATEYQzxsflB0kesH36Lb1PnBH4BEESNej1KAbR29pXsFEaEmsfYhp+iQ4/PXNhsfiXs
	kXYEFsiJXU2jodJvbKBmLvJI65Gejfcw5giFSfK0Qu0wLx9mEv02qc4XRJ6zn9Yvczp6fWcktkM
	QOnSHdMHDPmV/6WF707/3L//GZm+Zoy5yqYIdxe3Zs9cmpXmZ7XPYR+PXdWx9CjKMBsoVEAYps8
	nj0PgYQEnq0Qsn/qx3Kz0dC2tQr7Fu+CDKCbE03xmUI3pgyvl9jSQnghS4dDlAD9DlaV+xHOzQ/
	tQXukxGGiRJpT6i9f3Z8mZbofRLvkrWcZDiVAmud+mkuH80VJHqHXMyGNwjTUv7cCawgU9/ijnW
	TxxBQLKJyoGKVcpGSYk9pugi9DryxEsu+/f3f35Wkv29HWsdL2nYZoizSEPkgPqJ4Lc/KxXNw8d
	3N6TzzpnE2e2/2SycEZN9E4tA9eKAQHzZMBjE3iWg54emULQfnpBQp1dcKKarpgGPLlLiZH+9WF
	083tizY6zMi
X-Received: by 2002:a05:6a20:7d9b:b0:39b:e321:784e with SMTP id adf61e73a8af0-39c87c40488mr9199781637.60.1774802532982;
        Sun, 29 Mar 2026 09:42:12 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76917db770sm4015782a12.32.2026.03.29.09.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 09:42:12 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jean Delvare <jdelvare@suse.com>
Cc: linux-i2c@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: stub: Reject I2C block transfers exceeding I2C_SMBUS_BLOCK_MAX
Date: Mon, 30 Mar 2026 00:41:27 +0800
Message-ID: <20260329164126.820797-2-bestswngs@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,asu.edu,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-230966-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B2BF23531F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The I2C_SMBUS_I2C_BLOCK_DATA case in stub_xfer() uses data->block[0]
as the transfer length. The existing check only clamps it to avoid
overrunning the chip->words[256] register array, but does not validate
it against I2C_SMBUS_BLOCK_MAX (32), which is the limit of the union
i2c_smbus_data.block buffer (34 bytes total). The driver is a
development/test tool (CONFIG_I2C_STUB=m, not built by default)
that must be loaded with a chip_addr= parameter.

A local user with access to /dev/i2c-* can issue an I2C_SMBUS ioctl
with I2C_SMBUS_I2C_BLOCK_DATA and data->block[0] > 32, causing
stub_xfer() to read or write past the end of the union
i2c_smbus_data.block buffer:

 BUG: KASAN: stack-out-of-bounds in stub_xfer (drivers/i2c/i2c-stub.c:223)
 Read of size 1 at addr ffff88800abcfd92 by task exploit/81
 Call Trace:
  <TASK>
  stub_xfer (drivers/i2c/i2c-stub.c:223)
  __i2c_smbus_xfer (drivers/i2c/i2c-core-smbus.c:593)
  i2c_smbus_xfer (drivers/i2c/i2c-core-smbus.c:536)
  i2cdev_ioctl_smbus (drivers/i2c/i2c-dev.c:391)
  i2cdev_ioctl (drivers/i2c/i2c-dev.c:478)
  __x64_sys_ioctl (fs/ioctl.c:583)
  do_syscall_64 (arch/x86/entry/syscall_64.c:94)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
  </TASK>

The bug exists because i2c-stub implements .smbus_xfer directly,
bypassing the I2C_SMBUS_BLOCK_MAX validation in
i2c_smbus_xfer_emulated(). The I2C_SMBUS_BLOCK_DATA case in the same
function correctly validates against I2C_SMBUS_BLOCK_MAX, but the
I2C_SMBUS_I2C_BLOCK_DATA case does not.

Fix by rejecting oversized transfers with -EINVAL when
data->block[0] exceeds I2C_SMBUS_BLOCK_MAX, consistent with both
the I2C_SMBUS_BLOCK_DATA case in the same function and the
I2C_SMBUS_I2C_BLOCK_DATA validation in i2c_smbus_xfer_emulated().

Fixes: 4710317891e4 ("i2c-stub: Implement I2C block support")
Cc: stable@vger.kernel.org
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/i2c/i2c-stub.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/i2c-stub.c b/drivers/i2c/i2c-stub.c
index fbb0db41b10e1..349ef9fb2fdbc 100644
--- a/drivers/i2c/i2c-stub.c
+++ b/drivers/i2c/i2c-stub.c
@@ -214,6 +214,10 @@ static s32 stub_xfer(struct i2c_adapter *adap, u16 addr, unsigned short flags,
 		 * We ignore banks here, because banked chips don't use I2C
 		 * block transfers
 		 */
+		if (data->block[0] > I2C_SMBUS_BLOCK_MAX) {
+			ret = -EINVAL;
+			break;
+		}
 		if (data->block[0] > 256 - command)	/* Avoid overrun */
 			data->block[0] = 256 - command;
 		len = data->block[0];
-- 
2.43.0


