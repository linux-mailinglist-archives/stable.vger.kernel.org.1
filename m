Return-Path: <stable+bounces-235120-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOZOL+al1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-235120-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:00:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 673123C22D1
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 858CD307ABBD
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556873624B9;
	Wed,  8 Apr 2026 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1pZ3z7OV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1875BB67E;
	Wed,  8 Apr 2026 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674621; cv=none; b=Hmg+vIIzBeSo0qlucfJVmYKxKGoig1zKcuyhkT7avn8aACMhjomffra81W59lZtLPaG9kMLCUptUmK2+1VzKspGzDktDU+r2Voa/JFBEqUlPIyD4sL6W4wCvG9q/LNP6JG4Wa3Qyrfa6nwRuFuIsraGv2HjcRhtdQmEUSe+ZYrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674621; c=relaxed/simple;
	bh=cP3ZiiiHmQR0BLZT52I9ZQszdJyi2w+0/ruzurYSd9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3tNIE6EPAl2GPk18DkOzFSLc5ddGlIwcp+0laOKTNBmNqvru1J0FZ3WdLNPoeIOpyb2SxZfzqtu1/wVZAbN1RadQ2jGRWZvG45MTck4Og9EOkUBCRSPfKt9c/MddIS4ZOd/vZ6KCB2EuMiOcj/xi2OldfV1Nk4dpjAW7gC7/58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1pZ3z7OV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FEFC19421;
	Wed,  8 Apr 2026 18:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674621;
	bh=cP3ZiiiHmQR0BLZT52I9ZQszdJyi2w+0/ruzurYSd9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1pZ3z7OVOIe5qdqV9WtlNcYomLInu/S9VzFRLjacHogKg+wzLUEM2Pk7nqHIr8i9e
	 Or8UCKjbVTbHAy8pb50yiJ5MIvepM/3Qn2kAM8ETJIUvWyFU7S0+wdf6RwpjN5QV6b
	 phRLtSmUGIKBGH+p7WYIOzPEdMe5ZHzcbVDJlTHI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6.19 167/311] sched_ext: Fix inconsistent NUMA node lookup in scx_select_cpu_dfl()
Date: Wed,  8 Apr 2026 20:02:47 +0200
Message-ID: <20260408175945.641057377@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235120-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,nvidia.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 673123C22D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cheng-Yang Chou <yphbchou0911@gmail.com>

commit db08b1940f4beb25460b4a4e9da3446454f2e8fe upstream.

In the WAKE_SYNC path of scx_select_cpu_dfl(), waker_node was computed
with cpu_to_node(), while node (for prev_cpu) was computed with
scx_cpu_node_if_enabled(). When scx_builtin_idle_per_node is disabled,
idle_cpumask(waker_node) is called with a real node ID even though
per-node idle tracking is disabled, resulting in undefined behavior.

Fix by using scx_cpu_node_if_enabled() for waker_node as well, ensuring
both variables are computed consistently.

Fixes: 48849271e6611 ("sched_ext: idle: Per-node idle cpumasks")
Cc: stable@vger.kernel.org # v6.15+
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/ext_idle.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -543,7 +543,7 @@ s32 scx_select_cpu_dfl(struct task_struc
 		 * piled up on it even if there is an idle core elsewhere on
 		 * the system.
 		 */
-		waker_node = cpu_to_node(cpu);
+		waker_node = scx_cpu_node_if_enabled(cpu);
 		if (!(current->flags & PF_EXITING) &&
 		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
 		    (!(flags & SCX_PICK_IDLE_IN_NODE) || (waker_node == node)) &&



