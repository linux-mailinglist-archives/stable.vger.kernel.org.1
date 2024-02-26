Return-Path: <stable+bounces-23775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 723F7868382
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 23:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C281F288F85
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 22:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C178131E35;
	Mon, 26 Feb 2024 22:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SicHMBYB"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616ED1EA72
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 22:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708985814; cv=none; b=sUXL4f2t4mUoYes7cZEgJWTAELZnOiLy2MR6USutpuEdPgjIFyZCWavwdW3C3cbe4zs++7JFEWldKAUPTaMJQ/s/V5OwfJYwBPXp90UYqv/7hxrkDRa4UWp4y2zjHddMOFPTMHJ4YVYj2S70c8pimS1B5F7xNMNjOM1NAV2X9Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708985814; c=relaxed/simple;
	bh=O9Flt3Kgh50CgCAL4aYxnfWjXED1JqRUHO6DBRA/MxE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BwcfJi8fKdn8ykMXqoqpWALjTF7oQ3XGfgszCdutb3ENi6Cqt/i2QpJwpbc4WuROTxEU2t7+eMlFPW6HxCr93WW8H6ONtV9X5aQcUI58und5/M7MUF1jl3VmucwUbQ1q9FDFS+ttH1+Hgmljo15x6EwLzkOlECHq5J+G+Ixr8nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SicHMBYB; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608ab197437so57677547b3.1
        for <stable@vger.kernel.org>; Mon, 26 Feb 2024 14:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708985811; x=1709590611; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s7ObyCSycr8q8L12tDaq8/I6+rCz74bMVTcxWuZq8Dc=;
        b=SicHMBYBp6dYA62D9X7e0HOZRI5JeAgsS0P+YtBk7YvI2uRQmXUfZOcIikTAWoKvTx
         Y0riEFuPKj2YnoVpEL5FUkic+f6KmfOdpYZ5mjKPxEB8WmRoBQNd7Dp7tuLhaKu0WLtN
         hXS38iG9Z20NSVKOWpNEnpPvURtqhiZE6z0DLBfkzhsLidoYGhvu6IR8HVBQm3fiLq4x
         MAHaw0E/L6PIdHJCK4rBOa7LtOSDxtATV2qF0KStTQDVyXz3961m7JtRXkkCgHwpojhz
         hAVkXlgx9vJmO0dSjuKrExTmcDriKO5C7ge12QFfIXhF11AH9r+bbcxdh2PdtTeRwXV7
         J9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708985811; x=1709590611;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s7ObyCSycr8q8L12tDaq8/I6+rCz74bMVTcxWuZq8Dc=;
        b=hwd5B9EZULuYYrIGo7EL2NGsePlEraLVW4aiX6Vb6j9djVYkY5NEkZUSZ6O22HcXEm
         yuQ3Zl1xSVlEExxYrNPwHi/YU6L7dtpaZJcv2RTIMciDSswS14ugxMT0WwoRX/9bIOzp
         r8TkBoePEcgRd6dMponvDYhADdpw6oiWmO4UhUoK4joU0YpXOKJF8ynnV25knDWfm2vr
         42SXWxvrGpRk3oi7WJfJAJrZcxKGzM3ZzopgFYxTIySfACrcL6DbHXIXRedG09UF+QR1
         VBt3NiVZs+7aMdgF3FwEr64bo/MK/Ide7GamoBCIUXhrHRV2F+jbC1udJFpk7X0IMyh+
         mkQQ==
X-Gm-Message-State: AOJu0Yz4I/F6lL88Q+oreeEEBKcUBAydZn0xZvBpLXac95QqRN9/0Ezt
	0L/8D93J9sjSn57N1kmE3j7C+vxoUVp97hv5dGNkqlu+JXgD1yEswla6CyLxA5feV95rIrr43Lv
	ssNwWGyqV7UxjOI7gh5geYgeinZV4WvEMp2Rh8jPEpf4hRWdzQ9z1Wl8b202AQirxxb3utzu9kC
	v+VWuAO4N5dIOm/Q7PfMc3codhA0nEqZUEBuUJvhTVEoiDNE3E2qwlfA==
X-Google-Smtp-Source: AGHT+IFKgOwTlwCologB9RPnLVhImtH7zYgb7qNEU+EUjQsSVqZEp/p+GfGOGsRPyv9N3KqhANqCXUPStgV1KNYZ
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a81:4908:0:b0:608:a8da:1caf with SMTP
 id w8-20020a814908000000b00608a8da1cafmr97943ywa.6.1708985811384; Mon, 26 Feb
 2024 14:16:51 -0800 (PST)
Date: Mon, 26 Feb 2024 22:16:47 +0000
In-Reply-To: <2024022610-amino-basically-add3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024022610-amino-basically-add3@gregkh>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240226221647.1425311-1-yosryahmed@google.com>
Subject: [PATCH 6.7.y] mm: zswap: fix missing folio cleanup in writeback race path
From: Yosry Ahmed <yosryahmed@google.com>
To: stable@vger.kernel.org
Cc: Yosry Ahmed <yosryahmed@google.com>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

In zswap_writeback_entry(), after we get a folio from
__read_swap_cache_async(), we grab the tree lock again to check that the
swap entry was not invalidated and recycled.  If it was, we delete the
folio we just added to the swap cache and exit.

However, __read_swap_cache_async() returns the folio locked when it is
newly allocated, which is always true for this path, and the folio is
ref'd.  Make sure to unlock and put the folio before returning.

This was discovered by code inspection, probably because this path handles
a race condition that should not happen often, and the bug would not crash
the system, it will only strand the folio indefinitely.

Link: https://lkml.kernel.org/r/20240125085127.1327013-1-yosryahmed@google.com
Fixes: 04fc7816089c ("mm: fix zswap writeback race condition")
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit e3b63e966cac0bf78aaa1efede1827a252815a1d)
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/zswap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index 74411dfdad925..b6f4a1a760578 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1105,6 +1105,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	if (zswap_rb_search(&tree->rbroot, swp_offset(entry->swpentry)) != entry) {
 		spin_unlock(&tree->lock);
 		delete_from_swap_cache(page_folio(page));
+		unlock_page(page);
+		put_page(page);
 		ret = -ENOMEM;
 		goto fail;
 	}
-- 
2.44.0.rc1.240.g4c46232300-goog


