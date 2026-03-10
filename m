Return-Path: <stable+bounces-224215-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KcaKkAAsGmoeQIAu9opvQ
	(envelope-from <stable+bounces-224215-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:28:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A4824ABF2
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB6B23040DA0
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4503876AA;
	Tue, 10 Mar 2026 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3QwKTwo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6A73803CD;
	Tue, 10 Mar 2026 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141913; cv=none; b=EBV8SeksttIL3d7kfeeyJJWZwrPBp3QcaPqjmIpZfGDd8jLbLFJjkOefS0Nx/r7rjHsXx8hU4Z9FiCnkuEoxAW5eKrz1ugf/CilABRhJJaFKwCv59GosjtPeMF/tCVJFXcRs70I9WO3eyMAYEgDA4iZrSnwvEFY7m+K11hJg468=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141913; c=relaxed/simple;
	bh=IyWDwr0YumqQypt5Xl2HqYQaca+Tw0R6OD7rBO0PYqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+Ydw2a47ZD+hjJ5kZt7VGh7W5uL0ktg0POxGtP97AxRQctLWtORfx7xcPUQTAu/mwAUxbxT2dX62/AqAbYlZPyXJSbTdJnWjjauwVAzpAXvcY3f8oLL6G3JJkHn6ViuuV2VteKrlB4AfE2y/Zse+Coe8WIp9PYCaN0OOjJSGoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3QwKTwo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99380C2BC86;
	Tue, 10 Mar 2026 11:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141913;
	bh=IyWDwr0YumqQypt5Xl2HqYQaca+Tw0R6OD7rBO0PYqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h3QwKTwo4fy51YipCqlUNJiO7wKpZQC0YLcRHTKxxB+tYs8YzkQpiYubM+qxd0ct7
	 jJttgCHU6D/6FO2kik3O2W1VMXHpg5O/TmjHdteUGiV45+jmJa1uRt3j2k/QXl+6GZ
	 r0hOAg40sQnj88YPSU6wxehCpK/S/J9SOOyKg7pM8OF4BWKCh8CelWIKJghwlnEXbb
	 pLSyu91Dw5wuuIW1K/i+ziN/54mscMau38SNXSqtLrktAFDoazTw95B0uwzcAX0wt8
	 507aUO+txvVmHB9oBXfpSUMLqII8L/blReYwak3nWMNYS3R4EQT6QKA9/RsP3mRUMI
	 raUc8LXhYJ61w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Felix Gu <ustc.gu@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 036/314] regulator: bq257xx: Fix device node reference leak in bq257xx_reg_dt_parse_gpio()
Date: Tue, 10 Mar 2026 07:14:55 -0400
Message-ID: <e332c527a2579850c439dd58eba70899872190e4.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 40A4824ABF2
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
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224215-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Felix Gu <ustc.gu@gmail.com>

[ Upstream commit 4baaddaa44af01cd4ce239493060738fd0881835 ]

In bq257xx_reg_dt_parse_gpio(), if fails to get subchild, it returns
without calling of_node_put(child), causing the device node reference
leak.

Fixes: 981dd162b635 ("regulator: bq257xx: Add bq257xx boost regulator driver")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Link: https://patch.msgid.link/20260224-bq257-v1-1-8ebbc731c1c3@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/bq257xx-regulator.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/regulator/bq257xx-regulator.c b/drivers/regulator/bq257xx-regulator.c
index fc1ccede44688..dab8f1ab44503 100644
--- a/drivers/regulator/bq257xx-regulator.c
+++ b/drivers/regulator/bq257xx-regulator.c
@@ -115,11 +115,10 @@ static void bq257xx_reg_dt_parse_gpio(struct platform_device *pdev)
 		return;
 
 	subchild = of_get_child_by_name(child, pdata->desc.of_match);
+	of_node_put(child);
 	if (!subchild)
 		return;
 
-	of_node_put(child);
-
 	pdata->otg_en_gpio = devm_fwnode_gpiod_get_index(&pdev->dev,
 							 of_fwnode_handle(subchild),
 							 "enable", 0,
-- 
2.51.0


