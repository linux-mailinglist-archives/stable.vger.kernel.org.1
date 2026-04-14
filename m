Return-Path: <stable+bounces-237787-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPUGF7Ib3mmFnAkAu9opvQ
	(envelope-from <stable+bounces-237787-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:49:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1B53F8F2E
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3E44301C894
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEAA3D75C3;
	Tue, 14 Apr 2026 10:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ia/V96ZD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3373D6471
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776163372; cv=none; b=KiZgjYiWvj/9THjUiJ+/20uZBjfqlfyLbjXwjQon42nt10IvnM6OlnEg3oXNsVlPqYk6UYfNn/cJa5AuH5rZd5IEOwjdAfl5noWwwAH7Fs0Xbzjxc0Kue0myE2d1xlnOxKtl+De5LmOhRvxDEUXtZLZ7ud6mNlCAjFs3t02O+7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776163372; c=relaxed/simple;
	bh=TAGgXc3pQZLrIuJargNIRhmVN3wlW6zwiNEhPvr4UCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KiG1RBk/crpbWgXO0BBafMRci0aMBHm/Lrbjqv6V3wc+SuXyYIiKaGCzn97t7Ke9CYo5ek0IHk1AC8Xu1jPRYO0RtWlzG6BIG5R+CI0+TGe6lGPBsNTk6Vk5UixTCt4cpzqBmUb8ncqDb9mcwWjFcHVCfGX6bwfIk7Wd0XGd7fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ia/V96ZD; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35fb262f92cso311618a91.2
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 03:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776163366; x=1776768166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frM77usxFPT3vq9Copj1FbXjZMzdBEqufSu5zj/MX+g=;
        b=ia/V96ZDcODqMAi3CHDqCicH26omWIlmY/F2K5lfi251TRtGPv/Os6n4YUT77QVkcA
         4797dOgkurZZKDOFKhGhDTumSra9jpyi+7Sq1jBUdgZDDp9VpRlhyfWfqU39H7e/o8w8
         Q4o+bcVBKazi5CAm0bft9hJlxPHUBNq/8WCLvQzlufzNgCEnVdV6Ff+ERdXXO96ktmnm
         Iut+pz+hp+CvrqjwAH2+qfFdrizKrsPtQuMM0vpjIPIVVhGoYjZ5Hbbb8P9Pqb0mrE6p
         YGqQl18kHjf5DkGbMIxHYVqIExXbPZ3pEVxxw2/5hFmlxS7lJqA5FQt4euSktyb1yYAw
         0nIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776163366; x=1776768166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=frM77usxFPT3vq9Copj1FbXjZMzdBEqufSu5zj/MX+g=;
        b=mJWql1GLbQuVFhu1aBrG4cwoeH0gS9/q9sqMgWhNtfzwhK4q3Y13QogdjsAiHJLUKA
         5oKyxjsWx/7mvjUb1SVIK+PP3r8Dg6l3c9TES6y3hxreWqcvFYAmtHVTKjaHZga8XYeG
         vamlk/Zm5tDkbjMZbefPbD4cCOAtnP0HkEf81idVa4OBYN6wch5eV3+GM+VK5yAq9bo2
         5AY7w+VAj6jhsQzlCSALuz44xs9u0HeQopUZq8AONtvcea0erbV7aBDwsiC85+ZmibIw
         l/W9SYc8I7DrxklHCPz9t2bCbu3c/hUgNcY7TqWbGz9IPMfyIIYxkJ5upSyAcoCUTd82
         /niQ==
X-Forwarded-Encrypted: i=1; AFNElJ/rD94xOaF8sgZ42TiZFfkDV4DT8b3LBZn7gDOzEKimA2SXhD2hiTvyx1Y99wAPPz/IA0v+9LQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuDJRIvyftnczuIVVvfrHyd07W/TUVcUBopO7L1yBR029PLbTF
	MmmnZQLPYaxx3BUz59kooEQo76c7At7nVt+YDqd83vXUyp2za3idJopD
X-Gm-Gg: AeBDieu3y17HoHEfqKJ3cYL/8u9y9juW8EpzBQGm/uLGn3AlvF3/fCyHWHA46OctTai
	JZuvRwPtmWb9TgVXwrU38dnWy9oiokxc1eqAcfz2YS6a0ntelCKllGx/6oFS79llzSvEu23H65S
	QQYUt9na46nZcGg3Xgxu9kFcRBPS0axQL40NxW8hHkj6x6fCghIIk40v7ONWIVX7dI29b38+fn1
	FXwBmNjYMONKNKRweXCkyE01I88BT79ARFOrOs4Wj7D0xzkaCJ4KcjqGG9wJkDsjn9lkfDSBKwg
	wJNL63v8bpfcB7K0p71oal0Lw2a10nyXAUgmqimVA807jB5WDDJ8SNZKRgZ6uQcdeuWxBxLSMlf
	vGNeQdM19G7/o0dhI/8BEksx89sQuA3DA3MYeSFlUYaEBPWjYKK0vUbDU5kcVnYd8TO4VX0gzTg
	CbLzOjabG5BrEi+A85
X-Received: by 2002:a17:90b:3f45:b0:359:fe72:3555 with SMTP id 98e67ed59e1d1-35e427a9adcmr9590032a91.2.1776163365783;
        Tue, 14 Apr 2026 03:42:45 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7921a12adasm12179185a12.26.2026.04.14.03.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:42:45 -0700 (PDT)
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
Date: Tue, 14 Apr 2026 19:42:36 +0900
Message-ID: <20260414104236.988942-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <V1-MESSAGE-ID>
References: <V1-MESSAGE-ID>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,goodmis.org,linux.ibm.com,vger.kernel.org,kvack.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-237787-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB1B53F8F2E
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


