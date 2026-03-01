Return-Path: <stable+bounces-221861-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGieNm2ao2l4IAUAu9opvQ
	(envelope-from <stable+bounces-221861-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:46:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5983F1CBA6B
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DDBA303388E
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5137B2D979C;
	Sun,  1 Mar 2026 01:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svQAWwzs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A2582899
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329314; cv=none; b=LkezEeKz9l1DuqJw8zdbHFYpD2mhwKIlYNEVYjhegDcg8Coef9buLh77wTwZP/C8ohgdTI9oddAgvJJo8wqw3SFZjKhQ+Gv/oCBT3JG2i6mQHZEI1Tf6aFVqGtBsG+tt1oKm7QnQfnoQ2SXmViQ2+OGe9M36TtnuPkr7WMDhCkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329314; c=relaxed/simple;
	bh=XK485chqRAUqkZ6BF7Q8Flh4ocDzLimSDIKeo7CZc7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PvsCb6x9xE81kXIuOjNmJY5KtqI6tXUh9VG6xl1dWxGm+yCTD0hAsgWjUZmMYi53k9dPF584Uh5ahY10KYzoOFtsMV+JZq0bPhty+XCRZuJPSO+yJ+RY4bgyIipe2xzU8vSZ+fp6lWDO/OK5K1MnNEjE2Pj35VurhomVhceJLT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svQAWwzs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEB0C19421;
	Sun,  1 Mar 2026 01:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329314;
	bh=XK485chqRAUqkZ6BF7Q8Flh4ocDzLimSDIKeo7CZc7Y=;
	h=From:To:Cc:Subject:Date:From;
	b=svQAWwzssDK/yhSraStRq43nEaojDL9Cd8tdAxvXWjLyIGzcTxKKwqiKaGtUdj3eU
	 d6JV7lY1P1cyLLhQeDxG7vClXf47Lal8gTfYqk9CWAyPaUlBS8SPGDuy2EI0fGK0Fi
	 atvfbFcRQr7jS/+SGtuOYZUct4crIWlJp8QzOi1WWLswADvyDs/xyhfOSMRmM2W/Rn
	 ODvw+0RQ2L0jP3Q17+Ez2dsA2rIewe4ZGK47n/HOhjhjaIKWZAIcDjN6sjhWobNTWN
	 27yrpRMmWuioxM0/8K3UIVNdQ/ozJ9rKqzr/BFH4ssQL7vABpn4Yyg9jfDvojszzru
	 +ACdLVDKOdOfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	johan@kernel.org
Cc: Andrew Davis <afd@ti.com>,
	Nishanth Menon <nm@ti.com>,
	linux-arm-kernel@lists.infradead.org
Subject: FAILED: Patch "soc: ti: k3-socinfo: Fix regmap leak on probe failure" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:41:51 -0500
Message-ID: <20260301014152.1703596-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221861-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5983F1CBA6B
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c933138d45176780fabbbe7da263e04d5b3e525d Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 27 Nov 2025 14:49:42 +0100
Subject: [PATCH] soc: ti: k3-socinfo: Fix regmap leak on probe failure

The mmio regmap allocated during probe is never freed.

Switch to using the device managed allocator so that the regmap is
released on probe failures (e.g. probe deferral) and on driver unbind.

Fixes: a5caf03188e4 ("soc: ti: k3-socinfo: Do not use syscon helper to build regmap")
Cc: stable@vger.kernel.org	# 6.15
Cc: Andrew Davis <afd@ti.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Andrew Davis <afd@ti.com>
Link: https://patch.msgid.link/20251127134942.2121-1-johan@kernel.org
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/soc/ti/k3-socinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
index 50c170a995f90..42275cb5ba1c8 100644
--- a/drivers/soc/ti/k3-socinfo.c
+++ b/drivers/soc/ti/k3-socinfo.c
@@ -141,7 +141,7 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	regmap = regmap_init_mmio(dev, base, &k3_chipinfo_regmap_cfg);
+	regmap = devm_regmap_init_mmio(dev, base, &k3_chipinfo_regmap_cfg);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-- 
2.51.0





