Return-Path: <stable+bounces-215209-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNRgChPziWnGEgAAu9opvQ
	(envelope-from <stable+bounces-215209-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:45:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63330110E21
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0220A3018B96
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89BB37BE9A;
	Mon,  9 Feb 2026 14:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oKb84hxg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF7E36828A;
	Mon,  9 Feb 2026 14:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648037; cv=none; b=Ee6H3U4yMD4pb1+jGL3fVkTb4NyQ0t4Z4oZRwf40y+H2uscxHMxpvO/of97dtsgVhx/IHPcnJhCvlHP62IeSHC09W9llYEtAsOploJMNpk+Zv5Q793pnwVgrb7o1JuDvzsVu0uM2K3PPEMEx8Ta62jgrYklPg5ifyHK+0Hqr8iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648037; c=relaxed/simple;
	bh=ROvzAGDc4x7NUpYAOZa7V9TkV5UwtCZpHMnNjcbnA80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ajhu7pKAsL9RI1dJzJJUsaIhK2xIRr9dxgmzMf80+3vrxDewewoKc0Kde74NIVG7krfMD1OZ4uFvYJsYxJ1SfJD8qOEABXkdrNlL/R+I4csv+Dio0CA4x0Lwbn/hRxgrGNZAIA/oPREfOAWpSsneTg+jAnVK/2hwEH2FSOiQQsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oKb84hxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11B3C116C6;
	Mon,  9 Feb 2026 14:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648037;
	bh=ROvzAGDc4x7NUpYAOZa7V9TkV5UwtCZpHMnNjcbnA80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oKb84hxgexo0DB4mLu3MajnebXyzwstqdd3Z1mkROqHIopmT74EMvaiFd1UZCpCGU
	 WGLbkZEny8Cg8qSLFP7YSQSf6zYVLu+xbHizYNZPTCi6Q661z1ZYDDvP/dYh9gQEtZ
	 WJW4EngSX9013n8lhb0gTRD+GWxvMTd1QKvWCdBk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 069/113] wifi: mac80211: correctly check if CSA is active
Date: Mon,  9 Feb 2026 15:23:38 +0100
Message-ID: <20260209142312.669235643@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142310.204833231@linuxfoundation.org>
References: <20260209142310.204833231@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215209-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 63330110E21
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit db1d0b6ab11f612ea8a327663a578c8946efeee9 ]

We are not adding an interface if an existing one is doing CSA.
But the check won't work for MLO station interfaces, since for those,
vif->bss_conf is zeroed out.
Fix this by checking if any link of the vif has an active CSA.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20260111191912.7ceff62fc561.Ia38d27f42684d1cfd82d930d232bd5dea6ab9282@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/iface.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 50108fdb9361d..7e1b6a9d9f3ad 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -354,6 +354,8 @@ static int ieee80211_check_concurrent_iface(struct ieee80211_sub_if_data *sdata,
 	/* we hold the RTNL here so can safely walk the list */
 	list_for_each_entry(nsdata, &local->interfaces, list) {
 		if (nsdata != sdata && ieee80211_sdata_running(nsdata)) {
+			struct ieee80211_link_data *link;
+
 			/*
 			 * Only OCB and monitor mode may coexist
 			 */
@@ -380,8 +382,10 @@ static int ieee80211_check_concurrent_iface(struct ieee80211_sub_if_data *sdata,
 			 * will not add another interface while any channel
 			 * switch is active.
 			 */
-			if (nsdata->vif.bss_conf.csa_active)
-				return -EBUSY;
+			for_each_link_data(nsdata, link) {
+				if (link->conf->csa_active)
+					return -EBUSY;
+			}
 
 			/*
 			 * The remaining checks are only performed for interfaces
-- 
2.51.0




