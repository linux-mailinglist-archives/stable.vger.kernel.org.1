Return-Path: <stable+bounces-263977-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ANlREdBrMWqpiwUAu9opvQ
	(envelope-from <stable+bounces-263977-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:29:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CF969111C
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:29:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=2vXXOSNQ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263977-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263977-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E025930A64FE
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C5F1E8320;
	Tue, 16 Jun 2026 15:24:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EDC34D90C;
	Tue, 16 Jun 2026 15:24:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623487; cv=none; b=eafKSG+xsVPzlhglxTAz+g9BXdaUyvmuoRa+sY5l4GmmZXendYxaE4NMpkc3w9bfjysQ4NKqFZ95rg3rrzHFWjZRhEslbPHlB6ECtgKRj1dGNdokec+GF+smTYG5Ibut/XvkMdYIfd8CAd9OKVPe0Vm0T/xJ4B5wxvI2U39GhXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623487; c=relaxed/simple;
	bh=GTnd7TNoIsF9SU5uT/5W1803ARz6a2NDDfjGat7b7lY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VR91icPhPJayvkH0KbTugLd3HuYsT6iDPcwQyVjDH9dnpzRhbTSkkoU4FGhe9u4AVeyNd1PG/dVaZFfxQsOOwNeZkP8gOC15/9Y38fdsX5VtKr+YYZKVLfA0mRlmx5jgW1wK9WwE8n46uZEEaCQVkdKIHi4Xt1Dmf0lTYV1jv9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2vXXOSNQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2307D1F000E9;
	Tue, 16 Jun 2026 15:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623486;
	bh=IUS/pVNs6YJfr7VBwG8TP2r13uDKRIDT36zqCUBDkio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=2vXXOSNQ8WhPB4TKuq/RfdIMCeZPHaK85skQXgi4tXZN9hZxqhsDbNTJk0d2l1J6a
	 GUkZ32XlRp65PLG3OSVB+4l1OG0mdWl8VR7rBskMURkqVYpIXviJ2pD9PLBRtEooOI
	 KSvtpw88chHUXx+56+VlzkDxSoc6OkVmhFsWXsFI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Jani Nikula <jani.nikula@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 158/378] drm/i915/edp: Check supported link rates DPCD read
Date: Tue, 16 Jun 2026 20:26:29 +0530
Message-ID: <20260616145118.561493206@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263977-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:n.zhandarovich@fintech.ru,m:jani.nikula@intel.com,m:tursulin@ursulin.net,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxtesting.org:url,intel.com:email,fintech.ru:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90CF969111C

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

[ Upstream commit 2673cefa99ca918e7ac5b0388ff578a83656c896 ]

intel_edp_set_sink_rates() reads DP_SUPPORTED_LINK_RATES into a local
stack array and then parses the array unconditionally. If the read
fails, the array contents are not valid and may result in bogus sink
link rates being used.

Use drm_dp_dpcd_read_data() and clear the sink rate array on failure,
so the existing parser falls back to the default sink rate handling.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: 68f357cb7347 ("drm/i915/dp: generate and cache sink rate array for all DP, not just eDP 1.4")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patch.msgid.link/20260529145759.1640646-1-n.zhandarovich@fintech.ru
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
(cherry picked from commit bd61c7756b34157e093028225a69383b4b1203cc)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index d52205d714eee6..afd4169ac0a6c0 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -4533,10 +4533,17 @@ intel_edp_set_sink_rates(struct intel_dp *intel_dp)
 
 	if (intel_dp->edp_dpcd[0] >= DP_EDP_14) {
 		__le16 sink_rates[DP_MAX_SUPPORTED_RATES];
+		int ret;
 		int i;
 
-		drm_dp_dpcd_read(&intel_dp->aux, DP_SUPPORTED_LINK_RATES,
-				 sink_rates, sizeof(sink_rates));
+		ret = drm_dp_dpcd_read_data(&intel_dp->aux,
+					    DP_SUPPORTED_LINK_RATES,
+					    sink_rates, sizeof(sink_rates));
+		if (ret < 0) {
+			drm_dbg_kms(display->drm,
+				    "Unable to read eDP supported link rates, using default rates\n");
+			memset(sink_rates, 0, sizeof(sink_rates));
+		}
 
 		for (i = 0; i < ARRAY_SIZE(sink_rates); i++) {
 			int rate;
-- 
2.53.0




