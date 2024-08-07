Return-Path: <stable+bounces-65559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 852E794A9A3
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 16:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C558288174
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 14:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDB36BB4B;
	Wed,  7 Aug 2024 14:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KqVPPWYK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CDF4A9B0
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 14:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040043; cv=none; b=jQ+5G4UYDzsedRsqn3eOhAfynRUB68cWGnIwLvJU2C04m0aygEbaT4C4qCiyYGzcZpvswAVQ+JnzSnVemn5FTqIFlCF62U8QjBS/RgbhVZgSLHHeFNkVGmn4sgIibIok/hafsHkgHL6vFlPZU3U1Fh0CbYnPk+XjU9s20higQQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040043; c=relaxed/simple;
	bh=iexWVHVT6B+xsE1rxYarfXhxlevpNTfFvO0Yyf5u0cQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=g08Nb66+AlS4pRKs6f66sM8GtjF+3lAJ9y4Q1w2w2SI4+EyP3YqlzvbJKdT7meb24shORmd0EcKzq9UkpV4z7tF5AZ+LnrK/cWifuBmhi/loqDXZ0dAzH49ZiE9TYJtPfBc8oIcduWP6GR3QqcczK7xw4Fcw5eMNrfEifXany30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KqVPPWYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5BCC32781;
	Wed,  7 Aug 2024 14:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723040042;
	bh=iexWVHVT6B+xsE1rxYarfXhxlevpNTfFvO0Yyf5u0cQ=;
	h=Subject:To:Cc:From:Date:From;
	b=KqVPPWYKhbEWw9G7COlN6XA77LwIYdE+XhX8UPwjvqtIZb3yccof2ybhDrkUmcmtU
	 ooeSru9COSwXMz8i+ZpRtBQeahScBbhSjdOL98WPoK2ek+q88Yy8P7PMF/5x55jUaY
	 eNwMMHaMEWhVCftcdOdioglTPsgjz7YqXL/8y8LE=
Subject: FAILED: patch "[PATCH] mptcp: distinguish rcv vs sent backup flag in requests" failed to apply to 5.10-stable tree
To: matttbe@kernel.org,martineau@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 07 Aug 2024 16:13:51 +0200
Message-ID: <2024080751-skinhead-underfoot-5a1f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x efd340bf3d7779a3a8ec954d8ec0fb8a10f24982
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024080751-skinhead-underfoot-5a1f@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


