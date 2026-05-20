Return-Path: <stable+bounces-250691-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBUhMjQTDmoW6AUAu9opvQ
	(envelope-from <stable+bounces-250691-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:01:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3504F599098
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB4C437D68FB
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797893F0773;
	Wed, 20 May 2026 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jgl/Tx0j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC923EFD05;
	Wed, 20 May 2026 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296064; cv=none; b=sX5W8y1jfprgA7fr/9+tuWcBlK+Sz6q1lkL4Bc75SHbsumI8skh62Ra65BH9F0pH/qoRReUBrg7CI4Ji+nvmnoWlcT9h7+JYkrS3Iuy4hByTwEWuJmwxkG3hZKOASn7NDyNBw0Yw7FY9yXrbs2w0RJjLPbZSkmmZOPwg+Coq7hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296064; c=relaxed/simple;
	bh=dhEL3rfQmf7ynWk+wfisyLLUGNl8qcorjL/Rfc80ejg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzQDNkQLUaoJSRXc06HShWbOXZpo+qSfOshQt62NEMg3rV+1OsjMPq6BhGrFnx917ypJGbJRjpA/IxmBp61NxXKXRd+ulHHhsAfI/asVMYPqjstxJErmSragkiRxlYaPHGtASVyLC31HC0Mc5zsTXozkcfMS/zFw/hwYX5GRy3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jgl/Tx0j; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D0C1F000E9;
	Wed, 20 May 2026 16:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296063;
	bh=Ixg9ycwTXEJu3z4mKiChm9g/g1BH9UiiqiyJQ7YEkr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jgl/Tx0jtzCOnCAj7h++RuVlmNV+SK/4t22j2k9WjzHvNRzrhHL4YeazH+YCbPBx3
	 YcqEk5ExfMWa46k+m51vFYqh2U+gdgY2eyCzxQ9rgINo2twXvDvSWBT7oFIxqot6Bx
	 41llWfDpK2OY9wLXPytyYQDpcX4Gd16tWkP5WE+o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Frank Li <Frank.Li@nxp.com>,
	Felix Gu <ustc.gu@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0658/1146] i3c: master: renesas: Fix memory leak in renesas_i3c_i3c_xfers()
Date: Wed, 20 May 2026 18:15:08 +0200
Message-ID: <20260520162203.074248857@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,bp.renesas.com,nxp.com,gmail.com,bootlin.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250691-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,bootlin.com:email,renesas.com:email]
X-Rspamd-Queue-Id: 3504F599098
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

[ Upstream commit d7665c3b4f575251e449e2656879392346ca612b ]

The xfer structure allocated by renesas_i3c_alloc_xfer() was never freed
in the renesas_i3c_i3c_xfers() function. Use the __free(kfree) cleanup
attribute to automatically free the memory when the variable goes out of
scope.

Fixes: d028219a9f14 ("i3c: master: Add basic driver for the Renesas I3C controller")
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Link: https://patch.msgid.link/20260406-renesas-v3-1-4b724d7708f4@gmail.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master/renesas-i3c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
index d9f5b30a4b2f3..a8a9e89a9710a 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -8,6 +8,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/err.h>
@@ -817,13 +818,12 @@ static int renesas_i3c_i3c_xfers(struct i3c_dev_desc *dev, struct i3c_xfer *i3c_
 	struct i3c_master_controller *m = i3c_dev_get_master(dev);
 	struct renesas_i3c *i3c = to_renesas_i3c(m);
 	struct renesas_i3c_i2c_dev_data *data = i3c_dev_get_master_data(dev);
-	struct renesas_i3c_xfer *xfer;
 	int i;
 
 	/* Enable I3C bus. */
 	renesas_i3c_bus_enable(m, true);
 
-	xfer = renesas_i3c_alloc_xfer(i3c, 1);
+	struct renesas_i3c_xfer *xfer __free(kfree) = renesas_i3c_alloc_xfer(i3c, 1);
 	if (!xfer)
 		return -ENOMEM;
 
-- 
2.53.0




