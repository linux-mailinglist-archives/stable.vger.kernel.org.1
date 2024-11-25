Return-Path: <stable+bounces-95452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF8A9D8F31
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 00:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3288B2775F
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 23:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA7A193073;
	Mon, 25 Nov 2024 23:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9MqDI9A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6138E1E480;
	Mon, 25 Nov 2024 23:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732577637; cv=none; b=QHMlw0m40KeysE/ABxdr3j0mn/GgAEDGA7XwttaBAuC/qUiXO67qoPbuBwb8w9Y6a8gPLrCaK9KwNf1eESiHoDhaAVgPNzY/SZQ+wX+4qqRxh7B01j3hv7bZoC+MFDn2ORxT+QRmJAO5tsTxwNq+Fip/oxqqqfHTow8JLWEthv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732577637; c=relaxed/simple;
	bh=ZI88yhG9GI0DouWMQIl4znxd8wu87u5uaWf+pyuEVRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bj0KRbixS5qSHmSeOb0hmf2csDU3VHJBK1Hcon1TuIHRxT3xpDYndRh5k7jtAS0bnxxF+cFcHAtfSg5t1POYlTGicv4SU4ay3C8rFB7F0b6Znl9xw1uB6CoVHDcS0rL1L6YNYVHcOMihO1LverjNijng9DnOW9+AAoyJMnhNvV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9MqDI9A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3690BC4CECE;
	Mon, 25 Nov 2024 23:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732577636;
	bh=ZI88yhG9GI0DouWMQIl4znxd8wu87u5uaWf+pyuEVRU=;
	h=From:To:Cc:Subject:Date:From;
	b=L9MqDI9A8/KhvycwCCGcaVwWb8yODG0T+dRLdZeqzdDheGLoL7PkFNXvfI7WCSpzW
	 llfh2jTJeI+nsQEpXwk7qan/ZPth4NVXXN72Zq6lNhs3Mam3bWimDBlS/x4AWG/hoK
	 3TGZ0U3jqz8HjZ153FaovFS5k/wLNJ4ucK0Nre7Fk4SA2jbbAOwhfWu0tc/Z0K43+q
	 rXLBLzPjVmO3vOMxkrmHtScCjM+XRDjaZuwB35RX+xXLN5LOmzR9TJ8QNyAoah2RVL
	 AmZk2gEmqUhKa0vLgYjp0xBDpvmeX2o6FMpBqnMtN+UkpxtZN4gpzr7auBq99ie+/F
	 gEA4vVKFguUDw==
From: Miguel Ojeda <ojeda@kernel.org>
To: Jocelyn Falempe <jfalempe@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH] drm/panic: remove spurious empty line to clean warning
Date: Tue, 26 Nov 2024 00:33:32 +0100
Message-ID: <20241125233332.697497-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clippy in the upcoming Rust 1.83.0 spots a spurious empty line since the
`clippy::empty_line_after_doc_comments` warning is now enabled by default
given it is part of the `suspicious` group [1]:

    error: empty line after doc comment
       --> drivers/gpu/drm/drm_panic_qr.rs:931:1
        |
    931 | / /// They must remain valid for the duration of the function call.
    932 | |
        | |_
    933 |   #[no_mangle]
    934 | / pub unsafe extern "C" fn drm_panic_qr_generate(
    935 | |     url: *const i8,
    936 | |     data: *mut u8,
    937 | |     data_len: usize,
    ...   |
    940 | |     tmp_size: usize,
    941 | | ) -> u8 {
        | |_______- the comment documents this function
        |
        = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#empty_line_after_doc_comments
        = note: `-D clippy::empty-line-after-doc-comments` implied by `-D warnings`
        = help: to override `-D warnings` add `#[allow(clippy::empty_line_after_doc_comments)]`
        = help: if the empty line is unintentional remove it

Thus remove the empty line.

Cc: stable@vger.kernel.org
Fixes: cb5164ac43d0 ("drm/panic: Add a QR code panic screen")
Link: https://github.com/rust-lang/rust-clippy/pull/13091 [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
I added the Fixes and stable tags since it would be nice to keep the 6.12 LTS
Clippy-clean (since that one is the first that supports several Rust compilers).

 drivers/gpu/drm/drm_panic_qr.rs | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
index 09500cddc009..ef2d490965ba 100644
--- a/drivers/gpu/drm/drm_panic_qr.rs
+++ b/drivers/gpu/drm/drm_panic_qr.rs
@@ -929,7 +929,6 @@ fn draw_all(&mut self, data: impl Iterator<Item = u8>) {
 /// * `tmp` must be valid for reading and writing for `tmp_size` bytes.
 ///
 /// They must remain valid for the duration of the function call.
-
 #[no_mangle]
 pub unsafe extern "C" fn drm_panic_qr_generate(
     url: *const i8,

base-commit: b7ed2b6f4e8d7f64649795e76ee9db67300de8eb
--
2.47.0

