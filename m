Return-Path: <stable+bounces-218112-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJKkDFlQnmlIUgQAu9opvQ
	(envelope-from <stable+bounces-218112-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:28:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D8318EB7D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8596D300B1B2
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2E62505B2;
	Wed, 25 Feb 2026 01:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LVmMtVDf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1001D5ABA;
	Wed, 25 Feb 2026 01:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982890; cv=none; b=EpJTxvMlhLrflbehsa+0nGZIkDj5rk3/j55X5oVgDBpEmR81lj72lp5bxpMVd5GCqAFEXWCCI3ME4ZZF4C0QrDIxHhug316tStylAJyQ6E1nsK3SqNUFe4FEwGY0/LGGd01dW30bLKbi8bl2P4hsC7vahXYy9H5liYINHFToVpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982890; c=relaxed/simple;
	bh=RJX40bqxk/UbnF1D39hvRwLvceyTV2De6DjI50QSKes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfx2twVXIgWt4Wzr8geeQsK6aplnN8kjjS0yXGBEPKwWDyGNP2gwPy707yLzONoOKv5dYUTIRPdjUtcTWx8LiIga3QfnMFGD0mxhlXikN0k1LzYXwRrdR6ojtqTsiQf1d4V9iqRgdTHLPxJqL2upV/YBZUd8KZB9y2MYiBBLMik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LVmMtVDf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CFFC116D0;
	Wed, 25 Feb 2026 01:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982890;
	bh=RJX40bqxk/UbnF1D39hvRwLvceyTV2De6DjI50QSKes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LVmMtVDfsDrkXTJjx+G8oHYWcIrzPgbah8mKG4rfND3ey4s3+FYeGUgoFVsxGASsA
	 /lKDnLAQijf1MJANF1djA/gBxYNj4ZelVHUMyA/ihDiO4ZX8+Ozrk1qhysDm9aunGW
	 FILEOM3n9G0Pe93gEnhMlJF436Axo/8jvsZkaENg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gabriele Monaco <gmonaco@redhat.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Phil Auld <pauld@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 075/781] sched: Export hidden tracepoints to modules
Date: Tue, 24 Feb 2026 17:13:04 -0800
Message-ID: <20260225012401.543570626@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218112-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E7D8318EB7D
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gabriele Monaco <gmonaco@redhat.com>

[ Upstream commit 6c125b85f3c87b4bf7dba91af6f27d9600b9dba0 ]

The tracepoints sched_entry, sched_exit and sched_set_need_resched
are not exported to tracefs as trace events, this allows only kernel
code to access them. Helper modules like [1] can be used to still have
the tracepoints available to ftrace for debugging purposes, but they do
rely on the tracepoints being exported.

Export the 3 not exported tracepoints.
Note that sched_set_state is already exported as the macro is called
from modules.

[1] - https://github.com/qais-yousef/sched_tp.git

Fixes: adcc3bfa8806 ("sched: Adapt sched tracepoints for RV task model")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Link: https://patch.msgid.link/20251205131621.135513-9-gmonaco@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 61c2d65156b50..2df7c1e2aed80 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -119,6 +119,9 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_entry_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_exit_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_set_need_resched_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 DEFINE_PER_CPU(struct rnd_state, sched_rnd_state);
-- 
2.51.0




