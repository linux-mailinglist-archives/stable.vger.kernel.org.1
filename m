Return-Path: <stable+bounces-269708-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LMavJSg+QmpM2gkAu9opvQ
	(envelope-from <stable+bounces-269708-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 11:43:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 189AC6D85F7
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 11:43:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QuYrwq2B;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269708-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-269708-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EBBB3021993
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 09:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A463FC5C0;
	Mon, 29 Jun 2026 09:40:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDD83FBEC9
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 09:40:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726042; cv=none; b=XS2SjRRBfl/ms54ScHNZ8jkxpVbCw/frcrqTmuriyC+af6/B6zL4ChhkBuhAFRWhDKTC2f//PQLW/RCNGmGoLDaCrO42ysiQMajp8njqoNDjVe2tMPcjQOZ+9e17nzBvQWQz++TsTcreS0JbpYPo6cfUVYXoPktIueaiLTavbSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726042; c=relaxed/simple;
	bh=8cXXYRaiyjJPLXvVw0UbzVYBi4+9eRvchLF+g/NND14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BxJZAGbDJkjFHJZW1wB3suVk+XF2TSKcCsaB8d4UHyIcyl/ecIbv0rl85oXWqikl5VrvKHYoddOd0midgRfE95DDL1ioTNnGSQn3ciDaaZ6kirHjFmA1gqzPjkXjKIXyx/QdQMBsXS6qwwMEmXJIB8GdX0h+RNhqgtetLGI0A3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuYrwq2B; arc=none smtp.client-ip=209.85.221.50
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-472326ca506so570176f8f.2
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 02:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782726039; x=1783330839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S/3m0Eg/3cv1JDeg8JL7bESj/VyOJCgzktlC99yUrDw=;
        b=QuYrwq2B0IQ69a6O0N/cZB6qh+nrrgRX+d1lMcgtTouZXg98wAnAPKFKswREZfI/WT
         gDYN+jh3ixMpjhcs4ugva4B8wV5iBaJD4VI+GrQ7qexyAP4Zs0Jbi2DexTsUML4RydV0
         LvXxB0QXSpfES5YCkC4BIlyz7RRiXe/4HhqrPfrm8+ecvwvWgLmR/wNvwtuR2MhLQRkU
         SsWqGXJR9jWVjB171bkPzy4B/aM/aiWjxQBs0uZPu8K/8l+h6SBKZhP1iGxvTKztQm77
         C8Gpq75tE49coqUp9oVHbjZUGuzJW43a9/hKiTmBY1pkXuQR5c4jaJvTaEVGCTHLJ+HY
         hUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782726039; x=1783330839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/3m0Eg/3cv1JDeg8JL7bESj/VyOJCgzktlC99yUrDw=;
        b=CJul5/eVzHfnmGr2xmke7+j9us7jujt1xcCSA3MCUUh9kWAuTsHn1YccRXlLxSRaZ6
         J9AMrzHrpTvbOeeb6JNHZRo612x6y6TxxHyCMjxTeX5RGKBntH57kgJdPiNOeShAyEJ8
         eu8LLQbVrsScDT8IUgLnpS4OvFug+4rgvjJtLty09D7m9IzSXLUD1j57qEL96hQtqB+/
         5PGXnVQH+lzoI+hhEI55YPDxIr4hCzjEVdRJbssh1pHxsDIRoGDa3dpF4zXS8JuqfU/5
         pmmSMbJ/P3UaPV+opBbfqJYLg7f0/hbYE/EPNjRSXPDkAZvBukOPNhENcvpslYdzZIQa
         KGcg==
X-Gm-Message-State: AOJu0YyHylYTyFAB6dFJNPmz67oZVD3BYT+Ve/YwQIsUjSed+hSwWj71
	OqOGiOcr4JDfOb4Oka4PyAhrHczdsimYZS5QOheVKReYkQiz0yMTEJevN/hq/I8nbYA=
X-Gm-Gg: AfdE7clQKE11BEEkYLEG7tr1rdM4f4WvP/T4PFjhujQ3lEa+FzNlztedfcalFyM0lxE
	WEud2bViNiunhLlk0qQjGkmD93PTwHYv8q3XarYvB0PO/Bu47pZRj02RReOJRxcWamTFAi8bGAC
	G5t5NU9q3jU1AtPqbv3u7Lz4JQ7cps7Fw+1/iuWAcXGbqcnYIPgCqqCSDrgpDBvzPUQPK6R25LZ
	jYDh7fyz9URhnDotNTyd/rgJS/I2U00do9/ksmf2pzw66/sTv6njSuO2aCv09RZyjckgmAkwtgW
	+dKZBHt/FDvlrnAToToaLfk7YlLLu1vJybaCY0GAdQVXP1AkOXB7bGS3msRl+ugX0MI0ykYjBr7
	ZAcJLOO6W1/eXQgH5GG9ssd+ltJ57V+oE4TZz6JjZ/1KqNmWBfCZfemmk313DlKHPa5fobHwmmp
	d0jGaqSdtFXQlHtWodGiEn+NkI8SvfhPYZefcL6MxG7IgEMlQtu6X3ecqx7hpKD3utsqwa7JrH
X-Received: by 2002:a5d:6e54:0:b0:46f:558:a43e with SMTP id ffacd0b85a97d-46fb6bf2e92mr12608972f8f.9.1782726039399;
        Mon, 29 Jun 2026 02:40:39 -0700 (PDT)
Received: from localhost.localdomain (94-43-5-44.dsl.utg.ge. [94.43.5.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4726b76e6f8sm17704409f8f.13.2026.06.29.02.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:40:39 -0700 (PDT)
From: Igor Ushakov <sysroot314@gmail.com>
To: stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	Igor Ushakov <sysroot314@gmail.com>
Subject: [PATCH 7.0.y] af_unix: Set gc_in_progress to true in unix_gc().
Date: Mon, 29 Jun 2026 12:39:54 +0300
Message-ID: <20260629093954.195016-5-sysroot314@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-269708-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 189AC6D85F7

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
index a7967a3458..0783555e25 100644
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


