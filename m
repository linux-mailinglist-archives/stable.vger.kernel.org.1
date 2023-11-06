Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46247E2416
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjKFNR7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjKFNR7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:17:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C8BA9
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:17:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298ABC433C7;
        Mon,  6 Nov 2023 13:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276676;
        bh=ouQ81jf53pzZ/8j8aUQKo7eMhB9ldbVs9GGjkb13kng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t1IkWI6SfCcnubNCEJjd/tG2Jp2QR0YAzKo6aK1YNr+IRhWp642XIEQZ7JfqdJKcx
         XJ3OdYIuj+baAq4z70nu3K3nXngjYYQrPjuCD7LNOfREtSU7T96wah0h4DXCoTm+1g
         PeaK3E56cCngSZsu7os6nJaOYqn2ycSLfGs/6t3o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alice Ryhl <aliceryhl@google.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Gary Guo <gary@garyguo.net>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 61/88] rust: make `UnsafeCell` the outer type in `Opaque`
Date:   Mon,  6 Nov 2023 14:03:55 +0100
Message-ID: <20231106130308.041864552@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
References: <20231106130305.772449722@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alice Ryhl <aliceryhl@google.com>

[ Upstream commit 35cad617df2eeef8440a38e82bb2d81ae32ca50d ]

When combining `UnsafeCell` with `MaybeUninit`, it is idiomatic to use
`UnsafeCell` as the outer type. Intuitively, this is because a
`MaybeUninit<T>` might not contain a `T`, but we always want the effect
of the `UnsafeCell`, even if the inner value is uninitialized.

Now, strictly speaking, this doesn't really make a difference. The
compiler will always apply the `UnsafeCell` effect even if the inner
value is uninitialized. But I think we should follow the convention
here.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Link: https://lore.kernel.org/r/20230614115328.2825961-1-aliceryhl@google.com
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Stable-dep-of: 0b4e3b6f6b79 ("rust: types: make `Opaque` be `!Unpin`")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 rust/kernel/types.rs | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index d479f8da8f381..c0b8bb1a75393 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -206,17 +206,17 @@ fn drop(&mut self) {
 ///
 /// This is meant to be used with FFI objects that are never interpreted by Rust code.
 #[repr(transparent)]
-pub struct Opaque<T>(MaybeUninit<UnsafeCell<T>>);
+pub struct Opaque<T>(UnsafeCell<MaybeUninit<T>>);
 
 impl<T> Opaque<T> {
     /// Creates a new opaque value.
     pub const fn new(value: T) -> Self {
-        Self(MaybeUninit::new(UnsafeCell::new(value)))
+        Self(UnsafeCell::new(MaybeUninit::new(value)))
     }
 
     /// Creates an uninitialised value.
     pub const fn uninit() -> Self {
-        Self(MaybeUninit::uninit())
+        Self(UnsafeCell::new(MaybeUninit::uninit()))
     }
 
     /// Creates a pin-initializer from the given initializer closure.
@@ -240,7 +240,7 @@ pub fn ffi_init(init_func: impl FnOnce(*mut T)) -> impl PinInit<Self> {
 
     /// Returns a raw pointer to the opaque data.
     pub fn get(&self) -> *mut T {
-        UnsafeCell::raw_get(self.0.as_ptr())
+        UnsafeCell::get(&self.0).cast::<T>()
     }
 
     /// Gets the value behind `this`.
@@ -248,7 +248,7 @@ pub fn get(&self) -> *mut T {
     /// This function is useful to get access to the value without creating intermediate
     /// references.
     pub const fn raw_get(this: *const Self) -> *mut T {
-        UnsafeCell::raw_get(this.cast::<UnsafeCell<T>>())
+        UnsafeCell::raw_get(this.cast::<UnsafeCell<MaybeUninit<T>>>()).cast::<T>()
     }
 }
 
-- 
2.42.0



