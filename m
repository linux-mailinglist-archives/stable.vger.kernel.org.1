Return-Path: <stable+bounces-223624-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOc+MVG3rmnMIAIAu9opvQ
	(envelope-from <stable+bounces-223624-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 13:04:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D9523866C
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 13:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B598230197C4
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 12:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD778392C3D;
	Mon,  9 Mar 2026 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkWB8qbJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7153036BCE6
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773057706; cv=none; b=cQxSDmuMm4ofwWcD53MmcNMLafw90gnkx/GZq6uGrJ6IrkJHccV5YicCDB43XRF3TAmiJZlc0cCGyUnoX+dO4i+f6I7siAsBfHb1b+87I4t7kiN5Jgr5QA6VDZKWiNT7NeIqtOIN3bbH9tU2woecEiZBuDWSDrt4ec9eOEY842Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773057706; c=relaxed/simple;
	bh=5lGc+wi3X7vKmc7QZEleTu9/9KRiKbY6w9lw6uHdZyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AmHz4jRYhfnerbESniJOIjiZxLxUXhW+Wkc67JtRlT1N5Qmii/H/u5Ai8Y8M6jQIAL7CR+98VbQmDhoKSg4u8v0bPGGRw3XZF5oO2p7XW35ZDIzM7AyLkkmKrivW4BR9SxlSQ6BxzQSz9DamAr7XEuAg7/xLkZbcIqnjpDFP7gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkWB8qbJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A00C4CEF7;
	Mon,  9 Mar 2026 12:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773057706;
	bh=5lGc+wi3X7vKmc7QZEleTu9/9KRiKbY6w9lw6uHdZyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TkWB8qbJv/5LKEvWahj80TMmghguvhalYmaz3I9+E7YuTfunx2yfg7rZo0NF+Devx
	 KDkmPp6zwc0cLXjO/MCD54NUkjYmOaqk4d9/P6kUFayPAZkjtiy5aeTvWAMtUaBioF
	 bfAtHb3uzh0H2qIWgnSbI3IHAj8ZNE9Lg1eFdSewgvtGbjnGywAxNOmGiWv4IZf9FX
	 lqbbpx9FYYCy5bFYN3sLlmVRKmiAK+clI7hSVk1spnbRKqYOgXVCvsyvCKa5uyFwUP
	 xU2+rxTGY5R5avzqeHOrnu40+5iY4BgdjW/tNdhhS3KzMDK0zxgCiVYiOH19eYvdO1
	 H78jIektkN8yw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daniil Dulov <d.dulov@aladdin.ru>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] wifi: cfg80211: cancel rfkill_block work in wiphy_unregister()
Date: Mon,  9 Mar 2026 08:01:44 -0400
Message-ID: <20260309120144.846204-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026030935-cassette-expensive-04de@gregkh>
References: <2026030935-cassette-expensive-04de@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 80D9523866C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223624-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxtesting.org:url,intel.com:email,msgid.link:url,aladdin.ru:email]
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
[ Context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index cc2093f75468f..019f9767eda5f 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1046,6 +1046,7 @@ void wiphy_unregister(struct wiphy *wiphy)
 	rtnl_unlock();
 
 	flush_work(&rdev->scan_done_wk);
+	cancel_work_sync(&rdev->rfkill_block);
 	cancel_work_sync(&rdev->conn_work);
 	flush_work(&rdev->event_work);
 	cancel_delayed_work_sync(&rdev->dfs_update_channels_wk);
-- 
2.51.0


