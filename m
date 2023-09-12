Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEED79BEF2
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242357AbjIKVjd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240058AbjIKOfN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:35:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B8FF2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:35:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426B4C433C7;
        Mon, 11 Sep 2023 14:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442908;
        bh=Xslq3NdqREmtREbDPglR2/AlOTvDyxrVGPJav9ekDT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jMjx9rn99XO6qaAVKZGnoaaJnK73EUJX0DVxlhYkRQVyUqlxVCyBLRIXVtqlz+1nk
         +96umIWiVQ90eAYhGh/dHmyTyMaSYtpUF5rXABX+OFOeABEjR3lXedBo6ZAS3i9Ixl
         66T5oJ9j+WcSUygJfe9szoAl3FP44BcevUhB7UII=
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
Subject: [PATCH 6.4 191/737] kbuild: rust_is_available: fix confusion when a version appears in the path
Date:   Mon, 11 Sep 2023 15:40:50 +0200
Message-ID: <20230911134655.923874448@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

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



