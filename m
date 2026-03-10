Return-Path: <stable+bounces-224082-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDbAL4z+r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-224082-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:20:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE1F24A700
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61B5C30C169E
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02093876B7;
	Tue, 10 Mar 2026 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNJN0+qQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A2338757F;
	Tue, 10 Mar 2026 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141216; cv=none; b=TPidIdvdDADl5cV0WCAwYfw4Ih387ovOi0Aji/FRyRSRyV7V3XJNqhPAmAu0KVu4U8lCBxJCqy1o/3we1qPsMwL3KjZrfz0/otFs6ktUIfrFtHs+MYXI01Urf1raIpBEp0epPo7LPHAn37Ok6hS0OBhQ7UXU2aX7Mjibc79gQYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141216; c=relaxed/simple;
	bh=1VCYbGHtsILIB2nc5UBIWz5Lom2wBaxiTN75Oy0JpLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjTwLVbJ2DdR6SylAuwmA7xjXZqaZVoMBzm2FfYJaQcViF/u0m6EKkwuGQ31odwa4pexvgfumYI+BG39NkPw1Rjio/KM+lPBYTAOmZ8bewL7Kwa8UnsCUlKVuPUCb4uYtZwSs+3mVB7oYDV0zj2C7vJeHlrLYQKoPiPz4b8rU7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNJN0+qQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973E6C2BC86;
	Tue, 10 Mar 2026 11:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141216;
	bh=1VCYbGHtsILIB2nc5UBIWz5Lom2wBaxiTN75Oy0JpLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HNJN0+qQTTTjM/vLzFCdPIPtiIqyGk37p5rbweQEGDDeMYcZO4QLSBxGiusWOo/8Q
	 2iRbME2e7yQJmDRtMv+1SpmeClAScEGNXdiuNJbaq/vj++ot2LovfO6oj7OsLKEB8m
	 DkpDhZ/78D+kpIhPWs86dFkjIIwlHfONIKXfylxQunPVVmxPIcYiQk1/UQQzFNyOZY
	 TwHozZZJvjsSoqXw+re0FUcJzM85yvRlyGKIdi+BySDHzcLqoD2ZAYdJpQY1PvcWTe
	 3kESnwmzW8BiaYhaxTKAL2BG3VoW4N+wzigcs8ykAJGZGgds8qnFfYaFVaQ384OoMu
	 CMg8lRLhTe1dA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Felix Gu <ustc.gu@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 217/311] regulator: mt6363: Fix incorrect and redundant IRQ disposal in probe
Date: Tue, 10 Mar 2026 07:04:24 -0400
Message-ID: <ea5e85f13c0bc08952587a1732f5200a234a707e.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3BE1F24A700
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-224082-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Action: no action

From: Felix Gu <ustc.gu@gmail.com>

[ Upstream commit 23942b71f07cc99e39d9216a5b370df494759d8c ]

In mt6363_regulator_probe(), devm_add_action_or_reset() is used to
automatically dispose of the IRQ mapping if the probe fails or the
device is removed.

The manual call to irq_dispose_mapping() in the error path was redundant
as the reset action already triggers mt6363_irq_remove(). Furthermore,
the manual call incorrectly passed the hardware IRQ number (info->hwirq)
instead of the virtual IRQ mapping (info->virq).

Remove the redundant and incorrect manual disposal.

Fixes: 3c36965df808 ("regulator: Add support for MediaTek MT6363 SPMI PMIC Regulators")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Link: https://patch.msgid.link/20260223-mt6363-v1-1-c99a2e8ac621@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/mt6363-regulator.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/regulator/mt6363-regulator.c b/drivers/regulator/mt6363-regulator.c
index 03af5fa536007..0aebcbda0a196 100644
--- a/drivers/regulator/mt6363-regulator.c
+++ b/drivers/regulator/mt6363-regulator.c
@@ -899,10 +899,8 @@ static int mt6363_regulator_probe(struct platform_device *pdev)
 					     "Failed to map IRQ%d\n", info->hwirq);
 
 		ret = devm_add_action_or_reset(dev, mt6363_irq_remove, &info->virq);
-		if (ret) {
-			irq_dispose_mapping(info->hwirq);
+		if (ret)
 			return ret;
-		}
 
 		config.driver_data = info;
 		INIT_DELAYED_WORK(&info->oc_work, mt6363_oc_irq_enable_work);
-- 
2.51.0


