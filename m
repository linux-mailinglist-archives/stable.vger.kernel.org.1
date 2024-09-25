Return-Path: <stable+bounces-77601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D53985F03
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC691C24CF9
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F27D1B07B0;
	Wed, 25 Sep 2024 12:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dl1ytu/i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EDA1B07A7;
	Wed, 25 Sep 2024 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266427; cv=none; b=RnzbpEen4o+zMr2YW9DFiwplcJuDPZNQ3QWSwT4Bn04VNZCQODYjIpamDz/CflLiDnO54IAYpx/BVy2ttk/drsJq7E9Ad+K36wRoA0LAshefRPfgIN/ZqnpcD3/4iHH3ZmuaDFTZpS/CSw371VBVoeVQgDMjpjYaEIXqmvhCvRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266427; c=relaxed/simple;
	bh=bWnVQq/FSskDyqp8JhBvKiekpyhQd+d4A7dAmfZL4I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUe9i4d/Z1B2YcobMKkCHSARfb/mCtsfZaKyInUoC0Ai5ug8ek+MXVKc9ICi8efh663l8X2AToO9A4+luFi5yiPbSkoScYgzScETLsm2VMvp/6aWcOSnxRjZHCVMzFISYphYYa8PDXmdlRiqDIAnEyioaEpxJbhYztQS9tVXwpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dl1ytu/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82918C4CEC3;
	Wed, 25 Sep 2024 12:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266425;
	bh=bWnVQq/FSskDyqp8JhBvKiekpyhQd+d4A7dAmfZL4I0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dl1ytu/i4gSSnpYLZFyHZPLoBnLsxtq4MqTdTmxdDHjgW4i6mN8giZCrNEy4Csi3/
	 dtjsl0QW/zV0RL5ovJD0213qIaEG+mZOMLwGTWmzJMN9IXUxbZ1ukMyt+cHCDXsIt3
	 TZpo9DS9gQlF7Ryi1cUhnuvwXrDFACRK6ZJg/au3LKTnVmgke/lQTzu8Y3L9x7ZyRe
	 FoPERBDpp/+uzLXtqgXONjJcjrNAXtKTHYzOgjmvq03xeFuK+dmayS/URTjK3Cbll9
	 DelhfoDcaNJId12xZ0f1Jw/qmWWw2CLMcosKEUzYqQjWdjgoYtJt7Hz4dTnyjOZdbC
	 5b00i/DPYz/Lw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 054/139] net: tls: wait for async completion on last message
Date: Wed, 25 Sep 2024 08:07:54 -0400
Message-ID: <20240925121137.1307574-54-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Sascha Hauer <s.hauer@pengutronix.de>

[ Upstream commit 54001d0f2fdbc7852136a00f3e6fc395a9547ae5 ]

When asynchronous encryption is used KTLS sends out the final data at
proto->close time. This becomes problematic when the task calling
close() receives a signal. In this case it can happen that
tcp_sendmsg_locked() called at close time returns -ERESTARTSYS and the
final data is not sent.

The described situation happens when KTLS is used in conjunction with
io_uring, as io_uring uses task_work_add() to add work to the current
userspace task. A discussion of the problem along with a reproducer can
be found in [1] and [2]

Fix this by waiting for the asynchronous encryption to be completed on
the final message. With this there is no data left to be sent at close
time.

[1] https://lore.kernel.org/all/20231010141932.GD3114228@pengutronix.de/
[2] https://lore.kernel.org/all/20240315100159.3898944-1-s.hauer@pengutronix.de/

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Link: https://patch.msgid.link/20240904-ktls-wait-async-v1-1-a62892833110@pengutronix.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tls/tls_sw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index df166f6afad82..904dae0df7a47 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1201,7 +1201,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 
 	if (!num_async) {
 		goto send_end;
-	} else if (num_zc) {
+	} else if (num_zc || eor) {
 		int err;
 
 		/* Wait for pending encryptions to get completed */
-- 
2.43.0


