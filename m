Return-Path: <stable+bounces-256457-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EoEEazpGGruoggAu9opvQ
	(envelope-from <stable+bounces-256457-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 03:19:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2895FBF28
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 03:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAD5F303878D
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 01:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41F73546F3;
	Fri, 29 May 2026 01:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4S0loMQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040D73546EC
	for <stable@vger.kernel.org>; Fri, 29 May 2026 01:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780017574; cv=none; b=RJbHOxh23FAA4hBUbHShC0pFIYpKeZmx0hzfpgijJ2wsExeoW/gBMk+h6G+E/G3e2AA88GTdG/T/9+0pzwWplMJMeKl3o/1vee8aJtpi7jZeMWa/y3PeVbsF7+jZ7/ouj+9fq27ekHrKfuSk9KuqZQmI6+DM1cpIe1Q1+GgNgNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780017574; c=relaxed/simple;
	bh=9+5tF0J6/VIAoz29m+zdLF6hSRtmeSnELRVfUP1Q47c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V1bplOV8yQANd1Vou0e87w47EZru8NhBdwrSb/euzYZy/okvkviyWPEHRCQJBVVeM74GaKHtcw1jEK8GUGdzMxKEzx7VuNQCzZreUpuTaW+t6F/UKD4AgTfmsSvxc7LwEA6BfEzuWczwFlj+2BdB+d+Jhry1YdjRJDgSJqMx0Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4S0loMQ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82fbdd60b64so10862013b3a.3
        for <stable@vger.kernel.org>; Thu, 28 May 2026 18:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780017572; x=1780622372; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qIjpzaojjPAZHKihdp6RPFa2Tfe6qCRbgRVNDw+LS2c=;
        b=h4S0loMQ50rxVdUCadzO/8AKEv8cRbZkXW02Xok2Adjt17yK/wQ3GrTbR1D8D0Wph0
         cu4wTR2J2o2MxJb3RCQALxAUYY0BJQd7cUAzKw6msD9Pic9pVMCEpqttxchAdnNzdei6
         IXhm0YNWGPsPH99ZhpEp3CMSipxgT0JWk06y1FqYfv+8UZ2l1MPfC4IO2ZF8iMiIeHKW
         NKvmUbTkAncAbJyy/W6N+QXQ6zaKUwOBDSYIlk+8R8bsbTgBksUIYeSmsWg66bRqn/GD
         hYmSbYHkMS5Rmxm4SzlM0drZRzhPqFRBs+gOI7ytDsmOa3fnLunugVGqWlDwLY234ofZ
         gccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780017572; x=1780622372;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qIjpzaojjPAZHKihdp6RPFa2Tfe6qCRbgRVNDw+LS2c=;
        b=szlEI+dv6cU/2EhUNjmCepXgEhvQnp6EFM/E3Q1/EZhVuCU8dDqftqse+40Gl9G1/q
         boifzIak0j5WoMLj3Zvm9nboPX61j67QKqiyssEmo26ljSMUvu8R/VYFntRtH0pNafej
         j/GDE81ORWYtFy35e2sRHnMKXjvnxaIbURsVjQALcZRsHHbdD9KOtxQgbQRF3SjesKPN
         Sqr5B3VMHfKJTSHdJUOw8Sh+qLtT7pRiF+myPs0Nkg+qCFwxj8WvBLe6hDCXc8ybI0ae
         wtFZjaoRT7JIoefxwdY1goks431t3GaFRY5Dimiw5bmN8gUb6iQML/fO2v6f1s3iT/Zb
         ocBQ==
X-Forwarded-Encrypted: i=1; AFNElJ85nKTmmeiqldPo0O5Tx1nbCztuBCqucz6gI/zAJ/QWABAq6EjX47YuYPTgcSRCDKCQTzPrFd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnYiwpK0qV0EdaKeLm5HXIw4QWurTfzUNsGO9C7OzY5cvp/DFq
	7BAveqm2dxm7srxsXfLEsaeg2FIdT+Aof6YBfXjnstupSB2LfjA4/+Z0
X-Gm-Gg: Acq92OEYuADvNz+EqNvAhDFwXH8xWUwsbPAFHaxOMKfH0uX4PQrYcR2ZMZdhKRlJYRl
	JXWJW4c+KnzsM1UQm6ryk/HVtBVedk3GQA9OlRrTj9YIhcD3SmRXQy0dRdphH0SdwS3ot3ONbBI
	jDHMc+g3fqCTPvowUgD/o4X5QTCPZ1bZfbDbcuIwvF46bvnbT7smUTFRSzzgthoCZJSVX96h/s1
	l0tFE3inNUcjgvWHI9ZqyuZuaeKrq8bwllA1nCt+dkq4hh237IVVesKoFZarRMiKm+iCQxysIlw
	hDVU+anHsORdCu+F+yLuR5PXTeFakL0Rx3oeERSqTT3Qp299dRIJ7Hq8Bi27BQXIwK/+mdlyujU
	ifGCNq+IFf7mRygqsBg8p2elBTANl2NYBgRga3MDbI5ToFzjQXiYZdu30YJJFQsAlFLwJBgOpoh
	fbWoY0s5RYW1FsmvYeMBdXDS3c4r6cJ2e+iAsL2hVHR975ofGZ1LMhDw==
X-Received: by 2002:a05:6a00:4f86:b0:83e:2c38:f5d5 with SMTP id d2e1a72fcca58-84212b81ad5mr662298b3a.28.1780017572235;
        Thu, 28 May 2026 18:19:32 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214cec0d9sm35920b3a.55.2026.05.28.18.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:19:31 -0700 (PDT)
Date: Fri, 29 May 2026 10:19:27 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
	brauner@kernel.org, cmllamas@google.com, aliceryhl@google.com,
	mo@sdhn.cc, wedsonaf@gmail.com, Liam.Howlett@oracle.com
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	stable@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH] rust_binder: use a u64 stride when cleaning up the offsets
 array
