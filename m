Return-Path: <stable+bounces-223917-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JBXHUn8r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223917-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:11:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEED024A087
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C0BF3083015
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3997F371067;
	Tue, 10 Mar 2026 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhh+uXjc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F105C2BF3E2;
	Tue, 10 Mar 2026 11:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141054; cv=none; b=h/ZhGzpXKwkzUBxgc19ltfMVUtBiq50guQEfoE0KtQoR0oi5MmfnlUUs9A346sgRWAKBtOS+d8qGlg6REa6HB34L5eHeJ+JffpWl/pV/hmYFsIGsAF+NfG5mVXW2PN2xcOzZhKElkwjjbaMg3Jpw4hQKuJVHg55sd52D6JPGzCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141054; c=relaxed/simple;
	bh=JHUiY4KsA5sPURgwpwBKusMkyLuggSr91w/S75qy/+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NbVEt6vmlpRHezw3auOWHjYesXDPm8d1HhzByNIgfx9CXOPEZi2yITdJs5x94Ny+k2dhNKHuUDTXjfbTFDANPyOi0lOxSTS66umah1k4uh3y33m373+mbp8WSrMwDb35sZh6fiq/4M2sCcQUJWykSESIfwf2AzHX85x+ZS1akAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhh+uXjc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1D2C19423;
	Tue, 10 Mar 2026 11:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141053;
	bh=JHUiY4KsA5sPURgwpwBKusMkyLuggSr91w/S75qy/+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uhh+uXjcsivFaj/BjTJEM5mCVGLvyWzC0QcDd89jGzhCvi5jZHACkDP5ju0ECtA3g
	 uF2BPhwi8FHqsBXzbp6cxYNzsOmY16A2TvAk/tLd24AjBURRI0+pn9bb1nwdea6LKE
	 US9Pc/NBSewDcnMmn9AC3Qe04c5Vccgn7x/tp/hDCPE2vDFzGNK11/E/mC9kYNGKcL
	 Nx7pkMo9o9XOsR+qvXSbcfwBtMsWiuW/LkRcTIiKD9Jn1vN/TkTg5pNf8T02HDn9y9
	 nWkwMqrqdl8BS+DjBTru81zEfKjDmK2Of/nofTTAOBkGvnH9jgFU4f1u+mthbSHn3n
	 9MhBaVr3Gwalg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 052/311] irqchip/ls-extirq: Fix devm_of_iomap() error check
Date: Tue, 10 Mar 2026 07:01:39 -0400
Message-ID: <205e16af4f473421092399f7698943a3670942bf.1773140655.git.sashal@kernel.org>
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
X-Rspamd-Queue-Id: BEED024A087
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223917-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email,linaro.org:email]
X-Rspamd-Action: no action

From: Ioana Ciornei <ioana.ciornei@nxp.com>

[ Upstream commit fe5669e363b129cde285bfb4d45abb72d1d77cfc ]

The devm_of_iomap() function returns an ERR_PTR() encoded error code on
failure. Replace the incorrect check against NULL with IS_ERR().

Fixes: 05cd654829dd ("irqchip/ls-extirq: Convert to a platform driver to make it work again")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Herve Codina <herve.codina@bootlin.com>
Link: https://patch.msgid.link/20260224113610.1129022-3-ioana.ciornei@nxp.com
Closes: https://lore.kernel.org/all/aYXvfbfT6w0TMsXS@stanley.mountain/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-ls-extirq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-extirq.c
index 96f9c20621cf5..d724fe8439801 100644
--- a/drivers/irqchip/irq-ls-extirq.c
+++ b/drivers/irqchip/irq-ls-extirq.c
@@ -190,8 +190,10 @@ static int ls_extirq_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, -ENOMEM, "Failed to allocate memory\n");
 
 	priv->intpcr = devm_of_iomap(dev, node, 0, NULL);
-	if (!priv->intpcr)
-		return dev_err_probe(dev, -ENOMEM, "Cannot ioremap OF node %pOF\n", node);
+	if (IS_ERR(priv->intpcr)) {
+		return dev_err_probe(dev, PTR_ERR(priv->intpcr),
+				     "Cannot ioremap OF node %pOF\n", node);
+	}
 
 	ret = ls_extirq_parse_map(priv, node);
 	if (ret)
-- 
2.51.0


