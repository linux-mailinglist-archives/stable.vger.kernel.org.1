Return-Path: <stable+bounces-254603-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GhzLE4FF2rT1QcAu9opvQ
	(envelope-from <stable+bounces-254603-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:53:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E905E6495
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 834893331405
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C852741B37F;
	Wed, 27 May 2026 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="fPyDtgQV"
X-Original-To: stable@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F31421F05
	for <stable@vger.kernel.org>; Wed, 27 May 2026 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893113; cv=none; b=eZ1Tv4rh+bQ3r16ayFqE8gjARUu9SOC8TVH3DLU8HhRsHqi8nLmyqqiBWI1XgSk10XDZDC0D+RIOD2Zl+5S16MnbwmWTWbBWrH5e50HMuRSFuwNqxBBA/1F/+dtiV8Y+pfpNOY3W8FjH82ABmWrAoX8x2ukAbRwHj0gtt3q6MKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893113; c=relaxed/simple;
	bh=CwiB7im6pn6b4rVivEIv2oUMaX0jAuW2FeUwBliI+Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXit/poibDUT5AKIyntdyJYq4snGrsWF+cH5iUEjklRl8qqVh+bfVgL4SXLkbubCCn8PuA+SvUyWcDRqZZ+uEzJvUW/kkBjF5/Fsm7Af2CNHtsp84bXwwoXDc2Lb8d2lXCMgcVk5SctU5mXmri74jZOqxQjjClW9aXfvda4VQkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=fPyDtgQV; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1779893111;
	bh=Vfi7WkAkaKzQjlq2t3CxNnq4sW/XikH4X4sc46sN0qY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fPyDtgQVBb2AV/X6T3E9jpB/SCgIWIQzJ4EA3LlPMgy238hg08VMtZzqMeOtWVmiW
	 +1YKJNi34pn0r0zAU12Xy9ds9tXtCtw4dMdX6RPpTPp8L24WIZZ3jZ530UWCfTmaY3
	 KAl8W5vQ8cTNp4VwDcHUzxztE80Y2GIqE4Sn73PI=
Received: from stargazer (unknown [IPv6:2409:8a4c:e1b:e231:5a6e:b99e:242d:222b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 94C62659C8;
	Wed, 27 May 2026 10:45:09 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: stable@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v7.0.y 2/8] drm/amd/display: Backport dml21 DC_RUN_WITH_PREEMPTION_ENABLED addition from DC 3.2.373
Date: Wed, 27 May 2026 22:44:22 +0800
Message-ID: <20260527144428.1095001-3-xry111@xry111.site>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527144428.1095001-1-xry111@xry111.site>
References: <20260527144428.1095001-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[xry111.site,reject];
	R_DKIM_ALLOW(-0.20)[xry111.site:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254603-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xry111@xry111.site,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[xry111.site:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,xry111.site:email,xry111.site:mid,xry111.site:dkim]
X-Rspamd-Queue-Id: D0E905E6495
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


