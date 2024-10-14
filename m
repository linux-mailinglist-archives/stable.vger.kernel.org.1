Return-Path: <stable+bounces-85072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327A999D886
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 22:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E70F12824B5
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 20:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1351D0E08;
	Mon, 14 Oct 2024 20:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JtS4/JYs"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C608614D439
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 20:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939060; cv=none; b=P9wcflZJsR5XC5CPvBOg/cXV3AUuU0kcUASkHboUGInTpHnE0KX4T+UQ3ozGQTZAfreJCtqA0JvdUmOXIed8P9OH5ntBibCbZgjaAUSIGRNxjiALGZR+YL0JPXrJQ7RwQk75YnXcsq1t7ZW5bOmvaNxhPYnC5TQvBOIMUD9EOuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939060; c=relaxed/simple;
	bh=OtHecDzCY0maqojKB8QVAPvBWoIk1Y8ZPHcQ2Ta6zg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Njz78Vcj5Vab5DVOKrcKxmwlTFMvIj2CfEpb06iIu8jLNP+IIiYoQYE820/mwb4/QlQDeJW4eVxDJ5ntxZcj71RSH2nTQHf24xYv4v3l0+eYHk8fiPp1ysmqX1BVrlxoyk+DM5Ursi0KFEruK6pSTlYI9N+VxKZqCGiwd4vZ+OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JtS4/JYs; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c93e9e701fso26559a12.1
        for <stable@vger.kernel.org>; Mon, 14 Oct 2024 13:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728939057; x=1729543857; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rassIsgglA7eP8y4DjUfZA8yriOc/wKgAZKpicjPuHw=;
        b=JtS4/JYszIy+wjf0j4Cq+dCLjZ2nhnFqgRmDHN5IRHMelcr4Gx+KOs1EBlYBTHshxu
         YoLLyqx2BsZTJiGcHIxiIrWYhsHRyX05lRkOookLryHJpIKxAO3NDERfY1gzlGLmduhy
         dNK/6O/coz4jOB3bzi+7Y0UBsS0WwiZ5/wIP2Ho7DQtH6HXgRgSuwK9K+B/O/qmjkqfC
         5WFIvBbKD8zV9KY6PjlMDhBMoBKToqVrz2RSU+hwyofEql29uw2OwTbBJfUFis1lhwP8
         GlooTREEKqVaJWTOfgkZwo8NYFbv1tOe7tPqDbcKxLrAjMVeHafyrd+v7iSbFe4Wg7Mj
         GmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728939057; x=1729543857;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rassIsgglA7eP8y4DjUfZA8yriOc/wKgAZKpicjPuHw=;
        b=AfBdxn5y8qSPruATOtJj1wlmcz7+++5Q3MMITySF+v/xFFDSbvAA4njgZeKDID7r1s
         xXRpEZVZ4+PwUng1cG3ZZWFK/2CHN142u2I8EjRzHdFkJsmI1BGhqPi5AUrFub2et/Md
         MlsyoJotC9U+GH3Dcq6AjHAIa4MGJZp+7VknbUO2h2KUzCU+882ZryOVMT4M0pbrZgvF
         AAyATwmHBpyHVVhvSJvxXE9JyekRw4K5t9YMgG6odvU0Qx338WKcQlxFhD7EgcZO7SG2
         roQCn9buT45fM2k4aDlbMUzrzbVNuAiBO7T67dYmkGScnQEyqkedLxnldl+kf6BaK+kn
         4nuA==
X-Forwarded-Encrypted: i=1; AJvYcCXxiIgP4O3uLeoiVVvKUatBaoEkGmjqUp7Smohbbt07Zt/Ta48JBSA6781Av+rtbX14EsNVQSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaL6SfXEaLX/jBGo+iXUtKA27vAG5oXqPby0G1cKlfaTJmp8eV
	ScLZoxnnO0RdbwI7prl+2X4gGSGsLItj3SpZh9t30qQcBimUQanzbV6LZIx862f9oMevdGtZpRH
	ePnps
X-Google-Smtp-Source: AGHT+IFVxzlvWgPLnj+2KGiihqAFv2pUR2ON96tGXsZszxCBooQUjViChFGR2gUTGYwYOCsYvwpiqg==
X-Received: by 2002:a05:6402:26c1:b0:5c2:5641:af79 with SMTP id 4fb4d7f45d1cf-5c95b0bd39amr490306a12.0.1728939056542;
        Mon, 14 Oct 2024 13:50:56 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:76ed:8ce0:df7b:3495])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6cfb35sm12291395f8f.52.2024.10.14.13.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 13:50:55 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 14 Oct 2024 22:50:50 +0200
Subject: [PATCH] comedi: Flush partial mappings in error case
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-comedi-tlb-v1-1-4b699144b438@google.com>
X-B4-Tracking: v=1; b=H4sIACmEDWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0MT3eT83NSUTN2SnCRdEwOgoJmpgamlmaESUENBUWpaZgXYsOjY2lo
 ATjBYEVwAAAA=
To: Ian Abbott <abbotti@mev.co.uk>, 
 H Hartley Sweeten <hsweeten@visionengravers.com>, 
 Frank Mori Hess <fmhess@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728939052; l=1653;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=OtHecDzCY0maqojKB8QVAPvBWoIk1Y8ZPHcQ2Ta6zg8=;
 b=QT8NZT5LU+8E+Jdiko/6ghEHwPkTP23BVw6zr+FrjYfPeLwp7kNjDzH3th5JO18g8ph8KRhwK
 X2NJORZVu+MCszf63PEaILffPREd+ipK9WklLW64aVPjr8XMWh25Ao3
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

If some remap_pfn_range() calls succeeded before one failed, we still have
buffer pages mapped into the userspace page tables when we drop the buffer
reference with comedi_buf_map_put(bm). The userspace mappings are only
cleaned up later in the mmap error path.

Fix it by explicitly flushing all mappings in our VMA on the comedi_mmap()
error path.

See commit 79a61cc3fc04 ("mm: avoid leaving partial pfn mappings around in
error case").

Cc: stable@vger.kernel.org
Fixes: ed9eccbe8970 ("Staging: add comedi core")
Signed-off-by: Jann Horn <jannh@google.com>
---
Note: compile-tested only; I don't actually have comedi hardware, and I
don't know anything about comedi.
---
 drivers/comedi/comedi_fops.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 1b481731df96..0e573df8646f 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -2414,6 +2414,15 @@ static int comedi_mmap(struct file *file, struct vm_area_struct *vma)
 		vma->vm_private_data = bm;
 
 		vma->vm_ops->open(vma);
+	} else {
+		/*
+		 * Leaving behind a partial mapping of a buffer we're about to
+		 * drop is unsafe, see remap_pfn_range_notrack().
+		 * We need to zap the range here ourselves instead of relying
+		 * on the automatic zapping in remap_pfn_range() because we call
+		 * remap_pfn_range() in a loop.
+		 */
+		zap_page_range_single(vma, vma->vm_start, size, NULL);
 	}
 
 done:

---
base-commit: 6485cf5ea253d40d507cd71253c9568c5470cd27
change-id: 20241014-comedi-tlb-400246505961
-- 
Jann Horn <jannh@google.com>


