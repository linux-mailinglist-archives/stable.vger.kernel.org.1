Return-Path: <stable+bounces-256468-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPheBSsGGWrlpggAu9opvQ
	(envelope-from <stable+bounces-256468-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 05:21:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD11C5FCA7A
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 05:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9762312DFD7
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 03:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D99F36BCDD;
	Fri, 29 May 2026 03:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="P4sKsToa"
X-Original-To: stable@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A0735F5E5;
	Fri, 29 May 2026 03:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024591; cv=none; b=bwyghUIkFJ+/s09d3hNHpvk98cV9KFN1jEZKhR5Wv0/BrchANHHuDGrcCEoKtCt0UUHKd7FCjqUaWbDgSW38pHeHylBCl9MYMPoUKemfIPx9uuu4uwleIWz17GcdhQ5FVB0d3OFpSTJ5Wr4LmpmTKI8gZgXLot8IM2DbzlbqG5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024591; c=relaxed/simple;
	bh=yU+ab5X7M+Ppyb0GFmtgBCV9j8tOHNkEuYHDYaMjSOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g6Q5fMichJyeNQFL32hHACU7dVtLxQMNX1ar10P9cCg3mINm0tJmfZI+JjGGYIGSzDlWQIbr2wAJCoBBMZs9TBctUKBd9g9rrVLaxlQr+hWcvQ4iBhwz9d2K69QFzWlCoaZAhBZbkAw+ukypCpkNJ63wqF1ayUxNLJvLG/IU3Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=P4sKsToa; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 40433aa4a;
	Fri, 29 May 2026 11:10:57 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: martin.lau@linux.dev
Cc: emil@etsalapatis.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	kees@kernel.org,
	joel.granados@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	stable@vger.kernel.org,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH v2 3/3] bpf: cgroup: restore sysctl new-value replacement
Date: Fri, 29 May 2026 11:10:26 +0800
Message-Id: <20260529031026.2716641-4-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529031026.2716641-1-dawei.feng@seu.edu.cn>
References: <20260529031026.2716641-1-dawei.feng@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e71b6aad503a2kunm60a0b1e7a4157
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHkgYVktIHh0ZH0tISRpIHlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
	5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=P4sKsToaMiC0Rd6eLwWFUeIFIrUBtznbo2mkJXf/nq2zpfXdF6OhDjpc5wm+lHLGJxbljHd4hU/J4d3bcHs1e9P3S52tAVezNM0eh2A4zteamiKRKQaw6EcKXbh/Yh95XIhpqtv2HYgND2kUUAv2PAFk3XThX7sM9uovgSQEtcc=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=Q8ygCLpd4HOGNVC/mOD+BveGduwQFjiEob+c3aUyCPs=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[etsalapatis.com,kernel.org,iogearbox.net,gmail.com,linux.dev,vger.kernel.org,seu.edu.cn];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256468-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawei.feng@seu.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,seu.edu.cn:email,seu.edu.cn:mid,seu.edu.cn:dkim]
X-Rspamd-Queue-Id: AD11C5FCA7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 4e63acdff864 ("bpf: Introduce bpf_sysctl_{get,set}_new_value
helpers") changed the success return value to 0, but failed to update the
corresponding check in __cgroup_bpf_run_filter_sysctl(). Since
bpf_prog_run_array_cg() now returns 0 on success, the legacy ret == 1
condition is never satisfied. As a result, the modified value is ignored,
and bpf_sysctl_set_new_value() fails to replace the write buffer.

Fix this by checking for a return value of 0 instead, so cgroup/sysctl
programs can correctly replace the pending sysctl buffer.

This bug was discovered during a manual code review. Tested via a
cgroup/sysctl BPF reproducer overriding writes to a target sysctl.
Pre-fix, bpf_sysctl_set_new_value("foo") was silently ignored: the write
returned 8192 and the value remained "600". Post-fix, the BPF replacement
buffer properly propagates: the write returns 3 and the value updates to
"foo".

Fixes: 4e63acdff864 ("bpf: Introduce bpf_sysctl_{get,set}_new_value helpers")
Cc: stable@vger.kernel.org

Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
---
 kernel/bpf/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index a0b5f8cd8b10..3f06e2270f5c 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1935,7 +1935,7 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
 
 	kfree(ctx.cur_val);
 
-	if (ret == 1 && ctx.new_updated) {
+	if (!ret && ctx.new_updated) {
 		kvfree(*buf);
 		*buf = ctx.new_val;
 		*pcount = ctx.new_len;
-- 
2.34.1


