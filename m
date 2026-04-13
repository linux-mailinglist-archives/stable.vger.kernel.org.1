Return-Path: <stable+bounces-235934-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LSmCDiS3Gl9TAkAu9opvQ
	(envelope-from <stable+bounces-235934-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:50:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4B53E7EEE
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 287F03011C43
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E4F375ADF;
	Mon, 13 Apr 2026 06:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="ZMCuexF4"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216AF1FC101
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062952; cv=none; b=jlCk5si07dHAl1AFi0Vp4EqzkNHk3ilxN45AFTswkh56GKzXHqnidQoh15rbiH64xlQUO9MA6urGzjF7o/pA0LKj+TnQ8cH+NW2eX2hfDVDOVMPXvv+aDfr/SsC6IIjRZoUrFt6c1uUVYhdOC7zUW8lhsMKClM0d1Ezjq0/ZFAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062952; c=relaxed/simple;
	bh=Uv76UbxLCtHLXW7zFwCRuXTy2ICJgdbYIk8MFy6DaAE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqqAGfxvYNSN/72yibW8dNh1ZCNFx377OulnJVu4rwQW8sYdVKEvQdTYvLm/7YZaUkczHHmt4SINrG3BgC0oPvasJDuLmdRzU8fLgQe/xk/5BJymqtgVlAi7SCM0Ex+QBBVXEAJQ5na2x/9fB4x2MPo81FTGDAaAlF5WOem6Kj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=ZMCuexF4; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 54C313F1CC
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1776062589;
	bh=jRimhRSeNz4PqjerWU+ZkoLNJUjW9NBVcj09LqruSng=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=ZMCuexF4Mr/eHx87P/4bTm6YqK1avmFGkMXpnUMgs1gmXBz+89JDgVK79ccUMSWRi
	 W0T41F+tXaITEZNgonLnvGoeKysFOY/trulzZGvNq+O5c+xTmNryAHuzvMv73e7EZO
	 0Bugs6G9t2cE+SckgDe9eETdVrsW5pp+EmZZvxHCjURW5NTo9PBLmX7Ya+9oyGyijv
	 YXS8o0wUAfqwXe/BfnnLAomvFjYyj1dDnJfhuBmwFAj/3WLD/PBdwZAIrIK0KuKf59
	 PXA4Wk/x7Q21343hlOIjB9plHGGT13y9Grm2clUSDuDomvedXEb0iAB1BH32t2dyz9
	 THpBfhdf9Bv3Bv0SlzA2LdARpoWHMmjtn1eftJg6SMjHZ/s6dcibz3MmuuJVFKDF+G
	 C6zeqpI+CDUyoxD31Mw/LPZ4n0sLRM2OfKzg8Y2SGVkV8wBQb5mhxranTBvcJSS2oQ
	 JBmKrPOdQG5A+M7M1E2lDjAUe7MQXAxEAPw8zTw4V/b/KnZWPC2aTK/TakEV8IB39X
	 amSaEz/UfBtbFMX/fLINVJX2OCNNXtMzli3X+QxQYw3Z+fZ0wv4143fO1pO155yM+u
	 i+HGWtJ7bYSUT6f6zRLe+/QXsNh5NXLpInOi/hcPIZUDCgAZECLf9/Cv/x93wPVm0E
	 SlOEV8edtIzBZj/AeGAoxg+8=
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35daf3d3030so4538912a91.1
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 23:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776062588; x=1776667388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jRimhRSeNz4PqjerWU+ZkoLNJUjW9NBVcj09LqruSng=;
        b=FGtrv+gi1RHPBgF9+qQW8maDvbnIb8U+FWcboG/R7d2SvLquS1HJYUB2fDGAhUdGHm
         6M5/TdPv4U8sOjsHO+j7ta48GQaEXeDIQ1NceYEl1g3mO9ZE1VNlC6Bl1yErhVvXXrvA
         +0tHCSbSP0GxMBV63986AcShbKvTX9q64YGVeOiYjm8HoyRlZL177jsgdDvjtTGfuqd9
         4cFwc8TJuWckQAZXrvtL2y8whT5aG7chr4qXs7+4yTzkaLlF9lbXJnfFb2JfC6emh+UD
         BcJTBo74xgDEPh803XpJRxCsxojqLMNab87ZFEJCu19aoKfkVZ9q/pLcZ8m6JBI/Xkgv
         DpgQ==
X-Gm-Message-State: AOJu0YzE3x0vxtU+kmM+rrqVt9kfzrxTN5OUzo07xxF5n+3ztBKfTSlv
	A0xZ0vWhGO9ovXBuq7jFgqm/BZDyhfTfGaMftxnRvWIMEmJDx7ACRhGr4PAhTRbKpUz/+PTuNzk
	PLGx2Xms7QIStclbd15UTGQd9NtegLhp1eL9jOb75p0saHoB8h3Ps6hFAWl/NgM/yDaZXnCtEzR
	IHhkQT+g==
X-Gm-Gg: AeBDiet69OXDnfwbLv8W1n+mQgITUjm2SeLf1ti3svTt/qB/af5tf2Emn5OOLbtO+m8
	b/REZ5HpC8o/sk2Aar+hW23hiAhOzntYRPbPtmFDo8SLU6sbrcWwnyz4ZqbapyQwGkM60rYp+W8
	xvICnVvRkgAW7iEGoY6Gq+0BPK2NaedqhsIArLYMjuhlP2pJGlKZke5vti/Pbf+LjR0PmkhJV+7
	uLI4TyFgnweqci4t45XsDKHMGokqdwy2ZLl0gegih84AX7Rod/g6qeH2xAWJR6wHYJWN12t4AYk
	j3BOWO0F9u1nl/G9aDv546BfGk1E7xnai79hvez+ULC+BUhSH9PU5j8zfyLFu/LGeKQoHjJWSEU
	F9ARpbhsPD3p4R7pfioi6HuaBWac=
X-Received: by 2002:a17:90b:5547:b0:35f:b7f5:9cd with SMTP id 98e67ed59e1d1-35fb7f512c8mr1933720a91.20.1776062587917;
        Sun, 12 Apr 2026 23:43:07 -0700 (PDT)
X-Received: by 2002:a17:90b:5547:b0:35f:b7f5:9cd with SMTP id 98e67ed59e1d1-35fb7f512c8mr1933708a91.20.1776062587441;
        Sun, 12 Apr 2026 23:43:07 -0700 (PDT)
Received: from localhost ([50.47.147.90])
        by smtp.googlemail.com with UTF8SMTPSA id 98e67ed59e1d1-35fb27060f2sm3366977a91.1.2026.04.12.23.43.06
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 23:43:07 -0700 (PDT)
From: John Johansen <john.johansen@canonical.com>
To: stable@vger.kernel.org
Subject: [PATCH 06/11] apparmor: fix missing bounds check on DEFAULT table in verify_dfa()
Date: Sun, 12 Apr 2026 23:39:15 -0700
Message-ID: <20260413064256.1578919-7-john.johansen@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260413064256.1578919-1-john.johansen@canonical.com>
References: <20260413064256.1578919-1-john.johansen@canonical.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235934-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:dkim,canonical.com:email,canonical.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E4B53E7EEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>

commit d352873bbefa7eb39995239d0b44ccdf8aaa79a4 upstream.

The verify_dfa() function only checks DEFAULT_TABLE bounds when the state
is not differentially encoded.

When the verification loop traverses the differential encoding chain,
it reads k = DEFAULT_TABLE[j] and uses k as an array index without
validation. A malformed DFA with DEFAULT_TABLE[j] >= state_count,
therefore, causes both out-of-bounds reads and writes.

[   57.179855] ==================================================================
[   57.180549] BUG: KASAN: slab-out-of-bounds in verify_dfa+0x59a/0x660
[   57.180904] Read of size 4 at addr ffff888100eadec4 by task su/993

[   57.181554] CPU: 1 UID: 0 PID: 993 Comm: su Not tainted 6.19.0-rc7-next-20260127 #1 PREEMPT(lazy)
[   57.181558] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   57.181563] Call Trace:
[   57.181572]  <TASK>
[   57.181577]  dump_stack_lvl+0x5e/0x80
[   57.181596]  print_report+0xc8/0x270
[   57.181605]  ? verify_dfa+0x59a/0x660
[   57.181608]  kasan_report+0x118/0x150
[   57.181620]  ? verify_dfa+0x59a/0x660
[   57.181623]  verify_dfa+0x59a/0x660
[   57.181627]  aa_dfa_unpack+0x1610/0x1740
[   57.181629]  ? __kmalloc_cache_noprof+0x1d0/0x470
[   57.181640]  unpack_pdb+0x86d/0x46b0
[   57.181647]  ? srso_alias_return_thunk+0x5/0xfbef5
[   57.181653]  ? srso_alias_return_thunk+0x5/0xfbef5
[   57.181656]  ? aa_unpack_nameX+0x1a8/0x300
[   57.181659]  aa_unpack+0x20b0/0x4c30
[   57.181662]  ? srso_alias_return_thunk+0x5/0xfbef5
[   57.181664]  ? stack_depot_save_flags+0x33/0x700
[   57.181681]  ? kasan_save_track+0x4f/0x80
[   57.181683]  ? kasan_save_track+0x3e/0x80
[   57.181686]  ? __kasan_kmalloc+0x93/0xb0
[   57.181688]  ? __kvmalloc_node_noprof+0x44a/0x780
[   57.181693]  ? aa_simple_write_to_buffer+0x54/0x130
[   57.181697]  ? policy_update+0x154/0x330
[   57.181704]  aa_replace_profiles+0x15a/0x1dd0
[   57.181707]  ? srso_alias_return_thunk+0x5/0xfbef5
[   57.181710]  ? __kvmalloc_node_noprof+0x44a/0x780
[   57.181712]  ? aa_loaddata_alloc+0x77/0x140
[   57.181715]  ? srso_alias_return_thunk+0x5/0xfbef5
[   57.181717]  ? _copy_from_user+0x2a/0x70
[   57.181730]  policy_update+0x17a/0x330
[   57.181733]  profile_replace+0x153/0x1a0
[   57.181735]  ? rw_verify_area+0x93/0x2d0
[   57.181740]  vfs_write+0x235/0xab0
[   57.181745]  ksys_write+0xb0/0x170
[   57.181748]  do_syscall_64+0x8e/0x660
[   57.181762]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   57.181765] RIP: 0033:0x7f6192792eb2

