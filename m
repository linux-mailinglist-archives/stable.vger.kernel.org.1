Return-Path: <stable+bounces-251146-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DFWIQvwDWp+4wUAu9opvQ
	(envelope-from <stable+bounces-251146-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:31:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB5C593E0B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2390311967D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B2C37754D;
	Wed, 20 May 2026 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iqSbICp2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7523264EB;
	Wed, 20 May 2026 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297218; cv=none; b=tMSAcxxqmpruqCWLaVlPtN+aqjeB2BdKeUu7YGzVOxp4YyOzcFEyQ+7/2FgiH2XGasJh8HASvFmwAT9pzOH4OSbQEAAvkjy9XMqKP4eapF2xbmViJdOha9euKYhn5A4vU53RpCDODtnEC+3HhmXiDVyakhfA3g+IXJ2vh7TBuS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297218; c=relaxed/simple;
	bh=r5OcfKQtyktDa/yAfIeRkHGlUuiAnO4aB38hv1v4a80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDA5U4P26rJ/b48T84rifVZ4QQcrRCZ8KMI2meY5J92LcNNLH3/euvlUscPi4XhG+1ng5+RrTeIGkOXaAPDY19gk3+X+kZvvs1B92u09cpAHOf4mpUMP9d0HxkKIWmXkLtehfhOuNKhRNFg4X0EP14qE0rJ8t3jJWOZ5Rf4hBOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iqSbICp2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2243D1F000E9;
	Wed, 20 May 2026 17:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297217;
	bh=zdLT1kCVkhmsRIFGy/z0tnTxxa9D2I7JqcuUlNHQ8kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iqSbICp2CE7JwjFAiJ+bS0XNgNnrKUZ8q2RLHUygBeTHzln/qfeZ4PkP2paOpO4sB
	 Qp00UAypBLrQvN9wGb/3+lSv1bBa6CBzmOvXuliv2qR69Md5iWj0i1I2Llq3z1s09f
	 1pPo5lkNFgnCAKcILbrM7OcbcJaIuET0Iawzm3F0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Breno Leitao <leitao@debian.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 7.0 1043/1146] workqueue: Fix wq->cpu_pwq leak in alloc_and_link_pwqs() WQ_UNBOUND path
Date: Wed, 20 May 2026 18:21:33 +0200
Message-ID: <20260520162211.835124774@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251146-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EFB5C593E0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5629,7 +5629,9 @@ static int alloc_and_link_pwqs(struct wo
 		ret = apply_workqueue_attrs_locked(wq, unbound_std_wq_attrs[highpri]);
 	}
 
-	return ret;
+	if (ret)
+		goto enomem;
+	return 0;
 
 enomem:
 	if (wq->cpu_pwq) {



