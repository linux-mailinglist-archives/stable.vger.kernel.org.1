Return-Path: <stable+bounces-241817-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAEgI26S8WkoiQEAu9opvQ
	(envelope-from <stable+bounces-241817-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 07:09:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE4548F5DC
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 07:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8EA6830142AE
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 05:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB056346E7F;
	Wed, 29 Apr 2026 05:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2AqHOaj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4E1332918
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 05:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777439328; cv=none; b=NN1KSoQcU6wscpy8zL6C2Me3MB9cPUEPbPT5251skw8+ZfeGDOwP43ZuxkVWRcKl7OJZgaURd3fsZtly/F+Q7+omb1sjFkyeDyRutwJNJdEYuHH3q9QHFA4p74TdY0NgUv3dxNKFph9sD1g/BmuI4bp8T6XFnOiYrXE0YyWzdPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777439328; c=relaxed/simple;
	bh=3vr4LweU0XG/MdC/ybUiaL5dNvZ69Fa30FXvIM4R2N4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=M1Sc0CabGRptI3Sg8Px5y05Sr28QQdw7JxriT0FzoxKSvg/byDTlh2BW2ULNw6J2XG2tTQu2XQa2Zf0y4GhAxuvd05ZO8Vpflq81vaFH0jQjwYtSSc3LaPAuqHYOnj4Ke+Mmdw9APxbYwxjxRH6RIgPO9ZIzVUKgeswncDQG3cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2AqHOaj; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35d965648a2so10862283a91.0
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 22:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777439326; x=1778044126; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KPbd8CPced3p+R7AG2gDS8UVQl+Rhqk52G90qEr4h9s=;
        b=U2AqHOajgV+w4Lc4aOHZkRFpSgkS/QmIoqzQeKDJE8tDs9W5bE0dyYS/Krx9YO6g6N
         7/5Q9TCCrDKetEQpy2UWEeOSuh+KM9EjTcbfZYCLOiQ+R5+QqgtCj8tJGp74Bk/gnmEd
         r0G0/1EsrH+h69Q43s7cDrNj9HwzdaLmuzwUgy5SvVLRRgCgpgzeJMLu4C/FXEdQFqop
         Ybk4RDOy7rK0coz994NYgotHApcY1nioeoJjZFHEvS2ZRariijXGcFMh/VtzqyNNTPSY
         L3C6/qA8ES2e5hXvTy0T66t9La2HVT5VGG8CjJ7fjb3zBM+KCKGUtu6oj2fxv0mQ90w5
         jLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777439326; x=1778044126;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPbd8CPced3p+R7AG2gDS8UVQl+Rhqk52G90qEr4h9s=;
        b=JbV8bxuElzGj9wNWcRQlVHTpAnQpfHCnf0y2vOvllfqiNk+8JYgCqD00I0MeoEFcU1
         Oo3coFHcsFD/nzyErtnw7seREe6KnAyeoXzgjABpdvchxvkWJ7MRH/MH+B4IKZHn9SG4
         5xLViP2yGog4cqou+TDrRaZ8mxY2z753/pki0Np2VgKVSuNQtaym8iAHGBZZuiiXV7gJ
         EOc28DTPzhrjwqnXpa+QC0e1dWy1CFhL4nlGxewuynbH3NERe3sRJCwIxGDsQcjyWOjh
         Kvr6FsGdJPW+wAfQ7ZoRbXzW7dpL2HuAdwHdwFTqu7KamSEbg8mTiGu8ysVWnkZY5/me
         Tc6w==
X-Forwarded-Encrypted: i=1; AFNElJ9zdSeffcT5yYZGe512h+ir9manbkD/h031Pilcr6+6TY8X9g9WPOsZrkpj2GIA+YNOrFJm28A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQj+oK4Q/8HaHCXuNBrFBSk6vIfvOLdBGkBI2H5T7h2XF/VHGq
	bZ+8hT2KjmvG4jgAq8UEcKLFbSI/0TQcMGr98K4DEMVOGEjsdce/hxxV
X-Gm-Gg: AeBDiev0YU+xPbxOPt4F2y6OZqVGUnJ89gNY7DkiSK/Bi8yGe5B+V+qhSlyYYxGxm6M
	F0hvHIp+SRgXzcC0mWGnyJOvsB+KrC0lpTaIwJL9am6yCnT9QdHi9VJ+fFmwpCHNnaPzZm8POp5
	tSFyzkZZ9tx9JTKnusD9mPqgB0Q1OkSExG36mw8WWrQdsACjyD0zDwVHQ/PbuDaI/EFJxkI2mJ9
	tpesCR40jcEuSfjoi6/RiA2g/OA6hiwvyFZBOl0Rlyv3tJLH++gfMFvS8twzVleI/q7x7HfU8ql
	qP4a3PiSq4OynWQek5ne6OBxGFMVyaIuLsF45ac1YtF+0w8rEbgKbOHGQl7IYeyP2ALGPe0K2Jj
	FBR6gyrGH4955LMtrzkXROCPe3LpZzHn/1uYw6uK1+hdl48utOl0sLfwutFlbVMkfZ3Cs4b5vCc
	g/WgaX67/ChUpUuQfcZgciCuELaNaS4661N8xZJ6Sy1uKOcuY=
X-Received: by 2002:a17:90b:1a8e:b0:35b:9b77:d7c with SMTP id 98e67ed59e1d1-364a0d08580mr2433235a91.14.1777439326204;
        Tue, 28 Apr 2026 22:08:46 -0700 (PDT)
Received: from yuwhisper-pc. ([49.213.140.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a4152b85sm1158871a91.4.2026.04.28.22.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 22:08:45 -0700 (PDT)
From: Hsiu Che Yu <yu.whisper.personal@gmail.com>
Date: Wed, 29 Apr 2026 13:08:14 +0800
Subject: [PATCH] rust: drm: fix incorrect type name in `Device` doc comment
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-fix-drm-device-comment-v1-1-d8876b44d688@gmail.com>
X-B4-Tracking: v=1; b=H4sIAD2S8WkC/yWMQQqDMBAAvyJ7dkFTK9GviIe6WesKiSWxRRD/7
 lqPAzOzQ+IonKDNdoj8kyRLUCjzDGh6hTejOGUwhamLyjQ4yoYuenQqEyMt3nNYsSrts7H24Wg
 cQONPZDX/466/OX2HmWm9bnAcJ00Rqed6AAAA
X-Change-ID: 20260429-fix-drm-device-comment-41859883dcfb
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Maxime Ripard <mripard@kernel.org>, 
 Asahi Lina <lina+kernel@asahilina.net>, Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Hsiu Che Yu <yu.whisper.personal@gmail.com>
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: 7FE4548F5DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241817-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,google.com,gmail.com,ffwll.ch,garyguo.net,protonmail.com,umich.edu,asahilina.net,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuwhisperpersonal@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

The invariant documentation incorrectly referenced `struct device`
instead of `struct drm_device`. Fix it.

Fixes: 1e4b8896c0f3c ("rust: drm: add device abstraction")
Cc: stable@vger.kernel.org
Signed-off-by: Hsiu Che Yu <yu.whisper.personal@gmail.com>
---
 rust/kernel/drm/device.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index adbafe8db54d..301c9f7859e2 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -72,7 +72,7 @@ macro_rules! drm_legacy_fields {
 ///
 /// # Invariants
 ///
-/// `self.dev` is a valid instance of a `struct device`.
+/// `self.dev` is a valid instance of a `struct drm_device`.
 #[repr(C)]
 pub struct Device<T: drm::Driver> {
     dev: Opaque<bindings::drm_device>,
@@ -160,7 +160,7 @@ pub(crate) fn as_raw(&self) -> *mut bindings::drm_device {
 
     /// # Safety
     ///
-    /// `ptr` must be a valid pointer to a `struct device` embedded in `Self`.
+    /// `ptr` must be a valid pointer to a `struct drm_device` embedded in `Self`.
     unsafe fn from_drm_device(ptr: *const bindings::drm_device) -> *mut Self {
         // SAFETY: By the safety requirements of this function `ptr` is a valid pointer to a
         // `struct drm_device` embedded in `Self`.
@@ -184,7 +184,7 @@ unsafe fn into_drm_device(ptr: NonNull<Self>) -> *mut bindings::drm_device {
     /// to can't drop to zero, for the duration of this function call and the entire duration when
     /// the returned reference exists.
     ///
-    /// Additionally, callers must ensure that the `struct device`, `ptr` is pointing to, is
+    /// Additionally, callers must ensure that the `struct drm_device`, `ptr` is pointing to, is
     /// embedded in `Self`.
     #[doc(hidden)]
     pub unsafe fn from_raw<'a>(ptr: *const bindings::drm_device) -> &'a Self {

---
base-commit: b4e07588e743c989499ca24d49e752c074924a9a
change-id: 20260429-fix-drm-device-comment-41859883dcfb

Best regards,
--  
Hsiu Che Yu <yu.whisper.personal@gmail.com>


