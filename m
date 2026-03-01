Return-Path: <stable+bounces-222388-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNoZFu6ho2mRIwUAu9opvQ
	(envelope-from <stable+bounces-222388-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:18:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 667A61CD6AB
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D76233081AB3
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 02:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025D730595C;
	Sun,  1 Mar 2026 02:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vxc6f2su"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA136273D77;
	Sun,  1 Mar 2026 02:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330753; cv=none; b=Aon3siv4Y3oamuCVXsrvzaO5yYeaK6zzA553UQJwXmPgKObp/CwCnS52ivaErYlV/5nWPZVs4nE6Hdsz6vFRQY61ygVYZ229KAhjpHhPvzkn0iK6nH1UTmkb7DJMasN/nQi46mwsxJms1N3A0TXmeRGnr4VPnaBLnDaQV/knGUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330753; c=relaxed/simple;
	bh=KgQCxdZohFyJ8LaaVOXU0cS1MeqPQQt5jSy9Q7V3Ed4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k/GEhK41U9ZwF5sqKUQDQzkPHaUL+CDcXAfSdZHjAfjpHmh0y0AuhUeXgmFqdZY0mSGco+oZu/KmKg7VrfLxoMfJWmrcfesphBk6H5tOHRhasuk7TgzDFpTc5SwQOfjDujy5fRbNyMBPTQxapPr/AOcHenDZOgeIvtPFcmQOqLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vxc6f2su; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EF3C19421;
	Sun,  1 Mar 2026 02:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330753;
	bh=KgQCxdZohFyJ8LaaVOXU0cS1MeqPQQt5jSy9Q7V3Ed4=;
	h=From:To:Cc:Subject:Date:From;
	b=Vxc6f2suvQPgblquw4c/IY+g/sXf31iGNapUdLEXyqldHOv63sU4OkUAju2Jz1JP0
	 hFcBSIFZs5eiVn+tiIiyTbDhV0PZRTKzSPkOVZWGM8K0a+3k5V2ggPSwPWpLpa2DH8
	 7FDSpHvi7L1MXl746e6BAuHhE3ApDejXpPgW/MrnvkovJzaS+FNc59hxD1PpqCZziH
	 AbY4Ox2g+0DSTJlsqj3pzxaDo6DDr02A2iKvtTyy+A4QVohkgjnMSmB4fapNzCLjD2
	 Qoa9w5bNt9Ae7tIEoNtDjH2wiqN1YFRfatjxlwpeC48ctbbh5tdZyRD+g2/gcprwM7
	 gMrWArHDQ2yWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	den@valinux.co.jp
Cc: Frank Li <Frank.Li@nxp.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jon Mason <jdmason@kudzu.us>,
	ntb@lists.linux.dev
Subject: FAILED: Patch "NTB: ntb_transport: Fix too small buffer for debugfs_name" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 21:05:51 -0500
Message-ID: <20260301020551.1734713-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222388-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email,intel.com:email,kudzu.us:email]
X-Rspamd-Queue-Id: 667A61CD6AB
X-Rspamd-Action: no action

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6a4b50585d74fe45d3ade1e3e86ba8aae79761a5 Mon Sep 17 00:00:00 2001
From: Koichiro Den <den@valinux.co.jp>
Date: Wed, 7 Jan 2026 13:24:57 +0900
Subject: [PATCH] NTB: ntb_transport: Fix too small buffer for debugfs_name

The buffer used for "qp%d" was only 4 bytes, which truncates names like
"qp10" to "qp1" and causes multiple queues to share the same directory.

Enlarge the buffer and use sizeof() to avoid truncation.

Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
Cc: <stable@vger.kernel.org> # v3.9+
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
---
 drivers/ntb/ntb_transport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index a7dd983adf7b0..50f3b1f1b9262 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1252,9 +1252,9 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	qp->tx_max_entry = tx_size / qp->tx_max_frame;
 
 	if (nt->debugfs_node_dir) {
-		char debugfs_name[4];
+		char debugfs_name[8];
 
-		snprintf(debugfs_name, 4, "qp%d", qp_num);
+		snprintf(debugfs_name, sizeof(debugfs_name), "qp%d", qp_num);
 		qp->debugfs_dir = debugfs_create_dir(debugfs_name,
 						     nt->debugfs_node_dir);
 
-- 
2.51.0





