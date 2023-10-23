Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEDB7D31D3
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjJWLNl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbjJWLNl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:13:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B69A4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:13:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6F8C433CB;
        Mon, 23 Oct 2023 11:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059619;
        bh=moxeWhXuepqlxXF8ggTXvBhwAX1hDED4dqO+IowhgEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=01OmN6B06+WQ41aPn/IsxC3cZAQ/3cdY8jGdjlfAIiKRj8G1CKLJZ4nhkHxsF+IBC
         szAroIAaRPzFn8QqbGzausgyNZgParvk4tBtrR1Z7rBSmXyOQSqFpINht0v5MjXjzK
         RBejXD8PI11k/qbyCr8AhrhVdklFeXQJP8cj/IT0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Trevor Gross <tmgross@umich.edu>, Finn Behrens <me@kloenk.dev>,
        Alice Ryhl <aliceryhl@google.com>,
        Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.5 211/241] rust: error: fix the description for `ECHILD`
Date:   Mon, 23 Oct 2023 12:56:37 +0200
Message-ID: <20231023104838.993608503@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wedson Almeida Filho <walmeida@microsoft.com>

commit 17bfcd6a81535d7d580ddafb6e54806890aaca6c upstream.

A mistake was made and the description of `ECHILD` is wrong (it reuses
the description of `ENOEXEC`). This fixes it to reflect what's in
`errno-base.h`.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Finn Behrens <me@kloenk.dev>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Fixes: 266def2a0f5b ("rust: error: add codes from `errno-base.h`")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230930144958.46051-1-wedsonaf@gmail.com
[ Use the plural, as noticed by Benno. ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 rust/kernel/error.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 05fcab6abfe6..0f29e7b2194c 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -37,7 +37,7 @@ macro_rules! declare_err {
     declare_err!(E2BIG, "Argument list too long.");
     declare_err!(ENOEXEC, "Exec format error.");
     declare_err!(EBADF, "Bad file number.");
-    declare_err!(ECHILD, "Exec format error.");
+    declare_err!(ECHILD, "No child processes.");
     declare_err!(EAGAIN, "Try again.");
     declare_err!(ENOMEM, "Out of memory.");
     declare_err!(EACCES, "Permission denied.");
-- 
2.42.0



