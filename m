Return-Path: <stable+bounces-210685-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAoQG6JYcGlvXQAAu9opvQ
	(envelope-from <stable+bounces-210685-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 05:40:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B73D4511D0
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 05:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4F864E0B51
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 04:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0184532D0E6;
	Wed, 21 Jan 2026 04:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZavvV/RH"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F023C009A
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 04:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768970396; cv=none; b=CorO6UOEzz7V3Ny2JYBR9GuhLZSwZuzKyCiTX2TaCk3zRHQjL890qos1anr7ZdjyfYSy33laPhMl/6/57r0TV6pevvL2j3gRfxZW6CiDRcYKe4ibAaKZ75WonwDbOVlY2RzoLdVuK6zQNdAJpBf1eSixH91mQZwQJ4ekt7+iz7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768970396; c=relaxed/simple;
	bh=ssC9SZ7FnWmFIN/xHI0J1NfV0bJjOV0hhPtpXhMKEkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1t1mUrvfDr+7YRX2G+h16dp9KAJ5S8F7qKG5aym/+MTxUe4jd0eLIEGBD03DYX+z2iH5Uv5lI+L0L7Zs+mP+x6z4kAcgMKfiLxIWwpb2J/7USmI6ZtsU2OSOzHqdVm3ebl6JUgPxc9hXsxmj4dx8IurfGmarmhtQSMzQTw+WFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZavvV/RH; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47ee807a4c5so46739225e9.2
        for <stable@vger.kernel.org>; Tue, 20 Jan 2026 20:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768970392; x=1769575192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09YMj6FXkla/JWwV7RaHUOKoyUH2FgBUIKZk/eP2h0Q=;
        b=ZavvV/RHsGBAo+bl6hhLoBHfH6Yi5+5fBzyhJ4C5sGPzK5A2ivOtT9qMNhUDXvETzE
         +WXEo8TI/myZPwiiZz8ikfmIKWUEQzL/27z0qU3KAUBzd/HWwLZC8AahgLcnROiuDnpM
         OK3lOnuxDi6JtJat+v5JYvxJp9v3YIWTL0S7a2/On7gFoYZja+hdWUX5FifsUTMsiJ84
         qS4hXnbabaYgNYOow1CSHdQW68L/Cw2vUyG0hVCS8Y7l23UQNL+EFODWpF9IAe+NVZHb
         Bjq/ayah8rFpfZ/4wBT2zEE0hZQ2Bfps7Pr3v1dtGAHexrwW4uqzks33lR78voiu45O7
         ZtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768970392; x=1769575192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=09YMj6FXkla/JWwV7RaHUOKoyUH2FgBUIKZk/eP2h0Q=;
        b=pNqL5QuB3ioHKUF5WHqrSPmA6DmWC4zBghqiIWl/2bV7tIv7nreHLsCSc3/cnP+Rvq
         t4IggcXSuzjBfmaqrcgJ/0iVLhasF7bZFgocOXdX1KjCpChMRzpvl8/kxr1CrnNDiK5f
         iR9Qm4lVBUDqPQ0zdOLyDl1Tkd66yjBfU1fmZxl2607FZk+xvYhwE8AtP0Nz/z66usBz
         twLBYZ0Qqg7qNIkyCAFmpoYN2nNDN+XSONRbEBJ3VJiFbdD8K/EQWy/2y03b9IPW9RCu
         f1W8DIbxsLt091RvLKOSgyoeTKRY2/307sSkfmHz6VzGP04SapMb5m2R1mnu+/lwLdSO
         pYHg==
X-Gm-Message-State: AOJu0YyAhoAPOSQsTrXvUgUQ+augvc8AcGWfhmK7cFd4JdjjDYCgBaEQ
	9NWKwctdKVGE8SnsdcoRqweoVkRBOAteDAhdBGP5cUat8Wlil2VIJRUNlRwA8EZNuwvW2HIjIbo
	4ZMv7
X-Gm-Gg: AZuq6aIHzmxn+o6tKM158T6VTxUn5p3enzuDixpHIaKnA6TiZpyzwFPba0PkIxi/lRx
	iRtQnKiOIBPPCQ1fFWSBLWiWxHDjk7AlbvC5xjWg0zMMPeSnd3SWoS3N2Q6YE/BUjJD0XnVc+op
	DoumDJzrpeff27Imh3ZtNKjybytPjlBLEwePkZHDkAtCGDvVdD4mFIjIqGJ8kIB8H1aPRyD47VU
	01F9eW+rhLLw9SiKAwnzNQtgq4ou9LVXlUEAAimZbqroYGW1sYwJ1/fboKz3XnTz34nJRtGtGnB
	R/G0+ecv0spBnLDL1VJF5EzUeWUAhvq/jEmIIp0jwqrxQR5E7lw5V03FWw7T9bCK3Pj3rRuGueK
	FQLo86arryNxsP8ib2XwSxAgn+pib9530kFSr7Gt4evSRiUGIAtE+mJ5Ma440tGzjV8JUG5GXps
	cTaN1WMSYiLkFuFQ==
X-Received: by 2002:a05:600c:3ba8:b0:47e:e48b:506d with SMTP id 5b1f17b1804b1-4801eac88fcmr244014195e9.16.1768970391839;
        Tue, 20 Jan 2026 20:39:51 -0800 (PST)
Received: from localhost ([2401:e180:8d80:2a2e:c146:9b66:e2fa:21e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190abcf0sm140125235ad.12.2026.01.20.20.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 20:39:51 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	syzbot+0ef84a7bdf5301d4cbec@syzkaller.appspotmail.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH stable 6.12 6.6 1/2] bpf: Reject narrower access to pointer ctx fields
Date: Wed, 21 Jan 2026 12:39:15 +0800
Message-ID: <20260121043939.22629-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121043939.22629-1-shung-hsi.yu@suse.com>
References: <20260121043939.22629-1-shung-hsi.yu@suse.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.com,gmail.com,syzkaller.appspotmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210685-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,msgid.link:url,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: B73D4511D0
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
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 kernel/bpf/cgroup.c |  8 ++++----
 net/core/filter.c   | 20 ++++++++++----------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index c0d606c40195..1ebf40badbf6 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2418,22 +2418,22 @@ static bool cg_sockopt_is_valid_access(int off, int size,
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
index 0d1f93f944f2..04968d623d07 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8655,7 +8655,7 @@ static bool bpf_skb_is_valid_access(int off, int size, enum bpf_access_type type
 		if (size != sizeof(__u64))
 			return false;
 		break;
-	case offsetof(struct __sk_buff, sk):
+	case bpf_ctx_range_ptr(struct __sk_buff, sk):
 		if (type == BPF_WRITE || size != sizeof(__u64))
 			return false;
 		info->reg_type = PTR_TO_SOCK_COMMON_OR_NULL;
@@ -9232,7 +9232,7 @@ static bool sock_addr_is_valid_access(int off, int size,
 				return false;
 		}
 		break;
-	case offsetof(struct bpf_sock_addr, sk):
+	case bpf_ctx_range_ptr(struct bpf_sock_addr, sk):
 		if (type != BPF_READ)
 			return false;
 		if (size != sizeof(__u64))
@@ -9286,17 +9286,17 @@ static bool sock_ops_is_valid_access(int off, int size,
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
@@ -9305,7 +9305,7 @@ static bool sock_ops_is_valid_access(int off, int size,
 			bpf_ctx_record_field_size(info, size_default);
 			return bpf_ctx_narrow_access_ok(off, size,
 							size_default);
-		case offsetof(struct bpf_sock_ops, skb_hwtstamp):
+		case bpf_ctx_range(struct bpf_sock_ops, skb_hwtstamp):
 			if (size != sizeof(__u64))
 				return false;
 			break;
@@ -9375,17 +9375,17 @@ static bool sk_msg_is_valid_access(int off, int size,
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
@@ -11598,7 +11598,7 @@ static bool sk_lookup_is_valid_access(int off, int size,
 		return false;
 
 	switch (off) {
-	case offsetof(struct bpf_sk_lookup, sk):
+	case bpf_ctx_range_ptr(struct bpf_sk_lookup, sk):
 		info->reg_type = PTR_TO_SOCKET_OR_NULL;
 		return size == sizeof(__u64);
 
-- 
2.52.0


