Return-Path: <stable+bounces-215700-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFR6HB7Ai2l6aQAAu9opvQ
	(envelope-from <stable+bounces-215700-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 00:32:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6864120012
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 00:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FF4030BBE34
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 23:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A104303A15;
	Tue, 10 Feb 2026 23:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eoTsNhOw"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8008F338907
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 23:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770766219; cv=none; b=Pk53pd9cy7u/l0KRtR4+GdkaRe+TyPdB7qdRqanf57scvwliChQEWGGY+bZOmymilYIiCmrzuBvMWScfZjB8a2Wm2t98K0t0n9Xcp1oGS70CoXLfKYgTNswaGQq5PdktNIumoYyJHGxCCnakd2JVRHO1KVHvbX2b1D7f/+1IN0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770766219; c=relaxed/simple;
	bh=7Pa7vSAHTHgeNPV7lnCcMA0KjCpXbLVVkJL+cwa0SSA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=O470NhdbTUbUBiKnvNnuNH6g5gCwvP4yMD54APj+TWnycYfe+eWWAeYuQAZ6FILFEOrZJPU0RkoHsB+oy205Ucn7uybCcCCoGXdqV2eJsOPLw4M3v57vTSiNBY+3S12mdZj9IIEpkO0mOr72+3blNR/zkZLVMnH8oRNCke1dXQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eoTsNhOw; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b86381a107so25500883eec.1
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 15:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770766215; x=1771371015; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lj0RKcz76JMrswthVhhC2aRGx+N/zrzPWxqncCabNxk=;
        b=eoTsNhOw0aUkf3EWeJf9zAHvaEjxsawLRqtMQDupJzY2racsqPulP3pwTlOIeV/gul
         nuT5eX4FOXsWPpEz0IlB7wqcUsAnILPfia8p8klBJ3r/lk3gffHizixNrPq2y4Af2P73
         e9jUXF2WcilwkPm8rqXngrvjWNvNp2NcHV7NBah7q8xs5p8TtsHtOCWw3/qxM8YU+3Uk
         Nz99hlWv35qfoyzXuIz/Dj5DPWV+jBOCG3iyjMTkO1+uR7Gu4BlZwuDr/sITsTctZxk/
         h5ycMATOkangjBvKarRGVTZXXOzCOiftaZ0Jz6m2CvB9ODuCXeVZarK10iuIxqqHTl2b
         kmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770766215; x=1771371015;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lj0RKcz76JMrswthVhhC2aRGx+N/zrzPWxqncCabNxk=;
        b=enBXv+zZdUSewvbr1UKS8gAOs0tzziCEBSCvVyd/zTDAbuUwiITVnBLNakURtxZ1vm
         54FRXGU4j4woUvfMTNjpOFlDsH0uvsV+lpqgbcmIp4dx0F6i90QisucY3TfaksmI/5Xq
         AlofF1hsgsevYsh9kh7BhAWNw0JBx2dzsL6doLh7RWt6a34aT2UPv2D+ScR8sJz8kJD4
         C6vJuhx9rKuazGjC3BDD/bEXJ+7xhS/QTBvf02Qzl5kGZXe6cJk4iOEPGFDSqSVoGoDY
         he5t/P9nT9DMTaMZz+2gYMWO5el+XgJB61CjaXT/1xHtqrP84bUBKSZSFNDBn1OSsFry
         LY1w==
X-Forwarded-Encrypted: i=1; AJvYcCV8qM99rH6giE/3r41PPNdWYECjSsh0OlTc4xEcqRKzZAMTv+qsSs1mDYoWZKO0WlxTyhmmn6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJV9Gs1hiwyS/elPzntopgFbi9MqNVY5w1siN8+gMeJd2HytkW
	9SrwOhWb8NSGz1BI/Vy54wuE4XTRVo7SEylKnqpEsnISEDeVBRQ7gat6ZXONntYBb2ZiRGZEJFI
	/D7zVgS9lo73aBQ==
X-Received: from dlbeg13.prod.google.com ([2002:a05:7022:f8d:b0:124:a511:1ddf])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:4581:b0:119:e569:fb9b with SMTP id a92af1059eb24-1270411bf1cmr8087419c88.10.1770766215449;
 Tue, 10 Feb 2026 15:30:15 -0800 (PST)
Date: Tue, 10 Feb 2026 23:28:20 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260210232949.3770644-1-cmllamas@google.com>
Subject: [PATCH] rust_binder: fix oneway spam detection
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	Alice Ryhl <aliceryhl@google.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Matt Gilbride <mattgilbride@google.com>, Paul Moore <paul@paul-moore.com>, 
	Vitaly Wool <vitaly.wool@konsulko.se>, Miguel Ojeda <ojeda@kernel.org>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Tiffany Yang <ynaffit@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linuxfoundation.org,android.com,kernel.org,google.com,gmail.com,paul-moore.com,konsulko.se];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmllamas@google.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-215700-lists,stable=lfdr.de];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,args.pid:url]
X-Rspamd-Queue-Id: C6864120012
X-Rspamd-Action: no action

The spam detection logic in TreeRange was executed before the current
request was inserted into the tree. So the new request was not being
factored in the spam calculation. Fix this by moving the logic after
the new range has been inserted.

Also, the detection logic for ArrayRange was missing altogether which
meant large spamming transactions could get away without being detected.
Fix this by implementing an equivalent low_oneway_space() in ArrayRange.

