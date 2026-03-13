Return-Path: <stable+bounces-225388-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A/jD9V+tGmuowAAu9opvQ
	(envelope-from <stable+bounces-225388-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 22:17:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B941B28A14A
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 22:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D33893035023
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 21:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60798372ECA;
	Fri, 13 Mar 2026 21:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="QV2JyA1D"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07488382378
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773436622; cv=none; b=f/90Xnb8FhaXacK4nKU7Qla+hDNKTFajCKz+F+jAtdv+UZ7GGZn7c5cxOlqE24e9vPfYxzN/IDWsKQcovJLHxzjvotSQ3bLNqVE8vIohl3i2hjnwQfU9yTNwoW/QKyWg0VTx9p/NRK6hCzPTaAG+h3hQmtvjHqNAIEjaMsVQ0Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773436622; c=relaxed/simple;
	bh=wwGrUQgxU7uePMbyqhRtqzF8vy1orYlCZoYEmlnK1ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XX4Ochr0GUy9v4can5ssT4pqDj37l1ZNNBA7h+7z0795pM3r0KN91SOaxZi0QgFgDsZAZf83289SwkWzBrOoLa5r7CT6ZUG9yYpa//3ilrAsDvEuDyHP0uB0hzC95CSy2PJehBFmTwZzUnV+kRxssxd/spYzoDDqNWEAsRugZwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=QV2JyA1D; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c73a5473bbdso1073266a12.2
        for <stable@vger.kernel.org>; Fri, 13 Mar 2026 14:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773436620; x=1774041420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xX9Tgk0PCVdVHRhl80KArNy/HrovadxDUjYA1eEpUQM=;
        b=QV2JyA1D4jqSD4VBBSOsumGdgjqL8bGG2Dkgc5u4ZwrnVS0VSUTG0N7GFTSKGzDtJh
         Sjc8DoYVaUJgbZ7HNmXf7P8bHzRIb3qssixlDH+LWBa2xcLQOHPwIWvNqwEx9UNXr3eB
         r4lke7WLeaNfHss4Thr38QofR0HUMNmO9iQIgb2wLwowN1Errn8fzNG4YJaaT3BnCShB
         WBByDmfKGbOmlRX4xwkhm0xzqHKjW9I441jC/SpHOlasX11gDFc6gG82Qy7Man+vjWi2
         JU1gqqc1mq53rqMaxnuMPK9h/ETxNuPWwG2sznATXQ99cZrn0BsS+oAvYDMLLS6kOzq3
         9olQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773436620; x=1774041420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xX9Tgk0PCVdVHRhl80KArNy/HrovadxDUjYA1eEpUQM=;
        b=fG27OGZu8pcgG//A8QgwxT5ItJk94E4k7k62Yrlazc2v+NnsLGuvD+tSWEVqbCnYZY
         RbRNRns5/gNv9H2uvmbjqh9LyUHJx6/VA4Sv6yeESZ1eL2Uxfi2vm7Lc4Lb4c0ciU6A2
         hn44PvBx5o9TWqu6AHQyi7Fa6J1ljodWf6toeys2Oyzjv1wsRJ2JEiK3GSErTqDt3eAI
         L7Pib++VTOt11sNst6RNBamtcxG8NCQgDIqVmOOF2bSuZY8hpooLD88ooERw3l8vgv8s
         Ye19BUQhkezgOCOIf5TOojL7amHAMuQFG6EI513zkz26A0BXD0cbgQS8XDve6cdJ9zU0
         MUNA==
X-Forwarded-Encrypted: i=1; AJvYcCXwQ6jfpiIjYg/2JnNyGQ7tf1U6hWLFsviXvxHL+odxsDNLwtj5VsQi2NODSN54ZjnWM2CQOAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5JyLYwBZ1E+Eg69j0d03PP6jIqKpJEKpko6G/5QwxDkMXrtst
	el0JmbwA+LusmESvS6EVTR8mL9HPTw6H67csO0+gqIsI9khA80SbKHSUnGO3+QshKE0=
X-Gm-Gg: ATEYQzw7DCAvPCVKbCdBwxKtMyoYvL/j50leVvU6I6MSv2SvTpxc1DWv9PJjgzKIRym
	SmuL1wdF5AuWCeQqFHJ35uBvJ+ZrDPVnAnMospZwaSSFZcri/BkNTVrOSaHfBQX7e4+2ySAvSt1
	B+yu/M3Bsn8J0/ZOk3RZuuMQAIfBZytx7kUmIxXQmVww2YWi35X/5as/2xa6k3XwlOgkvbBn9gr
	lXdRFjBug/66oRXrzl3JZ0o4QIwlgu7WN8DLJUD4JaaZ9C2VXWOnmw/1E5yESZSuPXJLdJx/7Lu
	4r+XjtCbQwUsPfHInNBUCs/aPn50b8yIaYomSkq/8sCWTDdJmggXwFuhz5CiLbofUoswLV0F153
	qdpD3LDovLQc4veNPjTXhtyQvkZwQNdZHV+EkKWDhLIHyVV1xrpUC9z/6UKdSpasEbKBbxqBBIh
	pVYyTukIAngvd0EDJ8gHGslpjjOdHx4kBH
X-Received: by 2002:a17:902:ccc3:b0:2ae:4645:6f77 with SMTP id d9443c01a7336-2aecaa2f920mr49528875ad.20.1773436620333;
        Fri, 13 Mar 2026 14:17:00 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece81afccsm31204195ad.68.2026.03.13.14.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 14:17:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Ji-Soo Chung <jschung2@proton.me>,
	Gerlinde <lrGerlinde@mailfence.com>,
	stable@vger.kernel.org,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH 02/12] Revert "net/sched: Restrict conditions for adding duplicating netems to qdisc tree"
