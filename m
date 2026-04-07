Return-Path: <stable+bounces-233558-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOyeBIbi1Gn0yQcAu9opvQ
	(envelope-from <stable+bounces-233558-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 12:55:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 744993AD500
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 12:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BFD930D5CA9
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 10:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F1F39DBC6;
	Tue,  7 Apr 2026 10:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ILQdYue/"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2CC3AA4E0;
	Tue,  7 Apr 2026 10:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558924; cv=none; b=dF6JVkpbDqZ9Q3dVU3OnTfaXmgQic/Fl5D5gzM5XXBgyYu2q1XPemA0qXYkj5EtQSHfmBkX+Nv4oIwkHrzCWa+uxFexlgK8Doq/J9jSEg913+Gqn7dv2zDRQcx6VgibYSjYLyMZSZvNwewUupn4OCQXal/dA8Y62klYrXhB1xbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558924; c=relaxed/simple;
	bh=00l58+E7d7W7EjKv0MTjo17DPYW/vSP39MhtKCxYo3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NJIN2Y2RXlM5ZZ32lBmsxPWic98OVOMq8+Xw6PYZpd3W9zE4jDVpi8+rkIqEiVLC5pYAhvbhk3eaKDff9zTE/RbGqDrA7b2L6fnkgJXrw0v0UwCY/q/nTEt9QOGH+DxRKBtKemYtK5pJVE7BfYNyTNiwfyGqYQOgx3bnzBOoC6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ILQdYue/; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=fyJpmyBcC0c7wgp6GHS2X+37xYvhdQrxR7XrAUmv46U=; b=ILQdYue/GDcf//OaOT/C/eRjTe
	yDRjyyPA7BaXJHg0FwBXfI7/BiD2QN9UO4fO2YQITTxw4vv9Px98i+jv4H/6UWC9KmaOjOpYgjf0c
	UHAsTEk4MQYE0gHhU12M6DVdPkLl49WUl1LTMzghBzAwo6bNOnmekdqa0kuDXT5tQF1NUUGCKUsYL
	vbpwywjJ3ipqkYw2+6/mgq2ryixz6K0zfDjNMyH6rrBeQDjmxdU0WRZdBOSNjWWevgOgGwiyddsYb
	pMqyt66vdm7Jc75N8n4gurUZ8guk5198UCgzaSq9bZRRVY3zomk5FHz7PKDFBqmYcbaSovnmITQw2
	wg8xPEVQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wA3z0-007aUU-2C;
	Tue, 07 Apr 2026 10:48:33 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 07 Apr 2026 03:48:11 -0700
Subject: [PATCH] bpf: Fix suspicious RCU usage in LPM trie for sleepable
 programs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-bpf_rcu-v1-1-fbc9398d05c5@debian.org>
X-B4-Tracking: v=1; b=H4sIAOvg1GkC/yXMQQqDMBBG4asM/9pA1JBCrlJE6jjTThdWEpWCe
 HdpXb7F93YUySYFiXZk2azYZ0KiuiLw6zE9xdmIRGh8E33wNzfM2mdenUYOXjloyxEVYc6i9v2
 f7t3VZR3ewsuP4zhO7/ACsWsAAAA=
X-Change-ID: 20260407-bpf_rcu-f6c40fc4f3c6
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 stable@vger.kernel.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2619; i=leitao@debian.org;
 h=from:subject:message-id; bh=00l58+E7d7W7EjKv0MTjo17DPYW/vSP39MhtKCxYo3k=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp1OD8RJvEC4ekC1Vn+3mlpGO2OiNs/u7inMbh4
 VouXm0v0meJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCadTg/AAKCRA1o5Of/Hh3
 bWdbD/9/rVgQPpYgtGVXoMqO49sw1jXzgBGINChDfuTQn1ZNoNMI+nJJJ7XafyFhPXL8IXYxjAd
 NvuiOv603omdQORw2YVF5Mu7tRz1Uz43qG3cRZ28FXphRWgEERvicjbEKxUYuUQ86fBM4nn5IUW
 MiF+zN/PBZ2U+uMtTexVpJvUkqxlP/clnnfVdpBY4zwlVWnVsNRy+s2tSRVEssf+cl5HUF1DD14
 Yk49skDcEN1euG9qAaTOOhY3AJ91I7/Awg6IDfSfbGWOlMfQXNt8zFRzL+ecq/BDF6G7iAHgaLw
 FR8Uw4kHS1UqkShBgrfnlpEiW03eA6q9ZNHX0WHX8jZ6WF+bBkKGl37tCWk0uFIxNVjTIfnKW9Q
 JiDw38gqT3s3FKKygJ+J09LY2XrauYbRxePQGoy11WfhFWdWmj/8NKZqBAt1kJ8HmpyXQWDam2p
 jLO3UAHjwUZQJhbtbzioU6J8DcQOC1hwTWFDheS3quNWG7clTwgCwJhZrn19W1aCQz0vX79UyP6
 4rUBubfmA0vsW1c6NP8YlAIo+WL8LHJ4EnrMHEZqyknmcibHKAMYRZpyPQOlCf+97iWzBirPGpN
 CjhIk0+xEktb0sCT5dlVXFdySeglCKKvOU8kAxB0OMOSm+SJ42wG+INqe878x3s94nbP+Nl3jXf
 G9mUEbXVqrMIAgg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-233558-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 744993AD500
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

trie_lookup_elem() uses rcu_dereference_check() with
rcu_read_lock_bh_held() as the lockdep condition. This is insufficient
when the lookup is called from a sleepable BPF program, which holds
rcu_read_lock_trace() (via __bpf_prog_enter_sleepable) instead of
rcu_read_lock_bh(). With CONFIG_PROVE_LOCKING enabled, this triggers the
following warning:

  WARNING: suspicious RCU usage
  kernel/bpf/lpm_trie.c:249 suspicious rcu_dereference_check() usage!

  rcu_scheduler_active = 2, debug_locks = 1
  1 lock held by .../...:
   #0: ffffffff86ca5bd8 (rcu_tasks_trace_srcu_struct){....}-{0:0},
       at: __bpf_prog_enter_sleepable+0x26/0x280

  Call Trace:
   <TASK>
   dump_stack_lvl+0x69/0xa0
   lockdep_rcu_suspicious+0x13f/0x1d0
   trie_lookup_elem+0x99e/0x9d0
   bpf_prog_3980d36ecbef0e34_net_check_ip_pod+0x42a/0x510
   bpf_prog_57df4ce643736a70_enforce_security_socket_connect+0x3e9/0x69e
   bpf_trampoline_6442540179+0x60/0xf9
   security_socket_connect+0x25/0x80
   __sys_connect+0x15c/0x280
   __x64_sys_connect+0x76/0x80
   do_syscall_64+0xe6/0x930

Use bpf_rcu_lock_held() instead, which checks all three RCU flavors
(regular, bh, and trace) and is the canonical helper for BPF map
operations.

Fixes: 694cea395fded ("bpf: Allow RCU-protected lookups to happen from bh context")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
I've hacked a reproducer for this issue, and it could be found at
https://github.com/leitao/linux/commit/59c83f313face36107ef1e8392e27b1cf4887b70
---
 kernel/bpf/lpm_trie.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 0f57608b385d4..ac36063cb7e62 100644
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

---
base-commit: 59c83f313face36107ef1e8392e27b1cf4887b70
change-id: 20260407-bpf_rcu-f6c40fc4f3c6

Best regards,
--  
Breno Leitao <leitao@debian.org>


