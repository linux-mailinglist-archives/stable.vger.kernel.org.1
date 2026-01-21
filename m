Return-Path: <stable+bounces-210687-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XSdfCiVacGm8XgAAu9opvQ
	(envelope-from <stable+bounces-210687-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 05:46:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0714512A4
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 05:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0EB8C4042FE
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 04:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCAD274B5C;
	Wed, 21 Jan 2026 04:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RopUxdHn"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091FC2DCBFD
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 04:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768970750; cv=none; b=N1JDVWEKTfa9GOKPtIFpgZoaP/OOIh6RqKPoY2M8kBCWmObPu1NrJY4ZSjw8zNsW2pGoVwjVzZBW3hW9VWfLMkWQQKvMRE68nPMWsicc7XjQYmnuEtnXNLoIOWQIj9uLKkXFy4DfSPwXGQsYdkSGuDIScVQDInjye9s1csL/VA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768970750; c=relaxed/simple;
	bh=domcOfEBaP6yZPrEJiyNSt85tefriSkb6gpeLfrA7Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dct5kX0PZCc/f7hwdKaNJ5XYzirlOeqO/gPPXlOBAaNXDtYoYNM3V+XJbr901QQO6TZi99/EesjLbsxxFx8JoTPjKE/QgI3TyIN62+D4+3VI4tf+1r2yq5LSDe1c+eVDxPwqMIcwRRdvP86S8LzMeMj7v8W7cK58xCGabzV2ppI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RopUxdHn; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4801d24d91bso43628775e9.2
        for <stable@vger.kernel.org>; Tue, 20 Jan 2026 20:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768970746; x=1769575546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+KixJ1eV/PIhRBf84P7hsZ9aipMzlzNc3kfEM6tEoPg=;
        b=RopUxdHnRvhTYDfa09QyAKUSe1lgYUcQvdWoN+R12ivanlgQy4ibikGpI45nFeGG05
         Ualx67UkevbKHccEbtCAI46sLNCeEyfmgj/nRbDZD8Um+W5Qe3CkAbFapisDUhSL1bbv
         ZjEgzjP97+Q0oiaWjb//6kIuEwACHAHwjeMVXo+BbUb8yoYiloLDXUHkjDe3mNqeKtEO
         NMWY10GSjFbg9BzGggUGJc0ZOZZu0o3zCYi+ym3BlTsyNGb5ey1jMIdUv392StptfIO2
         Glvom9EaD8LO0gilNNYlu0HotMgdHdj5CwewjHNipvLVACSa+BsUFgrKp0E1Fe86uOuW
         AxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768970746; x=1769575546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KixJ1eV/PIhRBf84P7hsZ9aipMzlzNc3kfEM6tEoPg=;
        b=Ff7nM6pirEqs6HIizKB9d38B99ht0rdXDM9Q1Lvw0frtvVn6NK0eZmpZdbaHrbKB5o
         31RemBYfboA9uKwM1vJ6Sj0I7tzwO3Y1pilt1frg9p7XxpHXEOT1nDOhit2a9RyAmd5X
         VnP5AeyaMLUi8KPUriG75qzawU6+6IjUMGcxp6rm9xGgq238Pk5AEXvHPU4bNw7Dglas
         mLs5ZjE4uK24LWiidNG31CvkATzUIT8YUX/kBZ/2lF3jJ5QUDN1AjNjLwvljRvBf5Sc6
         I0jTWzbndv8upOCuw2uaTkcZU1I1H1bbRKlJDwhDSImMNGRZdb3N4YrVXxy1moc/+om3
         WRKw==
X-Gm-Message-State: AOJu0YyIc1tLTXdrYLwsAM2zMAmikSWqEkug2OzP+VnQG728rHE1Kzlk
	n7Hy7xbsqJBHJatw0cJr3UtWt4Hk/o4M1ATIBklku8xGKYI2dPLRtrjExJKlVRt31hu3OzWyx3C
	m05AC
X-Gm-Gg: AZuq6aLfLbcDZuCjo6Nhc8Q+D2EBTcZwdpuL0JTXvF3OGJAYCmzEgbQmZv1CgH6J0zT
	7Dc8Tw6dpsiQ/2/GqIHdASdgBO+Sdxru87lEsWy9p/eQ0pdmKnN85nVDGZgYD8TmhA5t+y7ZFt3
	2Oa0ioo/Zg6lK6/cc81tYl1R3fHPoH/ytvwrLD6D5WNn8F3rOI/CQDmuFT0GilksxH+NcWSVLRO
	PyTOolVLZMJchDEolDNQkTT78HRUZYgeVT7X5lDY9UatzNgG3WsBmUss2BbhAIj97kTevJ2k09M
	0VY7fQj9Rb+f06hUxj9Wbq4xrHfKynkWOo94hpqtHjRGaW6YFF+I/5k4fQFIJ/f2ICf2ZiG5u8a
	WabQm2chnxB2Ztw4GyOqFzi386EWdTgbj2QvCraYoaSnc7kKzPg0MrjaEa/lexQWcsfsr4QYdlE
	lvIrOLE1IOuIR32w==
X-Received: by 2002:a05:600c:1990:b0:480:3b26:82c3 with SMTP id 5b1f17b1804b1-4803e7e819dmr54657625e9.20.1768970746004;
        Tue, 20 Jan 2026 20:45:46 -0800 (PST)
Received: from localhost ([2401:e180:8d80:2a2e:c146:9b66:e2fa:21e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf32d82fsm13095450a12.19.2026.01.20.20.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 20:45:45 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Paul Chaignon <paul.chaignon@gmail.com>,
	syzbot+0ef84a7bdf5301d4cbec@syzkaller.appspotmail.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.1 5.15 5.10 1/1] bpf: Reject narrower access to pointer ctx fields
Date: Wed, 21 Jan 2026 12:45:30 +0800
Message-ID: <20260121044538.23237-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,syzkaller.appspotmail.com,kernel.org,suse.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210687-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[suse.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable,0ef84a7bdf5301d4cbec];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,appspotmail.com:email,msgid.link:url,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: C0714512A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Paul Chaignon <paul.chaignon@gmail.com>

commit e09299225d5ba3916c91ef70565f7d2187e4cca0 upstream.

The following BPF program, simplified from a syzkaller repro, causes a
kernel warning:

    r0 = *(u8 *)(r1 + 169);
    exit;

With pointer field sk being at offset 168 in __sk_buff. This access is
detected as a narrower read in bpf_skb_is_valid_access because it
doesn't match offsetof(struct __sk_buff, sk). It is therefore allowed
and later proceeds to bpf_convert_ctx_access. Note that for the
"is_narrower_load" case in the convert_ctx_accesses(), the insn->off
is aligned, so the cnt may not be 0 because it matches the
offsetof(struct __sk_buff, sk) in the bpf_convert_ctx_access. However,
the target_size stays 0 and the verifier errors with a kernel warning:

    verifier bug: error during ctx access conversion(1)

This patch fixes that to return a proper "invalid bpf_context access
off=X size=Y" error on the load instruction.

The same issue affects multiple other fields in context structures that
allow narrow access. Some other non-affected fields (for sk_msg,
sk_lookup, and sockopt) were also changed to use bpf_ctx_range_ptr for
consistency.

Note this syzkaller crash was reported in the "Closes" link below, which
used to be about a different bug, fixed in
commit fce7bd8e385a ("bpf/verifier: Handle BPF_LOAD_ACQ instructions
in insn_def_regno()"). Because syzbot somehow confused the two bugs,
the new crash and repro didn't get reported to the mailing list.

Fixes: f96da09473b52 ("bpf: simplify narrower ctx access")
Fixes: 0df1a55afa832 ("bpf: Warn on internal verifier errors")
Reported-by: syzbot+0ef84a7bdf5301d4cbec@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0ef84a7bdf5301d4cbec
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://patch.msgid.link/3b8dcee67ff4296903351a974ddd9c4dca768b64.1753194596.git.paul.chaignon@gmail.com
[shung-hsi.yu: offset(struct bpf_sock_ops, skb_hwtstamp) case was
dropped becasuse it was only added in v6.2 with commit 9bb053490f1a
("bpf: Add hwtstamp field for the sockops prog")]
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
Backport for 6.12 and 6.6 separately sent[1].

Commit ba578b87fe2b ("selftests/bpf: Test invalid narrower ctx load")
for the correspond BPF selftest was not backported along because it
depends on commit fcd36964f22b ("selftests/bpf: verifier/ctx converted
to inline assembly") added in v6.4.

1: https://lore.kernel.org/stable/20260121043939.22629-1-shung-hsi.yu@suse.com/
---
 kernel/bpf/cgroup.c |  8 ++++----
 net/core/filter.c   | 18 +++++++++---------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 2cb04e0e118d..0024b1a59209 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2384,22 +2384,22 @@ static bool cg_sockopt_is_valid_access(int off, int size,
 	}
 
 	switch (off) {
-	case offsetof(struct bpf_sockopt, sk):
+	case bpf_ctx_range_ptr(struct bpf_sockopt, sk):
 		if (size != sizeof(__u64))
 			return false;
 		info->reg_type = PTR_TO_SOCKET;
 		break;
-	case offsetof(struct bpf_sockopt, optval):
+	case bpf_ctx_range_ptr(struct bpf_sockopt, optval):
 		if (size != sizeof(__u64))
 			return false;
 		info->reg_type = PTR_TO_PACKET;
 		break;
-	case offsetof(struct bpf_sockopt, optval_end):
+	case bpf_ctx_range_ptr(struct bpf_sockopt, optval_end):
 		if (size != sizeof(__u64))
 			return false;
 		info->reg_type = PTR_TO_PACKET_END;
 		break;
-	case offsetof(struct bpf_sockopt, retval):
+	case bpf_ctx_range(struct bpf_sockopt, retval):
 		if (size != size_default)
 			return false;
 		return prog->expected_attach_type == BPF_CGROUP_GETSOCKOPT;
diff --git a/net/core/filter.c b/net/core/filter.c
index ac84e70cf543..dff4a008aba8 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8515,7 +8515,7 @@ static bool bpf_skb_is_valid_access(int off, int size, enum bpf_access_type type
 		if (size != sizeof(__u64))
 			return false;
 		break;
-	case offsetof(struct __sk_buff, sk):
+	case bpf_ctx_range_ptr(struct __sk_buff, sk):
 		if (type == BPF_WRITE || size != sizeof(__u64))
 			return false;
 		info->reg_type = PTR_TO_SOCK_COMMON_OR_NULL;
@@ -9099,7 +9099,7 @@ static bool sock_addr_is_valid_access(int off, int size,
 				return false;
 		}
 		break;
-	case offsetof(struct bpf_sock_addr, sk):
+	case bpf_ctx_range_ptr(struct bpf_sock_addr, sk):
 		if (type != BPF_READ)
 			return false;
 		if (size != sizeof(__u64))
@@ -9153,17 +9153,17 @@ static bool sock_ops_is_valid_access(int off, int size,
 			if (size != sizeof(__u64))
 				return false;
 			break;
-		case offsetof(struct bpf_sock_ops, sk):
+		case bpf_ctx_range_ptr(struct bpf_sock_ops, sk):
 			if (size != sizeof(__u64))
 				return false;
 			info->reg_type = PTR_TO_SOCKET_OR_NULL;
 			break;
-		case offsetof(struct bpf_sock_ops, skb_data):
+		case bpf_ctx_range_ptr(struct bpf_sock_ops, skb_data):
 			if (size != sizeof(__u64))
 				return false;
 			info->reg_type = PTR_TO_PACKET;
 			break;
-		case offsetof(struct bpf_sock_ops, skb_data_end):
+		case bpf_ctx_range_ptr(struct bpf_sock_ops, skb_data_end):
 			if (size != sizeof(__u64))
 				return false;
 			info->reg_type = PTR_TO_PACKET_END;
@@ -9238,17 +9238,17 @@ static bool sk_msg_is_valid_access(int off, int size,
 		return false;
 
 	switch (off) {
-	case offsetof(struct sk_msg_md, data):
+	case bpf_ctx_range_ptr(struct sk_msg_md, data):
 		info->reg_type = PTR_TO_PACKET;
 		if (size != sizeof(__u64))
 			return false;
 		break;
-	case offsetof(struct sk_msg_md, data_end):
+	case bpf_ctx_range_ptr(struct sk_msg_md, data_end):
 		info->reg_type = PTR_TO_PACKET_END;
 		if (size != sizeof(__u64))
 			return false;
 		break;
-	case offsetof(struct sk_msg_md, sk):
+	case bpf_ctx_range_ptr(struct sk_msg_md, sk):
 		if (size != sizeof(__u64))
 			return false;
 		info->reg_type = PTR_TO_SOCKET;
@@ -11437,7 +11437,7 @@ static bool sk_lookup_is_valid_access(int off, int size,
 		return false;
 
 	switch (off) {
-	case offsetof(struct bpf_sk_lookup, sk):
+	case bpf_ctx_range_ptr(struct bpf_sk_lookup, sk):
 		info->reg_type = PTR_TO_SOCKET_OR_NULL;
 		return size == sizeof(__u64);
 
-- 
2.52.0


