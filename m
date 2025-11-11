Return-Path: <stable+bounces-194496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EA2C4E7BD
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 15:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DECB4F7040
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 14:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC30FA55;
	Tue, 11 Nov 2025 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IR/qB5YW"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EC32FB0AE
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871029; cv=none; b=iv1ij2aBKCxQg1X2zoHfDQhzwIWHgKZ7F/89mRpFDQAyObYJKR/9t+6usMoV8V2mZzQzQFRD240KltSHWQaq13XADE+gMGR9FmU+Z0rX9kkcwh7WwMNk2zTjGldBaZ/HRyrx6H1FWJKu2pD1Au9TQT83MytAT+KlM7zR1A+CFRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871029; c=relaxed/simple;
	bh=KAyxsyVI7rxJC2+bw+Vkk3KiDJtx/3PPEIACBwdvs08=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SWEIBzs8UJ8CBMVlKEGbjVSW5MJ9+CPs0l/noByav/t2AYIbJ0EoJTYqF2uxrRXSq2FQ1HNKsUe/Lr0bx8HkiPGL3qEDcD+UBAk+CA2GK+2sS5PCVbvJRAYabP09PIqsKKeTzLTMerL9/mdqdLYoLx4V/J3rIocE2QTtsySizbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IR/qB5YW; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47775585257so23696685e9.1
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 06:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762871025; x=1763475825; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=znJZRiHsP/Uc78N1GNR0aqP0S6GuH1W4uou2Y4GH7sg=;
        b=IR/qB5YWfWFZj2yzX+PKlQ50KjHfHWfZW62nidZJ/FzNWU8G0Zu3dqe3Duz1O4tIjt
         tSFQYsFx9vsiX1GuychT7mjkQnbPhzjv62K6y/vGHr0cIVngv/Lb9UrT/bWGhL4ACm5D
         FJiN4HIKe16QXPZVT6BY6EQJxL35DZCiKKC1XRJC05gyiVESTNh+Y68b2L/nwCm34aFm
         wkb8zCU9YMiqMxsHgGvx9LywhhHZ7Tm/R3ORqCpRrBmyfXMQY5IUbiDIRGitc5zZWvof
         GXpgOYIMbOO6pBWI9TGslFH9WH7lYit37EHC0naQ91eTO6qWeQ/65lm1y4DMqdVLg3re
         mWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762871025; x=1763475825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=znJZRiHsP/Uc78N1GNR0aqP0S6GuH1W4uou2Y4GH7sg=;
        b=Any7ePovVyYpCuNFW0LlFlyA28aZhQHdtlEEzJ7EMnE7btjnXuLmnvGa8Za9VO8YAb
         MoQgqgprHZ57XPIjNVHwkF3ey965A4TQYgtzFnOJ38W6ZcXx6XLzu5gqkHTFLedwM/Ef
         qdTZd1VOC6ZknVh5DIK0yHS5z902P+KpiY3YT9XaJi3klVvhCUd+M05wv69Q4kMEFOan
         sT+NHHhxbOrVjMIKgeDFYB1P2NQi7y0VigMcdgWT8HR+s/aVMhMVAVdynSH9KvP2NhKs
         QVLJFiYqH+500T36vQXJwczSuntldxQwTr1EvfQoLxfXM1Z4oR76ReDiANTh7wuuS0MX
         yGWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuM8oppyseLqdVMxxzOKweMA3ZGaM2qeUuuhWBFV0owzG+NNRwUCB1V7BxiHSlnuGpDj5YxtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfPeuS3qgBAc8E/QpeFKRYsTTfz4pl7NIZxYsN3qMH/YRLe2Q5
	+v5wdGYemJIIBSsSniRTlXUB1Ti9utfVtOmOBuQ/cdDhrE3CnElwL0oV2V4ifeGP2LaGZ/rDttI
	9Ypqcr8mGlXDZcoT48A==
