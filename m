Return-Path: <stable+bounces-191790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6F2C241E9
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 10:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71DC24F6406
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 09:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC8D330B1C;
	Fri, 31 Oct 2025 09:18:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20022EA48F
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 09:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761902325; cv=none; b=QnLqUr+KAmK0MpdarlugXf6p0U0Izee3bodXXttscpw8IjQ2xkQ4r8tYAtHBZg16Tj4W5Ji3Kmu+FiaafnQdwR1N/QVOaERuQOuiGKPhR7MuJFCI2+oS8Fv43iwlWzYrjXLWaZrDPPKJ4crzD+Xv0CUVsHxuceNzzKEptVWYEeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761902325; c=relaxed/simple;
	bh=CKwLRXWSs8CRQTtdRUeDXnJdU3d4K2VDAIjleCdmPeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLDLGdtEtlu9FiAYYG3D8PDQPINFFo3KqbU+1uDUIZ6UDHJP4JkG0WXwWulfdR+cnNSvvp8loMoznHyPKAShUYuyezVGpRFV0xVOlBa4aMiU9Fzq5RALHWU55m3VzkK8aYd6W0WUENRQlTHLIEJ9/l2MueT7vUtnO+tAXOnPRQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-26a0a694ea8so15940195ad.3
        for <stable@vger.kernel.org>; Fri, 31 Oct 2025 02:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761902322; x=1762507122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+NZHuy7slH1tEgRbDXmTQJQ+Q/vMpvRiCleu5bnlac=;
        b=rYETT0vamXtjCjcqlbtL5Rf9enQISKgt53zoy9RgUUrIYNPHbrx2fkiAgcvdkaaIYT
         vpj6Ix3V5UWeML/+6j1IBfwZPXADqT3en9rSg4WMXNw74stC1cRKnFCbMVWS6DJDeZQJ
         GKyejwSV/iX4DDNW/khzd0CXBANCXngnibEiTu4cXZ609op0ZpQ/sp+Vn+pc/xlXC9+t
         tUVbla6F3B5XMDtVqkUtmvWWfJTjHlhwEiJ9MSwCk46XKO7sbHd7RCpGUQAWF2SVhAMI
         PaRe0sIwUg+G2VOtvMi8DZrIekbgk473N0h2yQmkAhh9RnHXIZ+VLS+ysD8R2XkVclqC
         Zx9g==
X-Forwarded-Encrypted: i=1; AJvYcCXq1NestCP2W1TH8zbwF269iZIgCXa3JZDi4wfv428OU2dqzrRzU2csFbMB9XEilaSaJa6O8xY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJQ4k4fr8/oyeFP/Y0oP84qpkECCXCztwkKIzM1gs8zS3ImSa/
	yo6t7H9WCR+g411XZPbP+J9t+nCczB6nh7vsdE5kd8eUTFnrBTBDH2vV
X-Gm-Gg: ASbGncsQG0mhLBqw8+b+7KmP2xUvuXA33VZNH5YKR81Eeb9G3f+mUIs6jesvOJC8rRt
	yImNtqUsBRQwqhpuOyUa83RtfVA2vj5cBNe0o3ZqFakBdAG1O3a4oDiWbhnAk3MjKKE53k2/D0f
	5YSe5k27l+VAaM4DsboiupIBwieyJxuTrtKVGOwwedkQY/6JsC0LtlfjzFrUIIpVGSEq+iso+CL
	C9JDp1E114sBG4ouN0b5ZoCcCwmKRnkPfoh55TkqLl0O+u9njrYWMvSZ71u2WypYeevu3V7Vza9
	BbHFI9ZjeaoBsOoJk26/WVTplce5Bc12hLXGjlGE1YTlkr5nBDkr1kjh6QQRSc7g3ZM9xGHfZCl
	4udH6+9vlVHXraaDs24g4oGBHpVzHP5ZPbtDONxtEW4Npc1u+LVMDOXzZtQ/69/1iS6OGulLBOY
	umpEongoAXxIGvHna3iqKoYvA=
X-Google-Smtp-Source: AGHT+IGaY5+g1K6KFzwg6ulzp43eGNlMp6k/vOU+6dw4kyEoznXaP1AMdrHNLfDz0Nl70DbFrEP/Wg==
X-Received: by 2002:a17:903:18a:b0:290:7803:9e8 with SMTP id d9443c01a7336-2951a48cf38mr43274965ad.48.1761902322016;
        Fri, 31 Oct 2025 02:18:42 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([124.156.216.125])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3409288c7c0sm1524575a91.5.2025.10.31.02.18.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Oct 2025 02:18:41 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org
Cc: big-sleep-vuln-reports@google.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	rppt@kernel.org,
	willy@infradead.org,
	david@redhat.com,
	stable@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH 1/1] mm/secretmem: fix use-after-free race in fault handler
Date: Fri, 31 Oct 2025 17:18:18 +0800
Message-ID: <20251031091818.66843-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAEXGt5QeDpiHTu3K9tvjUTPqo+d-=wuCNYPa+6sWKrdQJ-ATdg@mail.gmail.com>
References: <CAEXGt5QeDpiHTu3K9tvjUTPqo+d-=wuCNYPa+6sWKrdQJ-ATdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

The error path in secretmem_fault() frees a folio before restoring its
direct map status, which is a race leading to a panic.

Fix the ordering to restore the map before the folio is freed.

Cc: <stable@vger.kernel.org>
Reported-by: Google Big Sleep <big-sleep-vuln-reports@google.com>
Closes: https://lore.kernel.org/linux-mm/CAEXGt5QeDpiHTu3K9tvjUTPqo+d-=wuCNYPa+6sWKrdQJ-ATdg@mail.gmail.com/
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 mm/secretmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index c1bd9a4b663d..37f6d1097853 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -82,13 +82,13 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 		__folio_mark_uptodate(folio);
 		err = filemap_add_folio(mapping, folio, offset, gfp);
 		if (unlikely(err)) {
-			folio_put(folio);
 			/*
 			 * If a split of large page was required, it
 			 * already happened when we marked the page invalid
 			 * which guarantees that this call won't fail
 			 */
 			set_direct_map_default_noflush(folio_page(folio, 0));
+			folio_put(folio);
 			if (err == -EEXIST)
 				goto retry;
 
-- 
2.49.0


