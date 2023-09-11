Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C039B79BE50
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240785AbjIKVKX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241505AbjIKPKJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:10:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE235FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:10:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E277C433C7;
        Mon, 11 Sep 2023 15:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445004;
        bh=ohLkHtzAZfqtupwQENYJzGok14wpvn8oXxrFPLruEz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CbwcQddd8fSyeSPPPqBzOvutPIIWDytBs9zJSYU68rD4UMGHgU6LdwZ8gsm1aM4OL
         oAVFqJZV8uKr+T1hg/kclVErxg8YqzoSgOTWGmrrV4SXYpBwgFe2wTP9xm0ZZKPiby
         LNXljkgyJEJIm3WsdUoVpXZG2XtNERC8HCDW4kh4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jordan Isaacs <mail@jdisaacs.com>,
        "Ethan D. Twardy" <ethan.twardy@gmail.com>,
        Tiago Lam <tiagolam@gmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 166/600] kbuild: rust_is_available: fix confusion when a version appears in the path
Date:   Mon, 11 Sep 2023 15:43:19 +0200
Message-ID: <20230911134638.506799196@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miguel Ojeda <ojeda@kernel.org>

[ Upstream commit 9eb7e20e0c5cd069457845f965b3e8a7d736ecb7 ]

`bindgen`'s output for `libclang`'s version check contains paths, which
in turn may contain strings that look like version numbers [1][2]:

    .../6.1.0-dev/.../rust_is_available_bindgen_libclang.h:2:9: warning: clang version 11.1.0  [-W#pragma-messages], err: false

which the script will pick up as the version instead of the latter.

It is also the case that versions may appear after the actual version
(e.g. distribution's version text), which was the reason behind `head` [3]:

    .../rust-is-available-bindgen-libclang.h:2:9: warning: clang version 13.0.0 (Fedora 13.0.0-3.fc35) [-W#pragma-messages], err: false

Thus instead ask for a match after the `clang version` string.

Reported-by: Jordan Isaacs <mail@jdisaacs.com>
Closes: https://github.com/Rust-for-Linux/linux/issues/942 [1]
Reported-by: "Ethan D. Twardy" <ethan.twardy@gmail.com>
Closes: https://lore.kernel.org/rust-for-linux/20230528131802.6390-2-ethan.twardy@gmail.com/ [2]
Reported-by: Tiago Lam <tiagolam@gmail.com>
Closes: https://github.com/Rust-for-Linux/linux/pull/789 [3]
Fixes: 78521f3399ab ("scripts: add `rust_is_available.sh`")
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Ethan Twardy <ethan.twardy@gmail.com>
Tested-by: Ethan Twardy <ethan.twardy@gmail.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20230616001631.463536-8-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/rust_is_available.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
index c965895d80b97..7a925d2b20fc7 100755
--- a/scripts/rust_is_available.sh
+++ b/scripts/rust_is_available.sh
@@ -112,9 +112,7 @@ fi
 # of the `libclang` found by the Rust bindings generator is suitable.
 bindgen_libclang_version=$( \
 	echo "$bindgen_libclang_output" \
-		| grep -F 'clang version ' \
-		| grep -oE '[0-9]+\.[0-9]+\.[0-9]+' \
-		| head -n 1 \
+		| sed -nE 's:.*clang version ([0-9]+\.[0-9]+\.[0-9]+).*:\1:p'
 )
 bindgen_libclang_min_version=$($min_tool_version llvm)
 bindgen_libclang_cversion=$(get_canonical_version $bindgen_libclang_version)
-- 
2.40.1