Message-ID: <ahjpn-3WQTywTdyj@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256457-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,android.com,kernel.org,google.com,sdhn.cc,gmail.com,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DD2895FBF28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Allocation's Drop walks the offsets array (binder_size_t = u64 entries),
cleaning up the objects, but it used usize instead of u64 for both the
stride and the per-entry read.

On 64-bit kernels (usize == u64) this is harmless, but on 32-bit kernels
it walks the 8-byte entries in 4-byte steps, iterating an N-entry array
2N times, and reads the always-zero high word as offset 0, cleaning up
the object at offset 0 N extra times. As a result the referenced node or
handle ends up with a lower reference count than it actually has (a
refcount over-decrement), and binder's reference accounting is corrupted;
for example, the owner can be notified of a strong reference release
(BR_RELEASE) even though references still remain.

Change the stride to u64, and read each entry as a u64, narrowing it to
usize with try_into().

On 32-bit ARM, when this over-decrement would drive a count below zero,
the driver's existing refcount guard refuses it and fires:

  rust_binder: Failure: refcount underflow!

Cc: stable@vger.kernel.org
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 drivers/android/binder/allocation.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder/allocation.rs b/drivers/android/binder/allocation.rs
index 0cab959e4b7e..f4ffc57a8cb2 100644
--- a/drivers/android/binder/allocation.rs
+++ b/drivers/android/binder/allocation.rs
@@ -251,7 +251,7 @@ fn drop(&mut self) {
 
             if let Some(offsets) = info.offsets.clone() {
                 let view = AllocationView::new(self, offsets.start);
-                for i in offsets.step_by(size_of::<usize>()) {
+                for i in offsets.step_by(size_of::<u64>()) {
                     if view.cleanup_object(i).is_err() {
                         pr_warn!("Error cleaning up object at offset {}\n", i)
                     }
@@ -412,7 +412,7 @@ pub(crate) fn transfer_binder_object(
     }
 
     fn cleanup_object(&self, index_offset: usize) -> Result {
-        let offset = self.alloc.read(index_offset)?;
+        let offset: usize = self.alloc.read::<u64>(index_offset)?.try_into().map_err(|_| EINVAL)?;
         let header = self.read::<BinderObjectHeader>(offset)?;
         match header.type_ {
             BINDER_TYPE_WEAK_BINDER | BINDER_TYPE_BINDER => {
-- 
2.43.0


