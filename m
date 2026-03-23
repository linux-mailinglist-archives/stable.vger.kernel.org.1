Return-Path: <stable+bounces-229146-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOszMLdtwWnDTAQAu9opvQ
	(envelope-from <stable+bounces-229146-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:43:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6B32F8AD0
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AE693011108
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179403B6BE4;
	Mon, 23 Mar 2026 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aOLr46xF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94FF27FB3A;
	Mon, 23 Mar 2026 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278206; cv=none; b=fXxr8ln9kWqGunCuhu0cdYGgVtDyRMcBDj1lp/Lagcu4ff5NMAjFtD0K1xc6MAHHd1T9vdZqt5tA7g3BuD6E8Z3LTPQikXuihCSnIrHdPnd/yQ7qcyZRsFElM9NgVa67v58nnWe3yO5h99ftuzaDRR2pYIzIi3R8M1uYiVOpjKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278206; c=relaxed/simple;
	bh=ZVYg+qJPwm1ONaOtiQQ37rtq2SNGnpThMrqpL/q7Tp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GB5xEYZdTMlwVIwRS1qwOOKqwaUO8qHc1SQ5nADz1WpSr9qtkixqY4XBewBzHAWgktyWZ1eTcETToc+SV8p5mkyKaW2Np96KPuoKnuBd88AIDsfvs3/4LIQEk2E8CkZd+pXZp6tYidgHs/MTpgEDE8r87+9pWEw3gAUV7LqCcfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aOLr46xF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA71C4CEF7;
	Mon, 23 Mar 2026 15:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278206;
	bh=ZVYg+qJPwm1ONaOtiQQ37rtq2SNGnpThMrqpL/q7Tp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aOLr46xFplNX+h4g8LL6CMoOhz7LjN42Grz5TpPB3z1ZtdEEkYtS0uyWdAmXWB8iq
	 X0VsHb3p/lXY418+Ba6hdZ3Nm4Xd1n3u5jVQ2Ypkc1ryUVPZMkpdMJFGgLyL7p10wo
	 kBBqoo+i09yBWmWvnji3J0nTJT5thDSWlecrx0Wc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qualys Security Advisory <qsa@qualys.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	Cengiz Can <cengiz.can@canonical.com>,
	Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>,
	John Johansen <john.johansen@canonical.com>
Subject: [PATCH 6.6 191/567] apparmor: fix side-effect bug in match_char() macro usage
Date: Mon, 23 Mar 2026 14:41:51 +0100
Message-ID: <20260323134538.578177431@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229146-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1E6B32F8AD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>

commit 8756b68edae37ff546c02091989a4ceab3f20abd upstream.

The match_char() macro evaluates its character parameter multiple
times when traversing differential encoding chains. When invoked
with *str++, the string pointer advances on each iteration of the
inner do-while loop, causing the DFA to check different characters
at each iteration and therefore skip input characters.
This results in out-of-bounds reads when the pointer advances past
the input buffer boundary.

[   94.984676] ==================================================================
[   94.985301] BUG: KASAN: slab-out-of-bounds in aa_dfa_match+0x5ae/0x760
[   94.985655] Read of size 1 at addr ffff888100342000 by task file/976

[   94.986319] CPU: 7 UID: 1000 PID: 976 Comm: file Not tainted 6.19.0-rc7-next-20260127 #1 PREEMPT(lazy)
[   94.986322] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   94.986329] Call Trace:
[   94.986341]  <TASK>
[   94.986347]  dump_stack_lvl+0x5e/0x80
[   94.986374]  print_report+0xc8/0x270
[   94.986384]  ? aa_dfa_match+0x5ae/0x760
[   94.986388]  kasan_report+0x118/0x150
[   94.986401]  ? aa_dfa_match+0x5ae/0x760
[   94.986405]  aa_dfa_match+0x5ae/0x760
[   94.986408]  __aa_path_perm+0x131/0x400
[   94.986418]  aa_path_perm+0x219/0x2f0
[   94.986424]  apparmor_file_open+0x345/0x570
[   94.986431]  security_file_open+0x5c/0x140
[   94.986442]  do_dentry_open+0x2f6/0x1120
[   94.986450]  vfs_open+0x38/0x2b0
[   94.986453]  ? may_open+0x1e2/0x2b0
[   94.986466]  path_openat+0x231b/0x2b30
[   94.986469]  ? __x64_sys_openat+0xf8/0x130
[   94.986477]  do_file_open+0x19d/0x360
[   94.986487]  do_sys_openat2+0x98/0x100
[   94.986491]  __x64_sys_openat+0xf8/0x130
[   94.986499]  do_syscall_64+0x8e/0x660
[   94.986515]  ? count_memcg_events+0x15f/0x3c0
[   94.986526]  ? srso_alias_return_thunk+0x5/0xfbef5
[   94.986540]  ? handle_mm_fault+0x1639/0x1ef0
[   94.986551]  ? vma_start_read+0xf0/0x320
[   94.986558]  ? srso_alias_return_thunk+0x5/0xfbef5
[   94.986561]  ? srso_alias_return_thunk+0x5/0xfbef5
[   94.986563]  ? fpregs_assert_state_consistent+0x50/0xe0
[   94.986572]  ? srso_alias_return_thunk+0x5/0xfbef5
[   94.986574]  ? arch_exit_to_user_mode_prepare+0x9/0xb0
[   94.986587]  ? srso_alias_return_thunk+0x5/0xfbef5
[   94.986588]  ? irqentry_exit+0x3c/0x590
[   94.986595]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   94.986597] RIP: 0033:0x7fda4a79c3ea

