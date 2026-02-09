Return-Path: <stable+bounces-215347-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNoVDaD3iWl7FAAAu9opvQ
	(envelope-from <stable+bounces-215347-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:05:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8004E1117B1
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89FAB319AD54
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0913783C9;
	Mon,  9 Feb 2026 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G2S1XXfe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05C72690EC;
	Mon,  9 Feb 2026 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648497; cv=none; b=VhMkMwLdY1sPnBGA2cxVF89Vzcd4hE04cBST0IMwn/x6b2aHh66A17btMJdNL2G0ajlQ+ToT8W43IDrVoypxOoNqXVwJWUHYBc0ar7gfav1jxDRCJYS5riYPgKRnLFkbP1SYwj03v1kFioZdA16tZDopZnTVfzSKWZ4qFPtFS1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648497; c=relaxed/simple;
	bh=Uzf6xprqbLu4bTDYGkJLBKYzOtOwkZmfkwSvrpgCC7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bRJHJjG724JjU5PWzaGjgQe9Epv8gtpbMGQEvPSOmhynY4JPYS6PP2evaXovYkssPH8JdYCG9EWmBuLK/GeQNl3GHHEr09EceoAi0iyQSBXzIPJM8SKGpgdNJbVa3IO/Fe2708RY5rVj7dhSBRVCpIeV9zLCVS6sHpXHd7VujFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G2S1XXfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CEEBC116C6;
	Mon,  9 Feb 2026 14:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648497;
	bh=Uzf6xprqbLu4bTDYGkJLBKYzOtOwkZmfkwSvrpgCC7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G2S1XXfe1ylrJBj+ywDgD5GV9GVUyDvk0C8Ic6g8VndiMJuYsCs1+R3HfA1Or0VRA
	 pcbVj5BgPi2hL3bXlJP3H4ajfIBM0AXPhvdUUqJ1JEzoQQIARvNQ8NawV2/+easkni
	 qnBFWCyClbUK990yyHZuHPcmKDpiCiuQ9Dxp2Kvo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 54/86] wifi: mac80211: correctly check if CSA is active
Date: Mon,  9 Feb 2026 15:24:17 +0100
Message-ID: <20260209142306.724796390@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142304.770150175@linuxfoundation.org>
References: <20260209142304.770150175@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215347-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8004E1117B1
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index a531fb2b14dee..c8c53f4d1bdbf 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -347,6 +347,8 @@ static int ieee80211_check_concurrent_iface(struct ieee80211_sub_if_data *sdata,
 	/* we hold the RTNL here so can safely walk the list */
 	list_for_each_entry(nsdata, &local->interfaces, list) {
 		if (nsdata != sdata && ieee80211_sdata_running(nsdata)) {
+			struct ieee80211_link_data *link;
+
 			/*
 			 * Only OCB and monitor mode may coexist
 			 */
@@ -373,8 +375,10 @@ static int ieee80211_check_concurrent_iface(struct ieee80211_sub_if_data *sdata,
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




