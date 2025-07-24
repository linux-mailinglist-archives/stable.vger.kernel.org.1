Return-Path: <stable+bounces-164691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 104D5B111A3
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 21:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10D5C1CE708E
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 19:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2242ECEA8;
	Thu, 24 Jul 2025 19:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="RF9l4WOv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9512ED163
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 19:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753385235; cv=none; b=gbA0m6EOrod/t1MxClAf2B6uzSWxJ9E+Kh2kg7C60qxN3SCcx7IKrLyWCea4og0lniNEk9Tv3Xd3fh+2USuAshFs0wG4PCVHz3pVbiAvS6i6hlVZDO7MKm2I8MT80F+9R8SqM5N6dJonQC3spDb6DSTmCPMSdloyG30c1anDYgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753385235; c=relaxed/simple;
	bh=NLATYq5SkCJJLMQ/X7KKcR/cneORGmAZ2H80cv29d/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qDcConDXgV65z5BRPZcA18211Ed6hxY9X5UDjKizPJlxOYOKana2cbDmNgoq0areX8TTxNl4iqALJRRfO1QkQ0UyLN+FFedYGLmFV9ninyv6y3kI8DDsdvIJfXtsbkocaJWzxTN1AxaO0X46OCBRLbX5eS6ds3WVA5KEz3vvWro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=RF9l4WOv; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-313756c602fso34294a91.3
        for <stable@vger.kernel.org>; Thu, 24 Jul 2025 12:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1753385233; x=1753990033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCeulzLEue6JxqgJqitoOqrSG2i179oJCPK21QQ1wug=;
        b=RF9l4WOvcNXMO43i5BPiMgmLU7ntVtE34FPY0MNPHrgr8UBABaQVZ6XeGArZMaEbdR
         vlqAxn62+jjf/WF/tlgBp/dTkiOui6SlQ4l8PkjbGIInDzCqZtJJLVNaSesASGbH0QF/
         UkHF6ZgYmQ7RE1cLyxObbcWyFwfpGb5gz24I8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753385233; x=1753990033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCeulzLEue6JxqgJqitoOqrSG2i179oJCPK21QQ1wug=;
        b=amdk9EWw9roXtfAvAf9smg/ebnh3eRdoOkColprFGj5XHhE/dmoPM4qNSb2c+bTwip
         KgxW7iTktdsmJDifs15b/c1jWvR0zz97EhbOjSF5Vt9lpjjqMG0VQFyQ2gooCnRxVoau
         ZIuJ/RkAPDOJyEDgN3dd/JpOF/dYxSoPeyhbeLTBnLga8SILgnvCVO9uKTWoqG9oyS62
         6/7i+IICSua2iQiJAjAsk8BM64p1X7XzsUYYk8i1mAl5XTCm9SE70VUVo+/ra4lraE8y
         MQ0rEsR1aiNpNbABJSxpd022XkIDkYdNaclEB4KyEJHa9+e3A8f8gXG0eGmp5gn/RD5I
         BNRA==
X-Gm-Message-State: AOJu0Yz05YnxAJgaA+c4YFtHrrqKn0Uu2CPWh9LOZobFyF+t1dMkjx2T
	WUlc3u9GCRzLPGqxwGJMbqMfNUb8s8A329uF/z+6BiJOCx4RePgW3VPI67mScDzu/2NcVRZPblg
	Jp+8wIWTzJQ==
X-Gm-Gg: ASbGncvmJe4VtAZelRCOKXy7VoAW1usVMQcLyk4kCLOq/WMGdsYBuT+hRzamCun1R8j
	wZuPVbenqVgCLEKX8FKA6u84iGqHhm+VWoz/oGA2jNgm6VwH/1WQ/yD5RnuijpBZ+LrYiGbzOz6
	eP6wKdCo8ZffdWsJ9GXNit7wVabpkoJbY+uCzvKAzNaQXAVAxyUKYAEyP6TdJ9a5Jx27941SuQ3
	/OdCCu1dyP1hTkUbnJ0zihYjlQBvJPqWA7TO7wT6n5lnSfvAEHhVEqG4lascsRSJDzal7zEfyl2
	C7/lB7n/mlpbccMCF7ph5TieKMooak3rdF1gYxl6ABuqk0oM/D+ugwXSwgxtTsEs8FVLTxEDi5H
	yhRjsUdoHS26xG0dBRMBlnLzsqoQ/cm2Czg==
