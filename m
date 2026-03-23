Return-Path: <stable+bounces-229157-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LkkISpbwWnbSQQAu9opvQ
	(envelope-from <stable+bounces-229157-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:24:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBC82F63B2
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41FFE33D57DC
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A291625A2B5;
	Mon, 23 Mar 2026 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cLpG2VVS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6533C255F52;
	Mon, 23 Mar 2026 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278241; cv=none; b=NaRNYqkv124UPlQiBeuZoM9bxlJEIu9xxp7UPdeRUKzIOYSxwkqzTYsJA17fxo4TsakuYBvCRRuTS7Uj4rwMUUb2fXFGPJVwx4kDnLMQAalpJOreIP/3X9/TWFc0/F1ORaE37gWSudLaHRAWW5bBCcfty9ituBDtPB/cFioHreU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278241; c=relaxed/simple;
	bh=TdvoM1QedUlji6q4fjmeqQKHKWiGMPbtjCmkGGYPTOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QaETuk6xh1kp7VfuGL0y1PQlOEYVgpcDzAIFpwr4M+QzMO2bZyPW4J9paxbS0VBK0dVKnx1pyHtohGHtE99JkD6gSet82NHyupnHtj/QOX5s18qPpE8RHjT3aFTuFiyI/AxrhweXFKKTJSVVOuQMWaU9n7ymmz3CMGBQowRzxus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cLpG2VVS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD21BC4CEF7;
	Mon, 23 Mar 2026 15:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278241;
	bh=TdvoM1QedUlji6q4fjmeqQKHKWiGMPbtjCmkGGYPTOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cLpG2VVS7dyB1aFWdOpexFkNsoiA5DYHnVArtEY01GUfc6jADw6K7TBIh5PJXoaCg
	 RXB6u/BRvO7SP2ejo7iJPORGaBZD3WLedLMJglFA1rBFe+SNcw6CXLfDwfNfk8YA/K
	 VDDJGzc1Ni7xiaus9eknsf+CyhX/RYYV5qpEYim8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peng Fan <peng.fan@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 246/567] regulator: pca9450: Correct interrupt type
Date: Mon, 23 Mar 2026 14:42:46 +0100
Message-ID: <20260323134539.920441177@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229157-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: EFBC82F63B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit 5d0efaf47ee90ac60efae790acee3a3ed99ebf80 ]

Kernel warning on i.MX8MP-EVK when doing module test:
irq: type mismatch, failed to map hwirq-3 for gpio@30200000!

Per PCA945[X] specification: The IRQ_B pin is pulled low when any unmasked
interrupt bit status is changed and it is released high once application
processor read INT1 register.

So the interrupt should be configured as IRQF_TRIGGER_LOW, not
IRQF_TRIGGER_FALLING.

Fixes: 0935ff5f1f0a4 ("regulator: pca9450: add pca9450 pmic driver")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Link: https://patch.msgid.link/20260310-pca9450-irq-v1-1-36adf52c2c55@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/pca9450-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index b8f7b13b0cb08..8f09f7f15a119 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -780,7 +780,7 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 	if (pca9450->irq) {
 		ret = devm_request_threaded_irq(pca9450->dev, pca9450->irq, NULL,
 						pca9450_irq_handler,
-						(IRQF_TRIGGER_FALLING | IRQF_ONESHOT),
+						(IRQF_TRIGGER_LOW | IRQF_ONESHOT),
 						"pca9450-irq", pca9450);
 		if (ret != 0) {
 			dev_err(pca9450->dev, "Failed to request IRQ: %d\n",
-- 
2.51.0




