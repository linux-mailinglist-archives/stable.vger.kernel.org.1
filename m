Return-Path: <stable+bounces-164692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A4AB111A4
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 21:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FCF91CE735B
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 19:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE5E284B25;
	Thu, 24 Jul 2025 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="KpCfQIpG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2A42ED844
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 19:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753385241; cv=none; b=aCo0aB3l7eVqaL6pVnC12cCEp02mf/eqSbwByNkRALao/pllTwbMXRVTWtp0asM56ABjy/YKqkmHn39/Usabfgp8SoL08kjeHaGez2s3z85lewyT3F1Ocl+aO4TH1d/aDqofdxzlcG2v1RS8kDaPNljvP7eHhwkR1nuLohqidkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753385241; c=relaxed/simple;
	bh=WYt8nTG25/1Ji7hR0c+8iWPYgKGrSbCgPQyr1778J5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o0b98f3S/KfCkPvqp5LYFMSf4zi7Bn3013neNgnJM2s2rr1o+0jSZjW1CuaDZYl4ll3J37mI5DBScZ02Y5IYuAaoeZgBKNCqSg7XMAwhAYHTgop3VqB8jmCTy96x83P7rVgHuNX0IlGVLU5wBR8B5NCEZOwEOO4tZpwfovHgfdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=KpCfQIpG; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-313756c602fso34306a91.3
        for <stable@vger.kernel.org>; Thu, 24 Jul 2025 12:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1753385238; x=1753990038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Am6LBiaggnPf4CUMCQwxKLHavX7GZKeKQptIqPpqqw=;
        b=KpCfQIpGRjHprXWpfQI6tvJr+7EqYz1Ze0p7sBRjfzc+84umgUydk74dj6kSKtfbPh
         PIQhzDemNNzbA/oFo1YiOwt9XvRuJCWm5dKRU6dmj4v7OlPaYLRuocR/nCHiRjTSLqVs
         digq5KkVX+PNa6//sjjSxeYLHB9lfxzSRsg80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753385238; x=1753990038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Am6LBiaggnPf4CUMCQwxKLHavX7GZKeKQptIqPpqqw=;
        b=bnVdPlFZRmSvMjpDRFYqUX9u08cOxQKH52ECjYaJqkwuCY00EgjWdrGMcBgPWoN4Uq
         MG8+ohrOqoYFDIeWfUjpDBfPmUQHRztw4UY7iCXUTdut0rsLTX+ziipQbGFtlDrGw+LN
         /xaPtnVADOW8HTu98tnA9+ILQ79LPaRtBx9zMKDpD9GkNuiJiO8refgTawSEx6GPLcqa
         2kWVqDThqdqTXSg1awyPuzL4sfQv2cQmqVBpokD2RtqdzGC3Q1UtVih2Wr49Xcc+zlMr
         m9xWF4jMe1cRyfhLVtpyBjx6cbPyQ8pqaI6DsY8pGv7/3plpjmIAljUWNY70JhiHIgKW
         daOQ==
X-Gm-Message-State: AOJu0YzElr7hlFxwwH4XLHU1KHTB05Jwpr2RcIOdXYhztIC0h/V4TGHj
	MqhGQh3nUX2A+BJrpY+52S3/B/Rr8keX31DEnUsVOn8jkiEdyhKNU615pXDwKihYjVX2U8fhgPJ
	tZcaUm/pzlg==
X-Gm-Gg: ASbGncue7ksWI4phiCNEe98p6PO54dNMZRuFJfrl/PQ1zgoGBLN1dhn7ucULeVr7OBD
	vNu/Kg3QWyAI2nwKucID7VZN8bdryX6rGT8oggnsP9Uv9K4fPNNCJtffiwscGP7Zih7hej0/P72
	9nWK5EsE5RZDAws8V6N5oRsLC4ol2yvcr08c2PXiXRfNkyTJqE5uozcLO00Mit7w2SQla4ZjpMh
	acNDXkjD1iUyqlJIWNYK/GigoBZH0jEDeqDNZY2KlCgvNUJtLNyCFYmv8b9BU6mKVw8rHl0ZVXO
	ls9vaxrV81H1Gv/6pE0lyeUhljVf9SworuZs0MXrOnxWtHqoJUiuDfhCTa2AZ5fFro74klHx4H2
	CjxfSPg8Jtzfd2sWBifkzWdEjdYMmsQmmsw==
