Return-Path: <stable+bounces-264255-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2mLfNlF1MWpWjwUAu9opvQ
	(envelope-from <stable+bounces-264255-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:09:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 14397691C00
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:09:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=wuOHGwPU;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264255-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-264255-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E03A4303A8BB
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF1543E486;
	Tue, 16 Jun 2026 15:49:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966BB3B840B;
	Tue, 16 Jun 2026 15:49:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624971; cv=none; b=NPxYzi05o26lasTub7aBCZP0pbSKU8MmhuxWMQ0X7Fr4d24V5ExH/HGg5j3K56GeaXSPqzXpZAQl/lcPWp03M1ZTLg+eOh+1WtW5/dp+Foz2Q2YEIkEP9bWSyIQQUfABf/kB/V6bKbIxmMmto8wFNxbFEp4SZ2OBg8MN1P3iS8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624971; c=relaxed/simple;
	bh=b1NzoT4+khkM4zJIt6FJ1c+O6229H6KnNlZNWWkmVso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ge+9TOhSYZuGXu8GkAsRYUdHVUSrj92rFd8rlJZiIWlt1JzhPtY4WX02xg4viYbz/uyeeFrvmPd4ZE1Oz8sJbMIGfpzh4IYdt4lCJ7yydtGTMoz2iFbwxbV44hzPSBC7OvuaqtyrmOtbYCnr2a943iMv9Q79OyZt1JwWoEINGt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wuOHGwPU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8CA1F000E9;
	Tue, 16 Jun 2026 15:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781624970;
	bh=xu0l+Y6VlCGt/p7OwpZfsvtYNKuomG51EUqTt7vbwKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wuOHGwPUeSpdiyqLsdZAFmsp8jNrfehW8VCEskliKN86VKm+XyKqoDc2lGDu2AFLU
	 2kE2tcDbY0FUAnE5ZATZgXsIAHDORNX2oWxlOeFPQur5QDhwwvEoEo+Xp5W9Spbu4n
	 t8/6w9RYLv91dy+uKol+QUFxPSlQaPKOqwhbS1gU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 059/325] net: ethernet: mtk_eth_soc: Fix use-after-free in metadata dst teardown
Date: Tue, 16 Jun 2026 20:27:35 +0530
Message-ID: <20260616145100.633241712@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264255-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:lorenzo@kernel.org,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14397691C00

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit 80df409e1a483676826a6c66e693dba6ac507751 ]

mtk_free_dev() calls metadata_dst_free() which frees the metadata_dst
with kfree() immediately, bypassing the RCU grace period.
In the RX path, skb_dst_set_noref() sets a non-refcounted pointer from
the skb to the metadata_dst. This function requires RCU read-side
protection and the dst must remain valid until all RCU readers complete.
Since metadata_dst_free() calls kfree() directly, a use-after-free can
occur if any skb still holds a noref pointer to the dst when the driver
tears it down.
Replace metadata_dst_free() with dst_release() which properly goes
through the refcount path: when the refcount drops to zero, it schedules
the actual free via call_rcu_hurry(), ensuring all RCU readers have
completed before the memory is freed.

Fixes: 2d7605a72906 ("net: ethernet: mtk_eth_soc: enable hardware DSA untagging")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://patch.msgid.link/20260602-airoha-mtk-metadata-uaf-fix-v1-2-3aaa99d83351@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 0f676bd72832bb..065f969ee44ef6 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -4470,7 +4470,7 @@ static int mtk_free_dev(struct mtk_eth *eth)
 	for (i = 0; i < ARRAY_SIZE(eth->dsa_meta); i++) {
 		if (!eth->dsa_meta[i])
 			break;
-		metadata_dst_free(eth->dsa_meta[i]);
+		dst_release(&eth->dsa_meta[i]->dst);
 	}
 
 	return 0;
-- 
2.53.0




