Return-Path: <stable+bounces-56128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 274A591CDC3
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 17:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D89E1C20F11
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 15:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94AC82869;
	Sat, 29 Jun 2024 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l7GZXxfO"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803B35B05E
	for <stable@vger.kernel.org>; Sat, 29 Jun 2024 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719674049; cv=none; b=tjoCzepQnKuwq7i5xhdB0efN7lobX0UEHGRnBAjiYsuwXVMLMRfONPLBDZ0DWyx44GdxzHi4rK40/3DEzi4bEFv/yaPZTYLtY3cqAr7DHBxzu0XYh8lA25TkpbkXMTsVpm+ZXDnVE+yUnL4ph4JLHzGcw/7aUXwbllde3HEgOMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719674049; c=relaxed/simple;
	bh=EcX7z+WT8vr5hnO2kJRrWvXhtQk3Mx3Dp5Qz3S91RXI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=EZpwHMHIOE7NNU6gRbv/LC6A+MMR9AwWopCQFadc43Yf+la1ZKmIUTD98aSQUhKDdZX9p1YQOEYqljH4KvkWjkd2YYg1kWmG8RKKl+GMOE44WKKQ3doUNeC9cIb7iZBhy50JaCGWVkAWNU3gG8VDpDzekMEuTzeQhz+o1awXD5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l7GZXxfO; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62d032a07a9so27432447b3.2
        for <stable@vger.kernel.org>; Sat, 29 Jun 2024 08:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719674046; x=1720278846; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e+K8noA5rISLPh7KHVuWO785aZpaN5mAazWhOb2jGbI=;
        b=l7GZXxfOcgylZqzi/UuHfKAIPG22XeRi8RbEU02yB3Jnqm3SBVIwN23mSCd/Xzv5Pd
         jJWVj3esR+9iZg4RNPCn5WamJsb9BMdhZyJqmqS1naj0YwXOUHa7HzOk2gHpVIh3flWt
         D/OFqILn+lcH/Hes1+lEoPo11WJ04DP4OYS0Pp61DxjvH1Gtm8uDcottU4VN40f07yyj
         MKcBxshND7nizizzxoXmweqk36JHpye60InquTYLw9C+GNDVwep05wolAOiBAJGeWHNO
         qSKoB6+YMbWyGEiSahc2HZZdrh+vDYQnP4sAMYlDICNS3J1sokauzhaJV05aEh2mFTrj
         u2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719674046; x=1720278846;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e+K8noA5rISLPh7KHVuWO785aZpaN5mAazWhOb2jGbI=;
        b=oGJX1CL0H//1uFDtERS4YPjzG1J2Mq55P3HLO5SoaNmtZYgEyiCU2fxDrGuFs/9Y2e
         8d7Ua1oLtBxNhJOwArldonRwdy9ouDj52gO3OZJDU+NUHJ0O2e4JXjhJ32SV4Pnixb4I
         Rmr66SqZWapz031uD5eyKSqQawPT7LWIR2zBVWBH8YWhTRvrvUSPadUZvgIIVlVrXIFP
         j3bqPHU+Y/3hUdeR0HF/HLhS+Keg8Yq7BRiR8UQlS8XwDGSgpbm08K9Y4OqZvhWTH3Hj
         uKi2zmXetiFJlHiHRzT0V0ZHbDobKU949qeAqj3aSL2aEnio2r77AiutDNnyKF4ABuMy
         cWlg==
X-Gm-Message-State: AOJu0YwG3OZ5D5ADhV39DXtl86QPD+UhGmFBf/4vLq72fzMImbckJN+g
	9/60xR8+wgcI6/meabxQpKmOhS/g4sVjbBNFyx1gBtDxoAg+4rSjAUZjQ4ZGJ6d+MlVh7BRLdvN
	KAHn6sxjhuN0566ideAjk+FG92CMYeA7RROS9VJvtf7laCKyCnDdTla02QyGZApJyfzbvfS2rY3
	cBY3iQfGSZIhSCvnYeSU1A1Q==
X-Google-Smtp-Source: AGHT+IG0BEaDPsYVH13UfxVTVWgsfzniZDtcfMrydjvm9Tgl9yEL13//ZGwP/G7ud2+lP4W8vRSr3B9b
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:707:b0:e03:5239:736b with SMTP id
 3f1490d57ef6-e036ec370aemr75359276.8.1719674046479; Sat, 29 Jun 2024 08:14:06
 -0700 (PDT)
Date: Sat, 29 Jun 2024 17:13:58 +0200
In-Reply-To: <2024062455-glazing-flask-cf0c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024062455-glazing-flask-cf0c@gregkh>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=943; i=ardb@kernel.org;
 h=from:subject; bh=MMDbCRo14e4LLnTHWZucpWte5lgczkwP63WJKLmMR7M=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIa1BZdsqvvuuq6YebMnyqZ5bEdM5/93ujdOa+d+1HfbmD
 VNW9WvqKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABMR9WFk+K/7O+uf1g/3G7nb
 5knOs5r1pIKzfvsmwVtnNp6POJy6FKggzfXqr2o+tsX8L25lq/oKMLIv23Rs/ir2H4oR27qeXlj EDwA=
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240629151357.866803-6-ardb+git@google.com>
Subject: [PATCH 5.10.y 1/5] drivers: fix typo in firmware/efi/memmap.c
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Zheng Zhi Yuan <kevinjone25@g.ncu.edu.tw>

[ Commit 1df4d1724baafa55e9803414ebcdf1ca702bc958 upstream ]

This patch fixes the spelling error in firmware/efi/memmap.c, changing
it to the correct word.

Signed-off-by: Zheng Zhi Yuan <kevinjone25@g.ncu.edu.tw>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/memmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 2ff1883dc788..b4070b5e4c45 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -245,7 +245,7 @@ int __init efi_memmap_install(struct efi_memory_map_data *data)
  * @range: Address range (start, end) to split around
  *
  * Returns the number of additional EFI memmap entries required to
- * accomodate @range.
+ * accommodate @range.
  */
 int __init efi_memmap_split_count(efi_memory_desc_t *md, struct range *range)
 {
-- 
2.45.2.803.g4e1b14247a-goog


