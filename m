Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0137614F9
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbjGYLYZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbjGYLYW (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:24:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4F31BD1
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:24:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C43D61600
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:24:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D273C433C8;
        Tue, 25 Jul 2023 11:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284257;
        bh=NUOwHOtiZLKlkVZLFaYQ97k5Qe7FbI07YlCrhd9ol4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y8RdXI5WFcDOtQzeh318bupSc6S4xjxYeWf+81mMM0SR3RyHKQ6Nmw684GI9HUBc6
         Qim5uyoVvvH8Rwolp3JIAeEu8dPaQIFJLUeo9mGjjA4CoYknOo9wwFAnkJ3uMtT7LO
         7SmG/vkPF5dTuS50IUSDMnY8KUWXvY6h7NkYvSw4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5.10 292/509] autofs: use flexible array in ioctl structure
Date:   Tue, 25 Jul 2023 12:43:51 +0200
Message-ID: <20230725104607.109897284@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

commit e910c8e3aa02dc456e2f4c32cb479523c326b534 upstream.

Commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3") introduced a warning
for the autofs_dev_ioctl structure:

In function 'check_name',
    inlined from 'validate_dev_ioctl' at fs/autofs/dev-ioctl.c:131:9,
    inlined from '_autofs_dev_ioctl' at fs/autofs/dev-ioctl.c:624:8:
fs/autofs/dev-ioctl.c:33:14: error: 'strchr' reading 1 or more bytes from a region of size 0 [-Werror=stringop-overread]
   33 |         if (!strchr(name, '/'))
      |              ^~~~~~~~~~~~~~~~~
In file included from include/linux/auto_dev-ioctl.h:10,
                 from fs/autofs/autofs_i.h:10,
                 from fs/autofs/dev-ioctl.c:14:
include/uapi/linux/auto_dev-ioctl.h: In function '_autofs_dev_ioctl':
include/uapi/linux/auto_dev-ioctl.h:112:14: note: source object 'path' of size 0
  112 |         char path[0];
      |              ^~~~

This is easily fixed by changing the gnu 0-length array into a c99
flexible array. Since this is a uapi structure, we have to be careful
about possible regressions but this one should be fine as they are
equivalent here. While it would break building with ancient gcc versions
that predate c99, it helps building with --std=c99 and -Wpedantic builds
in user space, as well as non-gnu compilers. This means we probably
also want it fixed in stable kernels.

Cc: stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230523081944.581710-1-arnd@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/filesystems/autofs-mount-control.rst |    2 +-
 Documentation/filesystems/autofs.rst               |    2 +-
 include/uapi/linux/auto_dev-ioctl.h                |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- a/Documentation/filesystems/autofs-mount-control.rst
+++ b/Documentation/filesystems/autofs-mount-control.rst
@@ -196,7 +196,7 @@ information and return operation results
 		    struct args_ismountpoint	ismountpoint;
 	    };
 
-	    char path[0];
+	    char path[];
     };
 
 The ioctlfd field is a mount point file descriptor of an autofs mount
--- a/Documentation/filesystems/autofs.rst
+++ b/Documentation/filesystems/autofs.rst
@@ -467,7 +467,7 @@ Each ioctl is passed a pointer to an `au
 			struct args_ismountpoint	ismountpoint;
 		};
 
-                char path[0];
+                char path[];
         };
 
 For the **OPEN_MOUNT** and **IS_MOUNTPOINT** commands, the target
--- a/include/uapi/linux/auto_dev-ioctl.h
+++ b/include/uapi/linux/auto_dev-ioctl.h
@@ -109,7 +109,7 @@ struct autofs_dev_ioctl {
 		struct args_ismountpoint	ismountpoint;
 	};
 
-	char path[0];
+	char path[];
 };
 
 static inline void init_autofs_dev_ioctl(struct autofs_dev_ioctl *in)


