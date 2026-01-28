Return-Path: <stable+bounces-212661-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NqHDO5bemm35QEAu9opvQ
	(envelope-from <stable+bounces-212661-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 19:56:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7350A7F69
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 19:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9E27301980A
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 18:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31B3372B4C;
	Wed, 28 Jan 2026 18:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="GJGkJQYm"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113622737E0;
	Wed, 28 Jan 2026 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769626590; cv=none; b=FmY0UDCWd9dSW8Q4i/1QAGMm8E5SXLrLYPE0B1i4d5WNMJlfCHb2y3R96SBFWe9sqZ4iGKUPuDNfnjU76YppgnGovGY1l8js+1SufDaYQMbF688cCv5hCe0Eg27fXwqRujbN2MQNNsCuL8lX2ELVvTvwyFvK0Xc05kpM0CCwLRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769626590; c=relaxed/simple;
	bh=JQ6oAOMrOWrgsxXhHdDHSefRhwRr44NnCHveM5HrUtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=c4C6Hm6MjJ0MrjB0moMCAZ7Ir+JpWc/DhKT7nnkcT0keN4iJVpvp3JSRUQSq1eoS2m11hYbsEe0vVz018nnJTmWbhzmq9jzAs3HvbOj5qDE/efUEMEQYUZllHh5f96Yy9uMP1jbuZNlfPeb32Cbe+uRgO+it4S5XMYLYShZGIKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=GJGkJQYm; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=gQch948IyA92V6h0BzqtNv/cqMWX5k0kFZ5KJwnzom4=; b=GJGkJQYmfGdEWblFdVo1dSx3js
	JimX3mckTI69QcFWJsK3YOizzVgE05r4EvllQFNWP2QY+8nuWX89m2Vd1RyKBajkYrGCQUujVPcFT
	DcbpxCaRbqMtm6/m3zBtIuDF5NivczHcxg3F7KeDX1M1P5BpObHOLNyJHBgbzln5CpKo/SRtInlS8
	WFVPPNv1h7T+PmHJGOSoh3kz7aBTdWTcke7fWhDx27h3VYUfR566zHX8wcMuDDvItzflSl9GqZjxn
	MgLY2KWPqQTu+sUzFok1yAcGhDW6G9NeCV5ebX8B0mD7pQ3L6gTTfmzGAQkNC1TTEkr7VopEif1sj
	scKLFLBA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vlAi4-000NHU-05; Wed, 28 Jan 2026 18:56:13 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 28 Jan 2026 10:16:11 -0800
Subject: [PATCH v2] uprobes: fix incorrect lockdep condition in
 filter_chain()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-uprobe_rcu-v2-1-994ea6d32730@debian.org>
X-B4-Tracking: v=1; b=H4sIAGtSemkC/23NywqDMBCF4VcJszbFiRIvK9+jSDFxqtOFkYlKi
 /juRbvt8sDPd3aIJEwRarWD0MaRwwS1MokCP3bTQJp7qBWY1NgUTanXWYKjh/hVk8HSFp3LPTp
 IFMxCT35f2L397bi6F/nlFM5i5LgE+VxvG57dX3hDjbrPMUNb2KyoqqYnx910CzJAexzHF/aA7
 g63AAAA
X-Change-ID: 20260128-uprobe_rcu-e21867ab4c1b
To: Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, kernel-team@meta.com, 
 stable@vger.kernel.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-f4305
X-Developer-Signature: v=1; a=openpgp-sha256; l=1757; i=leitao@debian.org;
 h=from:subject:message-id; bh=JQ6oAOMrOWrgsxXhHdDHSefRhwRr44NnCHveM5HrUtY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpelvHWMWjX6l5l5feVpQ3ElIS/APObRyOLPum7
 y++fBZELCCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXpbxwAKCRA1o5Of/Hh3
 bVboD/9SvqYw73jXei3fdACOZqB9zgjK25WzACp/I0D+Ybu9luAFdziZxivizmp9P+nNMxn6bsx
 1Iqil8ZHPAvsUqJ2JrQKLr/9rmBbcma2h7AXMSMhcjPCLMrUy/+YeOKRKvW2LDWIX0v+VAzJJCh
 krEXEP2r76NqVnv5jTOY/ljDcr4o2DQARnONbmN4a8AokDL6WQXJFiAHJuzzo4Lxb2sVMJYSShV
 ueDS2sLjhuCZYzjzOURNkzLKT//glryvYluC6SROIPZPBTZpGGxKhOBqyBuY1dKyX/HMDdnHu7Z
 +p/IQ3rNYbFEft8qad0U352Nf+WpJy5naltKZP793UVHvZeA9ND4j1mp9jp9djHfwEmecQbdkIa
 gY9takeUnZKMKTtJ2gfLQL/vH6FtlpSEq4GWiBnwqddaBmLx1TZI9xy1VCvjdNu6FsHA9Gemgme
 u4DSx+PzmQipC5qcom2PyHfjfjQqxMURCXeM/gOl34X8kQAFiTH8zKpwoyUcUBLgr2DrDCuYezZ
 Agq5jC8zOixFFD+5qfcsqPUJAo/wjWgA4kAiMUGem8lz3MaFjTrEBi5vLSBR+odf7V0Zry/2q4a
 Hhk8J7Yg++6kcJ01JbxSOQywyYXif7OXMNWNx4WF2O6EKI/H+3EbD6EOWtTi1LLc9+FtmilIgJY
 MWZqdUnT2+PnK/A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212661-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A7350A7F69
X-Rspamd-Action: no action

The list_for_each_entry_rcu() in filter_chain() uses
rcu_read_lock_trace_held() as the lockdep condition, but the function
holds consumer_rwsem, not the RCU trace lock.

This gives me the following output when running with some locking debug
option enabled:

  kernel/events/uprobes.c:1141 RCU-list traversed in non-reader section!!
    filter_chain
    register_for_each_vma
    uprobe_unregister_nosync
    __probe_event_disable

Remove the incorrect lockdep condition since the rwsem provides
sufficient protection for the list traversal.

Cc: stable@vger.kernel.org
Fixes: cc01bd044e6a ("uprobes: travers uprobe's consumer list locklessly under SRCU protection")
Acked-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- updated the "fixes" tag (Oleg)
- Link to v1: https://patch.msgid.link/20260128-uprobe_rcu-v1-1-d41316763799@debian.org
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index d546d32390a81..726d13b375f3d 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1138,7 +1138,7 @@ static bool filter_chain(struct uprobe *uprobe, struct mm_struct *mm)
 	bool ret = false;
 
 	down_read(&uprobe->consumer_rwsem);
-	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_trace_held()) {
+	list_for_each_entry(uc, &uprobe->consumers, cons_node) {
 		ret = consumer_filter(uc, mm);
 		if (ret)
 			break;

---
base-commit: 1f97d9dcf53649c41c33227b345a36902cbb08ad
change-id: 20260128-uprobe_rcu-e21867ab4c1b

Best regards,
--  
Breno Leitao <leitao@debian.org>


