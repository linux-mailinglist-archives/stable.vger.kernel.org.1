Return-Path: <stable+bounces-67432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C67AD9500DA
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 11:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056001C20BD9
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 09:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E029F184521;
	Tue, 13 Aug 2024 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGmrRpZ6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECD414A086;
	Tue, 13 Aug 2024 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540002; cv=none; b=lZDKEES2anTe+6Mp6wcJ3qyx261ZJnS6Ouy49nourT303vx2WHjYg93VwVpahvu59zaNG/A/NATQF+NbJ1ImUfyxXJfdj6H37/IvcFEhmBS3Mi6O4LdkX4ar5E4JKgs8bT2LyCmXypyeju6WUhawVNoE4gmDppj/pswxq2C1XtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540002; c=relaxed/simple;
	bh=agCpECq5YzgFtdAMGpR6+nUKg01bKiIGqRPywYNprCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ca8a8IXaVFadQg8iMU+bU/dcNN4Ni+r8eKheA/Im+OQo8TNGw20/0k2Rq9jHEu+p0KQgH6igAKeclKJvasseksUFlUtC4z009YPJzuohFqm2dldKYdN/0SZ6k9126viIXZkowALxxBdtzt3HdMJ5OUI1hmKiHGVSJkLpwGiSuTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGmrRpZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB554C4AF10;
	Tue, 13 Aug 2024 09:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723540002;
	bh=agCpECq5YzgFtdAMGpR6+nUKg01bKiIGqRPywYNprCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aGmrRpZ6lxf5AJ99ckattmBp5U43F7oy9n/LNoeyrUNO5cwZzkvmDRKgD1+QbrqLV
	 6TfyIVHLGhLlS5Xw8VUWPOfOKy28RAUocEHTup3V0YxGRrpn2dCLKjo8nnu95A3/gw
	 NUvcOQbSccLWBNG4STzKW3bI0unPsDF7MGuw5EPHD0OEQAUOa8wJLdHIIbXn0r8vPp
	 3F9PQg1JCLKcEPlCR/nhDywi/Tv+c02inODhP9jCo8FI42N8Idb8ChQ21hRDQPwhC1
	 601LLAM9Lv3VOF0cqNJ2XytPi3ASHUE0ilPoeQRWUeJkJjgTrQ9LH9cnSsDv56/8Vz
	 J5heDXxtBRSpw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y] mptcp: fully established after ADD_ADDR echo on MPJ
Date: Tue, 13 Aug 2024 11:06:07 +0200
Message-ID: <20240813090606.939542-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024081208-motion-jubilant-6af5@gregkh>
References: <2024081208-motion-jubilant-6af5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2204; i=matttbe@kernel.org; h=from:subject; bh=agCpECq5YzgFtdAMGpR6+nUKg01bKiIGqRPywYNprCw=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmuyH+KSxMlX+ANMr+8YC7WI8MoBpK0kSEay7Qn EV7XGTy9OeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrsh/gAKCRD2t4JPQmmg c0ZYD/9ISCh8PpAZG1zfbZWwrUVwBhlnf+wz53HnB9/e73NKC/oAQS1Cn0ad7VsjeQBCac+k8Vz pbHffxtQW2xTAXFFlmhwR7GHp9Sj1EzJR41lw/LQrpAagV9yug2wVkChU2JO3k8pUlaN8cjWw1I HsngiUezcvc/tMvJquxd4Twp3MTSs5XFn1I7wB48kRZtjsh2qhYCyiPFHv8rU/+kz5UAWU7eVNm +c0xgg1veSdN6dhMsvOuiw+IYdt5N4IeyirWrJa6P9+Q6nlYecdnWJ35+rrdl1ppAaT8uf8rXNw pdOeSgR3XrKCnhM8KxD+U52raAQIcEnVdvf1MmwOJc72Y1LKLzxa/gSoolGXYWnCVHNzBDN33ax YrRzroBVLwyVgl/c1fv5kyDSYy1St9PHwIiny4brjSY0gz/2LdNFGoNQ0BkrAz3D2YIgTEpDl/T baXj642Dj287Q/GDo9xMoTj2BR7RCvZ3s2U40uI5TJv9Mcs6DFHOdcnibVabKtpZlyPAn2/KrGO YFqCFv03T27j0mHiNVpYOme7PUfZixX8yV00qMsTao2XVynui+TTALgcmQMyf/69cHEovfYv/5H MPa9CF1DZw7xDU5SRyBxPgnMCODERiBWBW1xHI65HrzZE23+A/VHntlOpV6yoo7vlOblIpf/LNf Nema8nPHauNeyAQ==
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
index daf53d685b5f..d469ad6c6a0b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -950,7 +950,8 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
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


