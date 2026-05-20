Return-Path: <stable+bounces-251723-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKPEL5fzDWry4wUAu9opvQ
	(envelope-from <stable+bounces-251723-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:47:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF775948D4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6546F3122B6C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D5A3EEAC6;
	Wed, 20 May 2026 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GfMbzSL3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680DB3E123F;
	Wed, 20 May 2026 17:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298723; cv=none; b=Rl8wI0WWDmif+caSla4mGa9tH2gwYncUEcB68xI/KIjE+0/ud069NsTxr0pz46OFNw5Oaoznkb/jHRF0e5X+ugS44ktveq2lymQ9ZzbJ/Av8CCATgUcNsozooNi1OzZtlMHiRZhifTCGNU3+hs3LlRdtKDtKBXBEKzxQF7VzweM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298723; c=relaxed/simple;
	bh=eoYs07JkXSwwm+qStZ+rLD9rImxpKEqLOOYPSeBkZ2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rn141mLE6lx1wPhQ8ztfoy7N4JMf6Bf8YhSNFI1RNW4gb1wZXudhht5vdYAB1xHKX/VFe4Her7IWC2OubWQWEH+mRAFc8Q55O926am9uqq2231WPo4N+T91X/g2ZkGtlmxsjm3+6hLIeUggFTlnsbZeQThgyki1RO6SdBHjCzms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GfMbzSL3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0021F000E9;
	Wed, 20 May 2026 17:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298722;
	bh=OG6ZNtWVk/3Ze1g5/6nRT3tTGNRRuJvwaDv77zzemzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GfMbzSL3DLTlkph6hHHV7oSEEu3Nsl2KLOP2zrJyPYYNVsvUbpJnGkjt5iIKkq9Pz
	 aj+gvOP+H2bRE5VGH+K5lU2+v4YbV1OKG2n0TPfGxNrNYRQPtnpv48FHKj/0oOf3YM
	 7kJ/vufYXY7GuJFnTqEp7n5m1AXkIGjo1HIItQxE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Inochi Amaoto <inochiama@gmail.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 518/957] pinctrl: sophgo: pinctrl-sg2042: Fix wrong module description
Date: Wed, 20 May 2026 18:16:41 +0200
Message-ID: <20260520162145.767304617@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,outlook.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-251723-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,outlook.com:email]
X-Rspamd-Queue-Id: 3AF775948D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Inochi Amaoto <inochiama@gmail.com>

[ Upstream commit ca1c2ddff00480c213903a1479b56203536e92de ]

Fix the SoC model in module description string, it should be
sg2042 instead of sg2002.

Fixes: 1e67465d3b74 ("pinctrl: sophgo: add support for SG2042 SoC")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/sophgo/pinctrl-sg2042.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sophgo/pinctrl-sg2042.c b/drivers/pinctrl/sophgo/pinctrl-sg2042.c
index 185305ac897d9..8dba12e122a45 100644
--- a/drivers/pinctrl/sophgo/pinctrl-sg2042.c
+++ b/drivers/pinctrl/sophgo/pinctrl-sg2042.c
@@ -651,5 +651,5 @@ static struct platform_driver sg2042_pinctrl_driver = {
 };
 module_platform_driver(sg2042_pinctrl_driver);
 
-MODULE_DESCRIPTION("Pinctrl driver for the SG2002 series SoC");
+MODULE_DESCRIPTION("Pinctrl driver for the SG2042 series SoC");
 MODULE_LICENSE("GPL");
-- 
2.53.0




