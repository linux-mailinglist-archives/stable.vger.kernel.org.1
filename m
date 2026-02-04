Return-Path: <stable+bounces-214205-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAarMuVog2kbmgMAu9opvQ
	(envelope-from <stable+bounces-214205-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:42:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AC5E92D0
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE0E131192DE
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76112C3254;
	Wed,  4 Feb 2026 15:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yJEqaYEV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7CE21ABC9;
	Wed,  4 Feb 2026 15:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218915; cv=none; b=mRNvVVasn2K6A8Td8qDS35NU8rf0Cg75mSUxO7cs/HdQ3idqdDr9A1mh/0dshFU46Vhb6mTq2gBQ3hGDcbLLqgkg61nBv9MZFJ55VtfKG6ncjQCc864dmMdQedR61dan/SJ+6ZgORWMezn8oKCOiuXlKz6APAecYn+w3vUBdf/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218915; c=relaxed/simple;
	bh=XoLUPuxdqvQBujiO85AWCdloFpZI8FqDFbJH4jtr3ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUN1r1UNviEi/Afutw2a2+ZsWQVouRBaLAe+4REIa2iG8N5ZkP8IE7xeaZgSD1ZjrgV5IRkoJQ4MSR5CZ4wTZnw26bDdmYGBSdvVE+akkmlO4ZboUXIjo2DcuI6vR/ZePugJ5rRJp8t/qaHSQsQ3qeK+a11dBXVkX3bE75ZvkHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yJEqaYEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6433C4CEF7;
	Wed,  4 Feb 2026 15:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218915;
	bh=XoLUPuxdqvQBujiO85AWCdloFpZI8FqDFbJH4jtr3ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yJEqaYEVHiGu3fbPuJ6jedD7Vh2XylOpbdBzodxBjbc50XubVbLonyDfvaXbcjlul
	 PM6AcnqmjIRdARvs/GIUsnkNJ5PihPsXZkG/VbnBgQ4uFUyKThcLtrxqyT3LM1VDRI
	 zOzA3jMFQHQ42c8C/O+6avweq+CKKBzJL7fmZJRU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zilin Guan <zilin@seu.edu.cn>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 012/122] net: mvpp2: cls: Fix memory leak in mvpp2_ethtool_cls_rule_ins()
Date: Wed,  4 Feb 2026 15:39:54 +0100
Message-ID: <20260204143852.307584881@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
References: <20260204143851.857060534@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214205-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,seu.edu.cn:email]
X-Rspamd-Queue-Id: 48AC5E92D0
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zilin Guan <zilin@seu.edu.cn>

[ Upstream commit 09f979d1f312627b31d2ee1e46f9692e442610cd ]

In mvpp2_ethtool_cls_rule_ins(), the ethtool_rule is allocated by
ethtool_rx_flow_rule_create(). If the subsequent conversion to flow
type fails, the function jumps to the clean_rule label.

However, the clean_rule label only frees efs, skipping the cleanup
of ethtool_rule, which leads to a memory leak.

Fix this by jumping to the clean_eth_rule label, which properly calls
ethtool_rx_flow_rule_destroy() before freeing efs.

Compile tested only. Issue found using a prototype static analysis tool
and code review.

Fixes: f4f1ba18195d ("net: mvpp2: cls: Report an error for unsupported flow types")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Link: https://patch.msgid.link/20260123065716.2248324-1-zilin@seu.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index 44b201817d94c..c116da7d7f18c 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -1389,7 +1389,7 @@ int mvpp2_ethtool_cls_rule_ins(struct mvpp2_port *port,
 	efs->rule.flow_type = mvpp2_cls_ethtool_flow_to_type(info->fs.flow_type);
 	if (efs->rule.flow_type < 0) {
 		ret = efs->rule.flow_type;
-		goto clean_rule;
+		goto clean_eth_rule;
 	}
 
 	ret = mvpp2_cls_rfs_parse_rule(&efs->rule);
-- 
2.51.0




