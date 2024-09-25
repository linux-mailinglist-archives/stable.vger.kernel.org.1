Return-Path: <stable+bounces-77566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA62985E9D
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2D71F218B4
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406C31D0788;
	Wed, 25 Sep 2024 12:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEyjckme"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF35C1D078C;
	Wed, 25 Sep 2024 12:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266348; cv=none; b=sP8nDoAr83ueI1FVutQwbsMV1M5wGlGRPxviYlIlnPj/Y85EOUXU9me6SlrzKjEac6MS41SOcscMUQYU4zFGqnqXWjH+yuxb3qVSERXuXfok+WH89UO7uzIAT4AendtM5wkR3FuJGveGJRusvfM4h6Gk4NxmY/XRLit/4spvCGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266348; c=relaxed/simple;
	bh=0NBvuPXswHaz7CQCzj43Yy17NgK7h6H+upnPzF9YFdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7yj+M3ZaDB99fykTxhlMx2iYkmon7YtXe6gdsa1B9iStFA6HzKvuNPG6ZUZdkxNpNysorKcGXkN3PxpDZutYxddmz432HcQyqfi7LvfNmhgZ1eZGCaycUykElG6CQr4GCeIjRLNmDdIIZVlswAnYi/Kku0Xs3JE1LMfvP9SfTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEyjckme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DF3C4CECD;
	Wed, 25 Sep 2024 12:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266346;
	bh=0NBvuPXswHaz7CQCzj43Yy17NgK7h6H+upnPzF9YFdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qEyjckmexsk2zvsgrQyP/AJCQebKoy6u4TTDH+MfA2SOFKEABVhUWKmM73noRcWj9
	 PS8QBkna1EyO94tLjAKfVM4xNCc8EN4hpnevdgsVC+gW5ctsZkul22+0jVosDtKtVZ
	 XC9cbiNNqYp9kcVW0EqOyJJhf950uyLKVfIRQrz3f66cHNbNOthjwzvcIAaLVTqYge
	 5upO8ARcd55SA8ST0kaYRYg9SfRRqXFXGMYE95P1U/Igy4HT/e0DSSsDznfcUkBPLq
	 qJOQdIPgRHWda2Bmsqm1dEd/cbigGZs+lMFU0l1Z14T/r6xL6eoviLskOtEPirY5CK
	 1EtLi/hlqJeRA==
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
Subject: [PATCH AUTOSEL 6.6 020/139] net: sched: consistently use rcu_replace_pointer() in taprio_change()
Date: Wed, 25 Sep 2024 08:07:20 -0400
Message-ID: <20240925121137.1307574-20-sashal@kernel.org>
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
index 418d4a846d04a..87090d6790362 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1975,7 +1975,9 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
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


