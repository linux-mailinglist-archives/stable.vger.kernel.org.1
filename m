Return-Path: <stable+bounces-251446-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDV3Hpf7DWru5AUAu9opvQ
	(envelope-from <stable+bounces-251446-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:21:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9460595DE7
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF5963356FB5
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B893F44F7;
	Wed, 20 May 2026 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N+6ylQhj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79C930BF68;
	Wed, 20 May 2026 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298002; cv=none; b=ue2JNICAM04z60nn1CBczMjJ6QsL2Q+y+yx327i7O8KlvKL5WE32ednBmRYq/bxAccPlA7M2A1sg5EyqcCVcQ2l3fJL+e3tz+DFeVHALoOlPflIyEWeUi+0r2xt7eEkXBBiTmlLmZlxpBEJrSjz0LkZFfypqgG5wo+e1tgXFRTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298002; c=relaxed/simple;
	bh=YSWTIf81w4phPR1TMLq5G3sZ0FLBQzBaXiQm70Eay3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=miTKEl/vIlzbeF3pw6bpcWDaiP1ncD+NJ94yzwgLI9pt5wwuRwoeP1fSLh4LLSAOs5TDM8CLAIjW1hgeqA2d1RON+lRqpJxHIEhCnkRtsQSP9XlScXs7T0Wg73oPuGdmlWy3um8c+EO3pUIqEHwMnlJ2FSCsN4JFU2GpsE6F5a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N+6ylQhj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298371F000E9;
	Wed, 20 May 2026 17:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298001;
	bh=Ei8oXE0+mbWkhiroJU5mjay1fFcSbWiByk6DEFsarvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N+6ylQhjiScyXiHY0sraHEkyZiFSU7Sc0JgWp+TJbmU8/pXUmrQhsMYX7t0EWSiKW
	 8eUBQyd9RpTBE5punZxFxNzfE34KsYV9Pg2mS/g9RIUCuzGvKygj/64N946jfbilas
	 a9u7glwXKQ/zinaPREIJiSX/18i0QUzDfp1tE6ng=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lijo Lazar <lijo.lazar@amd.com>,
	Asad Kamal <asad.kamal@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 218/957] drm/amd/pm: Fix xgmi max speed reporting
Date: Wed, 20 May 2026 18:11:41 +0200
Message-ID: <20260520162139.268479625@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251446-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: E9460595DE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lijo Lazar <lijo.lazar@amd.com>

[ Upstream commit da16822ce5c32b5aca848eaea521936d4410d48c ]

Fix XGMI max bitrate/width reporting on SMUv13.0.12 SOCs. The data
format got changed when moved to static table from dynamic metrics
table.

Fixes: 1bec2f270766 ("drm/amd/pm: Fetch SMUv13.0.12 xgmi max speed/width")
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index cb3fea9e8cf31..72d56cfd9d287 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -248,8 +248,9 @@ static void smu_v13_0_12_init_xgmi_data(struct smu_context *smu,
 	int ret;
 
 	if (smu_table->tables[SMU_TABLE_SMU_METRICS].version >= 0x13) {
-		max_width = (uint8_t)static_metrics->MaxXgmiWidth;
-		max_speed = (uint16_t)static_metrics->MaxXgmiBitrate;
+		max_width = (uint8_t)SMUQ10_ROUND(static_metrics->MaxXgmiWidth);
+		max_speed =
+			(uint16_t)SMUQ10_ROUND(static_metrics->MaxXgmiBitrate);
 		ret = 0;
 	} else {
 		MetricsTable_t *metrics = (MetricsTable_t *)smu_table->metrics_table;
-- 
2.53.0




