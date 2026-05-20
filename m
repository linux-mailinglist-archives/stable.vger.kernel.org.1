Return-Path: <stable+bounces-250694-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PkhIk72DWry4wUAu9opvQ
	(envelope-from <stable+bounces-250694-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:58:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF8259504C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 574EA354A3A0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EAC3F54CB;
	Wed, 20 May 2026 16:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I+8S5Rja"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BFC3F4DE7;
	Wed, 20 May 2026 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296072; cv=none; b=Sz7MJ4mB6CQEwRHT3k805Ef0Xzma0DHWrOyyFPcVZw+Q9AV8x9qzF4zFUC5C/sSt1aGCNKGFdHiUAM5hyOlqm8nCES5+ihSCddfBJzk3fUOqkdJfaU2HcgloNQxfIjYgYfjRWjQgfjHKPYbF3oxaXvSzJ6J/Vxq76U//DGpRPmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296072; c=relaxed/simple;
	bh=Zfl/dpqpP28dgEiIVhnylYzaMa5k6iFeJ1223SQ45p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ti3hRneWZkU62iQWP0ZPHEJcBFm5LXWeWXPcDLbbMrkx1AzMDQA2jahw1Jqd9T51RUcRECl7iAFtNWcM6DPhFQ3O7CmZsV225fmzrgz82ndDv3uii/wOTwkBARoFFV1R7eWYbC2uPKSAu28zvsuMlnf0Kx7CdGsCrZPek6DD8bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I+8S5Rja; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717351F000E9;
	Wed, 20 May 2026 16:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296070;
	bh=zMcplKZhU0g6oxkGfNZPKeIqrOilLuQ6cmgWL+J2B7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I+8S5Rjajkwo/L0W9qfFzpaAIDkzBD8nudnWyQA4pHXcpH18O4FVk2MoRUUK/4pE0
	 3nr99Pl7Q6pc9wRWoTymyKO0toEQ6fWV4fX+htGcVQ4Rc0cAsUF61ZsgH5HcaaGwis
	 JWvAszCpf4V6XAMtIRU0sitCkWtBmv7JSTRXvMj0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jorge Marques <jorge.marques@analog.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0661/1146] i3c: master: adi: Fix error propagation for CCCs
Date: Wed, 20 May 2026 18:15:11 +0200
Message-ID: <20260520162203.144201424@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250694-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,msgid.link:url,nxp.com:email]
X-Rspamd-Queue-Id: 5EF8259504C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jorge Marques <jorge.marques@analog.com>

[ Upstream commit 0b73da96b6eb6b9354654f96a9d423ab22cb222d ]

adi_i3c_master_send_ccc_cmd() always returned 0, ignoring the transfer
result populated in the completion path. As a consequence, CCC command
errors were silently dropped, including the default -ETIMEDOUT and
later overwritten by adi_i3c_master_end_xfer_locked().

Fix this by returning xfer->ret so that callers correctly receive any
transfer error codes.

Fixes: a79ac2cdc91d ("i3c: master: Add driver for Analog Devices I3C Controller IP")
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Jorge Marques <jorge.marques@analog.com>
Link: https://patch.msgid.link/20260323-ad4062-positive-error-fix-v3-5-30bdc68004be@analog.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master/adi-i3c-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/adi-i3c-master.c b/drivers/i3c/master/adi-i3c-master.c
index 6616f751075ae..545ddd79a45db 100644
--- a/drivers/i3c/master/adi-i3c-master.c
+++ b/drivers/i3c/master/adi-i3c-master.c
@@ -361,7 +361,7 @@ static int adi_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
 
 	cmd->err = adi_i3c_cmd_get_err(&xfer->cmds[0]);
 
-	return 0;
+	return xfer->ret;
 }
 
 static int adi_i3c_master_i3c_xfers(struct i3c_dev_desc *dev,
-- 
2.53.0




