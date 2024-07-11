Return-Path: <stable+bounces-59161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C5A92F02C
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 22:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EB551F22438
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 20:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D895219EEA4;
	Thu, 11 Jul 2024 20:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4XhutoQR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A7A19EEAA
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 20:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720728908; cv=none; b=telDu+kO784k+N511KVlmVQNT51QHrnW88mDRpvqSw0XvGylGe0hibp6NLnsG0s6GoDOadN56KeEqoXD0v2pkL71YpJGDD9FWBtl2CCeMaAr0UxJUsb+7wH0mKpJpHv/YJRpCapLQrKWZ6lKgAFJIMf6shN4HEgS1r7RLu6+vtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720728908; c=relaxed/simple;
	bh=ffgWiw/ggc+SHGiICSvAu2BZVRSY0eNV0A13uMJMTZM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KdMWkk7zNF1GhHwC6/I+cEazGtd6EsYubjyk7fJ2t/cpi+l/r/9WVP/dukLftPkEFNk0Vhp1Zy8algk7pKFD2YLao4+9tNFI4cmdACxTi1/gPO0dBODzHIa8WMZzA3CxYWlSnMceA0vLHC8Gaj3y5d0FD6CLPL2mCDoAez9pL4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4XhutoQR; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-70b05300627so1399619b3a.3
        for <stable@vger.kernel.org>; Thu, 11 Jul 2024 13:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720728906; x=1721333706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VXAgzTWHJrrbxSWRnlwI50WSsE9epZDrGyk57jVBeFw=;
        b=4XhutoQRPe2mpoFMd8H/fUYCV4wNjr6plvgdL640reOHpKiqgPr1l8xcsaxItI5YjJ
         d5Tn2DMOrlMlRp/L7dEohF8j8M0hCkhT4A49pt2aTu0VXnxgqGdLRmbYj7NFcJEAueVW
         i+B91oDxtN/2HyA/ckzaN69gHRU1bswkP7LUGlE6XZT81gt8qbOxUxP6IqaZ9h4+gAZX
         KB/uq+mDEZ8llU8Ex53u1YnzkaKt3nJ3Bl5TtMyYneqmxsAaKPzrwBj9NyMrhz1WzVLK
         MrXT4Eg80ld1OS6W4WQGzTnpQ+1cEZcs8IHY5bmMuGgvJQBz7tjNDnOz7lnTfncUd3TO
         7kNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720728906; x=1721333706;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXAgzTWHJrrbxSWRnlwI50WSsE9epZDrGyk57jVBeFw=;
        b=F5GvFyIKjlgWfbOTdmjKWZGlXn6UBEhg85JxOb9ndE+fOQgCbn7JUd6y0Kyds0eyZk
         aEbcanPmkmaSlPJjA865X58XlQYvtkEULcoY7aWDzMglYhSzihYimMDhSRm8yik0RXV4
         xpcQ/mIxQ08zH3ezU7KGlDhdfW6lpV//D3P6K6+2KmZQTorIFDh8g7oMqB54jiZQw+MC
         R3+Y2jgP0YPI0tcZ0tjEq0EXoR5+Fv+rA1P5Y7Qc+DmIqyTPz4YRaz4Fc3ld4l6Vn6As
         yM83JZ7rSUNwBp7LqRTy2P3BUSgz/ZzGxH17Mvf5+cYkyCLGVd9MxTZqc2F82VtYZHr+
         qZQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV28ccBj7xPeFe21FOfrNQTKoHN0ug5ai9bF+R+H6NJqPLSGeVYNiqAazPPC70kiyxRvoXPY3St0K12qunp78vs6oUAWzJ3
X-Gm-Message-State: AOJu0YyDugiUy55t2+AVuiYT+btxlAyIQdXmlHfi4fYQWrR6sb1m2x4A
	Bs87+eQhdnPEicHWiWvo7dFUk/pOzokxGu6ukUgaXSgspBxrQ90b6ZzOaftMEk8KIqD+d1AK3GF
	KdBsy4XNMTw==
X-Google-Smtp-Source: AGHT+IFBCyEY1yOdr0AAGu6OKWjejGpwi7NWiZk/luxllujP0NWCAqvmTjyblFDDXC6rBpZzZb77yUZF7ajnqw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a00:9287:b0:70b:5392:5a0d with SMTP
 id d2e1a72fcca58-70b53925b66mr277058b3a.2.1720728905497; Thu, 11 Jul 2024
 13:15:05 -0700 (PDT)
Date: Thu, 11 Jul 2024 20:14:51 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240711201452.2017543-1-cmllamas@google.com>
Subject: [PATCH] binder: fix hang of unregistered readers
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	stable@vger.kernel.org, Martijn Coenen <maco@google.com>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

With the introduction of binder_available_for_proc_work_ilocked() in
commit 1b77e9dcc3da ("ANDROID: binder: remove proc waitqueue") a binder
thread can only "wait_for_proc_work" after its thread->looper has been
marked as BINDER_LOOPER_STATE_{ENTERED|REGISTERED}.

This means an unregistered reader risks waiting indefinitely for work
since it never gets added to the proc->waiting_threads. If there are no
further references to its waitqueue either the task will hang. The same
applies to readers using the (e)poll interface.

I couldn't find the rationale behind this restriction. So this patch
restores the previous behavior of allowing unregistered threads to
"wait_for_proc_work". Note that an error message for this scenario,
which had previously become unreachable, is now re-enabled.

Fixes: 1b77e9dcc3da ("ANDROID: binder: remove proc waitqueue")
Cc: stable@vger.kernel.org
Cc: Martijn Coenen <maco@google.com>
Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index b21a7b246a0d..2d0a24a56508 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -570,9 +570,7 @@ static bool binder_has_work(struct binder_thread *threa=
d, bool do_proc_work)
 static bool binder_available_for_proc_work_ilocked(struct binder_thread *t=
hread)
 {
 	return !thread->transaction_stack &&
-		binder_worklist_empty_ilocked(&thread->todo) &&
-		(thread->looper & (BINDER_LOOPER_STATE_ENTERED |
-				   BINDER_LOOPER_STATE_REGISTERED));
+		binder_worklist_empty_ilocked(&thread->todo);
 }
=20
 static void binder_wakeup_poll_threads_ilocked(struct binder_proc *proc,
--=20
2.45.2.993.g49e7a77208-goog


