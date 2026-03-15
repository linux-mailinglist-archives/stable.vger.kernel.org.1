Return-Path: <stable+bounces-225453-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPHpC4T6tWkI8AAAu9opvQ
	(envelope-from <stable+bounces-225453-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 01:17:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F83028F9E2
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 01:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0577E3026054
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 00:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00A718BC3B;
	Sun, 15 Mar 2026 00:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="bjpCBaCP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFBC749C
	for <stable@vger.kernel.org>; Sun, 15 Mar 2026 00:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773533822; cv=none; b=rDxI/5LCAF19NjTdxXKl4/xklO8N1bGUYN4CI4z26UvgIq/Ph8wmSXh5MNwGvUtqwa8VKhyUNIWdxoGki0VXDfHUbU8Lj8n8hF2M2lmPSb0mW0Fd5wavBg6mmDWku5zLU4ORXeBU5CypfRM+t0Pwx1Hk3v1OLLbL6IVTzQeqXa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773533822; c=relaxed/simple;
	bh=wwGrUQgxU7uePMbyqhRtqzF8vy1orYlCZoYEmlnK1ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EL+OuffyzVDAPjcJWd4fsY+zQlaCO6sq+7s9C+GCyslXE2AqabsQQSIyxmsJm9bEwykmEVNuHqX7rPjnEaKHO7UJm5ZfTC7YmeDNu4K1u7ATJykqxlqgFM3Y87ulU5TT4zSUdQbne1moRcvW3F37nU3OEDwHyYy+UwtJIJkH2io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=bjpCBaCP; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so3356780a91.1
        for <stable@vger.kernel.org>; Sat, 14 Mar 2026 17:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773533820; x=1774138620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xX9Tgk0PCVdVHRhl80KArNy/HrovadxDUjYA1eEpUQM=;
        b=bjpCBaCPYM1/cvLKmBEcvETznrv6nBY+9p3xO//DCajOP6TyRK9DYwWz98UMrJwa8m
         7Ruc7RAJ0lzc44b/X4wHP4hp9uAsnm+7PypKkki9meEUb+IhaQRKWLaQ4jYRnzPFwK2P
         GIxZQwPs+XQqAnwTOV4zWY8QwcebRlczLNLNXi5nPrCzdjnjxZ1Rwx17NViip7ccSpyE
         TDs+M9mt1hTvaslTW/sixj+tN2rpAwJ6waBMBbH8I7tKHybXiL47zMEctSS0h3GdhtCr
         c/FsLX96aoh4HfB/55N8jOwpH2baAH7fPguMN2lLf1U3u3PM40RkTA7/LhawzJ8XksSY
         ek8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773533820; x=1774138620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xX9Tgk0PCVdVHRhl80KArNy/HrovadxDUjYA1eEpUQM=;
        b=W/y+ER1f4dKZgtrlXaMkfKWiYSIk60649PgeZvkIdZzOmNehdsFO7cSxpNmNPs97D+
         /uI1VT/8w93KfLCIEztesuxxLpeeK91J2lVuLokl5JWqfXHIDMnLFO8BaoX+MR7Fj4gJ
         Us1T8j0Uchp3ieaZ5c+ojZ14aVJCAJvhzwkqXatW0qFhb4O4vDvF6X/y29LviDgsoIrX
         Q7w9jQH2i6pzRp0Re/Ltuw+WVFAn6oWh7FoS0xUzqVC86vKsa5KHAqqIrrznb0PcRNMZ
         eUzrQyy/qLjGuaNekQBor0JNibqUEtngR2L5hJy6/U1G/FydyDhmUuBE30b52lBcWW1c
         Px2Q==
X-Forwarded-Encrypted: i=1; AJvYcCURmKd/ILuKbX9MFK/ehC+GBs4CJBPogvchnAiRvE/iZlR2MHuBYsr2GZ3rlbUp5espeY2O4bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjvndysbdS4HYooDuljbS2oasGj0ZOnEb7fxN874JUOVcq8GeB
	KaWTtaz7Uj3rJQ0GsOWtrjftF4xyij2sKjkea1piPE3hD8PtS8Gt7Ei+ow5PD8FVePg=
X-Gm-Gg: ATEYQzx2a+BINs3Ry7zygeHcZ25agcS4Gx1d+7vZ11gQ20LC6AtPSTJ78RERnDJpaM/
	DF5nAzFbrqscMoj/2kyd1VmmM9b/3tnJR5wXZVLHdtioPKmD9qajlqbJL++05t4aDiQ+h10jfrY
	7wGOdtuxpkCW1ko/wsxSKmmznyNjJlqC7uyOHk9HpVhk4FNsX+vc7YdLD40UqU7vbuejXA3QlaL
	aqqRS3snTL6SRnv424ggqOU5pugbQZpmiCI4x9uXZQpXra7ifF50mWKVP9q1NFQqgs0puxq6HCr
	+vGBw+W2s+VVf/2qV5DSYM/O+uWO+UzEbfDIr1SObIpttUY1TcTof+042z7J0OqQMm5unEOIrUW
	jrsmH3v2l3Zs0C9+S38KPIhLjnXFcyod+CUicRKnVhqWMJVMMa/c88uwMr3ptyODwyykQg6xgvV
	2Zhgk5BDzATSBonvWoB/Gvbf0KY/oJtniT
X-Received: by 2002:a17:902:d549:b0:2ae:809d:71c3 with SMTP id d9443c01a7336-2aecac65878mr80971755ad.50.1773533820617;
        Sat, 14 Mar 2026 17:17:00 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece86b12bsm74252425ad.91.2026.03.14.17.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 17:17:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Ji-Soo Chung <jschung2@proton.me>,
	Gerlinde <lrGerlinde@mailfence.com>,
	stable@vger.kernel.org,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH net v2 01/10] Revert "net/sched: Restrict conditions for adding duplicating netems to qdisc tree"
Date: Sat, 14 Mar 2026 17:14:05 -0700
Message-ID: <20260315001649.23931-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260315001649.23931-1-stephen@networkplumber.org>
References: <20260315001649.23931-1-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-225453-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[networkplumber.org,proton.me,mailfence.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[proton.me:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F83028F9E2
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