Note that I looked into centralizing this logic in RangeAllocator but
iterating through 'state' and 'size' got a bit too complicated (for me)
and I abandoned this effort.

Cc: stable@vger.kernel.org
Cc: Alice Ryhl <aliceryhl@google.com>
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder/range_alloc/array.rs | 35 +++++++++++++++++++--
 drivers/android/binder/range_alloc/mod.rs   |  4 +--
 drivers/android/binder/range_alloc/tree.rs  | 18 +++++------
 3 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/drivers/android/binder/range_alloc/array.rs b/drivers/android/binder/range_alloc/array.rs
index 07e1dec2ce63..ada1d1b4302e 100644
--- a/drivers/android/binder/range_alloc/array.rs
+++ b/drivers/android/binder/range_alloc/array.rs
@@ -118,7 +118,7 @@ pub(crate) fn reserve_new(
         size: usize,
         is_oneway: bool,
         pid: Pid,
-    ) -> Result<usize> {
+    ) -> Result<(usize, bool)> {
         // Compute new value of free_oneway_space, which is set only on success.
         let new_oneway_space = if is_oneway {
             match self.free_oneway_space.checked_sub(size) {
@@ -146,7 +146,38 @@ pub(crate) fn reserve_new(
             .ok()
             .unwrap();
 
-        Ok(insert_at_offset)
+        // Start detecting spammers once we have less than 20%
+        // of async space left (which is less than 10% of total
+        // buffer size).
+        //
+        // (This will short-circuit, so `low_oneway_space` is
+        // only called when necessary.)
+        let oneway_spam_detected =
+            is_oneway && new_oneway_space < self.size / 10 && self.low_oneway_space(pid);
+
+        Ok((insert_at_offset, oneway_spam_detected))
+    }
+
+    /// Find the amount and size of buffers allocated by the current caller.
+    ///
+    /// The idea is that once we cross the threshold, whoever is responsible
+    /// for the low async space is likely to try to send another async transaction,
+    /// and at some point we'll catch them in the act.  This is more efficient
+    /// than keeping a map per pid.
+    fn low_oneway_space(&self, calling_pid: Pid) -> bool {
+        let mut total_alloc_size = 0;
+        let mut num_buffers = 0;
+
+        // Warn if this pid has more than 50 transactions, or more than 50% of
+        // async space (which is 25% of total buffer size). Oneway spam is only
+        // detected when the threshold is exceeded.
+        for range in &self.ranges {
+            if range.state.is_oneway() && range.state.pid() == calling_pid {
+                total_alloc_size += range.size;
+                num_buffers += 1;
+            }
+        }
+        num_buffers > 50 || total_alloc_size > self.size / 4
     }
 
     pub(crate) fn reservation_abort(&mut self, offset: usize) -> Result<FreedRange> {
diff --git a/drivers/android/binder/range_alloc/mod.rs b/drivers/android/binder/range_alloc/mod.rs
index 2301e2bc1a1f..1f4734468ff1 100644
--- a/drivers/android/binder/range_alloc/mod.rs
+++ b/drivers/android/binder/range_alloc/mod.rs
@@ -188,11 +188,11 @@ pub(crate) fn reserve_new(&mut self, mut args: ReserveNewArgs<T>) -> Result<Rese
                 self.reserve_new(args)
             }
             Impl::Array(array) => {
-                let offset =
+                let (offset, oneway_spam_detected) =
                     array.reserve_new(args.debug_id, args.size, args.is_oneway, args.pid)?;
                 Ok(ReserveNew::Success(ReserveNewSuccess {
                     offset,
-                    oneway_spam_detected: false,
+                    oneway_spam_detected,
                     _empty_array_alloc: args.empty_array_alloc,
                     _new_tree_alloc: args.new_tree_alloc,
                     _tree_alloc: args.tree_alloc,
diff --git a/drivers/android/binder/range_alloc/tree.rs b/drivers/android/binder/range_alloc/tree.rs
index 838fdd2b47ea..48796fcdb362 100644
--- a/drivers/android/binder/range_alloc/tree.rs
+++ b/drivers/android/binder/range_alloc/tree.rs
@@ -164,15 +164,6 @@ pub(crate) fn reserve_new(
             self.free_oneway_space
         };
 
-        // Start detecting spammers once we have less than 20%
-        // of async space left (which is less than 10% of total
-        // buffer size).
-        //
-        // (This will short-circut, so `low_oneway_space` is
-        // only called when necessary.)
-        let oneway_spam_detected =
-            is_oneway && new_oneway_space < self.size / 10 && self.low_oneway_space(pid);
-
         let (found_size, found_off, tree_node, free_tree_node) = match self.find_best_match(size) {
             None => {
                 pr_warn!("ENOSPC from range_alloc.reserve_new - size: {}", size);
@@ -203,6 +194,15 @@ pub(crate) fn reserve_new(
             self.free_tree.insert(free_tree_node);
         }
 
+        // Start detecting spammers once we have less than 20%
+        // of async space left (which is less than 10% of total
+        // buffer size).
+        //
+        // (This will short-circuit, so `low_oneway_space` is
+        // only called when necessary.)
+        let oneway_spam_detected =
+            is_oneway && new_oneway_space < self.size / 10 && self.low_oneway_space(pid);
+
         Ok((found_off, oneway_spam_detected))
     }
 
-- 
2.53.0.239.g8d8fc8a987-goog


