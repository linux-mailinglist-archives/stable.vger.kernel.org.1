Return-Path: <stable+bounces-129671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C15BA800B3
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2778E1887A32
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9967126A0BF;
	Tue,  8 Apr 2025 11:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1V5luDvc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DED2690D5;
	Tue,  8 Apr 2025 11:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111668; cv=none; b=LJt/9XufgHHGd7mMAUG9riVp42B8ZNXAGm+hkKfDfZAJuoPJhEbXG4TpSPSnfNlUmZcVumCFzSbKdjofMmET7M26YUOEjFPlfZiM1OcbblkN+Fr1HV7Cl6ZD8f4Fu+IzOqhxCp/HfTUtYfX2B0Y5/0SsgjUNdAeGu7JI8sh7iK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111668; c=relaxed/simple;
	bh=QbPXgGdhZ9vTwv6XeZX7DEZllR/0Twsbf893wKXMylM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBvRq/NuxF5Z5/q1m80nTvB6QdkKTXG7T3WjXUY8oKO2lB3apJBxXIZYrPt+74CDvWpxki8Y+DstRK+/9SAgBWL9inpXLNCOWfKrbdBq3KAZ5AtPPoRKWuaiT4d8umy3Y6TNETE6yI+8fW/ycx9pw5xEWpuq9CH/6WlWTHBxwVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1V5luDvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE07C4CEE7;
	Tue,  8 Apr 2025 11:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744111668;
	bh=QbPXgGdhZ9vTwv6XeZX7DEZllR/0Twsbf893wKXMylM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1V5luDvcbuMCjXzE4jUEi0D5ehveOUBi8XdOXKS57W03SckiNNnmL0yt2mjrpLGlY
	 BtzAnJXi2b5vhYxrIBYPsXejxEQkQfKrAo99YU92biE+NH9z3WszaXQgKNo46iELJH
	 lxFcqoiBxjuyzJSAjc3d1TZvvVZlK8Ex6LmzmJrs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benno Lossin <benno.lossin@proton.me>,
	Danilo Krummrich <dakr@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 508/731] rust: pci: use to_result() in enable_device_mem()
Date: Tue,  8 Apr 2025 12:46:45 +0200
Message-ID: <20250408104926.091755973@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Danilo Krummrich <dakr@kernel.org>

[ Upstream commit d1f6d6c537d488b1a8f04091c7751124985a0ab9 ]

Simplify enable_device_mem() by using to_result() to handle the return
value of the corresponding FFI call.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Acked-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250314160932.100165-2-dakr@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 7b948a2af6b5 ("rust: pci: fix unrestricted &mut pci::Device")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 rust/kernel/pci.rs | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 4c98b5b9aa1e9..386484dcf36eb 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -382,12 +382,7 @@ impl Device {
     /// Enable memory resources for this device.
     pub fn enable_device_mem(&self) -> Result {
         // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
-        let ret = unsafe { bindings::pci_enable_device_mem(self.as_raw()) };
-        if ret != 0 {
-            Err(Error::from_errno(ret))
-        } else {
-            Ok(())
-        }
+        to_result(unsafe { bindings::pci_enable_device_mem(self.as_raw()) })
     }
 
     /// Enable bus-mastering for this device.
-- 
2.39.5




