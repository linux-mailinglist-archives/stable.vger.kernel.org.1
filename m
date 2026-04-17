Return-Path: <stable+bounces-238426-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJNQIofT4WnQyQAAu9opvQ
	(envelope-from <stable+bounces-238426-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:30:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F404176E6
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 625D93036C1C
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 06:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39D03368B6;
	Fri, 17 Apr 2026 06:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="tqApBjn9"
X-Original-To: stable@vger.kernel.org
Received: from n169-111.mail.139.com (n169-111.mail.139.com [120.232.169.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF173321BF
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 06:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776407421; cv=none; b=jIZ+JhR/WlgVFYcbR4efsBhuqxVps9FAnHk6k5BZ1eJc9fWn3Ub5Wt2EZK5ZvPDF2UbvmyFW+G8Yu8WWIlRjKDK3ElW4vRJqE2IuVBh0OV4/IkBVCQ1Zyln8uqp856pDMqguALWJ/LIPoW01TQn8UfGmflShGAcfiO6HNOKsrHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776407421; c=relaxed/simple;
	bh=klvzAtotyxmyxgNmdw2hRsdLNFqkDpFiWuALZgLSsxk=;
	h=From:To:Subject:Date:Message-Id; b=mPFDlNtPczUE4/kVI6LIT3E1YEL+DJVNNXfiE1BQGeIrMsgBCvFD9IVaOhMKADqHT42hOesK6RCnUmc1mPCWW8WfsrRecXGfrhlj3Fr0qT3Oy0S/cUSYwFZLTzIk+oSBy++BWI0G54plvvIw3mQ7hbWRTudkChjhnh8D9cxOSeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=tqApBjn9; arc=none smtp.client-ip=120.232.169.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=tqApBjn9laq0nULh1gOrCm7ReDHSeakMfTctQ84nUzRfelnjk+arKFwVJCdqWQkyFeaHBA/jeqFCv
	 VrkJncTpn9Izve46Xo2WV0fl27P0L9iUPJOh5/PhX1gUXXCV+/hshHrnx1a2rPB1q75i3UlhIr0M5z
	 g3bXjE830yo3PJ9U=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[183.241.248.246])
	by rmsmtp-lg-appmail-10-12088 (RichMail) with SMTP id 2f3869e1d371ae6-26d5b;
	Fri, 17 Apr 2026 14:30:10 +0800 (CST)
X-RM-TRANSID:2f3869e1d371ae6-26d5b
From: Rajani Kantha <681739313@139.com>
To: d.dulov@aladdin.ru,
	johannes.berg@intel.com,
	stable@vger.kernel.org
Subject: [PATCH 5.15.y] wifi: cfg80211: cancel rfkill_block work in wiphy_unregister()
Date: Fri, 17 Apr 2026 14:30:04 +0800
Message-Id: <20260417063004.3267-1-681739313@139.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [1.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238426-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[139.com];
	NEURAL_SPAM(0.00)[0.934];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[681739313@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[139.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,139.com:mid,139.com:email,linuxtesting.org:url,intel.com:email]
X-Rspamd-Queue-Id: 62F404176E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Signed-off-by: Rajani Kantha <681739313@139.com>
---
 net/wireless/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 22e6fd12f201..7612b2725286 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1105,6 +1105,7 @@ void wiphy_unregister(struct wiphy *wiphy)
 	cancel_work_sync(&rdev->wiphy_work);
 
 	flush_work(&rdev->scan_done_wk);
+	cancel_work_sync(&rdev->rfkill_block);
 	cancel_work_sync(&rdev->conn_work);
 	flush_work(&rdev->event_work);
 	cancel_delayed_work_sync(&rdev->dfs_update_channels_wk);
-- 
2.17.1



