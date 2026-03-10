Return-Path: <stable+bounces-224395-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FEgEqEDsGkWegIAu9opvQ
	(envelope-from <stable+bounces-224395-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:42:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 623C024B5DA
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ED27D306BCE9
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A8D38A725;
	Tue, 10 Mar 2026 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctb4P1l+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AF23876D0;
	Tue, 10 Mar 2026 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142127; cv=none; b=N4BEGMXpQtVOq7s+Rj5Ano/V102P4Ig9R6Pywwc2YjXn1zYE/AiPeSykdiIxNOKx5zKx4m4/Afq+LTsT7EWeUp5mkenT6/JXdxZaXPZ+6XQHNz2QP/hwA6l0vea4Wcp1lgT3+jZIbt+CLl/0cAepeOqzbiEEIAs1SPw4Os2u0oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142127; c=relaxed/simple;
	bh=VwYEPu7gqsKAwklOkLRT46Ju2ASNwgfSE8LTq8gzW/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTFH1O5/b3xL3BumcKkOM2v9IVyqp0MHaGKZIPEkUjOOKxc01XfcXru36h+ysX1Zg1bPEA1a1qFckSqQSNCW+G6sgEM1VKupadxH7cfNP1SWiVT5RXNsi8Roz3e6DtoWt42rvTYnLhS01K7VuVjqTraCLzIcBxKBAocNNgpwzKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctb4P1l+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C622DC2BC86;
	Tue, 10 Mar 2026 11:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142127;
	bh=VwYEPu7gqsKAwklOkLRT46Ju2ASNwgfSE8LTq8gzW/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ctb4P1l+s4fVGuQ4QgvbO9eEJuWhUsdlLlxQD7/hrlpp4cXu39TzC5VgHbtIyG1bO
	 hlKdMpx/gTrLFvWMfGdG/KysbEhTJhw8PIsIOiyXxPGaLqhshaFDcDkgL2XuZZHzFa
	 uoeOIH+cR7nT78PcO713ikEDsvLXwbCLEhcilYNz930Sj3n6ERNEUDnQrqim3tPwWq
	 PVBbZ5b8THfL4E4iHbaDYapJQ1EIDberelYhaYtgEuwjARnK0QrUG9hSVHfjHy/qrN
	 SjgvModF7655ACRcBBXDgCPCbMEzjeHN1Fa6lFfF86zV/KK3WNO6wPq17wk57xeXZ3
	 9zZieTnFrqaWg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Felix Gu <ustc.gu@gmail.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 216/314] pinctrl: cirrus: cs42l43: Fix double-put in cs42l43_pin_probe()
Date: Tue, 10 Mar 2026 07:17:55 -0400
Message-ID: <b1262d7920e595bc28b68885e96a329ba484d1e9.1773141555.git.sashal@kernel.org>
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
X-Rspamd-Queue-Id: 623C024B5DA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,opensource.cirrus.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-224395-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,cirrus.com:email]
X-Rspamd-Action: no action

From: Felix Gu <ustc.gu@gmail.com>

[ Upstream commit fd5bed798f45eb3a178ad527b43ab92705faaf8a ]

devm_add_action_or_reset() already invokes the action on failure,
so the explicit put causes a double-put.

Fixes: 9b07cdf86a0b ("pinctrl: cirrus: Fix fwnode leak in cs42l43_pin_probe()")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/cirrus/pinctrl-cs42l43.c b/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
index a8f82104a3842..227c37c360e19 100644
--- a/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
+++ b/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
@@ -574,10 +574,9 @@ static int cs42l43_pin_probe(struct platform_device *pdev)
 		if (child) {
 			ret = devm_add_action_or_reset(&pdev->dev,
 				cs42l43_fwnode_put, child);
-			if (ret) {
-				fwnode_handle_put(child);
+			if (ret)
 				return ret;
-			}
+
 			if (!child->dev)
 				child->dev = priv->dev;
 			fwnode = child;
-- 
2.51.0


