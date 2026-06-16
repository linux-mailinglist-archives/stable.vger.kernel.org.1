Return-Path: <stable+bounces-263760-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9GSQDodeMWrFiAUAu9opvQ
	(envelope-from <stable+bounces-263760-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:32:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABCE690888
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:32:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=O6MOoDND;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263760-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263760-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67B6F32E971D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 14:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFA9384CFF;
	Tue, 16 Jun 2026 14:16:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCA7379EFC
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 14:16:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619379; cv=none; b=jW5qTG1zPxFU28MI/+VGjDYs2zz8z7ib5cObQxA37WlEtjmYY6uvRtN/TrA4o4KQnv7thEnVKcgnqET89fCL7unsalchxH5ML6CSR3W0cUCEHJtqFkNE0DQ9rP7G+AipFz8G/p8H0te4SlBvJhrC+8oDYBOYFGqbs8+SUrJpqYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619379; c=relaxed/simple;
	bh=MVCtyfAmHP+tCWl4X6qpjB0hvAOfROEwoYvmoMY6LH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H71kZmeuxJ1KGDYYVH0s2nftFHc+cCJsrjh0pot7JdUmn5Icx50zMA1mIiGHtd5YoQwCycwwvlODThEDxM/tmnjSOKPzZ3FUe5YVMuFJYV2D4l6J7mI1W+Ua87ANUoz92G5vXevlN3huDGUMQmwWZ9q7+ltbX4dmHRAqoAkUkF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O6MOoDND; arc=none smtp.client-ip=91.218.175.171
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781619374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+d8yIEBEDqcbYiBBajCXV/8Pg50pBSzJlMnixHKyM4M=;
	b=O6MOoDNDZkEuBsP+7cYr3hYdGYlsVhvrID+NOnEHElhFRtKVUTC8XfrLxMHthascKFRO4F
	v3td8v0R79f6nnQtdCMmOlQhR95VlzwGp22nzqH78OuoecpRhurJq4LqmGPexizjJ5JPc8
	b21nIgj4uBmTdBpOIQwgKubE8wM3YKY=
From: Usama Arif <usama.arif@linux.dev>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com
Cc: shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	riel@surriel.com,
	kernel-team@meta.com,
	Usama Arif <usama.arif@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] kernel/fork: clear PF_BLOCK_TS in copy_process()
Date: Tue, 16 Jun 2026 07:15:17 -0700
Message-ID: <20260616141604.328820-2-usama.arif@linux.dev>
In-Reply-To: <20260616141604.328820-1-usama.arif@linux.dev>
References: <20260616141604.328820-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263760-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:linux-block@vger.kernel.org,m:bsegall@google.com,m:dietmar.eggemann@arm.com,m:juri.lelli@redhat.com,m:kprateek.nayak@amd.com,m:linux-kernel@vger.kernel.org,m:mgorman@suse.de,m:mingo@redhat.com,m:peterz@infradead.org,m:rostedt@goodmis.org,m:vincent.guittot@linaro.org,m:vschneid@redhat.com,m:shakeel.butt@linux.dev,m:hannes@cmpxchg.org,m:riel@surriel.com,m:kernel-team@meta.com,m:usama.arif@linux.dev,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[usama.arif@linux.dev,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usama.arif@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9ABCE690888

PF_BLOCK_TS is only set in blk_time_get_ns() when current->plug is
non-NULL, and blk_finish_plug() clears it via __blk_flush_plug()
before NULLing the plug pointer.  copy_process() breaks the
invariant by inheriting PF_BLOCK_TS from the parent while resetting
the child's plug to NULL.

Clear PF_BLOCK_TS alongside that assignment so callers can rely on
"PF_BLOCK_TS set implies current->plug != NULL" and dereference
current->plug unguarded.

Fixes: 06b23f92af87 ("block: update cached timestamp post schedule/preemption")
Cc: stable@vger.kernel.org
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 kernel/fork.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 892a95214c54..13e38e89a1f3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2338,6 +2338,7 @@ __latent_entropy struct task_struct *copy_process(
 
 #ifdef CONFIG_BLOCK
 	p->plug = NULL;
+	p->flags &= ~PF_BLOCK_TS;
 #endif
 	futex_init_task(p);
 
-- 
2.53.0-Meta


