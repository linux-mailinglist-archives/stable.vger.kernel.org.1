Return-Path: <stable+bounces-211943-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +N9rObreeWnI0QEAu9opvQ
	(envelope-from <stable+bounces-211943-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 11:02:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 683B59F2BA
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 11:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F348305237B
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 09:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7FF34DCCA;
	Wed, 28 Jan 2026 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="goawlMG4"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD3D34DB7B;
	Wed, 28 Jan 2026 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594369; cv=none; b=HTEGSn4x1plFhJCFKFDJdepzRGIf0d/Ve8QuEyXNGZogOF0OEZaKPa0DqiK+lfVpnsfxWVOmhbKsbslGHNbh7rEfFiMxMuOvUHaiX38p1oUP8ErYkoS3m5ow82CxnmnDDkIQRpowXq/JfR4MvYwDJ9Zo2bOXGo9khGgcLHNlPvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594369; c=relaxed/simple;
	bh=UHbJI7QHhCf6/qLiCs9zoyOI0n9rgQsghe0accS1jGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Jv6o6EPJPVs/rMk+YFU8CtEnKmg4Bk2YCKc1IcX3qTuVaH4QFsbFWxeUdaf/z9zQAtrir6ui7mIl+NNzj3ZOBeaBhf4cN22tLk8j2mdqCwFdfLCUl/UtFMbYJy3E452jjvFeO5KkeG00E88g/i52C0B2x+nlCNdVMuZGn5xnX6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=goawlMG4; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=1nO7a828YUpcLhY+o95VylGAfy5FWZlAkk3njZ1MCEI=; b=goawlMG45qxczHtuUUTkTzGoaT
	wmeTAzlZtiTXbPJQlnrBWCd8rz9ceTMyEdB4hkQKOJfKLG9kQNC/g1VaUsWyInVvmkeRD2ceRN2pN
	rzuPs8zKQEESQMXgs0Uomkrmt55ReFcMixnSKApXeFBGJb5hX0kOrULEdq0YVHPxF/32X88xInQLv
	ozlFD+Af/GaJ3LTsbHC3SayEw2TWdVcwIRbPOix39Ycs71LRPduOkUd2S+EK7wlHwP7UfPmUOQxGJ
	VeyojMfgMl7KJH4y3OLke39jnAe9UArBlQqs/hj8wQJYobnI48vRvw9/4vPaD4ifsZL6ToGvoKs2h
	ib31C5Eg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vl2KC-0005Fc-JM; Wed, 28 Jan 2026 09:59:00 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 28 Jan 2026 01:58:38 -0800
Subject: [PATCH] uprobes: fix incorrect lockdep condition in filter_chain()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-uprobe_rcu-v1-1-d41316763799@debian.org>
X-B4-Tracking: v=1; b=H4sIAM3deWkC/yXMQQqDMBAF0KsMf23AhKKSq5RSTBx1XKhMGimId
 xd1+TZvR2IVTvC0Q3mTJMsMT7YgxLGdBzbSwRNc6arSusbkVZfAX43ZsLNNVbfhFW1AQViVe/n
 f2fvzOOUwcfxdA47jBL/kjupuAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1516; i=leitao@debian.org;
 h=from:subject:message-id; bh=UHbJI7QHhCf6/qLiCs9zoyOI0n9rgQsghe0accS1jGE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBped3eu5M3fbHiVCjgixTSGNxB1xtTmYxjWM1FB
 DXMve5svYCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXnd3gAKCRA1o5Of/Hh3
 bX5HEACaYpnFCKsGemw7IqE6IiSiUz7qQKBRkinhy/JCZIMdrL8RWTBXM6Kr1qjODZDgwgnLV9L
 YqWBavrscM5AGEvcGc8JUg8x81UuMdHEfHvE2pYY+Ufqy9XYfknj7XbAxQxmZOW3sbYYQKbWslt
 LyaToEZndlXC6HkegyAw7SCMP8NUInPdu8v5BcYK8rB4ZgvDiFKIsoM5B9ErluHufnvCQuYgg1Y
 PpKuK2mXP2B9jIfaQZfDTpxMSVqps7JL65Ek2Sr3iKBadj9cP8Jvwl0qolBkg+tHNObg/5q3Huy
 psQGfX6Xn1BypxCr6b+cQMFyA0mB5OHllXs7OqZBP5ljoAMfnkjEOHsIxrkTphPOd/Va0fALa5h
 ppaxOJVzIDv9Wq//0oQqqDuzBPJaGKi1C+3g4qzum9jhOBpH15Di9IOsx2l4xP6ACvkP6nNIJpg
 tCoakdwC3T+x5FyLK2gL23m4v2IXGjyQjY6DdOB3UJkUboZVRVQ985g2Mq8mgkGfsmFss9CH4Ey
 gjchBe+bLP/e+Nqwi1i87teZiBs3ALVCkE3gYb3xIt5HKgfYgn5ZEjbW1ENfE6T1hTIdSNMkFf/
 ZAC1lZ2bKkoFODPDy1S4Nwss3djhl7kADncosu59GojxPQdu0DM+aNYDLZYgXx3DaerqdPEzeJ3
 esiqqRXZBrR6s5w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DMARC_NA(0.00)[debian.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-211943-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+]
X-Rspamd-Queue-Id: 683B59F2BA
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
Fixes: 87195a1ee332a ("uprobes: switch to RCU Tasks Trace flavor for better performance")
Signed-off-by: Breno Leitao <leitao@debian.org>
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


