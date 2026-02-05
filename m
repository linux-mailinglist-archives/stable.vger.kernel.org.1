Return-Path: <stable+bounces-214491-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GvmOCC2hGk54wMAu9opvQ
	(envelope-from <stable+bounces-214491-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 16:24:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B96F48E8
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 16:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0C6B303A131
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 15:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F96141C2F6;
	Thu,  5 Feb 2026 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="v96u4Vo3"
X-Original-To: stable@vger.kernel.org
Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE9F421EFB;
	Thu,  5 Feb 2026 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770305016; cv=none; b=LfdOw13rFGWdRLaOLnEH+SfZ74HzyiGT16JkT+hw+HiGhU8JTsk8yErSktQjBhkmiSRq/Rfc21Vus+fYZ5xv2qSnDGtszrWFdLW0ZIkHcm3KGrkFUcEbmcTjTPrlSKECzAKVayT8/bKPLjxH/3T+MUYaAHt0sJdLnN5WGfu9Bj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770305016; c=relaxed/simple;
	bh=3FPPKPLLjX8ulisIU3qtlaCy/etljM6rJ/pO9NrKWIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJoJ3z3N3ha+PoozU6Vnf98QtPhok3J4uoZ2umn4cKst0IqAeIojp10ogJLM8SFayWRBrXM1X7+iJ7PDRWbwq5rBDhtKFZzUfHvTX1tS0hjPsGgAYtmG47xsKiGPU1IlJR0ZdeC8+0WTLhUMA9tdICOJi3BXy9g8YUtWNsMDXvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=v96u4Vo3; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Received: from fedora (p4512038-ipxg00s01tokaisakaetozai.aichi.ocn.ne.jp [114.172.121.38])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 615ElrnL045624
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 5 Feb 2026 23:48:21 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=Iy63dnk4v66ntNaVeNlNQMC7btpSCCmyJG1nYU/ReBU=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:To:Subject:Date:Message-ID;
        s=rs20250315; t=1770302902; v=1;
        b=v96u4Vo3qyWBMXHnm5zVdWgq6GZKZ4RGRoPA9BDsWhgw6cl00nqhY9GSkP5lH62u
         SNVWSLjZrHLp5CLkEGmPd1p6AHCtOOISViJybPWxzauDKanJ6MmGGDtdlb/Un7yQ
         sEfoDf3cA4uPCaM4UbHwxTq9+CgkTXtUbtqutJSKhunCDBi3E1vdEha0KNpLk6gw
         RkzTleTMGD9HA2HypO1yTOCD8pS7gtQ+NOW3CXRUTl80H4R2CrHigc97Tyl7Wjvs
         N95Ff610KgYVNf1/9w4FRO0a+iunjKiPmV94YH5D1YHNAe3WM2rIKHCdyxzkhy5/
         rPeqjzFrgUtqQGC3C1KHgg==
From: Kenta Akagi <k@mgml.me>
To: Corey Minyard <corey@minyard.net>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Kenta Akagi <k@mgml.me>
Subject: [PATCH RFC 1/1] ipmi: Fix double list_add when sender returns an error
Date: Thu,  5 Feb 2026 23:47:39 +0900
Message-ID: <20260205144739.116409-2-k@mgml.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205144739.116409-1-k@mgml.me>
References: <20260205144739.116409-1-k@mgml.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mgml.me,none];
	R_DKIM_ALLOW(-0.20)[mgml.me:s=rs20250315];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214491-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[k@mgml.me,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[mgml.me:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 50B96F48E8
X-Rspamd-Action: no action

Since commit 9cf93a8fa951 ("ipmi: Allow an SMI sender to return an
error"), when the BMC does not respond, the sender returns an error, and
smi_work goes to restart.

However, curr_msg is not cleared during restart,
which results in a panic due to a double add to the list after restart.

[164050.860241] list_add double add: new=ffff8a5833cd0000, prev=ffff8a5833cd0000, next=ffff8a387b2491b0.
[164050.869744] ------------[ cut here ]------------
[164050.874698] kernel BUG at lib/list_debug.c:35!
[164050.879435] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[164050.884742] CPU: 5 UID: 0 PID: 99228 Comm: kworker/5:2 Kdump: loaded Tainted: G S          E       6.18.7-20260127.el9.x86_64 #1 PREEMPT(voluntary)
[164050.899481] Tainted: [S]=CPU_OUT_OF_SPEC, [E]=UNSIGNED_MODULE
[164050.905470] Hardware name: Dell Inc. PowerEdge R640/0X45NX, BIOS 2.15.1 06/15/2022
[164050.913285] Workqueue: events smi_work [ipmi_msghandler]
[164050.918865] RIP: 0010:__list_add_valid_or_report+0xb6/0xc0
[164050.924609] Code: c7 e8 b1 c3 89 48 8b 16 48 89 f1 4c 89 e6 e8 e1 16 a9 ff 0f 0b 48 89 f2 4c 89 e1 48 89 fe 48 c7 c7 40 b2 c3 89 e8 ca 16 a9 ff <0f> 0b 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90
[164050.943787] RSP: 0018:ffffceacac91fdc0 EFLAGS: 00010246
[164050.949271] RAX: 0000000000000058 RBX: ffff8a5833cd0000 RCX: 0000000000000000
[164050.956665] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8a773f89c1c0
[164050.964054] RBP: ffff8a5833cd0000 R08: 0000000000000000 R09: ffffceacac91fc78
[164050.971441] R10: ffffceacac91fc70 R11: ffffffff8a7e10c8 R12: ffff8a387b2491b0
[164050.978837] R13: 0000000000000000 R14: ffff8a387b249190 R15: ffff8a387b2491b0
[164050.986229] FS:  0000000000000000(0000) GS:ffff8a77b459d000(0000) knlGS:0000000000000000
[164050.994581] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[164051.000597] CR2: 00007ff95841be6c CR3: 000000063b022001 CR4: 00000000007726f0
[164051.007997] PKRU: 55555554
[164051.010970] Call Trace:
[164051.013690]  <TASK>
[164051.016055]  ? mutex_lock+0xe/0x30
[164051.019724]  deliver_response+0x59/0x100 [ipmi_msghandler]
[164051.025495]  smi_work+0xa0/0x370 [ipmi_msghandler]
[164051.030563]  process_one_work+0x19d/0x3d0
[164051.034844]  worker_thread+0x23e/0x360
[164051.038873]  ? __pfx_worker_thread+0x10/0x10
[164051.043423]  kthread+0xfb/0x230
[164051.046850]  ? __pfx_kthread+0x10/0x10
[164051.050872]  ? __pfx_kthread+0x10/0x10
[164051.054894]  ret_from_fork+0xe9/0x100
[164051.058826]  ? __pfx_kthread+0x10/0x10
[164051.062852]  ret_from_fork_asm+0x1a/0x30
[164051.067065]  </TASK>

This commit ensures that the next message is dequeued from the queue
upon restart.

Cc: stable@vger.kernel.org
Fixes: 9cf93a8fa951 ("ipmi: Allow an SMI sender to return an error")
Signed-off-by: Kenta Akagi <k@mgml.me>
---
 drivers/char/ipmi/ipmi_msghandler.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 3f48fc6ab596..17242b3cf53d 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -4814,7 +4814,7 @@ static void smi_work(struct work_struct *t)
 	unsigned long flags = 0; /* keep us warning-free. */
 	struct ipmi_smi *intf = from_work(intf, t, smi_work);
 	int run_to_completion = READ_ONCE(intf->run_to_completion);
-	struct ipmi_smi_msg *newmsg = NULL;
+	struct ipmi_smi_msg *newmsg;
 	struct ipmi_recv_msg *msg, *msg2;
 	int cc;
 
@@ -4826,6 +4826,7 @@ static void smi_work(struct work_struct *t)
 	 * message delivery.
 	 */
 restart:
+	newmsg = NULL;
 	if (!run_to_completion)
 		spin_lock_irqsave(&intf->xmit_msgs_lock, flags);
 	if (intf->curr_msg == NULL && !intf->in_shutdown) {
@@ -4854,6 +4855,7 @@ static void smi_work(struct work_struct *t)
 						     newmsg->recv_msg, cc);
 			else
 				ipmi_free_smi_msg(newmsg);
+			intf->curr_msg = NULL;
 			goto restart;
 		}
 	}
-- 
2.50.1


