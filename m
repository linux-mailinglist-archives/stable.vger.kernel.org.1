Return-Path: <stable+bounces-95165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF629D73D4
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CEB3166D6E
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D65232D73;
	Sun, 24 Nov 2024 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLbrA46l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BDF232D68;
	Sun, 24 Nov 2024 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456219; cv=none; b=Jo376xw52vLgQ3+q+VslFi0AUDy8hFD4vRz16/WHbFAasYD865R/StOS4XpsLUK1sC8ZOz3KjR0IGZGtirhhTdq12CguqTFV3LmXCuDKsR87yV6AZ/0o0p6eaz1z5KJW8ZyBNeW3PrGujcoNbohk3Or29WJqApUNZ6pqoMffbHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456219; c=relaxed/simple;
	bh=xLQJuJ/yr6V2XKTAWinTxANEoAHH4gcGZY7nKHGY9XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/WT1oT4mJFKUD4WH/wWwa2fcH4Gn3WsFdxllQiHRtTdAnlakdPg97x/4ITut+TbMfqFXrSO8slidfrWrE0GWQfHQGr3oWGCxD8imT3iJ/eofHC2+7XLF5kndlMMuwdlGYfliWk2nzQCX+fobFa+DaVVom6YYZQ2k1ccqUILe08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLbrA46l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D760C4CECC;
	Sun, 24 Nov 2024 13:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456219;
	bh=xLQJuJ/yr6V2XKTAWinTxANEoAHH4gcGZY7nKHGY9XY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BLbrA46lx3zlKyl0vPFnIAmbqGjcqI2yfyG0IJ6+c5cAykSXD222L8DPcrQk3YDg5
	 f/r2pey4Y8zVj7CdJH31VcagoFzAJqOgqPMmE1aP+LC+tRt3ygyH1aQ27FbqPe2xhY
	 KEBm28HAEjHZgNqau4OPxQMM2GX43YdSf1UVvkbGr968kzflVtj7FZGIXrfOymXCy8
	 IaMcwH2E2CP73rXaPnPe3/KAeU+lOA8MDqfMad9yThbX5Hj/8vrFrvPxpuN0RuyzSF
	 BjQ2YBwPuEmxcT+05PmRScwZmTFDIfyGTwYO2pgHGFZPx2jOi/RloZM4nv0uNgjQGJ
	 bE0BHpO/OWKZw==
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
Subject: [PATCH AUTOSEL 6.1 14/48] net/sched: cbs: Fix integer overflow in cbs_set_port_rate()
Date: Sun, 24 Nov 2024 08:48:37 -0500
Message-ID: <20241124134950.3348099-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134950.3348099-1-sashal@kernel.org>
References: <20241124134950.3348099-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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


