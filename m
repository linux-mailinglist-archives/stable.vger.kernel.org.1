Return-Path: <stable+bounces-237789-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOl1EPYb3mkNngkAu9opvQ
	(envelope-from <stable+bounces-237789-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:50:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B163F8F4B
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C33C30729DE
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA93C3D7D7B;
	Tue, 14 Apr 2026 10:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuLBPbJZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198A23D6485
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776163450; cv=none; b=R9DTplM54KeJdSMnvJ/ybIOReYv0/aQhs2b2goRMxOmS/jefZIc7rC2ZbvahEWpcjAiM5e3Of2yIBpUCF5I9OXGjP563BdvirbSct2MG6JjsyLlDROu5EVomWbzALsU+1H0w+hfOssfRWRznn5FdID8TrYz3dr887ZmBfAcsp58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776163450; c=relaxed/simple;
	bh=TAGgXc3pQZLrIuJargNIRhmVN3wlW6zwiNEhPvr4UCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWEzLt49VDywl8LIU8nNQOhEJ9V7ox5ruVDjHlSDf3UVjN3x6Yf5KGI59nbNhWgToAPTqHQEPfZg8IpnjRwu8Xsq6cWY/0RvHxBsRCaIHnhe3gdb+tIPBy0wuhe1iCfayhnf/jvbaICfq4PfKsXGsQcb8F9BkoYYmHqJBn8YJjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuLBPbJZ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ad2b375e58so3789975ad.3
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 03:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776163440; x=1776768240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frM77usxFPT3vq9Copj1FbXjZMzdBEqufSu5zj/MX+g=;
        b=KuLBPbJZpobsB4p02ZXpIAi7673iqZo8sz2MX1qh5VoEEA8mu8ttmeUmF6vO9FckKk
         mYjk1wvVRmnrUOz5VLzgYxxUlpHAyXwrkvfRn+9pbJBJTdKvcNaknLEm/Pyu4YLLvFNB
         n4wmixBoxJjdYJDmq6En3oA5wnGEYBUjcw5Kelft45GwAgz+G2lXqZsezCxgGrZ+v/QY
         al8qsnhOsZR9K33E8F4wTQewtyJE3v26mbt7tdW9teHzC0xPFtlgnJQ5MKRJ+DXAMeUa
         3TSlC2VVBequMY0zy/UXYQxr3CYgKphZ4cPZof6Keh2Wchycqjpwbai1zlFR1WIKQt+6
         aDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776163440; x=1776768240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=frM77usxFPT3vq9Copj1FbXjZMzdBEqufSu5zj/MX+g=;
        b=AIZmMPpciwYHbQ36ESDAr9/lIRge9CUY2UmWLNkO+15oibYpIBP0FP0sjUhKjGu76g
         c/t8WV+PfkaH6YcXUXFgwgmXHSn5yTLQEWvCt9lD+ws5srl3NEnC22EUTEnUemAmlstV
         IbjEzQbAbQswPHotTjFRFpI45OGHxHann4pff5pw8OBrIgX7VFhSyDB/X59MbYdfuqjz
         vEA3vynM+ExlSPB4MonnbInc8uqnweoz3UQNKui5TvWYDG8ER0q059bOub6n9JNQ5st1
         u4Fr/K9GFJtPpwdMhGtI71Og2fqrPkKDSuX9dpXevRqe6PUDMRJZqBbPrPWDS9/BvU0P
         hOMg==
X-Forwarded-Encrypted: i=1; AFNElJ/TWYB5EA1nFz38mYlHSulZQz8SoJ3vjm12RO55hMM+dedXu1Q/ZaCB7fBPF16tWNp9tBU9rYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxibMsQBpocpr7xpT7UHGU91d7sLvAox38SPhiMkS8qw/tPIr8z
	yV057ScKg1IV5Pizau61C1d0CuUoETeTg/KbbvU6JE70ldRj8ZzA3TA7
X-Gm-Gg: AeBDiessz3Yp8/yU6u6eJ2W5P34WLJIpcoCEggO/uYGEtw/aZoWCJiQHE2w7W+MCItu
	DDNVEF9Orfe+YqmsSyfrZwSMfCCzy1gJ/LG4oMcL6frqIeS8mgBkaePls/FOysu+QY77Ji2C8BU
	L4Q6vpX6a+rviH/8b4AgFwhI17o/PWKJJDip7N0u2U/M2yTtZqNc5EJGb0b1/jfOqbtrzm/8NaG
	p40h54jUgDFkDoBlokC05dpc8WiQxOc240rlAgSqBiTCx5OJF+0tb+xwGvvDCmJ8jUUcWWNapc/
	F3M3SBcXMsYznCt2NOuZKWyJ1EPwSzABJlVoX4HJL+AOairqcbTwTrPCnkhXXSVfkqLz4ApV1H1
	WEGn424AyV+2lQiuqxDzvF2LEL94qPjm/sX7sn6QybntwdM8ST9Yovu3uBgMP7adUy4Vw/5ULua
	/dQLr1oKDgwqy4XVHR
X-Received: by 2002:a17:903:2d0:b0:2b0:4c89:7b3b with SMTP id d9443c01a7336-2b2d5a3c1afmr100480015ad.4.1776163440033;
        Tue, 14 Apr 2026 03:44:00 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b463cb01afsm48231925ad.25.2026.04.14.03.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:43:59 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Donet Tom <donettom@linux.ibm.com>,
	stable@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v2] mm/memblock: fix off-by-one page leak in reserve_mem_release_by_name()
Date: Tue, 14 Apr 2026 19:43:53 +0900
Message-ID: <20260414104353.989063-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414094439.982853-1-charsyam@gmail.com>
References: <20260414094439.982853-1-charsyam@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,goodmis.org,linux.ibm.com,vger.kernel.org,kvack.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-237789-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charsyam@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4B163F8F4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

free_reserved_area() treats its 'end' argument as exclusive: it aligns
end down via 'end & PAGE_MASK' and iterates with 'pos < end'.

reserve_mem_release_by_name() instead passes 'start + map->size - 1',
which causes the last page of a page-aligned reservation to never be
freed. For a reservation spanning N pages, only N - 1 pages are
released back to the allocator.

Fix it by passing the exclusive end address, 'start + map->size'.

Fixes: 74e2498ccf7b ("mm/memblock: Add reserved memory release function")
Cc: stable@vger.kernel.org
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
Changes in v2:
 - Add Fixes: tag and Cc: stable (per Donet Tom's review).
 - v1: https://lore.kernel.org/lkml/

 mm/memblock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index b3ddfdec7a80..d4a02f1750e9 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2434,7 +2434,7 @@ int reserve_mem_release_by_name(const char *name)
 		return 0;
 
 	start = phys_to_virt(map->start);
-	end = start + map->size - 1;
+	end = start + map->size;
 	snprintf(buf, sizeof(buf), "reserve_mem:%s", name);
 	free_reserved_area(start, end, 0, buf);
 	map->size = 0;
-- 
2.43.0


