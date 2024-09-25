Return-Path: <stable+bounces-77123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F25985870
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31C211F21E41
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 11:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D1E18DF87;
	Wed, 25 Sep 2024 11:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGoCpWfD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3690B18DF61;
	Wed, 25 Sep 2024 11:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264260; cv=none; b=orBXudENv31EgWyOdt3XsAdeYYCsM0T46BJdFaC7jhA32YHmv3m/XFqO9neWNg/QOiXTMO9eLYwZ7kTc6g2RCfxReHcInxBS3rqClbxlVACvoTAnnYZCxvPZX4FCdDArx+VqSH3898DW/S/K742riIDjHaA0jzSSVxktfe+1B4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264260; c=relaxed/simple;
	bh=GEWQ5/b/RznTnA/F7uHq3LTBn3irsWisJycSLSY9qq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wk5HyUArThYuNsPrXOAA/jVsUJ3m2osh0+9aRozPEtBX/G4+Q5DJCeOJkkZMGf5kD9qiGKVA1lvT8XRHdVsL6RFPZCH94DFVadrPv+skKq8gkQSR6YYtmwIagYQxnQphgwUGgwJLc6SoqObUBoKs3ZX2BHpwGH8WdaZbTmFHSB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGoCpWfD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3897AC4CEC3;
	Wed, 25 Sep 2024 11:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264259;
	bh=GEWQ5/b/RznTnA/F7uHq3LTBn3irsWisJycSLSY9qq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eGoCpWfDELcPNCpGUv+rTzxV3b8Ss83smmOZJoK0RrvVoK7S6yV8X4cZLRvCJFyKr
	 YXImX/2XNoHd79HcXsBdtirh2NYWh4/Q1fih5UudfIzR9sqtYt17f/SvIIH2d6cI+8
	 hpOOqI1HXiWXPo9L4BWmcClBUgMSu7eco3mN3UhCUAkd979HdnSTfmw+J4FI3n6KSi
	 HC0hj7TrHu8IvUAnixqVW2Jsol1UVUwkeUyhNo/H/oTdOKr4tnMtxYERQrL6NqqRuU
	 aPYz/tRCwI1xHvSHdytHg/ShR7NT9ov3zi34jSsSxUk7PRN+czMsWxQz9wCUmekk4v
	 /o4UPXfc5G3mA==
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
Subject: [PATCH AUTOSEL 6.11 025/244] net: sched: consistently use rcu_replace_pointer() in taprio_change()
Date: Wed, 25 Sep 2024 07:24:06 -0400
Message-ID: <20240925113641.1297102-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
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
index cc2df9f8c14a6..8498d0606b248 100644
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


