Return-Path: <stable+bounces-126626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D1FA70993
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 19:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098583BF9CF
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 18:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A4A1A3157;
	Tue, 25 Mar 2025 18:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4EYSlkYM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEF51A3154
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 18:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742928551; cv=none; b=lA3Gj9/D2n3zg4btg3ODjKvS8HNHZN2fyKCXnaEvQh52V25KfWaEakXBNyWaecWUHtOEwzaYE4J3cSA8Rs1HAetwt52hsfTkx0nfHHSNydSOebTrPTJol0hQfr/FVv6xo8ZbEUwDQGdbdg0ttDOgM2rTd4E7pIrmidX2trQPUqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742928551; c=relaxed/simple;
	bh=6AKG+4MIU3nFkzhQI1KPFHDmJM4sAAvKCqzFZ2pchRM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=txidOAl/EG8JxGGf1o5Kg5qg+VV0NswUkfTsopq7dzX7JpzgtlmW3/7IYC79HvTulfk28DdJOtjDC2mZZIMC9H74lpOgHTJakN1jCZKx3jyvRQ4cfS53MoLlWiF/zZ62I0TmhOueu7PX4VjrHSRt/jPUU7Wejw6vE7gNeJ1B1OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4EYSlkYM; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-300fefb8e05so7589456a91.3
        for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742928550; x=1743533350; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+GYzbbMon8zBFYnMfBByCIqb+0VFAaEep9NdHw4CNu8=;
        b=4EYSlkYM2zHNZ7lYAjytaJNEMkXEMarq568obbxlDzWgGhYw1ENd9KHYAdzDO4eZOH
         0sJU+cAfUvnptluNFYkQlUv/RLSlbEUwYOs1CXxv5eti85XxvsENNv9Z7dI9nU7K+Sbr
         AicBI6jq9u9tQbarHeBaCXzOA/7MexU7CWJ5W+T0S7YWXzK9Ik0XNXgqQFHDbmW1Mqkf
         A7Ko3mNOfDR/VQe0cQnCFzsE0VMsu9WXHj9EYey3O+xd8OUYzDzwdFsso6QV22dBIa3U
         FdK4I+V9K2rrREbQTXUO8npkuVH4l02Fk4jP4Td/nQg7jCLgOIq8C3Ftmc4npnmF02Xq
         3gvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742928550; x=1743533350;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+GYzbbMon8zBFYnMfBByCIqb+0VFAaEep9NdHw4CNu8=;
        b=QUVFfu3T3In1ABmkmrlcKDGbubhQQrzknM1BfYUDYWfmLXD6jM2yt0xTs13QzfUlMx
         v0PU7MYAf75fbqDUQbbnCeJre4UWRN40FeJ82a006BTVCHGenMUj+1X8+q8Rc1kpEekL
         zjrHJZDB4TsY0wFeJ7d1rrpuOF9QzEGuwCtyZeed28z7vFwT9/tInJkeTm7+4i4sxocd
         RF8iP4OgolSC3bpoTyUzSNlrO9womzeYCl8MGosoRQ69IyxW7DBhyURZMzAmZHXn0eRC
         Ow5U68SEdKtKYiSEtMCy569ArteA47+f96NsO8bMwctSLxQJgN9sKHxijLWtRu4jar+M
         MzCg==
X-Forwarded-Encrypted: i=1; AJvYcCVk41MuoFYYKZeipnAy4IQ+PDXPkbNg9i8qRgOnCfpIqo7xMeJ0VgUTN5IPRx+tT//+SQvBiWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKXRGoqij0fSHwtca9oK6VnS06IVRA3J7oFhMIFL7o0gJ8QUEs
	gYvrI9NNn2dCXqik1u1ecZNxcLoyCUzN0iQjYm4D30zX7OSvPbUX/MHnXEd6+gIAtvNXmfhsTns
	IqoNw8OW/9g==
X-Google-Smtp-Source: AGHT+IFLLKVhdVugqD5pcE0y+fL5jXQTQK+4ePWC9LHMiExN+AlvX4zavqO6tq0PKuWuySMriKun4+wfAAS6zQ==
X-Received: from pjm7.prod.google.com ([2002:a17:90b:2fc7:b0:2f8:49ad:406c])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:134c:b0:2ff:53ad:a0f4 with SMTP id 98e67ed59e1d1-3030fe93f0dmr35266909a91.12.1742928549694;
 Tue, 25 Mar 2025 11:49:09 -0700 (PDT)
Date: Tue, 25 Mar 2025 18:49:00 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250325184902.587138-1-cmllamas@google.com>
Subject: [PATCH] binder: fix offset calculation in debug log
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Alice Ryhl <aliceryhl@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	"Tiffany Y. Yang" <ynaffit@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The vma start address should be substracted from the buffer's user data
address and not the other way around.

Cc: Tiffany Y. Yang <ynaffit@google.com>
Cc: stable@vger.kernel.org
Fixes: 162c79731448 ("binder: avoid user addresses in debug logs")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 76052006bd87..5fc2c8ee61b1 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6373,7 +6373,7 @@ static void print_binder_transaction_ilocked(struct seq_file *m,
 		seq_printf(m, " node %d", buffer->target_node->debug_id);
 	seq_printf(m, " size %zd:%zd offset %lx\n",
 		   buffer->data_size, buffer->offsets_size,
-		   proc->alloc.vm_start - buffer->user_data);
+		   buffer->user_data - proc->alloc.vm_start);
 }
 
 static void print_binder_work_ilocked(struct seq_file *m,
-- 
2.49.0.395.g12beb8f557-goog


