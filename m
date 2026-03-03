Return-Path: <stable+bounces-222881-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCWtNrjhpmkPYQAAu9opvQ
	(envelope-from <stable+bounces-222881-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 14:27:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0541F02FC
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 14:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 564FA303E4BE
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 13:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC60423A9A;
	Tue,  3 Mar 2026 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJBewaEl"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4F8345CD3
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 13:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544123; cv=none; b=SFwD6qte1QmC8ZUx8XNEufgQqVOEeeA4xws2/WWwbYzw3XDSSHDa08rBgMypAozZuu6FSpAxyOMWHKizIzQ4cBKDQGWwDUSIQ0xoR7IUSJ6nWGTU2XnQE8u0J+RnoabdiPYPUZwlTfssuhe8gOh62/CUZhIcF0S0OSB93fll+2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544123; c=relaxed/simple;
	bh=S6IgDV3EkPgU7CqMUbZY4/ZqHUIrnR0zS7iri3Z1R2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V8LyxGSo5uz7cEd3CCPzRog0vbx6C0AorsuJI06DkpGz0z3fyHc60kaCB6dJGq8mxJIG7QsIhUSuGg4O0IlrhxPizYzt7n/arSfrLQoKBk55xE/zGGtgLqhBG+a1gwperqPn2zg2O35U8fjaYWSJMSMLJWZqIPsSNzdF/xBJiuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJBewaEl; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5ff07cb363dso3354279137.2
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 05:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772544121; x=1773148921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnryJSFJlY0DH3LD+RHWMuvCjKgvSwK47BtfG8A42dI=;
        b=bJBewaEl76/rSTgFND7nUSF8NW77RF7ivvSpoSIeBJNspsp3xS5tCrVtQ2RFt+nDrg
         8e4YD5RvWeiCs0f4ZdAwqUJz2m+tAi0NcNdFlcbOesJ9dG/ikPl/ya0QcAFVfuidmwaX
         UFmfHBpccUm+Zgy78qBwtVExjCWlotbFAQkkB3vu6Cb9ittxDkSObiRdncBFqVVzZJMR
         PRypcOZpF6T+g8XJgkSj+uAavIvys94b3KQmk8HPQVMei08traqrRJf2fZkO29F+iz8n
         yR8MScaiWCafC/JPCl0XojNfwNuczZJECUo6nCL/kU7VR2paMUikAr+eRr5X+jll33Rm
         zIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772544121; x=1773148921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JnryJSFJlY0DH3LD+RHWMuvCjKgvSwK47BtfG8A42dI=;
        b=juzSuzT/Yy7PXWLLQgLNxSwMnfltO4ODs8PFcbluz9hSmmFu6Net4i4nj889IB72/e
         CznuCp05ReLIHZYFxbf+W2NvwgXZyN+8wZlInA3fefCk9m4DwcpX22nalzsxPorspUOr
         yvZTy+7cIki2TAxWiL94snh6IEXx3wljEE9zLMi/K2OjF0/DMufY/siMknkp14GQI0vX
         vhxU7N1mtekLd8R0LkoMWKxSN+Id3Ma2hvpxKl0ZWE/OIAojxz8sW9jWqgKJATJBzrPe
         AZZD+VLzLD0e2rvuPJxwzNCkYTa5+hy2bb61Fgdzk5Huc3SNLAW/RmfJPMjXN9BS/GqB
         AYDA==
X-Gm-Message-State: AOJu0YxzT3ULlwfpHAZDLfA6zEWfepfs6/yrj9X1YZMPoNdDTbvYYn/6
	q+AaSCpg39THx/oXXBvxQ4AA7BKtWIsxjVxci5hqJKAGb409knGa0DRq+jkLJg==
X-Gm-Gg: ATEYQzzIs7rO70PDuLpPPWwzqFIIyiSqQr0wq2jupascXpjkrNaCTVMy3zXMqIfUBnO
	KwQhwc1oDKbQUgwk/y8hQtM7XT/iGmetC5UqFL9DhLeHVLO+kezKO/kJk8ZjT0AUc7jCeAwADzE
	db2Tq8EpeqAg8tmeEObj+Fk5MLPPPn7OrMJC1CTuMYyMNyUrNbgSpayy1gJtAgB6JQ6qELHepL3
	8gbDA3rXXYO3A6DOvrhd5JEBvSWUKlxoA67wd3N9ktKpUwBfBYRnEb1UibFi1Bpkd6WJFI/p4CM
	LTb0UxUdw3dL8zbnWLyy+8G7s6a5w7QdWl7pTBfvhE+5qFyt2wohdDMzF7qMf3ZlPciBNJKATB/
	pGlJqTy50Jgi46I6/3/o0780tbPSCIMkZunpgS9kVxM8vuS6N3qdnA3jXY9W9vlDB6S/6FWVOLP
	0c5J5RIJo1LBilpM4OA7Y65DuJiGbqS/kuhROlVAebWWYxbmFaBA2Zjm5JZ21hQ61PgjbXhOXBE
	6QNa4Y=
X-Received: by 2002:a05:6102:3747:b0:5fd:efb0:8562 with SMTP id ada2fe7eead31-5ff325a3a36mr7057394137.39.1772544121171;
        Tue, 03 Mar 2026 05:22:01 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:1b3:a802:8875:499e:12bf:3287:5753])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ff1ea6ea19sm16593553137.12.2026.03.03.05.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 05:22:00 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: stable@vger.kernel.org
Cc: broonie@kernel.org,
	alexander.stein@ew.tq-group.com,
	linux-sound@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH stable] ASoC: fsl_xcvr: provide regmap names
Date: Tue,  3 Mar 2026 10:21:43 -0300
Message-Id: <20260303132143.766078-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303132143.766078-1-festevam@gmail.com>
References: <20260303132143.766078-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3D0541F02FC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,ew.tq-group.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-222881-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[festevam@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tq-group.com:email,msgid.link:url]
X-Rspamd-Action: no action

From: Alexander Stein <alexander.stein@ew.tq-group.com>

commit 08fd332eeb88515af4f1892d91f6ef4ea7558b71 upstream.

This driver uses multiple regmaps, which will causes name conflicts
in debugfs like:
  debugfs: '30cc0000.xcvr' already exists in 'regmap'
Fix this by adding a name for the non-core regmap configurations.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Link: https://patch.msgid.link/20251216084931.553328-1-alexander.stein@ew.tq-group.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 sound/soc/fsl/fsl_xcvr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index 58db4906a01d..64eaa2fdeab7 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -1323,6 +1323,7 @@ static const struct reg_default fsl_xcvr_phy_reg_defaults[] = {
 };
 
 static const struct regmap_config fsl_xcvr_regmap_phy_cfg = {
+	.name = "phy",
 	.reg_bits = 8,
 	.reg_stride = 4,
 	.val_bits = 32,
@@ -1335,6 +1336,7 @@ static const struct regmap_config fsl_xcvr_regmap_phy_cfg = {
 };
 
 static const struct regmap_config fsl_xcvr_regmap_pllv0_cfg = {
+	.name = "pllv0",
 	.reg_bits = 8,
 	.reg_stride = 4,
 	.val_bits = 32,
@@ -1345,6 +1347,7 @@ static const struct regmap_config fsl_xcvr_regmap_pllv0_cfg = {
 };
 
 static const struct regmap_config fsl_xcvr_regmap_pllv1_cfg = {
+	.name = "pllv1",
 	.reg_bits = 8,
 	.reg_stride = 4,
 	.val_bits = 32,
-- 
2.34.1


