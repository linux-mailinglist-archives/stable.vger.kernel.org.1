Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4F079BF35
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241509AbjIKVkH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240055AbjIKOfH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:35:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BD6F2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:35:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF78C433C8;
        Mon, 11 Sep 2023 14:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442903;
        bh=bNVF/HXelkpmgFmd9dy4UOYytkPE2cX/SgAzTSNzKIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FZyubGrW85K1UptqzN98fX47hInoV1GnXAQaeNuxAmJSqm9nmvbrnxRRAsDOS8lf/
         8h+tG9hH1FOkOBO6G4l7r/KQFTduo1+msAymrWk7f6/w2GLH/vmUkjq0xctztlDDi1
         /eAMKpQIB5kIhrF6CEbukJy4Yt3uSL5Pw/uNEJOI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Russell Currey <ruscur@russell.cc>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 189/737] kbuild: rust_is_available: fix version check when CC has multiple arguments
Date:   Mon, 11 Sep 2023 15:40:48 +0200
Message-ID: <20230911134655.861613753@linuxfoundation.org>
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

From: Russell Currey <ruscur@russell.cc>

[ Upstream commit dee3a6b819c96fc8b1907577f585fd66f5c0fefe ]

rust_is_available.sh uses cc-version.sh to identify which C compiler is
in use, as scripts/Kconfig.include does.  cc-version.sh isn't designed to
be able to handle multiple arguments in one variable, i.e. "ccache clang".
Its invocation in rust_is_available.sh quotes "$CC", which makes
$1 == "ccache clang" instead of the intended $1 == ccache & $2 == clang.

cc-version.sh could also be changed to handle having "ccache clang" as one
argument, but it only has the one consumer upstream, making it simpler to
fix the caller here.

Signed-off-by: Russell Currey <ruscur@russell.cc>
Fixes: 78521f3399ab ("scripts: add `rust_is_available.sh`")
Link: https://github.com/Rust-for-Linux/linux/pull/873
[ Reworded title prefix and reflow line to 75 columns. ]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20230616001631.463536-3-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/rust_is_available.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
index f43a010eaf305..0c9be438e4cd3 100755
--- a/scripts/rust_is_available.sh
+++ b/scripts/rust_is_available.sh
@@ -113,10 +113,10 @@ fi
 #
 # In the future, we might be able to perform a full version check, see
 # https://github.com/rust-lang/rust-bindgen/issues/2138.
-cc_name=$($(dirname $0)/cc-version.sh "$CC" | cut -f1 -d' ')
+cc_name=$($(dirname $0)/cc-version.sh $CC | cut -f1 -d' ')
 if [ "$cc_name" = Clang ]; then
 	clang_version=$( \
-		LC_ALL=C "$CC" --version 2>/dev/null \
+		LC_ALL=C $CC --version 2>/dev/null \
 			| sed -nE '1s:.*version ([0-9]+\.[0-9]+\.[0-9]+).*:\1:p'
 	)
 	if [ "$clang_version" != "$bindgen_libclang_version" ]; then
-- 
2.40.1



