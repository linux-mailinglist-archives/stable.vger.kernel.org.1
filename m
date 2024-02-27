Return-Path: <stable+bounces-23878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4D5868CD9
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 11:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B1B1C219F9
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 10:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2396136991;
	Tue, 27 Feb 2024 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iKllyzF7"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDC856458
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709028231; cv=none; b=dyy7I80u6L/8M7BlcTXvJNZgkuxfjIgPb6F21KBPEceUgmYR1gYt2xw0qCmq9FYggOqk4Mr+enA+pgtN4105KqxsWLrFvPpXatRj4+QY3biwccc4cNanSQjZ5FNaAMCzOCt0T317Zymm9mWu0j7W8urF2uXJdRyrS6xns0G2mjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709028231; c=relaxed/simple;
	bh=jf6TVdmGo7lcVUEsDWs3imwelVijSCXAfs3fk3UzjrY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gM2t1nahNq9EebVSbsXK6HHy5QsFfdEIyBDV2HaokzNKW7mCjVsMc9JlZKJazDp9p5JI+uJ3XL602grOwwl4n1B2fdrJQy4TP6RaocpP6wzjjqd90LSZWTTgdac8Pw34zn5fGwK7xwY90nL+WsdS7n/PXTxKNs4hIPdFi8nj0BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iKllyzF7; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc74ac7d015so5140589276.0
        for <stable@vger.kernel.org>; Tue, 27 Feb 2024 02:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709028228; x=1709633028; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/qP57UraBpiOX+iDeLGwGBNX+RIK6kWmanFIXJTTNNg=;
        b=iKllyzF7HH+nAG5i93HuoQg4QXe5+qP1F2WBfvW0X8GBxVy8x3mZfXCoa7gw3qdP1v
         7OPGzQ+V251YaoAj60EbpJwUJXkn9KvLsvCfvOjIGrLBDyto42n5xlIKbe3YeZItIyWG
         OsM4URWJ1yK88x0vvFl9CTwYmoRQwUwbhJsLTWTRuFBrPg0Nv1mJQv305Tkw+nUu+tzS
         Q3E5WjhlrTavAGPOiXdKuPAzghMIXLxPfs9W7Gs1VDO21eUoyVf3yZlJhfh3bUmQEgwZ
         alxMf1U5QzB5AFdRRzq7IBa9u7VJb9smJ3/yq4NKxyjAoFRcbXCT/ypI96Ovte73KqpK
         MVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709028228; x=1709633028;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/qP57UraBpiOX+iDeLGwGBNX+RIK6kWmanFIXJTTNNg=;
        b=rv6iIXVv3me9uB5xnzLsvE2lghnah8gNVAoRVs6cguHKWd4wJ85/5jJ/qLWmDr4ZYR
         PtrlFgtxzegM6fXiYX79o54ZMgJZz7gUC9Ny4AvFxlEJc49C0GJDkH9PojsXOTg2J8DS
         GqpvEYNQkModBqQOPKxKEIg83kQtvc40kRBP4li3Bhz4U5vqj6lAzzUZSAfbpMEoH7NE
         INlXmo6QuX1cGaZ1//KBQn1/+jD0IkdkLkWXT0+Le74RRZLDxoGOojkXCbGjj5m7/qHh
         jUPQsLlC50M7e39QkKfZ43ZpcEJKcxvLLoBf7YMuUE8pdGRb2+/EB1qXRdMmpgz1/TRa
         TXcA==
X-Gm-Message-State: AOJu0Yx+UbPjXg7hVHpDiOw8JUYAW83zJD1cAbuB8dIxQdgELua7PlMM
	DWv1Bx+SI9KJu0TuE5jibpRgY1EVKBjdhFOVoYg0JSL7pZ+sDDfHoJqPYF15Jf7eCDalrAcxUzJ
	E7OW2l5rSUdsfFGfRvbgWKxpOw0raaBVtzZgbyWZCPa4b4C7vCtxVg294RmaJP2yC7zDduxIFLH
	K5LxgP7G4M2Xs3zaJfrqjb/avPavT1D+3l52OFSuO2NaQ1StRrDjKf8Q==
X-Google-Smtp-Source: AGHT+IEkFtI7rj+GWXO4XkR50k8jlYyuszjSxcUMZX5w3jadJJ1RbaVMLXm95LF7Qo3dwMaLiN1EHikKzBNEIqBY
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:aa0f:0:b0:dc6:d1d7:d03e with SMTP
 id s15-20020a25aa0f000000b00dc6d1d7d03emr74838ybi.8.1709028228520; Tue, 27
 Feb 2024 02:03:48 -0800 (PST)
Date: Tue, 27 Feb 2024 10:03:46 +0000
In-Reply-To: <2024022612-uncloak-pretext-f4a2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024022612-uncloak-pretext-f4a2@gregkh>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227100346.2095761-1-yosryahmed@google.com>
Subject: [PATCH 6.1.y] mm: zswap: fix missing folio cleanup in writeback race path
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
index b3829ada4a413..b7cb126797f9e 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1013,6 +1013,8 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 		if (zswap_rb_search(&tree->rbroot, entry->offset) != entry) {
 			spin_unlock(&tree->lock);
 			delete_from_swap_cache(page_folio(page));
+			unlock_page(page);
+			put_page(page);
 			ret = -ENOMEM;
 			goto fail;
 		}
-- 
2.44.0.rc1.240.g4c46232300-goog


