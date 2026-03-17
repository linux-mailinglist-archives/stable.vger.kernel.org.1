Return-Path: <stable+bounces-226661-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EZyO6uNuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226661-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:21:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 780C72AF68E
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 451F531E5BE6
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED083F788D;
	Tue, 17 Mar 2026 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t6fu3zYD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54A63F7884;
	Tue, 17 Mar 2026 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767700; cv=none; b=InT2Q2F48E0RAKb4P8O5R6ezKJzJoaJwyNNiYS4092dKlSWZAiN2mmoZuHSFP+2c/gWsASvKV9B2Cnw/XRmGV3WDz4U62H1Ctobj+c/uAookl6l7VOMiSwN4KMfrBKE0TSZfEOlXHLnT6mA3n1Ybb5QXlfPULDL2w72t7dAOuus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767700; c=relaxed/simple;
	bh=BkKBaTxdKaNxSNVxH67B6XjXDqndxpcL18su2/ACDvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3QAkRKvTba21+3pnYvPPkQngVY8xloPvq4DyS09co1lu2KHSJuJ3/irhj4CwgmpeF46k6ACYk5aqJ3x+a+vfe24v/sN7bJMoBnOWINH5ZSIHImMd5yPbHgE+WQ7i589pYpFAcPmuqb3PxWyEz1cR/4MetCqHdEPQExrE/w+9kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t6fu3zYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CA1C2BC86;
	Tue, 17 Mar 2026 17:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767699;
	bh=BkKBaTxdKaNxSNVxH67B6XjXDqndxpcL18su2/ACDvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t6fu3zYDYeEOrbSX3KYJCQHdVAEtsVMazV9o+d/Yme+ckuXicMD/3UcULbxRpwwC8
	 mgdx1bnNBpHhvMWwhw7xVk/NW8ZlkC7fNs1cfB90BQ4DbUz62yEtyoNnzLVbEIxSqU
	 2rSBZulob3Mkw09eTN/hMdhd/DadvSCmAOoaAmI0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6.18 106/333] sched_ext: Remove redundant css_put() in scx_cgroup_init()
Date: Tue, 17 Mar 2026 17:32:15 +0100
Message-ID: <20260317163003.299883167@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226661-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,nvidia.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 780C72AF68E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cheng-Yang Chou <yphbchou0911@gmail.com>

commit 1336b579f6079fb8520be03624fcd9ba443c930b upstream.

The iterator css_for_each_descendant_pre() walks the cgroup hierarchy
under cgroup_lock(). It does not increment the reference counts on
yielded css structs.

According to the cgroup documentation, css_put() should only be used
to release a reference obtained via css_get() or css_tryget_online().
Since the iterator does not use either of these to acquire a reference,
calling css_put() in the error path of scx_cgroup_init() causes a
refcount underflow.

Remove the unbalanced css_put() to prevent a potential Use-After-Free
(UAF) vulnerability.

Fixes: 819513666966 ("sched_ext: Add cgroup support")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/ext.c |    1 -
 1 file changed, 1 deletion(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3450,7 +3450,6 @@ static int scx_cgroup_init(struct scx_sc
 		ret = SCX_CALL_OP_RET(sch, SCX_KF_UNLOCKED, cgroup_init, NULL,
 				      css->cgroup, &args);
 		if (ret) {
-			css_put(css);
 			scx_error(sch, "ops.cgroup_init() failed (%d)", ret);
 			return ret;
 		}



