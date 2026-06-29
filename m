Return-Path: <stable+bounces-269707-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b1d+Dg8+QmpC2gkAu9opvQ
	(envelope-from <stable+bounces-269707-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 11:42:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD19E6D85D1
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 11:42:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rBk3Izfj;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269707-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-269707-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BA0430347E7
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 09:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F533FADE2;
	Mon, 29 Jun 2026 09:40:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733B53FBB67
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 09:40:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726040; cv=none; b=NtYrnGMGMWD0WJ2mBCrc+tOY41Z+5u8IjxwNgVzHHzNT6gFbzgEnIn1BSKGgDEQnI+Mr3ZOgFfi6cvTR0PByzj2F5Rviy/K4KRiurDK3L75x+VNZEjM96bxfAQXL9CDJ6e5tpEI0ohQIizNfzxFYjF2Uxjh5QUoGqL9jTnFwFkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726040; c=relaxed/simple;
	bh=PAPkGLqY5+Ymgav2BoA7yLxceFYQhOZZT/SxJVtm5NI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YA7C9nak5DWXRVKeWzDQJ7kZCCOC343zRJOKudYz+c6xEtj+FYs3Gfv6t4vlFm8I9PEd9LsxdGwwccbk9BUPgc72CoC5Fjt59Tqtqv+mbw95Pq6zpnxEahn6j3HcYuFr3yFD3QoaZO6jry2mIKuBXNL5FF3zZ0jWgpT4pdukDdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rBk3Izfj; arc=none smtp.client-ip=209.85.221.48
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-471eeac43bfso1591924f8f.3
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 02:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782726038; x=1783330838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=udQyQF8aEa2+Se0VULon8t0pLOEmiAFoi+1fzCs7lXw=;
        b=rBk3IzfjLpLcUs9jwoKMRYwtTw/Y7kgijEn5mEfbJEOL65fJkXsZCOyvM4+p3rYJq1
         XxUqXTJcuYotiFPxo9qe5t08AOtlKHTgEKpdHoP525tVl7xR+khsIngXcBHtD5ggGmxa
         NM+AOtqbu51UKn3WjAKZ2CCPnqnIZD+CxLdrQj1LOGxqYq1QcKoGBCeq6J04DKIWY52y
         E+WRa4iEr1T43kc0JKuYZtoJh4EJM/rSdMiKKGFIApYtF/zeZwpW7MTd4uu6lwcQlBVl
         lABLTWHRNRem2NHYqmQ9NrhuVIEHZZ2QBVlwTXO61CwI2TYvBH56WSq6ASt8V5KLsqgR
         qAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782726038; x=1783330838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udQyQF8aEa2+Se0VULon8t0pLOEmiAFoi+1fzCs7lXw=;
        b=eM2wMBjYcfGGmDVVtAL2k8apNOwoeoFfbghVsPtILKImN+7PKdfXpqA8W9VvWLdEsG
         lZKN7iP57miW2RQquhg5loOqEzkCIWcWPZYUVJU9PGPG8BQQ/91TuWJwk3TMGL8EboQb
         9JralElMDkNY6OrqV+CMmiEAu75H8K6E+Kd18MkPvqPew6ee4b9L7omz1sFSL84BUxg/
         jzAX5Bk+hVitG4fKehRgVCF0uZiGZB9UVL68YlQgk184w6omHQO7fKuT0SIog8ZrD2e1
         ecuMVdog2hHIV3zirYJAbXJ/XeRSLBB+bt11fG21hFVIuwjKaVetw9Io4jorjFuB9ycI
         kfCA==
X-Gm-Message-State: AOJu0YyjYdPRBe6nLLePLg7UBSpLWMmYrhA8yK2NVQHrejffCmFWCpb4
	wPYdrZel+awkkbLGzSt6oFDCz1xKI16cjLKZWalNozPEIOnoIiDu3m7qIINXSUARs2I=
X-Gm-Gg: AfdE7cmdJeu1xOaBbxs115Z9FeP38XZ0lFaFv78STiqRr7mxTg63H9jSHokErbLHqH/
	dBOy+30UNUaQu7atk7aTpaR0lIG1hdSpoX92MhGE9Oj1ECATax1Sg5Kv3ScpzeBxKdxgM48p+z8
	5BLxMUjf4jXdS0qQBFYO1LEhYzCDh/dsnr/45P0gmRp+C7g9BMOn5A0IjYZoNPNggmd115eQRXM
	gtm7En0N8k7d8hFk2+soiPinRAljL6xBrEmRhzEtjooiOxMlzl7wU2Bj/QttTkQP2rYBTs36ykU
	sL9Aaes0ZaG2l4Q+N49czKCJm35EYUoI5WsAHSzsGByo/d/TzliQ2/8lvkqdIvAWdMa/uWf/VJ6
	LV49gxN+X6m/OO6GdueTqc4d8LsEu+R7airz4mnn4WQSZBSBGrMHaLY1Fgr9W54pk28IiTSg3z3
	tdcDtYvcI2RavUfm1oYbyO0uKA8DoyNuJc5stvIPKXRv9mCOTOaEZLaviZ55fJHxvCtu5CNcFk
X-Received: by 2002:a05:6000:4b1c:b0:472:edc7:b4c9 with SMTP id ffacd0b85a97d-472edc7b66cmr8021794f8f.38.1782726037947;
        Mon, 29 Jun 2026 02:40:37 -0700 (PDT)
Received: from localhost.localdomain (94-43-5-44.dsl.utg.ge. [94.43.5.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4726b76e6f8sm17704409f8f.13.2026.06.29.02.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:40:37 -0700 (PDT)
From: Igor Ushakov <sysroot314@gmail.com>
To: stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	Igor Ushakov <sysroot314@gmail.com>
Subject: [PATCH 6.19.y] af_unix: Set gc_in_progress to true in unix_gc().
Date: Mon, 29 Jun 2026 12:39:53 +0300
Message-ID: <20260629093954.195016-4-sysroot314@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,davemloft.net,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269707-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:kuniyu@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:netdev@vger.kernel.org,m:sysroot314@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sysroot314@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sysroot314@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD19E6D85D1

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit d82ba05263c69fa2437fe93e4e561cc40f4c03af ]

Igor Ushakov reported that unix_gc() could run with gc_in_progress
being false if the work is scheduled while running:

  Thread 1         Thread 2                     Thread 3
  --------         --------                     --------
                   unix_schedule_gc()           unix_schedule_gc()
                   `- if (!gc_in_progress)      `- if (!gc_in_progress)
                      |- gc_in_progress = true     |
                      `- queue_work()              |
  unix_gc() <----------------/                     |
  |                                                |- gc_in_progress = true
  ...                                              `- queue_work()
  |                                                       |
  `- gc_in_progress = false                               |
                                                          |
  unix_gc() <---------------------------------------------'
  |
  ... /* gc_in_progress == false */
  |
  `- gc_in_progress = false

unix_peek_fpl() relies on gc_in_progress not to confuse GC
by MSG_PEEK.

Let's set gc_in_progress to true in unix_gc().

Fixes: 8b90a9f819dc ("af_unix: Run GC on only one CPU.")
Reported-by: Igor Ushakov <sysroot314@gmail.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260501073945.1884564-1-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Igor Ushakov <sysroot314@gmail.com>
---
 net/unix/garbage.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index aaa5f5bf51..1d80471387 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -607,6 +607,8 @@ static void unix_gc(struct work_struct *work)
 	struct sk_buff_head hitlist;
 	struct sk_buff *skb;
 
+	WRITE_ONCE(gc_in_progress, true);
+
 	spin_lock(&unix_gc_lock);
 
 	if (unix_graph_state == UNIX_GRAPH_NOT_CYCLIC) {
@@ -649,10 +651,8 @@ void unix_schedule_gc(struct user_struct *user)
 	    READ_ONCE(user->unix_inflight) < UNIX_INFLIGHT_SANE_USER)
 		return;
 
-	if (!READ_ONCE(gc_in_progress)) {
-		WRITE_ONCE(gc_in_progress, true);
+	if (!READ_ONCE(gc_in_progress))
 		queue_work(system_dfl_wq, &unix_gc_work);
-	}
 
 	if (user && READ_ONCE(unix_graph_cyclic_sccs))
 		flush_work(&unix_gc_work);
-- 
2.47.3


