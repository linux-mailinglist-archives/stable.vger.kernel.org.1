Return-Path: <stable+bounces-77842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F9D987BDB
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 01:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8482856BF
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 23:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF52A1B14FD;
	Thu, 26 Sep 2024 23:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TAia3TOJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443D41B1416
	for <stable@vger.kernel.org>; Thu, 26 Sep 2024 23:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727393813; cv=none; b=q17rUaX/81W/k97mOJX1Dg1Wki4UbqTgcYtVJWn1Izjb8GATn+vnFsg9KHOjqFDbJR2TNofBBJ4FqnmoqHrpCKwE+h5OGjTJwNnMA42uQhPvJ1XVjRedWvceDo/2pKy4ySCC7nLjLoV1vD4VSHJIlodolk7w68sYLIXKoq/cMIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727393813; c=relaxed/simple;
	bh=f7VrQlEy1/WaHjI6BjRrvKo4WMJTCtdwmzr0sL5N1Rg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r0G6yPFhm5H1o6Wj6rD9Zbq6/osV39xnQu3JMq8ROBxsygWMSzN5SgVh2DFtNKFzByj0A84u7mq8WxyudgtXwWU2f2ERebLKJkccI19CvzUytTM41ruLpnNhJjonAbQuh5lSo8NZt3TuTtU0ToSeJjqqWH2iDeEKqWvgwuWe87E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TAia3TOJ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-718ea791e44so1786842b3a.0
        for <stable@vger.kernel.org>; Thu, 26 Sep 2024 16:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727393811; x=1727998611; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QFVmoAK5zkzr/xbof5li/DUKAdhKAj2qM3wGvCeB8ZU=;
        b=TAia3TOJ49KoW9vIiTpis2EF6bfUY/dMv75JdCQfEmYJJgW5qqfXqZiYguwSk8P++J
         tOHODFTahGwmH+Pfsapsb43OCmcZyh9/ZgIxOKOnxESLUGcjpZkcvlKLhB1anu8OxL+g
         lSU1xCAbHvEWK+qBe4S95TLV5soup8t2KtyEU07kY+e68OcO3O1+hCz/XrrIxlRgi7Rf
         k71EQxEGxEt2/4xSBbGX+yttMpPL0IP0vNp7sVmxNsio3YLaDcYlBrAMwFoghcYv2Sk1
         7dMWP2l8XHpkqmgA1bZDyvK4U1zuwvvbcvMATEMw25Dd32oNyWKxF3JNVjhko5M/JE2E
         PWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727393811; x=1727998611;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFVmoAK5zkzr/xbof5li/DUKAdhKAj2qM3wGvCeB8ZU=;
        b=PAgw5SKVfj2Nu4gJmuIwVs0oe4Tv/w2S44hOhIh56xVTg151SWf6+v959zSqvXgsbl
         iHMH4XL5EGn9QASVSQsOyJnvFqrwqj6l977x/ZZ+IkaUuMTpgUA0YNaYcFMEnZhZWBeH
         BXY1Huiqvw1+hOLO2XyeC6KqCqHnjqNi8u9ZTFXV2QMLNsHLyjpbLDMWOWA+ssExY7NO
         lxhbIkOwKQc2yabj3zivXNg+VkwMYotfqJbGMqOUxatBKchSAmksD65qx7Ah2PjeobTv
         NsUhyHHiwhcRUKjT5ZDacnPvbYM+MYJ9+DeTAnjWmBLLFwe7nW85drryMqXrbP8J+UMD
         tWfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGWAKr03t3XsZV03vIXZYxEKTOliCE3pegqVdxdX2aRdDB2e5O76R7HI48RrrHDllaFS9k9zI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLUZfFpiKH+VjeK4tgvmaORS5K7XMzFzxtfOA0ikRTMjFX5Gq+
	Kc5YCTZKnxsx4sHv5zG3q3ou608OO9g7qfuqTyrGJ9OCrCeoSaS/VRG3gnZrIq8Cp/IRu77kES1
	ZZpfauI4Dbw==
X-Google-Smtp-Source: AGHT+IHR4NDuIyolClnhqV4eBCiL0uf4qWgFX5/vNZoyo2P0n9bLX/vfJHlrGVUOnRlD1+dFJDpZhJOIoJ5T+A==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a00:b01b:b0:710:4d46:1760 with SMTP
 id d2e1a72fcca58-71b260ae1d0mr3452b3a.3.1727393811222; Thu, 26 Sep 2024
 16:36:51 -0700 (PDT)
Date: Thu, 26 Sep 2024 23:36:16 +0000
In-Reply-To: <20240926233632.821189-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926233632.821189-1-cmllamas@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240926233632.821189-6-cmllamas@google.com>
Subject: [PATCH v2 5/8] binder: fix BINDER_WORK_CLEAR_FREEZE_NOTIFICATION
 debug logs
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Yu-Ting Tseng <yutingtseng@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

proc 699
context binder-test
  thread 699: l 00 need_return 0 tr 0
  ref 25: desc 1 node 20 s 1 w 0 d 00000000c03e09a3
  unknown work: type 11

proc 640
context binder-test
  thread 640: l 00 need_return 0 tr 0
  ref 8: desc 1 node 3 s 1 w 0 d 000000002bb493e1
  has cleared freeze notification

Fixes: d579b04a52a1 ("binder: frozen notification")
Cc: stable@vger.kernel.org
Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 2be9f3559ed7..73dc6cbc1681 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6411,6 +6411,9 @@ static void print_binder_work_ilocked(struct seq_file *m,
 	case BINDER_WORK_FROZEN_BINDER:
 		seq_printf(m, "%shas frozen binder\n", prefix);
 		break;
+	case BINDER_WORK_CLEAR_FREEZE_NOTIFICATION:
+		seq_printf(m, "%shas cleared freeze notification\n", prefix);
+		break;
 	default:
 		seq_printf(m, "%sunknown work: type %d\n", prefix, w->type);
 		break;
-- 
2.46.1.824.gd892dcdcdd-goog


