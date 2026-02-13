Return-Path: <stable+bounces-216286-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDe4L6dmj2k+QwEAu9opvQ
	(envelope-from <stable+bounces-216286-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 19:00:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 338C1138C85
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 19:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF8AD301FD5A
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 17:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AE6364E93;
	Fri, 13 Feb 2026 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTJqddxE"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22C924A07C
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 17:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771005595; cv=none; b=rjRx0teYhTJ+L0DomwNab+cltmUVpfPz2MpLstOcXGfj/pTtQ6S+cXBHLxzQjova974m/PSuy6uG5ZEgtmugzAx4v9sSz7mB/9Pn9bo2rQ5vLkmLRF83/8NW9ZjB8G5chxg9flLx4QFyEgyz1IPEYc4PHukWs2/GSegHND+ajlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771005595; c=relaxed/simple;
	bh=xffl/tcUCbwQWS0kee51G6+d5C4oaOgdVrvYRW1YsQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EjvKgpVJhc/QTfRi5cC+aHysDBvDmJrxVLfuZSrBZT/dgNvy53qlNLdvxcRcshT/Gb+lLxC8KS7hTQ2RyNujG1NGMNp1bBxbPPodwyhRwE6sbDT8CLikOar1b8HWRtpiOZyggJ4jQ96iwFR9abZyG3d/TUIu1K4C9sf0OJexF2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTJqddxE; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4043b27ddeaso725670fac.1
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 09:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771005592; x=1771610392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+HH55yaDIAkLqPY4ZxIlW7GY63xjVHzwe6z7jmBHtY=;
        b=LTJqddxEzomKNgtOqzrPMXrIVYLcuhL5Zr1SC/YhV1jmN/hLcCSiq+G69VZXREXt1B
         ELDOjkTgSUaWoZZfkcC96UMnpdVwtfGkbhosLw1rGer/nfcPRsQaqJEcTqiKsUCaast8
         zCEuAgazVYHAaZ3KmCRKBq3m+febHpJlEFuX9TiNgBoHJY1v9Q8ekT/FvAh4ocZTiQKB
         oB3eawC8TLcWaySwMxGJbFaNWPF4p+KNlgu+wYbMzsYbefzbtq1O5WUZ723Zhrmk0RlM
         10tuXiBwVGsETEgivP9UrvXxZjqXecQTpwI3uvc0vjMTH4tMLFiRfo4MtQaR7qwPj7Or
         3ZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771005592; x=1771610392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1+HH55yaDIAkLqPY4ZxIlW7GY63xjVHzwe6z7jmBHtY=;
        b=nUJaGbOnNDvcEgKSAE5lOdmeJSyqBjxGs3AXlOUUISN+YCMMUB78Y8xXDgCisyOqI9
         lniPhBSyo97GOoZiU4ltGgTyXT3po2tHUC0nxfN6ygi/Z/Jaztnt5AUZHfgpo7F7G/Y0
         Fqhx4o7+IQ/g/Ja/+8Mt13dIoGo87DZF6Fz9gl6bZxIA9LOxgv5bUh3KIXXeOJjZiAoz
         OHidsO66n9Nt0GprQx4Wv77KYrnH13i5JVSDabrlKBmohanGPTobKbyzM+Qld9Zrt4A8
         SDsO+BYXkashxDFHSOiTYUSE33t0q4Y+ffsosIHogKc9CC4VjLwYZdphilA4Wit3iM8v
         KZ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSDPEmB0Nyrz9Pgv/zONGFzBoScD4RpxvhE9RneXWUe+LYciCPgNTRGCPnLwGPNfwedKPvUBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjSRl+kbpU9XZJrot2TsWL+RzCr7BXmZ3stB9R3wq+xr1gOtwk
	+7eMYETKg4FfzUUEL6gFKXqx8zJDphA0ytFrmOslKjV/IVl0l2MzlFPN
X-Gm-Gg: AZuq6aLf+FM4MvkxPSUOkR3v3ei73A9jWUD06ppYrCM7vyF1Imar0/YJPq+iWYE1BWC
	gU7kyST/P25SrL78mu91VJ6KsEQxaXmaBYUqzT320qIQYRpOYJY9ZwN3fO5JwCBJqKL8x0Z4gk9
	xNus8NlV/rnd65erHAlBPM/3CkIvQ/sq0IeeATNX85SQbA+rrSul3zRdoMCJQ5blgI6gkF7Rcxy
	6uA+IYgs1tU1gVe2xMRG9uE+oWZc9djtfnmQ8J87v1vHX0CjF1jfRc9X3oMRIkDSXpGSaWkO3nO
	A3gVA694LRbLYD2wDYX+nMyk9H9cZimXz7ZpeVK1t5WFxT5sN0dBxWRj2+II3YWlFpH5RK5o+GO
	yaoHm5MhYdfYEIaUl3WHe3XSrZqhuyEBwluw/pCYpw28a2gvd3Dq6+xGTTdrLboTgl+OESKAI1O
	EKdpEYkpt6HtSysvYPvW3bFDc3eWFnxuGKIYOt7Ip8PkNbObI2BisZ75zkyQc2rrNThwB9in1X
X-Received: by 2002:a05:6870:6985:b0:404:3f0a:9351 with SMTP id 586e51a60fabf-40ef40ebc2dmr1412774fac.52.1771005592394;
        Fri, 13 Feb 2026 09:59:52 -0800 (PST)
Received: from ubuntu-BQM5.tailafa00.ts.net (cs244-84-dhcp.cs.colorado.edu. [128.138.244.84])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40eaeb42708sm7356270fac.0.2026.02.13.09.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 09:59:51 -0800 (PST)
From: Ruitong Liu <cnitlrt@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Ruitong Liu <cnitlrt@gmail.com>,
	stable@vger.kernel.org,
	Shuyuan Liu <L0x1c3r@gmail.com>
Subject: [PATCH v3] net/sched: act_skbedit: fix divide-by-zero in tcf_skbedit_hash()
Date: Sat, 14 Feb 2026 01:59:48 +0800
Message-Id: <20260213175948.1505257-1-cnitlrt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260211184848.731894-1-cnitlrt@gmail.com>
References: <20260211184848.731894-1-cnitlrt@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-216286-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cnitlrt@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 338C1138C85
X-Rspamd-Action: no action

Commit 38a6f0865796 ("net: sched: support hash selecting tx queue")
added SKBEDIT_F_TXQ_SKBHASH support. The inclusive range size is
computed as:

mapping_mod = queue_mapping_max - queue_mapping + 1;

The range size can be 65536 when the requested range covers all possible
u16 queue IDs (e.g. queue_mapping=0 and queue_mapping_max=U16_MAX).
That value cannot be represented in a u16 and previously wrapped to 0,
so tcf_skbedit_hash() could trigger a divide-by-zero:

queue_mapping += skb_get_hash(skb) % params->mapping_mod;

Compute mapping_mod in a wider type and reject ranges larger than U16_MAX
to prevent params->mapping_mod from becoming 0 and avoid the crash.

Fixes: 38a6f0865796 ("net: sched: support hash selecting tx queue")
Cc: stable@vger.kernel.org # 6.12+
Reported-by: Ruitong Liu <cnitlrt@gmail.com>
Closes: https://lore.kernel.org/all/20260211184848.731894-1-cnitlrt@gmail.com/
Reported-by: Shuyuan Liu <L0x1c3r@gmail.com>
Closes: https://lore.kernel.org/all/20260211184848.731894-1-cnitlrt@gmail.com/
Signed-off-by: Ruitong Liu <cnitlrt@gmail.com>
---
 net/sched/act_skbedit.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
index 8c1d1554f657..5450c1293eb5 100644
--- a/net/sched/act_skbedit.c
+++ b/net/sched/act_skbedit.c
@@ -126,7 +126,7 @@ static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
 	struct tcf_skbedit *d;
 	u32 flags = 0, *priority = NULL, *mark = NULL, *mask = NULL;
 	u16 *queue_mapping = NULL, *ptype = NULL;
-	u16 mapping_mod = 1;
+	u32 mapping_mod = 1;
 	bool exists = false;
 	int ret = 0, err;
 	u32 index;
@@ -194,6 +194,10 @@ static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
 			}
 
 			mapping_mod = *queue_mapping_max - *queue_mapping + 1;
+			if (mapping_mod > U16_MAX) {
+				NL_SET_ERR_MSG_MOD(extack, "The range of queue_mapping is invalid.");
+				return -EINVAL;
+			}
 			flags |= SKBEDIT_F_TXQ_SKBHASH;
 		}
 		if (*pure_flags & SKBEDIT_F_INHERITDSFIELD)
-- 
2.34.1


