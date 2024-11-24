Return-Path: <stable+bounces-95034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 465F59D7271
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D39528B6EE
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF341F9EBE;
	Sun, 24 Nov 2024 13:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ws2h4c9I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A1B1F9EDF;
	Sun, 24 Nov 2024 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455778; cv=none; b=mbakY/CU5jIWm+n50Vt7SBwNKK7DIy7VhKbngtrOWWlMbKwtBsBB4PLrQonLqslYrNxU4ATrmf4RoWCU3ou+JHYfQSsPY8ip4QXixJx3KYkLS1DSKXqyDQuGViaBqaYVHAJ+8B1a7EtjAQ+UntAQZSBSNTCiJJSva7dMzCPODCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455778; c=relaxed/simple;
	bh=1LymdqpIRSVEy2c1NjgPG0NZM4d0W1v9adkK9z7UpEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V53rVBDeeF3Pe+MYg5rIqt083sOrhsAc2RpbkrWqJki+La7AnCnW9PK8V+7B73IQvYAuGXB+9NgMHnyd9LdGz8SpfUmj4ZNGN6JOea4TfEom71NZQgYWUMfh3fhVcAMR5irHNi5IO+0cRQLhHrq7WK7TE42uMP3h8iERtyLqJ2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ws2h4c9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE23C4CED3;
	Sun, 24 Nov 2024 13:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455777;
	bh=1LymdqpIRSVEy2c1NjgPG0NZM4d0W1v9adkK9z7UpEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ws2h4c9I0g5POFDIWQCKd1Igu/qSGIlXnZIZTX5fyB35SuDrsMA8DCZM/KHdWTjb9
	 0/yFNegUt7+S/pm13J3S4r78fDHNLllzA8vwDo74MmjqP5QmVF13+sDvsBcFdBt8wA
	 L/G4MKEzrcm8oDAAevK3QGfEoqLkdvA5s/5Vjv6gew9uFJM5VDLLzTFWgi6LbNP8CC
	 sa06qZd967Vr/sou41f1ycttqrlDJmu3c7mZUqcQD+FZ7ZZqpuFdvKwGAoxjlPOipV
	 zhf85f4c/BzKafUSm5Y3SoG1Ry+Bz3a8fTmpE8M05U15isG6aVG1RMzsQ/k/VgBSG/
	 6xfMu1fELzSRg==
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
Subject: [PATCH AUTOSEL 6.11 31/87] net/sched: cbs: Fix integer overflow in cbs_set_port_rate()
Date: Sun, 24 Nov 2024 08:38:09 -0500
Message-ID: <20241124134102.3344326-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index 939425da18955..8c9a0400c8622 100644
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


