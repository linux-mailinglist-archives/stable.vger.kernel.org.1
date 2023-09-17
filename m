Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197CF7A3AA6
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239564AbjIQUG7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240456AbjIQUGo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:06:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685DE97
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:06:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F71C433C7;
        Sun, 17 Sep 2023 20:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981199;
        bh=dLuQlRInJK+YRELW2Uf3eIp76RyqlKUDWoi3TGwr9xM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0YwGetfnuRqkJP9Di+wH1BEpOYMqVdjAJUUL6cB8HG/O6+n+CLVn+S+uCVozJ4Uf/
         bHR6MrpaYKieNp8ZvOWBUt6H/eVjtMs1R+ZjdaoFC6VK0Yaq1cP3uc8FTZeNqX3h+H
         UpsJXRZ3iJ6DSYSUrSd56MyHX9JOdcXap7Zv8Dis=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 056/219] kbuild: rpm-pkg: define _arch conditionally
Date:   Sun, 17 Sep 2023 21:13:03 +0200
Message-ID: <20230917191043.038880642@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit 233046a2afd12a4f699305b92ee634eebf1e4f31 ]

Commit 3089b2be0cce ("kbuild: rpm-pkg: fix build error when _arch is
undefined") does not work as intended; _arch is always defined as
$UTS_MACHINE.

The intention was to define _arch to $UTS_MACHINE only when it is not
defined.

Fixes: 3089b2be0cce ("kbuild: rpm-pkg: fix build error when _arch is undefined")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/package/mkspec | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index 70392fd2fd29c..f892cf8e37f03 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -51,7 +51,7 @@ $S	Source: kernel-$__KERNELRELEASE.tar.gz
 	Provides: $PROVIDES
 	# $UTS_MACHINE as a fallback of _arch in case
 	# /usr/lib/rpm/platform/*/macros was not included.
-	%define _arch %{?_arch:$UTS_MACHINE}
+	%{!?_arch: %define _arch $UTS_MACHINE}
 	%define __spec_install_post /usr/lib/rpm/brp-compress || :
 	%define debug_package %{nil}
 
-- 
2.40.1



