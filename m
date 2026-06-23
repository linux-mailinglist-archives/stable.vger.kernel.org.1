Return-Path: <stable+bounces-267908-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V4buNgBUOmrh6AcAu9opvQ
	(envelope-from <stable+bounces-267908-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 11:38:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D26B26B5DBE
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 11:38:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=astralinux.ru header.s=mail header.b=R3bclCMi;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267908-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267908-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=astralinux.ru;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 304FE301AC81
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 09:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C08F3CF046;
	Tue, 23 Jun 2026 09:37:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2F9364038;
	Tue, 23 Jun 2026 09:37:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207462; cv=none; b=n2N6074vaCMPzhJGI0h8dYYIHWpPfucoWusd9CjVCIdDEkSgPMDRz/tpJHOl0joOFzn+xc2TGIC+DLYvXDtKF4KKcaAqTEAfA/2g+Vm3N/p3vZF+1xgvslrOWGDr6AWBldXAXlLVhvdnAFR/BrwzFBIhAMxLCt9FmdDlGbw0OFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207462; c=relaxed/simple;
	bh=gnPNQSYLiix7tXGVjov4UJH1hC5zANPz0y23QKnaIxU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FiStAYgK40QrxiB2wq4On5JBY8EnHMXMBySlqaa0JBXlUMzvMj8go1p07q8igtzqC9waD22a4sgsJ4ujiEN21LXDD0OcHs4809onXDcozWHgeSdy+w92cM/wNeRC8c10IiphDHwfTC5f7U8Mu8BqTigwiEcwG5sY2nSCz/SwAlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=R3bclCMi; arc=none smtp.client-ip=93.188.205.243
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1782207447;
	bh=gnPNQSYLiix7tXGVjov4UJH1hC5zANPz0y23QKnaIxU=;
	h=From:To:Cc:Subject:Date:From;
	b=R3bclCMie3wL9XXwdxRLJhA+SFhPIiMszZ3Ke2zxKi8JQzK3+hYRpSnrm9hzl5iq9
	 RwhgypwujTfdU7B3UWi3RPypWoXBMPm0KJtGxP+6YzWN6haji4yCuPuh5dT82qXL2P
	 cV5FR0PwxCjpiCvj2Dzf+njOxhbPbC/U45Bp8Ftptf71UYAeISLwLFZllEhDPtpBw7
	 aMwCUUsl524pNKenk4Ge9fTw9WlBc5fq9THEOtc6dA/wSM2vYzdq1It9aa0Il0aoBU
	 rQEHHiIZBAU3S/KQ+BrTtIHvUGtP4F2B2iXSU84JRoO0wws1Tw1wpnlRhxFlSxUDgf
	 HK7XfZ/xPcSPg==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id D1A8F1F706;
	Tue, 23 Jun 2026 12:37:27 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Tue, 23 Jun 2026 12:37:25 +0300 (MSK)
Received: from rbta-msk-lt-302690.astralinux.ru (rbta-msk-lt-302690.astralinux.ru [10.198.19.150])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4gl0N45RbCzJpkX;
	Tue, 23 Jun 2026 12:37:24 +0300 (MSK)
From: Alexandra Diupina <adiupina@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexandra Diupina <adiupina@astralinux.ru>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Sahitya Tummala <stummala@codeaurora.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Sahitya Tummala <quic_stummala@quicinc.com>,
	lvc-project@linuxtesting.org,
	Dongliang Mu <mudongliangabcd@gmail.com>
Subject: [PATCH 5.10] f2fs: fix UAF in f2fs_available_free_memory
Date: Tue, 23 Jun 2026 12:36:54 +0300
Message-Id: <20260623093654.13440-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: adiupina@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 108 0.3.108 b3af89ff4c48cefaff455d02ab4cd72c6de3312f, {Tracking_internal2}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;new-mail.astralinux.ru:7.1.1;astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 204005 [Jun 23 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/06/23 08:10:00 #28271465
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[astralinux.ru,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[astralinux.ru:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267908-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[astralinux.ru,kernel.org,codeaurora.org,lists.sourceforge.net,vger.kernel.org,quicinc.com,linuxtesting.org,gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[adiupina@astralinux.ru,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:adiupina@astralinux.ru,m:jaegeuk@kernel.org,m:chao@kernel.org,m:stummala@codeaurora.org,m:linux-f2fs-devel@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:quic_stummala@quicinc.com,m:lvc-project@linuxtesting.org,m:mudongliangabcd@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adiupina@astralinux.ru,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[astralinux.ru:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D26B26B5DBE

From: Dongliang Mu <mudongliangabcd@gmail.com>

commit 5429c9dbc9025f9a166f64e22e3a69c94fd5b29b upstream.

if2fs_fill_super
-> f2fs_build_segment_manager
   -> create_discard_cmd_control
      -> f2fs_start_discard_thread

It invokes kthread_run to create a thread and run issue_discard_thread.

However, if f2fs_build_node_manager fails, the control flow goes to
free_nm and calls f2fs_destroy_node_manager. This function will free
sbi->nm_info. However, if issue_discard_thread accesses sbi->nm_info
after the deallocation, but before the f2fs_stop_discard_thread, it will
cause UAF(Use-after-free).

-> f2fs_destroy_segment_manager
   -> destroy_discard_cmd_control
      -> f2fs_stop_discard_thread

Fix this by stopping discard thread before f2fs_destroy_node_manager.

Note that, the commit d6d2b491a82e1 introduces the call of
f2fs_available_free_memory into issue_discard_thread.

Cc: stable@vger.kernel.org
Fixes: d6d2b491a82e ("f2fs: allow to change discard policy based on cached discard cmds")
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
Backport fix for CVE-2022-20148
 fs/f2fs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8ab7d3f9a764b..28ec398ed0462 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4009,6 +4009,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 free_stats:
 	f2fs_destroy_stats(sbi);
 free_nm:
+	/* stop discard thread before destroying node manager */
+	f2fs_stop_discard_thread(sbi);
 	f2fs_destroy_node_manager(sbi);
 free_sm:
 	f2fs_destroy_segment_manager(sbi);
-- 
2.47.3

