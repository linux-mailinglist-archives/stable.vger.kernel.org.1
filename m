Return-Path: <stable+bounces-222067-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MO2kCxmso2myJgUAu9opvQ
	(envelope-from <stable+bounces-222067-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:01:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C511CE235
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBE56340D57A
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A1E303CB0;
	Sun,  1 Mar 2026 01:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QD/9svt6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A17A3033F5
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329818; cv=none; b=Lyr4yNiiQqsAMc6wokJjOfjIVLxp4mcRMo0DKpZBJbzClABm3BUrg7aBmFrD3kgFlqmTPjaAw7KSAIPeFtlfIRDOi0uNFg6FZrR1biFMqs7MDaZFUtc/2UI37To7du7XriS6r/PvwzvTBQH2avc0ojxq0hLkJZg/+D3QJ+a94MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329818; c=relaxed/simple;
	bh=uGfV/++m4tGrtyJzvOCAf7ZAXaKn0ApjKBWRZ8SuvE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B+IVB5u3H7tk5TFhNJsKsIAy9nyy3sauhslNA6DXSYbADjpiLk6N1lGsE4r7KRwnZQOi5nRO1SKIlWYu7/8dNmjLepK8y6XnD4laIPxyxJ5eMcVGq8KfACqPnqp9RCLx8yW0A3sFOrFkoU/oL5tuUrfLrmvf7Zh5PRlb2qREE+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QD/9svt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90ABC19424;
	Sun,  1 Mar 2026 01:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329818;
	bh=uGfV/++m4tGrtyJzvOCAf7ZAXaKn0ApjKBWRZ8SuvE8=;
	h=From:To:Cc:Subject:Date:From;
	b=QD/9svt6nlAyNXc3wZHfMHjd03W7h4nW+YqRwLt6VH+eBOQUHsSZpW+/BowMYpT56
	 abULgehuwhNl8JTkwW62U7Q5Bm0BYsTsRxxE8whfhdWo2BnURscD2keJybitBNhRRt
	 RMb84Z66RNdiEQPTKBBZ69IjTU67RmYJofpQ5al9+/FVaThXmpw56q1Wea06jK5wZH
	 D40dx/AmAMzMn79ldnWuI/Xuec3qx6+AO+7xXh7ubn6udsBZVs0lJ7du/Jm5BEnFzZ
	 uCWGj4NJDIApusdNFEI1/ohBy6dQDohTHpilk9fNeoAi2riwi7/b+bIaMxx8LQJKnf
	 RTJ93BWeBncHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	johan@kernel.org
Cc: Andrew Davis <afd@ti.com>,
	Nishanth Menon <nm@ti.com>,
	linux-arm-kernel@lists.infradead.org
Subject: FAILED: Patch "soc: ti: k3-socinfo: Fix regmap leak on probe failure" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:50:16 -0500
Message-ID: <20260301015016.1716211-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222067-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:email]
X-Rspamd-Queue-Id: B2C511CE235
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
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





