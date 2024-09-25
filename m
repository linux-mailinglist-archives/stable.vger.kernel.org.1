Return-Path: <stable+bounces-77367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1217985C57
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610C8285191
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680FA1CEAAF;
	Wed, 25 Sep 2024 11:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBU7Jk3V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206301CEAA7;
	Wed, 25 Sep 2024 11:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265561; cv=none; b=ZKgvPGrFO6ThEjYDKW0hKt77JUTs0+PAyB7ZGYTrrm8+7/pxpx/N5B71zFRwKBvwIqdfXdd3+95BQogspvYLgfoZIYamKN46pmk5lOk8SN9FM4adcmxH7DxF1uonajpAbUF64u5KcLPzSYH14x5g1YnHXgpTIOubwXxyOCto6qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265561; c=relaxed/simple;
	bh=ZOgeyq49+WUZGyWLbqHvx44tkSNLRsVZ/Gp4SZjno5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNr4f4ZRaQJQ8/nLafUhec5S8U8Ecf4UEgaDmkhqZxoKRb/mb44QJLpqmoleX7nJdbkVqSfrE/Afbj8RGPr55XD8plF1G4VE0zHdBQFB65Sc51qjewPxlBUNbqDOL36PhyCGKjclijHZf+LhmEsYdohCQZ2Sbxkhy8riTWzxx6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBU7Jk3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34E0C4CEDB;
	Wed, 25 Sep 2024 11:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265560;
	bh=ZOgeyq49+WUZGyWLbqHvx44tkSNLRsVZ/Gp4SZjno5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PBU7Jk3VM5DoOAr/R+in1tObP56hzFo1EuSRdGpiDjhxMoVdoDRPg/tkpXUzLykPj
	 1kxRwB0vIBVm1TAQW31iRYBJpohObj4EQE16Q8J6caqU7/ykVSqylAKVob3ikLNvaH
	 5dd8fu3N2B1jKD0zG6uu6M1KaEybSgi54oDcXnU18tboJ7rWmpFF3eMRaO0bGcPOcw
	 d3FqKlQy9O7iFYo8tonEmNDjFL1X9pT0fclmvsiYkhkLM7ntebUSDkZO+K1MUr2JEw
	 KzEGu83xW1PkA7LPsN8o/qco5Udcz150PtFiBql1MYLTNBxahITNtFCKbfSMFKkZwu
	 96eKRh1Ve3OZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 022/197] net: sched: consistently use rcu_replace_pointer() in taprio_change()
Date: Wed, 25 Sep 2024 07:50:41 -0400
Message-ID: <20240925115823.1303019-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit d5c4546062fd6f5dbce575c7ea52ad66d1968678 ]

According to Vinicius (and carefully looking through the whole
https://syzkaller.appspot.com/bug?extid=b65e0af58423fc8a73aa
once again), txtime branch of 'taprio_change()' is not going to
race against 'advance_sched()'. But using 'rcu_replace_pointer()'
in the former may be a good idea as well.

Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_taprio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index b284a06b5a75f..847e1cc6052ec 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1952,7 +1952,9 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 			goto unlock;
 		}
 
-		rcu_assign_pointer(q->admin_sched, new_admin);
+		/* Not going to race against advance_sched(), but still */
+		admin = rcu_replace_pointer(q->admin_sched, new_admin,
+					    lockdep_rtnl_is_held());
 		if (admin)
 			call_rcu(&admin->rcu, taprio_free_sched_cb);
 	} else {
-- 
2.43.0