X-Google-Smtp-Source: AGHT+IF+m9fnrVon/CTlR3NvtBop/UnzA0x2mlBTx0ow2euaYe9HsMmXUMu9S2mO26XUCKnPgtldXA==
X-Received: by 2002:a17:90b:2247:b0:31e:3bac:96b8 with SMTP id 98e67ed59e1d1-31e5081718emr4885292a91.4.1753385232528;
        Thu, 24 Jul 2025 12:27:12 -0700 (PDT)
Received: from shubhamPC.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e6635f0a0sm1945884a91.24.2025.07.24.12.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 12:27:12 -0700 (PDT)
From: skulkarni@mvista.com
To: stable@vger.kernel.org
Cc: akuster@mvista.com,
	cminyard@mvista.com,
	wenxu <wenxu@ucloud.cn>,
	Jakub Kicinski <kuba@kernel.org>,
	Shubham Kulkarni <skulkarni@mvista.com>
Subject: [PATCH 5.4.y 6/8] net/sched: act_mirred: refactor the handle of xmit
Date: Fri, 25 Jul 2025 00:56:17 +0530
Message-Id: <20250724192619.217203-7-skulkarni@mvista.com>
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

From: wenxu <wenxu@ucloud.cn>

[ Upstream commit fa6d639930ee5cd3f932cc314f3407f07a06582d ]

This one is prepare for the next patch.

Signed-off-by: wenxu <wenxu@ucloud.cn>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ skulkarni: Adjusted patch for file 'sch_generic.h' wrt the mainline commit ]
Stable-dep-of: ca22da2fbd69 ("act_mirred: use the backlog for nested calls to mirred ingress")
Signed-off-by: Shubham Kulkarni <skulkarni@mvista.com>
---
 include/net/sch_generic.h |  5 -----
 net/sched/act_mirred.c    | 21 +++++++++++++++------
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index ee47d65b9b20..a9a68714b58f 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1320,11 +1320,6 @@ void mini_qdisc_pair_swap(struct mini_Qdisc_pair *miniqp,
 void mini_qdisc_pair_init(struct mini_Qdisc_pair *miniqp, struct Qdisc *qdisc,
 			  struct mini_Qdisc __rcu **p_miniq);
 
-static inline int skb_tc_reinsert(struct sk_buff *skb, struct tcf_result *res)
-{
-	return res->ingress ? netif_receive_skb(skb) : dev_queue_xmit(skb);
-}
-
 /* Make sure qdisc is no longer in SCHED state. */
 static inline void qdisc_synchronize(const struct Qdisc *q)
 {
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index a7e924806c2c..9e094c984217 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -206,6 +206,18 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
 	return err;
 }
 
+static int tcf_mirred_forward(bool want_ingress, struct sk_buff *skb)
+{
+	int err;
+
+	if (!want_ingress)
+		err = dev_queue_xmit(skb);
+	else
+		err = netif_receive_skb(skb);
+
+	return err;
+}
+
 static int tcf_mirred_act(struct sk_buff *skb, const struct tc_action *a,
 			  struct tcf_result *res)
 {
@@ -295,18 +307,15 @@ static int tcf_mirred_act(struct sk_buff *skb, const struct tc_action *a,
 		/* let's the caller reinsert the packet, if possible */
 		if (use_reinsert) {
 			res->ingress = want_ingress;
-			if (skb_tc_reinsert(skb, res))
+			err = tcf_mirred_forward(res->ingress, skb);
+			if (err)
 				tcf_action_inc_overlimit_qstats(&m->common);
 			__this_cpu_dec(mirred_rec_level);
 			return TC_ACT_CONSUMED;
 		}
 	}
 
-	if (!want_ingress)
-		err = dev_queue_xmit(skb2);
-	else
-		err = netif_receive_skb(skb2);
-
+	err = tcf_mirred_forward(want_ingress, skb2);
 	if (err) {
 out:
 		tcf_action_inc_overlimit_qstats(&m->common);
-- 
2.25.1


