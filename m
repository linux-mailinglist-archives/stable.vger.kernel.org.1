Return-Path: <stable+bounces-51104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 886EC906E5B
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F501C22C7E
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439DB144D3F;
	Thu, 13 Jun 2024 12:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r2/kNmiM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FD8144D36;
	Thu, 13 Jun 2024 12:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280321; cv=none; b=hnb/yfZGKr9PSbiDhyY2I5aEyZo80iaZ92Lm9RhIH2IIgWhT9vhuWn3O+8b21XJbTEiGX/tdd21Fv6wEiJpIadJOcSsMdEOeEhHEd/bTf30DpBXYKTAjE4ea9SWHZ0+gH5cpeYcN+PtvyP/acMP3OGDylRrGmJ/hyPTHMJ5XvI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280321; c=relaxed/simple;
	bh=wxBraw0qe268jMxfb76bPqvNsYlUFQ1GJRj1nYOx8nI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRVVlUwTBTaKW4SH0z1wB0LsT5IP0aXdMb1HqJuidT0Sferlys7Pnqsh4XU/Y25qTmTEMDP6ZGjsKxkfkfKeHUieBrFpbe3a8DVLXPsbKsYSDmtAQz+96h7ePH4sITN4OIVgZTKfIk+0gjVgu43fYUdbJjQWXTn8Giqmb7l8WoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r2/kNmiM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C31C32786;
	Thu, 13 Jun 2024 12:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718280320;
	bh=wxBraw0qe268jMxfb76bPqvNsYlUFQ1GJRj1nYOx8nI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r2/kNmiM2Sz2a1zZVUDW6G0kTSagesZQbUKn0Io4eG/+PqoQBJmOLFCsguiCfOeeg
	 E9AK4HguAXjlbfsRtQNNDaNMgMXQ6dphIldbex8wIT3c4zxfLqyKZIci6V5vr/GmBk
	 YU9C3sivmZjJqoxe8nGicvXQa+RNW05IQX/q3Gfc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.6 006/137] mptcp: avoid some duplicate code in socket option handling
Date: Thu, 13 Jun 2024 13:33:06 +0200
Message-ID: <20240613113223.530809723@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113223.281378087@linuxfoundation.org>
References: <20240613113223.281378087@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

commit a74762675f700a5473ebe54a671a0788a5b23cc9 upstream.

The mptcp_get_int_option() helper is needless open-coded in a
couple of places, replace the duplicate code with the helper
call.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: bd11dc4fb969 ("mptcp: fix full TCP keep-alive support")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/sockopt.c |   20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -626,13 +626,11 @@ static int mptcp_setsockopt_sol_tcp_cork
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	int val;
+	int val, ret;
 
-	if (optlen < sizeof(int))
-		return -EINVAL;
-
-	if (copy_from_sockptr(&val, optval, sizeof(val)))
-		return -EFAULT;
+	ret = mptcp_get_int_option(msk, optval, optlen, &val);
+	if (ret)
+		return ret;
 
 	lock_sock(sk);
 	sockopt_seq_inc(msk);
@@ -656,13 +654,11 @@ static int mptcp_setsockopt_sol_tcp_node
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	int val;
-
-	if (optlen < sizeof(int))
-		return -EINVAL;
+	int val, ret;
 
-	if (copy_from_sockptr(&val, optval, sizeof(val)))
-		return -EFAULT;
+	ret = mptcp_get_int_option(msk, optval, optlen, &val);
+	if (ret)
+		return ret;
 
 	lock_sock(sk);
 	sockopt_seq_inc(msk);



