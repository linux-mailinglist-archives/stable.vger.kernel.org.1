Return-Path: <stable+bounces-67463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 451669502CE
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 12:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06CC42874EA
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 10:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B66C19A294;
	Tue, 13 Aug 2024 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="malrt9dF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CB916B39A;
	Tue, 13 Aug 2024 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546026; cv=none; b=amrVBF94akbwYIMJkBrcShYKt4pKSQp0zPOsmYHOxBT4o7xh0OjZj8+J55ckcgUlaT1XrV5IO4hLJyrB8vM0130QoivM8K9zZNXSEJSCwdDOBU5KRtiCvScCFpgJZjNCSYRiGAKi5aLFHZQBbtJS2dnsXteC+XediclisIvyPg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546026; c=relaxed/simple;
	bh=SKo2EFi3xw7z1orJP6SgqeY5RDaW4/nvQmKXEmVL6K8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6sPuWqoKShWA185YC1P8KcyEo9pmQRjgpuq4e/kdhTzzJjNkP9omn9pHWt0g3Xnki3DOAU0zbw6zzf+AevQeBuY+UaUGi7CBLpOe2vfq9N+tv2wbDa8Yk1gkh8Z++LG7tZHcNPDtY2m4g2s9OXfHKEpUKqlrkeCKjx2QVLkAj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=malrt9dF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920EAC4AF0B;
	Tue, 13 Aug 2024 10:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723546026;
	bh=SKo2EFi3xw7z1orJP6SgqeY5RDaW4/nvQmKXEmVL6K8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=malrt9dFXrfIV8I/14J0VOgaQtgDdVVMC/Ge2zz9cAYdS7l2/rhI5vI8gXB0mBAFZ
	 y6DW8rVSm9MPszb42OIiRWs9SImUHiwNotEvxSGeQr8ZPa/oYeCmH5JXZRHMElG9Vf
	 gfCVzukKvdXLzU65JxjrnYe9o7F/jKm49/QPGLrtenID/qeYaUe7UwQShC0eG4cVrX
	 QJUoVbSz5oh82TE49AInx217APC8ZcAvkLQSFUhcmYfmzjdAjUd5p174Qq/fMK9gxx
	 ssDi1xQ2D6OPDOwBAAKXkEbOptyOawqR2o/jbG3IQQCHHjgFygT2m6Mdx/kcx84PTc
	 Aot/T5lXonMJA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] mptcp: fully established after ADD_ADDR echo on MPJ
Date: Tue, 13 Aug 2024 12:46:43 +0200
Message-ID: <20240813104642.1210553-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024081209-wrongly-zen-35f3@gregkh>
References: <2024081209-wrongly-zen-35f3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2204; i=matttbe@kernel.org; h=from:subject; bh=SKo2EFi3xw7z1orJP6SgqeY5RDaW4/nvQmKXEmVL6K8=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmuzmSrDf0oTNOi26YRU37kagCIP+S78sdiETk7 iqXbkrGmwWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrs5kgAKCRD2t4JPQmmg cyIpD/0ftD4EGWylXbHgTAU1PPUqBJMQ75kiJokemJSg2f0MeCL/7quJM9OucjmrkO0198dEygU qYTkAT6+8E8WI0T4iVkpzqcgBlQW3VXnpowD7Aae4EDkQucF+89GgGuII2BOgN90qbobO3CeuvK IcC+W+aP8v4rSUtVNmF+ZRbyrlyByZFdXwK8ASfQTH4Jsf9Czq/RDs0zFT3TZtxTP/QQEJMgyoy pN7uYREyhXJ73vwZmIQHimwbS1vkD6tHSIuFY4uKVWNIia3XuZOEQQZBBReEUH2yYCaCnGowGfQ Fb5Y8TINtVa0vlDMTx81zZ9QkqT0G1aHGvrIGBVFVd6nsEcRlP+Ryy/RZQwwjfQrZ01aiyhrOjc OWpWU5LNzBqk5v1Lnr9c02tdJPYihk2ZjTVLoh75T+JEo8fzRWdtneaYBvrcy4XLM9234xPACDW 5D/3WAuQ67eoEbxsP9fw1CQRdOJX5XHOKP1qYhHZN0q3Jmv6dK1A8Rpsw5w377rFOLAEPKZhcFU +M/OMHCgyo7DZt7LOzdGguI++DBwsOw+HBeUCaciUqdP0cdNqWrkgLiXJE1xS4W/mzdZrBtAuk+ 6KmFml1eToK6YE9bJRWa0gzJvrTcvORblhTWKPUDq/TolTh125LiS0pwl8EsiUYZDjTeeU5Pg+k qIEJUUQg+sy4uxQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit d67c5649c1541dc93f202eeffc6f49220a4ed71d upstream.

Before this patch, receiving an ADD_ADDR echo on the just connected
MP_JOIN subflow -- initiator side, after the MP_JOIN 3WHS -- was
resulting in an MP_RESET. That's because only ACKs with a DSS or
ADD_ADDRs without the echo bit were allowed.

Not allowing the ADD_ADDR echo after an MP_CAPABLE 3WHS makes sense, as
we are not supposed to send an ADD_ADDR before because it requires to be
in full established mode first. For the MP_JOIN 3WHS, that's different:
the ADD_ADDR can be sent on a previous subflow, and the ADD_ADDR echo
can be received on the recently created one. The other peer will already
be in fully established, so it is allowed to send that.

We can then relax the conditions here to accept the ADD_ADDR echo for
MPJ subflows.

Fixes: 67b12f792d5e ("mptcp: full fully established support after ADD_ADDR")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-1-c8a9b036493b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in options.c, because the context has changed in commit
  b3ea6b272d79 ("mptcp: consolidate initial ack seq generation"), which
  is not in this version. This commit is unrelated to this
  modification. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4d8f2f6a8f73..2baed0c01922 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -923,7 +923,8 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 	}
 
 	if (((mp_opt->suboptions & OPTION_MPTCP_DSS) && mp_opt->use_ack) ||
-	    ((mp_opt->suboptions & OPTION_MPTCP_ADD_ADDR) && !mp_opt->echo)) {
+	    ((mp_opt->suboptions & OPTION_MPTCP_ADD_ADDR) &&
+	     (!mp_opt->echo || subflow->mp_join))) {
 		/* subflows are fully established as soon as we get any
 		 * additional ack, including ADD_ADDR.
 		 */
-- 
2.45.2


