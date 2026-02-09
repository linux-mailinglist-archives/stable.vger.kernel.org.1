Return-Path: <stable+bounces-215401-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEsIOVT4iWn5FAAAu9opvQ
	(envelope-from <stable+bounces-215401-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:08:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A3A11194B
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCF52310B452
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9963783C9;
	Mon,  9 Feb 2026 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g3eVyoas"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAD737A488;
	Mon,  9 Feb 2026 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648673; cv=none; b=pK+Sk5ESvhdYOXECIeE6kliZ/+x5w+Zt1Mj+oTCxVSw1E8Ah6au9ko5gYydNEKdMFS3FjaE9X6yqdKIXe9kGngBWJBgwZpWw2liGWINjcw3sahL5Ya2DbiomrvSHHMF3Io881L/HW7YmP8THRG4Tw3RnvcjZy7SUSSTmaAHX/5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648673; c=relaxed/simple;
	bh=1IseCWoVRocKjHrX09qiVXTfQC4rr4oZvBMkaZZ6xcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ehsvnn9NmDr3D6jl7Nz62Rqv9zQgJXI9tAgiqHc8PGpYWe2x4BjmbqkugTuuWzmj/v/PEnndN2KwNdHAHJNwHKusS2TQ2ap8QbbfRwpYgLMJkL5M2FEf79EaWYXk9A0K2Yvwt3MpCu4wb6TnhYXvHw24QNY9b22vujxfBUvrHwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g3eVyoas; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C37C116C6;
	Mon,  9 Feb 2026 14:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648672;
	bh=1IseCWoVRocKjHrX09qiVXTfQC4rr4oZvBMkaZZ6xcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g3eVyoasJkQ9jj+MPNBZ3gIWsyjcPx6OtIK/LzNqpD9Xq4CNSWXTwC61N0UKVO0nJ
	 L4in/vtYnIebZqJoIpydb/38pbFTdPi9Q8ANaMwXU0Trcn8KgmewRId9viIc315okC
	 nf97lOx8OaIkX6tMYdT3lYSLzOs1nhx8OmEYgQTQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 22/41] wifi: mac80211: dont increment crypto_tx_tailroom_needed_cnt twice
Date: Mon,  9 Feb 2026 15:24:43 +0100
Message-ID: <20260209142257.612591090@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142256.797267956@linuxfoundation.org>
References: <20260209142256.797267956@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-215401-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 55A3A11194B
X-Rspamd-Action: no action

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit 3f3d8ff31496874a69b131866f62474eb24ed20a ]

In reconfig, in case the driver asks to disconnect during the reconfig,
all the keys of the interface are marked as tainted.
Then ieee80211_reenable_keys will loop over all the interface keys, and
for each one it will
a) increment crypto_tx_tailroom_needed_cnt
b) call ieee80211_key_enable_hw_accel, which in turn will detect that
this key is tainted, so it will mark it as "not in hardware", which is
paired with crypto_tx_tailroom_needed_cnt incrementation, so we get two
incrementations for each tainted key.
Then we get a warning in ieee80211_free_keys.

To fix it, don't increment the count in ieee80211_reenable_keys for
tainted keys

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20260118092821.4ca111fddcda.Id6e554f4b1c83760aa02d5a9e4e3080edb197aa2@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/key.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 3df4695caef6c..d5b697701cff6 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -910,7 +910,8 @@ void ieee80211_reenable_keys(struct ieee80211_sub_if_data *sdata)
 
 	if (ieee80211_sdata_running(sdata)) {
 		list_for_each_entry(key, &sdata->key_list, list) {
-			increment_tailroom_need_count(sdata);
+			if (!(key->flags & KEY_FLAG_TAINTED))
+				increment_tailroom_need_count(sdata);
 			ieee80211_key_enable_hw_accel(key);
 		}
 	}
-- 
2.51.0




