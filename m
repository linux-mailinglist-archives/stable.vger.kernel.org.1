Return-Path: <stable+bounces-252917-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rccSFcH/DWqA5QUAu9opvQ
	(envelope-from <stable+bounces-252917-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:38:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC924596E13
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBC9F30B9D64
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F5D33CEA2;
	Wed, 20 May 2026 18:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LCONYX/f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6811B17A2FC;
	Wed, 20 May 2026 18:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301928; cv=none; b=CBHYnGp2zSIlWSAaWBic+Ks2gOoScO7eF/Zb91fMo1vYFSOswr6MrZ7NAyhVFO/o34cUCiUHTDdqwEvcIvnFtzTcXQAUlakQgAJGsk81dsTXrGH5ge0xrXjsbZSht/JIOR1ZeSDFom7in3M86kcNBkgy1bm81jXFN3Uuo1uj6qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301928; c=relaxed/simple;
	bh=Tt2qX5stI9I7+f9mgvrJvkWnGoR02pV/266nJQ3Rzdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIMTPIOQxHwKVY/4UDWMuGvP66VYkeZUEKbsuETHAEDquDLbZvT6EoF7brzHdIvFq9U0jOtH7ZqhbXRwHu6v1Ip07+jtiQTrO/JyfM5nw+qQ/ktZFG0gKo4AJET4G6DaU9+AEiyMofmYqB1K9qIYwNQGUT4M6wUAPY4DMM3v62c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LCONYX/f; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCA71F000E9;
	Wed, 20 May 2026 18:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301927;
	bh=mU0ur5DCRK2ADKLPqyVX/QrP9Uw6SwzDdVJ4+7sIurs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LCONYX/fWa0lkxxcHr27ZUw3IGhcW1shO6yFzQZc+HBzsI3hIMtYIYdXffqGXyZFI
	 4bClslD5qkXQSJOsNLv74EiG8FxA/iGnyh4VX8nXJS8Vg0OaBG2Do90aDbZAC1lTFU
	 LkclSDkF5lMI8XrUunqoZsCnW6p6ZyKhRKe8ACq8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luca Weiss <luca.weiss@fairphone.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 071/508] net: ipa: Fix programming of QTIME_TIMESTAMP_CFG
Date: Wed, 20 May 2026 18:18:14 +0200
Message-ID: <20260520162100.146128323@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252917-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,qualcomm.com:email,msgid.link:url,sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,fairphone.com:email]
X-Rspamd-Queue-Id: EC924596E13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luca Weiss <luca.weiss@fairphone.com>

[ Upstream commit de08f9585692813bd41ee654fca0487664c4de30 ]

The 'val' variable gets overwritten multiple times, discarding previous
values. Looking at the git log shows these should be combined with |=
instead.

Fixes: 9265a4f0f0b4 ("net: ipa: define even more IPA register fields")
Link: https://sashiko.dev/#/patchset/20260403-milos-ipa-v1-0-01e9e4e03d3e%40fairphone.com?part=4
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://patch.msgid.link/20260409-ipa-fixes-v1-1-a817c30678ac@fairphone.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ipa/ipa_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index da853353a5c72..f5924142021d2 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -369,7 +369,7 @@ static void ipa_qtime_config(struct ipa *ipa)
 {
 	const struct reg *reg;
 	u32 offset;
-	u32 val;
+	u32 val = 0;
 
 	/* Timer clock divider must be disabled when we change the rate */
 	reg = ipa_reg(ipa, TIMERS_XO_CLK_DIV_CFG);
@@ -380,8 +380,8 @@ static void ipa_qtime_config(struct ipa *ipa)
 	val = reg_encode(reg, DPL_TIMESTAMP_LSB, DPL_TIMESTAMP_SHIFT);
 	val |= reg_bit(reg, DPL_TIMESTAMP_SEL);
 	/* Configure tag and NAT Qtime timestamp resolution as well */
-	val = reg_encode(reg, TAG_TIMESTAMP_LSB, TAG_TIMESTAMP_SHIFT);
-	val = reg_encode(reg, NAT_TIMESTAMP_LSB, NAT_TIMESTAMP_SHIFT);
+	val |= reg_encode(reg, TAG_TIMESTAMP_LSB, TAG_TIMESTAMP_SHIFT);
+	val |= reg_encode(reg, NAT_TIMESTAMP_LSB, NAT_TIMESTAMP_SHIFT);
 
 	iowrite32(val, ipa->reg_virt + reg_offset(reg));
 
-- 
2.53.0




