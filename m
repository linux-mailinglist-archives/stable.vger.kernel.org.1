Return-Path: <stable+bounces-128781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAB7A7F0BA
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 01:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B142E16C57C
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 23:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F156F22A4CC;
	Mon,  7 Apr 2025 23:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWULf6wj"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E3F226CF4;
	Mon,  7 Apr 2025 23:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744067664; cv=none; b=Rvq+8r7+5/wUagWMDtEY4C+Q8WzwLetGAbR85Hp1w5LLR+eD1FqL5n+sKoDF5H/gKikdiIP4buXcGXmgTW/eXdwUiTOW7DIitHBZlkgLEcVH746xYYQAR6MsGGaibTpn3dmZHh4DEwUQpL58RZOtFOGkvYywSzIBscXd1FHC7vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744067664; c=relaxed/simple;
	bh=3U6BVYINcede1cjJtqc/3GZyBpvRQDUdQ5t73UI9vNA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=m05TeHCULLy4/sZOAozO7oK+5ZJT1OBP0vyVOS5RU0BZ2Taj9JPXyBdjfyhcJ4VTe2nf4tinKK7ElNxvfj0rEeh3RID/PRJ2vbLIANcZGb7nAw+ND+8aDbaKsid2Gx1v/rEC6N2sWmIcq6vxHgu1Zo3z8VEKLZvWM6oeg/MVpYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWULf6wj; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab78e6edb99so710741866b.2;
        Mon, 07 Apr 2025 16:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744067661; x=1744672461; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RBLmvV7Q4wPiI+MEo68mMCleA6GCDfzaBhVQhk2842M=;
        b=XWULf6wjq11LXsNhJRGj+nae6c2sql/FTTG5uXAeqriig5O2HsaTlAnY+AHOVuJdGi
         7bEhLjGkW/jPBGsIoN/DUPKpvHAbUElKsYW6Lk4NjtkNGwv710+VfBwglSoySeNlNr+g
         lrajDwQIQKqTXYzVF+nWiqq+PBOBugQ8cSUquij7VyQP1BETAPESW7I65Pl5LRShn+RE
         1OH2eCXNioNjKb5z+JcQAlMjofzbauvqdiOCOgdDGwA4SjnYN1hJBEAU7WqKBNjAfKCR
         KxaDBRcfnXZeQTtFWhZmfug7V7JUZzQZNI+DVT2YKkkmCii4v91PjXK2GQxV7cBLAAO3
         WLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744067661; x=1744672461;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RBLmvV7Q4wPiI+MEo68mMCleA6GCDfzaBhVQhk2842M=;
        b=YSbPfCw0YBr5CE8pwjqID33cqPP1zGuawcaheDWP3i1QlwKWparqiM+EdY5875Ho6b
         dNCM0OAPYD/CVSxPXSfOixlqXM7/H0huKBZBmJIgPjG/LkOQq5TTmpKzqzeKB5evx75b
         Fk/v/+sLeUIRU6/JQUdO/OrOt/KV5CuIab1muXTiNOEb6/pVetJ8ZDDYJTOWSNBh18ux
         9+ksYL3JTkck6fjmk5Jr2QkE6Rvz5iswyciDEKiVjE9fXBSVmmNm99oti7FZD928clId
         ++ZCD+ZZu4h+XRg0adPRADpmX5iXL0PPK+OolGQTFILg2bTnQvN83Kt2O6w6oPHpL3jp
         7wIw==
X-Forwarded-Encrypted: i=1; AJvYcCXynWnVufK/o9YUu2hpvcp2Hxg3+Os9N/onkmW/zeJ9GSxdhsGDrYyPQpH80sd1BdI15YpNXMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqoBUAyLVum6Txwsb8dX2FZQrZerjm6saHMjkaTszSqWjwp485
	nF8TX6LNwcHDKgYXDpid2G39/Q0qrfUAvlYmHxscD5d8dUM9GLRhTBpUb0Qy
X-Gm-Gg: ASbGncv0yF0cY+hgSmnUdZzl9k8yt1FALGd7KpPNd6XU2XNPpqJkTrLcLpXxcEFwbu4
	vtdEwAsOZnova11t6si50ZjvD87dHxdUn7u+3tFsiqnTTmZsCrJ4cDJaP7W7FpNGw+k2F8z4Ojk
	Dqch14yP+b1jG/aFx37o7Uf9Jk4D1SfjMBcJQshklRztLCDubOWd/cJVB8GXCNeRXVYss8zqvo2
	MHG0kZCnk9+lD//n8c7z3SJgJ1h7vckwnmn/Eu6YPlgqgCE16BGhMBi9XV40XeL/RIb0eMWqxGp
	EZgVOyFvFwUeDjLxH0dKYfEvz8E138IGjQ9SJ4bvHClJ
X-Google-Smtp-Source: AGHT+IFw0VJuD/5dW/5qXBXj2E60I8Vo/rjRMNFLtTW24KhKoP0N3NY3gh2Db5uU52nsRPD05z706A==
X-Received: by 2002:a17:907:72c3:b0:ac7:9acf:4ef with SMTP id a640c23a62f3a-ac7d6e9fe06mr1202449766b.56.1744067661141;
        Mon, 07 Apr 2025 16:14:21 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c0184d0dsm807259066b.130.2025.04.07.16.14.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Apr 2025 16:14:20 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	"Liam R . Howlett" <Liam.Howlett@Oracle.com>,
	stable@vger.kernel.org
Subject: [RESEND Patch v2 2/3] maple_tree: restart walk on correct status
Date: Mon,  7 Apr 2025 23:13:53 +0000
Message-Id: <20250407231354.11771-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20250407231354.11771-1-richard.weiyang@gmail.com>
References: <20250407231354.11771-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Commit a8091f039c1e ("maple_tree: add MAS_UNDERFLOW and MAS_OVERFLOW
states") adds more status during maple tree walk. But it introduce a
typo on the status check during walk.

It expects to mean neither active nor start, we would restart the walk,
while current code means we would always restart the walk.

Fixes: a8091f039c1e ("maple_tree: add MAS_UNDERFLOW and MAS_OVERFLOW states")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Liam R. Howlett <Liam.Howlett@Oracle.com>
CC: <stable@vger.kernel.org>
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 0696e8d1c4e9..81970b3a6af7 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4895,7 +4895,7 @@ void *mas_walk(struct ma_state *mas)
 {
 	void *entry;
 
-	if (!mas_is_active(mas) || !mas_is_start(mas))
+	if (!mas_is_active(mas) && !mas_is_start(mas))
 		mas->status = ma_start;
 retry:
 	entry = mas_state_walk(mas);
-- 
2.34.1


