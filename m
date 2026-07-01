Return-Path: <stable+bounces-270106-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oXF5OiC2RGplzQoAu9opvQ
	(envelope-from <stable+bounces-270106-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 08:39:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CAB6EA47B
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 08:39:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=EuxziFIJ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270106-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270106-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 26F283036B27
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 06:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3373AF676;
	Wed,  1 Jul 2026 06:39:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235EA2DB78C
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 06:39:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782887961; cv=none; b=FFp3qm3jqy/I998KfnxUvXwFHRF+iSbDEFkiQH5etY1H4iOh6l09xb93TmUXmyq4CyR8TDw7igO7MhRk/6qyWi4AaUFbXB7RATT3o+uVLkU+nKNeg2qP9mhhN2L8Zp3sUWrrButQ6R8ktVondjUmkffKtPiZWSm+y2g8Htt/BZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782887961; c=relaxed/simple;
	bh=c3UXkmSf/U+KQu2LbfQINtMaYbmZc76jB9bbaDgnsC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utDo+wdQq4hkj1ZtamVY2KCqQn/GpIsWAuBsNaR0RI++gYC7YgoRRGHiztnubG4MeZ5D+ftGXnV6VmEaI1V4TKn/n6sl2OjfoIOOckIAi2N2vX4XMGgekdjrLYKvlY+R48DvwIhNu7V/ueOxEXhk6v2yDaYSRp5KTxRkKewDTt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuxziFIJ; arc=none smtp.client-ip=209.85.221.54
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-474e7ba9fd6so131353f8f.1
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 23:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782887957; x=1783492757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9lS47Kg6rDUlabcBxfm0AD8NjNyWC3LZqIIiOY+ZJo=;
        b=EuxziFIJv5R/EkQllUWaovqol6oj4qfkobLr0ujMtxhcZF93swOGZeEokU3Dp8qJLI
         d5Q4D/eJB5LD1rVz89LiJBY6DwE9lDPCqwqYUyhmt7BkTml4dWx9yz/kKzC2MxLrPfUE
         1LvsjFIRjVWKbbhgR89YeHPlgSuZiKy4XVbMsiq5pzOOC609AnUYqstX68IqQz/MRqCn
         m3bCVawOXu0QJ78R32CehmIoZ8lvjALxT7p22s0srun1AttdQQIjV0N/aV377ekTyjyw
         QGsPFA46IezdtmW1JeSLkAaUD0Sl+jRQ3a7qWove72lDwf+sIQFQep/X9Koodio/f/rN
         P79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782887957; x=1783492757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L9lS47Kg6rDUlabcBxfm0AD8NjNyWC3LZqIIiOY+ZJo=;
        b=b2zJpwDPAsgu43H4UJqGJXNCPfWC7RRC93AAW6Hax0zrOMBT9t/M9goYlynN7WH9H5
         cRqzkFsB7P/Crf7l7823kZvxNhkwM5iHYJlV/e6ikuQUZHl088IKjMkYbkiVlOUSX79z
         6O58KCUAnVRJ/8GIfqChklvfjbluqzrxmoCovjyc/p3uDABVVubtFmNJgeewILhwB4NZ
         A+C2XPKSfbMKgsyPqdGlIhqnZn1FyoNsEKclHvGLiUUvGm+NcmutkxdHA0cyHYWBtwna
         AVfng51ZPYE7nYoqln3/PSNnslaUqrMxFUQeOC3iZ+hINCnY99QOt0rZ8YqtUrsTAetD
         dh8A==
X-Forwarded-Encrypted: i=1; AFNElJ+8Wa4Ms+b+FwNVphup5f+ILwE9hJqebjf0FcNurcAANKxJhVMqlA0upU/LfueqfwE2LC6uv3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD+PRrmaR3dhsZ5MHIN2UiStua97yi4OjqtCDkJremBWHcZt+Z
	g5/qIvpj589ZP7yOigyQU22tsu9/BRkv3Ep/8heMWNh6qF7gqxNz2YKI
X-Gm-Gg: AfdE7cnvsm350hDScekOk2EilI1FyohgErOsDVUy8PfY5MbLctvZa0biyLMnqLthUGC
	k/9YnLZ8m76kslJYVKY/SszGR8HH7xK/GvaqxT8RtpCtKjMLJ1IY3p0lY6O/lEQPw6OMzl2ujm9
	OBKk42Srd9dxmGz9+ZpeENDIRJ7FAgRXXTAqk5uEdTAQ5yPSHLrCuFt6i3bqdZufbkvPrMYuea2
	2veWta+xvvMt6tWMsJb5II1852ahpJdSU8FZY+iAo6D/tZKMjzvf6gV4YbfTbjc6fnundutMiLr
	LjhBMJvSo1B03Yqzi84xyPzMBIX5pWxoStMUXpQPpu7728dCOxIUMXregNOd6bf2Uhdt6H/RFJk
	TJsD/iNLFkv4XE0qE7rBhwRQ7ohBpsV6OqUmzTC+qwb8i3Id6iu/xSiM7984DRNtRgOhbutnsiw
	aZ5R0ux2gzgGp/aL3sxLIb6cbrW3tLYg4MmLwIMzIOfdQkshyqMa8YMna6u4Xx0g/hm10Cq2b/
X-Received: by 2002:a05:600d:6409:20b0:493:c21a:11f9 with SMTP id 5b1f17b1804b1-493c2b38eddmr3043765e9.6.1782887957236;
        Tue, 30 Jun 2026 23:39:17 -0700 (PDT)
Received: from localhost.localdomain (94-43-5-44.dsl.utg.ge. [94.43.5.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4bfd47sm70551775e9.2.2026.06.30.23.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 23:39:16 -0700 (PDT)
From: Igor Ushakov <sysroot314@gmail.com>
To: sashal@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	kuniyu@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	sysroot314@gmail.com
Subject: [PATCH v2 6.6.y/6.12.y/6.18.y] af_unix: Set gc_in_progress to true in unix_gc().
Date: Wed,  1 Jul 2026 09:39:00 +0300
Message-ID: <20260701063900.280980-1-sysroot314@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <stable-reply-item009-af-unix-gc-20260630181642@kernel.org>
References: <stable-reply-item009-af-unix-gc-20260630181642@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270106-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,vger.kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[sysroot314@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:stable@vger.kernel.org,m:sysroot314@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sysroot314@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85CAB6EA47B

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
[ Add setting gc_in_progress in __unix_gc(). Keep the existing
  set in unix_gc() for wait_for_unix_gc() over-limit throttling. ]
Signed-off-by: Igor Ushakov <sysroot314@gmail.com>
---
 net/unix/garbage.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 1cdb54c616..fa6983dc31 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -583,6 +583,8 @@ static void __unix_gc(struct work_struct *work)
 	struct sk_buff_head hitlist;
 	struct sk_buff *skb;
 
+	WRITE_ONCE(gc_in_progress, true);
+
 	spin_lock(&unix_gc_lock);
 
 	if (!unix_graph_maybe_cyclic) {
-- 
2.47.3


