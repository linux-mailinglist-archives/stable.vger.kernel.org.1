Return-Path: <stable+bounces-270690-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3QwTLhKgRmrUaQsAu9opvQ
	(envelope-from <stable+bounces-270690-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:29:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C25486FB62D
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:29:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=oxa+8AH6;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270690-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-270690-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1351E30EE633
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBEC399D0B;
	Thu,  2 Jul 2026 16:26:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB70D390613;
	Thu,  2 Jul 2026 16:26:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009595; cv=none; b=tZGbHBI3+EMmoNgJb2rPDv43jwsrrP89ImltTufmMFSrrirvguBGl8pqOA4HObkUi2Oekvj0BlL7WzoXer+c2m86MfUsu7SPewDW6WVsOkSa9JxRljc6A3dW2EPPY0pT1KKdvMgloSpQazNrRiKNDCb7dmLIB7ja9CMxmzDraVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009595; c=relaxed/simple;
	bh=np2cT55dOCIUnanMG120/6QY0YP3+khTNUlxEB1XhIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJHtenuF9fsYJnpOalWjSMNPWVwOmbGTD8f2AkLVHmT0wXCtxRuWrwLCaFWXT0p0IvYB6D166/21t8w4Y+POD1NTLTG8qWjb498M5sHEum7yy4hImrKZM9F/nXJUCSALGxQdsL8PvSSZRSHU+syOnRc3jJkQEDSXEhChkgAP/Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oxa+8AH6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3731F000E9;
	Thu,  2 Jul 2026 16:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783009594;
	bh=TAPbiJThXImQJaSjLoUe4vQXao667D1die0gxkNRuAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oxa+8AH6yaiyspi9yy3LE0LTpLPlIEGvJOqHhlF354tkezaqC9MJ7V7AjwAG9lD1p
	 G0TdV4PidD8NmcWxpL+umfh3JQbO300su6QRL47XST3l6Q/WqrtGDfbIVHC2Jeqvsn
	 frKqlgodj+46dHJdaZuNjM5CE6QszhDAkdkff+lg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	Jean Delvare <jdelvare@suse.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 5.15 15/95] i2c: stub: Reject I2C block transfers with invalid length
Date: Thu,  2 Jul 2026 18:19:18 +0200
Message-ID: <20260702155109.527288730@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155109.196223802@linuxfoundation.org>
References: <20260702155109.196223802@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,asu.edu,gmail.com,suse.de,sang-engineering.com];
	TAGGED_FROM(0.00)[bounces-270690-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:xmei5@asu.edu,m:bestswngs@gmail.com,m:jdelvare@suse.de,m:wsa+renesas@sang-engineering.com,m:wsa@sang-engineering.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable,renesas];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,suse.de:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sang-engineering.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C25486FB62D

5.15-stable review patch.  If anyone has any objections, please let me know.

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



