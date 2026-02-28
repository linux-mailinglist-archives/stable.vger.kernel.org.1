Return-Path: <stable+bounces-221011-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGIvAwFIo2l//AQAu9opvQ
	(envelope-from <stable+bounces-221011-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:54:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FFB1C7854
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E0DD328BCEE
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98EF342C92;
	Sat, 28 Feb 2026 17:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESZsCIdF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A86E4BC002;
	Sat, 28 Feb 2026 17:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301354; cv=none; b=GzhVQI54zj8dNdD3YukcBwlwOBohzALMPhzUjoHfedmdm+bT6/ECjbf6LSD7MjE5mlZcnY7N+SpXmvO5WTM9JqoSzJWvZZX03U7W91v7k8bF2uYd1tqF3h3pFrta99I5pA8yOY3DnhZ9Oi4pptGoHGdIyjc+z3zGFBukQoIigpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301354; c=relaxed/simple;
	bh=xXJsk3Lae2xstEARdnH60ETU+GXhtsUK4YIx6sThe1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUbo48awrOyeKVBhYWj0Z9t0m1HtIDQtC/7RG7orziC+btpr016bFRtG8QvndUiooBQakKriUcmd0VFF97/+k5uSX9KSFm3bU09SWGt7aIym2o1C6m3SsldfRMUJEXNLqHaSu1yNWgWk5eLSPWRUJN4heJUtxhO8T4zy5YTfx2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESZsCIdF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C259DC19425;
	Sat, 28 Feb 2026 17:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301354;
	bh=xXJsk3Lae2xstEARdnH60ETU+GXhtsUK4YIx6sThe1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ESZsCIdFS/7rmsffacxKfLTzebpBKV+PQAKaXhNsjwEpiXQ2BOA3TN5yMX/h7HQpz
	 LHwqjlcTwueF+xjlBsXiqpsh7FZVSQx1VrVH6zFmrUux2KAOyvlIAko9TKGhmiaBXE
	 D71YgPZYw6MaF9lJx1Bhvxs3XrhogbpGLS3qa3y9K6Q0N+GZ51DY4oq92VFFFOeeNu
	 JNsoELP9TVF/RfPfKiNoCpBro3f1p7Hs5d1SwD8Fpee2p6wtpYVBkSOYVuhJ15UhJj
	 vWE7Q7YY7l4xeu9XElVzXD6VttbMSVmqCyWytRfx1cGbA6mIWnZaHT36fdEwCU5AhD
	 7soRmS5Cu22Hw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Andrew Davis <afd@ti.com>,
	Nishanth Menon <nm@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 542/752] soc: ti: k3-socinfo: Fix regmap leak on probe failure
Date: Sat, 28 Feb 2026 12:44:13 -0500
Message-ID: <20260228174750.1542406-542-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221011-lists,stable=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 83FFB1C7854
X-Rspamd-Action: no action

From: Johan Hovold <johan@kernel.org>

[ Upstream commit c933138d45176780fabbbe7da263e04d5b3e525d ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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


