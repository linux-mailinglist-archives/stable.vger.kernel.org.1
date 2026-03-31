Return-Path: <stable+bounces-232326-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHWxHHMGzGn+NQYAu9opvQ
	(envelope-from <stable+bounces-232326-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:37:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F6C36F076
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8252A304AEE5
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89BB2D8771;
	Tue, 31 Mar 2026 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vuQHeDYu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE242D73AD;
	Tue, 31 Mar 2026 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976461; cv=none; b=fi7Gwkxwv3p0MBPJ3K10NI6EMXI10F4QxVpb6Gmqk9q8bTYj0F10bdmqpuRowrIK0xJ5xf7xE3hm3Cp5vNNnYiCey8yyF8L/5gLQzEO4vp3i/nS+5IzgC1boJ9ZhBY/1K42r1MQMx9Pj9q5e8DY3ZRARTukBV30NYx7oAY8gw6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976461; c=relaxed/simple;
	bh=fSgOWKpvljbrfLBu50YiU7RDOO828yILsr0VfchxCYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=grpyIvv/5J0NhcCBdgDfKlUy0DlCnFvn801uYNbUYotlQE5QClSc6zMwfX+IICxm9amnei6EyTi/enin0r5zW22w8C0MRscSQjy7fmD+VJGxEJU5Eo/VwoX3GCkxQHb0Lq4+pDRbNlgH1blUWLpxY2Cyauo5OUjNtyRfxSt5gQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vuQHeDYu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3083EC19423;
	Tue, 31 Mar 2026 17:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976461;
	bh=fSgOWKpvljbrfLBu50YiU7RDOO828yILsr0VfchxCYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vuQHeDYuN1FWI/JqGhm3LTKk3MSZ03Ma9M4P+H+sOJnabelvjQX2QP7B27JhtAlgp
	 QoGUeNFO4BFPivFl4qykbQZLGIAHtH7qyi85tLZUDMSY8VNkKbAaAIzrkEs3zcRqFI
	 BejDtMkMe6GiXQGDqVMxdZMZtu7NOfdvx2SbnLYY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Lubomir Rintel <lkundrak@v3.sk>,
	Randy Dunlap <rdunlap@infradead.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 102/309] platform/olpc: olpc-xo175-ec: Fix overflow error message to print inlen
Date: Tue, 31 Mar 2026 18:20:05 +0200
Message-ID: <20260331161757.242176029@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232326-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,msgid.link:url,infradead.org:email,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,v3.sk:email]
X-Rspamd-Queue-Id: 73F6C36F076
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alok Tiwari <alok.a.tiwari@oracle.com>

[ Upstream commit 2061f7b042f88d372cca79615f8425f3564c0b40 ]

The command length check validates inlen (> 5), but the error message
incorrectly printed resp_len. Print inlen so the log reflects the
actual command length.

Fixes: 0c3d931b3ab9e ("Platform: OLPC: Add XO-1.75 EC driver")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Acked-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://patch.msgid.link/20260310130138.700687-1-alok.a.tiwari@oracle.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/olpc/olpc-xo175-ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/olpc/olpc-xo175-ec.c b/drivers/platform/olpc/olpc-xo175-ec.c
index fa7b3bda688a6..bee271a4fda1a 100644
--- a/drivers/platform/olpc/olpc-xo175-ec.c
+++ b/drivers/platform/olpc/olpc-xo175-ec.c
@@ -482,7 +482,7 @@ static int olpc_xo175_ec_cmd(u8 cmd, u8 *inbuf, size_t inlen, u8 *resp,
 	dev_dbg(dev, "CMD %x, %zd bytes expected\n", cmd, resp_len);
 
 	if (inlen > 5) {
-		dev_err(dev, "command len %zd too big!\n", resp_len);
+		dev_err(dev, "command len %zd too big!\n", inlen);
 		return -EOVERFLOW;
 	}
 
-- 
2.51.0




