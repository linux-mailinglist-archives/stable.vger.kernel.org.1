Return-Path: <stable+bounces-124228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C85A5EEC3
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 688AE19C0A95
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DC0264619;
	Thu, 13 Mar 2025 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qo3lAmy8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3A32641D7
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856484; cv=none; b=V4r5ewJ+vSs7BViPrdceNo4ZySrii4t1PmNKBaQkGJYEqY7JoF7NxKGtacoal6OoEJmJKDNyM762OwLIh1oXdt0lwA5k9DS4YvFj7Z0umuf5CR/5jn7MamGpgpBULYNxcOLzK6UA7WONXGzvyQI9JviyptEIvzg05O6KdyijEVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856484; c=relaxed/simple;
	bh=KX7RNgiCRERwW4AqvXgNQvPzew2IY90PKV2Wxh/XIJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YgzSfyAtDdjfgiRHuqmmjNTocaGLDpdenHr9aeoABFsOyPlqCuzvUdHEYFkz0TxUeYISxlKatrYzIgdLVEOk4IKhPePeMmLQxSmomv9xuKj1IYonIvf/X1+b5+dHC/m1CN9b6WwL17Ej9HXZD66APGgG/nKAMP9Aw8sd6UNrEQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qo3lAmy8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1AFC4CEEA;
	Thu, 13 Mar 2025 09:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741856484;
	bh=KX7RNgiCRERwW4AqvXgNQvPzew2IY90PKV2Wxh/XIJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qo3lAmy8lnE6MZE3j6Mju5K5Go/gxJ2vTij6xoBxSCduLrfbeERqbFRD92PCExf1w
	 1KDCfdOfR3PXWge5TFM7+V+gg9hSzeTjau2U+c7im0jyuw/Sb+Ib6+Y0B3ZunyAwOv
	 AWA++XeU2tcbIj3kejtuNrG/zfJsEYgiUY31Lv0P/xHRP3q5Ba5s+Q+/LmE4SI/BAU
	 DsKGexpsD4osjx56H1iHJBxfSypCamFaQOo7GJdpNyCd3pzAH28J0YeDbFH0kfqRT8
	 w6peK14/EHgimAlbXwwVGjFoL0yNOFa2AHbCub9OsHrCmrsAxJP0HhuqK4hJ2ApRtH
	 iPCmySGDhtoTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ojeda@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y 2/2] rust: map `long` to `isize` and `char` to `u8`
Date: Thu, 13 Mar 2025 05:01:22 -0400
Message-Id: <20250312231655-f84e0943cc19faf0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250309204217.1553389-3-ojeda@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
ℹ️ This is part 2/2 of a series
❌ Build failures detected

The upstream commit SHA1 provided is correct: 1bae8729e50a900f41e9a1c17ae81113e4cf62b8

WARNING: Author mismatch between patch and upstream commit:
Backport author: Miguel Ojeda<ojeda@kernel.org>
Commit author: Gary Guo<gary@garyguo.net>

Status in newer kernel trees:
6.13.y | Present (different SHA1: 7efbbb5407e7)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly.
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Failed     |  N/A       |

Build Errors:
Patch failed to apply on stable/linux-6.12.y. Reject:

diff a/rust/kernel/error.rs b/rust/kernel/error.rs	(rejected hunks)
@@ -153,11 +153,8 @@ pub(crate) fn to_blk_status(self) -> bindings::blk_status_t {
 
     /// Returns the error encoded as a pointer.
     pub fn to_ptr<T>(self) -> *mut T {
-        #[cfg_attr(target_pointer_width = "32", allow(clippy::useless_conversion))]
         // SAFETY: `self.0` is a valid error due to its invariant.
-        unsafe {
-            bindings::ERR_PTR(self.0.get().into()) as *mut _
-        }
+        unsafe { bindings::ERR_PTR(self.0.get() as _) as *mut _ }
     }
 
     /// Returns a string representing the error, if one exists.
diff a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs	(rejected hunks)
@@ -8,7 +8,7 @@
     alloc::Flags,
     bindings,
     error::Result,
-    ffi::{c_ulong, c_void},
+    ffi::c_void,
     prelude::*,
     types::{AsBytes, FromBytes},
 };

