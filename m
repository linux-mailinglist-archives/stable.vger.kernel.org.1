Return-Path: <stable+bounces-1227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF4B7F7E9D
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03BB4B217E0
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C9128387;
	Fri, 24 Nov 2023 18:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yQa5liVi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73932E658;
	Fri, 24 Nov 2023 18:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777CCC433C8;
	Fri, 24 Nov 2023 18:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850874;
	bh=b/j3iQNLoBsde/Ut3IMIsVnPPGPV32KS6ZRIS/DJp9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yQa5liVi6yWb/MoqRsyfeuIegwDvyaaKDc5YqrwbZCoP/wEMLSDiRiXls+xLDvBD8
	 W5eB0S9Sl3g70fIJySOwEZsPVljEM29wM4Gp87zUZ13IfuAl1w1WUvHSIh6WdnvaKd
	 VfAT2xKaiTClFJRmDp+Ecii5bDSRRP1kBE+dZCYI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xin Long <lucien.xin@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 216/491] net: sched: do not offload flows with a helper in act_ct
Date: Fri, 24 Nov 2023 17:47:32 +0000
Message-ID: <20231124172031.027357977@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 7cd5af0e937a197295f3aa3721031f0fbae49cff ]

There is no hardware supporting ct helper offload. However, prior to this
patch, a flower filter with a helper in the ct action can be successfully
set into the HW, for example (eth1 is a bnxt NIC):

  # tc qdisc add dev eth1 ingress_block 22 ingress
  # tc filter add block 22 proto ip flower skip_sw ip_proto tcp \
    dst_port 21 ct_state -trk action ct helper ipv4-tcp-ftp
  # tc filter show dev eth1 ingress

    filter block 22 protocol ip pref 49152 flower chain 0 handle 0x1
      eth_type ipv4
      ip_proto tcp
      dst_port 21
      ct_state -trk
      skip_sw
      in_hw in_hw_count 1   <----
        action order 1: ct zone 0 helper ipv4-tcp-ftp pipe
         index 2 ref 1 bind 1
        used_hw_stats delayed

This might cause the flower filter not to work as expected in the HW.

This patch avoids this problem by simply returning -EOPNOTSUPP in
tcf_ct_offload_act_setup() to not allow to offload flows with a helper
in act_ct.

Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://lore.kernel.org/r/f8685ec7702c4a448a1371a8b34b43217b583b9d.1699898008.git.lucien.xin@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tc_act/tc_ct.h | 9 +++++++++
 net/sched/act_ct.c         | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/include/net/tc_act/tc_ct.h b/include/net/tc_act/tc_ct.h
index b24ea2d9400ba..1dc2f827d0bcf 100644
--- a/include/net/tc_act/tc_ct.h
+++ b/include/net/tc_act/tc_ct.h
@@ -57,6 +57,11 @@ static inline struct nf_flowtable *tcf_ct_ft(const struct tc_action *a)
 	return to_ct_params(a)->nf_ft;
 }
 
+static inline struct nf_conntrack_helper *tcf_ct_helper(const struct tc_action *a)
+{
+	return to_ct_params(a)->helper;
+}
+
 #else
 static inline uint16_t tcf_ct_zone(const struct tc_action *a) { return 0; }
 static inline int tcf_ct_action(const struct tc_action *a) { return 0; }
@@ -64,6 +69,10 @@ static inline struct nf_flowtable *tcf_ct_ft(const struct tc_action *a)
 {
 	return NULL;
 }
+static inline struct nf_conntrack_helper *tcf_ct_helper(const struct tc_action *a)
+{
+	return NULL;
+}
 #endif /* CONFIG_NF_CONNTRACK */
 
 #if IS_ENABLED(CONFIG_NET_ACT_CT)
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index d131750663c3c..ea05d0b2df68a 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1534,6 +1534,9 @@ static int tcf_ct_offload_act_setup(struct tc_action *act, void *entry_data,
 	if (bind) {
 		struct flow_action_entry *entry = entry_data;
 
+		if (tcf_ct_helper(act))
+			return -EOPNOTSUPP;
+
 		entry->id = FLOW_ACTION_CT;
 		entry->ct.action = tcf_ct_action(act);
 		entry->ct.zone = tcf_ct_zone(act);
-- 
2.42.0




