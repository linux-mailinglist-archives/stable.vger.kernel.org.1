Return-Path: <stable+bounces-249700-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FVIAj7VDGqJnAUAu9opvQ
	(envelope-from <stable+bounces-249700-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 23:25:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B105852CA
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 23:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83FE2301B717
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 21:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FE73E7BC2;
	Tue, 19 May 2026 21:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NB8Q9UYc"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACC03B8BDA
	for <stable@vger.kernel.org>; Tue, 19 May 2026 21:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225846; cv=none; b=U4wQFZhdshp4Ekkym7/B2p4NX9rQMY+Ak7EEzgUqYdc8ymc5/Uq6D0ZaQJy7fPJ6imSALx5FSsUnK9Vh61kDqMhfsflZj9noRXXblZd02JH33lMfXSfgdU+JeNwbKTccH/qrdKpxht8OjVhCLlNmOsC/OOEFmzo7gFQ3gtFjePQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225846; c=relaxed/simple;
	bh=XZxRbYNB+p8MYv18ejMQ4A6b45jzlV4FremS2KhPQ9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WAUaDYASl0m9/Cm+MBnEm3pi1RA4M8W4JouMtsBXynxX/lcRcLRiiqBDGKg/Bwf6KgObyQso4y9NofBosYsyHJ2lSJ6ThBgPoWX5SykNC++Xp5bkG5lAhT8Kh7fFkIX8qk1Kp7jGvLLncwczAUn9zN9HIpgq5mUDv5znrKYarag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NB8Q9UYc; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-67b8d9c26bbso9433216a12.2
        for <stable@vger.kernel.org>; Tue, 19 May 2026 14:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779225843; x=1779830643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nPKRLa3wLXnIh4n1MboCUOELValbCWPOOcATx5jo12c=;
        b=NB8Q9UYcygv0OIEymIvT9a6PCp05ij/iH2qfOHDqyLcQUAwGpU5KE9ihFHdoU7jmQm
         a2ro741XH0GBb8gwbJFl8zEZxXze8DwRHdJChKN8ERVo+eyL9qXjld2vY3tKDs85i3Hd
         kuoZjMVJxYYwOxlOEcUWOjBMjSKIwNkQ4T/VJcdge/7otuy6ORASC+Dd+ME8UqH+5yBi
         4Vptnt5JZMPM2ZL9/W9da2MGQmj7H7IIAhtm8dBnq9vZMhIvtQNaxqeCenlkIKVK8ZiH
         clQFhTy+u+KmivMxQzHKzRmypI9pygJcZp/Nkq9rR1lAbfDd5eTSxhhH42ooj4fDLfVh
         iEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779225843; x=1779830643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPKRLa3wLXnIh4n1MboCUOELValbCWPOOcATx5jo12c=;
        b=Kdyq7E6nUpeMvKZMk0S3vxRMpeaJJ8ouROI1D8Z57xaXhEnLGpF4lyGx+8Tvd4itS3
         0qkjsAKojLVwrLKYc3WVUumlLN4VdjTbCWwmjaTogkrA1EY5/XnZXuObB1GmZYFAscaA
         IZcAxELMBl6HUijyYQnolCvjeXOkIDvEKXFTh/aC21CA5q0hHe4a3fMYor2gX4vfhPui
         BFowKTHlU5JtyZKlHE/yyzE0Xi6B8uAz9j200WrXeBNeSHVPltHv4t7TcSwYJ0J5sXXt
         dDtKTMHag03EZyT0XQn89s2lpC7rjQfNtLuTqdTkJ3KEkgl3s40m6LEv/DDRLcvkKZwK
         EH/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+srTVl7Wo91sYn+lx/f0ksrsDCehdGR6rUm3htdTFdbhk5DaQWTzjIA+k1pJ7xE7/QEmr3OtI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypz8Sv26SdUoy9YSGv9lkTB/3eM+6Vt9w7JNr6G+pAwcFTlnIM
	TcCnbA5Ev0wFgolR6K4lH9y6zf8j8cQ8nRxDfWjMvhSNg8H8iqqK8ocX
X-Gm-Gg: Acq92OENTBPpJHRIyycawENeSXmzsojunJCbwNHLpQjnzF3FkKg/697XxlqeUMBaGqv
	VN0rjCohidlKXE0JmV3DKeyAzVaYsEx2H59oWBZYZQBGhqmJg0kr2+wPqjpTQO9mgZyAfr2EnZy
	MxARQWGO9xIEXzRKHy/FHKglqlOVZGMCbg9A967ICLc06JlquoYe9i7n68+VGRR10LcdvjKDwgR
	s/mLMzFgc90twz/+FJnMjnd7hTIkUJfdKygahu7aEkNBsZ0imlVNUhTEF1wP3tkvVGha6Va669F
	U8kbFhUo1jTB6A/+dXnk6o/IEIlMTTOnc9nlmj5M1l2HB7tGZMQU7dkKv+PUfyrzn+f8EnKVy8/
	QTPMY0cGJcXT9jjDBzo42msQY1mKW6ppQU0/nPa7FNjqMYYf5q23n5l61hTyhEaz5YIKsd8DxUm
	kjjJNt2o3BqN82tUs4a7m43YTo/APruZmNfHgU7N2HwYvonuclhUrGEdElXtzLO5D+8JVE7Uv5M
	g==
X-Received: by 2002:a05:6402:1d88:b0:679:223c:d181 with SMTP id 4fb4d7f45d1cf-683bd096b2dmr8279933a12.15.1779225843297;
        Tue, 19 May 2026 14:24:03 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6831187d5f0sm6891416a12.28.2026.05.19.14.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 14:24:02 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] netfilter: nf_conntrack_irc: fix parse_dcc() off-by-one OOB read
