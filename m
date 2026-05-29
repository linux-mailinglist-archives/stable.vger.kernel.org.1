Return-Path: <stable+bounces-256681-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDKhBGPTGWodzQgAu9opvQ
	(envelope-from <stable+bounces-256681-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:56:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1808E606EA3
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E03453003830
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 17:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA4338F250;
	Fri, 29 May 2026 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwEflVMQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAE7390995
	for <stable@vger.kernel.org>; Fri, 29 May 2026 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076567; cv=none; b=P3U/uaua7ZmrVTIOdpmtHSzGzH84tGiozIiOHcpxNHCXzq3I8941usQLrtxm/NNno84b9N5JuXzzKIyWbKzkrIwEnbGPLdPMLsnJIiCTtkBtfrqwRxnU3XOK/AOwwSV+XIad5ycEk+bMAO8qk4SmXeE2vz640oH4HInAfr8OdV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076567; c=relaxed/simple;
	bh=LNYMZSCC/cAzhF+LBgIl6sgAGyIlLiiPJxEGjkswYyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lkeEaj60/Odhzeh8Frz6OXj54FHnI3FIPpOKdj1Z2Yr1d4AIez41V3S0vkcIy/65hZqhCXIevzSJa35EInwiMh798XkhmCNnuzCFxyznDYV2bTdOZDC9dLHabXJA0CGdoeRQtaiA18EObU5ucMiBB9gV7LUVyErM8IZt/swNXLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwEflVMQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso123248365e9.0
        for <stable@vger.kernel.org>; Fri, 29 May 2026 10:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780076564; x=1780681364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+HADlY/OIlF0hpDL5/ae4J9awZWb2JktfXMYyTtRGzk=;
        b=AwEflVMQ7pQsx30LNG6PgR0iFIpAY5RV+RyTI2t3AG1c9g0JG4fsUTcYdSAA2XkAN6
         f9PYchNMEQ6gr4NTdSnL4oAFXWX2GLayxWdF7U/9J/2ma+tMhHk+qISuavKfJCC0xag4
         lOYg3VKcOn7KizN+7BLsPzZ0WMrwdo+isQUgaYgZDfNdYGrQo4ZmewEYzzd1y+XnAJ7m
         TOb35uzrLRuAw8fw6EpUOOQfXOprg2+gd0TaVBP7iEqc5R4Nd9vEwBZZf2f3G7mQ3qdb
         QzqPLIx94DaWcIhngqZLWw6zwxRP1MsIoOdg2siaEkV+nfckEu+KgwbKLy5eItTwOl5O
         SRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780076564; x=1780681364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HADlY/OIlF0hpDL5/ae4J9awZWb2JktfXMYyTtRGzk=;
        b=MNenJKSayto/NPLYIkWQZNjsQ75PGAUk7m9FFaaAiTOCDclL2Ltap/5FAxuR95ooJ2
         Exabldltu/WQ0TAUp3azjsgKvfayY5z2wkjoUCkLV3SzT4RslM0q/C80lIFCHipFBqZE
         GRzsd3WCe/FdeAFq+sgJr4nHyiyfLaj5TxsEn2sk9A2WudR7a+TISCr9TZnXcXn/9Ebu
         9o1d06bWdt1xOd550icpG/h3W8zk6NFHaJR2IosXlty6fAOZVknbu5FeqGZ6gM6N7F2X
         s6KTBm35bkjh7bizBcY7egLZgTE/ATLW+FqH7Wr1ipmwd9tfqoX1VNawNopSynhEYgL8
         B4fA==
X-Forwarded-Encrypted: i=1; AFNElJ8RkKTwcplYLfTNAeu9XHXalvNwZ8Z1Cwd+KcATEbDuLiMBmSOKxIUPQr1JmXbsSG4wEDl9W5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNjvvPU1kC83zkVOr/hXwtnxhizjiq7u8O3QK8pq5jcvVSJ5oV
	kMTPL3qmvUVYyRFAUuiUm6npQOAPbEmAhJsKRyoN3GuJGk6xVVs4E1oS
X-Gm-Gg: Acq92OEv1oK2PbL6WPZJYtI80iiSqNarqCQWk+1/QwmI4hkFtnyZJ44XOCY6YnqsogJ
	hyDRVX73/YvMlcMtNoCYmWxNaFb+cIiuHKQIL6VNK1l9JcWHKiPa4EdURszVM2oI/it8To34s7h
	3YABUW2+BZk4Eq6Zz4X+IqG9o7nTqJ96zZFh85qLvjZJR6qRsn9dj6+21bk1vxjJ5ljsU6MlxL+
	4tUBvpxFJnnqpCOfgviVuUKO6fzsZFpUXRu2CVyCimj9fTKn/1Q/3FhwB/LlC0MOQQaun9OsJ2W
	zNGV1wdEdbmAQLR/aY4IDOAqactPl2poixVtkR5DR1Eeu7oo4Q4vcXak+o2EGSMI/qeaGBD84Mn
	N1ef85/OEPGtn8Kqe5OQS59byc3xEPP913NdsWANnEP62Z7uZyCq5l6LpYmmBxZe04dFgpJwImw
	n7+rh6ZnRGK81pcCJIVjWMWW7EWw==
X-Received: by 2002:a05:600c:a00c:b0:489:1f04:96c3 with SMTP id 5b1f17b1804b1-490a2904aa4mr12256725e9.2.1780076564142;
        Fri, 29 May 2026 10:42:44 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:7::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c13d018sm25065735e9.8.2026.05.29.10.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 10:42:41 -0700 (PDT)
From: Vlad Poenaru <vlad.wing@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH bpf] bpf, lpm_trie: Allow lookups from sleepable BPF programs
Date: Fri, 29 May 2026 10:42:33 -0700
Message-ID: <20260529174233.2954240-1-vlad.wing@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-256681-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladwing@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1808E606EA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

