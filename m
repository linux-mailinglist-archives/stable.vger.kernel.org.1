Return-Path: <stable+bounces-216840-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLwqKyF6lGkfFAIAu9opvQ
	(envelope-from <stable+bounces-216840-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 15:24:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C5D14D1F0
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 15:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96609302FAA0
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 14:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A946336C0D3;
	Tue, 17 Feb 2026 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nT1YAq7n"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9B136BCE6
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771338179; cv=none; b=nHYnMbDd5Jshr8R87Ke8VZmmrXMrSvcVNYzoKv8m9vF1jjn+f7uxCOpkAYun4HT6MxGox3XEzDoTGc82IzIFWq1GRbZo60LTB+7C41m28WR9qwXwAdudnt7xQqnvLicua7DkU3el0ui2vj26c2YwXIE6Kq20k28jEoe1mBF6tt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771338179; c=relaxed/simple;
	bh=Efrfc+ezEwByI/gNWdWXysiNKRrRQRbM6CMnAM/EeeM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YjDPZ/36x/wfrcCRDjO3oUHm2EHh7e4NiLUDHBKvQ2H+gvH9cqvCj2NaT3/rbJ+Xrm8Q9cayFZSC5GR3PbYfHhTqm8rPU9VNxh/fvbimtNzwIjjeArygaPHTgg74afHoQckBCe+JGcUonOleeCB86estGvSzJCs4xHUyLQDvrAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nT1YAq7n; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43637c70876so3280540f8f.2
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 06:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771338176; x=1771942976; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6LeKap7jZK//r6ZxbwvZGHpBK/lawg1BApnHVA3ELvI=;
        b=nT1YAq7nGZb1vHuJs3IBdSVY8q3dpaImDMox2CMHkufbX3H+dJt8LjRJfzyU1B0vg/
         lmzjPNcZCNrudJew2DnjDFHjD9T9eE2Ndy48OyF4f6pfmkOCQuIVyHwk5VxVHZ4UuTWM
         oHD/+txFg74uuUaGfxhe7+6vNy5hvmC+bULTbawxlx4jmEes6TMI5iLoiBBUIWsL4p4b
         3OB0vgboR3CL2zd5I3DEIhQVz4n7FwiZer9AYVIsoACf8vUD4Mteq7dprE03smq2mYfO
         HW3W53Y+mByMSBlG0GmT8WrUJ/s5oYVQVYyUEH6zWxRPG4wUVQRVvxGJqNa1gZ0ZwoUR
         gSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771338176; x=1771942976;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6LeKap7jZK//r6ZxbwvZGHpBK/lawg1BApnHVA3ELvI=;
        b=nn95Rp8kHIPW2GZ6CXtXbiHvBH/iMp8bSTQatRV6p0VtLDR57aUz8LeAQJcD6zIMTk
         whJEi9feKMGnNzpJox2I8cQhHM/kj0CWihgfl5eWWSdgu5axa+WEkWX2I1QoPKbLcDU1
         KO4OmZMs2WS4yzDIWLtKBHYtNeLmgM4C29uymq0l1YD3fwTPBbosgzfVdykX2C6yoEOG
         NMbE5odc3g/GK0fxwa/jfSHT+XqX1Q3A/T6yqD+6j/6U6zrrsHZw7f/hKRiWjI8COcmf
         N0AtyI+9bsJKWooyHY5T27Mr6CoR/tq2WTlu6BZhgiiUN9KVTBi6O1e/tmaXZ259mZ6D
         8PpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTn+nOwgx3NOA1zl3YCOqzTIyrDgfoO6BbWAds43jUbB55po+83P3LiLGJyxVixn6r55pT/I4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp64jB8DqXA5WiKEhMLGKu3ysNKrBQYb1+rXLeoWAqQwllM8d1
	y7UTFsyRYD8U7vUzYsDsnvELKlPfIeITUzIhCfoFAj71nMSRKAi1k5Mlg2ezq54X/isXQnEf6+y
	3E4xItuhvZWuWi9UQ3A==
X-Received: from wrnc10.prod.google.com ([2002:adf:e74a:0:b0:437:6b00:8cbc])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:240e:b0:431:808:2d50 with SMTP id ffacd0b85a97d-4379db24fb0mr20850357f8f.13.1771338176111;
 Tue, 17 Feb 2026 06:22:56 -0800 (PST)
Date: Tue, 17 Feb 2026 14:22:39 +0000
In-Reply-To: <20260217-binder-vma-check-v1-0-1a2b37f7b762@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260217-binder-vma-check-v1-0-1a2b37f7b762@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2851; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Efrfc+ezEwByI/gNWdWXysiNKRrRQRbM6CMnAM/EeeM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBplHm5prYIkklTAyDnHpvdtT4ZnH/PWKGUlo9A7
 e0m3cQkth6JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaZR5uQAKCRAEWL7uWMY5
 RjRCD/9Hw/hm2Xm3vaKkplhmlEb0PY2QkvIEUCwKHyT/1GELqXg87R/lLUOS5SfbeX6FB3MKzyZ
 qMQrby2qSbni8YHedTtzjFZZNS5kKbyOIXtkyiK0htiI4E+oV637qnqGzSqId3M9Sc1FbgYhZmD
 M5ot3f02kV1P9LLybjMEAXBxuEgYKjHv/Cdc1tan0KELqEmRyXF7wneln2hM9GGoXaXeUrk6/EW
 aDQo1JuVycWlZgzXY1bfMUCYbABcHl1xVcVt6+HAfCHpTPleAIvy1xFDoNtMUB//NwUT3ne7AjJ
 XodQxTZxTZZqsD2QSBzk+b6i8yJRFv9EVxBEFHn5N/F5PsPv2/HYU1eXWe6X7oh6UBFkeOHE/g9
 wQ2Xt4wa7HWgQwUYEofVqhJwcadiMbw9NAuB5ghDBrEZoprpr5Gg6zyYq6FbuJU9l5vWTKgarOb
 /5rddyZlLCgqDppocuz5wInoSxvJkpVwSwk10MjRSIyyURCpZtFQ2m2HDTqhYP5pgc8UQ1Ke5Nh
 8XFyDEqHwCRFMaxZ8ZaGWp4OFfAPKVJXkBPqToS90XrexsvF6L9m7Nhq5qSIejoh0JLBvUzILyQ
 XxBk0KpMUnllvaBB7ZXdoilUxvFY1GS5qS29U3uVRQcjiFtOdMyTifisrClGZ3F/2bpSewTI7f3 mliJbE3uEwn0XCg==
X-Mailer: b4 0.14.2
Message-ID: <20260217-binder-vma-check-v1-2-1a2b37f7b762@google.com>
Subject: [PATCH 2/2] rust_binder: avoid reading the written value in offsets array
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Jann Horn <jannh@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216840-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,oracle.com,vger.kernel.org,kvack.org,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05C5D14D1F0
X-Rspamd-Action: no action

When sending a transaction, its offsets array is first copied into the
target proc's vma, and then the values are read back from there. This is
normally fine because the vma is a read-only mapping, so the target
process cannot change the value under us.

However, if the target process somehow gains the ability to write to its
own vma, it could change the offset before it's read back, causing the
kernel to misinterpret what the sender meant. If the sender happens to
send a payload with a specific shape, this could in the worst case lead
to the receiver being able to privilege escalate into the sender.

The intent is that gaining the ability to change the read-only vma of
your own process should not be exploitable, so remove this TOCTOU read
even though it's unexploitable without another Binder bug.

Cc: stable@vger.kernel.org
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/thread.rs | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/thread.rs
index 1f1709a6a77abc1c865cc9387e7ba7493448c71d..f58ecccf5bb10a4b916d14a38dbb3bdfdda24ff8 100644
--- a/drivers/android/binder/thread.rs
+++ b/drivers/android/binder/thread.rs
@@ -1016,12 +1016,9 @@ pub(crate) fn copy_transaction_data(
 
         // Copy offsets if there are any.
         if offsets_size > 0 {
-            {
-                let mut reader =
-                    UserSlice::new(UserPtr::from_addr(trd_data_ptr.offsets as _), offsets_size)
-                        .reader();
-                alloc.copy_into(&mut reader, aligned_data_size, offsets_size)?;
-            }
+            let mut offsets_reader =
+                UserSlice::new(UserPtr::from_addr(trd_data_ptr.offsets as _), offsets_size)
+                .reader();
 
             let offsets_start = aligned_data_size;
             let offsets_end = aligned_data_size + offsets_size;
@@ -1042,11 +1039,9 @@ pub(crate) fn copy_transaction_data(
                 .step_by(size_of::<u64>())
                 .enumerate()
             {
-                let offset: usize = view
-                    .alloc
-                    .read::<u64>(index_offset)?
-                    .try_into()
-                    .map_err(|_| EINVAL)?;
+                let offset = offsets_reader.read::<u64>()?;
+                view.alloc.write(index_offset, &offset)?;
+                let offset: usize = offset.try_into().map_err(|_| EINVAL)?;
 
                 if offset < end_of_previous_object || !is_aligned(offset, size_of::<u32>()) {
                     pr_warn!("Got transaction with invalid offset.");

-- 
2.53.0.273.g2a3d683680-goog


