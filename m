Return-Path: <stable+bounces-224055-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKgkI9b8r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-224055-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:13:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FFF24A247
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 333053036AB6
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98E6387571;
	Tue, 10 Mar 2026 11:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHXU1n8Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD842352C4F;
	Tue, 10 Mar 2026 11:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141188; cv=none; b=aSwZ7znMXbSUO+HGc5CQd753a/PG7kNxPyKAs3sRkIus66ySWdUKgsB2HAiKfGUJMwMSo6OmE6ae7v70PN4+20Fv0yKAa+z8VDWWl7xlonv9EV1g9ADVxLzzwuiUQrttV1dpFpIzY3PfxUE1JZA+Q4rBtt7y7dt4sqGaSnr8uGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141188; c=relaxed/simple;
	bh=VwYEPu7gqsKAwklOkLRT46Ju2ASNwgfSE8LTq8gzW/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXCnP5JAxeOfK2G7JCwNIasNH39UQCKSVEjPbF5t1flNl2qvxvVYYX25hcLLigc5wzdLMQCgtCjTNbaHjIwZNysaCDAitcpZVpQwZWO6iMM9uMUQ+ZLgnBdi4M2Ezu0JhyKTZDQjnB3660CSUa0jrTsmU07bzVpu6mtX4B5c+J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHXU1n8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51C6C2BC86;
	Tue, 10 Mar 2026 11:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141188;
	bh=VwYEPu7gqsKAwklOkLRT46Ju2ASNwgfSE8LTq8gzW/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KHXU1n8Q1JaiIXpea922YrhkudKUqEhOW2qWAUySf/cO8NbsReaRYiCAARczlmm5D
	 bkpg2cAiwCsKCa/5dy4+uVMeQCfxVqURuGozJRkRfrglT8R//h9TLxWBkjXaFz3tOk
	 pdlXPbROR/ZRCK0HmV6xllvEcI4pNuuOiLy8k/wJVFN9atVUHJe9RipAV2I2yDWMo4
	 bPC4uJFGULnd6RC5ioIt7UahXZ1aA1FQnMbHU4a0ne7VXk15eb1T57Ke4NhVlBXLob
	 RFNCw71rtbpn0DDDrZJByXd1YejzZpcBydarJNPUKX5Lic3mPSJbSBe9CrTETe7pUZ
	 HhbpEteHcxaRQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Felix Gu <ustc.gu@gmail.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 190/311] pinctrl: cirrus: cs42l43: Fix double-put in cs42l43_pin_probe()
Date: Tue, 10 Mar 2026 07:03:57 -0400
Message-ID: <ab9f8437f867799113d5f8af1c7a2b349d3a7adb.1773140655.git.sashal@kernel.org>
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
X-Rspamd-Queue-Id: 31FFF24A247
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,opensource.cirrus.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-224055-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cirrus.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
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


