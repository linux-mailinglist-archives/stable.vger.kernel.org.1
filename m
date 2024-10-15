Return-Path: <stable+bounces-86378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B867F99F531
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 20:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D361C22DA7
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 18:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024511FC7EC;
	Tue, 15 Oct 2024 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fdRFp10a"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1772B1F9ED1
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016822; cv=none; b=lw1+KBZIAW5ts4Eq8+4F8LV2nJiuom4UMViA32daNHI6sVbBX7v/b0/g4yvt99lpGEf/0m+swnzfWLc0jTBGtmavVbD6QjYc3vTBqvU+vzllIYIFmJFhGLkvW1G1kOAkLU4MkEmWnuOaY7QhfSsHphpdy7SLpR65QLLb80zqJPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016822; c=relaxed/simple;
	bh=vamx8/rOiH4uiKyR1YrzhxprexDCGI5fRg2RjeqQ9cw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gyxz1C+SuxJgsSxdSXVUpMJ4NWWj2Q+D3uZUmPWxZ2JRpZyabaHJxKsnamrrVG7TpUdQamdk6ZwG+dTz+mk5XcG8BPOZdiv8mvAso7ZMRR5VX3k8spugKrU859YyzCIF6NOQc6sr/x4Rcq0UwuJEPE9sjXpbwwbbdNCEXmRbuVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fdRFp10a; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c932b47552so56938a12.0
        for <stable@vger.kernel.org>; Tue, 15 Oct 2024 11:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729016819; x=1729621619; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mlSTzVFBMAwfCjrUhLGs/71Kbvg//7/+EQqPLUMGtSs=;
        b=fdRFp10a3pQjyII1qC+wNdA/NI2AXcs7Z8x8eeSx79oRo+vWhDAroo+NrsR+0nqfmV
         8hJGFfi2622r+x9krhGCoY9cGLgvxaLxRYMxTWFKlubimpKXCXZgcFVhGzC2dE8BqZjc
         cOh5EOFVMhPVh+1SH6uD1AbF4CED1gDKTckDh9Pz4EzufhQYgKPVuQcy237MrlAA+u5D
         vyhwfsUJ4mdK8JZGs8uvHGLTYFf3F6a+v4Dkx20Bg/G8LuAAXPqWElbBsU3km48YeIIw
         m0ZaiSWx2gSeGeJySRQyoozeGYeS5qWd0MCpjX+1xuhry7G8T/tUpw5UPARZ1TGYZo0B
         waJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729016819; x=1729621619;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mlSTzVFBMAwfCjrUhLGs/71Kbvg//7/+EQqPLUMGtSs=;
        b=SK/CEhsNhcZ6qZCc8ZGuYauq1KkrBSMr8ioh1HcAS/o/VbuJjhpBey5HHSOHKr/V4v
         1VoZ6xNgvuVqBszeg8Z1sTQyYuyDEBNvoRFItVKqmZ4phqKarNJJWA8L9Y60x9OJpqPv
         eimSV2oSp/BMxewBBIsM4c2cFfeTJkFKIFBY5qik49GJho79A157dw+3HB9ni24D8plh
         iwEroa4Mv8HZoHXjYvx+PQi+N0bcZLuVEWmFoIW431B83X/jLvpgCjqY6UnGhFOv8/DD
         LdwOexRZLdpy8/WdEGiFBOhWiCOcg5eC/hpiRMfq4ZjvTJafi6wd/3wGkEV7i7uDiq3A
         tBRw==
X-Forwarded-Encrypted: i=1; AJvYcCWbrOvryKUEVeDybFl3IfZ4nacLSMQvU9BC7MAPVq64RbiCaqy8ZtQiT/FTFX8a73jGOAeeeqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhqk6mm9hfgdUK3FpAoad4BIMshXg4s32nZn4HY1HIq5RMNqS6
	iciBjW9U0UVZQ30qgbYUOs6LB7e05/c2QQ/5EDfp+Pibq1rCMGapSSNUhGXLDUGZNBYfaiWtgWe
	tM8Rc
