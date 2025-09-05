Return-Path: <stable+bounces-177819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EA6B45903
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 15:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842301B210D4
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 13:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A02352FE2;
	Fri,  5 Sep 2025 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LtvAR4/W"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6642235206C
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079050; cv=none; b=GIq0wKdc1LQk6CZAuaibSTrNLA+JTfg0AY1NRjzzLxhItc4ZFTNji8j4u+bW0ZSuDbBfP3LtHovBtTbfP9alE132T2h1JJ2ajF0r6Mo7rbXQX/2xk2URgVsl4r/OOAT5Zm2f7uYvbF2ROWaSNTO7fcmAnFpYqB8EyAVDeW5EvAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079050; c=relaxed/simple;
	bh=ECzWVd+AzMHGkO1axC4Nxd2WiHY2CoMBXtmHlgaGTvQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GffghDlw0juRggT6hrSrMJmXb510OljLlQKbopN8En/MXU0F6iEwfRujiO1ZD/jAA+Fmrk5lItxXTzKj/75uaLrbbH9Yj+BA6U0YdqIorJFhERZs80rm+o8A4UOwfNm2AdxtELYVe3VUpM7Xd+YjUGZ9zafwONSQ9X/siO8DgHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LtvAR4/W; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45b9ca27a11so14548685e9.1
        for <stable@vger.kernel.org>; Fri, 05 Sep 2025 06:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757079047; x=1757683847; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hFUi3FlPm9KOXLVkivG1TPAn4U/BsKfwoh1VfKcakJg=;
        b=LtvAR4/WArVQW1TnlYFCe/2oMHGblFXcqmpbcORaMDW8BmbYYVGxY1VA8sSIXH3zP8
         XNLPcyg2xUzO5op/qC3u4P2F9aq1fD/OBY2HDUql2wzHzI7o74ywaelMUE0S9b5dvtkt
         aNdRXPafJf7Rm65g9sgv1WTg79dvsC6XvmCh/R/9+Gd+Y7XO+ouMZrsBGdUE+dKwmBaS
         yedP6cvdZziv8YiF6reueLrnB2pcDFS6eyk6xTMpHa4T7qhBehE/Rfo5bIiN75MiOytm
         lK0a6yziAtk8Q8Q4Pv86lFMcOkD5H7LYGT9oJIDTydbsRI2O07MYET5h1KSV17VWudqW
         v2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757079047; x=1757683847;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFUi3FlPm9KOXLVkivG1TPAn4U/BsKfwoh1VfKcakJg=;
        b=NJeV+XFL4bXWuOHCniUXHs4KqrFP/pYgi5I9veeOYw4Y9Q4JtoOOsSN2scBArQJoIc
         Q9SKbS9RzimL4Z6ZeRVq3ZIx2jtej2lmiN33FdS3Rnv2Y/NQxlQtiBH/2J+vuD45qMes
         PciReDyFfrwno5MtFxXKdViVA5IKu7Bup++1sP69df2kGtXFJmjMA5/xbdm7gLH/fRh1
         EA4JYKxbsiQDEPx1cOSuTiC31wOHcI+JmtdsDiuvAvkMQyEpHejtCush+IdH5P8s3QfV
         BFThaFz0X8pUMXa7E63iJvNZZP6Mq/Cw8OAUr2gOimA2vcoGUSf68WzWwBVjNlq+tYON
         VH6w==
X-Forwarded-Encrypted: i=1; AJvYcCWj78SASxNoruEVstKlDrnGLRIrdwc/OhaCvWFTNq5LBnrFqLWRGx4F5Xw+zrMK2FnC57KSk/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4V59p8lUIsZwiWBMnmQDqF6HtHKL+tfrIUnDk5L7I1dZZ00qV
	hliglzt0J90bJ3ugNqj3n6A7pI4tDCVbr1aAGGJ2A+E6Mxo0wptH7VlOMxAnk7Cs6FlMmc5Meg=
	=
X-Google-Smtp-Source: AGHT+IGf+vRi3XmR/QGP16LgsrUNxoVVujkhlQmO0eAfjGcLlZWZe2h4Qdaq8UaJGcAf86n7aeIE74J6
X-Received: from wmbez15.prod.google.com ([2002:a05:600c:83cf:b0:45d:d3ef:abb8])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:35d4:b0:45d:d259:9a48
 with SMTP id 5b1f17b1804b1-45dd5b456c0mr26381175e9.9.1757079046680; Fri, 05
 Sep 2025 06:30:46 -0700 (PDT)
Date: Fri,  5 Sep 2025 15:30:37 +0200
In-Reply-To: <20250905133035.275517-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250905133035.275517-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=804; i=ardb@kernel.org;
 h=from:subject; bh=RXdT7wNu/pdGAxus7uiLMzLf2wBNTNItEYxQJXgozmU=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWPX07+PF7pdfzyJ+/va/jMpCWVesYfLU/VO3srL2bJD/
 4fqsgueHaUsDGJcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAilj8YGT493y9u4lk5z1xi
 txTTy/Lzcl7Ji9u4P7zflnZWYklnqS/DP93qaRt32exPZ3yexOYXL//w9rNPK+5sdlVi/yC+SiB rAicA
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250905133035.275517-10-ardb+git@google.com>
Subject: [PATCH v2 1/7] efi: Add missing static initializer for efi_mm::cpus_allowed_lock
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Initialize the cpus_allowed_lock struct member of efi_mm.

Cc: <stable@vger.kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 1ce428e2ac8a..fc407d891348 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -74,6 +74,9 @@ struct mm_struct efi_mm = {
 	.page_table_lock	= __SPIN_LOCK_UNLOCKED(efi_mm.page_table_lock),
 	.mmlist			= LIST_HEAD_INIT(efi_mm.mmlist),
 	.cpu_bitmap		= { [BITS_TO_LONGS(NR_CPUS)] = 0},
+#ifdef CONFIG_SCHED_MM_CID
+	.cpus_allowed_lock	= __RAW_SPIN_LOCK_UNLOCKED(efi_mm.cpus_allowed_lock),
+#endif
 };
 
 struct workqueue_struct *efi_rts_wq;
-- 
2.51.0.355.g5224444f11-goog


