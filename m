Return-Path: <stable+bounces-221015-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECyDLKJJo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-221015-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:01:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AD21C7C67
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06DB9300AB30
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B11D4BCAA8;
	Sat, 28 Feb 2026 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4rE7QIJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3E74BCAA3;
	Sat, 28 Feb 2026 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301358; cv=none; b=e/SYhsw/4fqWY2TFN9gP4SMdJhAJozDTiL+NddthLdZXboOfraAKnkvCKbYP608m12X19SRFcupg3PVpiAvj2ObpWf4+Qzht/vvIaTogExDu5Kf5D+yVEdOEHMdLbrNwdVoJd8wmZ8eKtXakYAxBljBV1eQAwAT4+r2FC80DyGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301358; c=relaxed/simple;
	bh=sERlK4cG0sQy2fgQwMEdNxFqpS9791B3HJ5q/wS0nV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HsK109BfH+KzPKZYbafayVlgwiv6QzZXFPCAt2LGDpHV6X9/9M+2Ry+RhiLSFAXUt2Ov8Lkqq5MYHDNHTV4UFiyPzDSPubfLAFiZycfeDHlcD1iVQls3rltqEEzc6P5Sk14ZOcZ6Riq8STBSyejGdlnqnLqLRU+1CjQot95StEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4rE7QIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54036C19423;
	Sat, 28 Feb 2026 17:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301358;
	bh=sERlK4cG0sQy2fgQwMEdNxFqpS9791B3HJ5q/wS0nV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A4rE7QIJ3m4hFaCsDYRZ8yrzbo9psnfYXNUL1cmVCS5K3+HeExtTxNnrf5ztJdN/i
	 CkyP3HklnLsiVaU/6NMQTdctpkYSEe2qS2zDbFER/XpUv2nUf3YNb9mKHz+Nkw6FL9
	 jMMgqjTV29bt1gwGYxsyYK6uosD53ggQm3eOnsgMumJoGD5/zsp48yhbYUe0v3dE69
	 BUQrsKcCiztJ01RDEwSOJe8Fs7+YPOJetc0Xtd3XjvUO8uXMD8igUo5zq0zoM8k4do
	 Wpwh2X+Yvxb3KKnml+nE+9BF0sGGwCTfW6o6r7sgURLkJn19drs8cuLOKQSJs9py/r
	 NI/+poRzt3rdA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Janne Grunau <j@jannau.net>,
	stable@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>,
	Neal Gompa <neal@gompa.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 546/752] clk: clk-apple-nco: Add "apple,t8103-nco" compatible
Date: Sat, 28 Feb 2026 12:44:17 -0500
Message-ID: <20260228174750.1542406-546-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221015-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gompa.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,jannau.net:email]
X-Rspamd-Queue-Id: 41AD21C7C67
X-Rspamd-Action: no action

From: Janne Grunau <j@jannau.net>

[ Upstream commit ef9b3b4dbe767e4ac642a88dc0507927ac545047 ]

After discussion with the devicetree maintainers we agreed to not extend
lists with the generic compatible "apple,nco" anymore [1]. Use
"apple,t8103-nco" as base compatible as it is the SoC the driver and
bindings were written for.

[1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/

Fixes: 6641057d5dba ("clk: clk-apple-nco: Add driver for Apple NCO")
Cc: stable@vger.kernel.org
Acked-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Janne Grunau <j@jannau.net>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-apple-nco.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-apple-nco.c b/drivers/clk/clk-apple-nco.c
index d3ced4a0f029e..434c067968bbc 100644
--- a/drivers/clk/clk-apple-nco.c
+++ b/drivers/clk/clk-apple-nco.c
@@ -320,6 +320,7 @@ static int applnco_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id applnco_ids[] = {
+	{ .compatible = "apple,t8103-nco" },
 	{ .compatible = "apple,nco" },
 	{ }
 };
-- 
2.51.0


