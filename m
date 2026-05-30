Return-Path: <stable+bounces-257918-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HIBHHEgG2rO/QgAu9opvQ
	(envelope-from <stable+bounces-257918-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:37:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBA36100CD
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52363300D756
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72DD3AFAE2;
	Sat, 30 May 2026 17:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JoQlFM31"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E7D33E36A;
	Sat, 30 May 2026 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780162608; cv=none; b=DUXC36+TcbuCrgBgEMp+VtkIFoqHr4oPjsytxNC71zJyZrc9cRp3sZJF+aWag8L4g53mYYO6/aZ5MqgNvsW8ig95xK1DFqzDQDX8UJVQNYosgjazfpoLL1qsDdLJBe+iE8jGqCsjXbjpgF5KTxLLTeLVk4ZIwfsMmY0vAVdFc7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780162608; c=relaxed/simple;
	bh=fMpK22cX4dvFRZCWKpPjAbsSvCIk3Q18AnGyVkDU1nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aa/qacKYdZwFpFFEDkqyK2s4xy51q+BPTiw8QNfWKR0Pu/tu8JgMtCBZftjsYLD7f5JqZ/OVBvNE+BWFQj1yPUEbU6vB9FFbwncLsAPtLuI9tuxOkY95p8MJ7LrkjH8T/kNkBfOBKxCf6e1vaPmDG7LXz/W5UfbE2aeWhCD5rLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JoQlFM31; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2602C1F0089D;
	Sat, 30 May 2026 17:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780162606;
	bh=oAY9MrjvGIO37eka7sBXCWEXd0AG6UVldS+5woeCzvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JoQlFM31GWGXuC5aEKlt+PQ8aZpw9yWyxKVyjbc/87CQxatXhSWqWeEq0g8bxUtBX
	 8cvQTjsDyeJhT5iraT6abmLqeVZE7+zTaczLy2V1NKW2GQ19Rs1IeecJe+/2qOYLVB
	 dr9d9GQ0R38rcSSH/CW8h4DvNlopD5jjsoCPKXvg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Golle <daniel@makrotopia.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 951/969] net: dsa: mt7530: sync driver-specific behavior of MT7531 variants
Date: Sat, 30 May 2026 18:07:55 +0200
Message-ID: <20260530160327.021102300@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257918-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,makrotopia.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6BBA36100CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Golle <daniel@makrotopia.org>

[ Upstream commit 497041d763016c2e8314d2f6a329a9b77c3797ca ]

MT7531 standalone and MMIO variants found in MT7988 and EN7581 share
most basic properties. Despite that, assisted_learning_on_cpu_port and
mtu_enforcement_ingress were only applied for MT7531 but not for MT7988
or EN7581, causing the expected issues on MMIO devices.

Apply both settings equally also for MT7988 and EN7581 by moving both
assignments form mt7531_setup() to mt7531_setup_common().

This fixes unwanted flooding of packets due to unknown unicast
during DA lookup, as well as issues with heterogenous MTU settings.

Fixes: 7f54cc9772ce ("net: dsa: mt7530: split-off common parts from mt7531_setup")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Chester A. Unal <chester.a.unal@arinc9.com>
Link: https://patch.msgid.link/89ed7ec6d4fa0395ac53ad2809742bb1ce61ed12.1745290867.git.daniel@makrotopia.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: e824e40d0e84 ("net: dsa: mt7530: fix FDB entries not aging out with short timeout")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mt7530.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 1aba0cf38630f..308e56a73df01 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2558,6 +2558,9 @@ mt7531_setup_common(struct dsa_switch *ds)
 	struct mt7530_priv *priv = ds->priv;
 	int ret, i;
 
+	ds->assisted_learning_on_cpu_port = true;
+	ds->mtu_enforcement_ingress = true;
+
 	mt753x_trap_frames(priv);
 
 	/* Enable and reset MIB counters */
@@ -2701,9 +2704,6 @@ mt7531_setup(struct dsa_switch *ds)
 	if (ret)
 		return ret;
 
-	ds->assisted_learning_on_cpu_port = true;
-	ds->mtu_enforcement_ingress = true;
-
 	return 0;
 }
 
-- 
2.53.0