Date: Tue, 19 May 2026 17:23:28 -0400
Message-ID: <20260519212328.28290-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[strlen.de,nwl.cc,vger.kernel.org,netfilter.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-249700-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 74B105852CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

parse_dcc() treats data_end as an inclusive end pointer, but its only
caller passes data_limit = ib_ptr + datalen, which points one past the
last valid byte.

The newline search loop iterates while tmp <= data_end, so when no
newline is present, *tmp is read at tmp == data_end, one byte beyond
the region filled by skb_header_pointer().

irc_buffer is kmalloc'd as MAX_SEARCH_SIZE + 1 bytes and datalen is
capped at MAX_SEARCH_SIZE, so the stray read does not fault.  The byte
is uninitialized or stale; if it contains an ASCII digit, simple_strtoul
will consume it and produce a wrong DCC IP or port in the conntrack
expectation.  The extra allocation byte is also a fragile guard: if the
cap or allocation size changes, this becomes a real out-of-bounds read.

Change the loop and its post-loop check to use strict less-than,
consistent with the caller's exclusive-end convention.  Update the
function comment accordingly.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/netfilter/nf_conntrack_irc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nf_conntrack_irc.c b/net/netfilter/nf_conntrack_irc.c
index 522183b9a..9a7b8f622 100644
--- a/net/netfilter/nf_conntrack_irc.c
+++ b/net/netfilter/nf_conntrack_irc.c
@@ -59,7 +59,7 @@ static const char *const dccprotos[] = {
 /* tries to get the ip_addr and port out of a dcc command
  * return value: -1 on failure, 0 on success
  *	data		pointer to first byte of DCC command data
- *	data_end	pointer to last byte of dcc command data
+ *	data_end	one past end of data
  *	ip		returns parsed ip of dcc command
  *	port		returns parsed port of dcc command
  *	ad_beg_p	returns pointer to first byte of addr data
@@ -77,10 +77,10 @@ static int parse_dcc(char *data, const char *data_end, __be32 *ip,
 
 	/* Make sure we have a newline character within the packet boundaries
 	 * because simple_strtoul parses until the first invalid character. */
-	for (tmp = data; tmp <= data_end; tmp++)
+	for (tmp = data; tmp < data_end; tmp++)
 		if (*tmp == '\n')
 			break;
-	if (tmp > data_end || *tmp != '\n')
+	if (tmp >= data_end || *tmp != '\n')
 		return -1;
 
 	*ad_beg_p = data;
-- 
2.54.0


