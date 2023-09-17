Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4C47A393A
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbjIQTqk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239994AbjIQTqM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:46:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BB698
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:46:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD9CC433CB;
        Sun, 17 Sep 2023 19:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979966;
        bh=jq9VlbIdiTbrxluHWxkWsgBj8lnL+6K8v9C6oZz0OTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AgW89mDRQwbNquMkgFevam8aBARuVSDR0FSEnY7tLZt7rBoFgUI9M0VdizL76TyoI
         rTD5SLbzSpYvGu9Ia4cKN1YMaetcehydfqaUMUcH/cyfX5bDSfLnuaOXfgAu+zWeqS
         3fDe6BPZEtujrIoqogifMRKHz50DgAnRpr0Z06Fg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiri Slaby <jslaby@suse.cz>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 058/285] kbuild: dummy-tools: make MPROFILE_KERNEL checks work on BE
Date:   Sun, 17 Sep 2023 21:10:58 +0200
Message-ID: <20230917191053.702170726@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Slaby <jslaby@suse.cz>

[ Upstream commit bfb41e46d0b040ae83c1c4a50292298208b10f73 ]

Commit 2eab791f940b ("kbuild: dummy-tools: support MPROFILE_KERNEL
checks for ppc") added support for ppc64le's checks for
-mprofile-kernel.

Now, commit aec0ba7472a7 ("powerpc/64: Use -mprofile-kernel for big
endian ELFv2 kernels") added support for -mprofile-kernel even on
big-endian ppc.

So lift the check in gcc-check-mprofile-kernel.sh to support big-endian too.

Fixes: aec0ba7472a7 ("powerpc/64: Use -mprofile-kernel for big endian ELFv2 kernels")
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/dummy-tools/gcc | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/dummy-tools/gcc b/scripts/dummy-tools/gcc
index 1db1889f6d81e..07f6dc4c5cf69 100755
--- a/scripts/dummy-tools/gcc
+++ b/scripts/dummy-tools/gcc
@@ -85,8 +85,7 @@ if arg_contain -S "$@"; then
 	fi
 
 	# For arch/powerpc/tools/gcc-check-mprofile-kernel.sh
-	if arg_contain -m64 "$@" && arg_contain -mlittle-endian "$@" &&
-		arg_contain -mprofile-kernel "$@"; then
+	if arg_contain -m64 "$@" && arg_contain -mprofile-kernel "$@"; then
 		if ! test -t 0 && ! grep -q notrace; then
 			echo "_mcount"
 		fi
-- 
2.40.1



