Return-Path: <stable+bounces-244746-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKxcOknS/Wl2jgAAu9opvQ
	(envelope-from <stable+bounces-244746-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 14:08:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BB04F61F6
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 14:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A60C830847B7
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 12:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B415D3DCD9C;
	Fri,  8 May 2026 12:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMfEh/EF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3FB3DBD49;
	Fri,  8 May 2026 12:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778241974; cv=none; b=dkJdap2O+1W5GeRPoSR2dF8j68POIO+XS5JXNWRbOzgt/5Z8rkHasR1PrEYG4kKVcxiyLDajPbDUAtssKXhl/PrFbMDiKJ5XLsSWEQCJ0q48uKq24Fnp8cjGK4+TdJMS1Etz/zcJpRCkhcgriU76FxFnhcNfXKBSCtHj5zrY9O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778241974; c=relaxed/simple;
	bh=7G+u2+a/dXZoaDQTY5dnH4LBsmqRbd5whI/r+XNorKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nbi9nxX+Tziau9EHbkVDXOjedaNIAUb11xgUxJTERgAnMVOhBoJApXKmUWjDpZXrklRoLs7ih/QUJ81V23lUMeUWmIOTuYbgDMQET3eLsu8M66v+fD2L7QHKftPl++pYZC47x024Fn5iW3N0rVnGrQFVUnShIfCOrWzz31NK5L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMfEh/EF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D612FC2BCC7;
	Fri,  8 May 2026 12:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778241973;
	bh=7G+u2+a/dXZoaDQTY5dnH4LBsmqRbd5whI/r+XNorKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rMfEh/EFH/5ge54Z0YC7OQ/4GHG5QRu7gNJtzQAI3anSq2ATDBVxJ4ndFVXannRQv
	 CWRRCXrUipE/pAFgBKL315RLc7SB80k72MlyMftTEefy0oLlI7IZjcHJrMLxSTAgln
	 tOWGzBGOef9VWIRE76wxjWGFToQSuPsd8RL9nVBR41IiebW8lboPp5k5bgeAzOvz8W
	 olBt3QGz36aNoQcY8bjJR9IlUbHU/GFfIcJHIjQB+NLb+jV7oBZii+Y+KqYGnKE+JI
	 JtE+VJLAcNkEeCMS6TWtEEeAfxQrcQFhQHWk71WpL9LYzmHycX6nkcnGdomsY85cng
	 vv+3awvgp28gQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wLJy7-00000001mrC-2uGV;
	Fri, 08 May 2026 14:06:11 +0200
From: Johan Hovold <johan@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Magnus Damm <damm@igel.co.jp>
Subject: [PATCH 1/2] sh: kfr2r09: fix i2c adapter leak on USB gdaget setup
Date: Fri,  8 May 2026 14:06:00 +0200
Message-ID: <20260508120601.426115-2-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508120601.426115-1-johan@kernel.org>
References: <20260508120601.426115-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 74BB04F61F6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244746-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,igel.co.jp:email]
X-Rspamd-Action: no action

Make sure to drop the reference taken to the I2C adapter (and its
module) when enabling USB gadget mode which prevents the adapter from
ever being deregistered.

Fixes: 5a1c4cb5bc22 ("sh: add r8a66597 usb0 gadget to the kfr2r09 board")
Cc: stable@vger.kernel.org	# 2.6.32
Cc: Magnus Damm <damm@igel.co.jp>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/sh/boards/mach-kfr2r09/setup.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index 70236859919d..62af9a9db039 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -368,7 +368,7 @@ static int kfr2r09_usb0_gadget_i2c_setup(void)
 	msg.flags = 0;
 	ret = i2c_transfer(a, &msg, 1);
 	if (ret != 1)
-		return -ENODEV;
+		goto err_put_adapter;
 
 	buf[0] = 0;
 	msg.addr = 0x09;
@@ -377,7 +377,7 @@ static int kfr2r09_usb0_gadget_i2c_setup(void)
 	msg.flags = I2C_M_RD;
 	ret = i2c_transfer(a, &msg, 1);
 	if (ret != 1)
-		return -ENODEV;
+		goto err_put_adapter;
 
 	buf[1] = buf[0] | (1 << 1);
 	buf[0] = 0x13;
@@ -387,9 +387,16 @@ static int kfr2r09_usb0_gadget_i2c_setup(void)
 	msg.flags = 0;
 	ret = i2c_transfer(a, &msg, 1);
 	if (ret != 1)
-		return -ENODEV;
+		goto err_put_adapter;
+
+	i2c_put_adapter(a);
 
 	return 0;
+
+err_put_adapter:
+	i2c_put_adapter(a);
+
+	return -ENODEV;
 }
 
 static int kfr2r09_serial_i2c_setup(void)
-- 
2.53.0


