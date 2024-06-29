Return-Path: <stable+bounces-56123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C087B91CDBA
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 17:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7197B28287E
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 15:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC7582862;
	Sat, 29 Jun 2024 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U+DGATrt"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF935B05E
	for <stable@vger.kernel.org>; Sat, 29 Jun 2024 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719673966; cv=none; b=MLtNZ+26Etzn8suPpkCfs/ichBusMuXtW1W4Dmdfe9aM+lJUmdV2urFf4FCARyu76H6kg/LJBzAIdCqv/aAYAFNesiDl1CU85lHN3oJ1aJPgm4NBSaaug1phVAfscR+BxXrXu1FsvS3YD5RYLHu8WymogjrMW4BYlA7wBbRkDOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719673966; c=relaxed/simple;
	bh=EcX7z+WT8vr5hnO2kJRrWvXhtQk3Mx3Dp5Qz3S91RXI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=MDv2EhmGF2qhMcIdnO45+PBbiiizVcNN2BGzCpB+KxMf5baUW9xTbDG+f0smgftC4Xr+aMzrR+ufh8beZPXgNsqJ2pzEjf0yiDJyG5/q4iHcQtARjk78nQZtW82Ntff8NKBNSV1ys6xcSejHAnGfYtexZCJ7f9DnUabetrnhN/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U+DGATrt; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-42490e94105so12488565e9.3
        for <stable@vger.kernel.org>; Sat, 29 Jun 2024 08:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719673962; x=1720278762; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e+K8noA5rISLPh7KHVuWO785aZpaN5mAazWhOb2jGbI=;
        b=U+DGATrtr9rp+x2TqiJjrQMt7lUldVIx/XOmjjmL1OH4+EKTdVazJNI1QTxnVAHYjv
         MgK2KUQeEoE5XLURcA9UJdY57I/7NlpDSiX93c30e5bYVEmfP1WHPaMtMlzxmbueQdRE
         dOiet45o8KZfBvZU+MNIyQsjOjcQ88IG2JAgctFpHqUiFVzuzF0gz8zLjteBhMF/Ej7B
         NmqlJCMXQjel/5tyGXz0kOG28E3vI15xRUqiG54+8B5MtTnuSmgoyFHSmShcbz1PuhYs
         tpcjGITQ7ZzkrwnTX+50VMp63Qm2960VZmNH3ZcN3fURhC+N3BSu6lZFSy+nzaODJTso
         mvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719673962; x=1720278762;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e+K8noA5rISLPh7KHVuWO785aZpaN5mAazWhOb2jGbI=;
        b=GVDy9rikneEyEx9bTxPQhWUQQAI2nkc7SiYASM+604i5AlS3NtV4QYhpa1ZJlYrxFE
         Zewm/UqqPmWG9LjLmk/vmHYp7VUVePYQhrCpCbnlmhW7l2JYa7wlvJ+2VtoED911rM1D
         Ynt4t7S2z/te7Hg5Bg44L8suuRU6qB2CFU6fEr5axZPyIGE6Vrz8UZPLCWptgYXqWnrH
         BDrCNapic+Lwm0gOkvqKCwBTQGoxzL+9rsNm5kBd2w7gGhOQ/43Jtvbcjkkd+T7EJBp4
         z1+WFMYLttOX2DEOMsuoK5ZZ5K2L1vChc0xunPxalLPNw5ZaySItI7Gw/R/RR/5DFqFx
         jiTA==
X-Gm-Message-State: AOJu0YwrxNYuj7lSC8sd8CCJgbI3DLd5QhwMX8eNgyRPkeo99GdoD8v3
	omkzdowsKJaTc5weg8XeaOQJc+t2Tg64zKgVSVVQrUMEap7XyXjqhbf5leqYIAUyFEqaoaC7Wzu
	avEFT6FJOPgxqT/ruZNdnM0wpI0he2jDGg2DwnFdqZTZ4EsqTw5lKs0F1SORHssqoWo/HfO11Gm
	MAUC1raoEiQDL5f+y8rRqM8w==
X-Google-Smtp-Source: AGHT+IFoBOC1/s4n5R2qJRrrGnimEFg83NmdzSC1UlwjFDTkOiCcvmwqvGiJ7qga6Y9CrSN32fxL6aAS
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a5d:6447:0:b0:362:b9a0:1cdc with SMTP id
 ffacd0b85a97d-367756b2babmr1997f8f.5.1719673961838; Sat, 29 Jun 2024 08:12:41
 -0700 (PDT)
Date: Sat, 29 Jun 2024 17:12:32 +0200
In-Reply-To: <2024062448-overspend-lucid-de35@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024062448-overspend-lucid-de35@gregkh>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=943; i=ardb@kernel.org;
 h=from:subject; bh=MMDbCRo14e4LLnTHWZucpWte5lgczkwP63WJKLmMR7M=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIa1BJWEV333XVVMPtmT5VM+tiOmc/273xmnN/O/aDnvzh
 imr+jV1lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIucZfifnq5w9Pny1kzjTPWo
 6V11XPE1e7xXi7DazFhk69X/rvUFI8P008E/xdL5F55bvuTijGdM58LXm361nSezQO/Ki/iIkye ZAQ==
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240629151231.864706-6-ardb+git@google.com>
Subject: [PATCH 5.15.y 1/5] drivers: fix typo in firmware/efi/memmap.c
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


