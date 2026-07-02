Return-Path: <stable+bounces-271455-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JkA+CJybRmokaAsAu9opvQ
	(envelope-from <stable+bounces-271455-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:10:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 690686FB17B
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:10:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=cnDp65GI;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271455-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271455-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACB69345277C
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A16318EC1;
	Thu,  2 Jul 2026 16:59:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAA922D7B9;
	Thu,  2 Jul 2026 16:59:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011589; cv=none; b=RQlPxJygHIhV/Xny2ncADmbPzuja8eLcgE9X32pNAsSieMQGgFUIFeIsv1WMbCwN7fPzIuSb+neGoTvduettoL0MnTGET6ffJFfZaO6ZXJt7E5XvOZJ2c/NmC7mScKjXS0pnvuA0V11ZUqkXfBqNGPcfRbBTfzl10OSDBih0H3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011589; c=relaxed/simple;
	bh=di3Gha1iEoV9eF87C3h8H+g3geoHi2mqj8d1BLOGJvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gx6HCdpazW1KFoaDvQD0MUd83MpNqYepw++ma6phWJALrkiIAj15VQeiqx5FaLljQLLO0f0Rd671QyztPp6F2f/U4VsetpTtjuqCcz/diqOMgsqrtjUpOs7BY+vhtPpJ6o+pyVDNBL6KC4XiLcsUQua0u2smtnVTy4fD8oR7Ccs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cnDp65GI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56A81F00A3A;
	Thu,  2 Jul 2026 16:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011588;
	bh=K6twDMSfXU6xBFdDY8A1OD3ut/hvtqWhEP4pxfSILzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cnDp65GIEabsauC/zaMfuEtIKeZbHwq7fTsHCi4xBGK7kmogscFMDWKM1dXiTllKK
	 5u+aERS0CJ4fN2CKUm7D+UxZRxJPgsnQ61OezGfX8p8e1wNYu8E/KWN9wx3/ik0jVY
	 tx3AAjjFKnAdy7ZSGXR7THwxhVhf5pa6LoqzlhWE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuhao Jiang <danisjiang@gmail.com>,
	Junrui Luo <moonafterrain@outlook.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 7.1 058/120] wifi: iwlwifi: mld: validate sta_mask before ffs() in BA session handlers
Date: Thu,  2 Jul 2026 18:20:54 +0200
Message-ID: <20260702155114.163901015@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.964534952@linuxfoundation.org>
References: <20260702155112.964534952@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-271455-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:danisjiang@gmail.com,m:moonafterrain@outlook.com,m:miriam.rachel.korenblit@intel.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,outlook.com,intel.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,outlook.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,intel.com:email,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 690686FB17B

7.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junrui Luo <moonafterrain@outlook.com>

commit f056fc2b927448d37eca6b6cacc3d1b0f67b20d2 upstream.

Three BA session handlers use ffs(ba_data->sta_mask) - 1 to derive a
station ID without checking that sta_mask is non-zero. When sta_mask is
zero, ffs() returns 0 and the subtraction wraps to 0xFFFFFFFF, causing
an out-of-bounds access on fw_id_to_link_sta[].

Add WARN_ON_ONCE(!ba_data->sta_mask) guards before each ffs() call,
consistent with the existing check in iwl_mld_ampdu_rx_start().

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Link: https://patch.msgid.link/SYBPR01MB788115C6CE873271A9A15A25AF51A@SYBPR01MB7881.ausprd01.prod.outlook.com
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mld/agg.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/net/wireless/intel/iwlwifi/mld/agg.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/agg.c
@@ -64,6 +64,9 @@ static void iwl_mld_release_frames_from_
 	}
 
 	/* pick any STA ID to find the pointer */
+	if (WARN_ON_ONCE(!ba_data->sta_mask))
+		goto out_unlock;
+
 	sta_id = ffs(ba_data->sta_mask) - 1;
 	link_sta = rcu_dereference(mld->fw_id_to_link_sta[sta_id]);
 	if (WARN_ON_ONCE(IS_ERR_OR_NULL(link_sta) || !link_sta->sta))
@@ -166,6 +169,9 @@ void iwl_mld_del_ba(struct iwl_mld *mld,
 		goto out_unlock;
 
 	/* pick any STA ID to find the pointer */
+	if (WARN_ON_ONCE(!ba_data->sta_mask))
+		goto out_unlock;
+
 	sta_id = ffs(ba_data->sta_mask) - 1;
 	link_sta = rcu_dereference(mld->fw_id_to_link_sta[sta_id]);
 	if (WARN_ON_ONCE(IS_ERR_OR_NULL(link_sta) || !link_sta->sta))
@@ -347,6 +353,9 @@ static void iwl_mld_rx_agg_session_expir
 	}
 
 	/* timer expired, pick any STA ID to find the pointer */
+	if (WARN_ON_ONCE(!ba_data->sta_mask))
+		goto unlock;
+
 	sta_id = ffs(ba_data->sta_mask) - 1;
 	link_sta = rcu_dereference(ba_data->mld->fw_id_to_link_sta[sta_id]);
 



