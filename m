Return-Path: <stable+bounces-226247-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SO0UFf+EuWlyIgIAu9opvQ
	(envelope-from <stable+bounces-226247-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:44:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DF92AE531
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 49B06302C28A
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D743EE1CB;
	Tue, 17 Mar 2026 16:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sllqlCjr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E942F12B94;
	Tue, 17 Mar 2026 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765885; cv=none; b=iQBdTrpZNrB8HNYqxA77FVs+pvZFfK90FTAJsjEpISviinwQrQLjWgz6s3uQebkSVALX5rNOGCgTPPrF12jCjkDKFSsNH/xMUuVw4Zf46croeuEBlzXCrwgCeQEp1S02IsXSdqTXey1GtcqXXe0QBCzNgo5EFVd+GE5yeKAj2I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765885; c=relaxed/simple;
	bh=uBjGPQqOLihfMJrKV+CJoJ9lTIn841ZugsFUh9F2BmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4gKtukwhdQfKsRhfuCkMjmPA05tyjJK8Q+qMeGjp5TF6SXisxiA/K6/VhBmTWGCT1q5gB+EJOpfALxcQnjhlrSx7gDLE/RlnSDcg6NJRIvABGmIu4CA8m9UGLS5hNh4rVNK4LAIr3fojtS7RWEV6JQxSysIwhdbXTeHj0Tq7TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sllqlCjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5595FC4CEF7;
	Tue, 17 Mar 2026 16:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773765884;
	bh=uBjGPQqOLihfMJrKV+CJoJ9lTIn841ZugsFUh9F2BmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sllqlCjrF0447+lcjyOrM6K9B39/SlpMgcnUYgOzq4EreWJ+qLeuXAMcGj8iuAqW/
	 zuXifwWQRS9IqXs7ZVL/CklEJw0McnYXgC+yUtduXDUuZrkOmf4nv23l+NiDpRW4rc
	 EUiR6h3xMvgEgmy6eedHTDsIhGH/0VmPJOMafrrs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6.19 116/378] sched_ext: Remove redundant css_put() in scx_cgroup_init()
Date: Tue, 17 Mar 2026 17:31:13 +0100
Message-ID: <20260317163011.283936440@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226247-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,nvidia.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: E1DF92AE531
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3553,7 +3553,6 @@ static int scx_cgroup_init(struct scx_sc
 		ret = SCX_CALL_OP_RET(sch, SCX_KF_UNLOCKED, cgroup_init, NULL,
 				      css->cgroup, &args);
 		if (ret) {
-			css_put(css);
 			scx_error(sch, "ops.cgroup_init() failed (%d)", ret);
 			return ret;
 		}



