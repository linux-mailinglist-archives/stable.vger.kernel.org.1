Return-Path: <stable+bounces-249756-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIokMO1QDWqgvwUAu9opvQ
	(envelope-from <stable+bounces-249756-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 08:13:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 209CC5880A9
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 08:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4387A3057760
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 06:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8882F691D;
	Wed, 20 May 2026 06:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="k0bzJuMJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0B8371D10
	for <stable@vger.kernel.org>; Wed, 20 May 2026 06:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779257443; cv=none; b=CiTTbdzU5x0cDUhUh2d9PaU19GY++d/srk6BIQAlib0Oc/tZ4uXo6FbG7dOEaZF6QpYeize24RMSPvgsIrquQY5fHUeP9pWSGTebshcedj/tp0KUYzTL01zj1Jac9zeakAnthS6x9hk23w/UD292ID0lGiRqq8XLzOVfiZkWFPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779257443; c=relaxed/simple;
	bh=fFYQJipjM3WwkoLgwB541hy+4ODEPwuCXTJWH8gDdKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X3JsuUMnKn/yEbHgHsoQgwyBQDTCZsBVzBJ86QrPwd0zC57LYOy8aiKiH2g6+bgxL+EKddXRdkUtWh8Nwbdtr36prCbFChdmTz+SMUJQZw37f6z0d06P5GmK1MzJtnFcgU8/ZLnNejdITywyhkiPtaP+gB8Bo5h7g8sp8og1qWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=k0bzJuMJ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-83ef1d17904so4384963b3a.1
        for <stable@vger.kernel.org>; Tue, 19 May 2026 23:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1779257440; x=1779862240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LW0VfZXiprYSkuoGkQTwqFtv8G4oHaP68qS1kw1Altg=;
        b=k0bzJuMJ81yyd+euiNT5NkKpx8Je+p3hkIqCTor/gocisrY8/iSS1LzLUJ8heuQErU
         QxyrTFlkGgbQ13U37Y3yCLnT+ajgTzCwT2X0lD+WoetpDaVEf/nBhzVS55Ridt8XQlY/
         qlSRE5wQKApuTzLQYLwTfuqWHKHrJJn8GIFWDFZYtwgDXMaQGQFwxgJ0e16KKTwrmGpq
         DIhvRiJEpwejq1uPUHEZEQov/n+IRUSS3qaxG5TEdRSjIMrY2Bo1hHBQEcC1YqRC8np7
         Fvd1/PV8+WWwgwzeWxImQUtBQuixQkXd2NLcYM6JqeU+WF//GN06ZE1CqwtQ6DRsLzKg
         u6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779257440; x=1779862240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LW0VfZXiprYSkuoGkQTwqFtv8G4oHaP68qS1kw1Altg=;
        b=an/WlyCW+OLE9IjH7YhDsELTv6KXgVTiotpNsSW5qL+HTvOzucbf7a6LfVruSshkh9
         P9a0lYjv2yQXmy6xSolTk7x12fxPMKjwRPZ5zswQg2/Rj148IGFp1wyBS5Rb7f8wkG0Q
         w5y32Hi1OCPe2rlBoGzFkbwYCPenCNrS10ZT3vqUUBDLodqWfqyTiAHNzlzN+KbaqXrF
         frxBugwmVrqlIu66sLzaCNq5+fucZSY7B5HlbZpEdBK9BQQwQXZ/zgebC6Ef5zmbHuVL
         KwY7NEMLARDpUdYOGs14sk74bhBbd6eW8YU0QqF2Jl/7ampDH6vWU96t5QuWoheDvAZH
         ExSw==
X-Forwarded-Encrypted: i=1; AFNElJ/FLFv/TheiPaxwxCNdZva1v47masuv+wxLbEGXDtLWzspdJfZwMANHDP+6p7rolpiz18EWgLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEMsP352pwUUYnUoV4fUsEHrjLnPgHWumXcEJiJtj+0NIj7aUE
	BU0lfZ2cYmkH0Ek5kBPKnPtCdAevTYZU4pUl0kdulS72+udICjSOf5M8a61iUrBc+0g=
X-Gm-Gg: Acq92OFNHbL6D4fWP/m0YVck+cMt8ymAS01dixowFOrxuPJNFtObcxvNLUS1HCxjStQ
	AHOL2yZBX09EtF1++fUGcGq/G5v4vQaNdtKtaUUvZVllthPpvoyDyezbrAf3xkoS5a50EVxZSz5
	vn0RFzMseWbal10qms0retirZ9Kgm1ZFTvWDOq886TwvbAMNPdKfwc54Kscs+a+kkrL6OsctbeI
	iVWqe2sG7We1xHHFsUlEvX7qODDQS/VvMJY82UGzEPXlMiSlWiQqa9byd+mphmpq5zmL1uPr/m/
	SFXcz8m/AqdAcrEeDbzkXoaqhKX39mUREC8mFJ+WKkhn4uP2QjRTGNLbo5dce8mbUZ44KBfWqj8
	l1oCx0OkQZdtH74crgvYvuwKe9bIB7rE6+9RTefJijK9LsayNMzrthgkRFDOHUfC3wyf0UzV8Zm
	zQUGS8YfVxllMwUJvDAAhPAz9du+CHCl7m55u1aZyi7r0CckGWS4RiNJw=
X-Received: by 2002:a05:6a00:2908:b0:82a:6461:6d15 with SMTP id d2e1a72fcca58-83f33f166f9mr23571904b3a.46.1779257440250;
        Tue, 19 May 2026 23:10:40 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c78844sm19049950b3a.47.2026.05.19.23.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 23:10:39 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	linux-mm@kvack.org
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Frank van der Linden <fvdl@google.com>,
	Stefan Strogin <stefan.strogin@gmail.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Michal Nazarewicz <mina86@mina86.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	muchun.song@linux.dev
Subject: [PATCH] mm/cma_debug: fix invalid accesses for inactive CMA areas
Date: Wed, 20 May 2026 14:10:25 +0800
Message-ID: <20260520061025.3971821-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,google.com,suse.com,gmail.com,mina86.com,vger.kernel.org,bytedance.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249756-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[songmuchun@bytedance.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bytedance.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bytedance.com:email,bytedance.com:mid,bytedance.com:dkim]
X-Rspamd-Queue-Id: 209CC5880A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cma_activate_area() can fail after allocating range bitmaps. Its cleanup
path frees those bitmaps, but only clears cma->count and
cma->available_count. It leaves cma->nranges and each range's count in
place, so cma_debugfs_init() can still register debugfs files for an area
that never activated successfully.

That exposes two problems. Reading the bitmap file can make debugfs walk a
freed range bitmap and trigger an invalid memory access. Reading maxchunk
can also take cma->lock even though that lock is initialized only on the
successful activation path.

Fix this by creating debugfs entries only for CMA areas that reached
CMA_ACTIVATED.

Fixes: c009da4258f9 ("mm, cma: support multiple contiguous ranges, if requested")
Fixes: 2e32b947606d ("mm: cma: add functions to get region pages counters")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/cma_debug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/cma_debug.c b/mm/cma_debug.c
index 5ae38f5abbcc..523ba4a0f9f7 100644
--- a/mm/cma_debug.c
+++ b/mm/cma_debug.c
@@ -205,7 +205,8 @@ static int __init cma_debugfs_init(void)
 	cma_debugfs_root = debugfs_create_dir("cma", NULL);
 
 	for (i = 0; i < cma_area_count; i++)
-		cma_debugfs_add_one(&cma_areas[i], cma_debugfs_root);
+		if (test_bit(CMA_ACTIVATED, &cma_areas[i].flags))
+			cma_debugfs_add_one(&cma_areas[i], cma_debugfs_root);
 
 	return 0;
 }

base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
-- 
2.54.0


