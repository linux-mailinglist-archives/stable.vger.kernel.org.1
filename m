Return-Path: <stable+bounces-213500-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCzXImdcg2mJlQMAu9opvQ
	(envelope-from <stable+bounces-213500-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:49:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6FEE7654
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1B9F3014131
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF74128CF49;
	Wed,  4 Feb 2026 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NvgGzUNd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A392C2C0F6E;
	Wed,  4 Feb 2026 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216548; cv=none; b=OEFfKhag3542jiMrQZljNMlWBTzHAWalqhLBXZnk3zper+SUI+iJmDJsdgbXBl9wKYrhAwgthbZGrvXujhc+gflooqb2LRtgvFbv9NsAX6evKVVfpVvGKkdeGxiMy+sicJiMnupUW26caR+7Kav0ca4sNJYpKXdGMHkzfPXiBTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216548; c=relaxed/simple;
	bh=822/xpiY/g65rpm776VqdffaU97uacmYP9FLUq6lF+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLQuFNllOPoOZ24PK6NcnmA/MwEPFO7+kOMBfnftQcPP9nor+HaGQ+exutFpbmff+wgnoSPmY2H/tvTjdAHFialr0Hq4TeEn0N/V4exhZG+4kUtCCudDfQX2So/KbDUl78ZhmsGWnkQzEZprCaaD1KiXUGMnmWDS+ETFHkJeAmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NvgGzUNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC870C4CEF7;
	Wed,  4 Feb 2026 14:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216548;
	bh=822/xpiY/g65rpm776VqdffaU97uacmYP9FLUq6lF+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NvgGzUNd39CoIXCno5GqqbsYDjQk7DsLP6qqjRnlltGYeAcyF2l34IsTd9IHKDDEK
	 RtyZ9qZmKnhY3lbsy6Sj++VtRKQFRpLR6Uoc7E9w6/jVLmqKpfQ+S7DGEH8Aorc1HY
	 3O+HP8l6B7K1RkzmolT46eYxCEuoo5s+2BR0us04=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zilin Guan <zilin@seu.edu.cn>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 120/161] net: mvpp2: cls: Fix memory leak in mvpp2_ethtool_cls_rule_ins()
Date: Wed,  4 Feb 2026 15:39:43 +0100
Message-ID: <20260204143856.064184347@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.755002596@linuxfoundation.org>
References: <20260204143851.755002596@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-213500-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF6FEE7654
X-Rspamd-Action: no action

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index 3ad1327395877..821cc5aa4a7b4 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -1383,7 +1383,7 @@ int mvpp2_ethtool_cls_rule_ins(struct mvpp2_port *port,
 	efs->rule.flow_type = mvpp2_cls_ethtool_flow_to_type(info->fs.flow_type);
 	if (efs->rule.flow_type < 0) {
 		ret = efs->rule.flow_type;
-		goto clean_rule;
+		goto clean_eth_rule;
 	}
 
 	ret = mvpp2_cls_rfs_parse_rule(&efs->rule);
-- 
2.51.0




