Return-Path: <stable+bounces-255891-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFVlIC2nGGpolwgAu9opvQ
	(envelope-from <stable+bounces-255891-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:35:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF93F5F9106
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78F6130F2107
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5692F39B4;
	Thu, 28 May 2026 20:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LWivg6hF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A8BDDC5;
	Thu, 28 May 2026 20:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000168; cv=none; b=ij0DJCrOvu+vz50LimVW+eUYrCUTGdAjjt1UL9K1BwGlJK1LSmgvq3B2acFzgiUNRXXuhWWC2VNFFhHxwAghHgYzAuW7DuOV6obwJlSjJYBhZl1eUQjVcmz33+02wSGlnM7bRYkoDDwxD6QFxXWjiflH6rLzIyD1h6OVuToeJxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000168; c=relaxed/simple;
	bh=SfxG+650dtm3QH/9f+OMVIrt+VdeDJqLPII1reGa0MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPx7+8IPWbRwf2ucJYjaOEoFZXaJtsIxOQre0ZfkIcCioHShoJgU5tu/hdwHLONg4/GZbCs8WZmtsT6SwNg1vWSsRfZSlIoJdizLf4Cf9SYLei+nC814cTNV83YAARq2cLMy2CqPicQDXIWNx0SgIWsFAKsRvOVv/UqLD05rLhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LWivg6hF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4040C1F000E9;
	Thu, 28 May 2026 20:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000167;
	bh=KrufPJpCoqxfPQsd+3CDbJEiNRF2XrJ3V7ZUAfoUuBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LWivg6hFnglVA04Av2LC973vC9YVyMzywi/xEqiBw8ITP0+ccHID/0uFnHUBDsOr1
	 H97x2+nucTtDRCr3o30ASBFpqUGrvFDrBKF9okeFrq7aRPZhe0cmZ2V9L+1FEvHrWT
	 47OdUezTKec+mqz1OpMu4/iLNA/1j5sZQsh/ttcI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Golle <daniel@makrotopia.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 327/377] net: dsa: mt7530: fix FDB entries not aging out with short timeout
Date: Thu, 28 May 2026 21:49:25 +0200
Message-ID: <20260528194647.875561003@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255891-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bridge_vlan_aware.sh:url,makrotopia.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,bridge_vlan_unaware.sh:url]
X-Rspamd-Queue-Id: EF93F5F9106
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Golle <daniel@makrotopia.org>

[ Upstream commit e824e40d0e841fab66ab7897d6c7b14dc81c66a7 ]

The DSA forwarding selftests bridge_vlan_aware.sh and
bridge_vlan_unaware.sh configure the bridge with ageing_time set to
LOW_AGEING_TIME (1000 centiseconds, i.e. 10 seconds) and then run
learning_test() in lib.sh, which expects a learned FDB entry to be
removed after ageing_time + 10 seconds. On MT7530/MT7531 the entry
persisted past the deadline and the "Found FDB record when should
not" assertion failed.

With msecs=10000, the algorithm in mt7530_set_ageing_time() finds
AGE_CNT=0 and AGE_UNIT=9 as the first exact match (starting the
search from tmp_age_count=0). The per-entry aging counter is
initialized to AGE_CNT when a MAC address is learned, so with
AGE_CNT=0 new entries start with a counter value of 0, which the
hardware treats as "already aged" and never removes, effectively
disabling aging.

Fix this by starting the search from tmp_age_count=1 to ensure
entries always have a non-zero initial aging counter. For a
10-second ageing time this yields AGE_CNT=1 and AGE_UNIT=4 instead:
the timer ticks every 5 seconds and entries are removed after 2
ticks.

Starting the search at AGE_CNT=1 raises the minimum representable
ageing time from 1 to 2 seconds. Without bounds, a stale ageing_time
of 1 second would now make the loop fall through without setting
age_count and age_unit, leaving them uninitialized when written to
the MT7530_AAC hardware register. Set ds->ageing_time_min and
ds->ageing_time_max so the DSA core validates the range before the
callback is invoked, and drop the now-redundant range check from
mt7530_set_ageing_time().

Fixes: ea6d5c924e39 ("net: dsa: mt7530: support setting ageing time")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Link: https://patch.msgid.link/7788ded12dc07b1bce329ec35fa70f4b45f3f9b7.1778766629.git.daniel@makrotopia.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mt7530.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 548b85befbf45..d6ce335f6688b 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -973,12 +973,16 @@ mt7530_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
 	unsigned int age_count;
 	unsigned int age_unit;
 
-	/* Applied timer is (AGE_CNT + 1) * (AGE_UNIT + 1) seconds */
-	if (secs < 1 || secs > (AGE_CNT_MAX + 1) * (AGE_UNIT_MAX + 1))
-		return -ERANGE;
-
-	/* iterate through all possible age_count to find the closest pair */
-	for (tmp_age_count = 0; tmp_age_count <= AGE_CNT_MAX; ++tmp_age_count) {
+	/* Applied timer is (AGE_CNT + 1) * (AGE_UNIT + 1) seconds.
+	 * The DSA core has already validated the range using
+	 * ds->ageing_time_min and ds->ageing_time_max.
+	 *
+	 * Iterate through all possible age_count values to find the closest
+	 * pair. Start from 1 because the per-entry aging counter is
+	 * initialized to AGE_CNT and a value of 0 means the entry will
+	 * never be aged out.
+	 */
+	for (tmp_age_count = 1; tmp_age_count <= AGE_CNT_MAX; ++tmp_age_count) {
 		unsigned int tmp_age_unit = secs / (tmp_age_count + 1) - 1;
 
 		if (tmp_age_unit <= AGE_UNIT_MAX) {
@@ -2378,6 +2382,8 @@ mt7530_setup(struct dsa_switch *ds)
 
 	ds->assisted_learning_on_cpu_port = true;
 	ds->mtu_enforcement_ingress = true;
+	ds->ageing_time_min = 2 * 1000;
+	ds->ageing_time_max = (AGE_CNT_MAX + 1) * (AGE_UNIT_MAX + 1) * 1000;
 
 	if (priv->id == ID_MT7530) {
 		regulator_set_voltage(priv->core_pwr, 1000000, 1000000);
@@ -2567,6 +2573,8 @@ mt7531_setup_common(struct dsa_switch *ds)
 
 	ds->assisted_learning_on_cpu_port = true;
 	ds->mtu_enforcement_ingress = true;
+	ds->ageing_time_min = 2 * 1000;
+	ds->ageing_time_max = (AGE_CNT_MAX + 1) * (AGE_UNIT_MAX + 1) * 1000;
 
 	mt753x_trap_frames(priv);
 
-- 
2.53.0




