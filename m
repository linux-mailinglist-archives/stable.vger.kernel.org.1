Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653F47462E2
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 20:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjGCSzj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 14:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjGCSzi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 14:55:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E049C1731
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 11:55:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75D5961013
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 18:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C8EC433C7;
        Mon,  3 Jul 2023 18:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688410523;
        bh=P1P6YAKwY/2BwVAwn4BOgA7lvmhP4ZY7h5VEz0L2o4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t8yAF8f1yrLkDsiQzmcsGX3htwJ94zefAUCp80yEuKmjWqpGEsuI5Yfsa252B8vRk
         wP63kX6NFOxbLbRnhVK8CGRh2GQeZ4I9cJBtmuy5mmE+IuIJvMfYqp0eqKyRKKGWms
         73y/tmpNM3XhJXOO3lXdNU3AxkRPEEX6hkRyIlsc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Ahmed S. Darwish" <darwi@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 6.4 10/13] scripts/tags.sh: Resolve gtags empty index generation
Date:   Mon,  3 Jul 2023 20:54:11 +0200
Message-ID: <20230703184519.573568535@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703184519.261119397@linuxfoundation.org>
References: <20230703184519.261119397@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ahmed S. Darwish <darwi@linutronix.de>

commit e1b37563caffc410bb4b55f153ccb14dede66815 upstream.

gtags considers any file outside of its current working directory
"outside the source tree" and refuses to index it. For O= kernel builds,
or when "make" is invoked from a directory other then the kernel source
tree, gtags ignores the entire kernel source and generates an empty
index.

Force-set gtags current working directory to the kernel source tree.

Due to commit 9da0763bdd82 ("kbuild: Use relative path when building in
a subdir of the source tree"), if the kernel build is done in a
sub-directory of the kernel source tree, the kernel Makefile will set
the kernel's $srctree to ".." for shorter compile-time and run-time
warnings. Consequently, the list of files to be indexed will be in the
"../*" form, rendering all such paths invalid once gtags switches to the
kernel source tree as its current working directory.

If gtags indexing is requested and the build directory is not the kernel
source tree, index all files in absolute-path form.

Note, indexing in absolute-path form will not affect the generated
index, as paths in gtags indices are always relative to the gtags "root
directory" anyway (as evidenced by "gtags --dump").

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/tags.sh |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -32,6 +32,13 @@ else
 	tree=${srctree}/
 fi
 
+# gtags(1) refuses to index any file outside of its current working dir.
+# If gtags indexing is requested and the build output directory is not
+# the kernel source tree, index all files in absolute-path form.
+if [[ "$1" == "gtags" && -n "${tree}" ]]; then
+	tree=$(realpath "$tree")/
+fi
+
 # Detect if ALLSOURCE_ARCHS is set. If not, we assume SRCARCH
 if [ "${ALLSOURCE_ARCHS}" = "" ]; then
 	ALLSOURCE_ARCHS=${SRCARCH}
@@ -131,7 +138,7 @@ docscope()
 
 dogtags()
 {
-	all_target_sources | gtags -i -f -
+	all_target_sources | gtags -i -C "${tree:-.}" -f - "$PWD"
 }
 
 # Basic regular expressions with an optional /kind-spec/ for ctags and


