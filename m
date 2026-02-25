Return-Path: <stable+bounces-219407-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJlMLtWdnmk5WgQAu9opvQ
	(envelope-from <stable+bounces-219407-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:59:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F537192AD0
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF0E5301CC92
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AF130AD0B;
	Wed, 25 Feb 2026 06:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wQHdD8rM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B05031197B;
	Wed, 25 Feb 2026 06:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002695; cv=none; b=H1dQcVI/sMA5xm/wzOLDZMC54CtVGqOA6wzIkUkJ8NU73IWbU4tFGOAvXmRIUeQBLZb3UHsLkx6q7SqkCkNhSZ1eHnndPAWspQxJFG/9KmKYu2/nU+RXN00BN1BfqvXCYSnvGRgQm9KkfcEiHyUZ6ciIQ4vUV3ky9+FwyoMyoGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002695; c=relaxed/simple;
	bh=4j8dUV2/ZIayNb6jCMEnkj5KA+a81fcdGlFX4vWL+pI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZwbVrNhIItDXSYiLUIN6BjIwiN6u7OdkGsoGxDwUKSmB/JEOUJMkDm8w4U08nEsOEg63MurSP2X/lkWvQ7N28/rwu8l99xnTkfDjJzMg7wR5ly8MT+6zn7qc4Eyqdr/UwvigH+ixInnDF8kFsN7ai+Pmvf2cmgjU3kwiGUNHTrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wQHdD8rM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BACC19422;
	Wed, 25 Feb 2026 06:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002695;
	bh=4j8dUV2/ZIayNb6jCMEnkj5KA+a81fcdGlFX4vWL+pI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wQHdD8rMQ5O11MiABDHbw6rWM0/ZPspQIDi/gXoFzvSOWroEL5n5sx0dg9LH+wp3J
	 9VjGd7aljV89EWpIVTL0BfDPGGC1FxkwT+xQU2ic26XcfPNzpqzzHbixtpYRfh6X6E
	 1ZGfWKiMF67HhZ0GUJch/M0H/DO83kRfMaV2b6/w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 491/641] pinctrl: canaan: k230: Fix NULL pointer dereference when parsing devicetree
Date: Tue, 24 Feb 2026 17:23:37 -0800
Message-ID: <20260225012400.412715934@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-219407-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,iscas.ac.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F537192AD0
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>

[ Upstream commit d8c128fb6c2277d95f3f6a4ce28b82c8370031f6 ]

When probing the k230 pinctrl driver, the kernel triggers a NULL pointer
dereference. The crash trace showed:
[    0.732084] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000068
[    0.740737] ...
[    0.776296] epc : k230_pinctrl_probe+0x1be/0x4fc

In k230_pinctrl_parse_functions(), we attempt to retrieve the device
pointer via info->pctl_dev->dev, but info->pctl_dev is only initialized
after k230_pinctrl_parse_dt() completes.

At the time of DT parsing, info->pctl_dev is still NULL, leading to
the invalid dereference of info->pctl_dev->dev.

Use the already available device pointer from platform_device
instead of accessing through uninitialized pctl_dev.

Fixes: d94a32ac688f ("pinctrl: canaan: k230: Fix order of DT parse and pinctrl register")
Signed-off-by: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>
Signed-off-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-k230.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-k230.c b/drivers/pinctrl/pinctrl-k230.c
index d716f23d837f7..20f7c0f70eb77 100644
--- a/drivers/pinctrl/pinctrl-k230.c
+++ b/drivers/pinctrl/pinctrl-k230.c
@@ -65,6 +65,7 @@ struct k230_pmx_func {
 };
 
 struct k230_pinctrl {
+	struct device		*dev;
 	struct pinctrl_desc	pctl;
 	struct pinctrl_dev	*pctl_dev;
 	struct regmap		*regmap_base;
@@ -470,7 +471,7 @@ static int k230_pinctrl_parse_groups(struct device_node *np,
 				     struct k230_pinctrl *info,
 				     unsigned int index)
 {
-	struct device *dev = info->pctl_dev->dev;
+	struct device *dev = info->dev;
 	const __be32 *list;
 	int size, i, ret;
 
@@ -511,7 +512,7 @@ static int k230_pinctrl_parse_functions(struct device_node *np,
 					struct k230_pinctrl *info,
 					unsigned int index)
 {
-	struct device *dev = info->pctl_dev->dev;
+	struct device *dev = info->dev;
 	struct k230_pmx_func *func;
 	struct k230_pin_group *grp;
 	static unsigned int idx, i;
@@ -596,6 +597,8 @@ static int k230_pinctrl_probe(struct platform_device *pdev)
 	if (!info)
 		return -ENOMEM;
 
+	info->dev = dev;
+
 	pctl = &info->pctl;
 
 	pctl->name	= "k230-pinctrl";
-- 
2.51.0




