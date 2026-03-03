Return-Path: <stable+bounces-222794-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBPvM0l4pmnxQAAAu9opvQ
	(envelope-from <stable+bounces-222794-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 06:57:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 741351E95B2
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 06:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C705301DF72
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 05:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D653090C5;
	Tue,  3 Mar 2026 05:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RUFpuaxL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7D22F3C22
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 05:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772517445; cv=none; b=u4H9Yoa3RrFKH4exgSMPTZRSNRT23oc5w7TLqTCkm50E/mcS86KcTFxA47nDi6aeLptc9doiginT29lCijaliRxomtXOwunPmTZ+rjwCJnhq9eGfyG0Um9r9aFtBSNs8BlJ1PKyvikybxGSTdwPae7a3YCQQcW6VBlV6goy/MY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772517445; c=relaxed/simple;
	bh=YSkj7yV9fHYX5D9RDHZytf9gJrBbsOvUt8PGxk5MLUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MjywBPBzLgcTsunbUQ/QmE3gX/G5Ny4GB3pwQ6wo+TwCCxqIOeVUpqWgIc4MFnkGAAIh1JHhXj4l9ZQYwbmV3kwiYKszy5uHz90OEEgGN+Bld1lyLeEdvBCLAsdW7GWR44fAaDF87LrQCsMhtMjzetKw9Lc3wjbis8wDBGBCp3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RUFpuaxL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso44348885e9.0
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 21:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772517442; x=1773122242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wbLqCT38jwoC2Nr4HKJ6p3wDiVnmqP0zGpnls7YlzMw=;
        b=RUFpuaxLVAGezZ3hCJFeNnXLhd0wnNJGugCnqKq+7AMGlK0rJU8fsRHyXEmbAmPZ6q
         +/71XvAcX7iUlJG0c0IDbvHLIP/gtzY83GIVc5+4PK++Xn0YfR4tCG7k0lhYGs2laaAt
         YX667OzHxbFHah1Pj+uJPa7MoxBg5zj+RKSwEweyxba5H4MOCL1iJLPoKlT4tM/iKOvj
         Flu3fbzCYAHzXgTJbIsU5+DFFy1fosuXQmNVpN4lDeFgnmd7QK6B3Zwfsj2frfZC4qOD
         jq+z2C9piT7NJqHna2lGlSevoeLV/bq9ItEX/3ckt2EkVlxHh5S+jK1m6Jb4M256NpYr
         Gcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772517442; x=1773122242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbLqCT38jwoC2Nr4HKJ6p3wDiVnmqP0zGpnls7YlzMw=;
        b=mldj6RmTkPUKQOhpUo8ZcICiYGRbkGAHHIKTpNNGdBvLHsgC2vrE5sVVstH3Tp+64+
         0q6VIMTWKqp+57XXwVdfjHLf14NOJtH7n7OtYsI6am0KB6Rw8b208+89XBfU51H6iVcO
         fTrRrNFMB5Fsw5g3Jmz8ikn2JM94IEsgo1m0mf5yZrzYiDj4RT4Vygw+T0FcDplyT1Fw
         Ti3bHkk2uILhLEyXy25CBHTC4Xyu/rl4p30jFPK/ptpUbUfBRfYR0b2HCKfpQ9cGl5Pp
         kApbcK56VJvinWaoIjbh0ib7r3EH6RaHK3jYXz/V0xcI+XWhR8al7tV/a0TzSsm25Vko
         Z8gA==
X-Gm-Message-State: AOJu0YzsBkhqj20lablZFNkQ0lCSBZ8w/7pLXwqWj76YXATx8he9Wm1a
	Zb9MEy9bQ6GqRP/zaoQSiTYIMomo9aFABmdeqWLJ2TMD9LtDjCn1H5oDIuQbrtQvyThrNyN4Dbd
	6znAy
X-Gm-Gg: ATEYQzxvUXFJw3wF72oO8sDBUxrpCBh67H1YjfGkP4Xem9Rk7imE7R5dBCm/QnCgkdL
	TD9JFbE8lYpPXr5M7d91OZw7PN+EUnpMAJxUuhGYTk3ENDQvj/fNefULsozPXDNLLib3YqlzfTx
	M9FeCukiKqdDFup/6zZ8wUA0DM/QRR4JAKA4QRqQLTj3N02wSgnvFunOlru5R9LL/WnGgod7UYL
	AUi1HnpQf47U+ENdNvPH3HmeRmwqqBqbWQGP010dJKfeyjxujm/fhF2hoKt3UWPoUzcX9Gaj9DU
	B0Q7nlbA9HxAxxN7n5vvdw+fcLHfguN/myRmptAiNEr5nqZVkgI6rilw1X9BgMJqCHj7OXyR/oS
	2iVqcjFS+yyTuaz0J1WN2vTDxm5sDG57u0usyCOhspuHDMUs4XCEKOFkuoMbQg5ycrx6/r9GIjU
	4aRo8nRcy3fP2i3kERVhTbTo9duw==
X-Received: by 2002:a05:600c:699a:b0:471:700:f281 with SMTP id 5b1f17b1804b1-483c9bf44e8mr236485065e9.25.1772517441943;
        Mon, 02 Mar 2026 21:57:21 -0800 (PST)
Received: from localhost ([2401:e180:88b0:32b4:4c71:af95:b813:9623])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa638dbcsm13598648a12.14.2026.03.02.21.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 21:57:21 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Paul Chaignon <paul.chaignon@gmail.com>,
	syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.6 6.1 5.15 5.10] bpf: Forget ranges when refining tnum after JSET
