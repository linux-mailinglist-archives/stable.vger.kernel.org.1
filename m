Return-Path: <stable+bounces-3667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC765801181
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 18:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CA7F281B93
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 17:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECA14E1B4;
	Fri,  1 Dec 2023 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zfbOFtmf"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F7210D
	for <stable@vger.kernel.org>; Fri,  1 Dec 2023 09:22:36 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d3911218b3so26197617b3.1
        for <stable@vger.kernel.org>; Fri, 01 Dec 2023 09:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451355; x=1702056155; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7AZjI8klObjc7N6sbmt2D6zbV84xPOc+qihwnfC0tTI=;
        b=zfbOFtmfyvO4ZrOjLgZTGyEY1V6pazwSXt6qa/ruhYmLkqlf+rIl7KQfVp9LrUaWFH
         Njxe2Uw59EOGdw751Es6BbLeGe79Eypggyh8Pc/pd4apjLriE/F44jgHB2l6IH+uiwOc
         NM15ZYYcuzU5UdyGPMRMTUkTZViMrJlNvq0MecIOFXYT3mW6FQWGCl3tKhF+KkGlnJtX
         vLdlU2UnDOA4o3tWSGMpH9hLw6bp7Nmv9vrZ5gBKrbZ+P3btrvZGnk6VaUgQ25dk6HV5
         VQp7YfP/awQD+R3ldma4K3VsM2hozUu13re3h1SfZmhIeudrTg2/JNMf+TIc2KP/VU2J
         pNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451355; x=1702056155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7AZjI8klObjc7N6sbmt2D6zbV84xPOc+qihwnfC0tTI=;
        b=vT7CGv/7o1FBgC5W9xfzZb0w/cLqwKhJpfLSSl6Hm/yHQe4rbobhon4dx2x1756QUs
         QPD4rZGuROC1ek5xapOrO+IEL8Uzk16WpYVkcLYijckImEBdW3Gcf/Lr0a4XdavsMU1P
         vnEPiSAKMoPTy+PYSw5iDM+cltg2vkUSpvbQxxhLlp1cxtAk5Y31qcYWsWAhpvYM6fZh
         zexWecge7QdH3p+HRRb+x0CbGIzAZ4bC1IgDLIXmB/J8VY+Zl/uEI8lhyhRz+TUCGhx1
         G97BH/PvvbAw0MwkFMC6NQQBJdchMl4jxV0WtBuh2y07iEV9geyoE7Nq4DYvU1dyD9Im
         z/Og==
X-Gm-Message-State: AOJu0YwUYW+jMo0jYlctcUDIzq/XcGgXj3lXqOQwdP+LvlB7GtExN8r5
	GC0HzQ9OJzmdDQV/3hnH/iI7k1YNrFqm3A==
X-Google-Smtp-Source: AGHT+IHjlNgO1/5SxxJWm9+fEpAT9H6aa9p5pj+fd3uju5TGuAZuKbSdeq0pNIcDZjKvXmptbIpeCMLeH61UKA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:690c:98a:b0:5d3:e8b8:e1eb with SMTP
 id ce10-20020a05690c098a00b005d3e8b8e1ebmr122038ywb.1.1701451355403; Fri, 01
 Dec 2023 09:22:35 -0800 (PST)
Date: Fri,  1 Dec 2023 17:21:30 +0000
In-Reply-To: <20231201172212.1813387-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231201172212.1813387-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201172212.1813387-2-cmllamas@google.com>
Subject: [PATCH v2 01/28] binder: use EPOLLERR from eventpoll.h
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Eric Biggers <ebiggers@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	stable@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"

Use EPOLLERR instead of POLLERR to make sure it is cast to the correct
__poll_t type. This fixes the following sparse issue:

  drivers/android/binder.c:5030:24: warning: incorrect type in return expression (different base types)
  drivers/android/binder.c:5030:24:    expected restricted __poll_t
  drivers/android/binder.c:5030:24:    got int

Fixes: f88982679f54 ("binder: check for binder_thread allocation failure in binder_poll()")
Cc: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 92128aae2d06..71a40a4c546f 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5030,7 +5030,7 @@ static __poll_t binder_poll(struct file *filp,
 
 	thread = binder_get_thread(proc);
 	if (!thread)
-		return POLLERR;
+		return EPOLLERR;
 
 	binder_inner_proc_lock(thread->proc);
 	thread->looper |= BINDER_LOOPER_STATE_POLL;
-- 
2.43.0.rc2.451.g8631bc7472-goog


