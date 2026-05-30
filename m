Return-Path: <stable+bounces-257559-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAtoOUAdG2qV/QgAu9opvQ
	(envelope-from <stable+bounces-257559-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:24:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 807D460F8E1
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F38B130591C2
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564523016E1;
	Sat, 30 May 2026 17:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GrSIU19S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B2F39A4A4;
	Sat, 30 May 2026 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161403; cv=none; b=YK+pKMJLNSZr5kGFFwo6/aPAo3qae7nHdGRrPYY/fW+Uq/7hs1Zfk3qQd1008NHCZRrANhEuhW6Fy8Hh6rYKWJacNLB2/ssEaV+S7EOm/2Ti7/ZD7rbWyudHULWbxCUmw6hfLCCfbEkApkHC8eU6kdR3tnnHvU7rbocT8XpdsA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161403; c=relaxed/simple;
	bh=VF2a+MDXaTnbBDHUu1gMs70fZ+AEgM0yqbEIV6FVfPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMB+6gPITW6Yhy/UmdV3nzIOxugaQzgTw0gHx7/EePddQ9TIvteAvuwtgyX+OJRH9Lzf501wOxN8ouF2sm/GYDFeXadfQKqgQetAPkeQRfe3Pnc+XRowJUZOReOnNeCq2ZyvuYCFnY/nd3aUcctkUUYo53gCD1HSZSyGW/v+yoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GrSIU19S; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680C71F00893;
	Sat, 30 May 2026 17:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780161402;
	bh=6IC6JysUlQI9RCPGzqqzMnWe50B3Z20H+LuYGLXOFrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GrSIU19SHkZo/aY8IIXgp5wv9maAJA6pEf++qhj3sJunsbRFlZbwFw+epfnR9rg7U
	 bQTtur14h+rCXVAC/2STms+FnC2+Th5V0pEOQ+FKUUqAsdqazJ2hdSG2YeUvb9j5Gp
	 OlD4dwi/l9OQnq5Pat+LoqCyoA3Ogs0zlTejoy8U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 614/969] mtd: parsers: ofpart: call of_node_put() only in ofpart_fail path
Date: Sat, 30 May 2026 18:02:18 +0200
Message-ID: <20260530160317.386474241@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257559-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 807D460F8E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

[ Upstream commit 0c87dea1aab86116211cb37387c404c9e9231c39 ]

ofpart_none can only be reached after the for_each_child_of_node() loop
finishes. for_each_child_of_node() correctly calls of_node_put() for all
device nodes it iterates over as long as we don't break or jump out of
the loop.

Calling of_node_put() inside the ofpart_none path will wrongly decrement
the ref count of the last node in the for_each_child_of_node() loop.

Move the call to of_node_put() under the ofpart_fail label to fix this.

Fixes: ebd5a74db74e ("mtd: ofpart: Check availability of reg property instead of name property")
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/parsers/ofpart_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/parsers/ofpart_core.c b/drivers/mtd/parsers/ofpart_core.c
index 3cf75b56d5a2e..110994b1e02f5 100644
--- a/drivers/mtd/parsers/ofpart_core.c
+++ b/drivers/mtd/parsers/ofpart_core.c
@@ -191,11 +191,11 @@ static int parse_fixed_partitions(struct mtd_info *master,
 ofpart_fail:
 	pr_err("%s: error parsing ofpart partition %pOF (%pOF)\n",
 	       master->name, pp, mtd_node);
+	of_node_put(pp);
 	ret = -EINVAL;
 ofpart_none:
 	if (dedicated)
 		of_node_put(ofpart_node);
-	of_node_put(pp);
 	kfree(parts);
 	return ret;
 }
-- 
2.53.0




