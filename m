Return-Path: <stable+bounces-258419-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDuVIBAnG2qS/ggAu9opvQ
	(envelope-from <stable+bounces-258419-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:06:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 839D2610FB6
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FAAB300FB3A
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94DB2FDC5E;
	Sat, 30 May 2026 18:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HutV+PZ4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A857A29B78B;
	Sat, 30 May 2026 18:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164288; cv=none; b=FO6td5mNP+jNN8/w2lIqcbLZ2LnavknSvd5r/tzPZPR0B34VOYZfFNoJ6m6bvHUsjHxX2VYHtOuY9m5hsF6A+2uo6MhSfmfq/Zfe3sPOc4fp9Z29ZukWXsjowncm471A0wVV0krgAbd+toguV48WyiukMvzmxgVw+h/+4Bm0a1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164288; c=relaxed/simple;
	bh=dZ2G64nK6AUxIxCpx2VfFqhL3mxTpaiTx0CAwlEW3yM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbQUcxQPV5QEDu+sJbPwYZyNwVwZ8bltLQrvyogieVS46MR/CqRYEt61BiVNdndJnP3gCkJ0Vbrf1IxUd5PEJtoaWkgWtyn0W2GDSVogVUCGZ2PGm0oEh55enw+R76T7LYigxaRxYH2DGt8GaaY6qqeR38SS3UpOa95IP9+SZEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HutV+PZ4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDBE1F00893;
	Sat, 30 May 2026 18:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164287;
	bh=swATJNOUrFs8qtri9Ku4yYkF40hthu6kuTG+vq23geg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HutV+PZ4IC07DDMikuwdEXd9qm/Rh+uSv0I1/d+FNZ4NKgXbZQThDuh2SBTfQjvKN
	 qfsi80KxJ0uYPtQMJBTMMjOvp+/lyyxvb915gtvOuaovCxmnFOfxPda2M+9d1Hy3H4
	 8i/uFpY9IV7H2G6vQnOrYZZaWSYjZ/BgY42Ly9ZE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 510/776] mtd: parsers: ofpart: call of_node_get() for dedicated subpartitions
Date: Sat, 30 May 2026 18:03:44 +0200
Message-ID: <20260530160253.444827939@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258419-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.0:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,renesas.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,4.196.207.88:email]
X-Rspamd-Queue-Id: 839D2610FB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

[ Upstream commit e882626c1747653f1f01ea9d12e278e613b11d0f ]

In order to parse sub-partitions, add_mtd_partitions() calls
parse_mtd_partitions() for all previously found partitions.

Each partition will end up being passed to parse_fixed_partitions(), and
its of_node will be treated as the ofpart_node.

Commit 7cce81df7d26 ("mtd: parsers: ofpart: fix OF node refcount leak in
parse_fixed_partitions()") added of_node_put() calls for ofpart_node on
all exit paths.

In the case where the partition passed to parse_fixed_partitions() has a
parent, it is treated as a dedicated partitions node, and of_node_put()
is wrongly called for it, even if of_node_get() was not called
explicitly.

On repeated bind / unbinds of the MTD, the extra of_node_put() ends up
decrementing the refcount down to 0, which should never happen,
resulting in the following error:

OF: ERROR: of_node_release() detected bad of_node_put() on
/soc/spi@80007000/flash@0/partitions/partition@0

Call of_node_get() to balance the call to of_node_put() done for
dedicated partitions nodes.

Fixes: 7cce81df7d26 ("mtd: parsers: ofpart: fix OF node refcount leak in parse_fixed_partitions()")
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/parsers/ofpart_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/parsers/ofpart_core.c b/drivers/mtd/parsers/ofpart_core.c
index 7ac5ba6edd63d..c024346df0c59 100644
--- a/drivers/mtd/parsers/ofpart_core.c
+++ b/drivers/mtd/parsers/ofpart_core.c
@@ -71,7 +71,7 @@ static int parse_fixed_partitions(struct mtd_info *master,
 			dedicated = false;
 		}
 	} else { /* Partition */
-		ofpart_node = mtd_node;
+		ofpart_node = of_node_get(mtd_node);
 	}
 
 	of_id = of_match_node(parse_ofpart_match_table, ofpart_node);
-- 
2.53.0




