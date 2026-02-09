Return-Path: <stable+bounces-215038-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JzxKEHxiWnyEgAAu9opvQ
	(envelope-from <stable+bounces-215038-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:37:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 423B7110945
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 647D4301B926
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C87377559;
	Mon,  9 Feb 2026 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dgkFQohi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C5123B604;
	Mon,  9 Feb 2026 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647467; cv=none; b=YhoCgFxXzmcWNVuJbdJexgwzo2VgWUyXfbGJ09+5NNVNTLLtY/RZDyVrAQvAuQ6QTLKWcJDhEUrSIxP8bLB4USkp0bNff25EJ0QGV02nWDklhPJAoPnXXoVf2hBwjb3Q/yj8cj+cRc+W+GwKnlzVe7UbzTz4ELJG7sWtRiLqh1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647467; c=relaxed/simple;
	bh=3embH6Jp3LHiXRCyOWbCI/1LodjxZTfDQ4ZEqr2kAv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohRrGHoS5AQDHjROHvxJAtASFpKUCWUV/+UNqc4C+pR4zE2f8zsfzzBVLzOgynAsmQxN+JSjay0+E1mSkaQqxYnK6Nfgq4v+pQWvd/Tt3I3NEf0HnZ9prXG4aj7xEGlwCRX9DHOs5XbZsSrHkfxB1lBzwSSxp5i9vdGXxBPQxe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dgkFQohi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CB0C116C6;
	Mon,  9 Feb 2026 14:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647467;
	bh=3embH6Jp3LHiXRCyOWbCI/1LodjxZTfDQ4ZEqr2kAv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dgkFQohiwGSAS9LJkYjNNvysB7ZCB92TOQR+Sm+/I1R6h8K98OezCuudbUAOR5W3h
	 4XGmcdlICses10MG8wLQ9uJKDm+LM4PruaUzADTnzlEcZXyW7tZvuL31wMtThTI6ML
	 R++V0lrGvyqbN/QHa0RG+leEgTsG6FrEDNvQolaM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 108/175] wifi: mac80211: dont increment crypto_tx_tailroom_needed_cnt twice
Date: Mon,  9 Feb 2026 15:23:01 +0100
Message-ID: <20260209142324.306296266@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
References: <20260209142320.474120190@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215038-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 423B7110945
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index d5da7ccea66e0..04c8809173d7f 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -987,7 +987,8 @@ void ieee80211_reenable_keys(struct ieee80211_sub_if_data *sdata)
 
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




