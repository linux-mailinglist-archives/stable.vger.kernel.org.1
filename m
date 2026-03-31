Return-Path: <stable+bounces-231322-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JJ7EI1by2lJGwYAu9opvQ
	(envelope-from <stable+bounces-231322-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 07:28:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1CF3641E3
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 07:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1EFEF301545A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 05:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B7836EABF;
	Tue, 31 Mar 2026 05:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noCM57/t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B668C29E0F6;
	Tue, 31 Mar 2026 05:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774934920; cv=none; b=McRgphO6FQY0jkDqSMTplremZuDbGy5G6n5NBCFTqxKQa/osfBguG1YCZsQSPvOtSH0xvHsU30s6kLDz/cdyqbWa2j2z77dgOGJNoqEm3882P2p20H2Tl+/qvlW2NEih94Lw9/6DelobRhUenhtGqGrWWRA3TkhVa9RDg+nfObQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774934920; c=relaxed/simple;
	bh=+Bku8QdBzfNE9060qI3hHjAAlgN1XJ+QsUnUMhIfTww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ge+lFwotyysO0mZFt419UPU1IBjtHL5bA0N2oRzuCFZo51cBo0rZvNFjoFaE5p+LN4ithKBUkv4b4bK+tRbR24qQ1wLLoyqdB/Nh5t6xrhnlMkkE/T6CD+/cjgN74WyGC6DA38Yjt9vf/18ibuMP6B1iOVAWG0c+eA0+AE8BuOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noCM57/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC79C19423;
	Tue, 31 Mar 2026 05:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774934920;
	bh=+Bku8QdBzfNE9060qI3hHjAAlgN1XJ+QsUnUMhIfTww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=noCM57/tC+ZKaAzklJ5CJEevkGW5fC59phSSjgz3d0AoyfXufsF7Q8izXCJiokGBA
	 GCmsFc0chaZqRqQ2gKVi29T7WQTqi8ndjv7r5Bs2aYuiumyP3Z7KgKGWDyMIWQ5T5+
	 l5zMFeOPwKDwKaWpUCU2jbGsP7BXtHSgu67GGiuT2P86lpr6eNYSAj7bEpx9jhyYpP
	 XG45870LupIZUfMHXbtqTK6jBWMUXke6srW+mLTXqIEB8IIzBmga1sIcJadVxEgiti
	 t8Mf1XMSSzYzXqvjdQskvY6Vc2xtvApCaQr3VvYyhHdClPUyM7P9u7N/xWmdCrcQhl
	 6bLVBHW+h/qkg==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	Josh Law <objecting@objecting.org>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/sysfs: check contexts->nr before accessing contexts_arr[0]
Date: Mon, 30 Mar 2026 22:28:38 -0700
Message-ID: <20260331052838.73914-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026033036-ecosphere-leggings-7691@gregkh>
References: <2026033036-ecosphere-leggings-7691@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231322-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[objecting.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux-foundation.org:email]
X-Rspamd-Queue-Id: DC1CF3641E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Josh Law <objecting@objecting.org>

Multiple sysfs command paths dereference contexts_arr[0] without first
verifying that kdamond->contexts->nr == 1.  A user can set nr_contexts to
0 via sysfs while DAMON is running, causing NULL pointer dereferences.

In more detail, the issue can be triggered by privileged users like
below.

First, start DAMON and make contexts directory empty
(kdamond->contexts->nr == 0).

    # damo start
    # cd /sys/kernel/mm/damon/admin/kdamonds/0
    # echo 0 > contexts/nr_contexts

Then, each of below commands will cause the NULL pointer dereference.

    # echo update_schemes_stats > state
    # echo update_schemes_tried_regions > state
    # echo update_schemes_tried_bytes > state
    # echo update_schemes_effective_quotas > state
    # echo update_tuned_intervals > state

Guard all commands (except OFF) at the entry point of
damon_sysfs_handle_cmd().

Link: https://lkml.kernel.org/r/20260321175427.86000-3-sj@kernel.org
Fixes: 0ac32b8affb5 ("mm/damon/sysfs: support DAMOS stats")
Signed-off-by: Josh Law <objecting@objecting.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>	[5.18+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 1bfe9fb5ed2667fb075682408b776b5273162615)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index acb6e57cd9cb..7a410640a0ef 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1494,6 +1494,9 @@ static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
 {
 	bool need_wait = true;
 
+	if (cmd != DAMON_SYSFS_CMD_OFF && kdamond->contexts->nr != 1)
+		return -EINVAL;
+
 	/* Handle commands that doesn't access DAMON context-internal data */
 	switch (cmd) {
 	case DAMON_SYSFS_CMD_ON:
-- 
2.47.3


