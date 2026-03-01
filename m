Return-Path: <stable+bounces-221711-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KL9PLayYo2neHgUAu9opvQ
	(envelope-from <stable+bounces-221711-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:38:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 501FA1CB398
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1771B302B18F
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B712EA498;
	Sun,  1 Mar 2026 01:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HO0ANwvQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9972C11DE
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328954; cv=none; b=CmGLKiIydiMPqNQJHpiMctcJRLg97cYaM12QRZSu9vLeuzzPSqh5YontNNZNkzaXFf/c0Rskoye0RAPEOV5FotFUTgPzjwQH9dhJLTGDAXAN4KTAUBmHljieQfllSqec004atBg+qAJ6nMgngF5oTKSItRsBPh2sLH7DfPSoGEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328954; c=relaxed/simple;
	bh=ohj4DoCarwyjJRCMadR2LGn2TfMpTMhKMWSsqNw+PLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=omuyjBCEkZSc1C1WAkwN9/U4Nc883jpPyy7jt0oe8HqTZMvjzcR6IWUjAQ/U7/dnl3nXGFKx4u22jw3qy1KUmZE6jUuchHaYw8wyVrE6fVcD8LEumPPxT4BFuxtH3nxmZOnyfU5q0w8Ymc1RwaHN9muay8OfxhXmGhQqeGPN8OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HO0ANwvQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADB2C19421;
	Sun,  1 Mar 2026 01:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328954;
	bh=ohj4DoCarwyjJRCMadR2LGn2TfMpTMhKMWSsqNw+PLE=;
	h=From:To:Cc:Subject:Date:From;
	b=HO0ANwvQTB1PbQwhOQEUmo+CjWt7vI0IePcIjr4sMvnuCOkVtv2kFlnMbXHjbxHRE
	 FmOnVNMBXpU6DOaZmKH3o3M3W+lJEZ4JfuO3UdEm2gUtenqzITZIJvAJd+a/+cUjCS
	 yt5Q+62t7elEacS4U4kM6VZjtgZZ5DM/QhGvnlJ1tHycK7s2Wkm9dP9TFPsKVdk16T
	 pKepK7UdmfRLD2v+i4avyMSISLBxhdqZWpVxGyimLKpq3GD1zRZIAr7pNqWW39dh0u
	 ePl0gfqawcMUdvRHGg7Q3963QNBKaXN1P2B0sVVFMQOMSzSVCJU/8Yvlu6HhfpAFXr
	 jHFDSYrXZHglw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	lihaoxiang@isrc.iscas.ac.cn
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexandre Bounine <alex.bou9@gmail.com>,
	Matt Porter <mporter@kernel.crashing.org>
Subject: FAILED: Patch "rapidio: replace rio_free_net() with kfree() in rio_scan_alloc_net()" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:35:52 -0500
Message-ID: <20260301013552.1695686-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221711-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,kernel.crashing.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 501FA1CB398
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
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