Date: Fri, 13 Mar 2026 14:15:02 -0700
Message-ID: <20260313211646.12549-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313211646.12549-1-stephen@networkplumber.org>
References: <20260313211646.12549-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-225388-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[networkplumber.org,proton.me,mailfence.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[proton.me:email,networkplumber.org:email,networkplumber.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: B941B28A14A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This reverts commit ec8e0e3d7adef940cdf9475e2352c0680189d14e.

The restriction breaks valid uses of netem such as using different
netem values on different branches of HTB. This even broke some
of the examples in the netem documentation.

The intent of blocking recursion is handled in next patch.

Fixes: ec8e0e3d7adef ("net/sched: Restrict conditions for adding duplicating netems to qdisc tree")
Reported-by: Ji-Soo Chung <jschung2@proton.me>
Reported-by: Gerlinde <lrGerlinde@mailfence.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=220774
Cc: stable@vger.kernel.org
Originally-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 5de1c932944a..0ccf74a9cb82 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -974,41 +974,6 @@ static int parse_attr(struct nlattr *tb[], int maxtype, struct nlattr *nla,
 	return 0;
 }
 
-static const struct Qdisc_class_ops netem_class_ops;
-
-static int check_netem_in_tree(struct Qdisc *sch, bool duplicates,
-			       struct netlink_ext_ack *extack)
-{
-	struct Qdisc *root, *q;
-	unsigned int i;
-
-	root = qdisc_root_sleeping(sch);
-
-	if (sch != root && root->ops->cl_ops == &netem_class_ops) {
-		if (duplicates ||
-		    ((struct netem_sched_data *)qdisc_priv(root))->duplicate)
-			goto err;
-	}
-
-	if (!qdisc_dev(root))
-		return 0;
-
-	hash_for_each(qdisc_dev(root)->qdisc_hash, i, q, hash) {
-		if (sch != q && q->ops->cl_ops == &netem_class_ops) {
-			if (duplicates ||
-			    ((struct netem_sched_data *)qdisc_priv(q))->duplicate)
-				goto err;
-		}
-	}
-
-	return 0;
-
-err:
-	NL_SET_ERR_MSG(extack,
-		       "netem: cannot mix duplicating netems with other netems in tree");
-	return -EINVAL;
-}
-
 /* Parse netlink message to set options */
 static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 			struct netlink_ext_ack *extack)
@@ -1067,11 +1032,6 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	q->gap = qopt->gap;
 	q->counter = 0;
 	q->loss = qopt->loss;
-
-	ret = check_netem_in_tree(sch, qopt->duplicate, extack);
-	if (ret)
-		goto unlock;
-
 	q->duplicate = qopt->duplicate;
 
 	/* for compatibility with earlier versions.
-- 
2.51.0


