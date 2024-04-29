Return-Path: <stable+bounces-41635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D408B5663
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B976282BAC
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 11:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744893D961;
	Mon, 29 Apr 2024 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FbZenD+f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B931EB2F
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389688; cv=none; b=N/ee/RPoPWh61t0F3Na+LabRtAjCs259D9leAmvvrRgzwY4UIN/+Kp5D2ISy4BsAelPlU9ZnEWGQDKjiBEHVBBsuPngEvp0CLoT3Il951O9e4FQpC3xZ3wHM8mvzyim7mHwy1sy2QAgM1/lj1RisB6bAbO4v9d27T4ASlvUoDWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389688; c=relaxed/simple;
	bh=3uOqIUZ33jC9zY3JN8bWXGSE0T8xA5LVq3kPOtvhhlA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=m36MCm9CBffsR/xIvrZqQvttm2X+HBuda97ZkjMgbYUdmRCDIfXMHcwHBNKJ84IHyNHc48c0c863hhbHZNVn/lp31nGoaVzgrfaoFfFD5RjjbmJ8mCiRvNIy04XDeU2KDwLC08sRh9N2issMvlIck3tGVbVKvPZfUZG6lZw9FWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FbZenD+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CC8C113CD;
	Mon, 29 Apr 2024 11:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714389687;
	bh=3uOqIUZ33jC9zY3JN8bWXGSE0T8xA5LVq3kPOtvhhlA=;
	h=Subject:To:Cc:From:Date:From;
	b=FbZenD+fgnHe6zuUrytAmIEqP659792GppYqt+MxzqZqsijyVGOSXFRYUEQ1JebyN
	 F3DNkiH9h4RGIAmRQDmbmso7y82kTZH306J0kF14lR5ycmHhQdTtOcIgWajCQW2N2i
	 czKsrJONmfbCEY01vnDE+prCG5ixLMT8223F7hM8=
Subject: FAILED: patch "[PATCH] rust: remove `params` from `module` macro example" failed to apply to 6.1-stable tree
To: aswinunni01@gmail.com,aliceryhl@google.com,ojeda@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Apr 2024 13:21:24 +0200
Message-ID: <2024042924-ribcage-browsing-7e8b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 19843452dca40e28d6d3f4793d998b681d505c7f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042924-ribcage-browsing-7e8b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

19843452dca4 ("rust: remove `params` from `module` macro example")
b13c9880f909 ("rust: macros: take string literals in `module!`")
c3630df66f95 ("rust: samples: add `rust_print` example")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 19843452dca40e28d6d3f4793d998b681d505c7f Mon Sep 17 00:00:00 2001
From: Aswin Unnikrishnan <aswinunni01@gmail.com>
Date: Fri, 19 Apr 2024 21:50:13 +0000
Subject: [PATCH] rust: remove `params` from `module` macro example

Remove argument `params` from the `module` macro example, because the
macro does not currently support module parameters since it was not sent
with the initial merge.

Signed-off-by: Aswin Unnikrishnan <aswinunni01@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Cc: stable@vger.kernel.org
Fixes: 1fbde52bde73 ("rust: add `macros` crate")
Link: https://lore.kernel.org/r/20240419215015.157258-1-aswinunni01@gmail.com
[ Reworded slightly. ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index f489f3157383..520eae5fd792 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -35,18 +35,6 @@ use proc_macro::TokenStream;
 ///     author: "Rust for Linux Contributors",
 ///     description: "My very own kernel module!",
 ///     license: "GPL",
-///     params: {
-///        my_i32: i32 {
-///            default: 42,
-///            permissions: 0o000,
-///            description: "Example of i32",
-///        },
-///        writeable_i32: i32 {
-///            default: 42,
-///            permissions: 0o644,
-///            description: "Example of i32",
-///        },
-///    },
 /// }
 ///
 /// struct MyModule;


