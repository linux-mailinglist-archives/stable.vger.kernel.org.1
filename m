Return-Path: <stable+bounces-224342-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJfBLakEsGlAegIAu9opvQ
	(envelope-from <stable+bounces-224342-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:46:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB5E24B84F
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7AE4C30D1B32
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F0F38A712;
	Tue, 10 Mar 2026 11:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1cLwH7c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16706389469;
	Tue, 10 Mar 2026 11:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142036; cv=none; b=fcPKdzK5t6B5FRvUC/OLv+/MuHz0r5M3gImRmBXX0uKU41HxCmsozH4t9UvTY2pb9TodGJE7b6ero10BeXlj9KrRUktIeMvim+GCqX0n33eP72a1m+DkKFsxqqhsknF0gT2N3PEevfcTUHHO/U96+EFJpSG9k+OgbhKQRb3ypEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142036; c=relaxed/simple;
	bh=5+Fcfl+AFT9JliSN4VjWjJoIDSj9QMIoAs2A3MxQGGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZ43d7En7iiVwaVtUxn3cKzzT8Xl4T9cXdIMSD3k1wvmMCJLs6V4TAAStnnaeKIkLkFwEAK8LWVe+FxmWJPCA/W9GU49PkWibB3uTdxRWN7Z4fk3edpyxOK6wv32Jkmet+xBz+Y60UEloqLdQ+XHKBglpD/MJi6TgzD36fyua7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1cLwH7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E348C2BC86;
	Tue, 10 Mar 2026 11:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142036;
	bh=5+Fcfl+AFT9JliSN4VjWjJoIDSj9QMIoAs2A3MxQGGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B1cLwH7cE1kyJSrkE74DLydnbnzfR7LlX6jICU5MgW3WbAuVnppdQeDbPcKa0eS5x
	 hU3dS13VChBFmgG+qIydjAPHVoQ/zar/wOpld6audW0IfsEQnRKNGN8H6b/RADEMMm
	 tQX6BB0PsHpg21ScoW786rsfREsK6dfJFZkyzhuURKiyZYD5OJgHVVpZZk6QAQPsZB
	 OgbSuT5MNDrJllo+kylofapU947DL9Pb9HGIlVeByTduf7667IxVaPkr1k1nMGayBf
	 d4y9y4C5slpkdla+D+u0QZPB3IteklgTT7VSb742AR9RQcte3nF45stySI8ZNy1s/g
	 J75gPWvFH3FXw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Daniil Dulov <d.dulov@aladdin.ru>,
	Johannes Berg <johannes.berg@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.18 163/314] wifi: cfg80211: cancel rfkill_block work in wiphy_unregister()
Date: Tue, 10 Mar 2026 07:17:02 -0400
Message-ID: <f8ed1b55aca1a753bc14db69d7e3621b9c478506.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8BB5E24B84F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224342-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,linuxtesting.org:url,aladdin.ru:email,linuxfoundation.org:email]
X-Rspamd-Action: no action

From: Daniil Dulov <d.dulov@aladdin.ru>

commit 767d23ade706d5fa51c36168e92a9c5533c351a1 upstream.

There is a use-after-free error in cfg80211_shutdown_all_interfaces found
by syzkaller:

BUG: KASAN: use-after-free in cfg80211_shutdown_all_interfaces+0x213/0x220
Read of size 8 at addr ffff888112a78d98 by task kworker/0:5/5326
CPU: 0 UID: 0 PID: 5326 Comm: kworker/0:5 Not tainted 6.19.0-rc2 #2 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: events cfg80211_rfkill_block_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x116/0x1f0
 print_report+0xcd/0x630
 kasan_report+0xe0/0x110
 cfg80211_shutdown_all_interfaces+0x213/0x220
 cfg80211_rfkill_block_work+0x1e/0x30
 process_one_work+0x9cf/0x1b70
 worker_thread+0x6c8/0xf10
 kthread+0x3c5/0x780
 ret_from_fork+0x56d/0x700
 ret_from_fork_asm+0x1a/0x30
 </TASK>

The problem arises due to the rfkill_block work is not cancelled when wiphy
is being unregistered. In order to fix the issue cancel the corresponding
work in wiphy_unregister().

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 1f87f7d3a3b4 ("cfg80211: add rfkill support")
Cc: stable@vger.kernel.org
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
Link: https://patch.msgid.link/20260211082024.1967588-1-d.dulov@aladdin.ru
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/wireless/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 2ce6e39926d05..6b204ca91a140 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1195,6 +1195,7 @@ void wiphy_unregister(struct wiphy *wiphy)
 	/* this has nothing to do now but make sure it's gone */
 	cancel_work_sync(&rdev->wiphy_work);
 
+	cancel_work_sync(&rdev->rfkill_block);
 	cancel_work_sync(&rdev->conn_work);
 	flush_work(&rdev->event_work);
 	cancel_delayed_work_sync(&rdev->dfs_update_channels_wk);
-- 
2.51.0


