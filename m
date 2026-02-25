Return-Path: <stable+bounces-218116-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMGhHVtQnmlIUgQAu9opvQ
	(envelope-from <stable+bounces-218116-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:28:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 572FB18EB92
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D81D3304AAF3
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4033251795;
	Wed, 25 Feb 2026 01:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p36AqkXU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78E74369A;
	Wed, 25 Feb 2026 01:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982894; cv=none; b=l0k7rG2BKfg6WU+aedr9GdgUPMVUCS4sO/nkRq9qZ29KNFZFxSQugB3Jau6QxM78r8FpwmCAHrxWqOGygzqf8lCCX+uqvRfQQu8Mg8hSUr77Jnr+i/yJPdxsJ91zq7A9yBNDJXslkrsko0328UCfI/aotdI96PK/ShtvXy2oWLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982894; c=relaxed/simple;
	bh=pv0VLznbjUH5/jyKfMPffqtIBGH1Ag5pCH42OVahT74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amaqYL/FASkmy2eRmqCafCEovW2BcHjCwS4ABBtNeXu/Crm2Nwo5KhPZrZ1P6m7fugYt0EuOxmCioHguDrfCxpbe6rdtxLZysH/5KrOd5XYU9OVD41Fwji4UvxRWb7cVfhA2gSIgU71HNKAgjHSMzif2IllI+9zrX/wg1Aoxu6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p36AqkXU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770D0C116D0;
	Wed, 25 Feb 2026 01:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982894;
	bh=pv0VLznbjUH5/jyKfMPffqtIBGH1Ag5pCH42OVahT74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p36AqkXU2A9hwKrMZ9rmWjzAv3c+kxEI5ZjmDIQYq4mykh/ENpr4SoBDACd2YSJwg
	 3NNgKEvsklNBmI8fhn1og0BKRNgA7gPS348ucWOtDr6R9pjRb1e+9DeqbQ1GZb/6Io
	 pTiybcKwmdAJyDpRagBbLKA2JT97Wf6rmw0YOpew=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gabriele Monaco <gmonaco@redhat.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Phil Auld <pauld@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 079/781] sched: Fix build for modules using set_tsk_need_resched()
Date: Tue, 24 Feb 2026 17:13:08 -0800
Message-ID: <20260225012401.642051441@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-218116-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 572FB18EB92
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gabriele Monaco <gmonaco@redhat.com>

[ Upstream commit 8d737320166bd145af70a3133a9964b00ca81cba ]

Commit adcc3bfa8806 ("sched: Adapt sched tracepoints for RV task model")
added a tracepoint to the need_resched action that can be triggered also
by set_tsk_need_resched.
This function was previously accessible from out-of-tree modules but
it's no longer available because the __trace_set_need_resched() symbol
is not exported (together with the tracepoint itself, which was exported
in a separate patch) and building such modules fails.

Export __trace_set_need_resched to modules to fix those build issues.

Fixes: adcc3bfa8806 ("sched: Adapt sched tracepoints for RV task model")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Link: https://patch.msgid.link/20260112140413.362202-1-gmonaco@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2df7c1e2aed80..c3b6e123fa00e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1139,6 +1139,7 @@ void __trace_set_need_resched(struct task_struct *curr, int tif)
 {
 	trace_sched_set_need_resched_tp(curr, smp_processor_id(), tif);
 }
+EXPORT_SYMBOL_GPL(__trace_set_need_resched);
 
 void resched_curr(struct rq *rq)
 {
-- 
2.51.0




