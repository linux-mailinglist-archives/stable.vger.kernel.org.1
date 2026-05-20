Return-Path: <stable+bounces-252825-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEVvNo/+DWo95QUAu9opvQ
	(envelope-from <stable+bounces-252825-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:33:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 99690596966
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08E853013A52
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51AC3F7ABC;
	Wed, 20 May 2026 18:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DjRfLZmv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A97F3EDAC6;
	Wed, 20 May 2026 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301687; cv=none; b=k18NH6Vu4gOQGN5dy2hr6nVSF4sRj4SZ8cbeN1qRDX4due4D06A8lgG/bJbx6jlzJk4lnBxxn3g5fbA8QqxKxBvqImDKnT5R24DFDguR91vgCfPFQO4B8QMAmRtcbzDURoyhjOygw4S5zWJWHxyPnewz5NBs+8Hcw5UCjSXs9ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301687; c=relaxed/simple;
	bh=iVBBSDw1EvdLBVEcG8hY6IsC+HutZ0TB5Gd+2OcEjr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bF1bocrITlkao2o2tk1OD0PhbvV51IH9zwH2PLgDddEb5IHzVCiXsTOiwJFF3p2/DaAWhlefFRHvWAVg7cU9E6cvzWQVzfR8pOtKodTIBNttT2j3A9JW1Qe7hlCTH/UNYn6QQWuGfp4iqKXFMx2Y++Ns6D1YYgsE5rHsKUnKEvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DjRfLZmv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE381F00896;
	Wed, 20 May 2026 18:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301686;
	bh=ccnDe62tZgy3tGDQY00kFPYEdGDSlWkc8Mt1Se1UuiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DjRfLZmv+75vdac2O4A1M6lps7IgA2CQDrW/qT4S1MjyY2RaOYzcXq4WzwSHemt8A
	 Tc/dKkQNinhpoC7AKVpt/s2A/slQ70N1EIetDhUClbRZgefazAXzIE6ZLbbZx/SxfH
	 /zFJ7qYvhGYU92K/LYczxQk3oF7G2PwvkjbzycZU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Breno Leitao <leitao@debian.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6.12 612/666] workqueue: Fix wq->cpu_pwq leak in alloc_and_link_pwqs() WQ_UNBOUND path
Date: Wed, 20 May 2026 18:23:43 +0200
Message-ID: <20260520162124.536405218@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252825-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 99690596966
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Breno Leitao <leitao@debian.org>

commit 0143033dc22cdff912cfc13419f5db92fea3b4cb upstream.

For WQ_UNBOUND workqueues, alloc_and_link_pwqs() allocates wq->cpu_pwq
via alloc_percpu() and then calls apply_workqueue_attrs_locked(). On
failure it returns the error directly, bypassing the enomem: label
which holds the only free_percpu(wq->cpu_pwq) in this function.

The caller's error path kfree()s wq without touching wq->cpu_pwq,
leaking one percpu pointer table (nr_cpu_ids * sizeof(void *) bytes) per
failed call.

If kmemleak is enabled, we can see:

  unreferenced object (percpu) 0xc0fffa5b121048 (size 8):
    comm "insmod", pid 776, jiffies 4294682844
    backtrace (crc 0):
      pcpu_alloc_noprof+0x665/0xac0
      __alloc_workqueue+0x33f/0xa20
      alloc_workqueue_noprof+0x60/0x100

Route the error through the existing enomem: cleanup and any error
before this one.

Cc: stable@kernel.org
Fixes: 636b927eba5b ("workqueue: Make unbound workqueues to use per-cpu pool_workqueues")
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/workqueue.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5568,7 +5568,9 @@ static int alloc_and_link_pwqs(struct wo
 		ret = apply_workqueue_attrs_locked(wq, unbound_std_wq_attrs[highpri]);
 	}
 
-	return ret;
+	if (ret)
+		goto enomem;
+	return 0;
 
 enomem:
 	if (wq->cpu_pwq) {



