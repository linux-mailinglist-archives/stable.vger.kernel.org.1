Return-Path: <stable+bounces-260141-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XaouJhVVIGov1QAAu9opvQ
	(envelope-from <stable+bounces-260141-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 18:23:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9E2639AF2
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 18:23:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=xry111.site header.s=default header.b=EFfgbJ74;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260141-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260141-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=xry111.site;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEE81315AE0A
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 15:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9873CDBAA;
	Wed,  3 Jun 2026 15:40:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD181F94F
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:40:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780501214; cv=none; b=hcdnjQ+SnrH2RLjr1T2oQRtzWHx/dKLaDIgLmONCzf6iWooYhcOGgUWTb6RyaxmY7+wPvvEkjUx9QkW7DM8KJgcL0C1Hcy8+3lgsghXNoYt686Axzh8MVRufO7seOcM7PoVOcEnvufTfhV2ZtYltGXfgQoNHHNEVaG9LJUv0ZWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780501214; c=relaxed/simple;
	bh=CwiB7im6pn6b4rVivEIv2oUMaX0jAuW2FeUwBliI+Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUbnY55H8gyyJ9pXP/QtRGa8VVRbGmb+n9mL/+iQZVETfUYeA0Brk7MtuV5I1e1asbR+KywSwii6G6JGY2l4M7mrtrpfbe7Qq6jiWfC1Je7mLUscbJlATP8VH+6wuexyxOH1a1ZHiNywb+OxGExA/GpVWZT5Rt54zOgWaHp+aB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=EFfgbJ74; arc=none smtp.client-ip=89.208.246.23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1780501212;
	bh=Vfi7WkAkaKzQjlq2t3CxNnq4sW/XikH4X4sc46sN0qY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EFfgbJ74bYVHNKEhwiBSaK7XX9tkLFB86GngfiJ4NDVGzY42TcUPm3raL7IdG32xK
	 /vewsr7ouC/SBsXd7rqHqsVeHruiHyzA7gABOzdwU2fsE9XG1dbvjQuU49mkWfvLzq
	 tVfUmrPTc1ZMj2GBkbmXQn4L/pz+A6ne7ANFvNDM=
Received: from stargazer (unknown [IPv6:2408:824e:307:6541:546a:40ae:5851:c0ef])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id AD28265BE5;
	Wed,  3 Jun 2026 11:40:10 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	amd-gfx@lists.freedesktop.org,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v7.0.y v2 2/8] drm/amd/display: Backport dml21 DC_RUN_WITH_PREEMPTION_ENABLED addition from DC 3.2.373
Date: Wed,  3 Jun 2026 23:39:14 +0800
Message-ID: <20260603153920.249671-3-xry111@xry111.site>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603153920.249671-1-xry111@xry111.site>
References: <20260603153920.249671-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[xry111.site,reject];
	R_DKIM_ALLOW(-0.20)[xry111.site:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260141-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:amd-gfx@lists.freedesktop.org,m:xry111@xry111.site,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[xry111@xry111.site,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xry111@xry111.site,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[xry111.site:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xry111.site:mid,xry111.site:dkim,xry111.site:from_mime,xry111.site:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E9E2639AF2

It's a part of the upstream commit e56e3cff2a1b ("drm/amd/display: Sync
dcn42 with DC 3.2.373") needed for the following backports moving FPU
guards from DML to DC.

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 .../amd/display/dc/dml2_0/dml21/dml21_wrapper.c    | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
index 96c62bd6a37b..2623e917ec28 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
@@ -9,16 +9,21 @@
 #include "dml21_utils.h"
 #include "dml21_translation_helper.h"
 #include "dml2_dc_resource_mgmt.h"
+#include "dc_fpu.h"
+
+#if !defined(DC_RUN_WITH_PREEMPTION_ENABLED)
+#define DC_RUN_WITH_PREEMPTION_ENABLED(code) code
+#endif // !DC_RUN_WITH_PREEMPTION_ENABLED
 
 #define INVALID -1
 
 static bool dml21_allocate_memory(struct dml2_context **dml_ctx)
 {
-	*dml_ctx = vzalloc(sizeof(struct dml2_context));
+	DC_RUN_WITH_PREEMPTION_ENABLED(*dml_ctx = vzalloc(sizeof(struct dml2_context)));
 	if (!(*dml_ctx))
 		return false;
 
-	(*dml_ctx)->v21.dml_init.dml2_instance = vzalloc(sizeof(struct dml2_instance));
+	DC_RUN_WITH_PREEMPTION_ENABLED((*dml_ctx)->v21.dml_init.dml2_instance = vzalloc(sizeof(struct dml2_instance)));
 	if (!((*dml_ctx)->v21.dml_init.dml2_instance))
 		return false;
 
@@ -28,7 +33,7 @@ static bool dml21_allocate_memory(struct dml2_context **dml_ctx)
 	(*dml_ctx)->v21.mode_support.display_config = &(*dml_ctx)->v21.display_config;
 	(*dml_ctx)->v21.mode_programming.display_config = (*dml_ctx)->v21.mode_support.display_config;
 
-	(*dml_ctx)->v21.mode_programming.programming = vzalloc(sizeof(struct dml2_display_cfg_programming));
+	DC_RUN_WITH_PREEMPTION_ENABLED((*dml_ctx)->v21.mode_programming.programming = vzalloc(sizeof(struct dml2_display_cfg_programming)));
 	if (!((*dml_ctx)->v21.mode_programming.programming))
 		return false;
 
@@ -70,8 +75,9 @@ static void dml21_init(const struct dc *in_dc, struct dml2_context *dml_ctx, con
 bool dml21_create(const struct dc *in_dc, struct dml2_context **dml_ctx, const struct dml2_configuration_options *config)
 {
 	/* Allocate memory for initializing DML21 instance */
-	if (!dml21_allocate_memory(dml_ctx))
+	if (!dml21_allocate_memory(dml_ctx)) {
 		return false;
+	}
 
 	dml21_init(in_dc, *dml_ctx, config);
 
-- 
2.54.0


