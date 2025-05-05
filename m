Return-Path: <stable+bounces-140049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6BBAABA58
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 09:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463E91B61F6E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EBE2FED12;
	Mon,  5 May 2025 22:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/jwOrwe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB672FED08;
	Mon,  5 May 2025 22:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483977; cv=none; b=c5sNS44+VT2GE2vA6lhxqGYt+qE0IuVCdpEV4DsV1PcUWDk4FElC5g1tLDNDZwHMTeOs5lLLrBNyYcUVrX2GOUPj8bdS780uFFXWes+ddX60nndQBpTVRjxEYx0pA9PPngayTD6ZCgMsA8zHVhBGRfIp+fgaaXDSbD76CG3hpQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483977; c=relaxed/simple;
	bh=xCQaZ4SHn2zLQvENl3Y5QUq2AcwL2iuTO4zWEtQmWt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k9dSAkTM7F32e4c4sZhRdvB5Pe2ek44yOfVOqGIHRaQ4AwmKKYK8/beIMiwflhwta+uND/QfDHvMITGe5D6r/GnAuktRZv2lIh3rkS41PPk8GQl2mNuh/WEU+GulFI2Kt0J4uci6kRuIz93UBJw5BYZfRpSNEtRJtoLSMrxJzLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/jwOrwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B15C4CEEE;
	Mon,  5 May 2025 22:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483977;
	bh=xCQaZ4SHn2zLQvENl3Y5QUq2AcwL2iuTO4zWEtQmWt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R/jwOrwe5tBi0Jw4QmDBWxJ4fNdKiFUj1tMGg9Z5rPaOHCsQC3geBAlPRwV5nB8lg
	 K/pf46rfpS2hP/V/Hd0yWvgQBwACzIaiFd/PwN4IxM+vB4LFs1kFC8FCt4w2iu8h2x
	 8R2cUAU0Vst2b81WrL5GWJ7bGeXbgb4U+Ea4G7Ul+h5sGAR94EH/isBFtbNojMZzAn
	 zdBTtZHH3+SbxgV1ayoWy+lffWA+0X7RcZ+Qoz4yjFKgpikyNhqV/y1TxY1s/wgI2I
	 cqfelezHE2ORvIw+Dqj9KiSMdjbVPVzir34okv+hG09nWdTV0yTq8Qj5VBWbVeeQeQ
	 miFTUm7aIvSog==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lyude Paul <lyude@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	dakr@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	rust-for-linux@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 302/642] rust/faux: Add missing parent argument to Registration::new()
Date: Mon,  5 May 2025 18:08:38 -0400
Message-Id: <20250505221419.2672473-302-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Lyude Paul <lyude@redhat.com>

[ Upstream commit 95cb0cb546c2892b7a31ff2fce6573f201a214b8 ]

A little late in the review of the faux device interface, we added the
ability to specify a parent device when creating new faux devices - but
this never got ported over to the rust bindings. So, let's add the missing
argument now so we don't have to convert other users later down the line.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20250227193522.198344-1-lyude@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 rust/kernel/faux.rs              | 13 +++++++++++--
 samples/rust/rust_driver_faux.rs |  2 +-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
index 5acc0c02d451f..68f53edf05d70 100644
--- a/rust/kernel/faux.rs
+++ b/rust/kernel/faux.rs
@@ -24,11 +24,20 @@
 
 impl Registration {
     /// Create and register a new faux device with the given name.
-    pub fn new(name: &CStr) -> Result<Self> {
+    pub fn new(name: &CStr, parent: Option<&device::Device>) -> Result<Self> {
         // SAFETY:
         // - `name` is copied by this function into its own storage
         // - `faux_ops` is safe to leave NULL according to the C API
-        let dev = unsafe { bindings::faux_device_create(name.as_char_ptr(), null_mut(), null()) };
+        // - `parent` can be either NULL or a pointer to a `struct device`, and `faux_device_create`
+        //   will take a reference to `parent` using `device_add` - ensuring that it remains valid
+        //   for the lifetime of the faux device.
+        let dev = unsafe {
+            bindings::faux_device_create(
+                name.as_char_ptr(),
+                parent.map_or(null_mut(), |p| p.as_raw()),
+                null(),
+            )
+        };
 
         // The above function will return either a valid device, or NULL on failure
         // INVARIANT: The device will remain registered until faux_device_destroy() is called, which
diff --git a/samples/rust/rust_driver_faux.rs b/samples/rust/rust_driver_faux.rs
index 048c6cb98b29a..58a3a94121bff 100644
--- a/samples/rust/rust_driver_faux.rs
+++ b/samples/rust/rust_driver_faux.rs
@@ -20,7 +20,7 @@ impl Module for SampleModule {
     fn init(_module: &'static ThisModule) -> Result<Self> {
         pr_info!("Initialising Rust Faux Device Sample\n");
 
-        let reg = faux::Registration::new(c_str!("rust-faux-sample-device"))?;
+        let reg = faux::Registration::new(c_str!("rust-faux-sample-device"), None)?;
 
         dev_info!(reg.as_ref(), "Hello from faux device!\n");
 
-- 
2.39.5


