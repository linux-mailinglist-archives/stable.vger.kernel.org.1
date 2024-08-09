Return-Path: <stable+bounces-66249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BD194CEFB
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2F41C2161A
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 10:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2E21922EB;
	Fri,  9 Aug 2024 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tqb4KuGi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0AA17993;
	Fri,  9 Aug 2024 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723200882; cv=none; b=Dk/HZfgHytqCUC3UgrNzfPFCRMouBmt2JiiwCd85krLQVEf3iAA0r1zxWA8ogJVKg7LBkLL1z4G+QZAT5HKlxGGW8Nv/YA8E60hgBp97cje+AHYOqe2RqPRGvRPipbCrHim+gwt6SALpalQZzrWgYypgp2lQDf7KnvRcWbKX/vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723200882; c=relaxed/simple;
	bh=osytQjcYk5IWZmEs8ylqUYJHytu3LPRvWbgz1hXcydk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8szsRGwWAUx4c4ApcWjFV93zYA7IUTayRGoH6AtL1uw9wzJq9dk80BV+GIACxjI+KR7UiH4KoZTaZggQsOvDwNaqdGRUeZeUWBhMSR+ePjMwckGnAnqacqnLXxGQcanmtJakSRaxECRLre9K+GT+/KMg/An3teuIlkE3DvYnJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tqb4KuGi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E1BC32782;
	Fri,  9 Aug 2024 10:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723200882;
	bh=osytQjcYk5IWZmEs8ylqUYJHytu3LPRvWbgz1hXcydk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tqb4KuGi3YqEftz1UMu06a2KMnc7Bpu/Bs6E8AY2bMpDwkbdy/6BckEXWCYdeSHRh
	 hm60Uh8ZDDEaCa0XSMR2C7FOBEAe+3+k/pj32fLJl5TNEXI74YFl0UldvoytpxUtxg
	 V5hzq49vTCEywDTvHa4wuYIloA0QA8bjHkQsVs+GGCnUFM3e5GEB5jMtCY90SpjYYw
	 nhtCkU/Oq8CKUyIHN09Fs9rY3jZqbUJTjy5FidXBDwciez5dQVgESxUmeqJ/F9QOiX
	 P7wtx55Bmlh1fEPiRY8V1fRPx6xymdSRF09hWDOixiZ26RHMEAs/YQHTS3+xI/eeWe
	 DMavjosXqDL4Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.10.y] mptcp: distinguish rcv vs sent backup flag in requests
Date: Fri,  9 Aug 2024 12:54:31 +0200
Message-ID: <20240809105430.2901613-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024080751-skinhead-underfoot-5a1f@gregkh>
References: <2024080751-skinhead-underfoot-5a1f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2911; i=matttbe@kernel.org; h=from:subject; bh=osytQjcYk5IWZmEs8ylqUYJHytu3LPRvWbgz1hXcydk=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtfVmExfsr7LO9m6c2n1Mlt9ya0lOUaaUgdQef dr9/8J7hRGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrX1ZgAKCRD2t4JPQmmg czh+EACwKKxtJzjhgB/K8u1gjM77RdrOgfDNT1adoJH4JQZrXaAE3bCa07hSloPfhdaTa38b3+i U9O8l/JwpXSEebRNx49NToWL1H/Hv6iqb/uYne8CPBNuhdZtajyhj8jDSop+ll18nwuYgGjPdQ8 kBtYlEaEOpUGWm2/MQbX//a8Fe7iuofWYnidZi/25X2tg3opwizin68hIIrp96s5eLS9VKJXb2n 9YMhz9U9PXJMxGrT2hOBK9qzMRxfRovTS3BEri+5atuGRu7luP9wgybGVrZKP36hr+3G+e8C4VC kRVHHleCkiWV7i0sIMNsvrJ+iLBZt8pvhMVS7ykcWDQFH1LGATlbndlVSqYgG6fcga9uvt0Z8mw AC7GNmn/gmGQi2O0lIJuwKGowupxb8VEfm4y3af218qPPANm2qcQ2TLYdkxNSN8TcZXQ2msRIhJ A4cVSSO+oE8p7xCfmGpGCUHSB+IHd29WXR3qIzWWlEY132/SZRywMczwo8jdGRI3GKFtwtxj2Tf nbVgt9/IzL2hDv2YO35Ew2bji6fRr5atv0BCQZ5TTuBShOK+1Dy02WZENbx03rIIqoLaApaDYxj Tq5wLN0bvrkRY0TWG/AhZnA8Maz3yXovUmJRyRB4DTkPWJq4MSNO7Nz/TZg3cxOwyLfuQMTwS+Z pWQcmz6f+vgg2OA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit efd340bf3d7779a3a8ec954d8ec0fb8a10f24982 upstream.

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
[ Conflicts in subflow.c, because the context has changed in commit
  4cf86ae84c71 ("mptcp: strict local address ID selection"), and in
  commit 967d3c27127e ("mptcp: fix data races on remote_id"), which are
  not in this version. These commits are unrelated to this
  modification.
  Same in protocol.h, with commit bab6b88e0560 ("mptcp: add
  allow_join_id0 in mptcp_out_options"). ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  | 2 +-
 net/mptcp/protocol.h | 3 ++-
 net/mptcp/subflow.c  | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c389d7e47135..f7a91266d5a9 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -708,7 +708,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 		return true;
 	} else if (subflow_req->mp_join) {
 		opts->suboptions = OPTION_MPTCP_MPJ_SYNACK;
-		opts->backup = subflow_req->backup;
+		opts->backup = subflow_req->request_bkup;
 		opts->join_id = subflow_req->local_id;
 		opts->thmac = subflow_req->thmac;
 		opts->nonce = subflow_req->local_nonce;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3e5af8397434..b5978bb4022f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -261,7 +261,8 @@ struct mptcp_subflow_request_sock {
 	struct	tcp_request_sock sk;
 	u16	mp_capable : 1,
 		mp_join : 1,
-		backup : 1;
+		backup : 1,
+		request_bkup : 1;
 	u8	local_id;
 	u8	remote_id;
 	u64	local_key;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 823a92b21c6c..a59c731d7fed 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1395,6 +1395,7 @@ static void subflow_ulp_clone(const struct request_sock *req,
 		new_ctx->mp_join = 1;
 		new_ctx->fully_established = 1;
 		new_ctx->backup = subflow_req->backup;
+		new_ctx->request_bkup = subflow_req->request_bkup;
 		new_ctx->local_id = subflow_req->local_id;
 		new_ctx->remote_id = subflow_req->remote_id;
 		new_ctx->token = subflow_req->token;
-- 
2.45.2


