Return-Path: <stable+bounces-42437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD508B7308
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D1FF1C231B5
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5614312D779;
	Tue, 30 Apr 2024 11:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K/GmkOzN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C47F12D772;
	Tue, 30 Apr 2024 11:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475662; cv=none; b=YUpTL3B/ieFDL26Pc6aM7+9DDlxSANLjWpOBZMysFX0uHmCNDEUPVP6Lw3OXRb75Sr5V0WGPt7QlCVIkfitUMtyxjrtoBcGzQiP+BSykcrlpy7sqVkUUhKdqWxLCS0e4d8BOHrV89FYCp0z57ClvLd3JnsnNjilwTSsBJy69Un8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475662; c=relaxed/simple;
	bh=NubA33BHNL6tZg3jTDJsH6AOI/XDNQNZOLoNvcEk5Go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qe/27a31RTeCkojXN5BBDyN8Ot9c+eF2zZnK9HCTrVRMvJ8FGaQmNGBV4aRdT0NG0iyjQXVRARjvuJHpURxOF6dc1OaAXdS2ixz0k2g8uDQ/z2BIm9wnKlleZP9zqKlb//EfYTTFE06XnQwODmwXHdkYqf8oQpAfK6DriP8SdjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K/GmkOzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755F4C2BBFC;
	Tue, 30 Apr 2024 11:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714475661;
	bh=NubA33BHNL6tZg3jTDJsH6AOI/XDNQNZOLoNvcEk5Go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K/GmkOzNU3skSj9dmRrbU4DoDqb5wP7O+sV8OVuOmQMKCB9nVKkTKxavY9QzSw5NC
	 EUt+r6uA7448ShX/RQDOisJEC5trUcn60aRieSilHa857OTFJVeGRtGZ6+j+vgOwEt
	 D3Z4YVvWfWRxtPn5oOBAtBX9oVrCt3LnAUSTuE1s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Alice Ryhl <aliceryhl@google.com>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.6 116/186] kbuild: rust: force `alloc` extern to allow "empty" Rust files
Date: Tue, 30 Apr 2024 12:39:28 +0200
Message-ID: <20240430103101.400157767@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103058.010791820@linuxfoundation.org>
References: <20240430103058.010791820@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miguel Ojeda <ojeda@kernel.org>

commit ded103c7eb23753f22597afa500a7c1ad34116ba upstream.

If one attempts to build an essentially empty file somewhere in the
kernel tree, it leads to a build error because the compiler does not
recognize the `new_uninit` unstable feature:

    error[E0635]: unknown feature `new_uninit`
     --> <crate attribute>:1:9
      |
    1 | feature(new_uninit)
      |         ^^^^^^^^^^

The reason is that we pass `-Zcrate-attr='feature(new_uninit)'` (together
with `-Zallow-features=new_uninit`) to let non-`rust/` code use that
unstable feature.

However, the compiler only recognizes the feature if the `alloc` crate
is resolved (the feature is an `alloc` one). `--extern alloc`, which we
pass, is not enough to resolve the crate.

Introducing a reference like `use alloc;` or `extern crate alloc;`
solves the issue, thus this is not seen in normal files. For instance,
`use`ing the `kernel` prelude introduces such a reference, since `alloc`
is used inside.

While normal use of the build system is not impacted by this, it can still
be fairly confusing for kernel developers [1], thus use the unstable
`force` option of `--extern` [2] (added in Rust 1.71 [3]) to force the
compiler to resolve `alloc`.

This new unstable feature is only needed meanwhile we use the other
unstable feature, since then we will not need `-Zcrate-attr`.

Cc: stable@vger.kernel.org # v6.6+
Reported-by: Daniel Almeida <daniel.almeida@collabora.com>
Reported-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
Closes: https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/topic/x/near/424096982 [1]
Fixes: 2f7ab1267dc9 ("Kbuild: add Rust support")
Link: https://github.com/rust-lang/rust/issues/111302 [2]
Link: https://github.com/rust-lang/rust/pull/109421 [3]
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Link: https://lore.kernel.org/r/20240422090644.525520-1-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/Makefile.build |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -272,7 +272,7 @@ rust_common_cmd = \
 	-Zallow-features=$(rust_allowed_features) \
 	-Zcrate-attr=no_std \
 	-Zcrate-attr='feature($(rust_allowed_features))' \
-	--extern alloc --extern kernel \
+	-Zunstable-options --extern force:alloc --extern kernel \
 	--crate-type rlib -L $(objtree)/rust/ \
 	--crate-name $(basename $(notdir $@)) \
 	--out-dir $(dir $@) --emit=dep-info=$(depfile)



