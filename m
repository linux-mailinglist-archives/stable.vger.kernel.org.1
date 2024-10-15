Return-Path: <stable+bounces-86377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B452799F500
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 20:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77901282537
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 18:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BC01FAEFD;
	Tue, 15 Oct 2024 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sU/ABULQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52211F6680
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016163; cv=none; b=pSvtuSGCZREtzk/DN4Um3LXrJ/TL7faiyMz/xGcza9QErv1CFtJBRH+5p6z30NfHifgvy1hDnEn+tN4zagqaTln9toobP2nc/uqpixmzhjuNLYLUpf1Tg2yRekluo0COj4iEKlP4xCx2viPzOso7EJsQQd3OGxukkb32k4Ej4oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016163; c=relaxed/simple;
	bh=1T6yD1P7ph0N1EELkpHc9HmNiM6TWkRhIMzSNPpxag8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pKXz4bagYvnf6/jWs6v3dpOfGB5usDWUNmssIVGnc8mX9ADHNvmia9P7Ta9juh/94iIVd2P0lf2w7ho0texiJ4ODAmDVyBAiU5GOjXnpD/A2/oak6wJAGDhpFa2T86Mj3h5whK/EwKvGLSFZoY3WZ4TV7cBck251p/UL9aoE8D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sU/ABULQ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e370d76c15so47306637b3.2
        for <stable@vger.kernel.org>; Tue, 15 Oct 2024 11:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729016160; x=1729620960; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vb0F1D/URMqrEFjwIj8UXRbubquki/NP7m91+7wn/AA=;
        b=sU/ABULQWEKF/v2LJteh80qpnBbzntEMnGpLRVewlKzZNipjeXp+Z5p5bL6oJg/svn
         EiMyJN/y4wVOv8Qrmh107lW8UXCla+FFN27dXBgEUHIAuP5jL26xRvHYwEs+85WD9VQF
         a621eVDb5KMEHZblyyUBM9M4Jzajv7VLmyswv6nG5Pa6kQ7OX/pzMyLWQ0cU9Bl9nheP
         ojnCT1qn7SKZxuy6IK0W++RoMmhThFJxJEI58xLCjGIjs/mnHIW313eD/sAeO0hVvChx
         rMV17ZEwua28NODgYLsa7lMt0tqiJEvidMFHuus+zh1eu785guZHOb9e+FDK3P4yS5PJ
         JBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729016160; x=1729620960;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vb0F1D/URMqrEFjwIj8UXRbubquki/NP7m91+7wn/AA=;
        b=elYWEjvi0yUFKgpG8IJeN0GeYjnvxexyoSYv9KSOKDrZe3Em8gBvWi2PkDm2MHyZ7t
         k537BqJ6NWSYR8qXPV9OMW2GR7g4xRZYADEUHl6Sh+yUIXoxQ84lu6oSrDOww5oqQxr9
         jokPjh7BT4Ewe5jU74tqI6vjOyxxssmM/PgjTMzCkNlPGNAcn8E/JB6HBwTlB5R5LGT3
         vSaoahBojivXAbVz3iwd0kV73ms07+XKQ7qlWXU44j0odG7NepDI1kd/FFoTNP1BUNaJ
         cN9JeWM9pdjdKc5PsRhP+/DtdDVziWkRClUu8jMF9pA71dv33VL1W2VkvpEpFxLoGLAM
         GAQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2aynbwdRhIOJIV3eNamy1PXVVRt/v85yI48oR5k23PgtiZb9G2SiJlYaPdfDxG+/JiMmSrak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4geuL7ieOJXmA/TUZdNgr3p92ZaDOKUcM9+xPHmaDqhq2tk5q
	lC4WuRQZAvjA1vf5+XCbkpfQjZTW2/zOqbFwm4IP0WnvRj4t0IqlcRrYwXVaQGyi/N3rBA==
X-Google-Smtp-Source: AGHT+IF0ZFpt5BuaaKZZKmArgpOmwAK2y4TVZ0ZMvSmzW3l/nsz2mOo0qLLkWGNat2clvzQKDi0jqUQU
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:690c:7406:b0:6e3:8562:ffa with SMTP id
 00721157ae682-6e3d41bede4mr387857b3.5.1729016160512; Tue, 15 Oct 2024
 11:16:00 -0700 (PDT)
Date: Tue, 15 Oct 2024 20:15:51 +0200
In-Reply-To: <20241015181549.3121999-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015181549.3121999-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1035; i=ardb@kernel.org;
 h=from:subject; bh=DUEag0n79tEu8RYPtJV8R8SWhGsqbJq47gyRYXEDML4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ1vY/iTL6tc/x0yfv/90ClBTt75/3geTTy8iWGhjNmd5
 ZtCJ6g6d5SyMIhxMMiKKbIIzP77bufpiVK1zrNkYeawMoEMYeDiFICJzFvD8D970vqGxVwcRr1b
 50Zsd57Su/LzvgvJ3xQYDKVrOH2UGp4x/K/OL1PLdl/kekB0cnbZhubNv3f9aWQ3cJlzhPOThvw Tdw4A
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015181549.3121999-7-ardb+git@google.com>
Subject: [PATCH 1/4] efi/libstub: Free correct pointer on failure
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jonathan Marek <jonathan@marek.ca>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

cmdline_ptr is an out parameter, which is not allocated by the function
itself, and likely points into the caller's stack.

cmdline refers to the pool allocation that should be freed when cleaning
up after a failure, so pass this instead to free_pool().

Fixes: 42c8ea3dca09 ("efi: libstub: Factor out EFI stub entrypoint ...")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index f09e277ba210..fc71dcab43e0 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -148,7 +148,7 @@ efi_status_t efi_handle_cmdline(efi_loaded_image_t *image, char **cmdline_ptr)
 	return EFI_SUCCESS;
 
 fail_free_cmdline:
-	efi_bs_call(free_pool, cmdline_ptr);
+	efi_bs_call(free_pool, cmdline);
 	return status;
 }
 
-- 
2.47.0.rc1.288.g06298d1525-goog


