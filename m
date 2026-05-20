Return-Path: <stable+bounces-253304-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KjFL0wHDmp25gUAu9opvQ
	(envelope-from <stable+bounces-253304-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:11:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54874597E3B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8897731330A0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C361F402BBF;
	Wed, 20 May 2026 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UXZ7lAT4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CBF3DD504;
	Wed, 20 May 2026 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302930; cv=none; b=DMcZ4DrMOeIovz+yaSNPWU0+4PSIyJjyBtzJLbR3zjtk9G1QmXmdK9fXGOG9x4EIRsViRyXJE7YkKqD5pbgfhkiZ89eTYR2No4ap/mlRIp2ayHH0Zj6k2TAvINt4hgWtv2scUM/jV8q6+L7A1mFF5nc7amInQQODN3WUwnLwA8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302930; c=relaxed/simple;
	bh=y7ngXbw79DX1FrTjIlSCF2dbMd4mT1SOwQ6NMGiCsFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bedYlpmWbAuItkY/sMdV28fudFnb1pXTz2xh+UWVV0RPUS8MiyJgoB2EcXuRoWxmml2y8HEMKgX0YDI1xutK3Mzy8ggd9O/cehgxLO/YwvNJ5kp/8ou50nQQijl4QwaptJYjDVcpFwk5NzSXUr15xoFsSb3oPgciBP0EpkkvpuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UXZ7lAT4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023101F000E9;
	Wed, 20 May 2026 18:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779302927;
	bh=MktEpKkaqTrVc4h3ymdaCMzK5Z390G6qgWy1FlJ/0nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UXZ7lAT4x1qCcYugbflMGSDmPMeFNjAl0G+kyq0Rex1M2Q9fHPYm6TSEpP5YUWevf
	 fRpCPUQgllBZNFQx7d3FSxINcmog1XeOxVRS7uZvGUsnihd2gC8OoZ6gspa8BPcEkX
	 1pYSYv3OidKRreuUljpJDKbHfld6pIVXbJVoX5kQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Breno Leitao <leitao@debian.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6.6 453/508] workqueue: Fix wq->cpu_pwq leak in alloc_and_link_pwqs() WQ_UNBOUND path
Date: Wed, 20 May 2026 18:24:36 +0200
Message-ID: <20260520162108.409938082@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253304-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 54874597E3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4683,7 +4683,9 @@ static int alloc_and_link_pwqs(struct wo
 	if (ret)
 		kthread_flush_worker(pwq_release_worker);
 
-	return ret;
+	if (ret)
+		goto enomem;
+	return 0;
 
 enomem:
 	if (wq->cpu_pwq) {



