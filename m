Return-Path: <stable+bounces-250308-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHVnLSDmDWpz4gUAu9opvQ
	(envelope-from <stable+bounces-250308-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:49:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F204592825
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D3253102935
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C78F372691;
	Wed, 20 May 2026 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JbCtzFZJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72E7370AE5;
	Wed, 20 May 2026 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295073; cv=none; b=C/IxZr6AnjR/KjeY7qVBkxx6jpvpIrkmpyCZPJ3JtiXFo8Lv+wvHQJjw650J5e9xfhInYfQlZaxgCfSA8/jhCXhQTAP+7cdzZwTBPfh1DbQyXm5tciAr3uun6Cd59GIabIKJuNXqIiuZSJ0/2+b5FlORtIWWRBhtBg4+JsLL49Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295073; c=relaxed/simple;
	bh=V3Lv8qXnindEvPjOyyGH+yd9xTWHKfmVlEdBkU9ECJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwxaypgVo0KiWKhadC5akVRzzspt7EHNIVi9m5Bq4H+52o0BU8TUdohF18zlxxwM5VACkKps3Xh/cA/zyZbxqjrz5KqwkkebXE2FXr2uWU+Pawjs5NroGzacrY2N26FJq+9IPtS6o+xaFKBHTlvD633ziZzC5X1ZSizUD+ukDag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JbCtzFZJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2D21F000E9;
	Wed, 20 May 2026 16:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295071;
	bh=6VGUXBLf7PmIdzHlpv0RvQVN2Jyx/t+QjeQA41+D0i0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JbCtzFZJDub9Q0J4XQMRRiXuVTX26KY0BN+ZzJRJ3MUq3iABk1F9uFYxqJ3o2n/Tz
	 st+1V95FvPur/ysA5A1y5t1jaqEXVVBJGDS38wVMt1Egq0dwe2wXooYxgosMXPQ25l
	 LkYPMKtL7v6cjO8HF24/ni74EwnpqdfbTThKM85Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lijo Lazar <lijo.lazar@amd.com>,
	Asad Kamal <asad.kamal@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0280/1146] drm/amd/pm: Fix xgmi max speed reporting
Date: Wed, 20 May 2026 18:08:50 +0200
Message-ID: <20260520162154.554556915@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-250308-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4F204592825
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

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
index 32d5e2170d80a..aa9deb7cd9da6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -262,8 +262,9 @@ static void smu_v13_0_12_init_xgmi_data(struct smu_context *smu,
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




