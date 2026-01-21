Return-Path: <stable+bounces-210922-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eE4MHhMycWlQfQAAu9opvQ
	(envelope-from <stable+bounces-210922-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:07:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0765CD47
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9594BA0F493
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE39C392B66;
	Wed, 21 Jan 2026 18:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y/p9P2qK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680FA33DECE;
	Wed, 21 Jan 2026 18:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019841; cv=none; b=jGo/Y6AdNv9zxLz58TuQ+dD/LK0i8DH1AErYpIrcmDLyA7hzMS0cxWBEz+GFFDMWA03/ydPpkFSGprmyDix7cvOQ3oP6/eKqk3FnRgw8oZP1od8RsiKyMX9312tHj1jhMQzQI9lp9FHIWXZ+Ex0Zp2V2/ydDJTSO35ome+E30Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019841; c=relaxed/simple;
	bh=iOtRQMr+wzLySGyNWrSvJTzVIX55e1Oun3mcUgBN2gA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RT/6DCvlWrSjYIhFZ6JdmYo7fJhiZBRtZJHESX5Ih8Cn/2PaiCA/KERHUohTL7wZYcGkTZYeMuI613PzNx22w7KW5VzBLueVxGmQAiQpBHvYJJ5CrwVXEATPYOJe93kWVyMzgoVlM0oxlDBy21jhSbu+b7ZD7y8DMwTv1nPz7Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y/p9P2qK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27ADFC4CEF1;
	Wed, 21 Jan 2026 18:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019839;
	bh=iOtRQMr+wzLySGyNWrSvJTzVIX55e1Oun3mcUgBN2gA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y/p9P2qKKNxcKh/B2w3morP34Z9Wh/Nuc3hninSTpkDbiTcmlOCf1Gspl/4tK/9Oa
	 UUWEaPbZai/C/H97uT7cCRr4jQDxEIciZhyK3Youga89VAWDlGHecdHX30nLCjTRvB
	 +Nn15rvt5aUp6kBgGz1gGkodVtNRcC5fcWTJAwPI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12 095/139] mm/page_alloc: make percpu_pagelist_high_fraction reads lock-free
Date: Wed, 21 Jan 2026 19:15:43 +0100
Message-ID: <20260121181414.872061273@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
References: <20260121181411.452263583@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210922-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,nvidia.com:email,suse.cz:email,linux-foundation.org:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: EA0765CD47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aboorva Devarajan <aboorvad@linux.ibm.com>

commit b9efe36b5e3eb2e91aa3d706066428648af034fc upstream.

When page isolation loops indefinitely during memory offline, reading
/proc/sys/vm/percpu_pagelist_high_fraction blocks on pcp_batch_high_lock,
causing hung task warnings.

Make procfs reads lock-free since percpu_pagelist_high_fraction is a
simple integer with naturally atomic reads, writers still serialize via
the mutex.

This prevents hung task warnings when reading the procfs file during
long-running memory offline operations.

[akpm@linux-foundation.org: add comment, per Michal]
  Link: https://lkml.kernel.org/r/aS_y9AuJQFydLEXo@tiehlicka
Link: https://lkml.kernel.org/r/20251201060009.1420792-1-aboorvad@linux.ibm.com
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/page_alloc.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6321,11 +6321,19 @@ static int percpu_pagelist_high_fraction
 	int old_percpu_pagelist_high_fraction;
 	int ret;
 
+	/*
+	 * Avoid using pcp_batch_high_lock for reads as the value is read
+	 * atomically and a race with offlining is harmless.
+	 */
+
+	if (!write)
+		return proc_dointvec_minmax(table, write, buffer, length, ppos);
+
 	mutex_lock(&pcp_batch_high_lock);
 	old_percpu_pagelist_high_fraction = percpu_pagelist_high_fraction;
 
 	ret = proc_dointvec_minmax(table, write, buffer, length, ppos);
-	if (!write || ret < 0)
+	if (ret < 0)
 		goto out;
 
 	/* Sanity checking to avoid pcp imbalance */



