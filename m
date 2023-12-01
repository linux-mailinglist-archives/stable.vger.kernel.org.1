Return-Path: <stable+bounces-3670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282A3801187
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 18:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2458281C36
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 17:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5BB4E1C2;
	Fri,  1 Dec 2023 17:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DPujzvQX"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDFD10FA
	for <stable@vger.kernel.org>; Fri,  1 Dec 2023 09:22:49 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d1ed4b268dso41482717b3.0
        for <stable@vger.kernel.org>; Fri, 01 Dec 2023 09:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451369; x=1702056169; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i8lzNNyGh9YxFrbdbNM0dDCNT8qnC2FAkz/L9borbvI=;
        b=DPujzvQX/ijuvdElTrA+p6r+aHAN3CRTOq14R2EmCz6skT8/TO2GM61SIKl1qeXp0n
         fZ+Pr+0z6gznhqPFzbLfO3bTNj3zpwqWuNnbhpot4Zx9rOtr6YPGSzWO9pzuzadOARX4
         re7TI5zrcG4CGCpmHyNLCOJMRuXQXpPFqOh6MIXUZecKgXgZ9/3NmHHvt5rBUAVEIdzN
         b6q6wKVD7UwiSDrsCt9TdgAyXDW0ml9LncrmJSrtgUTZdEPk6AREk9ex1FLh98lOxg/V
         NnwLVqVLzSDFrHWNokgl8dWnxFqNYrmBTHKU3GsEppIEvIf/6yHOa/tx/fRJkBaIsK67
         9/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451369; x=1702056169;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i8lzNNyGh9YxFrbdbNM0dDCNT8qnC2FAkz/L9borbvI=;
        b=pN3vzT/6v1u9sh+sK9coAP4ixc+x6gRa4J5EgRp30nJY9eJGwnBPl3e5L/j15Xx5f8
         dyElDQuNpH5IEKlt+L5429AJvv04jpGqvFmcr91kBrJftfPYSVpnkVkiiXzpWpooJBCq
         jtdyN8AIjcGsFQS6idypn9qVD+sc6CsVw98K+cOp/yHWo6y4dwvKCX8J+tiXrU17O30i
         OUZvK+xl0UBe5LD/toCVwRq2mjKVXgNrYy/hFmyoz+ruiPNNt2l6Z7p0oYHeZ040WWgo
         e5b3u+6IJOU2argr5voCGIlndYJWI7iO9eOxLIn0Hu8kjd6V5w8dnyEPai0dBJqnOiA5
         PmHA==
X-Gm-Message-State: AOJu0YzeJC3ch8MDuMA1aHF2FdiAd+SjcpKW8svDJFVZHIhAcz0zFq44
	4aAEPwwSazDLM+ID58Uk6GM04h+zVSwAdQ==
X-Google-Smtp-Source: AGHT+IHjF+ng2E43F9BQKf99LVucEjoO3ykuz42nnRR7hpAJ0pBW2m6GsFcflbGRPtHvtKawEVX1SCXVdvfftg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a25:d6c8:0:b0:db5:452a:8e4f with SMTP id
 n191-20020a25d6c8000000b00db5452a8e4fmr171087ybg.4.1701451368959; Fri, 01 Dec
 2023 09:22:48 -0800 (PST)
Date: Fri,  1 Dec 2023 17:21:36 +0000
In-Reply-To: <20231201172212.1813387-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231201172212.1813387-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201172212.1813387-8-cmllamas@google.com>
Subject: [PATCH v2 07/28] binder: fix comment on binder_alloc_new_buf() return value
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	stable@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"

Update the comments of binder_alloc_new_buf() to reflect that the return
value of the function is now ERR_PTR(-errno) on failure.

No functional changes in this patch.

Cc: stable@vger.kernel.org
Fixes: 57ada2fb2250 ("binder: add log information for binder transaction failures")
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index a124d2743c69..a56cbfd9ba44 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -556,7 +556,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
  * is the sum of the three given sizes (each rounded up to
  * pointer-sized boundary)
  *
- * Return:	The allocated buffer or %NULL if error
+ * Return:	The allocated buffer or %ERR_PTR(-errno) if error
  */
 struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 					   size_t data_size,
-- 
2.43.0.rc2.451.g8631bc7472-goog


