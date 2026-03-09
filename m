Return-Path: <stable+bounces-223620-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EfzMCmyrmkSHwIAu9opvQ
	(envelope-from <stable+bounces-223620-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 12:42:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C16523811C
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 12:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39A7B304ADB5
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 11:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A9A3A0E85;
	Mon,  9 Mar 2026 11:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aN7ZKl1L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15E437883D
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 11:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056547; cv=none; b=AjZEni6vhCRDVxPR9IL1AHDbZsLvAei4gvWx3CYwDEiNTrsvpqtmT0h/flHdI/0ywuIxwJkDtvhJ6pJzcA8lJGkkoeCLTb7w1x8DkJmnN31r4HPtj0tUAKyp1roJuuVp+CT/AzJUSTD9syogJ736J0ODtcHm70h8U+LNvTibNJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056547; c=relaxed/simple;
	bh=4yDM0lfF7BoqLhkv0025L9Q3UBy/NJWhMbxL+NknpAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ch99QTjwlvuvEwFiB8quewlwLobKV2b6w1pAZbimlKnxl8yiXRoDYoti4ZUmTiRqA/oR7N+CJDUJo4JVz+tSKsQ469h+TURPo47JUcOxjDxDR4VhU1Eony0wZ2psWG2MiSpGvvvuhZMt5hITP0Vt7aDeMf3s15FHulVT+4ABOmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aN7ZKl1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02938C2BC86;
	Mon,  9 Mar 2026 11:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773056547;
	bh=4yDM0lfF7BoqLhkv0025L9Q3UBy/NJWhMbxL+NknpAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aN7ZKl1LpmMEmMjO3zw6OjqC012WXyICK2VZKMx+RwibAscAtY+UD6Fy1wibBJ7Ed
	 rNI5UoA4AmjN8BNVldKbp4zqZvokvRtVsEH4VQdf3JpByjLMNSahR1y4m7TohdUSXk
	 C9b/WRvWipclUIrBrCpbiIptmsve6lU5QPiMcCyjJMvsKV7A7AyN/c1HjZW/jAjMVZ
	 R16J15/vKOJP9+WFwchEU+HCMbV+iQcqEjC+/nT2PzC4zSgyyhg6ZsCG+1bH09e0ZW
	 +VvJatKWP5Rl9LfWPIJxlH2a6EeFkF1j57/kSo2j8YuYgXW+V4GdO9rYunE2aId8L8
	 L8XnhlGfQ+jKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daniil Dulov <d.dulov@aladdin.ru>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] wifi: cfg80211: cancel rfkill_block work in wiphy_unregister()
Date: Mon,  9 Mar 2026 07:42:24 -0400
Message-ID: <20260309114224.831897-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260309114224.831897-1-sashal@kernel.org>
References: <2026030934-cocoa-wrangle-1781@gregkh>
 <20260309114224.831897-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4C16523811C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223620-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,linuxtesting.org:url,aladdin.ru:email,intel.com:email]
X-Rspamd-Action: no action

From: Daniil Dulov <d.dulov@aladdin.ru>

[ Upstream commit 767d23ade706d5fa51c36168e92a9c5533c351a1 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index f291af14a6459..a844f5253aa41 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1104,6 +1104,7 @@ void wiphy_unregister(struct wiphy *wiphy)
 	/* this has nothing to do now but make sure it's gone */
 	cancel_work_sync(&rdev->wiphy_work);
 
+	cancel_work_sync(&rdev->rfkill_block);
 	cancel_work_sync(&rdev->conn_work);
 	flush_work(&rdev->event_work);
 	cancel_delayed_work_sync(&rdev->dfs_update_channels_wk);
-- 
2.51.0