trie_lookup_elem() annotates its rcu_dereference_check() walks with
only rcu_read_lock_bh_held(). Because rcu_dereference_check(p, c)
resolves to "c || rcu_read_lock_held()", this passes for XDP/NAPI and
classic RCU readers but fails for sleepable BPF programs, which enter
via __bpf_prog_enter_sleepable() and hold only rcu_read_lock_trace().

A sleepable LSM hook that ends up doing bpf_map_lookup_elem() on an LPM
trie therefore triggers lockdep on debug kernels:

  =============================
  WARNING: suspicious RCU usage
  7.1.0-... Tainted: G            E
  -----------------------------
  kernel/bpf/lpm_trie.c:249 suspicious rcu_dereference_check() usage!
  1 lock held by net_tests/540:
   #0: (rcu_tasks_trace_srcu_struct){....}-{0:0},
       at: __bpf_prog_enter_sleepable+0x26/0x280
  Call Trace:
   dump_stack_lvl
   lockdep_rcu_suspicious
   trie_lookup_elem
   bpf_prog_..._enforce_security_socket_connect
   bpf_trampoline_...
   security_socket_connect
   __sys_connect
   do_syscall_64

This is lockdep-only -- no UAF, since Tasks Trace RCU does serialize
against the trie's reclaim path -- but it spams the console once per
distinct callsite on every debug kernel running a sleepable BPF LSM
that does map lookups on an LPM trie, which is increasingly common.

Other map types already use the bpf_rcu_lock_held() helper, which
accepts all three contexts (classic, BH, Tasks Trace). Use it here as
well, matching the established convention.

Fixes: 694cea395fde ("bpf: Allow RCU-protected lookups to happen from bh context")
Cc: stable@vger.kernel.org
Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>
---
 kernel/bpf/lpm_trie.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 0f57608b385d..ac36063cb7e6 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -246,7 +246,7 @@ static void *trie_lookup_elem(struct bpf_map *map, void *_key)
 
 	/* Start walking the trie from the root node ... */
 
-	for (node = rcu_dereference_check(trie->root, rcu_read_lock_bh_held());
+	for (node = rcu_dereference_check(trie->root, bpf_rcu_lock_held());
 	     node;) {
 		unsigned int next_bit;
 		size_t matchlen;
@@ -280,7 +280,7 @@ static void *trie_lookup_elem(struct bpf_map *map, void *_key)
 		 */
 		next_bit = extract_bit(key->data, node->prefixlen);
 		node = rcu_dereference_check(node->child[next_bit],
-					     rcu_read_lock_bh_held());
+					     bpf_rcu_lock_held());
 	}
 
 	if (!found)
-- 
2.53.0-Meta


