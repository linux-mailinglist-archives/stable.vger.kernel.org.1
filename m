Return-Path: <stable+bounces-219367-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEerHKednmkZWgQAu9opvQ
	(envelope-from <stable+bounces-219367-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:58:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A778192A5D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E90153023D76
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B6330F80C;
	Wed, 25 Feb 2026 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pwN5gzoz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E809330F7F7;
	Wed, 25 Feb 2026 06:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002669; cv=none; b=I/LhWL3Mx9uBdSV1PFc4sU7YcPrD6q1UqR2YrtcxdtZDUSWlBEVKgGrh2pl+KYbF7z4xkaIf1YdtGkd8aW4dQh4EzoyaFoEL/Ox8Rz8+qeg7BAhLZz4O4+UibFq1DjSRsyRaDkNu+um2oc8EYE7gf3++Ad+BgYj6xVwlLWNNvtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002669; c=relaxed/simple;
	bh=HjOQCHxxe+X6B2XyaaXYbXjx7kNy+jCXcN4443SIqng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+nA2u/k00URorIRBZMexb53iC13Hkv3xe7d93y9gv2DiwJhIW25lZHx2lCO/29Qy75ZB5WlZ0eGyMPzbEnnx45jPilumGMVbfzgnW+qfJ2tYF/9Too+J7EY6D0oLiLaF0HVGI5zrqttlRWPV6NJN8QUcrGd/n4ayIeySB9jA7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pwN5gzoz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF87C116D0;
	Wed, 25 Feb 2026 06:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002668;
	bh=HjOQCHxxe+X6B2XyaaXYbXjx7kNy+jCXcN4443SIqng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pwN5gzoz3xV74zyTijNwc8UiLxb8uY/Z5DNofaKgdxazwTGigva1sl79pSkR8zbLS
	 ljw1s5xWTdKRi0LvRQ2Aq8mkJaeJyw8XZmWnuEhsO0Yvk/R4nc1IczXhigB+dbZlag
	 p1kTE1ZQnXS+WneYS03uzHyAeLv4w5NSP4NeYoBQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Georgi Djakov <djakov@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 450/641] interconnect: mediatek: Dont hijack parent device
Date: Tue, 24 Feb 2026 17:22:56 -0800
Message-ID: <20260225012359.423708286@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219367-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,collabora.com:email]
X-Rspamd-Queue-Id: 1A778192A5D
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

[ Upstream commit 510f8214440c553e81774c5822437ccf154e9e38 ]

If the intention is that users of the interconnect declare their
relationship to the child icc_emi node of the dvfsrc controller, then
this code never worked. That's because it uses the parent dvfsrc device
as the device it passes to the interconnect core framework, which means
all the OF parsing is broken.

Use the actual device instead, and pass the dvfsrc parent into the
dvfsrc calls.

Fixes: b45293799f75 ("interconnect: mediatek: Add MediaTek MT8183/8195 EMI Interconnect driver")
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Link: https://lore.kernel.org/r/20251124-mt8196-dvfsrc-v2-12-d9c1334db9f3@collabora.com
Signed-off-by: Georgi Djakov <djakov@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/interconnect/mediatek/icc-emi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/mediatek/icc-emi.c b/drivers/interconnect/mediatek/icc-emi.c
index 7da740b5fa8d6..182aa2b0623af 100644
--- a/drivers/interconnect/mediatek/icc-emi.c
+++ b/drivers/interconnect/mediatek/icc-emi.c
@@ -40,7 +40,7 @@ static int mtk_emi_icc_set(struct icc_node *src, struct icc_node *dst)
 	if (unlikely(!src->provider))
 		return -EINVAL;
 
-	dev = src->provider->dev;
+	dev = src->provider->dev->parent;
 
 	switch (node->ep) {
 	case 0:
@@ -97,7 +97,7 @@ int mtk_emi_icc_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	provider->dev = pdev->dev.parent;
+	provider->dev = dev;
 	provider->set = mtk_emi_icc_set;
 	provider->aggregate = mtk_emi_icc_aggregate;
 	provider->xlate = of_icc_xlate_onecell;
-- 
2.51.0




