Return-Path: <stable+bounces-94933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480A59D7524
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CFE5B41CAB
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7391D356C;
	Sun, 24 Nov 2024 13:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5tbZeov"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFF41D2F54;
	Sun, 24 Nov 2024 13:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455314; cv=none; b=Hn4AIpATp6gsSuD+zHRclW8WRVRAKbbFAofWVnlI2GnVcbwwq6285O9XBhGSAFe0OUjgTJEmNDyclys0tKLF75fCflfdBcWybYanHrtCAF0rn10qvZc1QFRLJSKsz8G3ln/VMYcztwA82GUbUwLq1WsyQBst9UeLQttlbLbuLEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455314; c=relaxed/simple;
	bh=1LymdqpIRSVEy2c1NjgPG0NZM4d0W1v9adkK9z7UpEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=luY66DyMEfFRW7QKwy8/GFNbVypt/PPtVMNYEM9zm+HPdw7GJvpr/G5RYOI+nWgTErzlJhM+Es/5aUiFip8VfYuyhWSsihhE2S5lsNdEdDBwk90GdjaJmdAooQH/WY2/Bt5pF8gvukwuvYX5F43cbiwjvwlNT7yA5Js4tQidw6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5tbZeov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A82C4CED7;
	Sun, 24 Nov 2024 13:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455314;
	bh=1LymdqpIRSVEy2c1NjgPG0NZM4d0W1v9adkK9z7UpEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s5tbZeovZx2lV1xjco8fz4I7eOPbnk5HiE24GcSPUNcTLE1FmUUS9qJIWklYGq6CP
	 m0lnr0lzzlnNWtaOH+G5awZ7rIyKaYEDbS7NSpRv9yvaLUuEY9E4BOopkLZa91Vwd5
	 zBKoyhYX8wVVYh+MUVrq/wZjObY+4famLc8FrMvS8OiIPfK11dsnaVFRpVZBBr71Xj
	 USphvV/NkgqW0z2noLL8XxQSJ4dKB1xjJP2+4n6mTxyGSJy/XE98vl299gyyWF1fIM
	 sfOQpYveG2UYWDpBtJztcNNVHIFrhotIa+uKQbCGGtr/u/TOE+jmahZyOHXp+by0cn
	 Gua7jt0mmBamg==
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
Subject: [PATCH AUTOSEL 6.12 037/107] net/sched: cbs: Fix integer overflow in cbs_set_port_rate()
Date: Sun, 24 Nov 2024 08:28:57 -0500
Message-ID: <20241124133301.3341829-37-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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