Fix by extracting the character value before invoking match_char,
ensuring single evaluation per outer loop.

Fixes: 074c1cd798cb ("apparmor: dfa move character match into a macro")
Reported-by: Qualys Security Advisory <qsa@qualys.com>
Tested-by: Salvatore Bonaccorso <carnil@debian.org>
Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>
Reviewed-by: Cengiz Can <cengiz.can@canonical.com>
Signed-off-by: Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/apparmor/match.c |   30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

--- a/security/apparmor/match.c
+++ b/security/apparmor/match.c
@@ -408,13 +408,18 @@ aa_state_t aa_dfa_match_len(struct aa_df
 	if (dfa->tables[YYTD_ID_EC]) {
 		/* Equivalence class table defined */
 		u8 *equiv = EQUIV_TABLE(dfa);
-		for (; len; len--)
-			match_char(state, def, base, next, check,
-				   equiv[(u8) *str++]);
+		for (; len; len--) {
+			u8 c = equiv[(u8) *str];
+
+			match_char(state, def, base, next, check, c);
+			str++;
+		}
 	} else {
 		/* default is direct to next state */
-		for (; len; len--)
-			match_char(state, def, base, next, check, (u8) *str++);
+		for (; len; len--) {
+			match_char(state, def, base, next, check, (u8) *str);
+			str++;
+		}
 	}
 
 	return state;
@@ -448,13 +453,18 @@ aa_state_t aa_dfa_match(struct aa_dfa *d
 		/* Equivalence class table defined */
 		u8 *equiv = EQUIV_TABLE(dfa);
 		/* default is direct to next state */
-		while (*str)
-			match_char(state, def, base, next, check,
-				   equiv[(u8) *str++]);
+		while (*str) {
+			u8 c = equiv[(u8) *str];
+
+			match_char(state, def, base, next, check, c);
+			str++;
+		}
 	} else {
 		/* default is direct to next state */
-		while (*str)
-			match_char(state, def, base, next, check, (u8) *str++);
+		while (*str) {
+			match_char(state, def, base, next, check, (u8) *str);
+			str++;
+		}
 	}
 
 	return state;