X-Google-Smtp-Source: AGHT+IGrVjq4UbZIZxc0XUzzTQLvBel0agYzdvE0EBbcyaVW8iIIg+me9M2vVfg/SYDFgH0aqj2X2w==
X-Received: by 2002:a05:6402:520b:b0:5c9:2834:589c with SMTP id 4fb4d7f45d1cf-5c997bc14d3mr21224a12.3.1729016818678;
        Tue, 15 Oct 2024 11:26:58 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:9e7e:5bb9:bb65:c022])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f55df1csm25890795e9.1.2024.10.15.11.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 11:26:58 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 15 Oct 2024 20:26:44 +0200
Subject: [PATCH v2] comedi: Flush partial mappings in error case
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-comedi-tlb-v2-1-cafb0e27dd9a@google.com>
X-B4-Tracking: v=1; b=H4sIAOOzDmcC/22MQQ6CMBBFr0JmbU2nDo115T0MCwtjmQSpaUmjI
 dzdytrle/n/rZA5CWe4NCskLpIlzhXMoYF+vM+BlQyVwWhDqJFUH588iFomr0hXaVvdOotQD6/
 ED3nvsVtXeZS8xPTZ2wV/9m+moEJF3jqHRJ5O52uIMUx8rBvotm37ArWt8TGlAAAA
To: Ian Abbott <abbotti@mev.co.uk>, 
 H Hartley Sweeten <hsweeten@visionengravers.com>, 
 Frank Mori Hess <fmh6jj@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729016814; l=1856;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=vamx8/rOiH4uiKyR1YrzhxprexDCGI5fRg2RjeqQ9cw=;
 b=DWAUbb29ZWRl0BmEcGgYmZtEX/q4PdYLpMGsUS37T3aoYfbfO6QVbmCBNUX0kPaHiyOyQuCR6
 Fk/OoP06U6DAWuGugUbD/IhPLDpz3h4YscUyU7jTHpp5q/V4AqxEPo1
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

If some remap_pfn_range() calls succeeded before one failed, we still have
buffer pages mapped into the userspace page tables when we drop the buffer
reference with comedi_buf_map_put(bm). The userspace mappings are only
cleaned up later in the mmap error path.

Fix it by explicitly flushing all mappings in our VMA on the error path.

See commit 79a61cc3fc04 ("mm: avoid leaving partial pfn mappings around in
error case").

Cc: stable@vger.kernel.org
Fixes: ed9eccbe8970 ("Staging: add comedi core")
Signed-off-by: Jann Horn <jannh@google.com>
---
Note: compile-tested only; I don't actually have comedi hardware, and I
don't know anything about comedi.
---
Changes in v2:
- only do the zapping in the pfnmap path (Ian Abbott)
- use zap_vma_ptes() instead of zap_page_range_single() (Ian Abbott)
- Link to v1: https://lore.kernel.org/r/20241014-comedi-tlb-v1-1-4b699144b438@google.com
---
 drivers/comedi/comedi_fops.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 1b481731df96..68e5301e6281 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -2407,6 +2407,16 @@ static int comedi_mmap(struct file *file, struct vm_area_struct *vma)
 
 			start += PAGE_SIZE;
 		}
+
+		/*
+		 * Leaving behind a partial mapping of a buffer we're about to
+		 * drop is unsafe, see remap_pfn_range_notrack().
+		 * We need to zap the range here ourselves instead of relying
+		 * on the automatic zapping in remap_pfn_range() because we call
+		 * remap_pfn_range() in a loop.
+		 */
+		if (retval)
+			zap_vma_ptes(vma, vma->vm_start, size);
 	}
 
 	if (retval == 0) {

---
base-commit: 6485cf5ea253d40d507cd71253c9568c5470cd27
change-id: 20241014-comedi-tlb-400246505961
-- 
Jann Horn <jannh@google.com>


