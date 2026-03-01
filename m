Return-Path: <stable+bounces-221931-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FlzMEibo2l4IAUAu9opvQ
	(envelope-from <stable+bounces-221931-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:50:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6266C1CBEBB
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 896BF303BF63
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC982DB7B5;
	Sun,  1 Mar 2026 01:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMJrhMXu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809B72D9EF4
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329490; cv=none; b=krLWBbPpq8N+vkE2Myei7q0CEPI9STSazDHytkvyJJF+hRtv5aUbAAnudMRY3KA0SjiUvgA4psKfALd06y9sMQeTTIZ/B0DnEdtTq54ZdwxTdhxMYoVDEnDJha7SdAPLLQ8EL8sAExS7sKQoUJmqEaRteaD7qnZ6fS4mopcAfgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329490; c=relaxed/simple;
	bh=hZ0Ygae/ObNlT1CclwW638CCFTscQAOx9yzUWVJJ8lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Baw6CrYkTFL2OiEURPO22Oy6aXeQcO3QPLrZxyQRNdIpqs4jG3TBnpiXMWoLTqAtBFZnL4kVxvnlF7xWMM4fF7p++6pEmLUUuCLVf5AODLae9wcna6oG0/C+M382gPMffQy8ww5xkBsqaeTNkIyIiiJVpcJUQ4qWFbkE6OSRLw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMJrhMXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC55C19421;
	Sun,  1 Mar 2026 01:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329490;
	bh=hZ0Ygae/ObNlT1CclwW638CCFTscQAOx9yzUWVJJ8lQ=;
	h=From:To:Cc:Subject:Date:From;
	b=KMJrhMXurM56J0c11i87+1HdmRj4wwyzYv/OyzUVx0wY+ur9EsO1YV/7flwz5cPar
	 UjTDILQUFl2yn6ttYfKdnnTz9Aa4Qr18ScFPxzEuKAdDD3mWlghLqDa6o5ZlcxOd+a
	 BQle/JSXAN+h5B3a8C87CQcZgoGCs6/YcCAWVw9mXxvWf/+x4wiSwnyk8+TOouIOWL
	 ituI3qqRWgTFmC7GeePs1qXzvRQm4OBUJ6amYrfiB9rfyaCxlW0je+kQu70chcpJh8
	 UbJHYtnCl9IHoBIgAlctU5Kz7k19sMYXnndoITbctrFu+2TuBg2FI2RLx3P2mdyhd6
	 e8zsqJtk8bd3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	lihaoxiang@isrc.iscas.ac.cn
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexandre Bounine <alex.bou9@gmail.com>,
	Matt Porter <mporter@kernel.crashing.org>
Subject: FAILED: Patch "rapidio: replace rio_free_net() with kfree() in rio_scan_alloc_net()" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:44:48 -0500
Message-ID: <20260301014448.1707246-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,kernel.crashing.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-221931-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,crashing.org:email,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 6266C1CBEBB
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
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





