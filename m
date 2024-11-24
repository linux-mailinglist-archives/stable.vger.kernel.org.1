Return-Path: <stable+bounces-95108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 026079D7355
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1887F2825C9
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5641B4129;
	Sun, 24 Nov 2024 13:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQwDNUyL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041F23DAC1B;
	Sun, 24 Nov 2024 13:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456047; cv=none; b=Dl5MBVZ1calfyPZk5U9et3ywbFQRScfz9WG3blEw2aBdB+J9/zCkn3kM9xoUNcbwe/3hY1f+qeKiFdb1OIRP/OZz9o0TXqV51LfbaBnRR04Ata0vzYlRYpVoOAqm5u0h2QFMw6ci1b/K+DfDp5L0jOX9C+24yWTaU+4HBkLZ7C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456047; c=relaxed/simple;
	bh=xLQJuJ/yr6V2XKTAWinTxANEoAHH4gcGZY7nKHGY9XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDNBAKmLNPL4iFbatjnBqRaeoLTgkl3GMvh7rdU8MiHIGT5hWUMJgD4WQVD3Dzp1ymfKe8/KUkcH8tm6tQJwVnT3K9+35TCNAX2rUyhlku2ZZvwWXCoAwQoEeSzyC3RQqSFcqKGqJ/8fjQ/eWluKI1Rbo8o6ryFnF/6ZabOht8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQwDNUyL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81608C4CECC;
	Sun, 24 Nov 2024 13:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456046;
	bh=xLQJuJ/yr6V2XKTAWinTxANEoAHH4gcGZY7nKHGY9XY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tQwDNUyLWtTrOyrJ3lV9zCIPxkgvx/t7KS18HTL06crvqETF/wM9vDLqvtQ5WOTuG
	 j7Z0x0WW+Y6ge6ZvhGrUxaWmi0RPkeSrDxHDYK52YAE3ZzoODPLZlOQlEUG9ay1CMR
	 Jahw5EF+oDxz/RrnSQQAdgkDShgqexoCIgr9xLadu4PBBsu1fdGhGz5xxr7xalVU6/
	 +WwsiHWNglOwtag+tm/r1NFhxvwdaKCpR6tb0uRknwdV28/yaDhSYlmn/fjx5yS0cL
	 dRbLx8GpJ3z4/ZMeo16G+rkDfdUC/ilss4cUzlJlVRu/c+/yb6nFY/wIUds1ZLfjLS
	 JkDCPQ6URu60g==
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
Subject: [PATCH AUTOSEL 6.6 18/61] net/sched: cbs: Fix integer overflow in cbs_set_port_rate()
Date: Sun, 24 Nov 2024 08:44:53 -0500
Message-ID: <20241124134637.3346391-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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
index cac870eb78973..0567a15d0f850 100644
--- a/net/sched/sch_cbs.c
+++ b/net/sched/sch_cbs.c
@@ -310,7 +310,7 @@ static void cbs_set_port_rate(struct net_device *dev, struct cbs_sched_data *q)
 {
 	struct ethtool_link_ksettings ecmd;
 	int speed = SPEED_10;
-	int port_rate;
+	s64 port_rate;
 	int err;
 
 	err = __ethtool_get_link_ksettings(dev, &ecmd);
-- 
2.43.0


