Return-Path: <stable+bounces-237254-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABDNDnEh3WndaAkAu9opvQ
	(envelope-from <stable+bounces-237254-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:01:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 961813F0851
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 965B530471FD
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410133168EE;
	Mon, 13 Apr 2026 16:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="khkFkCrG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04219313298;
	Mon, 13 Apr 2026 16:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098983; cv=none; b=Vl5oEpaHWsg1QZhVn+JTG/xErw1yrxlQHUBK/AzyqedZc+n2YnGkyX0AssSwrOnmSUzL67rcRejz782z0yRyeqJ3hoBXvSF7x41nw/dbai4bDGzI+cBeR7c4sC6kCjIlB8ed9lQYvK7QvXDNYAtopd0SbjDaBdeFW34klROJrR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098983; c=relaxed/simple;
	bh=1EC87uYLW1YIcAsw94SWl81h2e8cORqJ22+j92TcTd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCy1/mcogorBfIHU+ygHdHUyGDaG0wotj2T6+OpVYrlMiYIAM7ED7rRlW6Ljo7g2P9cFOAXueKh1WTaqtuw470HGt43ZUrvsNPreumG/YwD263dpD86L2jveDElK4ofjUl0dvhwvfsuNwTdyCLiqfpAJ7kJVAkERt5/7a5Q0PqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=khkFkCrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F177C2BCAF;
	Mon, 13 Apr 2026 16:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098982;
	bh=1EC87uYLW1YIcAsw94SWl81h2e8cORqJ22+j92TcTd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=khkFkCrGnBf7XMb+s3mu/gC8A6oS+HpyuWP7ef93ImcgMXY8oSqnEm22nD37sPMTn
	 +Dht3cwrA7TNXpq7zc2tqJeMu9yiB9y+6DUZ7eEfZdDpe/o7BWp7oYBuBM+I0Wk2CZ
	 VvqYVfQzgTWPN3HIvLHmoJxu/PbOqZASR+SfvBcQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniil Dulov <d.dulov@aladdin.ru>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 164/491] wifi: cfg80211: cancel rfkill_block work in wiphy_unregister()
Date: Mon, 13 Apr 2026 17:56:49 +0200
Message-ID: <20260413155825.178972796@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237254-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,aladdin.ru:email,linuxtesting.org:url]
X-Rspamd-Queue-Id: 961813F0851
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/wireless/core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1046,6 +1046,7 @@ void wiphy_unregister(struct wiphy *wiph
 	rtnl_unlock();
 
 	flush_work(&rdev->scan_done_wk);
+	cancel_work_sync(&rdev->rfkill_block);
 	cancel_work_sync(&rdev->conn_work);
 	flush_work(&rdev->event_work);
 	cancel_delayed_work_sync(&rdev->dfs_update_channels_wk);



