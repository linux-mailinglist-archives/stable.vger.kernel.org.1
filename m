Return-Path: <stable+bounces-95275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3B49D7738
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 19:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA6D8B84D63
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9B724777A;
	Sun, 24 Nov 2024 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ar/8fe7J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C6D247770;
	Sun, 24 Nov 2024 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456564; cv=none; b=Ni8UfZEVJyflkEpvL9qan6JXUiFePez1xpKOQJMjjOqQeIVLXusWG8WXHo3weGpMugIZzdtd48EDFJMwhRy8vqntjgGxHFPbfGz4KVR8xPuZGevvUctYXF/PcW/mUkgfvWf5rjRPE8AKLh58RzdzjJ7WEyMpqNf1eF/nAOJT71U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456564; c=relaxed/simple;
	bh=n55YT7Wi8CHxVO7jPVw9PQUWQPpm+0t64NX0EBIj1zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXNyc6Xbl5l8B0K5pZl4p9uVKSpDMD5AZXzCT7Q3p+KaRESSPQeH8wKPSYxVAz3JnCjJt+RHFrACQffQsajRZns1gGax4nNHqikHIClHUQl+JE9QQ/2TdkuhrybN+fCTr8Qrcbn0lM1g45H7DnysmxvRTtMXBTiAXhq58KLCWys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ar/8fe7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F992C4CED3;
	Sun, 24 Nov 2024 13:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456564;
	bh=n55YT7Wi8CHxVO7jPVw9PQUWQPpm+0t64NX0EBIj1zM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ar/8fe7J3VMzcncHRWlDur9R3rqiRWYwMGhY6ufNaBW8NPKl8CJk6sHUQILuEWy2n
	 pUxcSWONd+KFR2sN1YVF/sZl3SJCgsUhq4FKLUTmlOAGWBVggl/YIadoJlDc6vyfN6
	 2WbKiJZxKYcBt2uXf22/QNadXG3uko/8xZXj9c1841zqQKZdyEnik2hKxc91pK39MI
	 Z7rpDLDifXu2a6IEvhFtXIz6av6+UrNkpxW0IkvF7v32tQSRhza7r/jYMB5JE0hvkY
	 n7XvkgPIy+z8QbQJnVvtVGzusiTzdMiVwbrU+pB0pl6ef7/GG8qFGd9+nNEOjcjB3G
	 eu0Pji2Bq4O2A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Elena Salomatkina <esalomatkina@ispras.ru>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	vinicius.gomes@intel.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 07/28] net/sched: cbs: Fix integer overflow in cbs_set_port_rate()
Date: Sun, 24 Nov 2024 08:55:07 -0500
Message-ID: <20241124135549.3350700-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135549.3350700-1-sashal@kernel.org>
References: <20241124135549.3350700-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
Content-Transfer-Encoding: 8bit

From: Elena Salomatkina <esalomatkina@ispras.ru>

[ Upstream commit 397006ba5d918f9b74e734867e8fddbc36dc2282 ]

The subsequent calculation of port_rate = speed * 1000 * BYTES_PER_KBIT,
where the BYTES_PER_KBIT is of type LL, may cause an overflow.
At least when speed = SPEED_20000, the expression to the left of port_rate
will be greater than INT_MAX.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Elena Salomatkina <esalomatkina@ispras.ru>
Link: https://patch.msgid.link/20241013124529.1043-1-esalomatkina@ispras.ru
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_cbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
index 2eaac2ff380fa..db92ae819fd28 100644
--- a/net/sched/sch_cbs.c
+++ b/net/sched/sch_cbs.c
@@ -309,7 +309,7 @@ static void cbs_set_port_rate(struct net_device *dev, struct cbs_sched_data *q)
 {
 	struct ethtool_link_ksettings ecmd;
 	int speed = SPEED_10;
-	int port_rate;
+	s64 port_rate;
 	int err;
 
 	err = __ethtool_get_link_ksettings(dev, &ecmd);
-- 
2.43.0


