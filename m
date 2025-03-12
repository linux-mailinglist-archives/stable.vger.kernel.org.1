Return-Path: <stable+bounces-124160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D041CA5DD75
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 14:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1C837AB5BE
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 13:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C051112E7F;
	Wed, 12 Mar 2025 13:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOi2LvCZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92CA1DB124
	for <stable@vger.kernel.org>; Wed, 12 Mar 2025 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741784863; cv=none; b=Xn+gNxBGfF9siKV37ithk4la3wSthEtZc6sDPS8oEPLw1sVvbD2wnr8w3lZ0Pn8uocMz1z4CQaN8u8cIGSjQ3UksqI3B/1eC4vjQy3rcCO7hUqcO4lqXEy8PuLCZOj/JHKyBp/CRtF1dncQOPqRbbxELzrftPbYXZmBOwC7NuvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741784863; c=relaxed/simple;
	bh=xy7RcXh/Zu7HXPI25fB6cMKTeCSQsij8XRqGWjoKOFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=rJ5naJo8tm/kKGE69eoVhOkihao17Gg9wV2OZYP7jBoC0rfwpf/KWqr5eH2n/Pqh2ozpNFcfjeyO7qUYlgvmW+GBsrI/9cddK94SS/OxBcc1IALCVy/qV3wEC1tEWskMrcUp/l3TJuhSw9aqvFjvw3Ov3IyHg0pzw0C7Yr4U0oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOi2LvCZ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso1361850566b.3
        for <stable@vger.kernel.org>; Wed, 12 Mar 2025 06:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741784860; x=1742389660; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DNHZcFex8Px1j83D4c9FcmO0xIGKpZb8OD7DVh1p9Xw=;
        b=AOi2LvCZFs+ghGJ/lEfG2K0FVLcaX3NrJC5JGcz7lMf81SLK/La42gMkY3/DCxfXnx
         9jJZ9n6fK5SHxu9F0QEAZsBlRRMEfMa3sVXjStoGUa06PyrrqO4yvSSgDD4TvXdzAIrz
         A0pzv/1pX7XGN4unab3aGa5sfASkUGXs7gdsRBnOfpYy4gy4v7jHW4gayjrB88WCc0Rp
         H8GthuIl6HCNBtxcZZTHzQO//kzUFP+Sv9fSOUBY1PtHrUcV5HHCGM5vAnw6BrAzbxjF
         1yytDiJCsXpwRPgfbhfN3Ec3aEpN2yWz58OGhFR/c8/YWZvOQfq21DlAgDvB9yT+NdUH
         Gwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741784860; x=1742389660;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DNHZcFex8Px1j83D4c9FcmO0xIGKpZb8OD7DVh1p9Xw=;
        b=cqsOFELICVuTOOeZEaBwDWJ8iFhubXaTMfh5gCdoK50kS+UAgu9GfYQE7iS0DbFpH7
         J+0hYEDEiv8huTmD/npNgXJq4ENYutcZG33kwoPHVUjjPx6tJIa/CMjMO9ovNs53X77M
         jynLQIxQXOBnyGTQFYjFQt39Y+17MbbhTlbV/mKtSRg9BK/CLEsLGZO5VzHvweqHTivS
         ByXoipmvpfpWKnlcjm64zU8NFmXgGXMcyS+psZC2DCtIDJA4hMaIGnat+CeoIaTLY+W/
         /Na3XJzgIs/hHV4AusR8mlNsHGOQb8o1Y3Gb07VjRBDWF6ODOQ15MY2tGkCoQzateKdH
         gHuw==
X-Forwarded-Encrypted: i=1; AJvYcCWs3sDm29N48yVqtGZRXeEUA8OHLOGW7wYCQUY7EKlXIWa3Kr934SKsJMdSgD5a+ZwtNfuA8J8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPWJB6XgdePoeK1flzap9v9ZrPkmU6I47KCthu0yhecNl2hdJa
	Csf29myQxADKQyFlwIA/c/ztrmbclTMXimdPkOog0AY1uXAX263y
X-Gm-Gg: ASbGncvF1OzgGHwbNtyT5bFgwwqrQ1eJYn99esxcPi7gi1gRXewmtdvZ+CgaY4iCOan
	DHRwLw7l0ULr+zjZcYPTIGEmq+TX7g3il0fvm29uWL1iZa93ii5eDiH1p7rfqwS/0Ni4Rezma7X
	gvcPQx8ABphI2sAoo1CUHY+ZS6x+gGxOVlO/FmHV5UrjbjL7FgFoB2e+Cxn2lVd3OdugQeT7TIi
	3I688J8L+/xjitstlIW/VRieJ89iKYVk4PiaCyGJZt0ieBL08XTj2p0RgraLODEGZWx0LvTWWuG
	ciq43Rqp2X0135Ss7uN1Dwrkg4ihmKDkP/Dqsm+QmTnW
X-Google-Smtp-Source: AGHT+IEN8u7QOLcSOGSbQarp99oCBB6jfJHA3YxhlG5I8KBsPt5gWTItLzkpJ1ry6WxIs/D+T/UCdA==
X-Received: by 2002:a17:906:6a1b:b0:abf:74e1:cfc0 with SMTP id a640c23a62f3a-ac2b9db476amr1098655566b.7.1741784859257;
        Wed, 12 Mar 2025 06:07:39 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2e1c23ab1sm96517766b.121.2025.03.12.06.07.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Mar 2025 06:07:38 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] mm/memblock: repeat setting reserved region nid if array is doubled
Date: Wed, 12 Mar 2025 13:07:27 +0000
Message-Id: <20250312130728.1117-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20250312130728.1117-1-richard.weiyang@gmail.com>
References: <20250312130728.1117-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Commit 61167ad5fecd ("mm: pass nid to reserve_bootmem_region()") introduce
a way to set nid to all reserved region.

But there is a corner case it will leave some region with invalid nid.
When memblock_set_node() doubles the array of memblock.reserved, it may
lead to a new reserved region before current position. The new region
will be left with an invalid node id.

Repeat the process when detecting it.

Fixes: 61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Mike Rapoport <rppt@kernel.org>
CC: Yajun Deng <yajun.deng@linux.dev>
CC: <stable@vger.kernel.org>
---
 mm/memblock.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index 85442f1b7f14..302dd7bc622d 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2184,7 +2184,10 @@ static void __init memmap_init_reserved_pages(void)
 	 * set nid on all reserved pages and also treat struct
 	 * pages for the NOMAP regions as PageReserved
 	 */
+repeat:
 	for_each_mem_region(region) {
+		unsigned long max = memblock.reserved.max;
+
 		nid = memblock_get_region_node(region);
 		start = region->base;
 		end = start + region->size;
@@ -2193,6 +2196,15 @@ static void __init memmap_init_reserved_pages(void)
 			reserve_bootmem_region(start, end, nid);
 
 		memblock_set_node(start, region->size, &memblock.reserved, nid);
+
+		/*
+		 * 'max' is changed means memblock.reserved has been doubled
+		 * its array, which may result a new reserved region before
+		 * current 'start'. Now we should repeat the procedure to set
+		 * its node id.
+		 */
+		if (max != memblock.reserved.max)
+			goto repeat;
 	}
 
 	/*
-- 
2.34.1