Date: Tue,  3 Mar 2026 13:57:14 +0800
Message-ID: <20260303055716.25158-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 741351E95B2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,syzkaller.appspotmail.com,linux.dev,kernel.org,suse.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222794-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,c711ce17dd78e5d4fdcf];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid,appspotmail.com:email]
X-Rspamd-Action: no action

From: Paul Chaignon <paul.chaignon@gmail.com>

commit 6279846b9b2532e1b04559ef8bd0dec049f29383 upstream.

Syzbot reported a kernel warning due to a range invariant violation on
the following BPF program.

  0: call bpf_get_netns_cookie
  1: if r0 == 0 goto <exit>
  2: if r0 & Oxffffffff goto <exit>

The issue is on the path where we fall through both jumps.

That path is unreachable at runtime: after insn 1, we know r0 != 0, but
with the sign extension on the jset, we would only fallthrough insn 2
if r0 == 0. Unfortunately, is_branch_taken() isn't currently able to
figure this out, so the verifier walks all branches. The verifier then
refines the register bounds using the second condition and we end
up with inconsistent bounds on this unreachable path:

  1: if r0 == 0 goto <exit>
    r0: u64=[0x1, 0xffffffffffffffff] var_off=(0, 0xffffffffffffffff)
  2: if r0 & 0xffffffff goto <exit>
    r0 before reg_bounds_sync: u64=[0x1, 0xffffffffffffffff] var_off=(0, 0)
    r0 after reg_bounds_sync:  u64=[0x1, 0] var_off=(0, 0)

Improving the range refinement for JSET to cover all cases is tricky. We
also don't expect many users to rely on JSET given LLVM doesn't generate
those instructions. So instead of improving the range refinement for
JSETs, Eduard suggested we forget the ranges whenever we're narrowing
tnums after a JSET. This patch implements that approach.

Reported-by: syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com
Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Link: https://lore.kernel.org/r/9d4fd6432a095d281f815770608fdcd16028ce0b.1752171365.git.paul.chaignon@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[shung-hsi.yu: no detection or kernel warning for invariant violation before
6.8, but the same umin=1,umax=0 state can occur when jset is preceed by r0 < 1.
Changes were made to adapt to older range refinement logic before commit
67420501e868 ("bpf: generalize reg_set_min_max() to handle non-const register
comparisons").]
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 45b2f06de452..743c3cf6f0c2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14162,6 +14162,10 @@ static void reg_set_min_max(struct bpf_reg_state *true_reg,
 		}
 		break;
 	case BPF_JSET:
+		/* Forget the ranges before narrowing tnums, to avoid invariant
+		 * violations if we're on a dead branch.
+		 */
+		__mark_reg_unbounded(false_reg);
 		if (is_jmp32) {
 			false_32off = tnum_and(false_32off, tnum_const(~val32));
 			if (is_power_of_2(val32))
-- 
2.53.0


