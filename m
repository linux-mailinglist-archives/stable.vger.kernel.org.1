Return-Path: <stable+bounces-269706-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QYJCKPs9Qmo82gkAu9opvQ
	(envelope-from <stable+bounces-269706-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 11:42:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 102836D85BB
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 11:42:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=coblmMZ0;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269706-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-269706-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0840303077F
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 09:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29A23ED3A7;
	Mon, 29 Jun 2026 09:40:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2067E3FAE0D
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 09:40:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726039; cv=none; b=HDP9yz4QDeMx5WqXiViwGDyJOR9qWU1HSMGIJhmrAOKLVWWYmQz6PlkH9ffBmbJbFabliv2gzhXjoc6eJBmgbF7yZ5ulF4H9iw48+y51LvCsQKXw0d2jQOQ0IdMT8WeFJ4tx07QBTI0FKMyDj2Su1eXXYhDXia/SPYZBYrPLtZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726039; c=relaxed/simple;
	bh=qbYNsnpGajxUvoWvZ9Gf+3+VhKKvHnOwjSRy9C17bsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mosLUmA9eFoPZ3VEGCWiTbH/Slac6hDdBoV/LE6GgApBxj/+R8XK6P6XUiov1uxNPFIJ6AlsLvBMIM6jrshp+VD8QBmdTdX8dfarTGhA9xEQu8xESjXOMQN/9UIrVUgJoLVMRyvDRFWBKksC97hUazMAGzI5zw2ha83cQad0yRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coblmMZ0; arc=none smtp.client-ip=209.85.221.42
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-474560436c3so359052f8f.0
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 02:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782726036; x=1783330836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/tlblPullUUOZj5HMHBD9SnBztd9AJIPot7pnx1VqU=;
        b=coblmMZ0RZ4nqrEB1JXLvFRriTFmuTZLuXUwWh5hb+n1HXFD+/j/ZQk0XTzRqy+KUA
         0h9DrIJvzjRmP7I92H2JVUkcWuPBlxIE1XvW4FO5zB2QQN2+lJpwu1EBO93nD0159Nzw
         2Cjlkc993mWbdW4vUp37AAPEnurb2JN3JjTfsOHjtalnA08Su9buX3uK2Lobyy6LBdqF
         Mr5dt5bD1+8ITq5ESOWRLRYdi1AfxrK13dacqZgltz+EAi88kMjaHcp0QQt7m2vQemtD
         CCyrlyhx+M9O430cvyM27az1pke6sG0b7kfaY0NygGkQSsKE6rBEGThI+coSliw0LTuw
         uwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782726036; x=1783330836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/tlblPullUUOZj5HMHBD9SnBztd9AJIPot7pnx1VqU=;
        b=hkENrvQZuURklSmkbvyJYnSVkSHPJ5NyWZEVdjlXQFYv+Nq2lkzWKAcTh9LOgN8DQv
         xBI6ThfLvOCnqsSIM0dN5ZzkQ5fpjnpQLZDDId8PjRtTHwglDGRrXyhgQaU6MvxH6C1M
         jxdD7MUTKnBotuuIt2j3To6JlTuV0l6PHld+ixid5YDdwFQnuE6EIC2ZbESnijBNpzqG
         4wIcbUKKbpG1XQM5OnZKqKsKbW44R24cE3Jmd3czGJTw996zMMGQq3Tr5bO69bniWcN+
         hsR/BKHm0so/7iF0s5Jx1O3M7v4CpAZQ+EYYcFRg8cqwYletkdXZPpRoRs+jy5mzLMZu
         1kIQ==
X-Gm-Message-State: AOJu0YzeVOhhQ3/lq3JEFwMC/3hJS3KjgTlEIlfwfFXzGDW4XxMYHE0U
	NX6Vp2jsY9bI4i0UiVd7MahK8HV5NSU4y2zJidiU3uM8PYeA3854NWVY12olJXrq5Sk=
X-Gm-Gg: AfdE7cl8xt+F2elA8Utk2kcfbbBqrD6ryE9eLK1/ZeWOvsZFu5wznK+QOvxUirtrJdk
	5eogZ7c/jiWHiO4JJbfwrSwxnO88EZO9pC/s95Acfs2C7WNJMpKKGz3ocR0j6j3OJXp7C/JVV1j
	ea++LRWg/3X2rOIe2mFI/qwHSb81aDBljvlZ49Tlo5Dh2L07q8nVunpGjkNTmsD6jNsXdvs0QPx
	kudpGQPOLKn6ZyzO9UJgDO8wkacJIZvanfArOvB5FNxNNb6aLqtyCdaBdhvdLnv/GYilAitVdM5
	JgW3C7ZDcHqXDch5ZHptyGtHvq7thqCvM8SQJHls73gusl/yfSp7X15nwWIp3BOs8sD5RTQB9ep
	uW9QoecdFceTGs3FfVU6j8Gi83O8l9WC0lWHbC0S30reaUusQyq/S4Z+ulLlS6HePh+dHOZXo8B
	S6YAgSITsoe1u2lnndVX4jQ/vclVEivYrhXdVlRz/PA0UkpA58ObOGy2uWkS14Vw4qC34aqPKn
X-Received: by 2002:a05:6000:4816:b0:472:55a:ef9c with SMTP id ffacd0b85a97d-472055af3ebmr10195520f8f.9.1782726036427;
        Mon, 29 Jun 2026 02:40:36 -0700 (PDT)
Received: from localhost.localdomain (94-43-5-44.dsl.utg.ge. [94.43.5.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4726b76e6f8sm17704409f8f.13.2026.06.29.02.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:40:36 -0700 (PDT)
From: Igor Ushakov <sysroot314@gmail.com>
To: stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	Igor Ushakov <sysroot314@gmail.com>
Subject: [PATCH 6.18.y] af_unix: Set gc_in_progress to true in unix_gc().
Date: Mon, 29 Jun 2026 12:39:52 +0300
Message-ID: <20260629093954.195016-3-sysroot314@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-269706-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 102836D85BB

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
[ move WRITE_ONCE(gc_in_progress, true) into the __unix_gc() work function and drop it from unix_gc(). ]
Signed-off-by: Igor Ushakov <sysroot314@gmail.com>
---
 net/unix/garbage.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 529b21d043..a3ac2695e5 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -606,6 +606,8 @@ static void __unix_gc(struct work_struct *work)
 	struct sk_buff_head hitlist;
 	struct sk_buff *skb;
 
+	WRITE_ONCE(gc_in_progress, true);
+
 	spin_lock(&unix_gc_lock);
 
 	if (unix_graph_state == UNIX_GRAPH_NOT_CYCLIC) {
@@ -636,7 +638,6 @@ static DECLARE_WORK(unix_gc_work, __unix_gc);
 
 void unix_gc(void)
 {
-	WRITE_ONCE(gc_in_progress, true);
 	queue_work(system_dfl_wq, &unix_gc_work);
 }
 
-- 
2.47.3


