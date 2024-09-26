Return-Path: <stable+bounces-77845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515CE987BE1
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 01:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1676B28517B
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 23:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105FA1B07DC;
	Thu, 26 Sep 2024 23:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v+y4tOKd"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719821B1D5E
	for <stable@vger.kernel.org>; Thu, 26 Sep 2024 23:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727393821; cv=none; b=otlyo8s+4FQyJuqeTgqS6ZK6iaYpHiOt2YAs6JmCgOtDJSgElksNvC8hWrTBuY91e5H3ESM42nUbTf6WDlJxBSNG+aJNRRvNxh5FR8HY0+QICi1IGPCPWfcj5gJ3oYyb4Q/YKlGrK49qzg0AT2qSoYxHyiEneLk0INzuJDlHXd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727393821; c=relaxed/simple;
	bh=0wQLZGUBmhpsm/PqIKgF4vhryRNNUmvmm5suV7LfdPQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t0OCZoMa6xPw4c7UWwPIc17j205jGc9pp3819sA19mLZJHAUr34O40pFXT4GCTJxzV8o78UzUvikbnS8VB1TGQXyDwFY7m/421A9nWv7uqf6Lpe4SNSgCQQ9ZlIW3f1QlmoBARGmI7rSohCZIpxv98x03f/25dGBqIhu1qP27bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v+y4tOKd; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2261adfdeso19351647b3.2
        for <stable@vger.kernel.org>; Thu, 26 Sep 2024 16:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727393819; x=1727998619; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RfIWbsqxtW/srupdqZRxObhE1OoVW4h9NYCU5IwMPgQ=;
        b=v+y4tOKdaF3SUrMHGd6o3rLp5EsXosURuPJxpDqmxaa5y1f1VTif/sCjrXMOGiCyWI
         XXnI9AE7aZQGpPkqvsfq/70aYzDJH+IPrIkeI/g2/BD//I0sPvTu+Ams+Iw6g66cEKmq
         ELNNbrLcYJ23/x0/RBKqXq3uEZ+Ew550Wqu3WsNxWmmRhmFumq39Y6lw+Uweuu5xlMNp
         Y3KqNcUMfDYEHCzU9dWpDpeAMQ8F5fjq6J5WD025+Tx8LbijubWXtbEsUQToADagwgAs
         8v7KApAG7TdT5SnFOAkMReLL3iGuVU6/SK4P+FqHN12GZ4+pai4kRslx3WBOwuGK8x26
         dAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727393819; x=1727998619;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RfIWbsqxtW/srupdqZRxObhE1OoVW4h9NYCU5IwMPgQ=;
        b=ftWkA+nQZBLw4nDisjtBQyUC/Fm2mbzSkO7295Ly3K2FWO/uVXrH96PPD9AYMZfF1I
         gxN7swriz+P8nbUEyv1oShhVlCTbKo2aqVZw1PlSu+FdUoYwtCGVbD/w/FoU/v9RL5go
         VjR9/BPb+v4zX559euYIlASdzgas8AOHtH9eV+pDoJ/LLAcg7KZ2FsJrm/DFCfcBjBg2
         YEO7qlxFD1sTasOOoyqJ7I9PF079nXD3yqBUXNGQossNXoWhDGTrQP8e2EQOEitY4xh+
         vdIWM7SWRCW1QRrD1VV4yGXRhsbdsvyOWgBnakoHc5dXAhCmJUiKCND7KcojHl/y/BB3
         uZHw==
X-Forwarded-Encrypted: i=1; AJvYcCWoWNXwsWxKVE2vGyinCiwibimrdbnbYuCW81NdM3e6G6pNWx5yq328bItyIYFYcRGKmljnNVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfbHuREq5x6aoPiMYlImQB1oiYQlG+/uKjyLbZD4q0EIXFti15
	M8UAvkIB2ItqjxM4TbqE/rVVdH/x9rPgDM3wfcDN2eEFDszoIphWwERm5ipXxyXKa6XonMcBnTp
	RnuL5QCme7w==
X-Google-Smtp-Source: AGHT+IHqSJVku0EWEj2r5XcqywvzRvQB0jNHyuhNh9+DFeKP39ZT7Op+9wJEbEIowlN2bzx85VbN4A6f+KQP5A==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:690c:3708:b0:6db:afa4:75d3 with SMTP
 id 00721157ae682-6e2475a7f21mr434807b3.3.1727393819526; Thu, 26 Sep 2024
 16:36:59 -0700 (PDT)
Date: Thu, 26 Sep 2024 23:36:19 +0000
In-Reply-To: <20240926233632.821189-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926233632.821189-1-cmllamas@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240926233632.821189-9-cmllamas@google.com>
Subject: [PATCH v2 8/8] binder: add delivered_freeze to debugfs output
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Yu-Ting Tseng <yutingtseng@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add the pending proc->delivered_freeze work to the debugfs output. This
information was omitted in the original implementation of the freeze
notification and can be valuable for debugging issues.

Fixes: d579b04a52a1 ("binder: frozen notification")
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 7c09b5e38e32..ef353ca13c35 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6569,6 +6569,10 @@ static void print_binder_proc(struct seq_file *m,
 		seq_puts(m, "  has delivered dead binder\n");
 		break;
 	}
+	list_for_each_entry(w, &proc->delivered_freeze, entry) {
+		seq_puts(m, "  has delivered freeze binder\n");
+		break;
+	}
 	binder_inner_proc_unlock(proc);
 	if (!print_all && m->count == header_pos)
 		m->count = start_pos;
-- 
2.46.1.824.gd892dcdcdd-goog


