Return-Path: <stable+bounces-241178-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIfYGi5R7mkzsQAAu9opvQ
	(envelope-from <stable+bounces-241178-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 19:53:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 116D846AB55
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 19:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF5AE3003989
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 17:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1BD2BE65F;
	Sun, 26 Apr 2026 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFdOGowt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43C92EB10
	for <stable@vger.kernel.org>; Sun, 26 Apr 2026 17:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777226020; cv=none; b=TIf2g7iqa7vNstILdHrj1lBKkUWPyAkAYniMzgPHT5/ZTCo1ukkN6Wzh4m3os6L3yOzvXhnpOr6b/QvxTm7A0FxUfYd4wiN3OfjJKtkjLNiNpqzqSJVKQHDxRSf2+m7UDkAjc2IOGYoFXBDAiY2KmjwJIRROenJ6ir8TBID1iLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777226020; c=relaxed/simple;
	bh=K3PhdH/H1LuLbuZf9RFfbPB361BzmgW112xFwjwqE+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nh+THQE7dNuKXEvSMZvG9HENxTjGo5bP9H9+PXVf7/pwQS+kgVgWB+c2+n4QvPFEUcJpfFvvNi/EgmSI0GRzbyWiYY/shTfXC/BRsxGG617f9oA2skK7JbZPGv+b6xevK/TdZP93fBU6HXR4fqcrgjX8eH7u043yjH7TAAadtJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFdOGowt; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ab077e3f32so40217475ad.3
        for <stable@vger.kernel.org>; Sun, 26 Apr 2026 10:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777226017; x=1777830817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fJwj/aOjKyp0eDwfZBPm2TCTAMglOjfWhZzP5CZOSOY=;
        b=bFdOGowtwLnEUho2k7QeS1vmnoachmQq4uSIqkmJLvKY3TXORu45LXfSYpDzMHj5qv
         eceD171VQFKRE8Hrjyr7h/vMjFeU7t/QE266leyexSiXXAqrW2irABeuRoEYH9nwGZ/7
         bLEj4XEn2q4YUtobAEXONpXYGlggRm+AH/6Bc5fRnvd4MizyIEDGbc/di5ZMw1JvbJGy
         vHc/nb7vDZ2EyBdWIynrAxeVNO/M/5CYrb006wjZU1J3bPekG35XHYkP6rVYsyeWEgrO
         8av19ouk3imA7m0uy5DyYZjPgDsIQ2BWCuRVp44vnoOk7AEZgteD0DHjsJWgwi+hIECr
         Ajsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777226017; x=1777830817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJwj/aOjKyp0eDwfZBPm2TCTAMglOjfWhZzP5CZOSOY=;
        b=gR5whtDhW7K8nGj4K1XUOCQe4Fw5K53jAvMZHHoSI/y7YEQYcbXyEzsF0JcIBygl41
         RLCT5d7od8T4ERI6Pv9vlr8YiMRYquRfvxdWyiG3ZGRR067xOFzymnVY8S6pPuSMIsT8
         ICNRCpFbx4OJ5DJjJnbVilnLrps4NMr+wQouCjZUmPbuxj5NLtljDL2Ozq0uD7lCwejs
         SHkuDo8aWOZmaodMaeMcTeY5Jqu03XswRbkFa9ML8QOaQgD6uxh30SBc8Jw5OGH9kJg+
         jM7uYd8NOG0dbl5j8cw+OO7/5Fr4Kb6ZYd8wL4iFqc/wlRSCaldAwj68YelhuERoK+e1
         HRgw==
X-Forwarded-Encrypted: i=1; AFNElJ8DgFBm6CQhrC4XLsM3S4vUse+z7YlRwDbb5gIFx9UZhS0urMU59NMPQd4Fcb9olkfaBlO6nYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytq30HDQgezirWyyHGYAZl965YbTPVoQbW8Wn//dZLfQntEjrq
	qvYSxIYqI1WN+l4zRK9mHB9PeaYhYAySuz14QoXiQYs/WzD82n3zg+Kb
X-Gm-Gg: AeBDieuNe25qMsDlhEUSV6vfZdL4lMEtjbuZs3bKfDNy4pjm5GWFtwZoPtos0I2lILK
	EB7EEAYzKFtG2EnMCXXkMt1O8J1tKULsHNmJq5nnIas2vw+isZAi36pmSAvYYkr+75LLiERMaoz
	U3odKDjElH7MZuiIOnUODCLGYRh5XO80ij8dyjBvIiv4BmJUxZX75qe9ngdaTJ8/WWtFHOxIFzf
	kdWEnbbbXeLSkJyrOT3iJwYvXl6Vvo9n2l02+jdeLLXvFoot8NHj0fGoERSl9O/ZPy2oowXRBWF
	z5jUsRjpXkfVnqUh9S701ZlE2cQBE4+t3vhpPH943rhivGE3VFKnVttAX7W+Ls3a0+/yXclY39Y
	4GMuhkD5li1Cj3vWiDNagvEONZvcS9tdnpPg32RUwpEmL7Wv7Ftse/29p30mcWNsMpjXL7xnA2H
	HvYkNXS2gkDgtQm6MQIPwLP57Sniio6JMOyZ5hS4m9Qq8K2uq9YH8=
X-Received: by 2002:a17:902:cf12:b0:2b4:460e:6fa8 with SMTP id d9443c01a7336-2b5f9f61d45mr395585175ad.34.1777226017339;
        Sun, 26 Apr 2026 10:53:37 -0700 (PDT)
Received: from Nighthawk.localdomain ([223.178.220.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff409sm349672805ad.14.2026.04.26.10.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 10:53:36 -0700 (PDT)
From: Sagar Taunk <sagartaunk2@gmail.com>
To: ojeda@kernel.org
Cc: aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	boqun@kernel.org,
	gary@garyguo.net,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	dakr@kernel.org,
	contact@onurozkan.dev,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sagar Taunk <sagartaunk2@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] rust: workqueue: fix SAFETY comment Arc refs in Pin<KBox<T>>
Date: Sun, 26 Apr 2026 23:23:17 +0530
Message-ID: <20260426175317.10171-1-sagartaunk2@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 116D846AB55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241178-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,protonmail.com,kernel.org,garyguo.net,umich.edu,onurozkan.dev,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sagartaunk2@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

The `WorkItemPointer` implementation for `Pin<KBox<T>>` contained SAFETY
comments that incorrectly referenced `Arc::into_raw` instead of
`KBox::into_raw`. This implementation uses `KBox`, not `Arc`, so update
the comments to accurately reflect the actual ownership transfer.

Fixes: 8373147ce496 ("rust: treewide: switch to our kernel `Box` type")
Cc: stable@vger.kernel.org
Suggested-by: Onur Özkan <contact@onurozkan.dev>
Link: https://github.com/Rust-for-Linux/linux/issues/1233
Signed-off-by: Sagar Taunk <sagartaunk2@gmail.com>
---
 rust/kernel/workqueue.rs | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 7e253b6f299c..74c59f2b1c09 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -890,9 +890,10 @@ unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Pin<KBox<T>>
     unsafe extern "C" fn run(ptr: *mut bindings::work_struct) {
         // The `__enqueue` method always uses a `work_struct` stored in a `Work<T, ID>`.
         let ptr = ptr.cast::<Work<T, ID>>();
-        // SAFETY: This computes the pointer that `__enqueue` got from `Arc::into_raw`.
+        // SAFETY: This computes the pointer that `__enqueue` got from `KBox::into_raw`.
         let ptr = unsafe { T::work_container_of(ptr) };
-        // SAFETY: This pointer comes from `Arc::into_raw` and we've been given back ownership.
+        // SAFETY: This pointer comes from `KBox::into_raw` and we have been given back ownership,
+        // as the workqueue guarantees `run` is called exactly once.
         let boxed = unsafe { KBox::from_raw(ptr) };
         // SAFETY: The box was already pinned when it was enqueued.
         let pinned = unsafe { Pin::new_unchecked(boxed) };
-- 
2.54.0