X-Google-Smtp-Source: AGHT+IGfGPEVHX5yxpBn6LB6xbzPnPO7OhFpl7KES4aCPyKp1Z6TlK1AznBvtDG1OsMkFNuwwQn81A==
X-Received: by 2002:a17:90b:38cf:b0:311:9c9a:58e2 with SMTP id 98e67ed59e1d1-31e50857109mr4296800a91.7.1753385238044;
        Thu, 24 Jul 2025 12:27:18 -0700 (PDT)
Received: from shubhamPC.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e6635f0a0sm1945884a91.24.2025.07.24.12.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 12:27:17 -0700 (PDT)
From: skulkarni@mvista.com
To: stable@vger.kernel.org
Cc: akuster@mvista.com,
	cminyard@mvista.com,
	Davide Caratti <dcaratti@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shubham Kulkarni <skulkarni@mvista.com>
Subject: [PATCH 5.4.y 7/8] net/sched: act_mirred: better wording on protection against excessive stack growth
Date: Fri, 25 Jul 2025 00:56:18 +0530
Message-Id: <20250724192619.217203-8-skulkarni@mvista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250724192619.217203-1-skulkarni@mvista.com>
References: <20250724192619.217203-1-skulkarni@mvista.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Davide Caratti <dcaratti@redhat.com>

[ Upstream commit 78dcdffe0418ac8f3f057f26fe71ccf4d8ed851f ]

with commit e2ca070f89ec ("net: sched: protect against stack overflow in
TC act_mirred"), act_mirred protected itself against excessive stack growth
using per_cpu counter of nested calls to tcf_mirred_act(), and capping it
to MIRRED_RECURSION_LIMIT. However, such protection does not detect
recursion/loops in case the packet is enqueued to the backlog (for example,
when the mirred target device has RPS or skb timestamping enabled). Change
the wording from "recursion" to "nesting" to make it more clear to readers.

CC: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ skulkarni: Adjusted patch for file 'act_mirred.c' - hunk #4/4 wrt the mainline commit ]
Stable-dep-of: ca22da2fbd69 ("act_mirred: use the backlog for nested calls to mirred ingress")
Signed-off-by: Shubham Kulkarni <skulkarni@mvista.com>
---
 net/sched/act_mirred.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 9e094c984217..5181eac5860e 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -28,8 +28,8 @@
 static LIST_HEAD(mirred_list);
 static DEFINE_SPINLOCK(mirred_list_lock);
 
-#define MIRRED_RECURSION_LIMIT    4
-static DEFINE_PER_CPU(unsigned int, mirred_rec_level);
+#define MIRRED_NEST_LIMIT    4
+static DEFINE_PER_CPU(unsigned int, mirred_nest_level);
 
 static bool tcf_mirred_is_act_redirect(int action)
 {
@@ -225,7 +225,7 @@ static int tcf_mirred_act(struct sk_buff *skb, const struct tc_action *a,
 	struct sk_buff *skb2 = skb;
 	bool m_mac_header_xmit;
 	struct net_device *dev;
-	unsigned int rec_level;
+	unsigned int nest_level;
 	int retval, err = 0;
 	bool use_reinsert;
 	bool want_ingress;
@@ -236,11 +236,11 @@ static int tcf_mirred_act(struct sk_buff *skb, const struct tc_action *a,
 	int mac_len;
 	bool at_nh;
 
-	rec_level = __this_cpu_inc_return(mirred_rec_level);
-	if (unlikely(rec_level > MIRRED_RECURSION_LIMIT)) {
+	nest_level = __this_cpu_inc_return(mirred_nest_level);
+	if (unlikely(nest_level > MIRRED_NEST_LIMIT)) {
 		net_warn_ratelimited("Packet exceeded mirred recursion limit on dev %s\n",
 				     netdev_name(skb->dev));
-		__this_cpu_dec(mirred_rec_level);
+		__this_cpu_dec(mirred_nest_level);
 		return TC_ACT_SHOT;
 	}
 
@@ -310,7 +310,7 @@ static int tcf_mirred_act(struct sk_buff *skb, const struct tc_action *a,
 			err = tcf_mirred_forward(res->ingress, skb);
 			if (err)
 				tcf_action_inc_overlimit_qstats(&m->common);
-			__this_cpu_dec(mirred_rec_level);
+			__this_cpu_dec(mirred_nest_level);
 			return TC_ACT_CONSUMED;
 		}
 	}
@@ -322,7 +322,7 @@ static int tcf_mirred_act(struct sk_buff *skb, const struct tc_action *a,
 		if (tcf_mirred_is_act_redirect(m_eaction))
 			retval = TC_ACT_SHOT;
 	}
-	__this_cpu_dec(mirred_rec_level);
+	__this_cpu_dec(mirred_nest_level);
 
 	return retval;
 }
-- 
2.25.1