X-Google-Smtp-Source: AGHT+IE2YmYheg20DfmC1cGFkXFjFdLpncEwyzBzXL0yvogGpbwF2wMENRkrYHUukkMid2IGCnveYW66GtA9q1s=
X-Received: from wmbg20.prod.google.com ([2002:a05:600c:a414:b0:45b:6337:ab6b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e93:b0:46e:37fc:def0 with SMTP id 5b1f17b1804b1-47773239bf6mr104388655e9.9.1762871025621;
 Tue, 11 Nov 2025 06:23:45 -0800 (PST)
Date: Tue, 11 Nov 2025 14:23:33 +0000
In-Reply-To: <20251111-binder-fix-list-remove-v1-0-8ed14a0da63d@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111-binder-fix-list-remove-v1-0-8ed14a0da63d@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1529; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=KAyxsyVI7rxJC2+bw+Vkk3KiDJtx/3PPEIACBwdvs08=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpE0btsQOvyXOMphFoNMnE1zWIjHLFNk4HQtKLB
 xWbRNwxiiSJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaRNG7QAKCRAEWL7uWMY5
 RuLJEACYEPvUcRF3T1OInJJZySTefUw1TIPsMSCcg7akYeqo4O1alQT8lffTaD/aOXucqHpWvpy
 M5kPdgcis/U2vsM7ea05d84aqkGfkZySok89V+SdzaX7lSx4g0ZSk4/QX6SquE3zDRYwwgfA1Mm
 MyegWBJmCen/spY6nsvLClGIhrdZlgfb9r4w9ZTTSLviJBG7o4eOuJTQpZ2H/xeKTmDQZNIQCml
 /k3bMWdR9fElvjhzwCKu3OlGfKq06gQWq6cs9ZacadPt0DOhCdRlInTfoqLc0z1Sb17mzbNHcq+
 28JihF0xoVpMLeaybvzXTJ8Y3V+shKRR96hCFnM6HZ2KXe7BCbByFqQU3K5q+8yL0Tvq8AjAR23
 0n5MC6pKM2eZKoJfJKePK0UiKxQVmiUInEwSjFB6g1sfMmy27tgwAPVemMrVsVL57h3k+EQO6Zz
 qUy5cOX+etGKnOhcUhE9Vi9X8WETcVX8xMlcH5ds8uFOmg+6xCADH1vUEbxlgjEi1UcEbkC9vTu
 Xo+gInJlMrBlaBUWDBE2VyDhnK3/QwHv08UF+QXZAdjEwmNGQbQ8Egw78MDIY++x61P5qH9CPNx
 5MP7qMLiGGqiT/ItQvE3k63P8MRf40qUEiU2yBkM588vzcvbCe5O9UqSP3pTY16bAa1t9HiapbF LX9LgkuB4/OcXIA==
X-Mailer: b4 0.14.2
Message-ID: <20251111-binder-fix-list-remove-v1-2-8ed14a0da63d@google.com>
Subject: [PATCH 2/3] rust_binder: avoid mem::take on delivered_deaths
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>
Cc: "=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Martijn Coenen <maco@android.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

Similar to the previous commit, List::remove is used on
delivered_deaths, so do not use mem::take on it as that may result in
violations of the List::remove safety requirements.

I don't think this particular case can be triggered because it requires
fd close to run in parallel with an ioctl on the same fd. But let's not
tempt fate.

Cc: stable@vger.kernel.org
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/process.rs | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index f13a747e784c84a0fb09cbf47442712106eba07c..022f554bb049280126fdaf636dc7a41dd02c535e 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -1335,8 +1335,12 @@ fn deferred_release(self: Arc<Self>) {
             work.into_arc().cancel();
         }
 
-        let delivered_deaths = take(&mut self.inner.lock().delivered_deaths);
-        drop(delivered_deaths);
+        // Clear delivered_deaths list.
+        //
+        // Scope ensures that MutexGuard is dropped while executing the body.
+        while let Some(delivered_death) = { self.inner.lock().delivered_deaths.pop_front() } {
+            drop(delivered_death);
+        }
 
         // Free any resources kept alive by allocated buffers.
         let omapping = self.inner.lock().mapping.take();

-- 
2.51.2.1041.gc1ab5b90ca-goog


