Return-Path: <stable+bounces-33846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B915892CB0
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 20:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C57CE1C2105A
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 19:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF753D0D2;
	Sat, 30 Mar 2024 19:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jupwujvK"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47EE1DFD8
	for <stable@vger.kernel.org>; Sat, 30 Mar 2024 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711825283; cv=none; b=PT2qGFQwXQJNVI9JU0Jg9zB+eRegg/2SFR1VJrrc+ddGSlNVla/6guR2qTcJVun/QsAOdcTlkxoVnPzc4sODbnniOGO7RKRAXxjU5qaO97OPa48rQg8ZVwoB6FYAabHu3OdBPM5LPYYe9IYpHto2iCYSQ/vyV5t1MP5NttFMlgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711825283; c=relaxed/simple;
	bh=V2ie+7To0BYnGaA6Bg61VOEnzM566Eh9HqIPS/sPS+E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=L421+3UV7yZ8JV+FOcqzpbi+4H0+ZuLbT0LFqh98SCSI74GLVWgAEfwKXdU4ucZlB3cY5Ed1t9Jd+m60FKHMjlRN5gB3libmMnv91she4AyvT5SfOpE1zX5Oxfe+2igWt0xjKFKbVgMxnZWwGcx6Qi7cL0P/aNTAy1IdiZZyWtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jupwujvK; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dccc49ef73eso4096957276.2
        for <stable@vger.kernel.org>; Sat, 30 Mar 2024 12:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711825281; x=1712430081; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EiiUPjGvLxIO9csQLAqCT44/6WzHuWbceesLPgGHvn4=;
        b=jupwujvKPnEVr2547uOoND5rz7a1jnBe4iYdLzn0DwDqqtOFav7gqR2ZbB+xUpXznc
         LvqmYp7LKm9Ep9L3WbzfHi5WWQ0xMPI4ZomJFZ9BWcbsbVGhxFAXrlJF9mK9zOativXl
         oeb5F8+RD9QNyokiyTZDDcJX9hvAdT28bUEZQd8gdZE0Br6F7EZJCGeETt1G8McB7V1V
         QxmIvA496wAQ+w6bk7q4TfU3vsUKAkmZcgBSv5oBjkJAlcEh/63OHXqrPCWfF3Spmmlv
         9Sq0crdhNlxIU/F/SVuqAAlPFuOAQTz+RdL0w/fEfnVyt5pSe4nZ2fzu+wuDIY1LAB2N
         BIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711825281; x=1712430081;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EiiUPjGvLxIO9csQLAqCT44/6WzHuWbceesLPgGHvn4=;
        b=VMMNvHt7AzMIhjJobdzbKA9cHRAOPrx4KBganw6QRJ/GXuCLa5tA0xtANPpioSYy+m
         loxAFf93THzwVNDX4tnXw+x1GzCGreDyq/gskvTQL4oj53MIKXakj1rZ/qviNp2zW7fv
         AyoX80SiXJLwWVLkBgLubpmxWkx/kAXcOz9DTNNrOVAz1MnGLhjMyJteQDEFEXRD4WUe
         sFoiB1R+nJMTN4HOibrS4G6w6HQONUn4EK/N0vL/y3n1V6LUjazmQVn8qxk41EhrX9jd
         bGRDvmbAHnsShtRzsFrZJ9qUD4BG3uDNycqc6X8pUPWaw3Xvrogj0s9l+hJAnG+4cCGB
         c0Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUVgqNK1jjlJlf9+ipj5h9bOnPSWaw29cg5B2o0OTzsT0uMmKJsFCdRk7btxrXmwPI3eQskDci9JHikO82yQxTVitB+Y3VW
X-Gm-Message-State: AOJu0Yxi3HeoiYuF/Ln2cBRzHTE3mzVt+uZitI2Wi+Uv1FCbA3xca446
	X39unFut4JQKcvPMPKEAQcO+daSBLyjWE8hP9RihrKBZ5cv/SSWJHzWESThfr5VmjFQ0DJHfP87
	oIuKC1hKmPA==
X-Google-Smtp-Source: AGHT+IGDyyYN8rAC95fI7H3o05Eg+AmVi+hqzqOIA1YgZfoKA1eomN3IPZFZ7c7IcDrwBZEVCwChOjjsodo2HQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6902:2309:b0:dbe:a0c2:df25 with SMTP
 id do9-20020a056902230900b00dbea0c2df25mr502653ybb.8.1711825280848; Sat, 30
 Mar 2024 12:01:20 -0700 (PDT)
Date: Sat, 30 Mar 2024 19:01:14 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240330190115.1877819-1-cmllamas@google.com>
Subject: [PATCH] binder: check offset alignment in binder_get_object()
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 6d98eb95b450 ("binder: avoid potential data leakage when copying
txn") introduced changes to how binder objects are copied. In doing so,
it unintentionally removed an offset alignment check done through calls
to binder_alloc_copy_from_buffer() -> check_buffer().

These calls were replaced in binder_get_object() with copy_from_user(),
so now an explicit offset alignment check is needed here. This avoids
later complications when unwinding the objects gets harder.

It is worth noting this check existed prior to commit 7a67a39320df
("binder: add function to copy binder object from buffer"), likely
removed due to redundancy at the time.

Fixes: 6d98eb95b450 ("binder: avoid potential data leakage when copying txn")
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index bad28cf42010..dd6923d37931 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1708,8 +1708,10 @@ static size_t binder_get_object(struct binder_proc *proc,
 	size_t object_size = 0;
 
 	read_size = min_t(size_t, sizeof(*object), buffer->data_size - offset);
-	if (offset > buffer->data_size || read_size < sizeof(*hdr))
+	if (offset > buffer->data_size || read_size < sizeof(*hdr) ||
+	    !IS_ALIGNED(offset, sizeof(u32)))
 		return 0;
+
 	if (u) {
 		if (copy_from_user(object, u + offset, read_size))
 			return 0;
-- 
2.44.0.478.gd926399ef9-goog


