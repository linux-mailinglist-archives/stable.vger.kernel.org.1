Return-Path: <stable+bounces-12722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE9A836FDD
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 19:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B33BE1F2535F
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 18:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7622E50A8B;
	Mon, 22 Jan 2024 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NghnwhR7"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C0D50A77
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946277; cv=none; b=rLkg8fFl4e7oucSml37snNtKDyW9jTClYxgwVbjmOJCJzxbAIbeKsKPzb0P95xPWVEGbWSEHoLslJCva8manXx0uoU0xfWGEtJEO7HQIVCWsOnfJZBFldEc41NIrviw/k9V0XO70I4EmLDQ5LP2hHjpsEkiGTlY02jZA1G5XlMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946277; c=relaxed/simple;
	bh=U5+97DemS43JKszALXFmtzwUOeP3DesFIJ8rwcAjs8g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qJ2eqe+fdblXSZcsGjTFZjsj2ocW9LdHhaS9XYBlEanZ9qm9x/sm/cQVvOg1YUiggHRDEuaeRKWJpLDY54J47lj0WQFA5FNBjniuHdfhfvTyj4xGW7jXxMJNXctkqywoZn0c1FYkNNRzjUh2G3A0kckpiNYnbdEGn3sXuoeyrII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NghnwhR7; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5eba564eb3fso54830707b3.1
        for <stable@vger.kernel.org>; Mon, 22 Jan 2024 09:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705946275; x=1706551075; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tB67ZYlsefMkFYw///200y2aHKd0ZHowVf426/MdPcE=;
        b=NghnwhR79vkhdMhMDpMvq0cbETa+ixvU1vC8waVZhl6KEfogl6xxu3AsmwJvbfqkRA
         k7m8NODuqnxyKyq88yRPhLgq9eS5BD86QAFEp7rlh9OPS50aDr4SfdvijyLJ+V6oikX4
         0gBqvoR5TCDXtZ2PumrN7qfWUTAF6Y7xkJLVb5mGsashoW6RsOSfnbOzR+pcficO28kC
         QqTFc6yQD/IbRI8R/etV+7laiUqE33Ule6MGHdmsDmYikVfgIadM1RHnehMy8PYCmvtV
         CSe9jZ64EAi+tco1Hzn4m4ZSLRXUMs59srKon03uDOOTJmk0uei608+Q8byk3KXaU+Fw
         CfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705946275; x=1706551075;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tB67ZYlsefMkFYw///200y2aHKd0ZHowVf426/MdPcE=;
        b=HyJT4Saf/GA+1m+Qhki3RggjvuUPpLdEBb6u2DKqsUJAS+jJUu123zCkQBmrKxez1k
         59esxlmssaoBgNF74x+b6fQG068pKPqduvX/woc45Yt9l3LLwblBEuw53KAAtl+UR+a+
         pP1Roqz6HynpO8gM7h+Perbp0ABC1mrt8RtdT1Ud6oOB5wYPJDszpUgSDpcrR5Y1CxEu
         TqKQo2A9mUlkYem51vW5xyncC3oPYXYZJeGD2GcTgvLXdGjr4/sM7HZo4TFChpOOGR4M
         4+y9ix5hJ6x5LwZ2KCmEcV9+bVt2JCOOr17v/oWvces89DBdpxiB6mt/BqR6GulzTzeL
         B4vg==
X-Gm-Message-State: AOJu0YzmB+gP16rVG5yo9fXjN1hT/2kqKZ9JOLA97TPYkXdiNMujEp/G
	9xwIjAIYSkamg/IceZPg/OLUJMAUbfeqmUYYzBn6lFM9tElC1gYN45fAMk84QeefnaMSc98ULF4
	2MNO0IM3okHPYI1Rr3Es/zwxeL42jmH93P0IO5aLPrdLfsJ0XxwvqK0By0+RULePsPwuyDkvo4A
	ePnttkNavcZsWvmRGe7YFL/tHQVJQU5SjS5z0Gi9w/b0w=
X-Google-Smtp-Source: AGHT+IEolfh7DHvobbaC2YQXa5IWDFMJm4RsjRRmbHCYEkSFJqVolp324aXcdUyzcYFB0/OqNhswoTbn2Sb+6w==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6902:b16:b0:dc2:5510:4a55 with SMTP
 id ch22-20020a0569020b1600b00dc255104a55mr2046636ybb.11.1705946274806; Mon,
 22 Jan 2024 09:57:54 -0800 (PST)
Date: Mon, 22 Jan 2024 17:57:50 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122175751.2214176-1-cmllamas@google.com>
Subject: [PATCH 5.4.y 1/2] binder: fix race between mmput() and do_exit()
From: Carlos Llamas <cmllamas@google.com>
To: stable@vger.kernel.org
Cc: Carlos Llamas <cmllamas@google.com>, Alice Ryhl <aliceryhl@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

commit 9a9ab0d963621d9d12199df9817e66982582d5a5 upstream.

Task A calls binder_update_page_range() to allocate and insert pages on
a remote address space from Task B. For this, Task A pins the remote mm
via mmget_not_zero() first. This can race with Task B do_exit() and the
final mmput() refcount decrement will come from Task A.

  Task A            | Task B
  ------------------+------------------
  mmget_not_zero()  |
                    |  do_exit()
                    |    exit_mm()
                    |      mmput()
  mmput()           |
    exit_mmap()     |
      remove_vma()  |
        fput()      |

In this case, the work of ____fput() from Task B is queued up in Task A
as TWA_RESUME. So in theory, Task A returns to userspace and the cleanup
work gets executed. However, Task A instead sleep, waiting for a reply
from Task B that never comes (it's dead).

This means the binder_deferred_release() is blocked until an unrelated
binder event forces Task A to go back to userspace. All the associated
death notifications will also be delayed until then.

In order to fix this use mmput_async() that will schedule the work in
the corresponding mm->async_put_work WQ instead of Task A.

Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Link: https://lore.kernel.org/r/20231201172212.1813387-4-cmllamas@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[cmllamas: fix trivial conflict with missing d8ed45c5dcd4.]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index d0d422b5e243..d2c887d96d33 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -272,7 +272,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 	}
 	if (mm) {
 		up_write(&mm->mmap_sem);
-		mmput(mm);
+		mmput_async(mm);
 	}
 	return 0;
 
@@ -305,7 +305,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 err_no_vma:
 	if (mm) {
 		up_write(&mm->mmap_sem);
-		mmput(mm);
+		mmput_async(mm);
 	}
 	return vma ? -ENOMEM : -ESRCH;
 }

base-commit: 9153fc9664959aa6bb35915b2bbd8fbc4c762962
prerequisite-patch-id: 040c7991c3b5fb63a9d12350a1400c91a057f7d5
-- 
2.43.0.429.g432eaa2c6b-goog


