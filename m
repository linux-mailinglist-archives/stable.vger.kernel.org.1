Return-Path: <stable+bounces-245445-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iASOCLoZA2p10QEAu9opvQ
	(envelope-from <stable+bounces-245445-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:14:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE8751FE48
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 379EB30BF0CF
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 12:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601BC3655E4;
	Tue, 12 May 2026 12:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LaI4vFhT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7683655DE
	for <stable@vger.kernel.org>; Tue, 12 May 2026 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778587815; cv=none; b=EKpAcwDQMWSxw5Asf9+T911xZQeyHyq1AjtYcVl9cxCFY+R8HpftAZfO7IlMjUijfHP+AvMUWlA1jCwRkgumxsGqC9Q92GrXHgYtB+V/H/aByHx9i4y9BD3sy3Q2GVexdbf31ECAPHBrRz42TLVZrIA05YlVv7JnYCEgoE4338k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778587815; c=relaxed/simple;
	bh=JqoNNKb3IGj082gXvIZa1KzEZk+tY+k4tNKeO9hSb/0=;
	h=Subject:To:Cc:From:Date:Message-ID; b=u6lXCpxRBSwy9eNmv3+et9Ew6Hshcc4iZqAb3Ie+uwVd4iwtacoDQX8Hhgrtv0SYde2OUrj3IbzZ/+jXnxbMgPqWLE2wguzE+JobiwEpdEIBlo8fLzGPxagvV9JKaezTbzvfRdMYCCrOUjS7yhYN7jiL5Ri95adhk3oJDob6Op0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LaI4vFhT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F59C2BCB0;
	Tue, 12 May 2026 12:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778587814;
	bh=JqoNNKb3IGj082gXvIZa1KzEZk+tY+k4tNKeO9hSb/0=;
	h=Subject:To:Cc:From:Date:From;
	b=LaI4vFhT3HLIAuJpDVcvx0J3goMgXAzY8M6X5JvhKbwhnLL9GysFGzktJmbFTtV0w
	 /uENBLiSAUcMbj3uRds0WZzKWQUiwnpJNLRBbctA1eRD4n/QkgcSoz/6X+c5K8esgz
	 MudPxxPMlmzCKcWIKGZ9A1zLtByCmCTrO7IOW0Mk=
Subject: FAILED: patch "[PATCH] wifi: mac80211: remove station if connection prep fails" failed to apply to 6.1-stable tree
To: johannes.berg@intel.com,miriam.rachel.korenblit@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 14:10:17 +0200
Message-ID: <2026051217-dodge-brutishly-7223@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 6BE8751FE48
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245445-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,intel.com:email,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 283fc9e44ff5b5ac967439b4951b80bd4299f4e4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051217-dodge-brutishly-7223@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 283fc9e44ff5b5ac967439b4951b80bd4299f4e4 Mon Sep 17 00:00:00 2001
From: Johannes Berg <johannes.berg@intel.com>
Date: Tue, 5 May 2026 15:15:34 +0200
Subject: [PATCH] wifi: mac80211: remove station if connection prep fails

If connection preparation fails for MLO connections, then the
interface is completely reset to non-MLD. In this case, we must
not keep the station since it's related to the link of the vif
being removed. Delete an existing station. Any "new_sta" is
already being removed, so that doesn't need changes.

This fixes a use-after-free/double-free in debugfs if that's
enabled, because a vif going from MLD (and to MLD, but that's
not relevant here) recreates its entire debugfs.

Cc: stable@vger.kernel.org
Fixes: 81151ce462e5 ("wifi: mac80211: support MLO authentication/association with one link")
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20260505151533.c4e52deb06ad.Iafe56cec7de8512626169496b134bce3a6c17010@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 298ebff6bbf8..0a0f27836d57 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -9149,7 +9149,7 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_bss *bss = (void *)cbss->priv;
 	struct sta_info *new_sta = NULL;
 	struct ieee80211_link_data *link;
-	bool have_sta = false;
+	struct sta_info *have_sta = NULL;
 	bool mlo;
 	int err;
 	u16 new_links;
@@ -9168,11 +9168,8 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 		mlo = false;
 	}
 
-	if (assoc) {
-		rcu_read_lock();
+	if (assoc)
 		have_sta = sta_info_get(sdata, ap_mld_addr);
-		rcu_read_unlock();
-	}
 
 	if (mlo && !have_sta &&
 	    WARN_ON(sdata->vif.valid_links || sdata->vif.active_links))
@@ -9336,6 +9333,8 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 out_release_chan:
 	ieee80211_link_release_channel(link);
 out_err:
+	if (mlo && have_sta)
+		WARN_ON(__sta_info_destroy(have_sta));
 	ieee80211_vif_set_links(sdata, 0, 0);
 	return err;
 }


