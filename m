Return-Path: <stable+bounces-268469-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F8zPNbsoPWqqyAgAu9opvQ
	(envelope-from <stable+bounces-268469-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:10:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6BB6C5F89
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:10:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=oRhKkGLf;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268469-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-268469-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6860C3062CB5
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E078429B77C;
	Thu, 25 Jun 2026 13:09:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F9F18FDBE;
	Thu, 25 Jun 2026 13:09:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782392956; cv=none; b=ErcD+A+bpMdMK2KPoLiNVK2vfzLn2WR6eiTolDMkPBuVJzFHuvvau9rvD79T6BleepPZZNiTKuhfv72aRlsWFxs5guh09d28lAmrr0qWINmQ+EJrRpclKsioHWXxncQ3BKUu78G1VMsj4flJF4C/vUP6g37dUQwFG1r2Vp1flwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782392956; c=relaxed/simple;
	bh=qDjIwXtuEtbNvbvyPCUbxuN5reWP62KKtPPDl6n6OK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=akTIY1xBiaQ71QnwBzrVr6cAI1EEmnw4a75Zd7AbnwN9cxfnToSp20jcmYYf9TQd/1Qhn2Rx6dcS6f+OPBALhDn33cP8L/1lWvgjs+tl6yaMtOrhvtc5MQGndcxeMHriQkC5ICCXdeVqHcDwG7Qyia8ancPRvKLIIVLrpeuW/ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oRhKkGLf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBAA11F000E9;
	Thu, 25 Jun 2026 13:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782392955;
	bh=ucxwV5DgkLGZ985cmM3SYdiJZuJdNgAjYoB9uh6tRvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oRhKkGLfnhPzTxM8TWcXiuzLy5uGR4TR3mc0TxJFteqirQewrOgjE0J30c+vq3Pg4
	 KWaH4LyUX1vo8FGpbAx+BL9h/XJVd4cQELO54jYz7WSOCqOmQ5o0GeTxIWKP9tVhCF
	 CMEtwOtkRVnSdHYipbDhxmyqAbUfTl19PYJFi670=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	Jean Delvare <jdelvare@suse.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 7.0 13/49] i2c: stub: Reject I2C block transfers with invalid length
Date: Thu, 25 Jun 2026 14:03:25 +0100
Message-ID: <20260625125639.370491945@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625125637.527552689@linuxfoundation.org>
References: <20260625125637.527552689@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,asu.edu,gmail.com,suse.de,sang-engineering.com];
	TAGGED_FROM(0.00)[bounces-268469-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:xmei5@asu.edu,m:bestswngs@gmail.com,m:jdelvare@suse.de,m:wsa+renesas@sang-engineering.com,m:wsa@sang-engineering.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,asu.edu:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sang-engineering.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B6BB6C5F89

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Weiming Shi <bestswngs@gmail.com>

commit 6036b5067a8199ba7a2dc7b377d4b9dd276d5f9e upstream.

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

Fix by rejecting transfers with data->block[0] == 0 or
data->block[0] > I2C_SMBUS_BLOCK_MAX with -EINVAL, consistent with
both the I2C_SMBUS_BLOCK_DATA case in the same function and the
I2C_SMBUS_I2C_BLOCK_DATA validation in i2c_smbus_xfer_emulated().

Fixes: 4710317891e4 ("i2c-stub: Implement I2C block support")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/i2c-stub.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/i2c/i2c-stub.c
+++ b/drivers/i2c/i2c-stub.c
@@ -214,6 +214,11 @@ static s32 stub_xfer(struct i2c_adapter
 		 * We ignore banks here, because banked chips don't use I2C
 		 * block transfers
 		 */
+		if (data->block[0] == 0 ||
+		    data->block[0] > I2C_SMBUS_BLOCK_MAX) {
+			ret = -EINVAL;
+			break;
+		}
 		if (data->block[0] > 256 - command)	/* Avoid overrun */
 			data->block[0] = 256 - command;
 		len = data->block[0];