Remove the MATCH_FLAG_DIFF_ENCODE condition to validate all DEFAULT_TABLE
entries unconditionally.

Fixes: 031dcc8f4e84 ("apparmor: dfa add support for state differential encoding")
Reported-by: Qualys Security Advisory <qsa@qualys.com>
Tested-by: Salvatore Bonaccorso <carnil@debian.org>
Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>
Reviewed-by: Cengiz Can <cengiz.can@canonical.com>
Signed-off-by: Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
---
 security/apparmor/match.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/match.c b/security/apparmor/match.c
index ae07fe81b47f..f70e5f769ef0 100644
--- a/security/apparmor/match.c
+++ b/security/apparmor/match.c
@@ -204,9 +204,10 @@ static int verify_dfa(struct aa_dfa *dfa)
 	if (state_count == 0)
 		goto out;
 	for (i = 0; i < state_count; i++) {
-		if (!(BASE_TABLE(dfa)[i] & MATCH_FLAG_DIFF_ENCODE) &&
-		    (DEFAULT_TABLE(dfa)[i] >= state_count))
+		if (DEFAULT_TABLE(dfa)[i] >= state_count) {
+			pr_err("AppArmor DFA default state out of bounds");
 			goto out;
+		}
 		if (BASE_TABLE(dfa)[i] & MATCH_FLAGS_INVALID) {
 			pr_err("AppArmor DFA state with invalid match flags");
 			goto out;
-- 
2.51.0


