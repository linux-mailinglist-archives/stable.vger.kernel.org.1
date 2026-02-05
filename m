Return-Path: <stable+bounces-214490-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GSfLgG2hGk54wMAu9opvQ
	(envelope-from <stable+bounces-214490-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 16:23:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 586E3F48E0
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 16:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC69C302A2E7
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 15:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9404219FD;
	Thu,  5 Feb 2026 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="DIKMJ26K"
X-Original-To: stable@vger.kernel.org
Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2092342189D;
	Thu,  5 Feb 2026 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770305014; cv=none; b=hKcfwlQ1pVwL+8wIuvOiSDWscAjyu/uCPYRM9jbxgGG4ygVLsrlPae1LN3pMfJ8L1dZZdxb6ucSSa0E2FLzWVE2Odj6Cfw969K3PfFnkutW6QJ+kWKyHu6DxTskg3/3BIduzhvm/6Uq6N+zxKFcTxLADUL3KWsAEpZGNJfOIoFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770305014; c=relaxed/simple;
	bh=Wd+NCrE64efvHubZZSRpOUQ/ne5W+ehLq7mET1jtAtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SV4zZUqoua02q+R9Qu2ahM0zQsXu7F1LaClcKWnFIyknHmxif3tlC26riCmW/kP6FqJ23NIfPPe9q6HihOlM2mTyk5HZug0GhfzcfYYO/c2MmN55Zdhh9Tvul4jShaVfaBwyfsoORXXgmFpJwNtFkWWD4peA0J0AwTb5Msusxro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=DIKMJ26K; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Received: from fedora (p4512038-ipxg00s01tokaisakaetozai.aichi.ocn.ne.jp [114.172.121.38])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 615ElrnK045624
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 5 Feb 2026 23:48:17 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=FMqKTVC4tFP0KfvzabCCcACgxz50qsTjISdyUVdpNgQ=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:To:Subject:Date:Message-ID;
        s=rs20250315; t=1770302897; v=1;
        b=DIKMJ26Kqp0HZF3fW9AwgU4HbVrLlC5yVdTI8ecmwNhRQoG6S77D4XI+ZNFXiuvg
         WsJiXuPZd0FT6r4I3ER4raYTWcM9fPgP+vo1GFZ7WgjkTxRge3xIMbGJ7lwcDWUq
         jR6XsWG04IGQEaN9pu7a4/2uxhfeW5vwBQfwb4C1JACr4OB6K2C68hFXI5PiWaAN
         gJ+m4Nl1VKtdxcSt8XpTY/CZaV32AITsiobU2MtktRmjUML12HtlgS4reVaJLR9i
         kLTApkdBvrYCQ+gwmXfdXHBdh6uul4tg571V5kAXPhioE+geSc/C9tDqbZYxwfVL
         MEGGHVWgExe6u3bNI5ZUDw==
From: Kenta Akagi <k@mgml.me>
To: Corey Minyard <corey@minyard.net>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Kenta Akagi <k@mgml.me>
Subject: [PATCH RFC 0/1] ipmi: Fix double list_add when sender returns an error
Date: Thu,  5 Feb 2026 23:47:38 +0900
Message-ID: <20260205144739.116409-1-k@mgml.me>
X-Mailer: git-send-email 2.50.1
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
	TAGGED_FROM(0.00)[bounces-214490-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 586E3F48E0
X-Rspamd-Action: no action

In kernel 6.18.7, we encountered the following panic.

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

Because kdump was not properly configured, I was unable to inspect the
vmcore, but based on the oops and the current implementation, I infer
that the issue occurred via the following mechanism.

- The BMC becomes unstable
- Some kind of msg is queued in (hp_)xmit_msgs and smi_work runs
- (Because the BMC is unstable) intf->handlers->sender returns an error
- deliver_err_response() queues newmsg into intf->user_msg
- goto restart, but since intf->curr_msg is naturally non-NULL, no
  dequeue is performed from (hp_)xmit_msgs
- The same newmsg as before the restart goes through the same flow and
  deliver_err_response is executed, leading to a double add

I took a quick look at the BMC logs and there was a watchdog BMC reset
around the time of the panic, so I'm pretty sure the BMC was unstable.

I'm not sure if this is the correct approach, but I submit a RFC PATCH
in the spirit of a bug report. I would appreciate your feedback. You
can completely discard mine and fix it as a separate patch if you
prefer.

Thanks.

 
Kenta Akagi (1):
  ipmi: Fix double list_add when sender returns an error

 drivers/char/ipmi/ipmi_msghandler.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.50.1


