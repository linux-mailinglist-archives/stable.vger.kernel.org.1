Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB5F6FA698
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbjEHKWL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbjEHKVf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:21:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36FA26440
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:20:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92CEE62537
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9099AC433D2;
        Mon,  8 May 2023 10:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541252;
        bh=8ezcZl5m/cEkzzWdEWK78JGEzBcRyHLWDItMhISB3kQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lcZv9xm1KL2PgZhio7st209jxdnp00iiCDADhL5/9wYyGUSsfaf95R5SY/508/l1I
         lWLMEvx+u+q2oyjb1yfq/7bQqLxWzv9n1mgonMF4yFJTOTOHbqpTM+2kiLrbKBuy8Q
         cysqvrzNGPAoXMzPsVtw8xKWMYOJQD0kaomTh4aI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 6.2 054/663] fs: fix sysctls.c built
Date:   Mon,  8 May 2023 11:38:00 +0200
Message-Id: <20230508094430.245365552@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kefeng Wang <wangkefeng.wang@huawei.com>

commit e3184de9d46c2eebdb776face2e2662c6733331d upstream.

'obj-$(CONFIG_SYSCTL) += sysctls.o' must be moved after "obj-y :=",
or it won't be built as it is overwrited.

Note that there is nothing that is going to break by linking
sysctl.o later, we were just being way to cautious and patches
have been updated to reflect these considerations and sent for
stable as well with the whole "base" stuff needing to be linked
prior to child sysctl tables that use that directory. All of
the kernel sysctl APIs always share the same directory, and races
against using it should end up re-using the same single created
directory.

And so something we can do eventually is do away with all the base stuff.
For now it's fine, it's not creating an issue. It is just a bit pedantic
and careful.

Fixes: ab171b952c6e ("fs: move namespace sysctls and declare fs base directory")
Cc: stable@vger.kernel.org # v5.17
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
[mcgrof: enhanced commit log for stable criteria and clarify base stuff ]
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/Makefile |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/Makefile
+++ b/fs/Makefile
@@ -6,7 +6,6 @@
 # Rewritten to use lists instead of if-statements.
 # 
 
-obj-$(CONFIG_SYSCTL)		+= sysctls.o
 
 obj-y :=	open.o read_write.o file_table.o super.o \
 		char_dev.o stat.o exec.o pipe.o namei.o fcntl.o \
@@ -49,7 +48,7 @@ obj-$(CONFIG_FS_MBCACHE)	+= mbcache.o
 obj-$(CONFIG_FS_POSIX_ACL)	+= posix_acl.o
 obj-$(CONFIG_NFS_COMMON)	+= nfs_common/
 obj-$(CONFIG_COREDUMP)		+= coredump.o
-obj-$(CONFIG_SYSCTL)		+= drop_caches.o
+obj-$(CONFIG_SYSCTL)		+= drop_caches.o sysctls.o
 
 obj-$(CONFIG_FHANDLE)		+= fhandle.o
 obj-y				+= iomap/


