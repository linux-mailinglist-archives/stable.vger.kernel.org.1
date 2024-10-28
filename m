Return-Path: <stable+bounces-88868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB06D9B27DB
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1401C21607
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16A618FC81;
	Mon, 28 Oct 2024 06:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EupDubIJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D51518FC7B;
	Mon, 28 Oct 2024 06:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730098303; cv=none; b=Pkqr48kQ9tM/X8KkZBQRY/83npL147FNc552IkKCGOmET1AKooLmnrk6rEUQ42kSwQ6bO8lipWEY44gy2ZnPdO/2QFlyt67CHeRwNET8FH/wTnV6gs7xPFOfEK909sqhlxV9z7HhrZItU8fAEP2Nu2B0lB727DRzeVnhcCUCWf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730098303; c=relaxed/simple;
	bh=lcvZ+hIJuAVy1SaDr9cHikETuCeLz1CwwdWr6lMmxWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ExeZjhe+VmndJAiIJSh2LAo7otX28y54We/40BbRlmHMdBr1dQuXg8RyKKpiCEQv5jYzdYKpJDQusTclhgAnTkohB9uTiJbVDqAvU1KgVuczfZthFq/CqLDc+s7xHugI+x8pXTR+eMexgkIa+rzZfDqslqPKDOwDqARrcQpYTeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EupDubIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24F3C4CEC3;
	Mon, 28 Oct 2024 06:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730098303;
	bh=lcvZ+hIJuAVy1SaDr9cHikETuCeLz1CwwdWr6lMmxWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EupDubIJPDubIoyEAijPgfEbsRyGyY/IC+B98eOphNm/GAS/o5HgkSMHjStDpQTr0
	 EicP/yAkpEq4HXE0Ml53ZMpRsx+G/C9Ok+p2XW60Z2WMgrKGdZxC9y+zyLJa4N6lDr
	 R80q/aw2EGUec1vPlR9n7Xu201Bi41um2b2hOD4A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 166/261] net/sched: act_api: deny mismatched skip_sw/skip_hw flags for actions created by classifiers
Date: Mon, 28 Oct 2024 07:25:08 +0100
Message-ID: <20241028062316.161547109@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062312.001273460@linuxfoundation.org>
References: <20241028062312.001273460@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 34d35b4edbbe890a91bec939bfd29ad92517a52b ]

tcf_action_init() has logic for checking mismatches between action and
filter offload flags (skip_sw/skip_hw). AFAIU, this is intended to run
on the transition between the new tc_act_bind(flags) returning true (aka
now gets bound to classifier) and tc_act_bind(act->tcfa_flags) returning
false (aka action was not bound to classifier before). Otherwise, the
check is skipped.

For the case where an action is not standalone, but rather it was
created by a classifier and is bound to it, tcf_action_init() skips the
check entirely, and this means it allows mismatched flags to occur.

Taking the matchall classifier code path as an example (with mirred as
an action), the reason is the following:

 1 | mall_change()
 2 | -> mall_replace_hw_filter()
 3 |   -> tcf_exts_validate_ex()
 4 |      -> flags |= TCA_ACT_FLAGS_BIND;
 5 |      -> tcf_action_init()
 6 |         -> tcf_action_init_1()
 7 |            -> a_o->init()
 8 |               -> tcf_mirred_init()
 9 |                  -> tcf_idr_create_from_flags()
10 |                     -> tcf_idr_create()
11 |                        -> p->tcfa_flags = flags;
12 |         -> tc_act_bind(flags))
13 |         -> tc_act_bind(act->tcfa_flags)

When invoked from tcf_exts_validate_ex() like matchall does (but other
classifiers validate their extensions as well), tcf_action_init() runs
in a call path where "flags" always contains TCA_ACT_FLAGS_BIND (set by
line 4). So line 12 is always true, and line 13 is always true as well.
No transition ever takes place, and the check is skipped.

The code was added in this form in commit c86e0209dc77 ("flow_offload:
validate flags of filter and actions"), but I'm attributing the blame
even earlier in that series, to when TCA_ACT_FLAGS_SKIP_HW and
TCA_ACT_FLAGS_SKIP_SW were added to the UAPI.

Following the development process of this change, the check did not
always exist in this form. A change took place between v3 [1] and v4 [2],
AFAIU due to review feedback that it doesn't make sense for action flags
to be different than classifier flags. I think I agree with that
feedback, but it was translated into code that omits enforcing this for
"classic" actions created at the same time with the filters themselves.

There are 3 more important cases to discuss. First there is this command:

$ tc qdisc add dev eth0 clasct
$ tc filter add dev eth0 ingress matchall skip_sw \
	action mirred ingress mirror dev eth1

which should be allowed, because prior to the concept of dedicated
action flags, it used to work and it used to mean the action inherited
the skip_sw/skip_hw flags from the classifier. It's not a mismatch.

Then we have this command:

$ tc qdisc add dev eth0 clasct
$ tc filter add dev eth0 ingress matchall skip_sw \
	action mirred ingress mirror dev eth1 skip_hw

where there is a mismatch and it should be rejected.

Finally, we have:

$ tc qdisc add dev eth0 clasct
$ tc filter add dev eth0 ingress matchall skip_sw \
	action mirred ingress mirror dev eth1 skip_sw

where the offload flags coincide, and this should be treated the same as
the first command based on inheritance, and accepted.

[1]: https://lore.kernel.org/netdev/20211028110646.13791-9-simon.horman@corigine.com/
[2]: https://lore.kernel.org/netdev/20211118130805.23897-10-simon.horman@corigine.com/
Fixes: 7adc57651211 ("flow_offload: add skip_hw and skip_sw to control if offload the action")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20241017161049.3570037-1-vladimir.oltean@nxp.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_api.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 2714c4ed928e5..eecad65fec92c 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1498,8 +1498,29 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
 			bool skip_sw = tc_skip_sw(fl_flags);
 			bool skip_hw = tc_skip_hw(fl_flags);
 
-			if (tc_act_bind(act->tcfa_flags))
+			if (tc_act_bind(act->tcfa_flags)) {
+				/* Action is created by classifier and is not
+				 * standalone. Check that the user did not set
+				 * any action flags different than the
+				 * classifier flags, and inherit the flags from
+				 * the classifier for the compatibility case
+				 * where no flags were specified at all.
+				 */
+				if ((tc_act_skip_sw(act->tcfa_flags) && !skip_sw) ||
+				    (tc_act_skip_hw(act->tcfa_flags) && !skip_hw)) {
+					NL_SET_ERR_MSG(extack,
+						       "Mismatch between action and filter offload flags");
+					err = -EINVAL;
+					goto err;
+				}
+				if (skip_sw)
+					act->tcfa_flags |= TCA_ACT_FLAGS_SKIP_SW;
+				if (skip_hw)
+					act->tcfa_flags |= TCA_ACT_FLAGS_SKIP_HW;
 				continue;
+			}
+
+			/* Action is standalone */
 			if (skip_sw != tc_act_skip_sw(act->tcfa_flags) ||
 			    skip_hw != tc_act_skip_hw(act->tcfa_flags)) {
 				NL_SET_ERR_MSG(extack,
-- 
2.43.0




