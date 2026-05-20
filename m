Return-Path: <stable+bounces-250622-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPGxHWnoDWrM4gUAu9opvQ
	(envelope-from <stable+bounces-250622-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:59:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00207592C25
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A473030C47DB
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7CD318EC7;
	Wed, 20 May 2026 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IxhhqL9n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D8A2701C4;
	Wed, 20 May 2026 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295893; cv=none; b=BCjRhIV+jws2nqNoMDOEsn5GfrNgQm8q6vXbYZwJBkq31BHH7LTM28tBZWwaVRIq8O/4xogt6/Bh6IhKJk7N+lquR78FHhnQNpz/7hWuDVDE97wx7h1PmBcv0rCTPnPKdDA4g4oxfRO/tBa0S0WWhtHzvmWlf0MZmSgjgLZxal4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295893; c=relaxed/simple;
	bh=OJJOghORRPaAZ1diCr+7t7xBGG2BJwpQK3X8TadK9ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4igowOnpe5+hNxKmX3uIBSsvyIGKRA/N8QyLRA25if9P2dhtEoTIFBXkWP6AZBP5H6CPRhPV/eEiEgbMBRprMr4j4PHTiQwKsyZE0v4TijewFEQmEiD+i3/pIv2L2I1VFnbpRP1TuPfu8GlwRspkXUkvVzq2F3wpKEeizvEdZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IxhhqL9n; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD9A1F000E9;
	Wed, 20 May 2026 16:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295891;
	bh=25m5qK2TywBH2XM+LmSGk+xNw5LyQ+RNoYtVWMNdgwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IxhhqL9npPYJz/NXOckJzw617IT5ISSqG11GtXccKjsW4q4d8I7GkKIcT9slnwoGO
	 sQDhKy7Zl6jalwHUJeL5kKwmXUV6s13lnEuj+eZlA5TE5S3M8VUhVGLTxaxjHzx4Ak
	 2QpaOk/e5mC6XZ+5A/PKgoJ7H6d8fpOR1kIKLgq4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen Ni <nichen@iscas.ac.cn>,
	Linus Walleij <linusw@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0591/1146] mtd: physmap_of_gemini: Fix disabled pinctrl state check
Date: Wed, 20 May 2026 18:14:01 +0200
Message-ID: <20260520162201.551608256@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250622-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,iscas.ac.cn:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 00207592C25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit b7c0982184b0661f5b1b805f3a56f1bd3757b63e ]

The condition for checking the disabled pinctrl state incorrectly checks
gf->enabled_state instead of gf->disabled_state. This causes misleading
error messages and could lead to incorrect behavior when only one of the
pinctrl states is defined.

Fix the condition to properly check gf->disabled_state.

Fixes: 9d3b5086f6d4 ("mtd: physmap_of_gemini: Handle pin control")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/maps/physmap-gemini.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/maps/physmap-gemini.c b/drivers/mtd/maps/physmap-gemini.c
index 9d3b4bf84a1ad..1c34b4ef77ea3 100644
--- a/drivers/mtd/maps/physmap-gemini.c
+++ b/drivers/mtd/maps/physmap-gemini.c
@@ -181,7 +181,7 @@ int of_flash_probe_gemini(struct platform_device *pdev,
 		dev_err(dev, "no enabled pin control state\n");
 
 	gf->disabled_state = pinctrl_lookup_state(gf->p, "disabled");
-	if (IS_ERR(gf->enabled_state)) {
+	if (IS_ERR(gf->disabled_state)) {
 		dev_err(dev, "no disabled pin control state\n");
 	} else {
 		ret = pinctrl_select_state(gf->p, gf->disabled_state);
-- 
2.53.0




