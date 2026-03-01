Return-Path: <stable+bounces-221453-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AQLBBalo2mWJAUAu9opvQ
	(envelope-from <stable+bounces-221453-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:31:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 672591CDA56
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 529293150964
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFD3283C89;
	Sun,  1 Mar 2026 01:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCk3RkEe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E58280CD5
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328303; cv=none; b=tA4LzUy4//8WrGpGaAQBtw3dlhRnK01tc+ofRDsNV18W13q+Jb4W9gUif+k9cDl1RnDZwUEkRjnRgYPWp575X7qouKbw9wjyMbq3jPGeUx27zrP0ZkEdByu7/Ws58EZeQQS5IyGTJnoj8pe6QQ7pOHOtL41yLt1xleg0GOx+LJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328303; c=relaxed/simple;
	bh=qpRUClGLO2dK8Lpmzh5xNHHRA98E4G3FynbDbiBzp24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A7on8gLz1W5GNZgV1KljwMNbRINUvTW30in49kPQsh2YCaVcHzyP2Y8XxNQeDXSv2RuAm0/eHxTCEscSy680LwK5qg0SXh0KrxF/nLMfQmEDkQj/fqfhffwqcnOakSAKbt1AQHx/rNn1iB40nwgi7e9lJkxEsSCssVEKE9AKAJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCk3RkEe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAA3C19421;
	Sun,  1 Mar 2026 01:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328302;
	bh=qpRUClGLO2dK8Lpmzh5xNHHRA98E4G3FynbDbiBzp24=;
	h=From:To:Cc:Subject:Date:From;
	b=iCk3RkEeY97mBRwCeGGa4saxIOre47ahQd3YOquaUYnrpevKct5M9mx0LZKWotaby
	 rbWwVUNfRZwDNAOtWJMZgDOUf/rqLJ686oQ8H1znpyLIuwhVe10KGmRgdosyyKWXSD
	 g8zi9WHq3DAyIGFDVf0ixoX7v2XXyMnE8GiLSSRW4/83UFo+0ZO9mG5n5qpcpzA4Nr
	 mSTXoZrydzi/U6lYQOE4PV75z20q12TbLmW55+RFoTMgPX4ABWmCwV8wCvQPReOAz4
	 zf31FdKhpx6WV679F94W5uDPuJRt7Svqj2R46gctihOEbwyXK3M2KIMQaZrMLwOTsI
	 V7OXi5Jz0tTrg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	lihaoxiang@isrc.iscas.ac.cn
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexandre Bounine <alex.bou9@gmail.com>,
	Matt Porter <mporter@kernel.crashing.org>
Subject: FAILED: Patch "rapidio: replace rio_free_net() with kfree() in rio_scan_alloc_net()" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:25:00 -0500
Message-ID: <20260301012501.1682007-1-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,kernel.crashing.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-221453-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,crashing.org:email]
X-Rspamd-Queue-Id: 672591CDA56
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 666183dcdd9ad3b8156a1df7f204f728f720380f Mon Sep 17 00:00:00 2001
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Date: Wed, 21 Jan 2026 09:35:08 +0800
Subject: [PATCH] rapidio: replace rio_free_net() with kfree() in
 rio_scan_alloc_net()

When idtab allocation fails, net is not registered with rio_add_net() yet,
so kfree(net) is sufficient to release the memory.  Set mport->net to NULL
to avoid dangling pointer.

Link: https://lkml.kernel.org/r/20260121013508.195836-1-lihaoxiang@isrc.iscas.ac.cn
Fixes: e6b585ca6e81 ("rapidio: move net allocation into core code")
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexandre Bounine <alex.bou9@gmail.com>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/rapidio/rio-scan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rapidio/rio-scan.c b/drivers/rapidio/rio-scan.c
index c12941f71e2cb..dcd6619a4b027 100644
--- a/drivers/rapidio/rio-scan.c
+++ b/drivers/rapidio/rio-scan.c
@@ -854,7 +854,8 @@ static struct rio_net *rio_scan_alloc_net(struct rio_mport *mport,
 
 		if (idtab == NULL) {
 			pr_err("RIO: failed to allocate destID table\n");
-			rio_free_net(net);
+			kfree(net);
+			mport->net = NULL;
 			net = NULL;
 		} else {
 			net->enum_data = idtab;
-- 
2.51.0





