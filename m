Return-Path: <stable+bounces-235926-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCmwHIqR3Gl9TAkAu9opvQ
	(envelope-from <stable+bounces-235926-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:47:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CD73E7E83
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BCCBE30074EB
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1031E7660;
	Mon, 13 Apr 2026 06:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="dHnf1yBo"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE9135DA49
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062848; cv=none; b=i0+NKivU7JXxYcVk7neni/b2sGaLK17KwDi9RZPCNcv61tuz3/WWiP3eHByk7CvJTZJvvOvJ5P02/Fk30FwXt1KTo6cB/meZxtsGBT3uTmWXtqcA3qVN34CDCeEZyOeR9rbhDiFr+jaNEmsiOtRFOFD6e8o6HLtWC1HBsLrvUcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062848; c=relaxed/simple;
	bh=9ws5Ec8nZQtA0NXvePxTanlbmPt1PAgQFp4ilpp911s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQq/oQs7FwKdJgHfmulq24tD+22+Ihg2Tax5ebjdlrhIPBIOXgedgrst4UEwDwOmfbTj/fbzIyIT2DM0NSmcXJyQutlR480n72ey9AlOre0uNUiVY4H0R4+m8vDj2OOuzu8Xhh/1EO9FDJwMGPc/fl+5j38BPu5JPrz+2WgBKks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=dHnf1yBo; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 699B93F20E
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1776062845;
	bh=Dpzwv/aTw9s2C4TEGtd6qCotESnymZp5oxSEexBtB7s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=dHnf1yBoYlQn2UHknBbYGnLJcEhHfFD3ehCEMbk9DJUYVKhUCV9oZpTqHTM6DtdXP
	 EQzbeazdjfLCRqcdgn/ifFLBWQcDE216+Moskc3j4e6h4ZOidvDp5iJ1CrOO9VpBSs
	 ijw0i3g45kurLeWPTN/ajdUx6+3O/tUepogRznRaEumcCRbA3BusOWCE7ppg00C4BI
	 gCOiNrMHDcAXwUjFMl3hYq4STz3KJ9r/1I5e8IlBHb/GZsuum/1TNnCumAjAc4tIp0
	 eX+Co2Y9YNDLSD4NPe7i34rq/CvJDd/qqFh4/TjIHf3fHsB2CRwLM1/Il5PIla1SvU
	 x8XxJfVuFRgUwawTqAu8IGh+7YlODHGt0b9erXgwzygs14OhG24DyoDCIdEj0jQKqI
	 ZFw72UGOPZkGTDyz8C+Vo9Fj+dbD1m6IorMMUGOo3w0zM2O9234n2iCpl98Hc7Y4ml
	 sHRT/Xz22bgpwPftVZrMyb0BvPCwApPIvhKTI0EoRTyhAl4OQYtRqiPKKWKH51CBOp
	 jyLJRzQijE2qoy9BdhByh7OojypmPLY8/xy7olQLtTkJ4d2UioMQ0ZKMjAcliPNI6r
	 +APbuprhLD7W28lU/glJr/2p09S1wCiTwqakLzeXeSvmZ/RfEtxhtNYnLofaT2we77
	 RrLEVUVXO34i7zXlzwhp9EjE=
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82cdf02bce5so1776760b3a.2
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 23:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776062844; x=1776667644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dpzwv/aTw9s2C4TEGtd6qCotESnymZp5oxSEexBtB7s=;
        b=M/AzjR847NP7GMgmCcct9xpQuN3ZXzkKqRQ21RPbhBifW6bcJvUAzrBAJfEJcL2DMK
         o8r/EkJqa8O7UOA1VN1E6D48tU3IzHdaTKBMfeimhTQzsE9uMzJmK8IUaTMWqDh+5joE
         OudbaNcocdoQMIs9MXUAcdtiyXyhWpK+To7fgGPA3j7dPnPfTNzSZco4f3SgC9JoZnoU
         o6A1ovre9TvEJhjLGpLzl1hWRsZI9tgXKpMXQQXzdwGXRiQfmdIFHlwTv4wPVZ/Zg1AD
         t/iSO5HPZAiJM2+lhziF3Oz9NN9irk+6o+pIgF3pMMyQpdUf6iJBSK/HrZHyu5mN5haT
         GFbg==
X-Gm-Message-State: AOJu0YyPcIT+yybFCZy8eP26zWmWDOc/DlZ8R2/uyesdl3ahGB0GDunf
	llSEFpS4RjEyt1ddhg3xBhrl66WHFxRC+z+VUCNogzMaGXJ5iDAioas5TJTc6ugE+wD9EXk0Myx
	zPJ/viy5dqNEoc88GiYSXMRYrjDhx/FuvrD7oKLbBGP3B4pgbTeYmDbIGzEfcoOnNhaKCLMS8Hj
	1SwLYn3A==
X-Gm-Gg: AeBDiesUA3fsRXkmoBZ9mMzl6vNi7a+KIArk2zlb3LUjbSH9+LS9CLPVntX3npvRHaS
	rBbbxS1zOvpRrjr2qjZlIqujsTK9iZsiFJHd4Nivrp61BrLj5RHr8j9nEaQSL68yQpZ02oq3KKE
	vOBbGAscRz8Cj3j4ZVb0kOnfPJAZHMAnid6PiC5sYsWy3oOIehDjQnXQWBnxPYPZSgqXBaunDE+
	s9UIcNOdNnYOle34N8npzlBuhpkxvwCOfNE5UWfhN4EUM0L/9pYTFkB1xXUpgKbPl8ackjQu/3y
	a+jU6l+BHDOqpbxRFHjbL94rwdeTkAScVpPTmEimTEddTPNyNoMxLRvVVWBc7hGTg6TTpHpb1vB
	sQPvbg3Eh524QoJfo2tgRwHS/suk=
X-Received: by 2002:a05:6a00:1bcd:b0:82c:24d5:63e6 with SMTP id d2e1a72fcca58-82f0c169049mr11932194b3a.15.1776062843989;
        Sun, 12 Apr 2026 23:47:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:1bcd:b0:82c:24d5:63e6 with SMTP id d2e1a72fcca58-82f0c169049mr11932168b3a.15.1776062843532;
        Sun, 12 Apr 2026 23:47:23 -0700 (PDT)
Received: from localhost ([50.47.147.90])
        by smtp.googlemail.com with UTF8SMTPSA id d2e1a72fcca58-82f0c311a06sm11339535b3a.10.2026.04.12.23.47.22
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 23:47:23 -0700 (PDT)
From: John Johansen <john.johansen@canonical.com>
To: stable@vger.kernel.org
Subject: [PATCH 05/11] apparmor: fix side-effect bug in match_char() macro usage
Date: Sun, 12 Apr 2026 23:46:30 -0700
Message-ID: <20260413064712.1581137-6-john.johansen@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260413064712.1581137-1-john.johansen@canonical.com>
References: <20260413064712.1581137-1-john.johansen@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235926-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[john.johansen@canonical.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[canonical.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,canonical.com:dkim,canonical.com:email,canonical.com:mid]
X-Rspamd-Queue-Id: B3CD73E7E83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
 security/apparmor/match.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/security/apparmor/match.c b/security/apparmor/match.c
index 0e683ee323e3..ae07fe81b47f 100644
--- a/security/apparmor/match.c
+++ b/security/apparmor/match.c
@@ -452,13 +452,18 @@ unsigned int aa_dfa_match_len(struct aa_dfa *dfa, unsigned int start,
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
@@ -493,13 +498,18 @@ unsigned int aa_dfa_match(struct aa_dfa *dfa, unsigned int start,
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
-- 
2.51.0


