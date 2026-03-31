Return-Path: <stable+bounces-232469-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFcTELEHzGn+NQYAu9opvQ
	(envelope-from <stable+bounces-232469-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:43:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEAD36F308
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 054E731470B3
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4553016EE;
	Tue, 31 Mar 2026 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L47uGMb7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E513301471;
	Tue, 31 Mar 2026 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976828; cv=none; b=EuMlzYb1p/T4FJt7BAtAWcI6OUMky7TtK/zPFTUgHZD+trE35koJ3bqfJIigvrTcZ1uxwbfKQitq8Hru3dmbRBp94a2wvsIeie0bsKAXsQESilhh5fhASeHD+qgJasKoIQOoLOMNavC8YgV1aa9OlcGGq5Rrp8Cqd90UiPtNFKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976828; c=relaxed/simple;
	bh=5ASkjnnd30bpamzJyYkQXB7uZwwWqH7xZy/2225XoKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZ01LZJCoZzuJ/AWoCnjVVZ8Ma5a1vXBM+QuSyXclHu5gS19aYzmSBxQWIopv8bihb2+SyoAJsxignRQPmS6JNiyrPy2jwrsdgd8DKPoICtMBDkTwPSzCMtYe3+mcLuVqNntNJjhoYu2v9Nal+Da+l25YF8LHd+rGZKsSlxLN2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L47uGMb7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA46BC19423;
	Tue, 31 Mar 2026 17:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976828;
	bh=5ASkjnnd30bpamzJyYkQXB7uZwwWqH7xZy/2225XoKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L47uGMb7YdelHd6Izy/Vs9SB6/lIckSTEvqmrIIQwvaVVnEgEnFZH4wcNPkidb0Os
	 FFYoIrDL6azodeHItCLFB/Wau5enXIvFaK6/UZS8lrDbxbHp/1eiiXQm+mwshFABn7
	 N97LxxGCbQ5+9fWZRWu6ugMQnLN6IiDOEPBQqFgE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josh Law <objecting@objecting.org>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18 244/309] mm/damon/sysfs: check contexts->nr before accessing contexts_arr[0]
Date: Tue, 31 Mar 2026 18:22:27 +0200
Message-ID: <20260331161802.551778175@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232469-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,objecting.org:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linux-foundation.org:email]
X-Rspamd-Queue-Id: 4DEAD36F308
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Law <objecting@objecting.org>

commit 1bfe9fb5ed2667fb075682408b776b5273162615 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/damon/sysfs.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1700,6 +1700,9 @@ static int damon_sysfs_update_schemes_tr
 static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
 		struct damon_sysfs_kdamond *kdamond)
 {
+	if (cmd != DAMON_SYSFS_CMD_OFF && kdamond->contexts->nr != 1)
+		return -EINVAL;
+
 	switch (cmd) {
 	case DAMON_SYSFS_CMD_ON:
 		return damon_sysfs_turn_damon_on(kdamond);



