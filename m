Return-Path: <stable+bounces-65558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A247F94A9A1
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 16:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF831F29C5B
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 14:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B864350271;
	Wed,  7 Aug 2024 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TurlCLo7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7699839FFE
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040034; cv=none; b=T/dDrRy/+4Ws9ecVE1rx16bWstCm0fA1FKVsBhnFqLMgdTrTxGHz0JdGBJX+0+/Ua8pyw0JIe/dp4Bv6Onx8Ep50ycYld/HYkzfGOi1UnWdpE58WPo/EylZo5j3YXZYWV0LAuKljBU8a43Z2Xnf7PdgibGVOlrH7R/eUapKnHHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040034; c=relaxed/simple;
	bh=C83lUvqDMYw721GQwrFIjHYdYzr4B6SXlNfwTeIqDAg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LZDhuzlfRuNY3Fvtk5ttX2ssm5b+J7foWrhKW67hX+otljfKGiYa9ALZD5sZiBMA0wYgDeoXp/r0dbNlrWRS/pB0hBMhAxDmX5FYpsdkMIkVNhYfMyu25lcNgidIXbLOHrfuzfQpF9xtMCW0pjLzdnhsM+NmMFroGXoP/1hd9fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TurlCLo7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B469DC32781;
	Wed,  7 Aug 2024 14:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723040034;
	bh=C83lUvqDMYw721GQwrFIjHYdYzr4B6SXlNfwTeIqDAg=;
	h=Subject:To:Cc:From:Date:From;
	b=TurlCLo76EH01vwjt5uxwMoQ8yumMDImbwdAxwmVw9td9BEkPKm7tMgfIpKR/xL4u
	 Ll8BDmmlQb+OaekwrErSkQiLnxnfI5IN32Ds8VYEn3HnjSDuPVJmvpoGAo22sohFHA
	 oQpG8EimNbNAcM+l5I8YAog/WFuIM9Sp8laGW7Bg=
Subject: FAILED: patch "[PATCH] mptcp: distinguish rcv vs sent backup flag in requests" failed to apply to 5.15-stable tree
To: matttbe@kernel.org,martineau@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 07 Aug 2024 16:13:50 +0200
Message-ID: <2024080750-sesame-overfull-bbb7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x efd340bf3d7779a3a8ec954d8ec0fb8a10f24982
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024080750-sesame-overfull-bbb7@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

efd340bf3d77 ("mptcp: distinguish rcv vs sent backup flag in requests")
967d3c27127e ("mptcp: fix data races on remote_id")
a7cfe7766370 ("mptcp: fix data races on local_id")
84c531f54ad9 ("mptcp: userspace pm send RM_ADDR for ID 0")
f1f26512a9bf ("mptcp: use plain bool instead of custom binary enum")
1e07938e29c5 ("net: mptcp: rename netlink handlers to mptcp_pm_nl_<blah>_{doit,dumpit}")
1d0507f46843 ("net: mptcp: convert netlink from small_ops to ops")
fce68b03086f ("mptcp: add scheduled in mptcp_subflow_context")
1730b2b2c5a5 ("mptcp: add sched in mptcp_sock")
740ebe35bd3f ("mptcp: add struct mptcp_sched_ops")
a7384f391875 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From efd340bf3d7779a3a8ec954d8ec0fb8a10f24982 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Jul 2024 12:01:24 +0200
Subject: [PATCH] mptcp: distinguish rcv vs sent backup flag in requests

When sending an MP_JOIN + SYN + ACK, it is possible to mark the subflow
as 'backup' by setting the flag with the same name. Before this patch,
the backup was set if the other peer set it in its MP_JOIN + SYN
request.

It is not correct: the backup flag should be set in the MPJ+SYN+ACK only
if the host asks for it, and not mirroring what was done by the other
peer. It is then required to have a dedicated bit for each direction,
similar to what is done in the subflow context.

Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8e8dcfbc2993..8a68382a4fe9 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -909,7 +909,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 		return true;
 	} else if (subflow_req->mp_join) {
 		opts->suboptions = OPTION_MPTCP_MPJ_SYNACK;
-		opts->backup = subflow_req->backup;
+		opts->backup = subflow_req->request_bkup;
 		opts->join_id = subflow_req->local_id;
 		opts->thmac = subflow_req->thmac;
 		opts->nonce = subflow_req->local_nonce;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b11a4e50d52b..b8b25124e7de 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -448,6 +448,7 @@ struct mptcp_subflow_request_sock {
 	u16	mp_capable : 1,
 		mp_join : 1,
 		backup : 1,
+		request_bkup : 1,
 		csum_reqd : 1,
 		allow_join_id0 : 1;
 	u8	local_id;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 39e2cbdf3801..a3778aee4e77 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -2005,6 +2005,7 @@ static void subflow_ulp_clone(const struct request_sock *req,
 		new_ctx->fully_established = 1;
 		new_ctx->remote_key_valid = 1;
 		new_ctx->backup = subflow_req->backup;
+		new_ctx->request_bkup = subflow_req->request_bkup;
 		WRITE_ONCE(new_ctx->remote_id, subflow_req->remote_id);
 		new_ctx->token = subflow_req->token;
 		new_ctx->thmac = subflow_req->thmac;


